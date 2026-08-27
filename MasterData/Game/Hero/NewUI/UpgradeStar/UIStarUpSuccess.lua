local UIStarUpSuccess = class("UIStarUpSuccess", UIBaseWindow)
local base = UIBaseWindow
local UINStarUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local cs_ResLoader = CS.ResLoader
local cs_tweening = CS.DG.Tweening
local nodeDataList = {
  [1] = {key = false, height = 122.47},
  [2] = {key = false, height = 308.8929},
  [3] = {key = false, height = 260},
  [4] = {key = false, height = 216}
}

function UIStarUpSuccess:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnClickBack)
  self.StarList = {}
  table.insert(self.StarList, self.ui.img_Star)
  self.attrItemPool = UIItemPool.New(UINStarUpAttrItem, self.ui.attriItem)
  self.ui.attriItem:SetActive(false)
  self.resloader = cs_ResLoader.Create()
end

function UIStarUpSuccess:InitStarUpSuccess(starupDataDiff)
  AudioManager:PlayAudioById(1109)
  self.ui.parSys_success:Play()
  self.heroData = PlayerDataCenter:GetHeroData(starupDataDiff.heroId)
  nodeDataList[1].key = self:RefreshStarNum(starupDataDiff.curRank)
  nodeDataList[2].key = self:RefreshAttrs(starupDataDiff.oldRank, starupDataDiff.curRank)
  nodeDataList[3].key = self:RefreshAthSlot(starupDataDiff.oldAthslotList, starupDataDiff.curAthslotList)
  nodeDataList[4].key = self:RefreshUltimateSkill(starupDataDiff.oldSkillLevelDic, starupDataDiff.skillLevelDic)
  self:__InitTheTween(nodeDataList)
  self.wait4Close = true
  self.ui.btn_background.interactable = false
  self.ui.obj_texContinue:SetActive(false)
  self.timerId = TimerManager:StartTimer(1, function()
    self.timerId = nil
    self.wait4Close = false
    self.ui.btn_background.interactable = true
    self.ui.obj_texContinue:SetActive(true)
  end, self, true, false, false)
end

function UIStarUpSuccess:__InitTheTween(nodeDataList)
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill()
  end
  self.tweenSeq = cs_tweening.DOTween.Sequence()
  local count = 0
  local delay = 0
  for index, data in ipairs(nodeDataList) do
    if data.key then
      count = count + 1
      delay = count == 2 and 0.35 or 0
      self:__SetNodeShowTween(index, data.height, delay)
    end
  end
end

function UIStarUpSuccess:__SetNodeShowTween(index, height, SetDelay)
  local delay = SetDelay or 0
  local fade = self.ui.fadeList[index]
  local layout = self.ui.layoutList[index]
  layout.minHeight = 0
  self.tweenSeq:Append(layout:DOMinSize(Vector2.New(0, height), 0.15, true):SetDelay(delay))
  if index == 1 then
    self.tweenSeq:Join(fade:DOFade(0, 0.1):SetLoops(6, cs_tweening.LoopType.Yoyo))
  else
    fade.alpha = 0
    self.tweenSeq:Join(fade:DOFade(1, 0.15))
  end
end

function UIStarUpSuccess:RefreshStarNum(starNum)
  for _, starGo in ipairs(self.StarList) do
    starGo.gameObject:SetActive(false)
  end
  local count = math.ceil(starNum / 2)
  local isHalf = starNum % 2 == 1
  for i = 1, count do
    if self.StarList[i] ~= nil then
      self.StarList[i].gameObject:SetActive(true)
      self.StarList[i]:SetIndex(0)
    else
      local imgItemInfo = self.ui.img_Star:Instantiate():GetComponent(typeof(CS.UiImageItemInfo))
      table.insert(self.StarList, imgItemInfo)
      imgItemInfo.gameObject:SetActive(true)
    end
  end
  if isHalf then
    self.StarList[count]:SetIndex(1)
  end
  return true
end

function UIStarUpSuccess:RefreshAttrs(oldRank, newRank)
  self.attrItemPool:HideAll()
  local changeList = self.heroData:GetDifferAttrWhenRankUp(newRank, nil, oldRank, nil, nil, nil)
  if 10 <= #changeList then
    for index, data in ipairs(changeList) do
      if 10 < index then
        break
      end
      local item = self.attrItemPool:GetOne()
      item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
    end
  elseif #changeList < 10 then
    local showedIds = {}
    local num = #changeList
    for index, data in ipairs(changeList) do
      table.insert(showedIds, data.attrId)
    end
    for _, attrId in ipairs(ConfigData.attribute.baseAttrIds) do
      if ConfigData.attribute[attrId].merge_attribute == 0 then
        if 10 <= num then
          break
        end
        if not table.contain(showedIds, attrId) then
          num = num + 1
          table.insert(changeList, {
            attrId = attrId,
            property = ConfigData.attribute[attrId].attribute_priority,
            oldAttr = self.heroData:GetAttr(attrId, nil, true),
            newAttr = nil
          })
        end
      end
    end
    table.sort(changeList, function(a, b)
      if a.property == b.property then
        return a.attrId < b.attrId
      else
        return a.property < b.property
      end
    end)
    for index, data in ipairs(changeList) do
      local item = self.attrItemPool:GetOne()
      item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
    end
  end
  return 1 <= #changeList
end

function UIStarUpSuccess:RefreshAthSlot(oldAthslotList, curAthslotList)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm) then
    self.ui.athAreaNode:SetActive(false)
    return false
  end
  local gridUnlockList = ConfigData.game_config.athGridUnlockList
  
  local function GetImageFunc(idx, areaItem)
    local gridId = gridUnlockList[idx]
    local image = areaItem.ui.arry_AthSlot[gridId]
    image.enabled = true
    return image
  end
  
  local totalAddNum = 0
  local increasedAthSlotIndex
  local areaItemList = {}
  table.insert(areaItemList, {
    obj = self.ui.areaItem,
    ui = {}
  })
  for index, curNum in ipairs(curAthslotList) do
    if 1 < index then
      local obj = self.ui.areaItem:Instantiate()
      table.insert(areaItemList, {
        obj = obj,
        ui = {}
      })
    end
    local areaItem = areaItemList[index]
    UIUtil.LuaUIBindingTable(areaItem.obj, areaItem.ui)
    local oldNum = oldAthslotList[index]
    local image
    for i = 1, oldNum do
      image = GetImageFunc(i, areaItem)
      image.color = areaItem.ui.color_unlocked
    end
    for i = oldNum + 1, curNum do
      image = GetImageFunc(i, areaItem)
      image.color = areaItem.ui.color_new
    end
    for i = curNum + 1, 8 do
      image = GetImageFunc(i, areaItem)
      image.color = areaItem.ui.color_locked
    end
    if curNum > oldNum then
      increasedAthSlotIndex = index
      totalAddNum = totalAddNum + curNum - oldNum
    end
  end
  if totalAddNum == 0 then
    self.ui.athAreaNode:SetActive(false)
    return false
  end
  self.ui.athAreaNode:SetActive(true)
  self.ui.tex_AddAreaNum.text = "+" .. tostring(totalAddNum)
  if increasedAthSlotIndex ~= nil then
    local athAreaCfg = ConfigData.ath_area[increasedAthSlotIndex]
    if athAreaCfg == nil then
      error("can't read athAreaCfg with slotId = " .. tostring(increasedAthSlotIndex))
    else
      self.ui.tex_AthAreaName:SetIndex(0, LanguageUtil.GetLocaleText(ConfigData.ath_area[increasedAthSlotIndex].name2))
    end
  end
  return true
end

function UIStarUpSuccess:RefreshUltimateSkill(oldSkillLevelDic, skillLevelDic)
  local diffSkillId, isUnlock
  for skillId, level in pairs(skillLevelDic) do
    if oldSkillLevelDic[skillId] ~= level then
      isUnlock = oldSkillLevelDic[skillId] <= 0
      diffSkillId = skillId
      break
    end
  end
  if diffSkillId == nil then
    self.ui.obj_skillNode:SetActive(false)
    return
  end
  self.ui.obj_skillNode:SetActive(true)
  if self.skillItem == nil then
    self.skillItem = UINBaseSkillItem.New()
    self.skillItem:Init(self.ui.skillItem)
  end
  local targetSkillData
  for _, skillData in ipairs(self.heroData.skillList) do
    if skillData.dataId == diffSkillId then
      targetSkillData = skillData
      break
    end
  end
  if targetSkillData == nil then
    self.ui.obj_skillNode:SetActive(false)
    return
  end
  if targetSkillData:IsUniqueSkill() then
    if isUnlock then
      self.ui.tex_SkillTitle:SetIndex(1)
    else
      self.ui.tex_SkillTitle:SetIndex(0)
    end
    self.ui.tex_Name.text = targetSkillData:GetName() .. " LV." .. tostring(targetSkillData.level)
  else
    if isUnlock then
      self.ui.tex_SkillTitle:SetIndex(3)
    else
      self.ui.tex_SkillTitle:SetIndex(2)
    end
    self.ui.tex_Name.text = targetSkillData:GetName()
  end
  self.skillItem:InitBaseSkillItem(targetSkillData, self.resloader)
  self.ui.tex_Intro.text = targetSkillData:GetCurLevelDescribe()
  return true
end

function UIStarUpSuccess:SetStarUpSuccessCloseCallBack(callback)
  self.__closeCallBack = callback
end

function UIStarUpSuccess:__OnClickBack()
  if self.wait4Close then
    return
  end
  local getHeroWin = UIManager:GetWindow(UIWindowTypeID.GetHero)
  if getHeroWin ~= nil then
    getHeroWin:Delete()
  end
  self:Delete()
end

function UIStarUpSuccess:OnDelete()
  self.ui.parSys_success:Stop()
  TimerManager:StopTimer(self.timerId)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.__closeCallBack ~= nil then
    self.__closeCallBack()
  end
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill()
    self.tweenSeq = nil
  end
  base.OnDelete(self)
end

return UIStarUpSuccess
