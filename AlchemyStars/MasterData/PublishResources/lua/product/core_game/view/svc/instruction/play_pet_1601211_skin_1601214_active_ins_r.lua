require("base_ins_r")
_class("PlayPet1601211Skin1601214ActiveInstruction", BaseInstruction)
PlayPet1601211Skin1601214ActiveInstruction = PlayPet1601211Skin1601214ActiveInstruction

function PlayPet1601211Skin1601214ActiveInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID) or 160121406
  self._gridEffectID1 = tonumber(paramList.gridEffectID1) or 160121408
  self._gridEffectID2 = tonumber(paramList.gridEffectID2) or 160121409
  self._intervalTime = tonumber(paramList.intervalTime) or 200
  self._waitTime = tonumber(paramList.waitTime) or 7000
  self._effectAnimTime = tonumber(paramList.effectAnimTime) or 2500
  self._effectAnimName1 = paramList.effectAnimName1 or "effanim_1601214_ult_hit01_01"
  self._effectAnimName2 = paramList.effectAnimName2 or "effanim_1601214_ult_hit01_02"
end

function PlayPet1601211Skin1601214ActiveInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
  local specialScopeResultList = {}
  for _, result in pairs(damageResultArray) do
    if result.GetSpecialScopeResultList then
      local specialScopeResult = result:GetSpecialScopeResultList()
      if specialScopeResult and table.count(specialScopeResult) > 0 and not table.icontains(specialScopeResultList, specialScopeResult[1]) then
        table.appendArray(specialScopeResultList, specialScopeResult)
      end
    end
  end
  local scopeGridSort = DataSortScopeGridRangeInstruction:New({
    sortType = GridRangeSortType.SpecialScopeResultIndex
  })
  local gridRange, maxGridCount = scopeGridSort:_SpecialScopeIndexSort(specialScopeResultList)
  local effectService = world:GetService("Effect")
  local boardServiceRender = world:GetService("BoardRender")
  local hadDamageTargetIds = {}
  local gridEffectEntityList = {}
  for _, range in pairs(gridRange) do
    for index, posList in pairs(range) do
      for i, pos in pairs(posList) do
        local targetPos = pos
        if pickUpGridArray[1] ~= pos then
          for _, v in ipairs(damageResultArray) do
            local damageResult = v
            if damageResult:GetGridPos() == pos then
              local targetEntityID = damageResult:GetTargetID()
              local targetEntity = world:GetEntityByID(targetEntityID)
              if not table.icontains(hadDamageTargetIds, targetEntityID) then
                table.insert(hadDamageTargetIds, targetEntityID)
                local targetRenderPosition = boardServiceRender:GetEntityRealTimeGridPos(targetEntity, true)
                local bodyAreaCount = targetEntity:BodyArea():GetAreaCount()
                local gridEffectID = self._gridEffectID1
                if 4 <= bodyAreaCount then
                  gridEffectID = self._gridEffectID2
                end
                local gridEffectEntity = effectService:CreateWorldPositionEffect(gridEffectID, targetRenderPosition)
                local obj = gridEffectEntity:View():GetGameObject()
                local anim = obj:GetComponentInChildren(typeof(UnityEngine.Animation))
                if anim then
                  anim:Play(self._effectAnimName1)
                end
                table.insert(gridEffectEntityList, gridEffectEntity)
              end
            end
          end
          local dir = Vector2(0, 0)
          if index == 1 then
            dir = pickUpGridArray[2] - pickUpGridArray[1]
          else
            local lastPosList = range[index - 1]
            local nearestPos
            for _, lastPos in pairs(lastPosList) do
              local dis = Vector2.Distance(targetPos, lastPos)
              if dis == 1 then
                nearestPos = lastPos
                break
              end
            end
            if not nearestPos then
              if 2 < index then
                lastPosList = range[index - 2]
                for _, lastPos in pairs(lastPosList) do
                  local dis = Vector2.Distance(targetPos, lastPos)
                  if dis == 1 then
                    nearestPos = lastPos
                    break
                  end
                end
              end
              if not nearestPos then
                lastPosList = range[index - 1]
                nearestPos = lastPosList[#lastPosList]
              end
            end
            dir = targetPos - nearestPos
          end
          local effEntity = effectService:CreateWorldPositionDirectionEffect(self._effectID, targetPos, dir)
        end
      end
      YIELD(TT, self._intervalTime)
    end
  end
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT, self._waitTime)
    for _, effectEntity in pairs(gridEffectEntityList) do
      local obj = effectEntity:View():GetGameObject()
      local anim = obj:GetComponentInChildren(typeof(UnityEngine.Animation))
      if anim then
        anim:Play(self._effectAnimName2)
      end
    end
    YIELD(TT, self._effectAnimTime)
    for _, effectEntity in ipairs(gridEffectEntityList) do
      world:DestroyEntity(effectEntity)
    end
  end)
end

function PlayPet1601211Skin1601214ActiveInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      10
    })
  end
  return t
end
