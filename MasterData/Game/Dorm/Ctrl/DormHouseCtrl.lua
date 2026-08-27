local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormHouseCtrl = class("DormHouseCtrl", DormCtrlBase)
local DormRoomEntity = require("Game.Dorm.Entity.DormRoomEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local DormRoomData = require("Game.Dorm.Data.DormRoomData")
local DormEditHouseData = require("Game.Dorm.Data.DormEditHouseData")
local DormRoomMoveEffect = require("Game.Dorm.Effect.DormRoomMoveEffect")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local CS_DormCameraCtrl = CS.DormCameraController
local cs_MessageCommon = CS.MessageCommon
local cs_GameObject = CS.UnityEngine.GameObject

function DormHouseCtrl:ctor(dormCtrl)
  self.__onHouseClicked = BindCallback(self, self.OnHouseClicked)
  self.__onD2HTimelineComplete = BindCallback(self, self.OnD2HTimelineComplete)
  self.__onH2DTimelineComplete = BindCallback(self, self.OnH2DTimelineComplete)
  self.__onSelectRoomDragStart = BindCallback(self, self.__SelectRoomDragStart)
  self.__onSelectRoomDragEnd = BindCallback(self, self.__SelectRoomDragEnd)
  self.__onSelectRoomDraging = BindCallback(self, self.__SelectRoomDraging)
  self._OnDmRoomUnlock = BindCallback(self, self.UnlockDmRoom)
  MsgCenter:AddListener(eMsgEventId.DmRoomUnlock, self._OnDmRoomUnlock)
end

function DormHouseCtrl:OnEnterDormScene()
  self.__effectHolder = CS.UnityEngine.GameObject("DormEffectHolder").transform
  self.__effectHolder.position = Vector3.zero
  local prefab = self.dormCtrl.comRes.selectRoomEffectPrefab
  if not IsNull(prefab) then
    self.selectRoomEffect = prefab:Instantiate(self.__effectHolder)
    self.selectRoomEffect:SetActive(false)
  end
  prefab = self.dormCtrl.comRes.moveRoomGoEffectPrefab
  if not IsNull(prefab) then
    local go = prefab:Instantiate(self.__effectHolder)
    go:SetActive(false)
    self.moveRoomGoEffect = DormRoomMoveEffect.New(go)
  end
  local inAlive = 2
  prefab = self.dormCtrl.comRes.moveRoomInEffectPrefab
  self.moveRoomInEffects = {}
  if not IsNull(prefab) then
    for i = 1, inAlive do
      local go = prefab:Instantiate(self.__effectHolder)
      go:SetActive(false)
      local moveRoomInEffect = DormRoomMoveEffect.New(go, true)
      table.insert(self.moveRoomInEffects, moveRoomInEffect)
    end
  end
end

function DormHouseCtrl:EnterDormHouse(dormHouseData, showUnlockFx)
  local curHouse = dormHouseData
  if curHouse == nil or self.curHouse == curHouse then
    return
  end
  self.curHouse = curHouse
  self.bind = self.dormCtrl.bind
  if not curHouse:IsDmHouseUnlockableReaded() then
    PlayerDataCenter.dormBriefData:SetDmHouseUnlockableReaded(curHouse.id)
  end
  if not curHouse:IsDmHouseLock() then
    PlayerDataCenter.dormBriefData:SetDormHouseNewReaded(curHouse.id)
  end
  self.dormCtrl.dormWindow:InitDormMainUI()
  TimerManager:StopTimer(self._waitShowRoomStateUITimer)
  self._waitShowRoomStateUITimer = TimerManager:StartTimer(1, function()
    self._waitShowRoomStateUITimer = nil
    self.dormCtrl.dormWindow:ShowDmStateNode(true)
    self.dormCtrl.dormWindow:RefreshDormStateNode()
  end, nil, true)
  if self.curHouse == nil then
    warn("no one dorm have!!!")
    return
  end
  DestroyUnityObject(self._bgEffectObj)
  local effectPrefab = self.dormCtrl.houseComRes.bgEffectPrefab
  if effectPrefab ~= nil then
    self._bgEffectObj = effectPrefab:Instantiate(self.bind.backGround)
  end
  if not IsNull(self.dormHolder) then
    DestroyUnityObject(self.dormHolder.gameObject)
  end
  self.dormHolder = CS.UnityEngine.GameObject("DormHolder").transform
  self.dormHolder.position = Vector3.zero
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
  end
  self.resloader = CS.ResLoader.Create()
  local houseHexRange = self.curHouse:GetRoomHexRange()
  if houseHexRange <= 0 then
    CS_DormCameraCtrl.Instance:SetDormVirtualCameraTarget(self.bind.dormOneTarget, self.bind.dormOneTarget)
  else
    CS_DormCameraCtrl.Instance:SetDormVirtualCameraTarget(self.bind.dormTarget, self.bind.dormTarget)
  end
  self:__InitHouseEntity(houseHexRange, showUnlockFx)
  self:__GetUnlockRoomData()
  self.dormCtrl:EmitEnterDormHouse()
  self.dormCtrl.dormWindow:RefreshDormHeroList()
end

function DormHouseCtrl:__InitHouseEntity(houseHexRange, showUnlockFx)
  self.roomEnityDic = {}
  CS_DormCameraCtrl.Instance:ClearDormTargetGroup()
  local n = houseHexRange
  for dx = -n, n do
    for dy = math.max(-n, -dx - n), math.min(n, -dx + n) do
      local dz = -dx - dy
      local spos = DormUtil.XYToRoomCoord(dx, dy)
      local roomData = self.curHouse.roomDic[spos]
      if self.dormCtrl:IsSelfDorm() then
        self:AddNewRoom(dx, dy, spos, roomData, showUnlockFx)
      elseif roomData ~= nil then
        self:AddNewRoom(dx, dy, spos, roomData, showUnlockFx)
        if table.count(self.curHouse.roomDic) == 1 and not roomData:IsBigRoomType() then
          self:__AddEmptyCameraTarget(spos)
        end
      end
    end
  end
end

function DormHouseCtrl:__AddEmptyCameraTarget(spos)
  local roomEntity = self.roomEnityDic[spos]
  self.go1 = cs_GameObject()
  self.go1.transform:SetParent(roomEntity.transform)
  self.go1.transform.localPosition = Vector3.Temp(2, 0, 2)
  CS_DormCameraCtrl.Instance:AddDormTargetGroup(self.go1.transform)
  self.go2 = cs_GameObject()
  self.go2.transform:SetParent(roomEntity.transform)
  self.go2.transform.localPosition = Vector3.Temp(-2, 0, -2)
  CS_DormCameraCtrl.Instance:AddDormTargetGroup(self.go2.transform)
end

function DormHouseCtrl:GetCurHouseId()
  return self.curHouse.id
end

function DormHouseCtrl:TryPlayDmAllRoomUnlockFx()
  for k, v in pairs(self.roomEnityDic) do
    v:TryPlayDmRoomUnlockFx()
  end
end

function DormHouseCtrl:AddNewRoom(x, y, spos, roomData, showUnlockFx)
  local roomEntity = DormRoomEntity.New()
  roomEntity:InitHouseData(x, y, spos, roomData)
  self.roomEnityDic[spos] = roomEntity
  roomEntity:LoadRoomEntity(self.dormHolder, self.dormCtrl.houseComRes, self.__onHouseClicked, showUnlockFx)
  CS_DormCameraCtrl.Instance:AddDormTargetGroup(roomEntity.transform)
end

function DormHouseCtrl:UnlockDmRoom(newUnlockDic)
  for houseId, dormHouse in pairs(newUnlockDic) do
    for spos, DormRoom in pairs(dormHouse.data) do
      self:_UnlockRoom(DormRoom, spos, houseId)
    end
  end
end

function DormHouseCtrl:_UnlockRoom(dormRoomMsg, spos, houseId)
  local houseData = self.dormCtrl.allDormData.houseDic[houseId]
  if houseData == nil then
    error("houseData == nil, id:" .. tostring(houseId))
    return
  end
  local houseHexRange = houseData:GetRoomHexRange()
  local roomData = DormRoomData.New()
  roomData:InitRoomData(spos, dormRoomMsg, houseId, houseHexRange)
  houseData:AddHouseRoom(roomData)
  if self.curHouse and houseId ~= self.curHouse.id then
    return
  end
  self._lockRoomDic[spos] = nil
  local roomEntity = self.roomEnityDic[spos]
  if roomEntity == nil then
    error("roomEntity == nil")
    return
  end
  if not roomEntity:IsEmptyRoom() then
    error("roomEntity not IsEmptyRoom")
    return
  end
  CS_DormCameraCtrl.Instance:RemoveDormTargetGroup(roomEntity.transform)
  DestroyUnityObject(roomEntity.gameObject)
  roomEntity:SetDmRoomEntityData(roomData)
  roomEntity:LoadRoomEntity(self.dormHolder, self.dormCtrl.houseComRes, self.__onHouseClicked, true)
  roomEntity:TryPlayDmRoomUnlockFx()
  CS_DormCameraCtrl.Instance:AddDormTargetGroup(roomEntity.transform)
  self.dormCtrl.dormWindow:RefreshDormStateNode()
end

function DormHouseCtrl:_SetRoomCamRotaton2DoorWall(roomEntity)
  local wallId = roomEntity:GetDmRoomDoorWallId()
  CS_DormCameraCtrl.Instance:SetDmRoomViewRotateHorizontal((wallId - 1) * 90)
end

function DormHouseCtrl:OnHouseClicked(roomEntity, auto2Edit)
  if self.curHouse:IsDmHouseLock() then
    self.dormCtrl:TryBuyNewHouse(self.curHouse.id)
    return
  end
  if roomEntity:IsEmptyRoom() then
    local data = self:TryGetRoomLockData(roomEntity.spos)
    if not string.IsNullOrEmpty(data.lockStr) then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(data.lockStr)
    end
    return
  end
  if roomEntity == nil or roomEntity:IsAnyDmFntEntityInLoading() then
    return
  end
  local state = self.dormCtrl:GetDormState()
  if state == DormEnum.eDormState.House then
    if auto2Edit then
      self.dormCtrl.roomCtrl:SetAutoEnterRoomEdit()
      UIManager:ShowWindowAsync(UIWindowTypeID.DormRoom, function(window)
        if window ~= nil then
          window:Hide()
        end
      end)
    end
    local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
    continueWindow:InitContinue(nil, nil, nil, nil, false)
    self.dormCtrl.bind.roomTarget.position = roomEntity.transform.position + self.dormCtrl.bind.roomTarPosOffset
    CS_DormCameraCtrl.Instance:ResetDormRoomView()
    AudioManager:PlayAudioById(1131)
    UIManager:ShowWindowAsync(UIWindowTypeID.SceneChangesMask, function(win)
      if win == nil then
        return
      end
      win:InitSceneChangesMask(function()
        self.dormCtrl.cameraCtrl:EnterRoomCameraState(roomEntity)
        self.dormCtrl.dormWindow:ShowDmStateNode(false)
        self.dormCtrl:EmitEnterDormRoomStart(roomEntity)
        if self.__onD2HTimelineComplete ~= nil then
          self.__onD2HTimelineComplete()
        end
      end, function()
        self.dormCtrl.roomCtrl:ShowDormRoomUI()
      end)
    end)
  elseif state == DormEnum.eDormState.HouseEdit then
    self.curEditSelectRoom = roomEntity
    if not self.curHouse:IsOnlyOneRoom() and self.selectRoomEffect ~= nil then
      self.selectRoomEffect.transform.position = roomEntity.transform.position
      self.selectRoomEffect:SetActive(true)
    end
    local editNode = self.dormCtrl.dormWindow:GetDormEditUI()
    editNode:SelectEditRoom(self, roomEntity)
    editNode:BindRoomMoveAction(self.__onSelectRoomDragStart, self.__onSelectRoomDraging, self.__onSelectRoomDragEnd)
  end
end

function DormHouseCtrl:OnEnterDormHouseEditMode()
  self:__SetRoomEditColliderEnable(true)
end

function DormHouseCtrl:OnExitDormHouseEditMode(success)
  self:__SetRoomEditColliderEnable(false)
  self:CancelSelectRoom()
end

function DormHouseCtrl:OnEnterDormRoomStart(roomEntity)
  for _, re in pairs(self.roomEnityDic) do
    if re ~= roomEntity then
      re:StartHideRoom()
    end
  end
end

function DormHouseCtrl:OnExitDormRoomStart(roomEntity)
  for _, re in pairs(self.roomEnityDic) do
    if re ~= roomEntity then
      re:StartShowRoom()
    end
  end
end

function DormHouseCtrl:CancelSelectRoom()
  if self.curHouse == nil then
    return
  end
  if not self.curHouse:IsOnlyOneRoom() and self.selectRoomEffect ~= nil then
    self.selectRoomEffect:SetActive(false)
  end
  self.curEditSelectRoom = nil
end

function DormHouseCtrl:__SetRoomEditColliderEnable(enable)
  if self.roomEnityDic == nil then
    return
  end
  for k, roomEntity in pairs(self.roomEnityDic) do
    roomEntity:SetEditColliderEnable(enable)
  end
end

function DormHouseCtrl:__ClearRoomMoveEffects()
  self.moveRoomGoEffect:ClearMoveEffect()
  for _, roomEffect in pairs(self.moveRoomInEffects) do
    roomEffect:ClearMoveEffect()
  end
end

function DormHouseCtrl:__SelectRoomDragStart()
  if self.curHouse:IsOnlyOneRoom() then
    return
  end
  if self.curEditSelectRoom == nil then
    return
  end
  self.__destChangeRoom = self.curEditSelectRoom
  self:__ClearRoomMoveEffects()
  self.moveRoomGoEffect.gameObject:SetActive(true)
  self.moveRoomGoEffect.transform.position = self.curEditSelectRoom.transform.position
  self.moveRoomGoEffect:StartPlayShow()
end

function DormHouseCtrl:__SelectRoomDraging(obj)
  if self.curHouse:IsOnlyOneRoom() then
    return
  end
  if IsNull(obj) then
    self.__destChangeRoom = nil
    self.moveRoomInEffects[1]:StartHideShow()
    return
  end
  local curRoomEntiy
  for k, roomEntity in pairs(self.roomEnityDic) do
    if roomEntity.gameObject == obj then
      curRoomEntiy = roomEntity
    end
  end
  if self.__destChangeRoom == curRoomEntiy then
    return
  end
  self.__destChangeRoom = curRoomEntiy
  self.moveRoomInEffects[1]:StartHideShow()
  if curRoomEntiy == nil or curRoomEntiy == self.curEditSelectRoom then
    return
  end
  local moveRoomEffect = table.remove(self.moveRoomInEffects)
  moveRoomEffect.gameObject:SetActive(true)
  moveRoomEffect.transform.position = self.__destChangeRoom.transform.position
  moveRoomEffect:StartPlayShow()
  table.insert(self.moveRoomInEffects, 1, moveRoomEffect)
end

function DormHouseCtrl:__SelectRoomDragEnd(obj)
  if self.curHouse:IsOnlyOneRoom() then
    return
  end
  self.moveRoomGoEffect:StartHideShow()
  self.moveRoomInEffects[1]:StartHideShow()
  self.__destChangeRoom = nil
  if IsNull(obj) then
    self.dormCtrl.dormWindow:GetDormEditUI():ResetMoveRoomUI()
    return
  end
  for k, roomEntity in pairs(self.roomEnityDic) do
    if not roomEntity:IsEmptyRoom() and roomEntity.gameObject == obj then
      if roomEntity == self.curEditSelectRoom then
        break
      end
      self:RequestRoomExChange(self.curEditSelectRoom, roomEntity)
      return
    end
  end
  self.dormCtrl.dormWindow:GetDormEditUI():ResetMoveRoomUI()
end

function DormHouseCtrl:RequestRoomExChange(originRoom, targetRoom)
  self.dormCtrl.dormWindow:GetDormEditUI():UnSelectEditRoom(false)
  self:CancelSelectRoom()
  local pos1, pos2 = originRoom.spos, targetRoom.spos
  originRoom:ChangeDormRoomPos(pos2)
  targetRoom:ChangeDormRoomPos(pos1)
  self.roomEnityDic[pos2] = originRoom
  self.roomEnityDic[pos1] = targetRoom
  self.curHouse:SwapHousePos(pos1, pos2)
  self.dormCtrl.dormNetwork:CS_DORM_RoomExchangePos(self:GetCurHouseId(), pos1, pos2)
end

function DormHouseCtrl:RequestCurRoomRename(completeAction)
  if self.curEditSelectRoom == nil then
    warn("cur edti room is null to rename")
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRename, function(renameWindow)
    if renameWindow == nil or self.curEditSelectRoom == nil then
      return
    end
    renameWindow:InitCommonRename(function(name)
      self.dormCtrl.dormNetwork:CS_DORM_RenameRoom(self:GetCurHouseId(), self.curEditSelectRoom.spos, name, function()
        if self.curEditSelectRoom ~= nil then
          self.curEditSelectRoom.roomData:SetRoomName(name)
        end
        UIUtil.PopFromBackStackByWinId(UIWindowTypeID.CommonRename)
        UIManager:DeleteWindow(UIWindowTypeID.CommonRename)
        if completeAction ~= nil then
          completeAction()
        end
      end)
    end)
  end)
end

function DormHouseCtrl:ConfirmHouseEdit()
  self.dormCtrl.dormNetwork:CS_DORM_HouseEdit(self.editHouseData)
end

function DormHouseCtrl:RecvHouseEdit(success, prefabUpdate)
  if success then
    self.editHouseData:ApplyModifyHouseData(prefabUpdate, self.dormCtrl.allDormData, self.roomEnityDic)
    self.dormCtrl:SetAllBindFntDataDirty()
    self.dormCtrl.dormWindow:RefreshDormHeroList()
    self:ExitDormEditMode(true)
  else
    self:CancelHouseEdit()
  end
  self.editHouseData = nil
  self.curEditSelectRoom = nil
end

function DormHouseCtrl:CancelHouseEdit()
  self.editHouseData = nil
  self.curEditSelectRoom = nil
  for spos, roomEntity in pairs(self.roomEnityDic) do
    local roomData = self.curHouse.roomDic[spos]
    if roomData ~= roomEntity.roomData then
      CS_DormCameraCtrl.Instance:RemoveDormTargetGroup(roomEntity.transform)
      DestroyUnityObject(roomEntity.gameObject)
      self:AddNewRoom(roomEntity.x, roomEntity.y, roomEntity.spos, roomData)
    end
  end
  self:ExitDormEditMode(false)
end

function DormHouseCtrl:ExitDormEditMode(successSave)
  self:__ClearRoomMoveEffects()
  self.dormCtrl:EmitExitDormHouseEditMode(successSave)
end

function DormHouseCtrl:ExitRoom()
  self.dormCtrl.characterCtrl:EndOperateCharacter()
  local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
  continueWindow:InitContinue(nil, nil, nil, nil, false)
  AudioManager:PlayAudioById(1132)
  UIManager:ShowWindowAsync(UIWindowTypeID.SceneChangesMask, function(win)
    if win == nil then
      return
    end
    win:InitSceneChangesMask(function()
      self.dormCtrl.cameraCtrl:EnterHouseCameraState()
      self.dormCtrl:EmitExitDormRoomStart()
    end, self.__onH2DTimelineComplete)
  end)
end

function DormHouseCtrl:OnD2HTimelineComplete(pd)
  self._houseRoomCo = nil
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  UIUtil.SetTopStatus(self, self.__ClickReturnInRoom, nil, DormEnum.ShowRoomInfoFunc)
  self.dormCtrl:EmitEnterDormRoomEnd()
end

function DormHouseCtrl:__ClickReturnInRoom()
  if self.dormCtrl.state == DormEnum.eDormState.Room then
    self:ExitRoom()
  end
end

function DormHouseCtrl:OnH2DTimelineComplete(pd)
  self._houseRoomCo = nil
  self.dormCtrl.dormWindow:ShowDmStateNode(true)
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  self.dormCtrl:EmitExitDormRoomEnd()
  self.dormCtrl.dormWindow:RefreshDormHeroList()
  CS_DormCameraCtrl.Instance:ResetDormRoomView()
end

function DormHouseCtrl:RandEnterNextDormRoom()
  local roomEntity = self.dormCtrl:GetCurRoomEntity()
  if roomEntity == nil then
    error("[RandEnterNextDormRoom] cur Room is nil,state:" .. tostring(self.dormCtrl:GetDormState()))
    return
  end
  local count = self.curHouse:GetRoomCount()
  local index = math.random(count - 1)
  local i = 1
  local nextRoomEntity
  for spos, tmpRoom in pairs(self.roomEnityDic) do
    if tmpRoom ~= roomEntity and not tmpRoom:IsEmptyRoom() then
      if i == index then
        nextRoomEntity = tmpRoom
        break
      end
      i = i + 1
    end
  end
  local selfUserId = self.dormCtrl:GetSelfUserId()
  self:EnterDormRoom(selfUserId, nextRoomEntity)
end

function DormHouseCtrl:EnterDormRoom(userId, roomEntity)
  if roomEntity == nil then
    error("[EnterDormRoom] Room is nil,state:" .. tostring(self.dormCtrl:GetDormState()))
    return
  end
  roomEntity:StartShowRoom()
  self.dormCtrl:EmitExitDormRoomStart(true)
  self.dormCtrl.bind.roomTarget.position = roomEntity.transform.position + self.dormCtrl.bind.roomTarPosOffset
  CS_DormCameraCtrl.Instance:ResetDormRoomView()
  self.dormCtrl:EmitEnterDormRoomStart(roomEntity)
  self.dormCtrl:EmitEnterDormRoomEnd()
end

function DormHouseCtrl:GetDmRoomEntityByPos(pos)
  return self.roomEnityDic[pos]
end

function DormHouseCtrl:__GetUnlockRoomData()
  self._lockRoomDic = {}
  local houseType = self.curHouse:GetRoomHexRange()
  local houseUnlockCfg = ConfigData.dorm_room_unlock[self.curHouse.id]
  if houseUnlockCfg == nil then
    error("Cant get dorm_room_unlock cfg, houseId:" .. tostring(self.curHouse.id))
    return
  end
  local needUnlock = false
  local dic = {}
  local n = houseType
  if self.dormCtrl:IsSelfDorm() then
    for dx = -n, n do
      for dy = math.max(-n, -dx - n), math.min(n, -dx + n) do
        local dz = -dx - dy
        local spos = DormUtil.XYToRoomCoord(dx, dy)
        local roomData = self.curHouse.roomDic[spos]
        if roomData == nil then
          local roomEntity = self:GetDmRoomEntityByPos(spos)
          if roomEntity ~= nil then
            local index = DormUtil.GetRoomIndexByRoomposToxy(dx, dy, houseType)
            local unlockCfg = houseUnlockCfg[index]
            if self:CheckDormUnlock(unlockCfg) then
              needUnlock = true
            end
            local lockStr = self:GetDormUnlockStr(unlockCfg)
            dic[spos] = {lockStr = lockStr, roomEntity = roomEntity}
          end
        end
      end
    end
  end
  if needUnlock then
    local dormNetwork = NetworkManager:GetNetwork(NetworkTypeID.Dorm)
    dormNetwork:CS_DORM_BriefDetailWhenUnlock()
  end
  self._lockRoomDic = dic
end

function DormHouseCtrl:CheckDormUnlock(unlockCfg)
  if unlockCfg.unlock_logic > 0 and not UnlockCenter:UnlockCheck(unlockCfg.unlock_logic, unlockCfg.unlock_para1) then
    return false
  end
  for k, v in ipairs(unlockCfg.pre_condition) do
    local unlock = CheckCondition.CheckLua({
      unlockCfg.pre_condition[k]
    }, {
      unlockCfg.pre_para1[k]
    }, {
      unlockCfg.pre_para2[k]
    })
    if not unlock then
      return false
    end
  end
  return true
end

function DormHouseCtrl:GetDormUnlockStr(unlockCfg)
  local lockStr
  local curIndex = 0
  for k, v in ipairs(unlockCfg.pre_condition) do
    curIndex = k
    if v == CheckerTypeId.CompleteStage then
      break
    end
  end
  if 0 < curIndex then
    lockStr = CheckCondition.GetUnlockInfoLua({
      unlockCfg.pre_condition[curIndex]
    }, {
      unlockCfg.pre_para1[curIndex]
    }, {
      unlockCfg.pre_para2[curIndex]
    })
  end
  if string.IsNullOrEmpty(lockStr) then
    lockStr = 0 < unlockCfg.unlock_logic and UnlockCenter:GetUnlockElemDes(unlockCfg.unlock_logic, unlockCfg.unlock_para1)
  end
  return lockStr
end

function DormHouseCtrl:TryGetRoomLockData(spos)
  return self._lockRoomDic[spos]
end

function DormHouseCtrl:GetLockRoomDic()
  return self._lockRoomDic
end

function DormHouseCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.DmRoomUnlock, self._OnDmRoomUnlock)
  if self._houseRoomCo ~= nil then
    TimelineUtil.StopTlCo(self._houseRoomCo)
    self._houseRoomCo = nil
  end
  for k, v in pairs(self.roomEnityDic) do
    v:OnDelete()
  end
  DestroyUnityObject(self.go1)
  self.go1 = nil
  DestroyUnityObject(self.go2)
  self.go2 = nil
  self:__ClearRoomMoveEffects()
  self.roomEnityDic = nil
  self.dormHolder = nil
  if self._waitShowRoomStateUITimer ~= nil then
    TimerManager:StopTimer(self._waitShowRoomStateUITimer)
    self._waitShowRoomStateUITimer = nil
  end
end

return DormHouseCtrl
