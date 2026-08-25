local AwakerLikeTipsPanel, Super = System.NewClass("AwakerLikeTipsPanel", UIBasePanel)
AwakerLikeTipsPanel.uiResCls = Func_AwakerLove_TipsResource

function AwakerLikeTipsPanel:ctor(data)
  Super.ctor(self)
  self.data = data
end

function AwakerLikeTipsPanel:OnBind(binder)
  Super.OnBind(self, binder)
  self.animator = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.Animator))
  local awakerTid = self.data.awakerTid
  local awakerConfig = DT.AwakerConfig[awakerTid]
  local awakerName = LT.Text(awakerConfig.Name)
  binder:SetText(self.ui.Text_AwakerLove_Tips, LT.Textf("Like_Up_Tips_Copies", awakerName))
  local showTime = CS.Framework.UIUtilTool.GetClipTimeByName(self.animator, "UA_AwakerLove_Tips")
  binder:BindTimer(showTime, 0, nil, function()
    self:Close()
  end)
end

return AwakerLikeTipsPanel
