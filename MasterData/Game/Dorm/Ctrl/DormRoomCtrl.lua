local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormRoomCtrl = class("DormRoomCtrl", DormCtrlBase)
local DormEditRoomData = require("Game.Dorm.Data.DormEditRoomData")
local DormFurnitureData = require("Game.Dorm.Data.DormFurnitureData")
local DormEnum = require("Game.Dorm.DormEnum")
local DormFntBottomEntity = require("Game.Dorm.Entity.DormFntBottomEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_Physics = CS.PhysicsUtility
local CS_MessageCommon = CS.MessageCommon
local CS_DormCameraController = CS.DormCameraController
local CS_GameObject = CS.UnityEngine.GameObject
local CS_UnityUtility = CS.UnityUtility

function DormRoomCtrl:ctor(dormCtrl)
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
  self.__onFingerTap = BindCallback(self, self.OnFingerTap)
  self.__update__handle = BindCallback(self, self.OnUpdate)
  self.__onItemChangeEvent = BindCallback(self, self.OnItemChange)
  self.__onConfirmEditComplete = BindCallback(self, self.ConfirmDormRoomEditComplete)
  self._DmWallPaperLayerIdxChanged = BindCallback(self, self._OnWallpaperLayerIdxChanged)
  self._oldPos = {}
  self._grid = {}
end

function DormRoomCtrl:OnEnterDormRoomStart(roomEntity)
  self.roomEntity = roomEntity
end

function DormRoomCtrl:OnEnterDormRoomEnd(roomEntity)
  CS_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  CS_LeanTouch.OnFingerSet("+", self.__onFingerSet)
  CS_LeanTouch.OnFingerUp("+", self.__onFingerUp)
  CS_LeanTouch.OnFingerTap("+", self.__onFingerTap)
  UpdateManager:AddUpdate(self.__update__handle)
  TimerManager:AddLateCommand(function()
    self:UpdDmRoomWallVisible()
  end)
  self.__wallCheckTime = 0
  self.bind = self.dormCtrl.bind
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemChangeEvent)
  MsgCenter:AddListener(eMsgEventId.DmWallpaperLayerIdxChanged, self._DmWallPaperLayerIdxChanged)
  self.editRoomData = DormEditRoomData.New()
  self.dormCtrl.dormWindow:RefreshDormHeroList()
end

function DormRoomCtrl:ShowDormRoomUI()
  UIManager:ShowWindowAsync(UIWindowTypeID.DormRoom, function(window)
    if window == nil then
      return
    end
    window:InitUIDormRoom(self)
    if self.__autoEnterEditMode then
      self.__autoEnterEditMode = false
      TimerManager:AddLateCommand(function()
        self:EnterDormRoomEdit()
      end)
    end
  end)
end

function DormRoomCtrl:OnExitDormRoomStart(roomEntity)
  if self.roomEntity == nil then
    return
  end
  self.roomEntity:ResetDormRoomWall()
  self.roomEntity:ResetAllFntAniState()
  self.roomEntity = nil
  self.editRoomData = nil
  UIManager:HideWindow(UIWindowTypeID.DormRoom)
  CS_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  CS_LeanTouch.OnFingerSet("-", self.__onFingerSet)
  CS_LeanTouch.OnFingerUp("-", self.__onFingerUp)
  CS_LeanTouch.OnFingerTap("-", self.__onFingerTap)
  UpdateManager:RemoveUpdate(self.__update__handle)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemChangeEvent)
  MsgCenter:RemoveListener(eMsgEventId.DmWallpaperLayerIdxChanged, self._DmWallPaperLayerIdxChanged)
end

function DormRoomCtrl:SetAutoEnterRoomEdit()
  self.__autoEnterEditMode = true
end

function DormRoomCtrl:IsDormFntDrag()
  return self._drag
end

function DormRoomCtrl:OnFingerDown(leanFinger)
  if self.dormCtrl.state ~= DormEnum.eDormState.RoomEdit or leanFinger.IsOverGui then
    return
  end
  local hits = CS_Physics.Raycast(self.bind.camera, 1 << LayerMask.Raycast, true)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) and (hitCollider.tag == TagConsts.DormFurniture or hitCollider.tag == TagConsts.DormFurnitureCollider) then
      local fntEntity = self.roomEntity:GetFntByGo(hitCollider.gameObject)
      self:SelectFntEntity(fntEntity)
      self._fingerId = leanFinger.Index
      self._oldPos.x = fntEntity.fntData.x
      self._oldPos.y = fntEntity.fntData.y
      self._drag = true
      self._dragOffset = nil
      return
    end
  end
end

function DormRoomCtrl:OnFingerSet(leanFinger)
  if not self._drag or self._selectFntEntity == nil or self._fingerId ~= leanFinger.Index or leanFinger.ScreenDelta.x == 0 and leanFinger.ScreenDelta.y == 0 then
    return
  end
  local hits = CS_Physics.Raycast(self.bind.camera, 1 << LayerMask.Raycast)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) then
      local hitPos
      local fntType = self._selectFntEntity.type
      local oldWallIndex
      if DormEnum.IsFntWallType(fntType) and hitCollider.tag == TagConsts.DormWall then
        local ok, wallIndex, hitWallTransform = self.roomEntity:IsDmRoomWall(hits[i].collider.gameObject)
        if not ok then
          goto lbl_191
        end
        local wallHolder = self._selectFntEntity.rootTran.parent
        if hitWallTransform ~= wallHolder and wallIndex ~= self._selectFntEntity.fntData:GetFntParam() then
          oldWallIndex = self._selectFntEntity.fntData:GetFntParam()
          self._selectFntEntity:ChangeDmFntWall(hitWallTransform, wallIndex)
          self:ShowGrid(fntType, wallIndex)
        end
        self._dragOffset = self._dragOffset or self._selectFntEntity.rootTran.position - hits[i].point
        hitPos = hitWallTransform:InverseTransformPoint(hits[i].point + self._dragOffset)
        hitPos.z = 0
      elseif not DormEnum.IsFntWallType(fntType) and hitCollider.tag == TagConsts.DormFloor then
        self._dragOffset = self._dragOffset or self._selectFntEntity.rootTran.position - hits[i].point
        hitPos = self._selectFntEntity.rootTran.parent:InverseTransformPoint(hits[i].point + self._dragOffset)
        hitPos.y = 0
        goto lbl_138
        goto lbl_191
        ::lbl_138::
        local move, oldX, oldY = self._selectFntEntity:SetFntEntityPosFromUnity(hitPos, oldWallIndex ~= nil)
        if move then
          local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
          if roomWin ~= nil then
            roomWin.dmRoomEditNode:DmRoomEditOperateShow(false)
          end
          local doorOldFloorAreaList
          if fntType == DormEnum.eDormFntType.Door then
            doorOldFloorAreaList = self._selectFntEntity:GetFntDoorAreaList(oldX, oldY, oldWallIndex)
          end
          local oldAreaList = self._selectFntEntity:GetFntAreaList(oldX, oldY)
          self.roomEntity:UpdateFntMap(self._selectFntEntity, false, oldAreaList, oldWallIndex, doorOldFloorAreaList)
          self.roomEntity:UpdateFntMap(self._selectFntEntity, true)
          self._edited = true
        end
        break
      end
    end
    ::lbl_191::
  end
end

function DormRoomCtrl:OnFingerUp(leanFinger)
  if not self._drag or self._selectFntEntity == nil or self._fingerId ~= leanFinger.Index then
    return
  end
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    roomWin.dmRoomEditNode:DmRoomEditSelectFntMode(true)
  end
  self._fingerId = nil
  self._drag = false
end

function DormRoomCtrl:OnFingerTap(leanFinger)
  if leanFinger.IsOverGui or leanFinger.StartedOverGui then
    return
  end
  if self._selectFntEntity ~= nil and not self._drag then
    self:DeselectFntEntity()
  end
  if self.dormCtrl.state == DormEnum.eDormState.Room then
    local hits = CS_Physics.Raycast(self.bind.camera, 1 << LayerMask.Raycast, true)
    for i = 0, hits.Length - 1 do
      local hitCollider = hits[i].collider
      if not IsNull(hitCollider) and (hitCollider.tag == TagConsts.DormFurniture or hitCollider.tag == TagConsts.DormFurnitureCollider) then
        local fntEntity = self.roomEntity:GetFntByGo(hitCollider.gameObject)
        fntEntity:StartFntTouch()
        break
      end
    end
  end
end

function DormRoomCtrl:OnUpdate()
  if self._selectFntEntity ~= nil then
    local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
    if roomWin ~= nil then
      roomWin.dmRoomEditNode.dmRoomFntOp:UpdDmRoomFntOpPos(self._selectFntEntity:GetFntEntityCenterTrasform())
    end
  end
  self:__RoomWallCheck()
end

function DormRoomCtrl:__RoomWallCheck()
  self.__wallCheckTime = self.__wallCheckTime - Time.deltaTime
  if self.__wallCheckTime <= 0 then
    self.__wallCheckTime = ConfigData.buildinConfig.DormRoomWallCheck
    self:UpdDmRoomWallVisible()
  end
end

function DormRoomCtrl:UpdDmRoomWallVisible()
  local angle = CS_UnityUtility.GetTargetForwardAngle(CS_DormCameraController.Instance.transform, self.roomEntity.transform)
  if -22.5 <= angle and angle < 22.5 then
    self.roomEntity:Show3Hide1DormRoom(3)
  elseif 22.5 <= angle and angle < 67.5 then
    self.roomEntity:Show2Hide2DormRoom(1, 2, 3, 4)
  elseif 67.5 <= angle and angle < 112.5 then
    self.roomEntity:Show3Hide1DormRoom(4)
  elseif 112.5 <= angle and angle < 157.5 then
    self.roomEntity:Show2Hide2DormRoom(2, 3, 4, 1)
  elseif 157.5 <= angle or angle < -157.5 then
    self.roomEntity:Show3Hide1DormRoom(1)
  elseif -157.5 <= angle and angle < -112.5 then
    self.roomEntity:Show2Hide2DormRoom(3, 4, 1, 2)
  elseif -112.5 <= angle and angle < -67.5 then
    self.roomEntity:Show3Hide1DormRoom(2)
  else
    self.roomEntity:Show2Hide2DormRoom(4, 1, 2, 3)
  end
end

function DormRoomCtrl:SelectFntEntity(fntEntity)
  self._selectFntEntity = fntEntity
  local fntData = fntEntity.fntData
  self:ShowGrid(fntData:GetFntType(), fntData:GetFntParam())
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    local fntName = fntData:GetName()
    local fntType = fntData:GetFntType()
    local showRecycleBtn = not fntData:IsDmFntDoor() or not DormUtil.IsDmRoomDefaultDoorId(fntData.id)
    local notInWall = not DormEnum.IsFntWallType(fntType)
    roomWin.dmRoomEditNode.dmRoomFntOp:InitDmRoomFntOperate(self, fntName, notInWall, showRecycleBtn)
    roomWin.dmRoomEditNode:DmRoomEditSelectFntMode(true)
  end
end

function DormRoomCtrl:DeselectFntEntity()
  if self._selectFntEntity == nil then
    return
  end
  self._selectFntEntity = nil
  self:HideAllGrid()
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    roomWin.dmRoomEditNode:DmRoomEditSelectFntMode(false)
  end
  if self.editWindow ~= nil then
    self.editWindow:UpdateUIDormRoomEdit()
  end
end

function DormRoomCtrl:OnDmRoomWallShow(wallId, isShow)
  if self._selectFntEntity == nil or self._selectFntEntity.fntData:GetFntParam() ~= wallId then
    return
  end
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    roomWin.dmRoomEditNode:DmRoomEditOperateShow(isShow, true)
  end
end

function DormRoomCtrl:ResetFntEntity()
  if self._selectFntEntity == nil then
    return
  end
  self.roomEntity:ResetDmRoomFntEntity(self._selectFntEntity, true)
end

function DormRoomCtrl:OnItemChange(itemUpdate, resourceData)
  if resourceData.backpack == nil then
    return
  end
  if self.editRoomData ~= nil and self.dormCtrl.state == DormEnum.eDormState.RoomEdit then
    self.editRoomData:OnItemChange(itemUpdate, resourceData)
  end
end

function DormRoomCtrl:EnterDormRoomEdit(resetData)
  self.dormCtrl.characterCtrl:EndOperateCharacter()
  if resetData == nil then
    resetData = true
  end
  if resetData then
    self.editRoomData:ResetStorateFntData(true)
  end
  self._recycledFntDic = {}
  self:TryInitGrid()
  self.roomEntity:EnterRoomEditMode(self._grid.floor, self._grid.wall, self)
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    roomWin:OnDRoomEidtMode(true)
  end
  UIUtil.SetTopStatusBtnShow(false, false)
  CS_DormCameraController.Instance:DmRoomEditorEnterTween(true)
  self.dormCtrl:EmitEnterDormRoomEditMode(self.roomEntity)
end

function DormRoomCtrl:GetDmRoomFntConfigStr()
  if self.roomEntity == nil then
    error("self.roomEntity == nil")
    return ""
  end
  local roomData = self.roomEntity.roomData
  local tab = {
    data = roomData:GetFntDatas(),
    wallId = roomData.wallId,
    floorId = roomData.floorId,
    door = roomData.dmRoomDoorData:GetDmFntServerData()
  }
  local str = table.Table2String(tab)
  print(serpent.block(table.String2Table(str)))
  return str
end

function DormRoomCtrl:LoadDmRoomTheme(themeData)
  self._isInLoadTheme = true
  self:ClearAllFnt()
  if themeData.wallId > 0 then
    local fntWarehousedata = self.editRoomData:GetDmStorageFntData(themeData.wallId)
    if fntWarehousedata ~= nil and 0 < fntWarehousedata.count then
      self:InstallFnt(fntWarehousedata)
    end
  end
  if 0 < themeData.floorId then
    local fntWarehousedata = self.editRoomData:GetDmStorageFntData(themeData.floorId)
    if fntWarehousedata ~= nil and 0 < fntWarehousedata.count then
      self:InstallFnt(fntWarehousedata)
    end
  end
  for k, v in ipairs(themeData.data) do
    local fntWarehousedata = self.editRoomData:GetDmStorageFntData(v.id)
    if fntWarehousedata ~= nil and not (0 >= fntWarehousedata.count) then
      self:_SetInstallFntParam(v)
      self:InstallFnt(fntWarehousedata)
    end
  end
  local doorFntWarehousedata = self.editRoomData:GetDmStorageFntData(themeData.door.id)
  if doorFntWarehousedata ~= nil and 0 < doorFntWarehousedata.count then
    self:_SetInstallFntParam(themeData.door)
    self:InstallFnt(doorFntWarehousedata)
  end
  self._isInLoadTheme = false
end

function DormRoomCtrl:ConfirmDormRoomEdit()
  if not self:HasDmRoomEdited() then
    self:ExitDormRoomEdit()
    return
  end
  if self.roomEntity:FntMapOverlap() then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Dorm_FntConfirmEdit))
    return
  end
  local roomData = self.roomEntity.roomData
  local wallId = roomData.wallId
  local floorId = roomData.floorId
  local doorData = roomData.dmRoomDoorData:GetDmFntServerData()
  local houseId = self.dormCtrl.houseCtrl.curHouse.id
  local roomPos = self.roomEntity.spos
  self._newFntDataList = roomData:GetFntDatas(true)
  self.updateDic = self:GetAddAndRemoveDic(roomData)
  self.dormCtrl.dormNetwork:CS_DORM_RoomEdit(houseId, roomPos, self._newFntDataList, wallId, floorId, doorData, self.__onConfirmEditComplete)
end

function DormRoomCtrl:GetAddAndRemoveDic(roomData)
  local newDic = self:__GenFmtDic(roomData, false)
  local oldDic = self:__GenFmtDic(roomData.oldRoomdata, true)
  local updateDic = {}
  for i, v in pairs(newDic) do
    local oldValue = oldDic[i]
    if oldValue then
      if v ~= oldValue then
        updateDic[i] = v - oldValue
      end
    else
      updateDic[i] = v
    end
  end
  for i, v in pairs(oldDic) do
    local newValue = newDic[i]
    if not newValue then
      updateDic[i] = -v
    end
  end
  return updateDic
end

function DormRoomCtrl:__GenFmtDic(roomData, isOld)
  local doorId, dataList
  local wallId = roomData.wallId
  local floorId = roomData.floorId
  if isOld then
    doorId = roomData.door.id
    dataList = roomData.data
  else
    doorId = roomData.dmRoomDoorData:GetDmFntServerData().id
    dataList = roomData:GetFntDatas(true)
  end
  local fmtDic = {}
  fmtDic[doorId] = 1
  fmtDic[wallId] = 1
  fmtDic[floorId] = 1
  for i, v in pairs(dataList) do
    if fmtDic[v.id] then
      fmtDic[v.id] = fmtDic[v.id] + 1
    else
      fmtDic[v.id] = 1
    end
  end
  return fmtDic
end

function DormRoomCtrl:ConfirmDormRoomEditComplete(dataList)
  if dataList.Count == 0 then
    error("dataList.Count == 0")
    return
  end
  local success = dataList[0]
  if success then
    self.roomEntity.roomData:UpdateRoomFntData(self._newFntDataList, false)
    self.roomEntity.roomData:SaveDmRoomData()
    self:ExitDormRoomEdit(true)
  end
  PlayerDataCenter.dormBriefData:UpdateDormBriefFurnitureTotal(self.updateDic)
  self._newFntDataList = nil
end

function DormRoomCtrl:HasDmRoomEdited()
  return self._edited
end

function DormRoomCtrl:ExitDormRoomEdit(editSuccess, fromTopStates)
  if not fromTopStates then
    UIUtil.ForcePopFromBackStack()
  end
  UIUtil.SetTopStatusBtnShow(true, true)
  local restore = false
  if self._edited and not editSuccess then
    self:RestoreDormRoomEdit()
    restore = true
  end
  self._edited = false
  self._selectFntEntity = nil
  self.editWindow = nil
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    roomWin:OnDRoomEidtMode(false)
    if restore then
      roomWin:RefreshDormRoomBaseInfo()
    end
  end
  for fntData, fntEntity in pairs(self._recycledFntDic) do
    fntEntity:OnDelete()
  end
  self._recycledFntDic = nil
  self:RecycleAllGrid()
  self.roomEntity:ExitRoomEditMode(self, editSuccess)
  self.dormCtrl:SetAllBindFntDataDirty()
  CS_DormCameraController.Instance:DmRoomEditorEnterTween(false)
  self.dormCtrl:EmitExitDormRoomEditMode(self.roomEntity, editSuccess)
end

function DormRoomCtrl:RestoreDormRoomEdit()
  if not self._edited then
    return
  end
  local fntObjDic = self.roomEntity:GetFntObjDic()
  local recycleList = {}
  for go, fntEntity in pairs(fntObjDic) do
    if not self.roomEntity:IsOriginDmRoomFnt(fntEntity.fntData) then
      table.insert(recycleList, fntEntity)
    end
  end
  for k, fntEntity in ipairs(recycleList) do
    self:RecycleFnt(fntEntity)
  end
  self.roomEntity:ReinitAllFntEntity()
  self.roomEntity.roomData:DmRoomResetWallpaper()
  self:ResetDmRoomDoor(false, false)
  self.roomEntity:InitFntMapData()
  self:ResetDmRoomFloor()
  self:ResetDmRoomWall()
  self.editRoomData:ResetStorateFntData()
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    roomWin.dmRoomEditNode:ReinitDmRoomtEditData()
  end
  self._recycledFntDic = {}
  self._edited = false
end

function DormRoomCtrl:_OnWallpaperLayerIdxChanged(changeLayerFntDic)
  for fntDt, _ in pairs(changeLayerFntDic) do
    local fEntity = self.roomEntity:GetFntByData(fntDt)
    if fEntity ~= nil then
      fEntity:TryUpdDmFntWallpaperLayer()
    end
  end
end

local function _installFloorFntFunc(self, fntId)
  local fntData = self:_NewFntData(fntId)
  local roomData = self.roomEntity.roomData
  if self._InstallFntParamTab == nil then
    fntData:SetFntPos(roomData:GetRoomGridLengthCount() // 2, roomData:GetRoomGridHeightCount() // 2)
  end
  fntData:CheckOutMap()
  self:InstallFntConfirm(fntData)
end

local _InstallFntFunc = {
  [DormEnum.eDormFntType.FloorDecoration] = _installFloorFntFunc,
  [DormEnum.eDormFntType.WallDecoration] = function(self, fntId)
    local fntData = self:_NewFntData(fntId)
    local roomData = self.roomEntity.roomData
    local wallId = 1
    if self._InstallFntParamTab == nil then
      fntData:SetFntPos(roomData:GetRoomGridLengthCount() // 2, roomData:GetRoomGridHeightCount() // 2)
    else
      wallId = self._InstallFntParamTab.param
    end
    fntData:CheckOutMap()
    self:InstallFntConfirm(fntData, wallId)
  end,
  [DormEnum.eDormFntType.Furniture] = _installFloorFntFunc,
  [DormEnum.eDormFntType.Wall] = function(self, fntId)
    local curId = self.roomEntity.roomData.wallId
    if curId == fntId then
      return
    end
    if fntId == 0 then
      self:ResetDmRoomWall(true)
      return
    end
    self.roomEntity.roomData:SetDmRoomWall(fntId)
    self.roomEntity:ChangeDmRoomWall(fntId)
    self.editRoomData:InstallFntData(fntId)
    if curId ~= 0 then
      self.editRoomData:UninstallFntData(curId)
    end
  end,
  [DormEnum.eDormFntType.Floor] = function(self, fntId)
    local curId = self.roomEntity.roomData.floorId
    if curId == fntId then
      return
    end
    if fntId == 0 then
      self:ResetDmRoomFloor(true)
      return
    end
    self.roomEntity.roomData:SetDmRoomFloor(fntId)
    self.roomEntity:ChangeDmRoomFloor(fntId)
    self.editRoomData:InstallFntData(fntId)
    if curId ~= 0 then
      self.editRoomData:UninstallFntData(curId)
    end
  end,
  [DormEnum.eDormFntType.Door] = function(self, fntId)
    local fntData = self.roomEntity.roomData.dmRoomDoorData
    local curId = fntData.id
    local doorEntity = self.roomEntity:GetFntByData(fntData)
    local doorOldFloorAreaList = doorEntity:GetFntDoorAreaList(fntData.x, fntData.y)
    local oldAreaList = doorEntity:GetFntAreaList(fntData.x, fntData.y)
    local sameDoorId = not fntData:TryFntDoorDataChangeDoor(fntId)
    local oldWallIndex
    if self._InstallFntParamTab ~= nil then
      oldWallIndex = fntData:GetFntParam()
      local x, y = DormUtil.FntCoord2XY(self._InstallFntParamTab.pos)
      local wallId = self._InstallFntParamTab.param
      local wallHolder = self.roomEntity:GetFntHolder(DormEnum.eDormFntType.Door, wallId)
      doorEntity:ChangeDmFntWall(wallHolder, wallId)
      doorEntity:SetFntEntityPos(x, y)
    end
    doorEntity:SetFntEntityPosFromUnity(doorEntity:GetFntEntityLocalPos(), true)
    self.roomEntity:UpdateFntMap(doorEntity, false, oldAreaList, oldWallIndex, doorOldFloorAreaList)
    self.roomEntity:UpdateFntMap(doorEntity, true)
    if sameDoorId then
      return
    end
    if not DormUtil.IsDmRoomDefaultDoorId(fntId) then
      self.editRoomData:InstallFntData(fntId)
    end
    if curId ~= 0 then
      self.editRoomData:UninstallFntData(curId)
    end
    self.roomEntity:ChangeDmRoomDoorGo()
  end,
  [DormEnum.eDormFntType.Wallpaper] = function(self, fntId)
    local roomData = self.roomEntity.roomData
    local fntData = self:_NewFntData(fntId)
    local wallId = 1
    if self._InstallFntParamTab == nil then
      fntData:SetFntPos(roomData:GetRoomGridLengthCount() // 2, roomData:GetRoomGridHeightCount() // 2)
    else
      wallId = self._InstallFntParamTab.param
    end
    fntData:CheckOutMap()
    self.roomEntity.roomData:AddDmWallpaper(fntData, wallId)
    self:InstallFntConfirm(fntData, wallId)
  end
}

function DormRoomCtrl:_NewFntData(fntId)
  local fntData = DormFurnitureData.New()
  fntData:InitFntData(fntId, self.roomEntity.roomData, self._InstallFntParamTab)
  return fntData
end

function DormRoomCtrl:_SetInstallFntParam(paramTab)
  self._InstallFntParamTab = paramTab
end

function DormRoomCtrl:InstallFnt(fntWarehousedata)
  if self.dormCtrl.state == DormEnum.eDormState.Room then
  elseif self.dormCtrl.state == DormEnum.eDormState.RoomEdit then
  else
    return
  end
  local fntId = fntWarehousedata.id
  local fntType = fntWarehousedata.fntCfg.type
  local installFunc = _InstallFntFunc[fntType]
  if installFunc == nil then
    error(string.format("unsurpported fntType, fntType:%s, fntId:%s", fntType, fntId))
    return
  end
  installFunc(self, fntId)
  self._InstallFntParamTab = nil
  self._edited = true
end

function DormRoomCtrl:InstallFntConfirm(fntData, param)
  fntData:SetFntParam(param)
  fntData:RecordOriginalFntData()
  local fntEntity = self.roomEntity:CreateFntEntity(fntData, true)
  local bottomItem = self:GetFntBottomItem()
  fntEntity:AddFntBottom(bottomItem)
  self.editRoomData:InstallFntData(fntData.id)
  self._edited = true
  if not self._isInLoadTheme then
    self:SelectFntEntity(fntEntity)
    local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
    if roomWin ~= nil then
      roomWin.dmRoomEditNode:DmRoomEditSelectFntMode(true)
    end
  end
end

function DormRoomCtrl:RecycleFntSelect()
  if self._selectFntEntity == nil then
    return
  end
  local fntData = self._selectFntEntity.fntData
  if fntData:GetFntType() == DormEnum.eDormFntType.Door then
    self:ResetDmRoomDoor(true, true)
    local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
    if roomWin ~= nil then
      local fntName = fntData:GetName()
      roomWin.dmRoomEditNode.dmRoomFntOp:InitDmRoomFntOperate(self, fntName, false, false)
    end
  else
    self:RecycleFnt(self._selectFntEntity)
    self:DeselectFntEntity()
  end
  self._edited = true
end

function DormRoomCtrl:RecycleFnt(fntEntity, isRemoveAll)
  local fntData = fntEntity.fntData
  if fntData:IsDmFntDoor() then
    warn("Cant recycle fnt door")
    return
  end
  self.editRoomData:UninstallFntData(fntData.id)
  self.roomEntity:RemoveFntEntity(fntEntity, isRemoveAll)
  if self.roomEntity:IsOriginDmRoomFnt(fntEntity.fntData) then
    self._recycledFntDic[fntEntity.fntData] = fntEntity
    fntEntity:OnRecycleOriginFnt()
  else
    local fntBottomItem = fntEntity:RemoveFntBottom()
    if fntBottomItem ~= nil then
      self:RecycleFntBottomItem(fntBottomItem)
    end
    fntEntity:OnDelete()
  end
end

function DormRoomCtrl:ClearAllFnt()
  local fntObjDic = self.roomEntity:GetFntObjDic()
  local recycleList = {}
  for go, fntEntity in pairs(fntObjDic) do
    if not fntEntity.fntData:IsDmFntDoor() then
      table.insert(recycleList, fntEntity)
    end
  end
  for k, fntEntity in ipairs(recycleList) do
    self:RecycleFnt(fntEntity, true)
  end
  self.roomEntity.roomData:DmRoomClearWallpaper()
  self:ResetDmRoomDoor(true)
  self:ResetDmRoomWall(true)
  self:ResetDmRoomFloor(true)
  local roomWin = UIManager:GetWindow(UIWindowTypeID.DormRoom)
  if roomWin ~= nil then
    roomWin.dmRoomEditNode:DmRoomEditSelectFntMode(false)
  end
  self._selectFntEntity = nil
  self._edited = true
end

function DormRoomCtrl:ResetDmRoomWall(isDefault)
  local curWallId = self.roomEntity.roomData.wallId
  local tarWallId = isDefault and 0 or self.roomEntity.roomData:GetDmRoomOldWall()
  if curWallId == tarWallId then
    return
  end
  self.roomEntity.roomData:SetDmRoomWall(tarWallId)
  self.roomEntity:ChangeDmRoomWall(tarWallId)
  if curWallId ~= 0 then
    self.editRoomData:UninstallFntData(curWallId)
  end
end

function DormRoomCtrl:ResetDmRoomFloor(isDefault)
  local curFloorId = self.roomEntity.roomData.floorId
  local tarFloorId = isDefault and 0 or self.roomEntity.roomData:GetDmRoomOldFloor()
  if tarFloorId == curFloorId then
    return
  end
  self.roomEntity.roomData:SetDmRoomFloor(tarFloorId)
  self.roomEntity:ChangeDmRoomFloor(tarFloorId)
  if curFloorId ~= 0 then
    self.editRoomData:UninstallFntData(curFloorId)
  end
end

function DormRoomCtrl:ResetDmRoomDoor(isDefault, onlyGameObject)
  local doorData = self.roomEntity.roomData.dmRoomDoorData
  local curDoorId = doorData.id
  local tarDoorId = isDefault and 0 or self.roomEntity.roomData:GetDmRoomOldDoor()
  if curDoorId ~= tarDoorId then
    if DormUtil.IsDmRoomDefaultDoorId(tarDoorId) then
      tarDoorId = ConfigData.game_config.DmRoomDoorDefaultId
    end
    local installFunc = _InstallFntFunc[DormEnum.eDormFntType.Door]
    installFunc(self, tarDoorId)
  end
  if onlyGameObject then
    return
  end
  local doorEntity = self.roomEntity:GetFntByData(doorData)
  self.roomEntity:ResetDmRoomFntEntity(doorEntity, true)
end

function DormRoomCtrl:RotateFnt()
  if self._selectFntEntity ~= nil then
    self.roomEntity:UpdateFntMap(self._selectFntEntity, false)
    self._selectFntEntity:RotateFntEntity()
    self.roomEntity:UpdateFntMap(self._selectFntEntity, true)
    self._edited = true
  end
end

function DormRoomCtrl:TryInitGrid()
  if IsNull(self._grid.holder) then
    self._grid.holder = CS_GameObject("GridHolder").transform
    self._grid.holder.gameObject:SetActive(false)
    self._grid.floor = self.dormCtrl.comRes.gridFloorPrefab:Instantiate()
    self._grid.floor:SetActive(false)
    self._grid.floorQuad = self._grid.floor.transform:Find("Quad")
    self._grid.wall = {}
    self._grid.wallQuad = {}
    for i = 1, 4 do
      local go = self.dormCtrl.comRes.gridWallPrefab:Instantiate()
      go:SetActive(false)
      self._grid.wallQuad[i] = go.transform:Find("Quad")
      self._grid.wall[i] = go
    end
  end
  local roomLength = self.roomEntity.roomData:GetRoomGridLengthCount()
  local roomHeight = self.roomEntity.roomData:GetRoomGridHeightCount()
  local gridNum = 2
  if IsNull(self._grid.floorQuad) then
    error("Cant find Quad")
  else
    local sizeX = roomLength * ConfigData.game_config.HouseGridWidth
    self._grid.floorQuad.localScale = Vector3.New(sizeX, sizeX, 1)
    local mat = self._grid.floorQuad:FindComponent(eUnityComponentID.MeshRenderer).material
    local matTilingX = roomLength / gridNum
    mat:SetTextureScale("_Maintex", Vector2.New(matTilingX, matTilingX))
  end
  for k, quadTran in ipairs(self._grid.wallQuad) do
    if IsNull(quadTran) then
      error("Cant find Quad")
    else
      local sizeX = roomLength * ConfigData.game_config.HouseGridWidth
      local sizeY = roomHeight * ConfigData.game_config.HouseGridWidth
      quadTran.localScale = Vector3.New(sizeX, sizeY, 1)
      local posY = sizeY / 2
      local posZ = -(sizeX / 2 - 0.01)
      quadTran.localPosition = Vector3.New(0, posY, posZ)
      quadTran:FindComponent(eUnityComponentID.Renderer).material:SetTextureScale("_Maintex", Vector2.New(roomLength / gridNum, roomHeight / gridNum))
    end
  end
end

function DormRoomCtrl:ShowGrid(fntType, fntParam)
  if IsNull(self._grid.holder) then
    return
  end
  self:HideAllGrid()
  self:_ShowGridInternal(fntType, fntParam)
  if fntType == DormEnum.eDormFntType.Door then
    self:_ShowGridInternal(DormEnum.eDormFntType.Furniture)
  end
end

function DormRoomCtrl:_ShowGridInternal(fntType, fntParam)
  local gridGo
  if DormEnum.IsFntWallType(fntType) then
    gridGo = self._grid.wall[fntParam]
  else
    gridGo = self._grid.floor
  end
  gridGo:SetActive(true)
end

function DormRoomCtrl:HideAllGrid()
  if IsNull(self._grid.holder) then
    return
  end
  self._grid.floor:SetActive(false)
  for k, go in pairs(self._grid.wall) do
    go:SetActive(false)
  end
end

function DormRoomCtrl:RecycleAllGrid()
  if IsNull(self._grid.holder) then
    return
  end
  self._grid.floor.transform:SetParent(self._grid.holder, false)
  for k, go in pairs(self._grid.wall) do
    go.transform:SetParent(self._grid.holder, false)
  end
end

function DormRoomCtrl:GetFntBottomItem()
  if self._fntBottom == nil then
    self._fntBottom = {}
    self._fntBottom.pool = {}
    self._fntBottom.holder = CS_GameObject("FntBottom Holder").transform
    self._fntBottom.holder.gameObject:SetActive(false)
  end
  local item
  if #self._fntBottom.pool > 0 then
    item = table.remove(self._fntBottom.pool, 1)
  else
    item = DormFntBottomEntity.New()
    local go = self.dormCtrl.comRes.fntBottomPrefab:Instantiate()
    item:InitFntBottomGo(go)
  end
  return item
end

function DormRoomCtrl:RecycleFntBottomItem(item)
  table.insert(self._fntBottom.pool, item)
  item.transform:SetParent(self._fntBottom.holder, false)
end

function DormRoomCtrl:OnDelete()
  UpdateManager:RemoveUpdate(self.__update__handle)
  if self.roomEntity ~= nil then
    self:OnExitDormRoomStart()
  end
end

return DormRoomCtrl
