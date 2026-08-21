_class("UIN24MainEnter", UICustomWidget)
UIN24MainEnter = UIN24MainEnter

function UIN24MainEnter:OnShow(uiParams)
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._new:SetActive(false)
  self._red:SetActive(false)
  self._tipspanel1 = self:GetGameObject("tipspanel1")
  self._tips1 = self:GetUIComponent("RollingText", "tips1")
  self._tipspanel1:SetActive(false)
  self._activityConst = UIActivityN24Const:New()
  self:RequestCampaign()
end

function UIN24MainEnter:OnHide()
end

function UIN24MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN24MainEnter:RequestCampaign()
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

function UIN24MainEnter:Flush()
  self._tipspanel1:SetActive(false)
  if self._activityConst:IsHomelandTaskEnable() then
    self._tipspanel1:SetActive(true)
    self._tips1:RefreshText(StringTable.Get("str_n24_main_entry_tips"))
  end
end

function UIN24MainEnter:FlushNewRed()
  self._new:SetActive(false)
  self._red:SetActive(false)
  if self._activityConst:IsShowEntryNew() then
    self._new:SetActive(true)
    return
  end
  if self._activityConst:IsShowEntryRed() then
    self._red:SetActive(true)
  end
end

function UIN24MainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIN24MainEnter:Enter(TT)
  self:Lock("UIN20MainEnter_Enter")
  self:SwitchState(UIStateType.UIActivityN24MainController)
  self:UnLock("UIN20MainEnter_Enter")
end
