local AwakerFavorGainedPanel, Super = System.NewClass("AwakerFavorGainedPanel", UIBasePanel)
AwakerFavorGainedPanel.uiResCls = UI_Main_Favor_TipResource

function AwakerFavorGainedPanel:ctor(awakerTid, gainedNum)
  Super.ctor(self)
  self.awakerTid = awakerTid
  self.gainedNum = gainedNum
end

function AwakerFavorGainedPanel:OnBind(binder)
  local awakerName = AwakerDataUtils.GetAwakerName(self.awakerTid)
  binder:SetText(self.ui.Text_Name, LT.Textf("FavorabilityIncrease", awakerName, self.gainedNum))
  binder:BindTimer(3, 0, nil, System.fn(self, self.Close))
end

return AwakerFavorGainedPanel
