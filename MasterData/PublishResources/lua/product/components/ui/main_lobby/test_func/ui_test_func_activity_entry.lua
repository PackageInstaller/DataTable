_class("UITestFuncActivityEntry", UICustomWidget)
UITestFuncActivityEntry = UITestFuncActivityEntry

function UITestFuncActivityEntry:OnShow(uiParams)
  self._root = self:GetGameObject("_root")
  self._infos = self:_GetInfos()
  self:_SetList()
end

function UITestFuncActivityEntry:OnHide()
end

function UITestFuncActivityEntry:_GetInfos()
  local tb = {}
  local cfgs = Cfg.cfg_campaign({})
  for id, v in pairs(cfgs) do
    if v.EntranceIcon and table.count(v.EntranceIcon) >= 3 then
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      local campaignObj = campaignModule.m_campaign_manager:GetCampaignObj(id)
      if campaignObj then
        table.insert(tb, campaignObj)
      end
    end
  end
  return tb
end

function UITestFuncActivityEntry:_SetList()
  local objs = UIWidgetHelper.SpawnObjects(self, "_entryPool", "UIMainLobbyCampaignEnter", #self._infos)
  for i, v in ipairs(objs) do
    v:Flush(nil, self._infos[i])
  end
end

function UITestFuncActivityEntry:ExitBtnOnClick()
  self._root:SetActive(false)
end
