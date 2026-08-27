local UINActivityExplorationFundRewardItem = class("UINActivityExplorationFundRewardItem", UIBaseNode)
local base = UIBaseNode
local ActivityExplorationFundEnum = require("Game.ActivityExplorationFund.Data.ActivityExplorationFundEnum")
local ERewardState = ActivityExplorationFundEnum.ERewardState
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local colorIndex = {
  img_Icon = 1,
  img_Line = 2,
  img_Dot = 3,
  tex_Misson = 4,
  tex_MissonDes = 5
}

function UINActivityExplorationFundRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._rewardItem = UINBaseItemWithReceived.New()
  self._rewardItem:Init(self.ui.uINBaseItemWithReceived)
end

function UINActivityExplorationFundRewardItem:InitExplorationFundRewardItem(order, singleFundData)
  local level = singleFundData:GetSingleFundDataRewardLevels()[order]
  local commonState, seniorState = singleFundData:GetSingleFundDataRewardState(level)
  local currentColors = commonState == ERewardState.Complete and self.ui.colors_Complete or self.ui.colors_UnComplete
  self.ui.img_Icon.color = currentColors[colorIndex.img_Icon]
  self.ui.img_Line.color = currentColors[colorIndex.img_Line]
  self.ui.img_Dot.color = currentColors[colorIndex.img_Dot]
  self.ui.tex_Misson.color = currentColors[colorIndex.tex_Misson]
  self.ui.tex_MissonDes.color = currentColors[colorIndex.tex_MissonDes]
  self.ui.imgItem_Bottom:SetIndex(commonState == ERewardState.Complete and 1 or 0)
  self.ui.imgItem_SeniorBottom:SetIndex(seniorState == ERewardState.Complete and 1 or 0)
  self.ui.canvas_Normal.alpha = commonState == ERewardState.IsPicked and 0.6 or 1
  self.ui.canvas_Ex.alpha = seniorState == ERewardState.IsPicked and 0.6 or 1
  local levelCfg = singleFundData:GetSingleFundDataRewardLevelCfg(level)
  self.ui.imgItem_Icon:SetIndex(levelCfg.icon_type - 1)
  self.ui.tex_MissonDes.text = LanguageUtil.GetLocaleText(levelCfg.tip_des)
  for itemId, itemNum in pairs(levelCfg.base_item) do
    local itemCfg = ConfigData.item[itemId]
    self._rewardItem:InitItemWithCount(itemCfg, itemNum, nil, commonState == ERewardState.IsPicked)
    break
  end
  for itemId, itemNum in pairs(levelCfg.senior_item) do
    local itemCfg = ConfigData.item[itemId]
    self.ui.tex_SeniorNum.text = tostring(itemNum)
    self.ui.tex_SeniorName.text = LanguageUtil.GetLocaleText(itemCfg.name)
    break
  end
  local isSingleFundDataUnlockSenior = singleFundData:GetIsSingleFundDataUnlockSenior()
  self.ui.obj_SeniorLock:SetActive(not isSingleFundDataUnlockSenior)
  self.ui.obj_ExfX:SetActive(isSingleFundDataUnlockSenior and seniorState == ERewardState.Complete)
  self.ui.obj_Lock:SetActive(commonState == ERewardState.InProgress)
  self.ui.obj_fX:SetActive(commonState == ERewardState.Complete)
end

return UINActivityExplorationFundRewardItem
