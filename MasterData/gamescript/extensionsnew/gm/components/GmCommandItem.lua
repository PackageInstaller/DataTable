local GmCommandItem, Super = NewViewComponent("GmCommandItem")
local GM_SPECIAL_EQUIP_ID = 237

function GmCommandItem:ctor(uiNode, view, gmConfig)
  Super.ctor(self, uiNode, view)
  self.ui = GmcommandItemResource(uiNode)
  self._config = gmConfig
end

function GmCommandItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Send, System.fn(self, self._OnClickSend))
end

function GmCommandItem:OnEnterComponent()
  self:_UpdateView()
end

function GmCommandItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function GmCommandItem:SetConfig(gmConfig)
  self._config = gmConfig
  self:_UpdateView()
end

function GmCommandItem:_UpdateView()
  local config = self._config
  if not config then
    return
  end
  local name = config.name
  if config.nameFunc and GmClientUtils[config.nameFunc] then
    name = GmClientUtils[config.nameFunc]()
  end
  self:SetRawText(self.ui.Text_ShowName, name or "")
end

function GmCommandItem:_OnClickSend()
  local config = self._config
  if not config then
    return
  end
  GmModel.Instance:AddRecentGm(config.id)
  if 0 == config.num then
    GmManager.TriggerGm(config.id, "", "")
  elseif config.name == "生成特定装备" or config.id == GM_SPECIAL_EQUIP_ID then
    UIManager.Instance:Show(Urls.GmParamEquipPanel, config)
  else
    UIManager.Instance:Show(Urls.GmParamPanel, config)
  end
  if config.notCloseUI ~= true and UIManager.Instance then
    UIManager.Instance:CloseByUrl(Urls.GmPanel)
  end
end

return GmCommandItem
