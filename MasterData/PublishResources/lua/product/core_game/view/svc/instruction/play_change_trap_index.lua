require("base_ins_r")
_class("PlayChangeTrapIndexInstruction", BaseInstruction)
PlayChangeTrapIndexInstruction = PlayChangeTrapIndexInstruction

function PlayChangeTrapIndexInstruction:Constructor(paramList)
  local str = paramList.trapIDList
  local sp = string.split(str, "|")
  self._trapID = {}
  for i, trapID in ipairs(sp) do
    table.insert(self._trapID, tonumber(trapID))
  end
  str = paramList.indexPrefabList
  self._indexPrefabList = string.split(str, "|")
end

function PlayChangeTrapIndexInstruction:GetCacheResource()
  local t = {}
  for i, resPath in ipairs(self._indexPrefabList) do
    table.insert(t, {resPath, 1})
  end
  return t
end

function PlayChangeTrapIndexInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
  local allTrapEntity = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  local choseEntity = {}
  for i, trapEntity in ipairs(allTrapEntity) do
    if not trapEntity:HasDeadMark() then
      local trapRenderCmpt = trapEntity:TrapRender()
      local trapID = trapRenderCmpt:GetTrapID()
      if table.icontains(self._trapID, trapID) then
        table.insert(choseEntity, trapEntity)
      end
    end
  end
  
  local function sortFunc(trapA, trapB)
    local trapARenderCmpt = trapA:TrapRender()
    local trapBRenderCmpt = trapB:TrapRender()
    local roundA = trapARenderCmpt:GetTrapBornRound()
    local roundB = trapBRenderCmpt:GetTrapBornRound()
    return trapA:GetID() > trapB:GetID()
  end
  
  table.sort(choseEntity, sortFunc)
  for i, entity in ipairs(choseEntity) do
    local prefab = self._indexPrefabList[i]
    if not self._indexPrefabList[i] then
      prefab = self._indexPrefabList[#self._indexPrefabList]
    end
    entity:ReplaceAsset(NativeUnityPrefabAsset:New(prefab, true))
  end
end
