require("base_service")
_class("FettersService", BaseService)
FettersService = FettersService

function FettersService:Constructor(world)
  self._world = world
end

function FettersService:InitFetters()
  if self._world:MatchType(GetMatchTypeType.PopStarProNoRelic) ~= MatchType.MT_PopStarPro then
    return
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for _, petEntity in ipairs(teamMembers) do
    local cPetPstID = petEntity:PetPstID()
    local petTemplateID = cPetPstID:GetTemplateID()
    local fettersPetEntity = self:GetFettersPetEntity(teamMembers, petTemplateID)
    if fettersPetEntity then
      self:InitFettersComponent(petEntity, fettersPetEntity)
    end
  end
end

function FettersService:GetFettersPetEntity(teamMembers, petTemplateID)
  local createInfo = self._world.BW_WorldInfo.clientCreateInfo.anipop_mission_info[1]
  local fettersID = createInfo.fetters_id
  local fettersPetTmpID = self:GetFettersPetTemplateID(fettersID, petTemplateID)
  if fettersPetTmpID then
    for _, petEntity in ipairs(teamMembers) do
      local cPetPstID = petEntity:PetPstID()
      local tmpID = cPetPstID:GetTemplateID()
      if tmpID == fettersPetTmpID then
        return petEntity
      end
    end
  end
end

function FettersService:GetFettersPetTemplateID(fettersID, petID)
  local fetterAInfos = Cfg.cfg_anipop_fetters({FettersID = fettersID, PetAID = petID}) or {}
  local fetterBInfos = Cfg.cfg_anipop_fetters({FettersID = fettersID, PetBID = petID}) or {}
  local fettersPetTemplateIDList = {}
  for _, fetterAInfo in pairs(fetterAInfos) do
    table.insert(fettersPetTemplateIDList, fetterAInfo.PetBID)
  end
  for _, fetterBInfo in pairs(fetterBInfos) do
    table.insert(fettersPetTemplateIDList, fetterBInfo.PetAID)
  end
  if 1 < #fettersPetTemplateIDList then
    Log.error("Fetters count error, pet template id = ", petID, ", fettersID = ", fettersID)
    return
  elseif #fettersPetTemplateIDList == 0 then
    return
  end
  return fettersPetTemplateIDList[1]
end

function FettersService:InitFettersComponent(petEntity, fettersPetEntity)
  if petEntity:HasFetters() then
    petEntity:RemoveFetters()
  end
  petEntity:AddFetters()
  local elementCmpt = fettersPetEntity:Element()
  local primaryType = elementCmpt:GetPrimaryType()
  local fettersCmpt = petEntity:Fetters()
  fettersCmpt:SetFettersData(fettersPetEntity:GetID(), primaryType)
end

function FettersService:GetFettersPrimaryType(petEntity)
  if not petEntity:HasFetters() then
    return
  end
  local fettersCmpt = petEntity:Fetters()
  return fettersCmpt:GetFettersPrimaryType()
end

function FettersService:IsFettersActive(petEntity)
  if not petEntity:HasFetters() then
    return false
  end
  local fettersCmpt = petEntity:Fetters()
  return fettersCmpt:IsActive()
end

function FettersService:SetFettersActive(petEntity, isActive)
  if not petEntity:HasFetters() then
    return false
  end
  local fettersCmpt = petEntity:Fetters()
  return fettersCmpt:SetActive(isActive)
end

function FettersService:IsMatchPieceType(petEntityID, pieceType, needSet)
  local petEntity = self._world:GetEntityByID(petEntityID)
  if petEntity and not petEntity:HasPetDeadMark() then
    local elementCmpt = petEntity:Element()
    local primaryType = elementCmpt:GetPrimaryType()
    if CanMatchPieceType(primaryType, pieceType) then
      if needSet then
        self:SetFettersActive(petEntity, false)
      end
      return true, false
    else
      local fettersPrimaryType = self:GetFettersPrimaryType(petEntity)
      local isMatch = CanMatchPieceType(fettersPrimaryType, pieceType)
      if needSet then
        self:SetFettersActive(petEntity, isMatch)
      end
      return isMatch, isMatch
    end
  end
  return false, false
end
