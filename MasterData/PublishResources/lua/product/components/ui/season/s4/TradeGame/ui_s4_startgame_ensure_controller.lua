_class("UIS4StartGameEnsureController", UIController)
UIS4StartGameEnsureController = UIS4StartGameEnsureController

function UIS4StartGameEnsureController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIS4StartGameEnsureController:OnShow(uiParams)
  self._tradeData = uiParams[1]
  self.OnChooseHarborId = uiParams[2]
  self.state = uiParams[3]
  self.cdTime = uiParams[4]
  self:InitWidget()
  self:InitData()
end

function UIS4StartGameEnsureController:InitWidget()
  self.stateCount = self:GetUIComponent("UILocalizationText", "StateCount")
  self._headList = self:GetUIComponent("UISelectObjectPath", "headList")
  self.cdTimeTxt = self:GetUIComponent("UILocalizationText", "CdTime")
  self._shipName = self:GetUIComponent("UILocalizationText", "txt")
end

function UIS4StartGameEnsureController:InitData()
  self._crews = self._tradeData:GetCrewsByHarbourID(self.OnChooseHarborId)
  self._crewItemTb = self._headList:SpawnObjects("UIS4TradeCrewManagerItem", 3)
  for i, item in pairs(self._crewItemTb) do
    local crew
    if i <= table.count(self._crews) then
      crew = self._crews[i]
    end
    item:SetData(crew)
    item:SetLayout(156, 164, Vector2(156, 164), Vector3(1.4, 1.4, 1.4))
  end
  local shipnamestr = "str_season_s4_trade_ship_" .. self.OnChooseHarborId
  self._shipName:SetText(StringTable.Get(shipnamestr))
  self.stateCount:SetText(self.state .. "%")
  self.cdTimeTxt:SetText(self.cdTime)
end

function UIS4StartGameEnsureController:EnsureBtnOnClick(go)
  if table.count(self._crews) == 0 then
    local title = StringTable.Get("str_season_s4_trade_sail_confirm")
    PopupManager.Alert("UIS4MessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", title, function()
      self:EnsureCallback()
    end)
  else
    self:EnsureCallback()
    self:CloseDialog()
  end
end

function UIS4StartGameEnsureController:EnsureCallback()
  self:ShowDialog("UIS4TradeGameMainController", self._tradeData, self.OnChooseHarborId)
  self:CloseDialog()
end

function UIS4StartGameEnsureController:CancelBtnOnClick(go)
  self:CloseDialog()
end

function UIS4StartGameEnsureController:CloseBtnOnClick(go)
  self:CloseDialog()
end
