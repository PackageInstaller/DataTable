require("base_ins_r")
_class("PlayEntityAnimationInstruction", BaseInstruction)
PlayEntityAnimationInstruction = PlayEntityAnimationInstruction

function PlayEntityAnimationInstruction:Constructor(paramList)
  self._animName = paramList.animName
  self._monsterClassID = tonumber(paramList.monsterClassID) or 0
  self._trapID = tonumber(paramList.trapID) or 0
  self._petTemplateID = tonumber(paramList.petTemplateID) or 0
end

function PlayEntityAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local entityList = {}
  if self._trapID and self._trapID > 0 then
    local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
    for _, e in ipairs(trapGroup:GetEntities()) do
      local trapRenderCmpt = e:TrapRender()
      if trapRenderCmpt and not trapRenderCmpt:GetHadPlayDestroy() and self._trapID == trapRenderCmpt:GetTrapID() then
        table.insert(entityList, e)
      end
    end
  end
  if self._monsterClassID and 0 < self._monsterClassID then
    local monsterGroup = world:GetGroup(world.BW_WEMatchers.MonsterID)
    for _, e in ipairs(monsterGroup:GetEntities()) do
      if e:HasView() and not e:HasShowDeath() and self._monsterClassID == e:MonsterID():GetMonsterClassID() then
        table.insert(entityList, e)
      end
    end
  end
  if self._petTemplateID and 0 < self._petTemplateID then
    local petGroup = world:GetGroup(world.BW_WEMatchers.PetPstID)
    for _, e in ipairs(petGroup:GetEntities()) do
      local cPetPstID = e:PetPstID()
      local petTemplateID = cPetPstID:GetTemplateID()
      if self._petTemplateID == petTemplateID then
        table.insert(entityList, e)
      end
    end
  end
  for _, e in ipairs(entityList) do
    e:SetAnimatorControllerTriggers({
      self._animName
    })
  end
end
