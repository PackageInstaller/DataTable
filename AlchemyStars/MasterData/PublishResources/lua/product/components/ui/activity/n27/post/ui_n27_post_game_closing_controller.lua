_class("UIN27PostGameClosingController", UIController)
UIN27PostGameClosingController = UIN27PostGameClosingController

function UIN27PostGameClosingController:OnShow(uiParams)
  self._curOrderMap = uiParams[1]
  self._curOrderRTMap = uiParams[2]
  self._curOrderSeq = uiParams[3]
  self._curTaskList = uiParams[4]
  self._uiN27MissionTaskCondition = uiParams[5]
  self._missionID = uiParams[6]
  self._componentInfo = uiParams[7]
  self._isSuccess = uiParams[8]
  self._curSelectOrder = nil
  self._color1 = Color(0.17647058823529413, 0.6666666666666666, 0.8627450980392157, 1)
  self._color2 = Color(0.3058823529411765, 0.28627450980392155, 0.27450980392156865, 1)
  self._missionCfg = Cfg.cfg_component_post_station_game_mission({
    ID = self._missionID
  })[1]
  self:InitWidget()
  self:InitTaskPanel()
  self:InitOrderPanel()
end

function UIN27PostGameClosingController:InitWidget()
  self._taskObjList = {}
  for i = 1, 3 do
    table.insert(self._taskObjList, self:GetGameObject("Task" .. i))
  end
  self._orderObjList = {}
  for i = 1, 5 do
    local rootObj = self:GetGameObject("Order" .. i)
    local selectImageObj = rootObj.transform:Find("SelectImage").gameObject
    local orderNameText = rootObj.transform:Find("LocalizationText"):GetComponent("UILocalizationText")
    local orderPercentText = rootObj.transform:Find("LocalizationText1"):GetComponent("UILocalizationText")
    local cfg = {
      rootObj = rootObj,
      selectImageObj = selectImageObj,
      orderNameText = orderNameText,
      orderPercentText = orderPercentText
    }
    self._orderObjList[i] = cfg
  end
  self._gameRawImage = self:GetUIComponent("RawImage", "GameRawImage")
  self._gameRawImageRect = self:GetUIComponent("RectTransform", "GameRawImage")
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._failText = self:GetUIComponent("UILocalizationText", "FailText")
  self._failTextObj = self:GetGameObject("FailText")
  self._orderBtnGroup = self:GetGameObject("OrderBtnGroup")
  self._gamePassObj = self:GetGameObject("PassObj")
  self._gameFailObj = self:GetGameObject("FailImage")
  self._taskRootObj = self:GetGameObject("TaskRoot")
  self._gamePassObj:SetActive(self._isSuccess)
  self._gameFailObj:SetActive(not self._isSuccess)
  self._orderBtnGroup:SetActive(self._isSuccess)
  self._taskRootObj:SetActive(self._isSuccess)
  if self._isSuccess then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N27MiniGaneSuccess)
  else
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioLose)
  end
  if not self._isSuccess then
    self._failText:SetText(StringTable.Get(self._missionCfg.FailMessage))
    self._failTextObj:SetActive(true)
  end
  self._titleText:SetText(StringTable.Get(self._missionCfg.Title))
  self._gameRawImageRect.sizeDelta = Vector2(675 * UnityEngine.Screen.width / UnityEngine.Screen.height, 675)
end

function UIN27PostGameClosingController:RestartBtnOnClick()
  self:SwitchState(UIStateType.UIN27PostInnerGameController, self._missionID)
end

function UIN27PostGameClosingController:QuitBtnOnClick()
  local param = self._isSuccess and self._missionID or nil
  if self:CheckComponentClose() then
    self:SwitchState(UIStateType.UIMain)
  else
    local openDialogListInfo = OpenDialogListInfo:New()
    openDialogListInfo:AddUIInfo("UISideEnterCenterController", {
      campaign_type = ECampaignType.CAMPAIGN_TYPE_N27,
      params = {param}
    })
    GameGlobal.UIStateManager():SwitchStateWithDialogList(UIStateType.UIMain, openDialogListInfo, true)
  end
end

function UIN27PostGameClosingController:InitOrderPanel()
  if not self._isSuccess then
    return
  end
  local firstOrderID = -1
  local len = table.count(self._curOrderMap)
  for orderID, orderMap in pairs(self._curOrderMap) do
    local idx = self._curOrderSeq[orderID]
    local refIdx = idx
    local refOrderID = orderID
    if idx == 1 then
      firstOrderID = orderID
    end
    local rootCfg = self._orderObjList[idx]
    rootCfg.orderNameText:SetText(StringTable.Get("str_n27_poststation_order") .. idx)
    local orderFinishPercent = self._uiN27MissionTaskCondition:GetOrderFinishPercent(orderID, orderMap)
    rootCfg.orderPercentText:SetText(orderFinishPercent .. "%")
    self:AddUICustomEventListener(UICustomUIEventListener.Get(rootCfg.rootObj), UIEvent.Click, function(go)
      self:ShowOrderDetail({refOrderID, refIdx})
    end)
  end
  for i = len + 1, #self._orderObjList do
    self._orderObjList[i].rootObj:SetActive(false)
  end
  self:ShowOrderDetail({firstOrderID, 1})
end

function UIN27PostGameClosingController:ShowOrderDetail(cfg)
  if self._curSelectOrder then
    local rootCfg = self._orderObjList[self._curSelectOrder[2]]
    rootCfg.selectImageObj:SetActive(false)
    rootCfg.orderNameText.color = self._color1
    rootCfg.orderPercentText.color = self._color2
  end
  local orderID = cfg[1]
  local rootCfg = self._orderObjList[cfg[2]]
  self._curSelectOrder = cfg
  rootCfg.selectImageObj:SetActive(true)
  rootCfg.orderNameText.color = Color(1, 1, 1, 1)
  rootCfg.orderPercentText.color = Color(1, 1, 1, 1)
  self._gameRawImage.texture = self._curOrderRTMap[orderID]
end

function UIN27PostGameClosingController:InitTaskPanel()
  local idx = 1
  for _, task in pairs(self._curTaskList) do
    local taskObj = self._taskObjList[idx]
    local textComp = taskObj.transform:Find("LocalizationText"):GetComponent("UILocalizationText")
    local str, done = self._uiN27MissionTaskCondition:CheckTaskAndGetStr(task, self._curOrderMap)
    if done then
      local UnDoneImageObj = taskObj.transform:Find("Image").gameObject
      local DoneMaskObj = taskObj.transform:Find("Mask").gameObject
      UnDoneImageObj:SetActive(false)
      DoneMaskObj:SetActive(true)
    end
    textComp.text = str
    idx = idx + 1
  end
end

function UIN27PostGameClosingController:CheckComponentClose()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if curTime >= self._componentInfo.m_close_time then
    return true
  end
  return false
end
