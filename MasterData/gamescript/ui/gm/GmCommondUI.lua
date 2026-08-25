local GmCommandUI, Super = System.NewComponent("GmCommandUI")

function GmCommandUI:ctor(gmConfig)
  Super.ctor(self)
  self.config = gmConfig
end

function GmCommandUI:OnBind(binder)
  Logger.Debug("GmCommandUI:OnBind(), 创建 UI")
  self.root = self.ui.uiNode
  self.binder = binder
  self.binder:BindButtonClick(self.ui.Btn_Send, System.fn(self, self.OnClickSend))
  self.ui.Text_ShowName:GetComponent(typeof(CS.UnityEngine.UI.Text)).text = self.config.name
  local x = math.floor((self.config.keyId - 1) % 3) * 215 - 380
  local y = 0 - math.floor((self.config.keyId - 1) / 3) * 65 + 221
  local srcWorldPos = CS.UnityEngine.Vector3(x, y, 0)
  self.root.transform.localPosition = srcWorldPos
end

function GmCommandUI:OnClickSend()
  if 0 == self.config.num then
    GmManager.TriggerGm(self.config.id, "", "")
    return
  end
  UIManager.Instance:Show(Urls.GmParamPanelUI, self.config)
end

return GmCommandUI
