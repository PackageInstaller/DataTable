_class("UISideEnterCenterTabPage", UICustomWidget)
UISideEnterCenterTabPage = UISideEnterCenterTabPage

function UISideEnterCenterTabPage:OnShow()
  self._active = true
  self._data = nil
  self._content = nil
end

function UISideEnterCenterTabPage:OnHide()
  self._active = false
  self:UnLoadData()
  self:UnLoadContent()
end

function UISideEnterCenterTabPage:SetData(type, closeCallback, hideUICallback, cfg)
  if self._cfg ~= nil and self._cfg ~= cfg then
    self:UnLoadData()
    self:UnLoadContent()
  end
  self._type = type
  self._closeCallback = closeCallback
  self._hideUICallback = hideUICallback
  self._cfg = cfg
end

function UISideEnterCenterTabPage:LoadData(TT)
  local cfg = UISideEnterConst.GetCfg_SideEnterContent(self._cfg.ContentKey)
  local loadDataTimes = cfg and cfg.LoadDataTimes
  local loadData = false
  if loadDataTimes then
    loadData = true
  elseif not self._data then
    loadData = true
  end
  if loadData then
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    local dataClass = cfg and cfg.DataClass
    if not string.isnullorempty(dataClass) then
      local obj = _createInstance(dataClass)
      if obj then
        obj:SetData(self._cfg.ContentParams)
        self._data = obj:LoadData(TT, res)
      end
    end
    if not res:GetSucc() then
      self._data = nil
      Log.info("UISideEnterCenterTabPage:LoadData() failed, cfg_main_side_enter_center id = ", self._cfg.ID)
      return false
    end
  elseif UIActivityCampaign:IsInstanceOfType(self._data) then
    local open = self._data:CheckCampaignOpen()
    if not open then
      ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._data:GetCampaignID())
    end
    return open
  end
  return true
end

function UISideEnterCenterTabPage:GetHelpIntrKey()
  return self._cfg.HelpIntrKey
end

function UISideEnterCenterTabPage:UnLoadData()
  self._data = nil
end

function UISideEnterCenterTabPage:LoadContent()
  local info = self._cfg
  if not self._content then
    local class, prefab = UISideEnterConst.GetCfg_SideEnterContent_Info(info.ContentKey, self._type)
    if string.isnullorempty(class) or string.isnullorempty(prefab) then
      return
    end
    self._content = UIWidgetHelper.SpawnObject(self, "_sop", class, prefab)
    self._content:OnInit(self._type, self._closeCallback, self._hideUICallback, self._data, info.ContentParams)
  end
end

function UISideEnterCenterTabPage:UnLoadContent()
  if self._content then
    self._content:DoHide()
    self._content:DoDestroy()
    self._content = nil
    UIWidgetHelper.ClearWidgets(self, "_sop")
  end
end

function UISideEnterCenterTabPage:OnSelect(params)
  params = params or {}
  self:LoadContent()
  self._content:DoShow(params)
  if self._cfg.Bgm ~= CriAudioIDConst.BGMMainUI then
    AudioHelperController.PlayBGM(self._cfg.Bgm, AudioConstValue.BGMCrossFadeTime)
  else
    UIBgmHelper.PlayMainBgm()
  end
end

function UISideEnterCenterTabPage:OnDeselect()
  if self._content then
    self._content:DoHide()
  end
end

function UISideEnterCenterTabPage:GetContent()
  return self._content
end
