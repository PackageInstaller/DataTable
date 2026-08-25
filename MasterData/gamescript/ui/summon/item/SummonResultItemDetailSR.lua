local SummonResultItemDetailSR, Super = System.NewComponent("SummonResultItemDetailSR", SummonResultItemDetail)

function SummonResultItemDetailSR:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Summon_Popup_Show_RareResource(uiNode)
  self.animName = "UI_Summon_Popup_Show_Rare_Open_01"
end

return SummonResultItemDetailSR
