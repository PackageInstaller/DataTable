local typeof = _ENV.typeof
local ResUpdateErrTipsPanel, Super = System.NewClass("ResUpdateErrTipsPanel", UIBasePanel)
ResUpdateErrTipsPanel.uiResCls = UI_Login_update_TipsResource

function ResUpdateErrTipsPanel:ctor(title, desc, confimCb, cancelCb)
  Super.ctor(self)
  self.title = title
  self.desc = desc
  self.cancelCb = cancelCb
  self.confirmCb = confimCb
end

function ResUpdateErrTipsPanel:OnBind(binder)
  self.binder = binder
  binder:SetActive(self.ui.Btn_Cancel, self.cancelCb)
  if self.cancelCb and not self.confirmCb then
    local rect = self.ui.Btn_Cancel.transform:GetComponent(typeof(CS.UnityEngine.RectTransform))
    rect.localPosition = CS.UnityEngine.Vector3(262, rect.localPosition.y, rect.localPosition.z)
  end
  binder:BindButtonClick(self.ui.Btn_Cancel, function()
    self:Close()
  end)
  if self.confirmCb and not self.cancelCb then
    local rect = self.ui.Btn_Confirm.transform:GetComponent(typeof(CS.UnityEngine.RectTransform))
    rect.localPosition = CS.UnityEngine.Vector3(262, rect.localPosition.y, rect.localPosition.z)
  end
  binder:SetActive(self.ui.Btn_Confirm, self.confirmCb)
  binder:BindButtonClick(self.ui.Btn_Confirm, function()
    if self.confirmCb then
      self.confirmCb()
    end
    Super.Close(self)
  end)
  if not self.title then
    self.title = "资源更新失败"
  end
  binder:SetText(self.ui.Text_Title, LT.Text(self.title))
  if not self.desc or self.desc == "" then
    self.desc = "资源更新失败，点击确定重试更新（点击取消退出游戏）"
  end
  binder:SetText(self.ui.Text_detail, LT.Text(self.desc))
end

function ResUpdateErrTipsPanel:Close()
  if self.cancelCb then
    self.cancelCb()
  end
  Super.Close(self)
end

function ResUpdateErrTipsPanel:OnUnbind()
  if self.finishCb then
    self.finishCb()
  end
end

return ResUpdateErrTipsPanel
