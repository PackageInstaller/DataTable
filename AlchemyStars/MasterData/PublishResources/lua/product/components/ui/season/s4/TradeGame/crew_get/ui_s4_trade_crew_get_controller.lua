_class("UIS4TradeCrewGetController", UIController)
UIS4TradeCrewGetController = UIS4TradeCrewGetController

function UIS4TradeCrewGetController:OnShow(uiParams)
  self._tradeData = uiParams[1]
  self._crewID = uiParams[2]
  self._shipID = uiParams[3]
  self._callback = uiParams[4]
  self:_GetComponents()
  self:_InitComponents()
  self:_AttachEvents()
end

function UIS4TradeCrewGetController:_GetComponents()
  self._crewSpawner = self:GetUIComponent("UISelectObjectPath", "crew")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIS4TradeCrewGetController:_InitComponents()
  self._crew = self._crewSpawner:SpawnObject("UIS4TradeCrewItem")
  self._crew:SetData(self._tradeData, self._crewID, self._shipID)
  self._crew:SetClick(false)
  self._crew:PlayInAnim(0)
end

function UIS4TradeCrewGetController:_AttachEvents()
end

function UIS4TradeCrewGetController:_Close()
  if self._callback then
    self._callback()
  end
  self:StartTask(function(TT)
    self:Lock("uieff_UIS4TradeCrewGetController_out")
    self._anim:Play("uieff_UIS4TradeCrewGetController_out")
    YIELD(TT, 334)
    self:UnLock("uieff_UIS4TradeCrewGetController_out")
    self:CloseDialog()
  end)
end

function UIS4TradeCrewGetController:CheckBtnOnClick()
  self:_Close()
end
