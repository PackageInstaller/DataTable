require("base_ins_r")
_class("BattleEnterPetsInstruction", BaseInstruction)
BattleEnterPetsInstruction = BattleEnterPetsInstruction

function BattleEnterPetsInstruction:Constructor(paramList)
  self._petShowDelay = tonumber(paramList.petShowDelay)
  self._interval = {}
  local strParam = paramList.interval
  if strParam then
    local arr = string.split(strParam, "|")
    for index, str in ipairs(arr) do
      local n = tonumber(str)
      table.insert(self._interval, n)
    end
  else
    self._interval = {
      0,
      0,
      0
    }
  end
  self._effLightPillar = tonumber(paramList.effLightPillar)
end

function BattleEnterPetsInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  self._ePets = teamEntity:Team():GetTeamPetEntities()
  for i, e in ipairs(self._ePets) do
    if e then
      self:PlayEffShowPet(e, teamEntity)
      if self._interval and self._interval[i] then
        YIELD(TT, self._interval[i])
      end
    end
  end
end

function BattleEnterPetsInstruction:PlayEffShowPet(e, teamEntity)
  local teamLeaderPetPstID = teamEntity:Team():GetTeamLeaderPetPstID()
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    local petPstIDCmpt = e:PetPstID()
    if petPstIDCmpt:GetPstID() ~= teamLeaderPetPstID then
      self:PlayEffLightPillar(e)
      if self._petShowDelay then
        YIELD(TT, self._petShowDelay)
      end
    end
    self:PlayBattlePermanentEffect(e)
    e:SetViewVisible(true)
  end, self)
end

function BattleEnterPetsInstruction:PlayEffLightPillar(e)
  if not self._effLightPillar then
    self._effLightPillar = self:GetFirstElementEffect(e)
  end
  local sEffect = self._world:GetService("Effect")
  sEffect:CreateEffect(self._effLightPillar, e)
end

function BattleEnterPetsInstruction:GetFirstElementEffect(e)
  local sEffect = self._world:GetService("Effect")
  local elementType = e:Element():GetPrimaryType()
  return sEffect:GetPetShowEffIdByEntity(elementType)
end

function BattleEnterPetsInstruction:PlayBattlePermanentEffect(e)
  local sEffect = self._world:GetService("Effect")
  local templateID = e:PetPstID():GetTemplateID()
  local cfgPet = Cfg.cfg_pet[templateID]
  local permanentFxArray = cfgPet.BattlePermanentEffect
  if permanentFxArray and 0 < #permanentFxArray then
    for _, effectID in ipairs(permanentFxArray) do
      sEffect:CreateEffect(effectID, e)
    end
  end
end

function BattleEnterPetsInstruction:GetCacheResource()
  local t = {}
  if self._effLightPillar and self._effLightPillar > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effLightPillar].ResPath,
      4
    })
  end
  return t
end
