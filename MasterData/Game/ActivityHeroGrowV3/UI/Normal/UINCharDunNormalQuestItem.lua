local base = UIBaseNode
local UINCharDunNormalQuestItem = class("UINCharDunNormalQuestItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINCharDunNormalQuestItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_self, self, self.__OnClick)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.UINBaseItemWithReceived, false)
end

function UINCharDunNormalQuestItem:InitHGV3NormalQuestItem(normalData, decoColor, clickCallback)
  self.normalData = normalData
  self.clickCallback = clickCallback
  self.ui.Tex_Name.text = self.normalData:GetHGV3NormalDataName()
  self.ui.Text_Des.text = self.normalData:GetHGV3NormalDataDes()
  self.ui.Tex_teamDes.text = self.normalData:GetHGV3NormalDataTeamDes()
  for _, colorComp in pairs(self.ui.color_array) do
    colorComp.color = decoColor
  end
  self:__RefreshRewards()
  self:__RefreshState()
end

function UINCharDunNormalQuestItem:__RefreshRewards()
  local rewards = self.normalData:GetHGV3NormalDataRewards()
  if rewards == nil or table.count(rewards) == 0 then
    self.ui.Go_Reward:SetActive(false)
    return
  end
  self.ui.Go_Reward:SetActive(true)
  self.rewardItemPool:HideAll()
  for itemId, itemNum in pairs(rewards) do
    local item = self.rewardItemPool:GetOne(true)
    local itemCfg = ConfigData.item[itemId]
    item:InitItemWithCount(itemCfg, itemNum)
  end
end

function UINCharDunNormalQuestItem:__RefreshState()
  local curIndex = self.normalData:GetHGV3CurLvProgress()
  local maxIndex = #self.normalData:GetHGV3NormalLevels()
  local isAllClear = curIndex >= maxIndex
  if isAllClear then
    self.ui.Tex_State:SetIndex(1)
    return
  end
  local progress = curIndex + 1
  if progress <= 9 then
    self.ui.Tex_State:SetIndex(0, "0" .. tostring(progress))
  else
    self.ui.Tex_State:SetIndex(0, tostring(progress))
  end
end

function UINCharDunNormalQuestItem:__OnClick()
  if self.clickCallback ~= nil then
    self.clickCallback(self.normalData)
  end
end

function UINCharDunNormalQuestItem:OnDelete()
  base.OnDelete(self)
end

return UINCharDunNormalQuestItem
