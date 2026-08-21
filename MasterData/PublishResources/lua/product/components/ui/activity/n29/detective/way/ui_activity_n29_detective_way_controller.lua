_class("UIActivityN29DetectiveWayController", UIController)
UIActivityN29DetectiveWayController = UIActivityN29DetectiveWayController

function UIActivityN29DetectiveWayController:LoadDataOnEnter(TT, res, uiParams)
end

function UIActivityN29DetectiveWayController:OnShow(uiParams)
  self._point = uiParams[1]
  self._cfg = self._point:GetCfg()
  self._curStage = uiParams[2]
  self._psdId = uiParams[3]
  self:_GetComponent()
  self:InitInfo()
end

function UIActivityN29DetectiveWayController:OnHide()
end

function UIActivityN29DetectiveWayController:_GetComponent()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._info = self:GetUIComponent("UILocalizationText", "info")
  self._enterBtnTxt = self:GetUIComponent("UILocalizationText", "enterBtnTxt")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIActivityN29DetectiveWayController:InitInfo()
  if self._point:GetIsLockStatue() then
    self._icon:LoadImage("n29_dt_dd01")
    self._name:SetText(StringTable.Get(self._cfg.HideName))
    self._info:SetText(StringTable.Get(self._cfg.LockInfo))
    if self._cfg.Type == 1 then
      self._enterBtnTxt:SetText(StringTable.Get("str_n29_detective_way_btn_noenter"))
    else
      self._enterBtnTxt:SetText(StringTable.Get("str_n29_detective_role_btn_noenter"))
    end
  else
    self._icon:LoadImage(self._cfg.Pic)
    self._name:SetText(StringTable.Get(self._cfg.ShowName))
    self._info:SetText(StringTable.Get(self._cfg.Info))
    if self._cfg.Type == 1 then
      self._enterBtnTxt:SetText(StringTable.Get("str_n29_detective_way_btn_enter"))
    else
      self._enterBtnTxt:SetText(StringTable.Get("str_n29_detective_role_btn_enter"))
    end
  end
end

function UIActivityN29DetectiveWayController:MaskOnClick()
  self:StartTask(self._Close, self)
end

function UIActivityN29DetectiveWayController:_Close(TT)
  self._anim:Play("uieff_UIN29DetectiveWayController_out")
  YIELD(TT, 300)
  self:CloseDialog()
end

function UIActivityN29DetectiveWayController:EnterBtnOnClick()
  if self._point:GetIsLockStatue() then
    ToastManager.ShowToast(StringTable.Get("str_n29_detective_spot_lock"))
    return
  end
  local cfg_waypoint = Cfg.cfg_component_detective_waypoint[self._cfg.ID]
  local firstStory = cfg_waypoint.FirstStory
  if UIN29DetectiveHelper.CheckOpenIdKey(self._psdId, "UIN29DetectivePlayFirstStory" .. self._cfg.ID) then
    self:_StoryEnd()
  else
    UIN29DetectiveHelper.SetOpenIdKey(self._psdId, "UIN29DetectivePlayFirstStory" .. self._cfg.ID)
    UIActivityN29DetectiveWayController:ShowDialog("UIStoryController", firstStory, function()
      self:_StoryEnd()
    end, self)
  end
end

function UIActivityN29DetectiveWayController:_StoryEnd()
  if self._cfg.Type == 1 then
    self:SwitchState(UIStateType.UIN29DetectiveSuspectController, self._cfg.ID, self._curStage)
  elseif self._cfg.Type == 2 then
    self:SwitchState(UIStateType.UIN29DetectivePersonController, self._cfg.ID, self._curStage)
  end
end
