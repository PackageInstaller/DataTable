_class("PartnerServiceRender", BaseService)
PartnerServiceRender = PartnerServiceRender

function PartnerServiceRender:Dispose()
end

function PartnerServiceRender:AddMiddleEnterPetRender(TT, petRes)
  local creationRes = petRes
  local resPath = creationRes:GetPetCreationRes()
  local logicEntityID = creationRes:GetPetCreationLogicEntityID()
  local petEntity = self._world:GetEntityByID(logicEntityID)
  petEntity:ReplaceAsset(NativeUnityPrefabAsset:New(resPath, false))
  local id = string.gsub(resPath, ".prefab", "")
  petEntity:PetPstID():SetResID(tonumber(id))
  local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
  if teamEntity then
    local teamPos = teamEntity:Location().Position
    local teamDir = teamEntity:Location().Direction
    petEntity:SetLocation(teamPos, teamDir)
  end
  self:_InitRenderAttributes(petEntity, creationRes)
end

function PartnerServiceRender:_InitRenderAttributes(entity, creationRes)
  local hp = creationRes:GetPetCreation_CurHp()
  local maxHP = creationRes:GetPetCreation_MaxHp()
  entity:ReplaceRedAndMaxHP(hp, maxHP)
end

function PartnerServiceRender:AddPartnerRender(TT, dataAddPartnerResult)
  Log.debug("[MiniMaze] PartnerServiceRender:AddPartnerRender ")
  Log.debug("[MiniMaze] PartnerServiceRender:AddPartnerRender task begin")
  self:CachePartner(TT, dataAddPartnerResult:GetMatchPet())
  Log.debug("[MiniMaze] PartnerServiceRender:AddPartnerRender task after CachePartner")
  self:AddMiddleEnterPetRender(TT, dataAddPartnerResult:GetPetRes())
  Log.debug("[MiniMaze] PartnerServiceRender:AddPartnerRender task after AddMiddleEnterPetRender")
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  teamEntity:ReplaceRedAndMaxHP(dataAddPartnerResult:GetHP(), dataAddPartnerResult:GetMaxHP())
  local hpCmpt = teamEntity:HP()
  Log.debug("[MiniMaze] PartnerServiceRender:AddPartnerRender task before AddNewBattlePet")
  GameGlobal:EventDispatcher():Dispatch(GameEventType.AddNewBattlePet, dataAddPartnerResult:GetPetInfo(), dataAddPartnerResult:GetMatchPet())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamHPChange, {
    isLocalTeam = true,
    currentHP = hpCmpt:GetRedHP(),
    maxHP = hpCmpt:GetMaxHP(),
    hitpoint = hpCmpt:GetWhiteHP(),
    shield = hpCmpt:GetShieldValue(),
    entityID = teamEntity:GetID(),
    showCurseHp = hpCmpt:GetShowCurseHp(),
    curseHpVal = hpCmpt:GetCurseHpValue()
  })
  Log.debug("[MiniMaze] PartnerServiceRender:AddPartnerRender task before WaveResultAwardFinish")
  local playBuffSvc = self._world:GetService("PlayBuff")
  Log.debug("[MiniMaze] PartnerServiceRender:AddPartnerRender task before PlayAutoAddBuff")
  playBuffSvc:PlayAutoAddBuff()
  local featureRender = self._world:GetService("FeatureRender")
  if featureRender then
    Log.debug("[MiniMaze] PartnerServiceRender:AddPartnerRender task before _InitUIFeatureList")
    featureRender:_InitUIFeatureList(TT)
  end
end

function PartnerServiceRender:CachePartner(TT, partnerMatchPet)
  local respool = self._world.BW_Services.ResourcesPool
  local loadingSvc = self._world:GetService("Loading")
  local partnerMatchPetDataList = {partnerMatchPet}
  local restable = loadingSvc:_GetCacheTable_ByPetData(partnerMatchPetDataList)
  for k, v in pairs(restable) do
    local resname = v[1]
    local count = v[2]
    if string.endwith(resname, ".mat") then
      respool:CacheMaterial(resname, count)
    else
      respool:Cache(resname, count)
    end
  end
  YIELD(TT)
end
