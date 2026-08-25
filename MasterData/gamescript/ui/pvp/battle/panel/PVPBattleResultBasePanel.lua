local PvPSettleRewardDataType = CommonDefine.PvPSettleRewardDataType
local PvPBattleResultBasePanel, Super = System.NewClass("PvPBattleResultBasePanel", UIBasePanel)

function PvPBattleResultBasePanel:ctor()
  Super.ctor(self)
  self.normalReward = PvPSettleDataUtils.GetSettleRewardByType(PvPSettleRewardDataType.PVP)
  self.battleStyleReward = PvPSettleDataUtils.GetSettleRewardByType(PvPSettleRewardDataType.PVPStyle)
end

function PvPBattleResultBasePanel:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Quantity_1, function()
    return self.normalReward and self.normalReward.num or ""
  end)
  binder:BindToText(self.ui.Text_Quantity_2, function()
    return self.battleStyleReward and self.battleStyleReward.num or ""
  end)
  binder:BindToText(self.ui.Text_Currency, System.fn(self, self._GetTotalRewardDesc))
  binder:BindToImage(self.ui.Image_Currency, System.fn(self, self._GetCurrencyImage))
  binder:BindToVisible(self.ui.Image_Currency, function()
    return self.normalReward
  end)
  binder:BindToVisible(self.ui.Image_Reward_1, function()
    return self.normalReward
  end)
  binder:BindToVisible(self.ui.Image_Reward_2, function()
    return self.normalReward
  end)
  self:OnBindDiff(binder)
end

function PvPBattleResultBasePanel:_GetCurrencyImage()
  if not self.normalReward then
    return ""
  end
  do return ItemDataUtils.GetItemIcon end
  return ItemDataUtils.GetItemIcon, self.normalReward.tid
end

function PvPBattleResultBasePanel:_GetTotalRewardDesc()
  if not self.normalReward then
    return ""
  end
  do return LT.Text, string.format("+%s%s", self.normalReward.num + self.battleStyleReward.num, ItemDataUtils.GetItemName(self.normalReward.tid)) end
  return LT.Text, string.format("+%s%s", self.normalReward.num + self.battleStyleReward.num, ItemDataUtils.GetItemName(self.normalReward.tid))
end

function PvPBattleResultBasePanel:OnBindDiff(_)
end

return PvPBattleResultBasePanel
