local SummonResultItemDetailSSR, Super = System.NewComponent("SummonResultItemDetailSSR", SummonResultItemDetail)

function SummonResultItemDetailSSR:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Summon_Popup_Show_LegendResource(uiNode)
  self.animName = "UI_Summon_Popup_Show_Legend_Open_01"
end

return SummonResultItemDetailSSR
