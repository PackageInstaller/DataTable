require("base_ins_r")
_class("PlayGridEffectByTransportGridInstruction", BaseInstruction)
PlayGridEffectByTransportGridInstruction = PlayGridEffectByTransportGridInstruction

function PlayGridEffectByTransportGridInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._intervalTime = tonumber(paramList.intervalTime)
end

function PlayGridEffectByTransportGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local effectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.TransportByRange)
  if effectResult == nil then
    return
  end
  local posList = effectResult:GetOutlineRange()
  local dir = effectResult:GetTransportDir()
  local sortPosList = {}
  local step = 1
  local maxL = 1
  if dir == DirectionType.Left or dir == DirectionType.Right then
    if dir == DirectionType.Left then
      step = -1
    end
    for i, pos in ipairs(posList) do
      if not sortPosList[pos.x] then
        sortPosList[pos.x] = {}
      end
      if maxL < pos.x then
        maxL = pos.x
      end
      table.insert(sortPosList[pos.x], pos)
    end
  elseif dir == DirectionType.Up or dir == DirectionType.Down then
    if dir == DirectionType.Down then
      step = -1
    end
    for i, pos in ipairs(posList) do
      if maxL < pos.y then
        maxL = pos.y
      end
      if not sortPosList[pos.y] then
        sortPosList[pos.y] = {}
      end
      table.insert(sortPosList[pos.y], pos)
    end
  end
  self:_SmallToLargeSort(sortPosList)
  local beginL, endL
  if step == 1 then
    beginL = 1
    endL = maxL
  elseif step == -1 then
    beginL = maxL
    endL = 1
  end
  local effectSvc = self._world:GetService("Effect")
  for i = beginL, endL, step do
    local list = sortPosList[i]
    if list then
      for i, pos in ipairs(list) do
        effectSvc:CreateCommonGridEffect(self._effectID, pos)
      end
      YIELD(TT, self._intervalTime)
    end
  end
end

function PlayGridEffectByTransportGridInstruction:_SmallToLargeSort(posDic)
  local function sortDicFunc(dic)
    local newDic = {}
    
    local keyList = {}
    for k, _ in pairs(dic) do
      table.insert(keyList, k)
    end
    table.sort(keyList, function(a, b)
      return a < b
    end)
    for i = 1, #keyList do
      newDic[#newDic + 1] = dic[keyList[i]]
    end
    return newDic
  end
  
  posDic = sortDicFunc(posDic)
  return posDic
end

function PlayGridEffectByTransportGridInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
