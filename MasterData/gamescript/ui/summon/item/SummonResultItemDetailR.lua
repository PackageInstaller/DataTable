local SummonResultItemDetailR, Super = System.NewComponent("SummonResultItemDetailR", SummonResultItemDetail)

function SummonResultItemDetailR:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Summon_Popup_Show_OrdinaryResource(uiNode)
  self.animName = "UI_Summon_Popup_Show_Ordinary_Open_01"
end

return SummonResultItemDetailR
