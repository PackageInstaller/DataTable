_class("UIAircraftTacticSwitch", UIController)
UIAircraftTacticSwitch = UIAircraftTacticSwitch

function UIAircraftTacticSwitch:OnShow(uiParams)
  self._pstid = uiParams[1]
  self._cb = uiParams[2]
  self._event = GameGlobal.Timer():AddEvent(7000, function()
    if self._cb then
      self._cb()
      self._cb = nil
    end
  end)
  self:InitWidget()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N8TapePlay)
end

function UIAircraftTacticSwitch:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  if self._req then
    self._req:Dispose()
    self._req = nil
  end
end

function UIAircraftTacticSwitch:InitWidget()
  self._anim = self:GetUIComponent("Animation", "UIAircraftTacticSwitch")
  self._icon = self:GetUIComponent("RawImage", "Tape")
  self._quality = self:GetUIComponent("UILocalizationText", "quality")
  local item = GameGlobal.GetModule(ItemModule):FindItem(self._pstid)
  local cardid = item:GetTemplateID()
  local cfg = Cfg.cfg_item[cardid]
  if not cfg then
    Log.error("###[UIAircraftTacticSwitch] cfg is nil ! id --> ", cardid)
  end
  local cfg_item_cartridge = Cfg.cfg_item_cartridge[cardid]
  self._quality:SetText(cfg_item_cartridge.Quality)
  local icon = cfg.Icon
  self._req = ResourceManager:GetInstance():SyncLoadAsset(icon .. ".mat", LoadType.Mat)
  if self._req then
    local obj = self._req.Obj
    local mainTexture = obj.mainTexture
    local matericon = self._icon.material
    matericon.mainTexture = mainTexture
  end
end

function UIAircraftTacticSwitch:bgOnClick(go)
  if self._cb then
    self._cb()
    self._cb = nil
  end
  local state = self._anim:get_Item("uieff_AircraftTactic_Switch")
  state.normalizedTime = 1
end
