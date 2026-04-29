_class("UIS4TradeCrewController", UIController)
UIS4TradeCrewController = UIS4TradeCrewController

function UIS4TradeCrewController:Constructor()
  self._tabType = nil
end

function UIS4TradeCrewController:OnShow(uiParams)
  self._tradeData = uiParams[1]
  self._selectID = uiParams[2]
  self:_GetComponents()
  self:_InitComponents()
  self:_AttachEvents()
  self:SwitchTab(UIS4TradeCrewTabType.Control)
end

function UIS4TradeCrewController:_GetComponents()
  self._crewControlSpawner = self:GetUIComponent("UISelectObjectPath", "crewControlSpawner")
  self._crewPurchaseSpawner = self:GetUIComponent("UISelectObjectPath", "crewPurchaseSpawner")
  self._select1Txt = self:GetUIComponent("UILocalizationText", "select1Txt")
  self._select2Txt = self:GetUIComponent("UILocalizationText", "select2Txt")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._select1Obj = self:GetGameObject("select1")
  self._select2Obj = self:GetGameObject("select2")
  self._crewControlSpawnerObj = self:GetGameObject("crewControlSpawner")
  self._crewPurchaseSpawnerObj = self:GetGameObject("crewPurchaseSpawner")
end

function UIS4TradeCrewController:_InitComponents()
  self._crewControlTab = self._crewControlSpawner:SpawnObject("UIS4TradeCrewControlTab")
  self._crewPurchaseTab = self._crewPurchaseSpawner:SpawnObject("UIS4TradeCrewPurchaseTab")
  self._crewControlTab:SetData(self._tradeData, self._selectID)
  self._crewPurchaseTab:SetData(self._tradeData, self._selectID)
end

function UIS4TradeCrewController:_AttachEvents()
end

function UIS4TradeCrewController:_Close()
  self:StartTask(function(TT)
    self:Lock("uieff_UIS4TradeCrewController_out")
    self._anim:Play("uieff_UIS4TradeCrewController_out")
    YIELD(TT, 334)
    self:UnLock("uieff_UIS4TradeCrewController_out")
    self:CloseDialog()
  end)
end

function UIS4TradeCrewController:SwitchTab(tabType)
  if self._tabType == tabType then
    return
  end
  self._tabType = tabType
  if tabType == UIS4TradeCrewTabType.Control then
    self._select1Obj:SetActive(true)
    self._select2Obj:SetActive(false)
    self._crewControlSpawnerObj:SetActive(true)
    self._crewPurchaseSpawnerObj:SetActive(false)
    self._crewControlTab:PlayInAnim()
    self._select1Txt.color = Color(0.34509803921568627, 0.2784313725490196, 0.23137254901960785)
    self._select2Txt.color = Color(0.5686274509803921, 0.5333333333333333, 0.4823529411764706)
  else
    self._select1Obj:SetActive(false)
    self._select2Obj:SetActive(true)
    self._crewControlSpawnerObj:SetActive(false)
    self._crewPurchaseSpawnerObj:SetActive(true)
    self._select1Txt.color = Color(0.5686274509803921, 0.5333333333333333, 0.4823529411764706)
    self._select2Txt.color = Color(0.34509803921568627, 0.2784313725490196, 0.23137254901960785)
    self._crewPurchaseTab:SetInit()
    self._crewPurchaseTab:PlayInAnim()
  end
end

function UIS4TradeCrewController:CloseBtnOnClick()
  self:_Close()
end

function UIS4TradeCrewController:EmptyBtnOnClick()
  self:_Close()
end

function UIS4TradeCrewController:Select1BtnOnClick()
  self:SwitchTab(UIS4TradeCrewTabType.Control)
end

function UIS4TradeCrewController:Select2BtnOnClick()
  self:SwitchTab(UIS4TradeCrewTabType.Purchase)
end

local UIS4TradeCrewTabType = {Control = 1, Purchase = 2}
_enum("UIS4TradeCrewTabType", UIS4TradeCrewTabType)
