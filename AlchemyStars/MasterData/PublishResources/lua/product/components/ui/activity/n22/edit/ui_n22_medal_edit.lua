_class("UIN22MedalEdit", UIController)
UIN22MedalEdit = UIN22MedalEdit

function UIN22MedalEdit:Constructor()
  self.mMedal = GameGlobal.GetModule(MedalModule)
  self.data = self.mMedal:GetN22MedalEditData()
  self.data:Init()
  self.filter = 0
  self.curDragPosition = Vector2.zero
  self.whBoard = Vector2.zero
end

function UIN22MedalEdit:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnMedalGroupApply, self.SetBoardAndMedalList)
  self.camera = GameGlobal.UIStateManager():GetControllerCamera("UIN22MedalEdit")
  local isOpenInHomeland = false
  if uiParams[1] then
    isOpenInHomeland = uiParams[1]
  end
  if uiParams[2] then
    self._closeCallback = uiParams[2]
  end
  self.anim = self:GetUIComponent("Animation", "SafeArea")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self.data:IsDirty() then
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_medal_edit_close_hint"), function()
        self:CloseDialog()
      end, nil, function()
      end, nil)
    else
      self:CloseDialog()
    end
  end, nil, nil, isOpenInHomeland)
  self.ImgRotate = self:GetGameObject("ImgRotate")
  self.ImgTakeIn = self:GetGameObject("ImgTakeIn")
  self.ImgClear = self:GetGameObject("ImgClear")
  self.ImgSave = self:GetGameObject("ImgSave")
  self.imgBoard = self:GetUIComponent("RawImageLoader", "imgBoard")
  self.rtBoard = self:GetUIComponent("RectTransform", "imgBoard")
  self.whBoard.x = self.rtBoard.rect.width
  self.whBoard.y = self.rtBoard.rect.height
  self.poolBoard = self:GetUIComponent("UISelectObjectPath", "poolBoard")
  self.txtFilter = self:GetUIComponent("UILocalizationText", "txtFilter")
  self._sr = self:GetUIComponent("ScrollRect", "sv")
  self._svHelper = H3DScrollViewHelper:New(self, "sv", "UIN22MedalEditItem", function(index, ui)
    local item = self.list[index]
    ui:Flush(item)
    return ui
  end, nil, nil)
  self._svHelper:SetCalcScale(false)
  self._svHelper:SetEndSnappingCallback(nil)
  self._svHelper:SetItemPassSnapPosCallback(nil)
  self.goList = self:GetGameObject("goList")
  self:SetCurBoardMedalId(0)
  self:FlushBoard()
  self:FlushList()
end

function UIN22MedalEdit:OnHide()
  self.imgBoard:DestoryLastImage()
  if self._closeCallback then
    self._closeCallback()
  end
end

function UIN22MedalEdit:FlushBoard()
  local curBoardId = self._groupSaveBoard or self.data:GetBoardId()
  local boardIconHD = UIN22MedalEdit.GetMedalBoardBgHd(curBoardId)
  self.imgBoard:LoadImage(boardIconHD)
  local len = table.count(self.data.boardMedals)
  self.poolBoard:SpawnObjects("UIN22MedalEditBoardItem", len)
  local uis = self.poolBoard:GetAllSpawnList()
  for i, boardMedal in ipairs(self.data.boardMedals) do
    local ui = uis[i]
    ui:Flush(boardMedal.id, self)
  end
end

function UIN22MedalEdit:FlushList()
  self.listData = UIMedalListData:New()
  local client_medal_info = self.mMedal:GetMedalVec()
  self.listData:Init(client_medal_info)
  local filterData = self.listData:GetFilterInfoById(self.filter)
  local name = filterData.Name
  self.txtFilter:SetText(StringTable.Get(name))
  local listAll = self.listData:GetItemsByFilter(self.filter)
  self.list = {}
  for _, item in ipairs(listAll) do
    if item:IsReceive() then
      local id = item:GetID()
      local boardMedal = self.data:GetBoardMedalById(id)
      if boardMedal then
      else
        table.insert(self.list, item)
      end
    end
  end
  self._svHelper:Dispose()
  self._svHelper:SetItemName("UIN22MedalEditItem")
  self._svHelper:SetShowFunction(function(index, ui)
    local item = self.list[index]
    local id = item:GetID()
    ui:Init(self.rtBoard, self)
    ui:Flush(item)
    return ui
  end)
  local len = table.count(self.list)
  self._svHelper:Init(len, 0, Vector2(0, 0))
  self._sr.horizontalNormalizedPosition = 0
end

function UIN22MedalEdit:FlushSelectBoarMedal(id)
  local uis = self.poolBoard:GetAllSpawnList()
  for j, ui2 in ipairs(uis) do
    ui2:FlushSelect(id)
  end
end

function UIN22MedalEdit:FlushSelectBoarMedalWithoutAnim(id)
  local uis = self.poolBoard:GetAllSpawnList()
  for j, ui2 in ipairs(uis) do
    ui2:FlushSelectWithoutAnim(id)
  end
end

function UIN22MedalEdit:FlushRotateTakeInButton(isShow)
  self.ImgRotate:SetActive(isShow)
  self.ImgTakeIn:SetActive(isShow)
end

function UIN22MedalEdit:InsertMedal(id)
  local bm = BoardMedal:New(id)
  bm.index = table.count(self.data.boardMedals) + 1
  bm.pos = Vector2.zero
  bm.quat = Quaternion.identity
  bm.wh = Vector2.one
  table.insert(self.data.boardMedals, bm)
  self:FlushBoard()
  self:SetCurBoardMedalId(id)
end

function UIN22MedalEdit:SetBoardAndMedalList(groupid, medallist, boardid)
  Log.debug("###[UIN22MedalEdit] SetBoardAndMedalList groupid:", groupid, "|boardid:", boardid)
  if boardid then
    self._groupSaveBoard = boardid
  else
    self._groupSaveBoard = nil
  end
  self:ChangeMedalList(medallist)
end

function UIN22MedalEdit:ChangeMedalList(list)
  table.clear(self.data.boardMedals)
  self:SetCurBoardMedalId(0)
  for index, cfg in ipairs(list) do
    local id = cfg[1]
    local posx = cfg[2]
    local posy = cfg[3]
    local rot = cfg[4]
    local bm = BoardMedal:New(id)
    bm.index = table.count(self.data.boardMedals) + 1
    bm.pos = Vector2(posx, posy)
    bm.quat = Quaternion.Euler(0, 0, rot)
    bm.wh = Vector2.one
    table.insert(self.data.boardMedals, bm)
    Log.debug("###[UIN22MedalEdit] SetBoardAndMedalList medalid:", id)
  end
  self.data:FormatBoardMedalIndex()
  self:FlushBoard()
  self:FlushList()
end

function UIN22MedalEdit:BoardItem2List(idList)
  if not idList or table.count(idList) <= 0 then
    return
  end
  for _, id in ipairs(idList) do
    local boardMedal = self.data:GetBoardMedalById(id)
    table.removev(self.data.boardMedals, boardMedal)
    if id == self.curBoardMedalId then
      self:SetCurBoardMedalId(0)
    end
  end
  self.data:FormatBoardMedalIndex()
  self:FlushBoard()
  self:FlushList()
end

function UIN22MedalEdit:ClampBoardMedalUI(id)
  if self:IsBoardMedalOutOfBoard(id) then
    self:BoardItem2List({id})
  elseif self:IsBoardInvolveBoardMedal(id) then
  else
    local aabbBoard = UIN22MedalEdit.GetAABBOfRectTransform(self.rtBoard)
    local uiBoardMedal = self:GetBoardMedalById(id)
    local aabbBoardMedal = uiBoardMedal:AABB()
    local v2Offset = Vector2.zero
    if aabbBoardMedal.min.x < aabbBoard.min.x then
      v2Offset.x = aabbBoard.min.x - aabbBoardMedal.min.x
    elseif aabbBoardMedal.max.x > aabbBoard.max.x then
      v2Offset.x = aabbBoard.max.x - aabbBoardMedal.max.x
    end
    if aabbBoardMedal.min.y < aabbBoard.min.y then
      v2Offset.y = aabbBoard.min.y - aabbBoardMedal.min.y
    elseif aabbBoardMedal.max.y > aabbBoard.max.y then
      v2Offset.y = aabbBoard.max.y - aabbBoardMedal.max.y
    end
    local uiBoardMedal = self:GetBoardMedalById(id)
    local vector2TargetPos = uiBoardMedal:AnchoredPosition() + v2Offset
    uiBoardMedal:FlushPos(vector2TargetPos)
  end
end

function UIN22MedalEdit.GetAABBOfRectTransform(rt)
  local aabb = MedalAABB:New()
  local halfW = rt.rect.width * 0.5
  local halfH = rt.rect.height * 0.5
  local verts = {
    rt.localRotation * Vector2(-halfW, -halfH) + rt.anchoredPosition,
    rt.localRotation * Vector2(-halfW, halfH) + rt.anchoredPosition,
    rt.localRotation * Vector2(halfW, halfH) + rt.anchoredPosition,
    rt.localRotation * Vector2(halfW, -halfH) + rt.anchoredPosition
  }
  aabb:InitByPoints(verts)
  return aabb
end

function UIN22MedalEdit:IsBoardMedalOutOfBoard(id)
  local uiBoardMedal = self:GetBoardMedalById(id)
  local center = uiBoardMedal:AnchoredPosition()
  local aabb = UIN22MedalEdit.GetAABBOfRectTransform(self.rtBoard)
  if aabb:ContainsPoint(center) then
    return false
  end
  return true
end

function UIN22MedalEdit:IsBoardInvolveBoardMedal(id)
  local uiBoardMedal = self:GetBoardMedalById(id)
  local aabb = UIN22MedalEdit.GetAABBOfRectTransform(self.rtBoard)
  if aabb:InvolveAABB(uiBoardMedal:AABB()) then
    return true
  end
  return false
end

function UIN22MedalEdit:OnUpdate(deltaTimeMS)
  if not self.isDraggingMedal then
    return
  end
  if not self.curBoardMedalUI then
    Log.warn("### curBoardMedalUI nil. ")
    return
  end
  self.curBoardMedalUI:FlushPos(self.curDragPosition)
end

function UIN22MedalEdit:SetCurBoardMedalId(curBoardMedalId, curBoardMedalUI)
  self.curBoardMedalId = curBoardMedalId
  if curBoardMedalUI then
    self.curBoardMedalUI = curBoardMedalUI
  else
    self.curBoardMedalUI = self:GetBoardMedalById(curBoardMedalId)
  end
  self:FlushSelectBoarMedal(curBoardMedalId)
  if curBoardMedalId and 0 < curBoardMedalId then
    self:FlushRotateTakeInButton(true)
  else
    self:FlushRotateTakeInButton(false)
  end
end

function UIN22MedalEdit:GetIsDraggingMedal()
  return self.isDraggingMedal
end

function UIN22MedalEdit:SetIsDraggingMedal(isDraggingMedal)
  self.isDraggingMedal = isDraggingMedal
  self._sr.enabled = not isDraggingMedal
end

function UIN22MedalEdit:SetCurDragPosition(curDragPosition)
  self.curDragPosition = curDragPosition
end

function UIN22MedalEdit:SetCurDragScreenPosition(posScreen)
  local posWorld = self:GetWorldPositionByScreenPosition(posScreen)
  local posLocal = self:GetLocalPositionByWorldPosition(posWorld)
  self.curDragPosition.x = posLocal.x
  self.curDragPosition.y = posLocal.y
end

function UIN22MedalEdit:ImgRotateOnClick(go)
  local ui = self:GetSelectBoardMedal()
  if ui then
    self:ShowDialog("UIN22MedalEditRotate", ui, self)
  end
end

function UIN22MedalEdit:ImgTakeInOnClick(go)
  self:BoardItem2List({
    self.curBoardMedalId
  })
end

function UIN22MedalEdit:ImgClearOnClick(go)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_medal_clear_board_medal"), function()
    local t = {}
    for index, boardMedal in ipairs(self.data.boardMedals) do
      table.insert(t, boardMedal.id)
    end
    self:BoardItem2List(t)
  end, nil, function()
  end, nil)
end

function UIN22MedalEdit:BoardExchange()
  local placement_infoSer = self.mMedal:GetPlacementInfo()
  if self._groupSaveBoard and placement_infoSer.board_back_id ~= self._groupSaveBoard then
    return true
  end
  return false
end

function UIN22MedalEdit:ImgSaveOnClick(go)
  if not self.data:IsDirty() and not self:BoardExchange() then
    return
  end
  local len = table.count(self.data.boardMedals)
  local limit = self.data:GetBoardMedalLimit()
  if len > limit then
    ToastManager.ShowToast(StringTable.Get("str_medal_board_medal_limit_hint", limit))
    return
  end
  self:StartTask(function(TT)
    local key = "UIN22MedalEditImgSaveOnClick"
    self:Lock(key)
    self.data:FormatBoardMedalIndex()
    local placement_infoSer = self.mMedal:GetPlacementInfo()
    local placement_info = medal_placement_info:New()
    placement_info.board_back_id = self._groupSaveBoard or placement_infoSer.board_back_id
    placement_info.medal_on_board = {}
    for _, boardMedal in pairs(self.data.boardMedals) do
      local medalUIData = medal_position:New()
      medalUIData.x = boardMedal.pos.x
      medalUIData.y = boardMedal.pos.y
      medalUIData.z = boardMedal.index
      medalUIData.w = boardMedal.wh.x
      medalUIData.h = boardMedal.wh.y
      medalUIData.quatx = boardMedal.quat.x
      medalUIData.quaty = boardMedal.quat.y
      medalUIData.quatz = boardMedal.quat.z
      medalUIData.quatw = boardMedal.quat.w
      placement_info.medal_on_board[boardMedal.id] = medalUIData
    end
    local res = self.mMedal:ReqSaveMedal(TT, placement_info)
    if N22MedalEditData.CheckCode(res) then
      ToastManager.ShowToast(StringTable.Get("str_medal_save_board_medal"))
      self.data:Init()
      self:SetCurBoardMedalId(0)
      self:FlushSelectBoarMedalWithoutAnim(0)
      self:FlushBoard()
      self:FlushList()
    end
    self:UnLock(key)
  end)
end

function UIN22MedalEdit:ImgChangeOnClick(go)
  local curBoardId = self.data:GetBoardId()
  self:ShowDialog("UIN22MedalChangeBoard", curBoardId, function()
    self._groupSaveBoard = nil
    self:FlushBoard()
  end)
end

function UIN22MedalEdit:ImgFilterOnClick(go)
  self.anim:Play("uieff_UIN22MedalEdit_in")
  self:ShowDialog("UIN22MedalFilter", self.listData, self.filter, function(filter)
    self.filter = filter
    self:FlushList()
  end)
end

function UIN22MedalEdit:GetSelectBoardMedal()
  local uis = self.poolBoard:GetAllSpawnList()
  for index, ui in ipairs(uis) do
    if ui:IsSelect() then
      return ui
    end
  end
end

function UIN22MedalEdit:GetBoardMedalById(id)
  local uis = self.poolBoard:GetAllSpawnList()
  for index, ui in ipairs(uis) do
    if ui:Id() == id then
      return ui
    end
  end
end

function UIN22MedalEdit:GetWorldPositionByScreenPosition(posScreen)
  local posWorld = UIHelper.ScreenPointToWorldPointInRectangle(self.rtBoard, posScreen, self.camera)
  return posWorld
end

function UIN22MedalEdit:GetLocalPositionByWorldPosition(posWorld)
  local posLocal = self.rtBoard:InverseTransformPoint(posWorld)
  return posLocal
end

function UIN22MedalEdit:GetBoardWidthHeight()
  return self.whBoard
end

function UIN22MedalEdit.GetMedalBoardBgHd(boardId)
  local cfgv = Cfg.cfg_item_medal_board[boardId]
  if cfgv then
    return cfgv.IconHD
  end
  return ""
end

function UIN22MedalEdit:ApplyBtnOnClick(go)
  local all = UIMedalGroupApply.GetAllCollectAnyGroup()
  if all and next(all) then
    self:ShowDialog("UIMedalGroupApply")
  else
    local tips = StringTable.Get("str_medal_group_open_apply_fail")
    ToastManager.ShowToast(tips)
  end
end
