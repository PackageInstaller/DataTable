local this = {}

function this:req_enterHome(creator_id, callBack)
  if creator_id == nil then
    creator_id = L_PlayerStore:getPlayerId()
  end
  local data = {creator_id = creator_id}
  L_Net:sendMessage(MsgGenCode.CSProtoEnterHome, data, function(rspData)
    if callBack then
      callBack()
    end
  end)
end

function this:req_exitHome(callBack)
  L_Net:sendMessage(MsgGenCode.CSProtoWorldQuitHome, nil, function(rspData, errorCode)
    if errorCode == 0 and callBack then
      callBack()
    end
  end)
end

function this:req_levelUpMainBuilding(homeId, callBack)
  local data = {u32 = homeId}
  L_Net:sendMessage(MsgGenCode.CSProtoMainBuildLvUp, data, function(rspData, errorCode)
    if errorCode == 0 and callBack then
      callBack()
    end
  end)
end

function this:req_buildCreate(guid, build_id, block_id, anchor, direction, callBack)
  local data
  if guid then
    data = {guid = guid}
  else
    local dataLocate = {
      block_id = block_id,
      anchor = math.floor(anchor),
      direction = direction
    }
    data = {build_id = build_id, locate = dataLocate}
  end
  L_Net:sendMessage(MsgGenCode.CSProtoBuildCreate, data, function(rspData)
    if callBack then
      callBack(rspData)
    end
  end)
end

function this:req_locateBuilding(guid, build_id, block_id, anchor, direction, callBack)
  local dataLocate = {
    block_id = block_id,
    anchor = math.floor(anchor),
    direction = direction
  }
  local data = {
    guid = guid,
    build_id = build_id,
    locate = dataLocate
  }
  AzurWorld.HomeMgr:ReqLocateBuilding(guid, build_id, block_id, anchor, direction, callBack)
end

function this:req_BuildUnlocate(guid, callBack)
  local data = {guid = guid}
  AzurWorld.HomeMgr.PerformanceModule:SetIsPlayerActivelyChangeSetPass()
  L_Net:sendMessage(MsgGenCode.CSProtoBuildUnlocate, data, function(rspData, errorCode)
    if errorCode ~= L_Const.errorCode.ErrCodeSucc then
      return
    end
    if self.data.buildingDatas[guid] then
      self.data.buildingDatas[guid] = nil
    end
    if callBack then
      callBack()
    end
  end)
end

function this:req_changeBelt(type, list, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoHomeShortcutChange, {
    shortcut_bar = {
      {type = type, item_id = list}
    }
  }, callback)
end

function this:rsp_syncBuildingBag(data)
  for _, v in pairs(data) do
    if not math.isEmpty(v.build_id) then
      self.data.buildingBag[v.build_id] = self.data.buildingBag[v.build_id] or require(L_R.store .. "home.data.homeBuildingInfo").new()
      local entity = self.data.buildingBag[v.build_id]
      entity.build_id = v.build_id
      entity.total_num = v.total_num
      entity.used_num = v.used_num
      entity.unlock = v.unlock
    end
  end
  self:call(self.event.refreshBuildingBag)
end

function this:rsp_generalInfo(data)
  self:call(self.event.refreshHomePetInfo)
  if data.home_name == nil then
    return
  end
  self.data.homeName = data.home_name
  self:call(self.event.refreshHomeInfo)
end

function this:rsp_syncHomeBelt(data)
  for _, belt in ipairs(data) do
    self.data.beltItems[belt.type] = belt.item_id
  end
  printf("家园快捷栏物品id", self.data.beltItems)
  self:call(self.event.refreshBelt)
end

function this:rsp_syncHomeBuilding(homeBuilds, delBuilds)
  local hadChange = false
  for _, buildData in ipairs(homeBuilds) do
    local buildType = buildData.build_type
    if buildType ~= L_Const.WorldMapBuildType.WMBT_RANCH and buildType ~= L_Const.WorldMapBuildType.WMBT_WILD_COLLECT and buildData.build_id > 0 then
      hadChange = true
      self.data.buildingDatas[buildData.guid] = buildData
      setmetatable(buildData, {
        __newindex = function(t, k, v)
          errorf("不要往store数据里放奇怪的对象！！")
        end
      })
    end
  end
  if not table.isEmpty(delBuilds) then
    for _, v in ipairs(delBuilds) do
      self.data.buildingDatas[v] = nil
    end
  end
  if hadChange then
    self:call(self.event.syncWorldMapHomeItem)
  end
  if hadChange or not table.isEmpty(delBuilds) then
    L_ProductStore:call(L_ProductStore.event.refreshHomeProduct)
    self:call(self.event.refreshBuildPetWorkState, homeBuilds)
  end
end

function this:clearMap()
  self.data.buildingDatas = {}
end

function this:rsp_syncHomeUnlock(data)
  local flag = false
  for _, v in ipairs(data.infos) do
    if v.type == L_HomeConst.HomeLevelUnlockModuleType.Block then
      self.data.tempUnlockBlock[v.id] = true
    end
  end
  self:call(self.event.syncHomeContentUnlock)
end

function this:rsp_CSProtoHomeBuildLoginSync(data, errcode, init)
  L_SatietyStore:initSatietyServer()
end

function this:syncHomeMapDatas()
end

function this:req_modifyHomeName(name, callback)
  local data = {name = name}
  L_Net:sendMessage(MsgGenCode.CSProtoSetHomeName, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
    elseif errorCode == L_Const.errorCode.ErrCodeInvalidNick then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_idcard_4"))
    end
  end)
end

function this:rsp_petEatingFinishNotify(data, errcode)
  if errcode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  self:call(self.event.refreshPetEatFinishList, data)
end

function this:reqPetStationHomeHub(petGuid)
  local csHomeStore = L_HomeStore:getCsHomeStore()
  csHomeStore:ReqPetStationHomeHub(petGuid)
end

function this:reqPetExitHomeHub(petGuid, cb)
  local csHomeStore = L_HomeStore:getCsHomeStore()
  csHomeStore:ReqPetExitHomeHub(petGuid, cb)
end

function this:reqChangeHomeHubBuildingPos(homeHubTabType, sourcePos, targetPos)
  local csHomeStore = L_HomeStore:getCsHomeStore()
  csHomeStore:ReqChangeHomeHubBuildingPos(homeHubTabType, sourcePos, targetPos)
end

function this:reqReceiveAllBuildingDataInHomeCenter()
  local csHomeStore = self:getCsHomeStore()
  csHomeStore:ReqReceiveAllBuildingDataInHomeCenter()
end

function this:req_enterDorm(heroGuid, buildingGuid, callBack)
  if heroGuid == nil then
    errorf("请设置进入的角色Id")
    return
  end
  buildingGuid = buildingGuid or 0
  local data = {hero_id = heroGuid, build_guid = buildingGuid}
  L_Net:sendMessage(MsgGenCode.CSProtoHomeDormEnter, data, function(rspData)
    if callBack then
      callBack()
    end
  end)
end

function this:req_exitDorm(callBack)
  L_Net:sendMessage(MsgGenCode.CSProtoHomeDormQuit, nil, function(rspData, errorCode)
    if errorCode == 0 and callBack then
      callBack()
    end
  end)
end

return this
