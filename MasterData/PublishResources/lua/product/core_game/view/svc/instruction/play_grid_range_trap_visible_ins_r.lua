require("base_ins_r")
_class("PlayGridRangeTrapVisbleInstruction", BaseInstruction)
PlayGridRangeTrapVisbleInstruction = PlayGridRangeTrapVisbleInstruction

function PlayGridRangeTrapVisbleInstruction:Constructor(paramList)
  local param = tonumber(paramList.visible)
  if param == 1 then
    self._visible = true
  else
    self._visible = false
  end
  self._trapID = tonumber(paramList.trapID) or 0
end

function PlayGridRangeTrapVisbleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local scopeGridRange = phaseContext:GetScopeGridRange()
  if not scopeGridRange then
    return InstructionConst.PhaseEnd
  end
  local maxScopeRangeCount = phaseContext:GetMaxRangeCount()
  if not maxScopeRangeCount then
    return InstructionConst.PhaseEnd
  end
  local curScopeGridRangeIndex = phaseContext:GetCurScopeGridRangeIndex()
  if maxScopeRangeCount < curScopeGridRangeIndex then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local group = world:GetGroup(world.BW_WEMatchers.Trap)
  for _, range in pairs(scopeGridRange) do
    if range then
      local posList = range[curScopeGridRangeIndex]
      if posList then
        for _, pos in pairs(posList) do
          for _, e in ipairs(group:GetEntities()) do
            local trapRenderCmpt = e:TrapRender()
            if trapRenderCmpt and not trapRenderCmpt:GetHadPlayDestroy() and self._trapID == trapRenderCmpt:GetTrapID() and pos == e:GetGridPosition() then
              local location = e:Location()
              if location then
                local gridWorldPos = e:GetPosition()
                local offsetY = self._visible and 0 or 1000
                local gridWorldNew = Vector3.New(gridWorldPos.x, offsetY, gridWorldPos.z)
                e:SetPosition(gridWorldNew)
              end
              local cTrapRoundInfo = e:TrapRoundInfoRender()
              if cTrapRoundInfo then
                cTrapRoundInfo:SetIsShow(self._visible)
              end
            end
          end
        end
      end
    end
  end
end
