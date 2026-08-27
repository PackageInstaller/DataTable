local UINCSTLevelUp = class("UINCSTLevelUp", UIBaseNode)
local base = UIBaseNode
local UINAthMatUpItem = require("Game.Arithmetic.AthList.Area.MatUpgrade.UINAthMatUpItem")
local UINCSTLvUpSkillUnlockList = require("Game.CommanderSkill.UI.LevelUpNode.UINCSTLvUpSkillUnlockList")
local UINTweenUtil = require("Game.CommonUI.Tween.UINTweenUtil")

function UINCSTLevelUp:ctor(cstMainRoot)
  self.cstMainRoot = cstMainRoot
end

function UINCSTLevelUp:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Clear, self, self._OnClickClear)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  self.ui.uINUpgradeItem:SetActive(false)
  self.expItemPool = UIItemPool.New(UINAthMatUpItem, self.ui.uINUpgradeItem)
  self.__OnItemChange = BindCallback(self, self._OnItemChange)
  self.levelCfg = ConfigData.commander_skill_level
  self.maxLevel = #self.levelCfg
  self.upgradeBtnDefaultColor = self.ui.img_Upgrade.color
  self.skillUnlockList = UINCSTLvUpSkillUnlockList.New()
  self.skillUnlockList:Init(self.ui.scrollRect)
end

function UINCSTLevelUp:InitCSTLevelUp(cmdSkillCtrl, treeData, resLoader)
  UIUtil.HideTopStatus()
  AudioManager:PlayAudioById(1067)
  self.cmdSkillCtrl = cmdSkillCtrl
  self.expItemNums = {}
  self.newLevel = nil
  self.treeData = treeData
  self.resLoader = resLoader
  self.curExp = treeData.curExp
  self:_RefreshIsFullLvUI()
  self.isInit = true
  self:_RefreshLvUpItems()
  self:_CalAndRefreshExpBar()
  self:_Clear()
  self.isInit = false
end

function UINCSTLevelUp:_OnItemChange()
  self:_KillLvUpSeq(true)
  self:_RefreshLvUpItems()
  self:_CalAndRefreshExpBar()
end

function UINCSTLevelUp:_RefreshLvUpItems()
  self.expItemPool:HideAll()
  for _, id in ipairs(ConfigData.item.growUpIds[eItemActionType.CommanderSkillExp]) do
    if PlayerDataCenter.itemDic[id] ~= nil then
      local itemData = PlayerDataCenter.itemDic[id]
      local item = self.expItemPool:GetOne()
      item.gameObject.name = tostring(id)
      item:InitExpItem(itemData, function(num)
        self.expItemNums[itemData] = num
        self:_CalAndRefreshExpBar()
      end)
    else
      local item = self.expItemPool:GetOne()
      item:InitEmptyExpItem(id)
    end
  end
end

function UINCSTLevelUp:_CalAndRefreshExpBar()
  local level = self.treeData.level or 1
  local curExp = self.curExp or 0
  local addExp = self:_CalAddExp() or 0
  local maxAddExp = -curExp
  for i = level, self.maxLevel - 1 do
    maxAddExp = maxAddExp + self.levelCfg[i].exp
  end
  self:_SetAddExpLimt(maxAddExp, addExp)
  self.ui.tex_AddExp:SetIndex(0, tostring(addExp))
  if maxAddExp == 0 or addExp >= maxAddExp then
    if not self._waitLvUpTween then
      self.ui.img_Bar.fillAmount = 1
      self:_UpdateLevel(self.maxLevel)
    end
    self.ui.tex_Exp:SetIndex(1)
    self.ui.tex_Exp.gameObject:SetActive(false)
    self.ui.btn_Upgrade.interactable = 0 < addExp
    self:_RefreshConfirmBtnState(0 < addExp)
    return
  end
end

function UINCSTLevelUp:_CalAddExp()
  local totalExp = 0
  for itemData, num in pairs(self.expItemNums) do
    totalExp = totalExp + itemData:GetActionArg(1) * num
  end
  return totalExp
end

function UINCSTLevelUp:_SetAddExpLimt(maxAddExp, addExp)
  for _, item in ipairs(self.expItemPool.listItem) do
    item:SetAddExpLimt(maxAddExp, addExp)
  end
end

function UINCSTLevelUp:_UpdateLevel(newlevel)
  local curLevel = self.treeData.level
  if 9 < curLevel then
    self.ui.tex_CurLevel:SetIndex(1, tostring(curLevel))
  else
    self.ui.tex_CurLevel:SetIndex(0, tostring(curLevel))
  end
  local isMaxLevel = curLevel == self.maxLevel
  self.ui.tex_NextLevel.gameObject:SetActive(not isMaxLevel)
  self.ui.obj_Arrow:SetActive(not isMaxLevel)
  if isMaxLevel then
    return
  end
  if 9 < newlevel then
    self.ui.tex_NextLevel:SetIndex(1, tostring(newlevel))
  else
    self.ui.tex_NextLevel:SetIndex(0, tostring(newlevel))
  end
  self:_RefreshUnlockSkill(newlevel)
end

function UINCSTLevelUp:_RefreshConfirmBtnState(canUp)
  self.ui.btn_Upgrade.interactable = canUp
  self.ui.img_Upgrade.color = canUp and self.upgradeBtnDefaultColor or Color.gray
end

function UINCSTLevelUp:_Clear()
  self.newLevel = nil
  for _, item in ipairs(self.expItemPool.listItem) do
    item:CleanAll()
  end
  self.expItemNums = {}
end

function UINCSTLevelUp:_RefreshUnlockSkill(newLevel)
  if self.newLevel == newLevel then
    return
  end
  self.newLevel = newLevel
  local unlockSkillList = {}
  local levelSkillCfg = ConfigData.commander_skill_unlock.treeLevelSkillCfg[self.treeData.treeId]
  for treelevel = self.treeData.level + 1, self.maxLevel do
    local skillDic = levelSkillCfg[treelevel]
    if skillDic ~= nil then
      for skillId, skillLevel in pairs(skillDic) do
        local skillData = self.treeData.commanderSkillDataDic[skillId]
        if skillData.type == skillData.skillType.active or skillData.type == skillData.skillType.passive then
          table.insert(unlockSkillList, {
            skillId = skillId,
            skillLevel = skillLevel,
            treeLevel = treelevel
          })
        end
      end
    end
  end
  table.sort(unlockSkillList, function(a, b)
    if a.treeLevel == b.treeLevel then
      return a.skillId < b.skillId
    else
      return a.treeLevel < b.treeLevel
    end
  end)
  self.skillUnlockList:InitCSTLvUpSkillUnlockList(self.resLoader, unlockSkillList, newLevel, self.treeData, self.isInit)
end

function UINCSTLevelUp:_PopUnlockSkillMessageTip(skillDataList)
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(window)
    if window == nil then
      return
    end
    for _, data in ipairs(skillDataList) do
      local msg
      if data.level == 1 then
        msg = ConfigData:GetTipContent(TipContent.CST_unlockTip)
        msg = string.format(msg, data.battleSkillCfg.Name)
      else
        msg = ConfigData:GetTipContent(TipContent.CST_unlockTipLevel)
        msg = string.format(msg, data.battleSkillCfg.Name, data.level - 1)
      end
      window:ShowTips(msg)
    end
  end)
end

function UINCSTLevelUp:_LevelSkillData(startLevel, endLevel)
  local skillDatas = {}
  for i = startLevel + 1, endLevel do
    local treeLevelSkillCfg = ConfigData.commander_skill_unlock.treeLevelSkillCfg[self.treeData.treeId]
    if treeLevelSkillCfg ~= nil and treeLevelSkillCfg[i] ~= nil then
      for skillId, _ in pairs(treeLevelSkillCfg[i]) do
        local skillData = self.treeData.commanderSkillDataDic[skillId]
        if skillData.type ~= skillData.skillType.master then
          table.insert(skillDatas, skillData)
        end
      end
    end
  end
  return skillDatas
end

function UINCSTLevelUp:_OnClickClear()
  AudioManager:PlayAudioById(1053)
  self:_Clear()
end

function UINCSTLevelUp:_OnClickClose()
  UIUtil.ReShowTopStatus()
  self:Hide()
  self:_KillLvUpSeq(true)
  AudioManager:PlayAudioById(1068)
end

function UINCSTLevelUp:OnShow()
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemChange)
end

function UINCSTLevelUp:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemChange)
end

function UINCSTLevelUp:_RefreshIsFullLvUI()
  local isFullLv = self:_IsFullLv()
  self.ui.obj_normal:SetActive(not isFullLv)
  self.ui.obj_fullLevel:SetActive(isFullLv)
end

function UINCSTLevelUp:_IsFullLv()
  return (self.treeData.level or 1) >= self.maxLevel
end

function UINCSTLevelUp:OnDelete()
  self.expItemPool:DeleteAll()
  self.skillUnlockList:Delete()
  self:_KillLvUpSeq(false)
  base.OnDelete(self)
end

return UINCSTLevelUp
