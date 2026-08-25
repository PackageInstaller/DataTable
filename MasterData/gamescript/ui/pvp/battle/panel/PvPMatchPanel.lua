local PvPMatchPanel, Super = System.NewClass("PvPMatchPanel", UIBasePanel)
PvPMatchPanel.uiResCls = UI_Pvp_Panel_MatchResource

function PvPMatchPanel:ctor()
  Super.ctor(self)
  self.isMatching = Vue.ref(false)
end

function PvPMatchPanel:OnBind(binder)
  self.binder = binder
  binder:BindZ1Button(self.ui.UI_ComBtn2_Match, function()
    self:OnBtnMatch()
  end, nil, function()
    if self.isMatching.value then
      return "取消匹配"
    else
      return "开始匹配"
    end
  end)
  binder:BindToText(self.ui.Text_Matching, function()
    if self.isMatching.value then
      return "正在匹配"
    else
      return ""
    end
  end)
  self.binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self.Close)))
  binder:BindResponse(self, "World", "OnCreatePvPBattle", System.fn(self, self.OnCreatePvPBattle))
end

function PvPMatchPanel:OnBtnMatch()
  if not self.isMatching.value then
    self:ReqMatch()
  else
    self:ReqCancelMatch()
  end
end

function PvPMatchPanel:ReqMatch()
  ProtoManager.Instance:ReqServer("PvpRequest", "ReqMatch", function(data)
    self.isMatching.value = true
  end, nil)
end

function PvPMatchPanel:ReqCancelMatch()
  ProtoManager.Instance:ReqServer("PvpRequest", "ReqCancelMatch", function(data)
    self.isMatching.value = false
  end, nil)
end

function PvPMatchPanel:OnCreatePvPBattle(info)
  self.isMatching.value = false
end

function PvPMatchPanel:OnUnbind()
  Super.OnUnbind(self)
  if self.isMatching.value then
    self:ReqCancelMatch()
  end
end

return PvPMatchPanel
