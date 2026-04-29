_class("UICN7N36PostInnerGameController", UIController)
UICN7N36PostInnerGameController = UICN7N36PostInnerGameController

function UICN7N36PostInnerGameController:LoadDataOnEnter(TT, res, uiParams)
end

function UICN7N36PostInnerGameController:OnShow(uiParams)
  self.originMultiTouch = UnityEngine.Input.multiTouchEnabled
  UnityEngine.Input.multiTouchEnabled = false
  local firstParam = uiParams[1]
  if type(firstParam) == "number" then
    self._MissionID = firstParam
    self._MissionCallBack = uiParams[2]
  else
    self._MissionID = firstParam:GetID()
    self._TaskChainCallback = uiParams[2]
  end
  self._guideItem = nil
  self:InitGameConfig()
  self:InitWidget()
  self:AttachEvents()
  self:InitMainGrid()
  self:RefreshItemPanel()
  self:StartGame()
  if self._MissionID == 1 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.S3BackpackGameGrid)
  end
end

function UICN7N36PostInnerGameController:InitGameConfig()
  self._RotationList = {
    0,
    90,
    180,
    270
  }
  self._TimeCountSprNameList = {
    "n27_yz_wf_first",
    "n27_yz_wf_second",
    "n27_yz_wf_third",
    "n27_yz_wf_fourth"
  }
  self._StartGameTime = 3
  self._GameItemSortList = {}
  self._GameItemDic = {}
  self._GameItemObjectMap = {}
  self._CurSelectItemTypeID = -1
  self._CurItemWidget = nil
  self._CurRotateIdx = 1
  self._CurItemMatrix = nil
  self._CurDragItemID = nil
  self._CurDragItemCenter = nil
  self._CurDragItemAtomicID = nil
  self._CurShowOrderIdx = 1
  self._IsDragItem = false
  self._IsSelectItem = false
  self._IsDragFromItem = false
  self._DragFromItem = false
  self._CurHoveredBlock = nil
  self._AllGameItemCount = 0
  self._CurItemMap = {}
  self._UIGameItemObjectMap = {}
  self._IsPause = false
  self._EndGame = false
  self._IsAnimated = false
  self._IsDragingEmptyBlock = false
  self._Input = GameGlobal.EngineInput()
  self._MousePresent = GameGlobal.EngineInput().mousePresent
  self._TimerList = {}
  self._TotalScore = 0
  self._SpecialID = {
    8,
    9,
    10,
    11,
    12
  }
  self._RotationPos = Cfg.cfg_season_debris_item
  local missionSvrCfg = Cfg.cfg_season_debris_mission({
    ID = self._MissionID
  })
  local missionCfg = Cfg.cfg_season_debris_level({
    ID = self._MissionID
  })
  if missionCfg and missionSvrCfg then
    self._MissionCfg = missionCfg[1]
    self._MissionSvrCfg = missionSvrCfg[1]
    self._MissionScore = self._MissionSvrCfg.Score
    self._MissionMapMatrix = self._MissionCfg.Matrix
    self._MainGridWidth = #self._MissionMapMatrix[1]
    self._MainGridHeight = #self._MissionMapMatrix
    self._UIGridItemSize = 160
    self._UIMainGridRect = Vector2(self._UIGridItemSize * self._MainGridWidth, self._UIGridItemSize * self._MainGridHeight)
  end
  local missionItemIdList = self._MissionCfg.DebrisId
  local missionItemCountList = self._MissionCfg.DebrisNum
  for i = 1, #missionItemIdList do
    local itemID = missionItemIdList[i]
    local itemCount = missionItemCountList[i]
    local cfg = Cfg.cfg_season_debris_item({ID = itemID})
    if cfg then
      local itemCfg = cfg[1]
      local t = {}
      t.cfg = itemCfg
      t.count = itemCount
      self._GameItemDic[itemID] = t
      table.insert(self._GameItemSortList, t)
    end
  end
  table.sort(self._GameItemSortList, function(v1, v2)
    return v1.cfg.Sort < v2.cfg.Sort
  end)
  self._AllGameItemCount = #self._GameItemSortList
  self._UICN7N36PostPackageGridManager = UICN7N36PostPackageGridManager:New(self._MainGridWidth, self._MainGridHeight)
  self._UICN7N36ScoreManager = UICN7N36ScoreManager:New(self._UICN7N36PostPackageGridManager, self._MissionID, self._MainGridWidth, self._MainGridHeight)
end

function UICN7N36PostInnerGameController:InitWidget()
  self._atlas = self:GetAsset("CN7N36PostGame.spriteatlas", LoadType.SpriteAtlas)
  self._MainGridRawImage = self:GetUIComponent("RawImage", "MainGridRawImage")
  self._MainGridRawImageObj = self:GetGameObject("MainGridRawImage")
  self._ItemPanel = self:GetUIComponent("UISelectObjectPath", "ItemPanel")
  self._ItemPanelGo = self:GetGameObject("ItemPanel")
  self._StartPanelObj = self:GetGameObject("StartPanel")
  self._PausePanelObj = self:GetGameObject("PausePanel")
  self._DeletePanelObj = self:GetGameObject("DeletePanel")
  self._MainEmptyArea = self:GetGameObject("EmptyArea")
  self._DayText = self:GetUIComponent("UILocalizationText", "DayText")
  self._PcImageRObj = self:GetGameObject("pcImageR")
  self._PcImageTObj = self:GetGameObject("pcImageT")
  self._Anim = self:GetUIComponent("Animation", "anim")
  self._AnimIn = self:GetUIComponent("Animation", "animIn")
  self._Transition = self:GetUIComponent("ATransitionComponent", "anim")
  self._HideGroup = self:GetUIComponent("CanvasGroup", "HideGroup")
  self._Shot = self:GetUIComponent("H3DUIBlurHelper", "HideGroup")
  self._TotalScoreTxt = self:GetUIComponent("UILocalizationText", "ScoreTxt")
  self._PostMaskObj = self:GetGameObject("PostMask")
  self._ScoreTipsTxt = self:GetUIComponent("UILocalizationText", "ScoreTipsTxt")
  self._MainGridRawImageTrans = self._MainGridRawImageObj.transform
  self._PassIconsObj = self:GetGameObject("PassIcons")
  self._GuideBoxObj = self:GetGameObject("guideBox")
  self._ScoreTipsAnim = self:GetUIComponent("Animation", "ScoreTipsAnim")
  self._TotalScoreTxt:SetText(self._TotalScore .. "/" .. self._MissionScore)
  self._Camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
end

function UICN7N36PostInnerGameController:AttachEvents()
  self:AttachEvent(GameEventType.OnCN7N36PostGameItemPress, self.OnGameItemSelect)
  self:AttachEvent(GameEventType.OnCN7N36PostGameItemRelease, self.OnGameItemRelease)
  self:AttachEvent(GameEventType.OnCN7N36PostGameItemClick, self.OnGameItemClick)
  self:AttachEvent(GameEventType.OnCN7N36PostGameBlockHovered, self.OnGameBlockHovered)
  self:AttachEvent(GameEventType.OnCN7N36PostGameBlockPress, self.OnGameBlockPress)
  self:AttachEvent(GameEventType.OnCN7N36PostGameBlockRelease, self.OnGameBlockRelease)
  self:AttachEvent(GameEventType.OnCN7N36PostGameBlockClick, self.OnGameBlockClick)
  self._reselutionChangeCb = GameHelper:GetInstance():CreateCallback(self.OnResolutionChanged, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIBlackChange, self._reselutionChangeCb)
end

function UICN7N36PostInnerGameController:OnResolutionChanged()
  local ratio = UnityEngine.Screen.width / UnityEngine.Screen.height
  local offset = ratio < 1.77777 and 1.77777 - ratio or 0
  if not self._MainGridGameCamera or tolua.isnull(self._MainGridGameCamera) then
    return
  end
  self._MainGridGameCamera.fieldOfView = 57 + 34 * offset
  if self._GameRenderTexture then
    self._GameRenderTexture:Release()
  end
  self._GameRenderTexture = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  self._MainGridGameCamera.targetTexture = self._GameRenderTexture
  self._MainGridRawImage.texture = self._GameRenderTexture
  local rect = self._GuideBoxObj.transform.parent:GetComponent("RectTransform")
  local bangWidth = ResolutionManager.BangWidth()
  local blackWidth = ResolutionManager.BlackWidth()
  local width = math.max(bangWidth, blackWidth)
  rect.anchoredPosition = rect.anchoredPosition + Vector3(width / 2, 0, 0)
end

function UICN7N36PostInnerGameController:StartGame()
  self._CurUICameraDepth = self._Camera.depth
  self._MainGridGameCamera.depth = self._CurUICameraDepth + 1
end

function UICN7N36PostInnerGameController:RefreshItemPanel()
  self._ItemPanel:SpawnObjects("UICN7N36PostSelectItem", self._AllGameItemCount)
  local itemWidgetList = self._ItemPanel:GetAllSpawnList()
  for i = 1, #self._GameItemSortList do
    local widget = itemWidgetList[i]
    local data = self._GameItemSortList[i]
    widget:SetData(data.cfg, data.count, i)
    if not self._guideItem then
      self._guideItem = widget
    end
  end
end

function UICN7N36PostInnerGameController:InitMainGrid()
  self._MainGridReq = ResourceManager:GetInstance():SyncLoadAsset("UICN7N36PostMainGrid.prefab", LoadType.GameObject)
  self._MainGridReq.Obj:SetActive(true)
  self._MainGridCanvasRaycaster = self._MainGridReq.Obj.transform:Find("Canvas"):GetComponent("GraphicRaycaster")
  self._MainGridItemPrefab = self._MainGridReq.Obj.transform:Find("Canvas/block").gameObject
  self._GameItemPrefab = self._MainGridReq.Obj.transform:Find("Canvas/itemImage").gameObject
  self._MainGridTransform = self._MainGridReq.Obj.transform:Find("Canvas/Grid")
  self._MainGridGroupTransform = self._MainGridReq.Obj.transform:Find("Canvas/GridItemGroup")
  self._DragItem = self._MainGridReq.Obj.transform:Find("Canvas/DragItem").gameObject
  self._DragGroup = self._MainGridReq.Obj.transform:Find("Canvas/dragGroup").gameObject
  self._DragItemRect = self._DragGroup:GetComponent("RectTransform")
  self._DragGroupRect = self._DragGroup:GetComponent("RectTransform")
  self._DragItemEventComp = self._DragItem:GetComponent("EmptyImage")
  self._DragIconImage = self._MainGridReq.Obj.transform:Find("Canvas/DragItem/dragIcon").gameObject:GetComponent("Image")
  self._SelectIconObj = self._MainGridReq.Obj.transform:Find("Canvas/DragItem/SelectIcon").gameObject
  self._SelectIconImage = self._SelectIconObj:GetComponent("Image")
  self._RotateBtn = self._MainGridReq.Obj.transform:Find("Canvas/dragGroup/rotateBtn").gameObject
  self._CancelBtn = self._MainGridReq.Obj.transform:Find("Canvas/dragGroup/cancelBtn").gameObject
  self._DragHand = self._MainGridReq.Obj.transform:Find("Canvas/hand").gameObject
  self._MainGridGameCamera = self._MainGridReq.Obj.transform:Find("Camera"):GetComponent("Camera")
  self._ScoreRoot = self._MainGridReq.Obj.transform:Find("Canvas/DragItem/dragIcon/Score").gameObject
  self._ScoreTxt = self._MainGridReq.Obj.transform:Find("Canvas/DragItem/dragIcon/Score/ScoreTxt"):GetComponent("UILocalizationText")
  self:OnResolutionChanged()
  local gridRect = self._MainGridTransform.gameObject:GetComponent("RectTransform")
  local gridGroupRect = self._MainGridGroupTransform.gameObject:GetComponent("RectTransform")
  gridRect.sizeDelta = self._UIMainGridRect
  gridGroupRect.sizeDelta = self._UIMainGridRect
  for i = 1, self._MainGridHeight do
    for j = 1, self._MainGridWidth do
      local mainGridItem = UnityEngine.GameObject.Instantiate(self._MainGridItemPrefab, self._MainGridTransform)
      local isEmptyBlock = self._MissionMapMatrix[i][j] == 0
      if isEmptyBlock then
        mainGridItem:GetComponent("Image").color = Vector2(1, 1, 1, 0)
      end
      local mainGridItemWidget = UICN7N36PostMainGridItem:New(i, j, mainGridItem, isEmptyBlock)
      self._UICN7N36PostPackageGridManager:InjectWidgetToMainMatrix(i, j, mainGridItemWidget)
      mainGridItem:SetActive(true)
    end
  end
  self:InjectMainGridEvent()
end

function UICN7N36PostInnerGameController:InjectMainGridEvent()
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._MainEmptyArea), UIEvent.Hovered, function(go)
    Log.debug("Empty Hovered!!!!!!!!!!!!")
    self._CurHoveredBlock = nil
    self._UICN7N36PostPackageGridManager:ClearCheckBlocksColor()
    local itemCfg = Cfg.cfg_season_debris_item({
      ID = self._CurDragItemID
    })[1]
    self._SelectIconImage.sprite = self._atlas:GetSprite(itemCfg.UnPutItemIcon)
    self._ScoreRoot:SetActive(false)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._DragItem), UIEvent.BeginDrag, function(go)
    self:RecaculateSelectItemPivot()
    self:RefreshDragItemPos()
    self:SetDragStatus(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._DragItem), UIEvent.EndDrag, function(go)
    self:RevertSelectItemPivot()
    self:SetDragStatus(false)
    if self._IsDragFromItem then
      self:OnGameItemRelease()
    else
      self:OnGameBlockRelease()
    end
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._RotateBtn), UIEvent.Click, function(go)
    self:RotateBtnOnClick()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._CancelBtn), UIEvent.Click, function(go)
    self:SetDragItemSelectStatus(false)
    self:DeleteCurrentSelectGameItem()
    self._UICN7N36PostPackageGridManager:ClearCheckBlocksColor()
    self:RefreshItemDownScore()
    self:RefreshTotalScore()
  end)
end

function UICN7N36PostInnerGameController:DeleteCurrentSelectGameItem()
  if not self._IsDragFromItem then
    local atomicItemID = self._CurDragItemAtomicID
    local itemID = self._CurDragItemID
    self:SetItemToMap(itemID, false)
    self._UICN7N36PostPackageGridManager:RemoveItemDetailInGridMap(atomicItemID)
    local gameObject = self._GameItemObjectMap[atomicItemID]
    self._GameItemObjectMap[atomicItemID] = nil
    UnityEngine.GameObject.Destroy(gameObject)
  end
end

function UICN7N36PostInnerGameController:OnUpdate(deltaTimeMS)
  if self._EndGame then
    return
  end
  self:OnPCInputUpdate()
  self:OnDragUpdate()
  self:OnClickScreen()
end

function UICN7N36PostInnerGameController:OnClickScreen()
  if self:_CheckGuide56() then
    return
  end
  if self._Input.GetMouseButtonDown(0) and self._IsSelectItem and self:CanAutoInsertSelectItem() then
    if self._IsDragFromItem then
      self:OnGameItemRelease()
    else
      self:OnGameBlockRelease()
    end
  end
end

function UICN7N36PostInnerGameController:OnDragUpdate()
  if not self._IsDragItem then
    return
  end
  self:RefreshDragItemPos()
end

function UICN7N36PostInnerGameController:RefreshDragItemPos()
  local mousePosition = self._Input.mousePosition
  local screenPos = Vector2(mousePosition.x, mousePosition.y)
  local pos = UIHelper.ScreenPointToWorldPointInRectangle(self._DragItem.transform.parent, screenPos, self._MainGridGameCamera)
  self._DragItem.transform.position = pos
  self._DragHand.transform.position = pos
  self._DragGroup.transform.position = pos
end

function UICN7N36PostInnerGameController:OnPCInputUpdate()
  if not self._IsDragItem then
    return
  end
  if self._Input.GetKeyDown(UnityEngine.KeyCode.R) then
    self:RotateBtnOnClick()
  end
end

function UICN7N36PostInnerGameController:SetDragStatus(flag)
  self._IsDragItem = flag
  self._DragItem:SetActive(flag)
  self._DragHand:SetActive(flag)
  self._MainEmptyArea:SetActive(flag)
  self._DragGroup:SetActive(false)
  self._DragItemEventComp.enabled = not flag
end

function UICN7N36PostInnerGameController:SetDragItemSelectStatus(flag)
  self._IsSelectItem = flag
  self._DragItem:SetActive(flag)
  self._DragHand:SetActive(false)
  self._DragGroup:SetActive(flag)
  self._DragItemEventComp.enabled = flag
end

function UICN7N36PostInnerGameController:OnGameItemSelect(itemWidget)
  self._CurItemWidget = itemWidget
  if self._CurItemWidget:GetItemCount() == 0 then
    return
  end
  if self._IsSelectItem then
    self:SetDragItemSelectStatus(false)
    self:DeleteCurrentSelectGameItem()
  end
  self._IsDragFromItem = true
  self._CurDragItemCenter = nil
  self._CurHoveredBlock = nil
  local itemDetail = self._UICN7N36PostPackageGridManager:GetItemDetail(itemWidget:GetItemID())
  self._CurRotateIdx = 1
  self._CurItemMatrix = self._UICN7N36PostPackageGridManager:CopyMatrix(itemDetail.Matrix)
  self._CurDragItemID = itemWidget:GetItemID()
  local eulerAngle = self._RotationList[self._CurRotateIdx]
  local ndcX, ndxY = self._UICN7N36PostPackageGridManager:GetItemNDCCenter(itemWidget:GetItemID(), true)
  local pivot = self:GetItemPivot({ndcX, ndxY}, self._CurRotateIdx)
  local RectTransform = self._DragItem:GetComponent("RectTransform")
  self._DragItem.transform.localEulerAngles = Vector3(0, 0, eulerAngle)
  RectTransform.pivot = Vector2(pivot[1], pivot[2])
  local sizeX, sizeY = self._UICN7N36PostPackageGridManager:GetItemSize(itemWidget:GetItemID())
  RectTransform.sizeDelta = Vector2(self._UIGridItemSize * sizeX, self._UIGridItemSize * sizeY)
  self:SetDragStatus(true)
  self:RefreshDragItemPos()
  local dragItemIcon = itemWidget:GetItemIcon()
  local bgIcon = itemWidget:GetUnPutItemIcon()
  self._DragIconImage.sprite = self._atlas:GetSprite(dragItemIcon)
  self._SelectIconImage.sprite = self._atlas:GetSprite(bgIcon)
  self._DragGroupRect.pivot = Vector2(pivot[1], pivot[2])
  self._DragGroupRect.sizeDelta = Vector2(self._UIGridItemSize * sizeX, self._UIGridItemSize * sizeY)
  self:_GetItemScorePos(itemWidget:GetItemID(), 0, false)
  if self:CheckInDragGuide() then
    self._GuideBoxObj:SetActive(true)
    if GameGlobal.GuideMessageBoxMng()._uiMsgBox then
      GameGlobal.GuideMessageBoxMng()._uiMsgBox:SetShow(false)
    end
  end
end

function UICN7N36PostInnerGameController:OnGameItemRelease()
  if not self._CurItemWidget then
    return
  end
  if self._CurItemWidget:GetItemCount() == 0 then
    self._CurItemWidget = nil
    return
  end
  self:SetDragStatus(false)
  if self:CheckInDragGuide() then
    self._GuideBoxObj:SetActive(false)
    if GameGlobal.GuideMessageBoxMng()._uiMsgBox then
      GameGlobal.GuideMessageBoxMng()._uiMsgBox:SetShow(true)
    end
    if self._CurHoveredBlock and self._CurHoveredBlock:GetIsGuideBlock() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
    else
      self._UICN7N36PostPackageGridManager:ClearCheckBlocksColor()
      return
    end
  end
  if self._CurHoveredBlock == nil then
    if self:CheckDragInItemPanel() then
      self:SetDragItemSelectStatus(false)
      self:DeleteCurrentSelectGameItem()
    else
      self:SetDragItemSelectStatus(true)
    end
    return
  end
  self._ScoreRoot:SetActive(false)
  local eulerAngles = math.floor(self._DragItem.transform.rotation.eulerAngles.z)
  self:_GetItemScorePos(self._CurDragItemID, eulerAngles, false)
  local pos = Vector2(self._CurHoveredBlock:GetX(), self._CurHoveredBlock:GetY())
  local mainBlockWidget = self._UICN7N36PostPackageGridManager:GetMainMatrixWidget(pos.x, pos.y)
  local result, atomicItemID = self._UICN7N36PostPackageGridManager:TryToInsertMainMatrix(self._CurDragItemID, self._CurItemMatrix, mainBlockWidget, self._CurRotateIdx, self._CurDragItemCenter)
  if result then
    Log.debug("------放置成功-----")
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameWeight)
    local itemDetail = self._UICN7N36PostPackageGridManager:GetItemDetailOnGridMap(atomicItemID)
    local gameObject = self:CreateItemOnGrid(self._CurDragItemID, pos, itemDetail)
    self:SetItemToMap(self._CurDragItemID, true)
    self._GameItemObjectMap[atomicItemID] = gameObject
    self:CheckScore(atomicItemID, itemDetail.itemID)
    self._ScoreRoot:SetActive(true)
    self:RefreshItemDownScore()
    self:PlayAddScoreTip(itemDetail.blockList, itemDetail.itemID)
    self:SetDragItemSelectStatus(false)
  else
    self:SetDragItemSelectStatus(true)
    Log.debug("------放置失败-----")
  end
  self._UICN7N36PostPackageGridManager:ClearCheckBlocksColor()
  self._CurHoveredBlock = nil
end

function UICN7N36PostInnerGameController:CheckDragInItemPanel()
  local mousePosition = self._Input.mousePosition
  local screenWidth = UnityEngine.Screen.width
  if mousePosition.x / screenWidth > 0.7 then
    return true
  end
  return false
end

function UICN7N36PostInnerGameController:OnGameItemClick(itemWidget)
  if self:CheckInGuide() then
    return
  end
  if itemWidget:GetItemCount() == 0 then
    return
  end
  if self._IsSelectItem then
    self:SetDragItemSelectStatus(false)
    self:DeleteCurrentSelectGameItem()
  end
  self._UICN7N36PostPackageGridManager:AutoSetItemOnMainMatrix(itemWidget:GetItemID(), function(result, atomicItemID, blockWidget, rotationID)
    if result then
      Log.debug("------放置成功-----")
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameWeight)
      local itemDetail = self._UICN7N36PostPackageGridManager:GetItemDetailOnGridMap(atomicItemID)
      local pos = Vector2(blockWidget:GetX(), blockWidget:GetY())
      self._CurDragItemCenter = nil
      self._CurRotateIdx = rotationID
      local gameObject = self:CreateItemOnGrid(itemWidget:GetItemID(), pos, itemDetail)
      self:SetItemToMap(itemWidget:GetItemID(), true)
      self._GameItemObjectMap[atomicItemID] = gameObject
      self:CheckScore(atomicItemID, itemDetail.itemID)
      self:RefreshItemDownScore()
    else
      ToastManager.ShowToast(StringTable.Get("str_season_debris_tips4"))
    end
  end)
end

function UICN7N36PostInnerGameController:OnGameBlockHovered(blockWidget)
  if not self._IsDragItem then
    return
  end
  self._CurHoveredBlock = blockWidget
  self._ScoreRoot:SetActive(false)
  local eulerAngles = math.floor(self._DragItem.transform.rotation.eulerAngles.z)
  self:_GetItemScorePos(self._CurDragItemID, eulerAngles, false)
  local result, blockList = self._UICN7N36PostPackageGridManager:CheckItemHoveredOnMainMatrix(self._CurDragItemID, self._CurItemMatrix, blockWidget, self._CurRotateIdx, self._CurDragItemCenter)
  local itemCfg = Cfg.cfg_season_debris_item({
    ID = self._CurDragItemID
  })[1]
  if result then
    self._ScoreRoot:SetActive(true)
    local score = self:_GetSpecialItemScore(blockList, self._CurDragItemID)
    self._ScoreTxt:SetText(score)
    self._SelectIconImage.sprite = self._atlas:GetSprite(itemCfg.CanPutItemIcon)
  else
    self._SelectIconImage.sprite = self._atlas:GetSprite(itemCfg.UnPutItemIcon)
  end
end

function UICN7N36PostInnerGameController:OnGameBlockPress(blockWidget, noRecaculatePivot)
  local atomicItemID = blockWidget:GetAtomicItemID()
  local itemID = blockWidget:GetItemID()
  if atomicItemID == nil then
    self._IsDragingEmptyBlock = true
    return
  end
  if self._IsSelectItem then
    self:SetDragItemSelectStatus(false)
    self:DeleteCurrentSelectGameItem()
  end
  self._IsDragFromItem = false
  local itemDetail = self._UICN7N36PostPackageGridManager:GetItemDetailOnGridMap(atomicItemID)
  self._CurHoveredBlock = blockWidget
  self._CurDragItemAtomicID = atomicItemID
  self._CurRotateIdx = itemDetail.rotationID
  self._CurItemMatrix = itemDetail.matrix
  self._CurDragItemID = itemID
  local eulerAngle = self._RotationList[self._CurRotateIdx]
  local RectTransform = self._DragItem:GetComponent("RectTransform")
  self._DragItem.transform.localEulerAngles = Vector3(0, 0, eulerAngle)
  local sizeX, sizeY = self._UICN7N36PostPackageGridManager:GetItemSize(itemID)
  RectTransform.sizeDelta = Vector2(self._UIGridItemSize * sizeX, self._UIGridItemSize * sizeY)
  self._GameItemObjectMap[atomicItemID]:SetActive(false)
  for _, blockWidget in pairs(itemDetail.blockList) do
    blockWidget:SetOccupy(false, nil, nil)
  end
  local mapItemRect = self._GameItemObjectMap[atomicItemID]:GetComponent("RectTransform")
  RectTransform.pivot = mapItemRect.pivot
  RectTransform.position = mapItemRect.position
  local offsetSize = {
    (RectTransform.pivot.x - 0.5) * RectTransform.sizeDelta.x,
    (RectTransform.pivot.y - 0.5) * RectTransform.sizeDelta.y
  }
  local curRotateIdx = self._CurRotateIdx - 1
  local pos = RectTransform.anchoredPosition
  local size = self:GetRevertItemSize(offsetSize, curRotateIdx)
  RectTransform.anchoredPosition = Vector2(pos.x + size[1], pos.y + size[2])
  RectTransform.pivot = Vector2(0.5, 0.5)
  if not noRecaculatePivot then
    self:RecaculateSelectItemPivot()
    self:RefreshDragItemPos()
  end
  self:SetDragStatus(true)
  local itemCfg = Cfg.cfg_season_debris_item({
    ID = self._CurDragItemID
  })[1]
  self._DragIconImage.sprite = self._atlas:GetSprite(itemCfg.GameItemIcon)
  self._SelectIconImage.sprite = self._atlas:GetSprite(itemCfg.UnPutItemIcon)
  self:_GetItemScorePos(self._CurDragItemID, eulerAngle, false)
  local score = self:_GetSpecialItemScore(itemDetail.blockList, itemID)
  self._ScoreTxt:SetText(score)
  self._TotalScore = self._TotalScore - score
  self._TotalScoreTxt:SetText(self._TotalScore .. "/" .. self._MissionScore)
  local finished = self._TotalScore >= self._MissionScore
  self._PostMaskObj:SetActive(not finished)
  self._PassIconsObj:SetActive(finished)
  local sizeDelta = {
    RectTransform.sizeDelta.x,
    RectTransform.sizeDelta.y
  }
  local flip = self._CurRotateIdx & 1 == 0
  if flip then
    sizeDelta[1], sizeDelta[2] = sizeDelta[2], sizeDelta[1]
  end
  self._DragGroupRect.pivot = Vector2(RectTransform.pivot.x, RectTransform.pivot.y)
  self._DragGroupRect.sizeDelta = Vector2(sizeDelta[1], sizeDelta[2])
  self._DragGroup.transform.position = self._DragItem.transform.position
end

function UICN7N36PostInnerGameController:OnGameBlockRelease()
  local atomicItemID = self._CurDragItemAtomicID
  local itemID = self._CurDragItemID
  if self._IsDragingEmptyBlock then
    self._IsDragingEmptyBlock = false
    return
  end
  self:SetDragStatus(false)
  local itemDetail = self._UICN7N36PostPackageGridManager:GetItemDetailOnGridMap(atomicItemID)
  self._ScoreRoot:SetActive(false)
  local eulerAngles = math.floor(self._DragItem.transform.rotation.eulerAngles.z)
  self:_GetItemScorePos(self._CurDragItemID, eulerAngles, false)
  if self._CurHoveredBlock == nil then
    if self:CheckDragInItemPanel() then
      self:SetDragItemSelectStatus(false)
      self:DeleteCurrentSelectGameItem()
    else
      self:SetDragItemSelectStatus(true)
    end
  else
    local pos = Vector2(self._CurHoveredBlock:GetX(), self._CurHoveredBlock:GetY())
    local mainBlockWidget = self._UICN7N36PostPackageGridManager:GetMainMatrixWidget(pos.x, pos.y)
    local result, newAtomicItemID = self._UICN7N36PostPackageGridManager:TryToInsertMainMatrix(itemID, self._CurItemMatrix, mainBlockWidget, self._CurRotateIdx, self._CurDragItemCenter)
    if result then
      self:SetDragItemSelectStatus(false)
      Log.debug("------替换位置放置成功-----")
      self._UICN7N36PostPackageGridManager:RemoveItemDetailInGridMap(atomicItemID)
      local gameObject = self._GameItemObjectMap[atomicItemID]
      self._GameItemObjectMap[atomicItemID] = nil
      UnityEngine.GameObject.Destroy(gameObject)
      itemDetail = self._UICN7N36PostPackageGridManager:GetItemDetailOnGridMap(newAtomicItemID)
      local gameObject = self:CreateItemOnGrid(itemID, pos, itemDetail)
      self._GameItemObjectMap[newAtomicItemID] = gameObject
      self:CheckScore(newAtomicItemID, itemID)
      self._ScoreRoot:SetActive(true)
      self:RefreshItemDownScore()
    else
      self:SetDragItemSelectStatus(true)
    end
  end
  self._UICN7N36PostPackageGridManager:ClearCheckBlocksColor()
  self._CurHoveredBlock = nil
end

function UICN7N36PostInnerGameController:OnGameBlockClick(blockWidget)
  local atomicItemID = blockWidget:GetAtomicItemID()
  if atomicItemID == nil then
    return
  end
  self._ScoreRoot:SetActive(false)
  self:OnGameBlockPress(blockWidget, true)
  self:SetDragStatus(false)
  self:SetDragItemSelectStatus(true)
  self:TryAutoInsertMainMatrix()
  self:_CheckGuide4()
end

function UICN7N36PostInnerGameController:CreateItemOnGrid(itemID, blockCenter, itemDetail)
  local sizeX, sizeY = self._UICN7N36PostPackageGridManager:GetItemSize(itemID)
  local gameItemObj = UnityEngine.GameObject.Instantiate(self._GameItemPrefab, self._MainGridGroupTransform)
  local itemCfg = Cfg.cfg_season_debris_item({ID = itemID})[1]
  local image = gameItemObj:GetComponent("Image")
  image.sprite = self._atlas:GetSprite(itemCfg.GameItemIcon)
  local eulerAngle = self._RotationList[itemDetail.rotationID]
  local pivot
  if not self._CurDragItemCenter then
    local ndcX, ndxY = self._UICN7N36PostPackageGridManager:GetItemNDCCenter(itemID)
    pivot = self:GetItemPivot({ndcX, ndxY}, self._CurRotateIdx)
  else
    local ndcX, ndxY = self._UICN7N36PostPackageGridManager:GetCurrentItemNDCCenter(self._CurItemMatrix, self._CurDragItemCenter)
    pivot = self:GetRevertItemPivot({
      ndcX,
      1 - ndxY
    }, self._CurRotateIdx - 1)
  end
  gameItemObj.transform.localEulerAngles = Vector3(0, 0, eulerAngle)
  local RectTransform = gameItemObj:GetComponent("RectTransform")
  RectTransform.sizeDelta = Vector2(self._UIGridItemSize * sizeX, self._UIGridItemSize * sizeY)
  RectTransform.anchoredPosition = Vector2(blockCenter.y * self._UIGridItemSize, -blockCenter.x * self._UIGridItemSize)
  RectTransform.pivot = Vector2(pivot[1], pivot[2])
  self._DownScore = gameItemObj.transform:Find("DownScore").gameObject
  self._DownScoreTxt = gameItemObj.transform:Find("DownScore/DownScoreTxt"):GetComponent("UILocalizationText")
  self:_GetItemScorePos(itemID, eulerAngle, true)
  self._DownScore:SetActive(true)
  local score = self:_GetSpecialItemScore(itemDetail.blockList, itemID)
  self._DownScoreTxt:SetText(score)
  gameItemObj:SetActive(true)
  return gameItemObj
end

function UICN7N36PostInnerGameController:RotateBtnOnClick()
  if self._IsAnimated then
    return
  end
  self._ScoreRoot:SetActive(false)
  self._CurRotateIdx = self._CurRotateIdx + 1
  self._CurRotateIdx = self._CurRotateIdx > #self._RotationList and 1 or self._CurRotateIdx
  local eulerAngle = self._RotationList[self._CurRotateIdx]
  local RectTransform = self._DragItem:GetComponent("RectTransform")
  RectTransform.pivot = Vector2(0.5, 0.5)
  self._IsAnimated = true
  local eulerAngles = Vector3(0, 0, eulerAngle)
  self:Lock("UICN7N36PostInnerGameController_RotateBtnOnClick")
  self._DragItem.transform:DOLocalRotate(eulerAngles, 0.3):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self._IsAnimated = false
    self:UnLock("UICN7N36PostInnerGameController_RotateBtnOnClick")
  end)
  self._CurItemMatrix = self._UICN7N36PostPackageGridManager:RotateItemClockwise(self._CurItemMatrix)
  self:_GetItemScorePos(self._CurDragItemID, eulerAngle, false)
  local sizeDelta = {
    self._DragItemRect.sizeDelta.x,
    self._DragItemRect.sizeDelta.y
  }
  sizeDelta[1], sizeDelta[2] = sizeDelta[2], sizeDelta[1]
  self._DragGroupRect.pivot = Vector2(0.5, 0.5)
  self._DragGroupRect.sizeDelta = Vector2(sizeDelta[1], sizeDelta[2])
  self._DragGroup.transform.position = self._DragItem.transform.position
  self:TryAutoInsertMainMatrix()
end

function UICN7N36PostInnerGameController:CanAutoInsertSelectItem()
  local eventSystem = UnityEngine.EventSystems.EventSystem.current
  local worldPos = self._DragItem.transform.position
  local screenPos = self._MainGridGameCamera:WorldToScreenPoint(worldPos)
  local pointEventData = UnityEngine.EventSystems.PointerEventData:New(eventSystem)
  pointEventData.position = self._Input.mousePosition
  local raycastResults = UIHelper.CreateEventSystemRaycastResultList()
  eventSystem:RaycastAll(pointEventData, raycastResults)
  for i = 1, raycastResults.Count do
    local go = raycastResults:get_Item(i - 1).gameObject
    if go.name == "rotateBtn" or go.name == "cancelBtn" or go.name == "DragItem" then
      return false
    end
  end
  return true
end

function UICN7N36PostInnerGameController:TryAutoInsertMainMatrix()
  local mx, my = #self._CurItemMatrix[1], #self._CurItemMatrix
  local pivot = {
    1 - 1 / mx / 2,
    1 / my / 2
  }
  local RectTransform = self._DragItem:GetComponent("RectTransform")
  local offsetPivot = {
    pivot[1] - 0.5,
    pivot[2] - 0.5
  }
  local sizeDelta = {
    RectTransform.sizeDelta.x,
    RectTransform.sizeDelta.y
  }
  local flip = self._CurRotateIdx & 1 == 0
  if flip then
    sizeDelta[1], sizeDelta[2] = sizeDelta[2], sizeDelta[1]
  end
  local offsetRect = {
    offsetPivot[1] * sizeDelta[1],
    offsetPivot[2] * sizeDelta[2]
  }
  local scale = UnityEngine.Screen.height / 1080
  local offsetScreent = Vector3(offsetRect[1] * scale, offsetRect[2] * scale, 0)
  local eventSystem = UnityEngine.EventSystems.EventSystem.current
  local worldPos = self._DragItem.transform.position
  local screenPos = self._MainGridGameCamera:WorldToScreenPoint(worldPos) + offsetScreent
  local pointEventData = UnityEngine.EventSystems.PointerEventData:New(eventSystem)
  pointEventData.position = screenPos
  local raycastResults = UIHelper.CreateEventSystemRaycastResultList()
  eventSystem:RaycastAll(pointEventData, raycastResults)
  local itemCfg = Cfg.cfg_season_debris_item({
    ID = self._CurDragItemID
  })[1]
  for i = 1, raycastResults.Count do
    local go = raycastResults:get_Item(i - 1).gameObject
    if go.name == "block(Clone)" then
      local blockWidget = self._UICN7N36PostPackageGridManager:GetWidgetFromGameObjectInstanceID(go:GetInstanceID())
      self._CurHoveredBlock = blockWidget
      self._CurDragItemCenter = {mx, my}
      local result, blockList = self._UICN7N36PostPackageGridManager:CheckItemHoveredOnMainMatrix(self._CurDragItemID, self._CurItemMatrix, blockWidget, self._CurRotateIdx, self._CurDragItemCenter)
      if result then
        self._SelectIconImage.sprite = self._atlas:GetSprite(itemCfg.CanPutItemIcon)
      else
        self._SelectIconImage.sprite = self._atlas:GetSprite(itemCfg.UnPutItemIcon)
      end
      return
    end
  end
  self._CurHoveredBlock = nil
  self._UICN7N36PostPackageGridManager:ClearCheckBlocksColor()
  self._SelectIconImage.sprite = self._atlas:GetSprite(itemCfg.UnPutItemIcon)
end

function UICN7N36PostInnerGameController:RevertSelectItemPivot()
  local dragItemRect = self._DragItem:GetComponent("RectTransform")
  local x, y = dragItemRect.pivot.x - 0.5, dragItemRect.pivot.y - 0.5
  local pos = dragItemRect.anchoredPosition
  local curRotateIdx = self._CurRotateIdx - 1
  local offsetSize = {
    x * dragItemRect.sizeDelta.x,
    y * dragItemRect.sizeDelta.y
  }
  local size = self:GetRevertItemSize(offsetSize, curRotateIdx)
  dragItemRect.anchoredPosition = Vector2(pos.x + size[1], pos.y + size[2])
  dragItemRect.pivot = Vector2(0.5, 0.5)
end

function UICN7N36PostInnerGameController:RecaculateSelectItemPivot()
  local dragItemRect = self._DragItem:GetComponent("RectTransform")
  local curRectPos = dragItemRect.anchoredPosition
  local parentRect = self._DragItem.transform.parent.gameObject:GetComponent("RectTransform")
  local mousePosition = self._Input.mousePosition
  local screenPos = Vector2(mousePosition.x, mousePosition.y)
  local rec, mouseRectPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRect, screenPos, self._MainGridGameCamera, nil)
  local offsetX, offsetY = mouseRectPos.x - curRectPos.x, mouseRectPos.y - curRectPos.y
  local sizeDelta = {
    dragItemRect.sizeDelta.x,
    dragItemRect.sizeDelta.y
  }
  local flip = self._CurRotateIdx & 1 == 0
  if flip then
    sizeDelta[1], sizeDelta[2] = sizeDelta[2], sizeDelta[1]
  end
  local offsetPivotX, offsetPivotY = offsetX / sizeDelta[1], offsetY / sizeDelta[2]
  local curRotateIdx = self._CurRotateIdx - 1
  local cacuPivot = {
    dragItemRect.pivot.x + offsetPivotX,
    dragItemRect.pivot.y + offsetPivotY
  }
  local rotatePivot = self:GetRevertItemPivot(cacuPivot, curRotateIdx)
  dragItemRect.pivot = Vector2(rotatePivot[1], rotatePivot[2])
  local cx, cy = self._UICN7N36PostPackageGridManager:GetCenterFromPivot(self._CurItemMatrix, cacuPivot)
  self._CurDragItemCenter = {cx, cy}
  self._DragGroupRect.pivot = Vector2(cacuPivot[1], cacuPivot[2])
  self._DragGroupRect.sizeDelta = Vector2(sizeDelta[1], sizeDelta[2])
end

function UICN7N36PostInnerGameController:DeleteBtnOnClick()
  self._MainGridGameCamera.depth = self._CurUICameraDepth - 1
  self:ShowDialog("UICN7N36PostGameClosingTipsController", StringTable.Get("str_season_debris_close_tips2"), function()
    self._MainGridGameCamera.depth = self._CurUICameraDepth + 1
  end, function()
    self._MainGridGameCamera.depth = self._CurUICameraDepth + 1
    self:ClearGameMainGrid()
    self:RefreshTotalScore()
  end)
end

function UICN7N36PostInnerGameController:DeleteCancelOnClick()
  self._Transition:PlayLeaveAnimation(true)
  local te = GameGlobal.Timer():AddEvent(333, function()
    self._MainGridGameCamera.depth = self._CurUICameraDepth + 1
    self._DeletePanelObj:SetActive(false)
  end)
  table.insert(self._TimerList, te)
end

function UICN7N36PostInnerGameController:PostBtnOnClick()
  if self._TotalScore < self._MissionScore then
    ToastManager.ShowToast(StringTable.Get("str_season_debris_tips3"))
  else
    if self._IsSelectItem then
      return
    end
    self:Lock("UICN7N36PostInnerGameController_PostBtnOnClick")
    self:StartTask(function(TT)
      local cacheGameRT = self._GameRenderTexture
      self._MainGridRawImageObj:SetActive(false)
      local seasonModule = GameGlobal.GetModule(SeasonModule)
      local hasPassed = seasonModule:GetHasPassedDebris(self._MissionID)
      seasonModule:HandleSeasonDebrisMissionReq(TT, self._MissionID, self._TotalScore)
      self:UnLock("UICN7N36PostInnerGameController_PostBtnOnClick")
      local pos = self._MainGridGameCamera.transform.position
      self._MainGridGameCamera.transform.position = Vector3(0, pos.y, pos.z)
      self:ShowDialog("UICN7N36PostGameClosingController", self._MissionID, cacheGameRT, self._TotalScore, self._MissionCallBack, hasPassed, self._TaskChainCallback)
    end)
  end
end

function UICN7N36PostInnerGameController:GetRevertItemSize(sizeDelta, rotationID)
  local x, y = 0, 0
  if rotationID == 1 then
    x, y = sizeDelta[2], -sizeDelta[1]
  elseif rotationID == 2 then
    x, y = sizeDelta[1], sizeDelta[2]
  elseif rotationID == 3 then
    x, y = -sizeDelta[2], sizeDelta[1]
  else
    x, y = -sizeDelta[1], -sizeDelta[2]
  end
  return {x, y}
end

function UICN7N36PostInnerGameController:GetRevertItemPivot(ndcCenter, rotationID)
  local x, y = 0, 0
  if rotationID == 1 then
    x, y = ndcCenter[2], 1 - ndcCenter[1]
  elseif rotationID == 2 then
    x, y = 1 - ndcCenter[1], 1 - ndcCenter[2]
  elseif rotationID == 3 then
    x, y = 1 - ndcCenter[2], ndcCenter[1]
  else
    x, y = ndcCenter[1], ndcCenter[2]
  end
  return {x, y}
end

function UICN7N36PostInnerGameController:GetItemPivot(ndcCenter, rotationID)
  local x, y = 0, 0
  if rotationID == 1 then
    x, y = ndcCenter[1], 1 - ndcCenter[2]
  elseif rotationID == 2 then
    x, y = 1 - ndcCenter[1], 1 - ndcCenter[2]
  elseif rotationID == 3 then
    x, y = 1 - ndcCenter[1], ndcCenter[2]
  else
    x, y = ndcCenter[1], ndcCenter[2]
  end
  return {x, y}
end

function UICN7N36PostInnerGameController:CacheGameRT(TT, id)
  self._HideGroup:DOFade(0, 0.3)
  YIELD(TT, 300)
  self._Shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera("UICN7N36PostInnerGameController")
  self._Shot.width = UnityEngine.Screen.width
  self._Shot.height = UnityEngine.Screen.height
  local rt = self._Shot:RefreshBlurTexture()
  local cacheRT = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  YIELD(TT)
  UnityEngine.Graphics.Blit(rt, cacheRT)
  UnityEngine.RenderTexture.active = cacheRT
  local tex2d = UnityEngine.Texture2D:New(UnityEngine.Screen.width, UnityEngine.Screen.height)
  tex2d:ReadPixels(UnityEngine.Rect:New(0, 0, UnityEngine.Screen.width, UnityEngine.Screen.height), 0, 0, false)
  tex2d:Apply()
  UnityEngine.RenderTexture.active = nil
  self._Shot:CleanRenderTexture()
  return tex2d
end

function UICN7N36PostInnerGameController:ClearGameMainGrid()
  if self._IsSelectItem then
    self:SetDragItemSelectStatus(false)
    self:DeleteCurrentSelectGameItem()
  end
  for itemID, count in pairs(self._CurItemMap) do
    self._GameItemDic[itemID].count = self._GameItemDic[itemID].count + count
  end
  table.clear(self._CurItemMap)
  self:RefreshItemPanel()
  self._UICN7N36PostPackageGridManager:ClearGrid()
  for _, go in pairs(self._GameItemObjectMap) do
    UnityEngine.GameObject.Destroy(go)
  end
  table.clear(self._GameItemObjectMap)
end

function UICN7N36PostInnerGameController:SetItemToMap(itemID, isAdd)
  if isAdd then
    self._CurItemMap[itemID] = self._CurItemMap[itemID] or 0
    self._CurItemMap[itemID] = self._CurItemMap[itemID] + 1
    self._GameItemDic[itemID].count = self._GameItemDic[itemID].count - 1
  else
    self._CurItemMap[itemID] = self._CurItemMap[itemID] - 1
    self._GameItemDic[itemID].count = self._GameItemDic[itemID].count + 1
  end
  self:RefreshItemPanel(self._CurSelectItemTypeID, true)
end

function UICN7N36PostInnerGameController:QuitOnClick()
  if self:CheckComponentClose() then
    self:SwitchState(UIStateType.UIMain)
  else
    self:SwitchState(UIStateType.UIN27MiniGameController, self._MissionID)
  end
end

function UICN7N36PostInnerGameController:OnHide()
  UnityEngine.Input.multiTouchEnabled = self.originMultiTouch
  self._EndGame = false
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  for _, v in pairs(self._TimerList) do
    GameGlobal.Timer():CancelEvent(v)
  end
  UnityEngine.GameObject.Destroy(self._MainGridReq.Obj)
  self._MainGridReq = nil
  self._GameRenderTexture:Release()
end

function UICN7N36PostInnerGameController:CloseBtnOnClick()
  self:ShowDialog("UICN7N36PostGameClosingTipsController", StringTable.Get("str_season_debris_close_tips1"), nil, function()
    if self._TaskChainCallback then
      self._TaskChainCallback()
    end
    self:CloseDialog()
  end)
end

function UICN7N36PostInnerGameController:CheckScore(atomicItemID, itemID)
  local blockList = self._UICN7N36PostPackageGridManager:GetItemDetailOnGridMap(atomicItemID).blockList
  self:PlayAddScoreTip(blockList, itemID)
  self:RefreshTotalScore()
end

function UICN7N36PostInnerGameController:PlayAddScoreTip(blockList, itemID)
  self._ScoreTipsAnim:Stop()
  local itemScore = self._UICN7N36ScoreManager:GetItemScore(itemID, blockList)
  self._ScoreTipsTxt:SetText("+" .. itemScore)
  self._ScoreTipsAnim:Play("uieff_UICN7N36PostInnerGameController_ScoreTips_in")
end

function UICN7N36PostInnerGameController:_GetSpecialItemScore(blockList, itemID)
  local itemScore = self._UICN7N36ScoreManager:GetItemScore(itemID, blockList)
  return itemScore
end

function UICN7N36PostInnerGameController:_GetItemScorePos(ItemID, eulerAngles, itemPutDown)
  local RotateIdx = 1
  if eulerAngles == 0 then
    RotateIdx = 1
  elseif eulerAngles == 90 then
    RotateIdx = 2
  elseif eulerAngles == 180 then
    RotateIdx = 3
  elseif 160 <= eulerAngles or eulerAngles <= 270 then
    RotateIdx = 4
  end
  local rotation = (RotateIdx - 1) * -90
  local str = "ScoreShow" .. RotateIdx
  local pos = self._RotationPos[ItemID][str]
  if itemPutDown then
    self._DownScore.transform.localEulerAngles = Vector3(0, 0, rotation)
    self._DownScore.transform.anchoredPosition = Vector2(pos[1], pos[2])
  else
    self._ScoreRoot.transform.localEulerAngles = Vector3(0, 0, rotation)
    self._ScoreRoot.transform.anchoredPosition = Vector2(pos[1], pos[2])
  end
end

function UICN7N36PostInnerGameController:RefreshItemDownScore()
  local atomicItemIDMap = self._UICN7N36PostPackageGridManager:GetMainGridItemMap()
  for idx, value in pairs(atomicItemIDMap) do
    local score = self._UICN7N36ScoreManager:GetItemScore(value.itemID, value.blockList)
    local txt = self._GameItemObjectMap[idx].transform:Find("DownScore/DownScoreTxt"):GetComponent("UILocalizationText")
    txt:SetText(score)
  end
end

function UICN7N36PostInnerGameController:RefreshTotalScore()
  self._TotalScore = self._UICN7N36ScoreManager:GetTotalScore()
  self._TotalScoreTxt:SetText(self._TotalScore .. "/" .. self._MissionScore)
  local finished = self._TotalScore >= self._MissionScore
  self._PostMaskObj:SetActive(not finished)
  self._PassIconsObj:SetActive(finished)
end

function UICN7N36PostInnerGameController:GetGuideItem()
  if self._guideItem then
    return self._guideItem:GetGuideGameObject()
  end
  return self:GetGameObject()
end

function UICN7N36PostInnerGameController:GetGuideItemBtn()
  if self._guideItem then
    return self._guideItem:GetGuideGameObjectBtn()
  end
  return self:GetGameObject()
end

function UICN7N36PostInnerGameController:_CheckGuide4()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:GuideInProgress(80030301) then
    local guides = guideModule:GetCurGuides()
    if guides then
      for _, guide in pairs(guides) do
        local curStep = guide:GetCurStep()
        if curStep and curStep.show and curStep.data.step == 4 then
          local cfg = curStep:GetBtnGuideCfg()
          if cfg and cfg.completeRule == GuideCompleteType.OperationComplete then
            GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
            return
          end
        end
      end
    end
  end
end

function UICN7N36PostInnerGameController:CheckInGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  return guideModule:GuideInProgress()
end

function UICN7N36PostInnerGameController:CheckInDragGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:GuideInProgress(80030301) then
    local guides = guideModule:GetCurGuides()
    if guides then
      for _, guide in pairs(guides) do
        local curStep = guide:GetCurStep()
        if curStep and curStep.show and curStep.data.step == 3 then
          local cfg = curStep:GetBtnGuideCfg()
          if cfg and cfg.completeRule == GuideCompleteType.OperationComplete then
            return true
          end
        end
      end
    end
  end
  return false
end

function UICN7N36PostInnerGameController:_CheckGuide56()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:GuideInProgress(80030301) then
    local guides = guideModule:GetCurGuides()
    if guides then
      for _, guide in pairs(guides) do
        local curStep = guide:GetCurStep()
        if curStep and curStep.show and (curStep.data.step == 5 or curStep.data.step == 6) then
          return true
        end
      end
    end
  end
  return false
end
