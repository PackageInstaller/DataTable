require("ui_side_enter_item_base")
_class("UITempSignInEnter", UISideEnterItem_Base)
UITempSignInEnter = UITempSignInEnter

function UITempSignInEnter.CheckOpen()
  local isPassMissionID = Cfg.cfg_global.signInPassMissionID.IntValue
  local missionModule = GameGlobal.GetModule(MissionModule)
  local isPass = missionModule:IsPassMissionID(isPassMissionID)
  if not isPass then
    return false
  end
  local tb = {
    NewPlayerLoginStatus.NPLS_UnReach,
    NewPlayerLoginStatus.NPLS_UnAccept
  }
  local isOpen = UITempSignInEnter.CheckDayStatus(tb)
  if isOpen == 0 then
    Log.debug("UITempSignInEnter:CheckOpen() temp sign is close !")
    return false
  end
  return true
end

function UITempSignInEnter.CheckRed()
  local tb = {
    NewPlayerLoginStatus.NPLS_UnAccept
  }
  local idx = UITempSignInEnter.CheckDayStatus(tb)
  return idx ~= 0
end

function UITempSignInEnter.CheckDayStatus(target)
  local dic = table.reverse(target)
  local signInModule = GameGlobal.GetModule(SignInModule)
  local dayInfo = signInModule:GetNewPlayerSignupStatus()
  for index, value in ipairs(dayInfo) do
    if dic[value] ~= nil then
      return index
    end
  end
  return 0
end

function UITempSignInEnter:OnShow()
  self:AttachEvent(GameEventType.OnTempSignInAwardGot, self._Refresh)
end

function UITempSignInEnter:OnHide()
  self:DetachEvent(GameEventType.OnTempSignInAwardGot, self._Refresh)
end

function UITempSignInEnter:SetData(btnCfg)
  self._btnCfg = btnCfg
end

function UITempSignInEnter:_CheckOpen(TT)
  return UITempSignInEnter.CheckOpen()
end

function UITempSignInEnter:GetSideEnterRawImage()
  return "gh_xsqd_di09"
end

function UITempSignInEnter:DoShow()
  self:_SetTitle()
  self:_SetBg()
end

function UITempSignInEnter:_CalcNew()
  return false
end

function UITempSignInEnter:_CalcRed()
  return UITempSignInEnter.CheckRed()
end

function UITempSignInEnter:_Refresh()
  self:_CheckPoint()
end

function UITempSignInEnter:_SetTitle()
  local widgetName = "txtTitle"
  local strId = "str_sign_in_btn_str_new"
  if widgetName and strId then
    UIWidgetHelper.SetLocalizationText(self, widgetName, StringTable.Get(strId))
  end
end

function UITempSignInEnter:_SetBg()
  local widgetName = "bg"
  local sideEnterIcon = self:GetSideEnterRawImage()
  if widgetName and sideEnterIcon then
    UIWidgetHelper.SetRawImage(self, widgetName, sideEnterIcon)
  end
end

function UITempSignInEnter:BtnOnClick(go)
end
