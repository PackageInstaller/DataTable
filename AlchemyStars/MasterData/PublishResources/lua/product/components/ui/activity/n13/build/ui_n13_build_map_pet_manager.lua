_class("UIN13BuildMapPetManager", Object)
UIN13BuildMapPetManager = UIN13BuildMapPetManager
local EUIN13MapPetState = {
  Fixed = 1,
  Unfixed = 2,
  Leave = 3,
  Spare = 4
}
_enum("EUIN13MapPetState", EUIN13MapPetState)

function UIN13BuildMapPetManager:Constructor(petData, nodeData, nodeObjs, spawnCallback, fixedCallback, picnicNodesCallback, btnCallback)
  self._petData = petData
  self._nodeData = nodeData
  self._nodeObjs = nodeObjs
  local petSetting = Cfg.cfg_n13_map_pet_setting[1]
  self._petCount = table.count(self._petData)
  self._petActiveCount = petSetting.PetActiveCount
  self._petStepLimit = petSetting.PetStepLimit
  self._nodePicnicPointList = {}
  self._nodeStartPointList = {}
  self._nodeNormalPointList = {}
  self._nodeUsedMap = {}
  self:_InitNode(picnicNodesCallback)
  self._fixedCallback = fixedCallback
  self._btnCallback = btnCallback
  self._petObjMap = self:_InitPetObjMap(spawnCallback)
  self._petIdList = self:_InitPetIdList(self._petObjMap)
  self:SetShowDebug(false)
  self:_Refresh()
end

function UIN13BuildMapPetManager:_Refresh()
  self:_SetDebugState()
end

function UIN13BuildMapPetManager:_InitNode(picnicNodesCallback)
  local picnicNodes = picnicNodesCallback()
  local nodeIdList = self._nodeData:GetNodeIdList()
  for _, v in ipairs(nodeIdList) do
    local node = self._nodeData:GetNode(v)
    if picnicNodes[node.ID] then
      table.insert(self._nodePicnicPointList, v)
    elseif node.Type == 1 then
      table.insert(self._nodeStartPointList, v)
    else
      table.insert(self._nodeNormalPointList, v)
      self._nodeUsedMap[v] = 0
    end
  end
  if #self._nodeStartPointList == 0 then
    Log.exception("UIN13BuildMapPetManager:_InitNode() self._nodeStartPointList == 0")
  end
  if #self._nodeNormalPointList < self._petActiveCount then
    Log.exception("UIN13BuildMapPetManager:_InitNode() #self._nodeNormalPointList < self._petActiveCount")
  end
end

function UIN13BuildMapPetManager:_InitPetObjMap(spawnCallback)
  local tb = {}
  local petIdList = self:_GetSortedIDList(self._petData)
  local objs = spawnCallback(#petIdList)
  for i, v in ipairs(petIdList) do
    tb[v] = objs[i]
  end
  return tb
end

function UIN13BuildMapPetManager:_InitPetIdList(objMap)
  local fixedPetIdList = self:_GetFixedPetIdList()
  local unfixedPetIdList, sparePetIdList = self:_GetUnfixedPetIDList(fixedPetIdList)
  for _, v in ipairs(fixedPetIdList) do
    self:_PetObj_Init(objMap[v], v)
  end
  for _, v in ipairs(unfixedPetIdList) do
    self:_PetObj_Init(objMap[v], v)
  end
  for _, v in ipairs(sparePetIdList) do
    self:_PetObj_Init(objMap[v], v, true)
  end
  local tb = {
    [EUIN13MapPetState.Fixed] = fixedPetIdList,
    [EUIN13MapPetState.Unfixed] = unfixedPetIdList,
    [EUIN13MapPetState.Leave] = {},
    [EUIN13MapPetState.Spare] = sparePetIdList
  }
  return tb
end

function UIN13BuildMapPetManager:_GetFixedPetIdList()
  if self._fixedCallback then
    return self._fixedCallback()
  end
  return {}
end

function UIN13BuildMapPetManager:_GetUnfixedPetIDList(fixedList)
  local petIdList = self:_GetSortedIDList(self._petData)
  table.shuffle(petIdList)
  local fixed = table.reverse(fixedList)
  local count = self._petActiveCount - #fixedList
  local unfixed = {}
  while count > #unfixed and petIdList[1] do
    if not fixed[petIdList[1]] then
      table.insert(unfixed, petIdList[1])
    end
    table.remove(petIdList, 1)
  end
  local spare = {}
  while petIdList[1] do
    if not fixed[petIdList[1]] then
      table.insert(spare, petIdList[1])
    end
    table.remove(petIdList, 1)
  end
  return unfixed, spare
end

function UIN13BuildMapPetManager:Start()
  for _, v in ipairs(self._petIdList[EUIN13MapPetState.Fixed]) do
    self:_PetObj_Start(v)
  end
  for _, v in ipairs(self._petIdList[EUIN13MapPetState.Unfixed]) do
    self:_PetObj_Start(v)
  end
end

function UIN13BuildMapPetManager:ChangeFixedPet()
  local newFixedPetIdList = self:_GetFixedPetIdList()
  return self:_ChangePet(newFixedPetIdList)
end

function UIN13BuildMapPetManager:_ChangePet(newFixedPetIdList)
  local oldFixedPetIdList = table.collect(self._petIdList[EUIN13MapPetState.Fixed])
  for _, v in ipairs(oldFixedPetIdList) do
    if not table.icontains(newFixedPetIdList, v) then
      table.removev(self._petIdList[EUIN13MapPetState.Fixed], v)
      table.insert(self._petIdList[EUIN13MapPetState.Unfixed], v)
    end
  end
  for _, v in ipairs(newFixedPetIdList) do
    if not table.icontains(oldFixedPetIdList, v) then
      if table.icontains(self._petIdList[EUIN13MapPetState.Unfixed], v) then
        table.removev(self._petIdList[EUIN13MapPetState.Unfixed], v)
      elseif table.icontains(self._petIdList[EUIN13MapPetState.Leave], v) then
        table.removev(self._petIdList[EUIN13MapPetState.Leave], v)
      elseif table.icontains(self._petIdList[EUIN13MapPetState.Spare], v) then
        table.removev(self._petIdList[EUIN13MapPetState.Spare], v)
        self:_PetObj_Start(v)
      else
        Log.exception("UIN13BuildMapPetManager:ChangeFixedPet() pet can not find, id = ", v)
      end
      table.insert(self._petIdList[EUIN13MapPetState.Fixed], v)
    end
  end
  local fixedCount = #self._petIdList[EUIN13MapPetState.Fixed]
  local unfixedCount = #self._petIdList[EUIN13MapPetState.Unfixed]
  for i = 1, fixedCount + unfixedCount - self._petActiveCount do
    local v = self._petIdList[EUIN13MapPetState.Unfixed][1]
    table.remove(self._petIdList[EUIN13MapPetState.Unfixed], 1)
    table.insert(self._petIdList[EUIN13MapPetState.Leave], v)
    self:_PetObj_Leave(v)
  end
  self:_Refresh()
  return newFixedPetIdList
end

function UIN13BuildMapPetManager:SetPetPicnic(petId, nodeId, story, callback)
  local v = self._petObjMap[petId]
  v:SetPetPicnic(nodeId, story, callback)
end

function UIN13BuildMapPetManager:SetPetBtnShow(petId)
  for k, v in pairs(self._petObjMap) do
    v:SetBtnShow(petId == k)
  end
end

function UIN13BuildMapPetManager:_PetObj_Init(obj, id, isSpare)
  local petSpine = self._petData[id].Spine
  local nodeIdList = isSpare and self._nodeStartPointList or self._nodeNormalPointList
  local list = table.collect(nodeIdList)
  table.shuffle(list)
  for _, v in ipairs(list) do
    if isSpare or not self:_CheckNodeUsed(v) then
      obj:Init(self._nodeData, id, petSpine, v, self._nodeStartPointList, function(id, isLeave)
        return self:_PetObj_On_Move(id, isLeave)
      end, function(id)
        return self:_PetObj_On_Stop(id)
      end, self._btnCallback)
      if not isSpare then
        self:_SetNodeUsed(v, id)
      end
      return
    end
  end
end

function UIN13BuildMapPetManager:_PetObj_GetPos(id)
  local obj = self._petObjMap[id]
  return obj:GetNodeId()
end

function UIN13BuildMapPetManager:_PetObj_Start(id)
  local obj = self._petObjMap[id]
  obj:Start()
end

function UIN13BuildMapPetManager:_PetObj_Leave(id)
  local obj = self._petObjMap[id]
  obj:Leave(self._PetObj_On_Stop)
end

function UIN13BuildMapPetManager:_PetObj_On_Move(id, isLeave)
  local from = self:_PetObj_GetPos(id)
  if not isLeave then
    local allPath = self._nodeData:GetAllPathsInLimitStep(from, self._petStepLimit)
    local targets = table.keys(allPath)
    for _, v in ipairs(self._nodeStartPointList) do
      table.removev(targets, v)
    end
    for _, v in ipairs(self._nodePicnicPointList) do
      table.removev(targets, v)
    end
    table.shuffle(targets)
    for _, v in ipairs(targets) do
      if not self:_CheckNodeUsed(v) then
        self:_SetNodeUsed(from, 0)
        self:_SetNodeUsed(v, id)
        self:_Refresh()
        return allPath[v]
      end
    end
    return {}
  else
    local targetIds = self._nodeStartPointList
    local path = self._nodeData:GetAPathToTarget(from, targetIds)
    if #path == 0 then
      local t = "id = " .. id .. [[

from = ]] .. from .. [[

targetIds = {]]
      for _, v in ipairs(targetIds) do
        t = t .. v .. ", "
      end
      t = t .. "}"
      Log.error("UIN13BuildMapPetManager:_PetObj_On_Move() No way out\n" .. t)
    end
    self:_SetNodeUsed(from, 0)
    self:_Refresh()
    return path
  end
end

function UIN13BuildMapPetManager:_PetObj_On_Stop(id)
  local succ = true
  if table.icontains(self._petIdList[EUIN13MapPetState.Leave], id) then
    table.removev(self._petIdList[EUIN13MapPetState.Leave], id)
    table.insert(self._petIdList[EUIN13MapPetState.Spare], id)
  else
    succ = false
  end
  self:_Refresh()
  return succ
end

function UIN13BuildMapPetManager:_GetSortedIDList(tb_in)
  local tb = {}
  for k, v in pairs(tb_in) do
    table.insert(tb, k)
  end
  table.sort(tb)
  return tb
end

function UIN13BuildMapPetManager:_CheckNodeUsed(node)
  return self._nodeUsedMap[node] ~= 0
end

function UIN13BuildMapPetManager:_SetNodeUsed(node, id)
  self._nodeUsedMap[node] = id
end

function UIN13BuildMapPetManager:DebugChangeFixedPet()
  local petIdList = self:_GetSortedIDList(self._petData)
  self._debugPetIndex = self._debugPetIndex or -1
  self._debugPetIndex = (self._debugPetIndex + 1) % #petIdList
  local index = self._debugPetIndex + 1
  local newFixedPetIdList = {
    petIdList[index]
  }
  return self:_ChangePet(newFixedPetIdList)
end

function UIN13BuildMapPetManager:_GetDebugFixedPetIdList()
  local test = {
    {1500991, 1501001},
    {1600961, 1601121},
    {1501141, 1601121}
  }
  self._testTurn = self._testTurn or 0
  self._testTurn = self._testTurn + 1
  self._testTurn = self._testTurn > #test and 1 or self._testTurn
  return test[self._testTurn]
end

function UIN13BuildMapPetManager:SetShowDebug(show)
  self._flagShowDebug = show
  for k, v in pairs(self._petObjMap) do
    v:SetShowDebug(show)
  end
end

function UIN13BuildMapPetManager:_SetDebugState()
  if not self._flagShowDebug then
    return
  end
  self:_NodeObj_SetHighlight()
  local tb_check = {}
  for k, v in pairs(self._petIdList) do
    for _, vv in ipairs(v) do
      self._petObjMap[vv]:SetDebugState(k)
      if not tb_check[vv] then
        tb_check[vv] = true
      else
        Log.exception("UIN13BuildMapPetManager:_SetDebugState() repeat key = " .. vv)
      end
    end
  end
  local petIdList = self:_GetSortedIDList(self._petData)
  if table.count(tb_check) ~= #petIdList then
    Log.exception("UIN13BuildMapPetManager:_SetDebugState() lost key = ")
  end
end

function UIN13BuildMapPetManager:_NodeObj_SetHighlight()
  for _, v in ipairs(self._nodeObjs) do
    local nodeId = v._nodeId
    local flagStart = table.icontains(self._nodeStartPointList, nodeId)
    if not flagStart then
      v:SetHighlight(self:_CheckNodeUsed(nodeId))
    end
  end
end
