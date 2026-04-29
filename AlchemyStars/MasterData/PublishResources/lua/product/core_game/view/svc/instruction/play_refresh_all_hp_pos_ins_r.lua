require("base_ins_r")
_class("PlayRefreshAllHPPosInstruction", BaseInstruction)
PlayRefreshAllHPPosInstruction = PlayRefreshAllHPPosInstruction

function PlayRefreshAllHPPosInstruction:Constructor(paramList)
  self._forceRefreshHPPercent = tonumber(paramList.forceRefreshHPPercent) or 0
end

function PlayRefreshAllHPPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local hpGroup = world:GetGroup(world.BW_WEMatchers.HP)
  if hpGroup then
    local targetEntitys = hpGroup:GetEntities()
    if targetEntitys then
      for i, e in ipairs(targetEntitys) do
        local hpCmpt = e:HP()
        if hpCmpt then
          hpCmpt:SetHPPosDirty(true)
        end
        if self._forceRefreshHPPercent == 1 then
          e:ReplaceHPComponent()
        end
      end
    end
  end
end
