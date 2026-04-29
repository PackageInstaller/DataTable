_class("UIChangeSignController", UIController)
UIChangeSignController = UIChangeSignController

function UIChangeSignController:OnShow(uiParams)
  self._playerInfo = uiParams[1]
  self._roleModule = self:GetModule(RoleModule)
  self._signUpper = EnumMaxStringLen.E_MaxString_SignText
  self:_GetComponents()
  self:_OnValue()
end

function UIChangeSignController:OnHide()
end

function UIChangeSignController:_GetComponents()
  self._oldSignTex = self:GetUIComponent("UILocalizationText", "oldSign")
  self._inputField = self:GetUIComponent("InputField", "changeSign")
  self._rulerTex = self:GetUIComponent("UILocalizationText", "ruler")
end

function UIChangeSignController:_OnValue()
  local maxValue = Cfg.cfg_global.change_chapter_sign_max_value_view.IntValue or 50
  self._rulerTex:SetText("")
  self._oldSign = self._playerInfo.m_stSignText
  self._etl = UICustomUIEventListener.Get(self._inputField.gameObject)
  self:AddUICustomEventListener(self._etl, UIEvent.Press, function()
    if self._inputField.touchScreenKeyboard then
      pcall(self.ActiveKeyboard, self, false)
    end
  end)
end

function UIChangeSignController:ActiveKeyboard(active)
  self._inputField.touchScreenKeyboard.active = active
end

function UIChangeSignController:backOnClick()
  self:CloseDialog()
end

function UIChangeSignController:changeBtnOnClick()
  if self:CheckSignError() then
    return
  end
  local idip_mng = self:GetModule(IdipgameModule)
  if idip_mng:TextBanHandle(IDIPBanType.IDIPBan_Signs) == true then
    return
  end
  self:Lock("UIChangeSignController:changeBtnOnClick")
  self:StartTask(self.OnchangeBtnOnClick, self)
end

function UIChangeSignController:CheckSignError()
  self.newSign = self._inputField.text
  if string.len(self.newSign) > self._signUpper then
    ToastManager.ShowToast(StringTable.Get("str_player_info_change_sign_chaoguo"))
    return true
  end
  if self._oldSign == self.newSign then
    ToastManager.ShowToast(StringTable.Get("str_player_info_change_sign_same"))
    return true
  end
  return false
end

function UIChangeSignController:OnchangeBtnOnClick(TT)
  local res = self._roleModule:Request_AmendSignText(TT, self.newSign)
  self:UnLock("UIChangeSignController:changeBtnOnClick")
  if res:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnChapcterInfoChanged)
    ToastManager.ShowToast(StringTable.Get("str_player_info_change_sign_succ"))
    self:CloseDialog()
  else
    local errorCode = res:GetResult()
    Log.fatal("###playerinfo - RequestChangeName fail ! result - ", errorCode)
    if errorCode == ROLE_RESULT_CODE.ROLE_ERROR_CHANGE_NICK_INVALID then
      ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_CHANGE_NICK_INVALID"))
    elseif errorCode == ROLE_RESULT_CODE.ROLE_ERROR_DIRTY_NICK then
      ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_DIRTY_NICK"))
    elseif errorCode == ROLE_RESULT_CODE.ROLE_ERROR_CHANGE_NICK_SPE then
      ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_CHANGE_NICK_SPE"))
    end
  end
end
