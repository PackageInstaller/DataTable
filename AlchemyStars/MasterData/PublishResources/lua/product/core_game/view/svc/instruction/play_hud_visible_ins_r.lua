require("base_ins_r")
_class("PlayHUDVisibleInstruction", BaseInstruction)
PlayHUDVisibleInstruction = PlayHUDVisibleInstruction

function PlayHUDVisibleInstruction:Constructor(paramList)
  local param = tonumber(paramList.visible)
  if param == 1 then
    self._visible = true
  else
    self._visible = false
  end
end

function PlayHUDVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if self._visible then
    local targets = phaseContext:GetHUDTargets()
    if targets then
      for i, e in ipairs(targets) do
        e:SetViewVisible(true)
      end
    end
  else
    local targets = {}
    local group = world:GetGroup(world.BW_WEMatchers.HUD)
    for _, e in ipairs(group:GetEntities()) do
      e:SetViewVisible(self._visible)
      if e:IsViewVisible() then
        table.insert(targets, e)
        e:SetViewVisible(false)
      end
    end
    phaseContext:SetHUDTargets(targets)
  end
end
