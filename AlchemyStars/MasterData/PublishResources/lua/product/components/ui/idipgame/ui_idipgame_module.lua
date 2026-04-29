_class("UIIdipgameModule", UIModule)
UIIdipgameModule = UIIdipgameModule

function UIIdipgameModule:Constructor()
  self._Module = self:GetModule(IdipgameModule)
  self:AttachEvent(GameEventType.IdipBanDataEvent, self.HandleData)
  self:AttachEvent(GameEventType.LoginIdipActive, self.ActiveHandle)
  self:AttachEvent(GameEventType.SwitchUIStateFinish, self.UIHandle)
end

function UIIdipgameModule:Dispose()
end

function UIIdipgameModule:HandleData(idipType)
  if idipType == IDIPBanType.IDIPBan_Shutup then
    self:ShutupUI()
  elseif idipType == IDIPBanType.IDIPBan_Account then
    self:ShowUI()
  elseif idipType == IDIPBanType.IDIPBan_Nick then
    self:TextUI(idipType)
  elseif idipType == IDIPBanType.IDIPBan_Signs then
    self:TextUI(idipType)
  elseif idipType == IDIPBanType.IDIPBan_Teamdes then
    self:TextUI(idipType)
  else
    self:HandleRelogin()
  end
end

function UIIdipgameModule:UIHandle(uiStateType)
  self:ShowUI()
end

function UIIdipgameModule:ShowUI()
  local curUIState = GameGlobal.UIStateManager():CurUIStateType()
  if curUIState == UIStateType.BattleLoading or curUIState == UIStateType.UIBattle then
    return
  end
  self:HandleLogout()
end

function UIIdipgameModule:ShutupUI()
  local ct, desc = self._Module:GetData(IDIPBanType.IDIPBan_Shutup)
  if ct <= 0 then
    return
  end
  local cburl
  if desc == "" then
    local t = TimeToDate(ct)
    desc = StringTable.Get("str_common_idip_shutup", t)
    
    function cburl(url)
      SDKProxy:GetInstance():OpenUrl(url)
    end
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", desc, nil, "", cburl)
end

function UIIdipgameModule:ShutupUI()
  local ct, desc = self._Module:GetData(IDIPBanType.IDIPBan_Shutup)
  if ct <= 0 then
    return
  end
  local cburl
  if desc == "" then
    local t = TimeToDate(ct)
    desc = StringTable.Get("str_common_idip_shutup", t)
    
    function cburl(url)
      SDKProxy:GetInstance():OpenUrl(url)
    end
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", desc, nil, "", cburl)
end

function UIIdipgameModule:TextUI(idipType)
  local ct, desc = self._Module:GetData(idipType)
  if ct <= 0 then
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", desc)
end

function UIIdipgameModule:HandleLogout()
  local ct, desc = self._Module:GetData(IDIPBanType.IDIPBan_Account)
  if ct <= 0 then
    return
  end
  local cburl
  if desc == "" then
    local t = TimeToDate(ct)
    desc = StringTable.Get("str_common_idip_banacc", t)
    
    function cburl(url)
      SDKProxy:GetInstance():OpenUrl(url)
    end
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", desc, function()
    if GameGlobal.UIStateManager():CurUIStateType() == UIStateType.LoginEmpty then
    else
      GameGlobal.GameLogic():BackToLogin(false, LoginModule, "player logout", false)
    end
  end, "", cburl)
end

function UIIdipgameModule:HandleRelogin()
  if self._Module:IsRelogin() == false then
    return
  end
  local desc = StringTable.Get("str_common_idip_relogin")
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", desc, function()
    if GameGlobal.UIStateManager():CurUIStateType() == UIStateType.LoginEmpty then
    else
      GameGlobal.GameLogic():BackToLogin(false, LoginModule, "player logout", false)
    end
  end)
end

function UIIdipgameModule:ActiveHandle()
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_login_idip_kick"))
end
