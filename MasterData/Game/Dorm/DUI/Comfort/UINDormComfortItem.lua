local UINDormComfortItem = class("UINDormComfortItem", UIBaseNode)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")

function UINDormComfortItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Pick, self, self.OnComforPickClicked)
  self.ui.rewardItem:SetActive(false)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
end

function UINDormComfortItem:InitDormComfortItem(comfortLevelCfg, dormBriefData, pickAction)
  self.comfortLevelCfg = comfortLevelCfg
  self.comfortLevel = comfortLevelCfg.level
  self.__pickAction = pickAction
  self:RefreshDormComfortItem(dormBriefData)
end

function UINDormComfortItem:OnComforPickClicked()
  if self.__pickAction ~= nil then
    self.__pickAction(self.comfortLevelCfg, self)
  end
end

function UINDormComfortItem:RefreshDormComfortItem(dormBriefData)
  local curLevel = dormBriefData:GetDormComfortLevel()
  local isPicked = dormBriefData:IsDormComfortPicked(self.comfortLevel)
  local isReach = false
  if curLevel >= self.comfortLevel then
    isReach = true
  end
  if isReach then
    self.ui.isComplete:SetActive(isPicked)
    self.ui.btn_Pick.gameObject:SetActive(not isPicked)
  else
    self.ui.isComplete:SetActive(false)
    self.ui.btn_Pick.gameObject:SetActive(false)
  end
  self.rewardItemPool:HideAll()
  for index, itemId in pairs(self.comfortLevelCfg.rewardIds) do
    local itemCount = self.comfortLevelCfg.rewardNums[index]
    local rewardItem = self.rewardItemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    rewardItem:InitItemWithCount(itemCfg, itemCount)
    rewardItem:SetPickedUIActive()
  end
  if self.comfortLevel < 10 then
    self.ui.tex_Level.text = "LV.0" .. tostring(self.comfortLevel)
  else
    self.ui.tex_Level.text = "LV." .. tostring(self.comfortLevel)
  end
  if #self.comfortLevelCfg.logic > 0 then
    local front_cfg = ConfigData.dorm_comfort[self.comfortLevel - 1]
    local logic, para1, para2, para3 = CommonLogicUtil.MinLogicCfg(self.comfortLevelCfg, front_cfg)
    local des = CommonLogicUtil.GetLogicDesStrMultiLine(logic, para1, para2, para3)
    self.ui.tex_Addition.text = des
    self.ui.isAddition:SetActive(true)
    local isEffectOn = curLevel >= self.comfortLevel
    self.ui.isEffectOn:SetActive(isEffectOn)
    local showColor = isEffectOn and self.ui.color_effect or Color.white
    self.ui.img_Addition.color = showColor
    self.ui.tex_Addition.color = showColor
  else
    self.ui.isEffectOn:SetActive(false)
    self.ui.isAddition:SetActive(false)
  end
end

function UINDormComfortItem:OnDelete()
end

return UINDormComfortItem
