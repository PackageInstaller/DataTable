local UINFairySkillUpgradeNode = class("UINFairySkillUpgradeNode", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINFairySkillItem = require("Game.Fairy.UI.UINFairySkillItem")

function UINFairySkillUpgradeNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SkillCheck, self, self.OnClickSkillCheck)
  UIUtil.AddButtonListener(self.ui.btn_icon, self, self.OnClickIconGuide)
  self._checkCanClickCallback = BindCallback(self, self.CheckCanClickItem)
  self._clickSkillItemCallback = BindCallback(self, self.ClickSkillItem)
  self.skillItemPool = UIItemPool.New(UINFairySkillItem, self.ui.uINElfSkillItem, false)
end

function UINFairySkillUpgradeNode:InitNFairySkillUpgradeNode(nowFairyData, resloader)
  self.resloader = resloader
  self.selectFairyData = nil
  self.nowFairyData = nowFairyData
  self.selectFairySkillDataDic = {}
  self.ui.tex_Name:SetIndex(1)
  self:NormalRefreshUpgradeNode()
end

function UINFairySkillUpgradeNode:NormalRefreshUpgradeNode()
  self:GenSkillItemByData()
  self:RefreshSelectTip()
  self:RefreshSelectItem(nil)
end

function UINFairySkillUpgradeNode:SetConsumeFairy(selectFairyData)
  self.selectFairyData = selectFairyData
  self.selectFairySkillDataDic = {}
  self:NormalRefreshUpgradeNode()
end

function UINFairySkillUpgradeNode:RefreshSelectItem(skillData)
  for i, item in pairs(self.skillItemPool.listItem) do
    item:RefreshSelectedByData(skillData)
  end
end

function UINFairySkillUpgradeNode:RefreshSelectTip()
  if not self.selectFairyData then
    self.ui.tex_Num.gameObject:SetActive(false)
    self.ui.img_bottom.color = self.ui.addColor
    if self.nowFairyData:GetIsUpStarState() then
      self.ui.tex_Tip:SetIndex(1)
    else
      self.ui.tex_Tip:SetIndex(2)
    end
  else
    self.ui.tex_Num.gameObject:SetActive(true)
    local nowNum, maxNum = self:GetNowSelectNum()
    self.ui.tex_Tip:SetIndex(0)
    self.ui.tex_Num:SetIndex(0, tostring(nowNum), tostring(maxNum))
    if nowNum == maxNum then
      self.ui.img_bottom.color = self.ui.selectColor
    else
      self.ui.img_bottom.color = self.ui.addColor
    end
  end
end

function UINFairySkillUpgradeNode:GenSkillItemByData()
  self.skillItemPool:HideAll()
  local nowMaxSkillNum = self.nowFairyData:GetMaxSkillNum()
  local ultMaxSkillNum = self.nowFairyData:GetMaxStateSkillNum()
  for i = 1, nowMaxSkillNum do
    local skillItem = self.skillItemPool:GetOne(true)
    skillItem:InitFairySkillItem(self.nowFairyData:GetFairySkillBySlotIndex(i), self.resloader, self._clickSkillItemCallback)
    skillItem:SetCanSelectFunc(self._checkCanClickCallback)
  end
  for i = nowMaxSkillNum + 1, ultMaxSkillNum do
    local skillItem = self.skillItemPool:GetOne(true)
    skillItem:InitFairySkillItemEmpty(true)
  end
  nowMaxSkillNum = self.selectFairyData and self.selectFairyData:GetMaxSkillNum() or 0
  if 0 < nowMaxSkillNum then
    for i = 1, nowMaxSkillNum do
      local skillItem = self.skillItemPool:GetOne(true)
      skillItem:InitFairySkillItem(self.selectFairyData:GetFairySkillBySlotIndex(i), self.resloader, self._clickSkillItemCallback)
      skillItem:SetCanSelectFunc(self._checkCanClickCallback)
    end
  end
  for i = nowMaxSkillNum + 1, ultMaxSkillNum do
    local skillItem = self.skillItemPool:GetOne(true)
    skillItem:InitFairySkillItemEmpty(0 < nowMaxSkillNum)
  end
end

function UINFairySkillUpgradeNode:RefreshExternalInfo(skillData, isSelected, itemCard)
  local mainWin = UIManager:GetWindow(UIWindowTypeID.FairyCultivateMain)
  if mainWin then
    mainWin:RefreshConsumeNum()
    if not isSelected then
      mainWin:OnClickNormalSkillItem(skillData, isSelected, itemCard)
    end
  end
end

function UINFairySkillUpgradeNode:ClickSkillItem(skillData, isSelected, itemCard)
  if isSelected then
    self.selectFairySkillDataDic[skillData.fairySkillId] = nil
  else
    self.selectFairySkillDataDic[skillData.fairySkillId] = skillData
  end
  self:RefreshSelectItem(skillData)
  self:RefreshSelectTip()
  self:RefreshExternalInfo(skillData, isSelected, itemCard)
end

function UINFairySkillUpgradeNode:CheckHaveSameSkill(skillData)
  for id, data in pairs(self.selectFairySkillDataDic) do
    if data:IsSameFairySkill(skillData) then
      return true
    end
  end
  return false
end

function UINFairySkillUpgradeNode:CheckCanClickItem(skillData, isSelected, ignoreTip)
  if isSelected then
    return true
  end
  if not self.selectFairyData then
    if not ignoreTip then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22002))
    end
    return false
  end
  local poolId = skillData:GetFairyPoolId()
  local isUnque = skillData:IsUniqueSkill()
  if isUnque and poolId ~= self.nowFairyData:GetFairyPoolId() then
    if not ignoreTip then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22015))
    end
    return false
  end
  if self:CheckHaveSameSkill(skillData) then
    if not ignoreTip then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22003))
    end
    return false
  end
  local count, maxCount = self:GetNowSelectNum()
  if count == maxCount then
    if not ignoreTip then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22004))
    end
    return false
  end
  return true
end

function UINFairySkillUpgradeNode:CheckAlreadyClick(skillData, fairyData)
  if self.selectFairySkillDataDic[skillData.fairySkillId] and self.selectFairySkillDataDic[skillData.fairySkillId].fairyUID == fairyData:GetFairyUID() then
    return true
  end
  return false
end

function UINFairySkillUpgradeNode:GetNowSelectNum()
  local count = 0
  for i, v in pairs(self.selectFairySkillDataDic) do
    count = count + 1
  end
  local maxSelectNum = self.nowFairyData and self.nowFairyData:GetMaxSkillNum() or 0
  return count, maxSelectNum
end

function UINFairySkillUpgradeNode:GetSelectSkillList()
  local skillList = {}
  for id, v in pairs(self.selectFairySkillDataDic) do
    table.insert(skillList, v)
  end
  return skillList
end

function UINFairySkillUpgradeNode:GetAllCouldSelectSkillList()
  local list = {}
  for _, skillData in pairs(self.nowFairyData:GetFairySkillDic()) do
    table.insert(list, skillData)
  end
  if self.selectFairyData ~= nil then
    for _, skillData in pairs(self.selectFairyData:GetFairySkillDic()) do
      table.insert(list, skillData)
    end
  end
  return list
end

function UINFairySkillUpgradeNode:OnClickSkillCheck()
  local mainWin = UIManager:GetWindow(UIWindowTypeID.FairyCultivateMain)
  if mainWin then
    mainWin:OpenSkillSelectedNode()
  end
end

function UINFairySkillUpgradeNode:OnClickIconGuide()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(57)
end

function UINFairySkillUpgradeNode:OnHide()
  self.skillItemPool:HideAll()
end

function UINFairySkillUpgradeNode:OnDelete()
end

return UINFairySkillUpgradeNode
