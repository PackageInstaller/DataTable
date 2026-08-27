local UINPlayerSkillNode = class("UINPlayerSkillNode", UIBaseNode)
local base = UIBaseNode
local UINPlayerSkillItem = require("Game.Battle.UI.SkillModule.PlayerSkill.UINPlayerSkillItem")
local UINPlayerConsumeSkillItem = require("Game.Battle.UI.SkillModule.PlayerSkill.UINPlayerConsumeSkillItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_DoTween = CS.DG.Tweening.DOTween

function UINPlayerSkillNode:ctor(resloader)
  self.resloader = resloader
end

function UINPlayerSkillNode:OnInit()
  self.playerMaxMp = 0
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:__TranslateUIPos()
  self.__OnItemClick = BindCallback(self, self.OnPlayerSkillItemClick)
  self.__OnItemPointDown = BindCallback(self, self.OnPlayerSkillItemPointDown)
  self.__ShowSkillInfo = BindCallback(self, self.ShowSkillInfo)
  self.__HideSkillInfo = BindCallback(self, self.HideSkillInfo)
  self.ui.skillItem:SetActive(false)
  self.skillItemPool = UIItemPool.New(UINPlayerSkillItem, self.ui.skillItem)
  self.ui.consumeSkillItem:SetActive(false)
  self.consumeSkillItemPool = UIItemPool.New(UINPlayerConsumeSkillItem, self.ui.consumeSkillItem)
  self.ui.tex_engShow.text = ""
end

function UINPlayerSkillNode:__TranslateUIPos()
  if not BattleUtil.IsInTDBattle() then
    return
  end
  self.ui.normalTrans:SetAnchoredPosition(self.ui.tdOffset.x, self.ui.normalTrans.anchoredPosition.y)
end

function UINPlayerSkillNode:InitPlayerSkillNode(battlePlayerController, skillList)
  if skillList == nil or skillList.Count <= 0 then
    self.__hasNoSkill = true
    return
  end
  self._csSkillList = skillList
  self.playerCtrl = battlePlayerController
  local curMp = battlePlayerController.CurMp
  self.skillItemPool:HideAll()
  self.consumeSkillItemPool:HideAll()
  self.__lastConsumeSkillCount = -1
  local dynplayer = BattleUtil.GetCurDynPlayer()
  local CSTId
  if dynplayer ~= nil then
    CSTId = dynplayer:GetCSTId()
  end
  local curSkillList, consumeSkillList = self:SortSkillList(CSTId, skillList)
  if curSkillList == nil then
    return
  end
  for i = 1, #curSkillList do
    local battleSkill = curSkillList[i]
    local skillItem = self.skillItemPool:GetOne()
    skillItem.gameObject.name = tostring(i)
    skillItem:InitPlayerSkillItem(battleSkill, self.resloader, self.__OnItemClick, self.__ShowSkillInfo, self.__HideSkillInfo, self.__OnItemPointDown)
    if dynplayer then
      local isLocked = dynplayer:IsEpBattleSkillLock(i)
      skillItem:SetSkillItemLock(isLocked)
    end
    skillItem:RefreshPlayerSkillItemMp(curMp, curMp >= self.playerMaxMp)
  end
  for k, battleSkill in ipairs(consumeSkillList) do
    local skillItem = self.consumeSkillItemPool:GetOne()
    skillItem:InitPlayerConsumeSkillItem(battleSkill, self.__OnItemClick, self.__ShowSkillInfo, self.__HideSkillInfo, self.__OnItemPointDown)
  end
end

function UINPlayerSkillNode:SortSkillList(CSTId, skillList)
  local function sortFixSkillFunc(skills)
    local isFix, fixSkills, fixSkillPosDic = BattleUtil.TryGetFixedCstSkills()
    
    if not isFix then
      return skills
    end
    if #skills ~= #fixSkills then
      error("在固定指挥官技能关卡中，接受到的指挥官技能数量与配置数量不同")
      return skills
    end
    local templist = skills
    skills = {}
    for _, battleSkill in ipairs(templist) do
      local pos = fixSkillPosDic[battleSkill.dataId]
      if pos ~= nil then
        skills[pos] = battleSkill
      else
        table.insert(skills, battleSkill)
        error("在固定指挥官技能关卡中，存在一个技能不是已配置的技能  id:" .. tostring(battleSkill.dataId))
      end
    end
    return skills
  end
  
  if skillList == nil or skillList.Count <= 0 then
    return nil
  end
  local curSkillList = {}
  local consumeSkillList = {}
  for i = 0, skillList.Count - 1 do
    local battleSkill = skillList[i]
    if battleSkill.skillType == eBattleSkillLogicType.ChipConsume then
      table.insert(consumeSkillList, battleSkill)
    else
      table.insert(curSkillList, battleSkill)
    end
  end
  table.sort(consumeSkillList, function(a, b)
    return a.dataId < b.dataId
  end)
  if CSTId == nil then
    return sortFixSkillFunc(curSkillList), consumeSkillList
  end
  local cstunlock = ConfigData.commander_skill_unlock[CSTId]
  if cstunlock == nil then
    error("Config is nil： commander_skill_unlock，key is " .. tostring(CSTId))
    return sortFixSkillFunc(curSkillList), consumeSkillList
  end
  local skillId2CSTIdDic = ConfigData.commander_skill_unlock.realSkillId2CSTSIdDic
  table.sort(curSkillList, function(a, b)
    local CSTSkillIdA = skillId2CSTIdDic[a.dataId]
    local cmdSkillDataA = cstunlock[CSTSkillIdA]
    if cmdSkillDataA == nil then
      return false
    end
    local CSTSkillIdB = skillId2CSTIdDic[b.dataId]
    local cmdSkillDataB = cstunlock[CSTSkillIdB]
    if cmdSkillDataB == nil then
      return false
    end
    return cmdSkillDataA.place < cmdSkillDataB.place
  end)
  return sortFixSkillFunc(curSkillList), consumeSkillList
end

function UINPlayerSkillNode:OnPlayerMpChange(mp)
  self.ui.tex_Energy:SetIndex(0, tostring(mp), tostring(self.playerMaxMp))
  self.ui.tex_engShow.text = tostring(mp) .. "/" .. tostring(self.playerMaxMp)
  if self._mp ~= mp and mp < self.playerMaxMp then
    if 0 < self.playerMaxMp then
      if self.mpSeq ~= nil then
        self.mpSeq:Restart()
      else
        local seq = cs_DoTween.Sequence()
        seq:OnStart(function()
          self.ui.img_Energy.fillAmount = 0
          self.ui.tex_engShow.transform.localScale = Vector3.one
          self.ui.tex_engShow.color = Color.New(1, 1, 1, 1)
        end)
        seq:Append(self.ui.img_Energy:DOFillAmount(1, 1))
        seq:Join(self.ui.tex_engShow.transform:DOScale(Vector3.New(1.2, 1.2, 1), 0.5))
        seq:Join(self.ui.tex_engShow:DOFade(0, 0.5))
        seq:SetAutoKill(false)
        self.mpSeq = seq
      end
    else
      self.ui.img_Energy.fillAmount = 1
    end
    self._mp = mp
  end
  self.isMax = mp >= self.playerMaxMp
  for k, skillItem in ipairs(self.skillItemPool.listItem) do
    skillItem:RefreshPlayerSkillItemMp(mp, self.isMax)
  end
end

function UINPlayerSkillNode:OnPlayerMaxMpChange(maxMp)
  self.playerMaxMp = maxMp
end

function UINPlayerSkillNode:OnPlayerSkillItemClick(battleSkill)
  if battleSkill.isPassive then
    return
  end
  local skillModuleWin = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if skillModuleWin ~= nil then
    skillModuleWin:SetSelectSkillType(false)
  end
  self.playerCtrl:OnSkillItemMonoCliked(battleSkill, false)
end

function UINPlayerSkillNode:OnPlayerSkillItemPointDown(battleSkill)
  if battleSkill.isPassive or not battleSkill.isManualMode then
    return
  end
  local skillModuleWin = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if skillModuleWin ~= nil then
    skillModuleWin:SetSelectSkillType(false)
  end
  self.playerCtrl:OnSkillItemMonoCliked(battleSkill, false)
end

function UINPlayerSkillNode:ShowSkillInfo(item, battleSkill)
  if battleSkill.totalCDTime == 0 and not battleSkill.isManualMode and not battleSkill.isPassive then
    self:OnPlayerSkillItemClick(battleSkill)
    return
  end
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local describe = battleSkill:GetBattleSkillDescribe()
  win:SetTitleAndContext(battleSkill.name, describe)
  win:FloatTo(item.transform, HAType.autoCenter, VAType.up)
end

function UINPlayerSkillNode:HideSkillInfo()
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

function UINPlayerSkillNode:OnUpdateLogic_PlayerSkillNode()
  for k, skillItem in ipairs(self.skillItemPool.listItem) do
    skillItem:OnUpdateLogic_PlayerSkillItem()
  end
  local consumeSkillNum = 0
  for k, skillItem in ipairs(self.consumeSkillItemPool.listItem) do
    skillItem:OnUpdateLogic_PlayerConsumeSkillItem()
    if skillItem.active then
      consumeSkillNum = consumeSkillNum + 1
    end
  end
  if self.__lastConsumeSkillCount ~= consumeSkillNum then
    self.__lastConsumeSkillCount = consumeSkillNum
    self.ui.tex_ConsumeCount.text = tostring(consumeSkillNum) .. "/" .. tostring(BattleUtil.GetConsumeChipLimit())
  end
  self.ui.consumeSkill:SetActive(0 < consumeSkillNum)
end

function UINPlayerSkillNode:SetSkillItemActive(index, active)
  local skillItem = self.skillItemPool.listItem[index]
  if skillItem ~= nil and active ~= nil then
    if active then
      skillItem:Show()
    else
      skillItem:Hide()
    end
  end
  return skillItem
end

function UINPlayerSkillNode:GetSkillItemById(skillId)
  for _, skillItem in pairs(self.skillItemPool.listItem) do
    if skillItem.skillId == skillId then
      return skillItem
    end
  end
  for _, skillItem in pairs(self.consumeSkillItemPool.listItem) do
    if skillItem.skillId == skillId then
      return skillItem
    end
  end
  return nil
end

function UINPlayerSkillNode:GetSkillItem(index)
  local skillItem = self.skillItemPool.listItem[index]
  return skillItem
end

function UINPlayerSkillNode:SetConsumeSkillItemActive(index, active)
  local skillItem = self.consumeSkillItemPool.listItem[index]
  if skillItem ~= nil and active ~= nil then
    if active then
      skillItem:Show()
    else
      skillItem:Hide()
    end
  end
  return skillItem
end

function UINPlayerSkillNode:SetConsumeSkillItemCanUse(skillId, bValue, tipId)
  for k, skillItem in ipairs(self.consumeSkillItemPool.listItem) do
    if skillItem.skillId == skillId then
      skillItem:SetCantUse(bValue, tipId)
      return skillItem
    end
  end
  return nil
end

function UINPlayerSkillNode:OnUpdateRender_PlayerSkillNode(deltaTime, interpolation)
  for k, skillItem in ipairs(self.skillItemPool.listItem) do
    skillItem:OnUpdateRender_PlayerSkillItem(deltaTime, interpolation)
  end
  for k, skillItem in ipairs(self.consumeSkillItemPool.listItem) do
    skillItem:OnUpdateRender_PlayerConsumeSkillItem(deltaTime, interpolation)
  end
end

function UINPlayerSkillNode:IsSkillEmpty()
  return self.__hasNoSkill
end

function UINPlayerSkillNode:GetPlayerSkillUsedTimes()
  local usedTimes = 0
  for i = 0, self._csSkillList.Count - 1 do
    local battleSkill = self._csSkillList[i]
    usedTimes = usedTimes + battleSkill.curUseTime
  end
  return usedTimes
end

function UINPlayerSkillNode:OnDelete()
  self.consumeSkillItemPool:DeleteAll()
  self.skillItemPool:DeleteAll()
  self.playerCtrl = nil
  if self.mpSeq ~= nil then
    self.mpSeq:Kill()
    self.mpSeq = nil
  end
  self.__hasNoSkill = false
  base.OnDelete(self)
end

return UINPlayerSkillNode
