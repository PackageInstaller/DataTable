_class("UICN13PerfectPuzzleMainGameController", UIController)
UICN13PerfectPuzzleMainGameController = UICN13PerfectPuzzleMainGameController

function UICN13PerfectPuzzleMainGameController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UICN13PerfectPuzzleMainGameController:OnShow(uiParams)
  self.missionId = uiParams[1]
  self.missionCfg = Cfg.cfg_cn13_client_mission[self.missionId]
  self._component = uiParams[2]
  self._componentInfo = self._component:GetComponentInfo()
  self._cfg = uiParams[3]
  self._campaign = uiParams[4]
  self:InitWidget()
  self:InitUI()
  self.anim:Play("uianim_UICN13PerfectPuzzleMainGameController_unlock")
end

function UICN13PerfectPuzzleMainGameController:InitWidget()
  self.anim = self:GetUIComponent("Animation", "Anim")
  self.roadPointGuide = self:GetGameObject("RoadPointGuide")
  self.totalPieceCountText = self:GetUIComponent("UILocalizationText", "TotalPieceCountText")
  self.unLockPuzzleBtn = self:GetUIComponent("Image", "UnLockPuzzleBtn")
  self.originViewBtn = self:GetUIComponent("Image", "OriginViewBtn")
  self.titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self.needPieceText = self:GetUIComponent("UILocalizationText", "NeedPieceText")
  self.needPiece = self:GetGameObject("NeedPiece")
  self.lockObj = self:GetGameObject("Lock")
  self.lockObj:SetActive(false)
  self.puzzlePieceRoot = self:GetUIComponent("UISelectObjectPath", "PuzzlePieceRoot")
  self.puzzlePieceRootObj = self:GetGameObject("PuzzlePieceRoot")
  self.puzzlePieceRootObj:SetActive(true)
  self.successTitleText = self:GetUIComponent("UILocalizationText", "SuccessTitleText")
  self.successRoot = self:GetGameObject("SuccessRoot")
  self.successRoot:SetActive(false)
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  self.closeSuccRootBtnObj = self:GetGameObject("CloseSuccRootBtn")
  self.closeSuccRootBtnObj:SetActive(false)
  self.successfulObj = self:GetGameObject("successful")
  self.successfulObj:SetActive(false)
  self.rightTop = self:GetUIComponent("RectTransform", "RightTop")
end

function UICN13PerfectPuzzleMainGameController:InitUI()
  self.backBtns:SetData(function()
    if self.missionStateType ~= 1 then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PerfectPuzzleEntryRefresh)
      self:CloseDialog()
      return
    end
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_luckland_back_tips"), function(param)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PerfectPuzzleEntryRefresh)
      self:CloseDialog()
    end, nil, nil, nil)
  end, nil, nil, true, nil, false, nil)
  local originPieces = self._cfg.OriginPiecePos
  local veCount = #originPieces
  local hoCount = #originPieces[1]
  local totalCount = veCount * hoCount
  self.pieceDataList = {}
  for i = 1, veCount do
    for j = 1, hoCount do
      local pieceName = originPieces[i][j]
      local data = CN13PerfectPuzzlePieceItemData:New()
      data:Init(pieceName, i, j, veCount, hoCount)
      self.pieceDataList[#self.pieceDataList + 1] = data
    end
  end
  local puzzleList = self._cfg.PuzzlePiece
  local vePuzzleCount = #puzzleList
  local hoPuzzleCount = #puzzleList[1]
  self.sucPieceDataList = {}
  for i = 1, vePuzzleCount do
    for j = 1, hoPuzzleCount do
      local pieceName = puzzleList[i][j]
      local data = CN13PerfectPuzzlePieceItemData:New()
      data:Init(pieceName, i, j, veCount, hoCount)
      self.sucPieceDataList[#self.sucPieceDataList + 1] = data
    end
  end
  self:InitBaseUI()
  self.selectComboPiece = {}
  self.pieceItemList = {}
  self._pieceGameArea = UIWidgetHelper.SpawnObjects(self, "PuzzlePieceRoot", "UICN13PuzzlePieceItem", totalCount)
  for i = 1, #self._pieceGameArea do
    local uiitem = self._pieceGameArea[i]
    self.pieceItemList[#self.pieceItemList + 1] = uiitem
    local data = self.pieceDataList[i]
    uiitem:SetData(i, data, function(uiitem)
      if #self.selectComboPiece == 0 then
        self.selectComboPiece[1] = uiitem
      elseif #self.selectComboPiece == 1 then
        if self.selectComboPiece[1].pieceData ~= uiitem.pieceData then
          local datax = self.selectComboPiece[1].pieceData.hoIndex
          local datay = self.selectComboPiece[1].pieceData.verIndex
          local data2x = uiitem.pieceData.hoIndex
          local data2y = uiitem.pieceData.verIndex
          local index1 = self.selectComboPiece[1].index
          local index2 = uiitem.index
          local itemPer1 = self.pieceItemList[index1]
          local itemPer2 = self.pieceItemList[index2]
          self.pieceItemList[index1] = itemPer2
          self.pieceItemList[index2] = itemPer1
          self.selectComboPiece[1]:TransPiece(data2x, data2y, index2)
          uiitem:TransPiece(datax, datay, index1)
          self.selectComboPiece[1] = nil
          self:CheckGameSuc()
        else
          self.selectComboPiece[1] = nil
          uiitem:CancleCurPiece()
        end
      elseif #self.selectComboPiece > 1 then
      end
    end)
  end
end

function UICN13PerfectPuzzleMainGameController:InitBaseUI()
  self.costId = 3000386
  self.missionStateType = -1
  self.itemModule = GameGlobal.GetModule(ItemModule)
  local curCount = self.itemModule:GetItemCount(self.costId)
  local notLockItem = true
  local unlockItem = self._cfg.UnlockItem
  if unlockItem ~= nil and #unlockItem ~= 0 then
    local needCount = unlockItem[1][2]
    if curCount >= needCount then
      self.needPieceText:SetText(needCount)
    else
      local str = "<color=#FF0000>" .. needCount .. "</color>"
      self.needPieceText:SetText(str)
    end
    notLockItem = false
  end
  self.totalPieceCountText:SetText(curCount)
  self.titleText:SetText(StringTable.Get(self._cfg.Name))
  self.successTitleText:SetText(StringTable.Get(self._cfg.Name))
  if self:CheckLock() and not notLockItem then
    self.lockObj:SetActive(true)
    self.successRoot:SetActive(false)
    self.needPiece:SetActive(true)
    self.unLockPuzzleBtn.gameObject:SetActive(true)
    self.originViewBtn.gameObject:SetActive(false)
    self.missionStateType = 0
  elseif self:CheckComplete() then
    self.lockObj:SetActive(false)
    self.successRoot:SetActive(true)
    self.needPiece:SetActive(false)
    self.unLockPuzzleBtn.gameObject:SetActive(false)
    self.originViewBtn.gameObject:SetActive(false)
    self.titleText.gameObject:SetActive(false)
    self.puzzlePieceRootObj:SetActive(false)
    self.successRoot:SetActive(true)
    self.successfulObj:SetActive(true)
    self._pieceGameArea_suc = UIWidgetHelper.SpawnObjects(self, "SuccessRoot", "UICN13PuzzlePieceItem", #self.sucPieceDataList)
    for i = 1, #self._pieceGameArea_suc do
      local uiitem = self._pieceGameArea_suc[i]
      local data = self.sucPieceDataList[i]
      uiitem:SetData(i, data)
    end
    self.missionStateType = 2
  else
    self.lockObj:SetActive(false)
    self.successRoot:SetActive(false)
    self.needPiece:SetActive(false)
    self.unLockPuzzleBtn.gameObject:SetActive(false)
    self.originViewBtn.gameObject:SetActive(true)
    self.missionStateType = 1
  end
end

function UICN13PerfectPuzzleMainGameController:CheckLock()
  local lock = true
  if self._componentInfo.m_unlock_missions == nil then
    return true
  end
  for i = 1, #self._componentInfo.m_unlock_missions do
    local id = self._componentInfo.m_unlock_missions[i]
    if id == self._cfg.MissionID then
      lock = false
    end
  end
  return lock
end

function UICN13PerfectPuzzleMainGameController:CheckComplete()
  local complete = false
  if self._componentInfo.m_pass_mission_info == nil then
    return false
  end
  local passInfo = self._componentInfo.m_pass_mission_info[self._cfg.MissionID]
  if passInfo ~= nil then
    complete = true
  end
  return complete
end

function UICN13PerfectPuzzleMainGameController:CheckGameSuc()
  local suc = true
  for i = 1, #self.pieceItemList do
    local res = self.pieceItemList[i].pieceData.resName
    local sucRes = self.sucPieceDataList[i].resName
    if res ~= sucRes then
      suc = false
    end
  end
  if suc then
    self.gameSucTaskID = self:StartTask(self.Task_GameSuc, self)
  end
end

function UICN13PerfectPuzzleMainGameController:Task_TrasnPieceShow(TT)
  self:Lock("UICN13PerfectPuzzleMainGameController:Task_TrasnPieceShow")
  self:UnLock("UICN13PerfectPuzzleMainGameController:Task_TrasnPieceShow")
end

function UICN13PerfectPuzzleMainGameController:Task_GameSuc(TT)
  self:Lock("UICN13PerfectPuzzleMainGameController:Task_GameSuc")
  local res = AsyncRequestRes:New()
  self._component:HandleCompletePerfectPuzzle(TT, res, self.missionId, 0)
  self.anim:Play("uianim_UICN13PerfectPuzzleMainGameController_succesfull")
  YIELD(TT, 1000)
  self.successRoot:SetActive(true)
  self._pieceGameArea_suc = UIWidgetHelper.SpawnObjects(self, "SuccessRoot", "UICN13PuzzlePieceItem", #self.sucPieceDataList)
  for i = 1, #self._pieceGameArea_suc do
    local uiitem = self._pieceGameArea_suc[i]
    local data = self.sucPieceDataList[i]
    uiitem:SetData(i, data)
  end
  self.anim:Play("uianim_UICN13PerfectPuzzleMainGameController_midlle_in")
  if res:GetSucc() then
    YIELD(TT, 1000)
    self:UnLock("UICN13PerfectPuzzleMainGameController:Task_GameSuc")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PerfectPuzzleEntryRefresh)
    self:CloseDialog()
    return
  else
    self:UnLock("UICN13PerfectPuzzleMainGameController:Task_GameSuc")
    self:CloseDialog()
  end
end

function UICN13PerfectPuzzleMainGameController:Task_UnLockMission(TT)
  self.anim:Play("uianim_UICN13PerfectPuzzleMainGameController_unlock_click")
  self:Lock("UICN13PerfectPuzzleMainGameController:Task_UnLockMission")
  local res = AsyncRequestRes:New()
  self._component:HandleUnlockPerfectPuzzle(TT, res, self.missionId)
  YIELD(TT, 250)
  if res:GetSucc() then
    self:UnLock("UICN13PerfectPuzzleMainGameController:Task_UnLockMission")
    self:RefreshUnlockMission()
    return
  else
    Log.error("解锁失败")
    self:UnLock("UICN13PerfectPuzzleMainGameController:Task_UnLockMission")
  end
end

function UICN13PerfectPuzzleMainGameController:RefreshUnlockMission()
  self.lockObj:SetActive(false)
  self.successRoot:SetActive(false)
  self.needPiece:SetActive(false)
  self.unLockPuzzleBtn.gameObject:SetActive(false)
  self.originViewBtn.gameObject:SetActive(true)
  local curCount = self.itemModule:GetItemCount(self.costId)
  self.totalPieceCountText:SetText(curCount)
end

function UICN13PerfectPuzzleMainGameController:ActivityTipsbtnOnClick(go)
  self:ShowDialog("UICN13PerfectPuzzleIntro")
end

function UICN13PerfectPuzzleMainGameController:UnLockPuzzleBtnOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    self:CloseDialog()
    return
  end
  self.itemModule = GameGlobal.GetModule(ItemModule)
  local curCount = self.itemModule:GetItemCount(self.costId)
  local unlockItem = self._cfg.UnlockItem
  if unlockItem ~= nil and #unlockItem ~= 0 then
    local needCount = unlockItem[1][2]
    if curCount >= needCount then
      self.gameUnLockTaskID = self:StartTask(self.Task_UnLockMission, self)
    else
      ToastManager.ShowToast(StringTable.Get("str_cn13_PerfectPuzzle_cost_uncan"))
    end
  end
end

function UICN13PerfectPuzzleMainGameController:OriginViewBtnOnClick(go)
  self.successRoot:SetActive(true)
  self.closeSuccRootBtnObj:SetActive(true)
  self._pieceGameArea_suc = UIWidgetHelper.SpawnObjects(self, "SuccessRoot", "UICN13PuzzlePieceItem", #self.sucPieceDataList)
  for i = 1, #self._pieceGameArea_suc do
    local uiitem = self._pieceGameArea_suc[i]
    local data = self.sucPieceDataList[i]
    uiitem:SetData(i, data)
  end
  self.anim:Play("uianim_UICN13PerfectPuzzleMainGameController_midlle_in")
end

function UICN13PerfectPuzzleMainGameController:CloseSuccRootBtnOnClick(go)
  if self.successRoot.gameObject.activeSelf then
    self.anim:Play("uianim_UICN13PerfectPuzzleMainGameController_midlle_out")
    GameGlobal.Timer():AddEvent(400, function()
      self.successRoot:SetActive(false)
      self.closeSuccRootBtnObj:SetActive(false)
    end)
  end
end

function UICN13PerfectPuzzleMainGameController:PieceCountRootOnClick(go)
  local pos = go.transform.position - self.rightTop.transform.position
  UITopTipsContext:PopupTips(self.costId, Vector2(-120, 30), pos)
end
