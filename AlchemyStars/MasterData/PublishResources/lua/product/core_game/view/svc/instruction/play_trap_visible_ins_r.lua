require("base_ins_r")
_class("PlayTrapVisibleInstruction", BaseInstruction)
PlayTrapVisibleInstruction = PlayTrapVisibleInstruction

function PlayTrapVisibleInstruction:Constructor(paramList)
  local param = tonumber(paramList.visible)
  if param == 1 then
    self._visible = true
  else
    self._visible = false
  end
end

function PlayTrapVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local group = world:GetGroup(world.BW_WEMatchers.Trap)
  for _, e in ipairs(group:GetEntities()) do
    local trapRenderCmpt = e:TrapRender()
    if trapRenderCmpt and not trapRenderCmpt:GetHadPlayDestroy() then
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
