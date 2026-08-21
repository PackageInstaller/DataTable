_class("UIN20MainEnter", UICustomWidget)
UIN20MainEnter = UIN20MainEnter

function UIN20MainEnter:OnShow(uiParams)
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._new:SetActive(false)
  self._red:SetActive(false)
  self._tipspanel1 = self:GetGameObject("tipspanel1")
  self._tips1 = self:GetUIComponent("RollingText", "tips1")
  self._tipspanel2 = self:GetGameObject("tipspanel2")
  self._tips2 = self:GetUIComponent("RollingText", "tips2")
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._activityConst = UIActivityN20Const:New()
  self._anim = self:GetUIComponent("Animation", "Anim")
  self:RequestCampaign()
end

function UIN20MainEnter:OnHide()
end

function UIN20MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN20MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN20MainEnterRequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN20MainEnter:Flush()
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  local minGameOpenTime = self._activityConst:GetMiniGameOpenTime()
  local avgOpenTime = self._activityConst:GetAVGOpenTime()
  if minGameOpenTime > avgOpenTime then
    if self:CheckMiniGame() then
      return
    end
    self:CheckAVG()
  else
    if self:CheckAVG() then
      return
    end
    self:CheckMiniGame()
  end
end

function UIN20MainEnter:CheckMiniGame()
  if self._activityConst:IsMiniGameEnable() then
    self._tipspanel2:SetActive(true)
    self._tips2:RefreshText(StringTable.Get("str_n20_main_entry_tips2"))
    return true
  end
  return false
end

function UIN20MainEnter:CheckAVG()
  if self._activityConst:IsAVGEnable() then
    self._tipspanel1:SetActive(true)
    self._tips1:RefreshText(StringTable.Get("str_n20_main_entry_tips1"))
    return true
  end
  return false
end

function UIN20MainEnter:FlushNewRed()
  self._new:SetActive(false)
  self._red:SetActive(false)
  if self._activityConst:IsShowMainEntryNew() then
    self._new:SetActive(true)
    return
  end
  if self._activityConst:IsShowMainEntryRed() then
    self._red:SetActive(true)
  end
end

function UIN20MainEnter:btnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIN20MainEnter:Enter(TT)
  self:Lock("UIN20MainEnter_Enter")
  self._anim:Play("uieffanim_UIN20MainEnter_dian")
  YIELD(TT, 666)
  self:SwitchState(UIStateType.UIActivityN20MainController)
  self:UnLock("UIN20MainEnter_Enter")
end
