local GmCommandItem, Super = System.NewComponent("GmCommandItem")
local MaxSaveGmCount = 30

function GmCommandItem:ctor(uiNode, gmConfig, gmPanel)
  Super.ctor(self)
  self.config = gmConfig
  self.ui = GmcommandItemResource(uiNode)
  self.gmPanel = gmPanel
end

function GmCommandItem:OnBind(binder)
  self.root = self.ui.uiNode
  self.binder = binder
  self.binder:BindButtonClick(self.ui.Btn_Send, System.fn(self, self.OnClickSend))
  self:UpdateView()
end

function GmCommandItem:SetConfig(config)
  self.config = config
  self:UpdateView()
end

function GmCommandItem:UpdateView()
  local name = self.config.name
  if self.config.nameFunc and GmClientUtils[self.config.nameFunc] then
    name = GmClientUtils[self.config.nameFunc]()
  end
  self.ui.Text_ShowName:GetComponent(typeof(CS.UnityEngine.UI.Text)).text = name
end

function GmCommandItem:OnClickSend()
  local recentUseGm = self.gmPanel.recentUseGm
  for k, v in ipairs(recentUseGm) do
    if tonumber(v) == self.config.id then
      table.remove(recentUseGm, k)
      break
    end
  end
  table.insert(recentUseGm, 1, self.config.id)
  if #recentUseGm > MaxSaveGmCount then
    table.remove(recentUseGm)
  end
  if 0 == self.config.num then
    GmManager.TriggerGm(self.config.id, "", "")
  elseif self.config.name == "生成特定装备" or self.config.id == 237 then
    UIManager.Instance:Show(Urls.GmParamEquipPanel, self.config)
  else
    UIManager.Instance:Show(Urls.GmParamPanel, self.config)
  end
  if self.config.notCloseUI ~= true and UIManager.Instance then
    UIManager.Instance:CloseByUrl(Urls.GmPanel)
  end
end

return GmCommandItem
