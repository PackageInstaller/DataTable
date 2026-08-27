local UINCSTSkill = class("UINCSTSkill", UIBaseNode)
local base = UIBaseNode
local UINCSTSkillActiveItem = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkillActiveItem")
local UINCSTSkillOverrideItem = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkillOverrideItem")

function UINCSTSkill:ctor(sctMain)
  self.sctMain = sctMain
end

function UINCSTSkill:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_CancelSelect, self, self._OnClickCancelSelect)
  self._clickSkillFunc = BindCallback(self, self._OnClickSkillItem)
  self.ui.btn_CancelSelect.enabled = false
  self.ui.skillRootItem:SetActive(false)
  self.skillActiveItemPool = UIItemPool.New(UINCSTSkillActiveItem, self.ui.skillRootItem)
  self.skillActiveItemList = {}
  self.overrideSkillItemList = {}
  self.skillActiveItemDic = {}
  for i = 1, 3 do
    local skillItem = self.skillActiveItemPool:GetOne()
    table.insert(self.skillActiveItemList, skillItem)
  end
  for k, go in ipairs(self.ui.overrideSkillGoList) do
    local item = UINCSTSkillOverrideItem.New()
    item:Init(go)
    table.insert(self.overrideSkillItemList, item)
  end
end

function UINCSTSkill:InitUINCSTSkill(treeData, resLoader)
  self.treeData = treeData
  self.resLoader = resLoader
  self:_OnClickCancelSelect()
  self:UpdateUINCSTSkillAll()
  self:_PlayInitAnim()
end

function UINCSTSkill:_PlayInitAnim()
  for slotId, skillItemList in pairs(self.overrideSkillItemSlotDic) do
    for k, skillItem in ipairs(skillItemList) do
      skillItem:ResetCSTSkillOverrideItemAnim()
    end
    self:PlayCSTSkillSlotAnim(slotId)
  end
end

function UINCSTSkill:PlayCSTSkillSlotAnim(slotId)
  local skillItemList = self.overrideSkillItemSlotDic[slotId]
  local isMiddle = true
  for k, skillItem in ipairs(skillItemList) do
    if skillItem.isEquip then
      isMiddle = false
      break
    end
  end
  local equipOvSkillIndex
  for k, skillItem in ipairs(skillItemList) do
    skillItem:PlayCSTSkillOverrideItemAnim(isMiddle)
    if skillItem.isEquip then
      equipOvSkillIndex = k
    end
  end
end

function UINCSTSkill:_OnClickSkillItem(cmdSkillData, skillItem)
  if self.lastSelectSkillItem == skillItem then
    return
  end
  if self.lastSelectSkillItem ~= nil then
    self.lastSelectSkillItem:SetCSTSkillItemSelect(false)
  end
  skillItem:SetCSTSkillItemSelect(true)
  self.lastSelectSkillItem = skillItem
  self.sctMain:ShowCSTSkillDetail(cmdSkillData)
  self.ui.btn_CancelSelect.enabled = true
end

function UINCSTSkill:_OnClickCancelSelect()
  if self.lastSelectSkillItem == nil then
    return
  end
  self.lastSelectSkillItem:SetCSTSkillItemSelect(false)
  self.lastSelectSkillItem = nil
  self.sctMain:HideCSTSkillDetail()
  self.ui.btn_CancelSelect.enabled = false
end

function UINCSTSkill:CSTSkillCancelSelect()
  self:_OnClickCancelSelect()
end

function UINCSTSkill:UpdateUINCSTSkillAll()
  local treeData = self.treeData
  for slotIndex, skillItem in ipairs(self.skillActiveItemList) do
    local skillData = treeData:GetCSTCurSkillDataBySlot(slotIndex)
    if skillData == nil then
      skillData = treeData:GetCSTDafaultSkillDataBySlot(slotIndex)
    end
    local skillId = skillData:GetCSTSkillRealSkilllId()
    skillItem:InitCSTSkillActiveItem(skillData, self.resLoader, self._clickSkillFunc)
    self.skillActiveItemDic[skillId] = skillItem
  end
  local overloadSkillDic = treeData:GetCSTOverloadSkillDic()
  self.overrideSkillItemSlotDic = {}
  local index = 1
  for slotIndex, skillDataList in ipairs(overloadSkillDic) do
    self.overrideSkillItemSlotDic[slotIndex] = {}
    local curSkillData = treeData:GetCSTCurSkillDataBySlot(slotIndex)
    if curSkillData == nil then
      curSkillData = treeData:GetCSTDafaultSkillDataBySlot(slotIndex)
    end
    local curSkillId = curSkillData:GetCSTSkillRealSkilllId()
    local isCurDefault = curSkillData:GetCSTSId() == ConfigData.commander_skill_unlock.slotDefaultSkillIdDic[treeData:GetCSTTreeId()][slotIndex]
    for _, skillData in ipairs(skillDataList) do
      local skillItem = self.overrideSkillItemList[index]
      local skillId = skillData:GetCSTSkillRealSkilllId()
      local fairyRepalceSkillData = treeData:GetCSTFairyReplaceSkillDataByRealSkillId(skillId)
      skillItem:Show()
      skillItem:InitCSTSkillOverrideItem(skillData, self.resLoader, self._clickSkillFunc, curSkillId, fairyRepalceSkillData, treeData)
      skillItem:ShowRedDotCSTSkillItem(isCurDefault and skillData:IsCmdSkillUnlock())
      table.insert(self.overrideSkillItemSlotDic[slotIndex], skillItem)
      index = index + 1
    end
  end
end

function UINCSTSkill:OnDelete()
  self.skillActiveItemPool:DeleteAll()
  for k, item in ipairs(self.overrideSkillItemList) do
    item:Delete()
  end
  base.OnDelete(self)
end

return UINCSTSkill
