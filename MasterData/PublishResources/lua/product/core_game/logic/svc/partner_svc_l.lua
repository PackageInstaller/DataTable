require("battle_ui_active_skill_cannot_cast_reason")
_class("PartnerServiceLogic", BaseService)
PartnerServiceLogic = PartnerServiceLogic

function PartnerServiceLogic:Constructor()
end

function PartnerServiceLogic:Initialize()
end

function PartnerServiceLogic:CanEnablePartner()
  if self._world:MatchType() == MatchType.MT_MiniMaze then
    return true
  end
  return false
end

function PartnerServiceLogic:CreatePartner(partnerID)
  if not self:CanEnablePartner() then
    return
  end
  if not partnerID then
    return
  end
  local partnerCfg = Cfg.cfg_mini_maze_partner_info[partnerID]
  if not partnerCfg then
    Log.debug("[MiniMaze] PartnerServiceLogic:CreatePartner no partnerCfg, partnerID: ", partnerID)
    return
  end
  local partnerAttrCfg
  local cfgGroup = Cfg.cfg_component_bloodsucker_pet_attribute({
    ComponentID = BattleConst.PartnerAttrCfgComponentID,
    PetId = partnerCfg.PetID
  })
  if cfgGroup and 0 < #cfgGroup then
    partnerAttrCfg = cfgGroup[1]
  end
  if not partnerAttrCfg then
    Log.debug("[MiniMaze] PartnerServiceLogic:CreatePartner no partnerAttrCfg, partnerID: ", partnerID)
    return
  end
  local teamPetsMax = 8
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPetEntitys = teamEntity:Team():GetTeamPetEntities()
  if teamPetsMax <= #teamPetEntitys then
    Log.debug("[MiniMaze] PartnerServiceLogic:CreatePartner too mutch pet ")
    return
  end
  local battleStatCmpt = self._world:BattleStat()
  local curWaveIndex = battleStatCmpt:GetCurWaveIndex()
  local curWaveOptionalPartnerIDList = battleStatCmpt:GetWaveOptionalPartnerIDList(curWaveIndex)
  local abandonedList = {}
  if curWaveOptionalPartnerIDList then
    for _, partnerID in ipairs(curWaveOptionalPartnerIDList) do
      table.insert(abandonedList, partnerID)
    end
  end
  battleStatCmpt:AddAbandonedPartnerIDList(abandonedList)
  battleStatCmpt:SetWaveChoosePartner(curWaveIndex, partnerID)
  local createInfo = {}
  createInfo.petID = partnerCfg.PetID
  createInfo.level = 1
  createInfo.grade = partnerAttrCfg.Grade
  createInfo.awake = partnerAttrCfg.Awakening
  createInfo.equip = partnerAttrCfg.Equip
  createInfo.atk = partnerAttrCfg.Attack
  createInfo.def = partnerAttrCfg.Def
  createInfo.hp = partnerAttrCfg.Hp
  createInfo.affinityLevel = 1
  local petEntity, petInfo, matchPet, petRes, hp, maxHP = self:CreateMiddleEnterPet(createInfo)
  Log.debug("[MiniMaze] PartnerServiceLogic:CreatePartner after CreateMiddleEnterPet ")
  return partnerID, petInfo, matchPet, petRes, hp, maxHP
end

function PartnerServiceLogic:CreateMiddleEnterPet(createInfo)
  local petID = createInfo.petID
  local cfg = Cfg.cfg_pet[petID]
  if not cfg then
    return
  end
  local petEntity, petInfo, matchPet = self:CreateMiddleEnterTeamMember(createInfo)
  local petRes = self:CreateMiddleEnterTeamMemberRes(petEntity)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local attributesComponent = teamEntity:Attributes()
  local hp = attributesComponent:GetCurrentHP()
  local maxHP = attributesComponent:CalcMaxHp()
  return petEntity, petInfo, matchPet, petRes, hp, maxHP
end

function PartnerServiceLogic:CreateMiddleEnterTeamMember(createInfo)
  local petID = createInfo.petID
  local randomSvc = self._world:GetService("RandomLogic")
  local randomFlag = randomSvc:LogicRand(1, 100)
  local petInfo = MatchPetInfo:New()
  local tmpPstid = 999000000 + petID + randomFlag * 10000000
  petInfo.pet_pstid = tmpPstid
  petInfo.pet_power = -1
  petInfo.template_id = petID
  petInfo.level = createInfo.level or 1
  petInfo.grade = createInfo.grade or 0
  petInfo.awakening = createInfo.awake or 0
  petInfo.affinity_level = createInfo.affinityLevel or 1
  petInfo.team_slot = 6
  petInfo.attack = createInfo.atk or 0
  petInfo.defense = createInfo.def or 0
  petInfo.max_hp = createInfo.hp or 0
  petInfo.cur_hp = createInfo.hp or 0
  petInfo.after_damage = 0
  petInfo.equip_lv = createInfo.equip or 0
  petInfo.m_nHelpPetKey = 0
  local petPstID = petInfo.pet_pstid
  local matchPet = MatchPet:New(petInfo)
  local listMatchPet = self._world:GetLocalMatchPetList()
  table.insert(listMatchPet, matchPet)
  local localMatchPetDict = self._world:GetLocalMatchPets()
  localMatchPetDict[petPstID] = matchPet
  local configService = self._world:GetService("Config")
  local affixService = self._world:GetService("Affix")
  local petData = matchPet
  local petId = petData:GetTemplateID()
  local awaking = petData:GetPetAwakening()
  local grade = petData:GetPetGrade()
  local skinId = petData:GetSkinId()
  local normalSkillID = petData:GetNormalSkill()
  if normalSkillID then
    configService:GetSkillConfigData(normalSkillID)
  end
  local chainSkillIDs = petData:GetChainSkillInfo()
  if chainSkillIDs then
    for i = 1, #chainSkillIDs do
      local configData = configService:GetSkillConfigData(chainSkillIDs[i].Skill)
      affixService:ChangePetChainCount(configData)
    end
  end
  local activeSkillID = petData:GetPetActiveSkill()
  if activeSkillID then
    configService:GetSkillConfigData(activeSkillID)
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local petPstID = matchPet:GetPstID()
  local entityService = self._world:GetService("LogicEntity")
  local petEntity = entityService:_CreateTeamMemberLogic(matchPet, petPstID, teamEntity)
  self:_ReAddTeamBuffOnPartnerJoin(petEntity)
  self:_CheckFeatureOnPartnerJoin(petEntity)
  return petEntity, petInfo, matchPet
end

function PartnerServiceLogic:CreateMiddleEnterTeamMemberRes(petEntity)
  local petRes = DataPetCreationResult:New()
  local matchPet = petEntity:MatchPet():GetMatchPet()
  local eid = petEntity:GetID()
  petRes:SetPetCreationLogicEntityID(eid)
  local tplID = matchPet:GetTemplateID()
  petRes:SetPetCreationTemplateID(tplID)
  local pstID = matchPet:GetPstID()
  petRes:SetPetCreationPstID(pstID)
  local firstElement = matchPet:GetPetFirstElement()
  local secondElement = matchPet:GetPetSecondElement()
  petRes:SetPetCreationElementType(firstElement, secondElement)
  local petPrefab = matchPet:GetPetPrefab(PetSkinEffectPath.MODEL_INGAME)
  petRes:SetPetCreationRes(petPrefab)
  local gridLocCmpt = petEntity:GridLocation()
  local gridPos = gridLocCmpt:GetGridPos()
  petRes:SetPetCreationGridPos(gridPos)
  local attrCmpt = petEntity:Attributes()
  local hp = attrCmpt:GetCurrentHP()
  local maxHP = attrCmpt:CalcMaxHp()
  petRes:SetPetCreation_CurHp(hp)
  petRes:SetPetCreation_MaxHp(maxHP)
  return petRes
end

function PartnerServiceLogic:_ReAddTeamBuffOnPartnerJoin(petEntity)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local levelConfigData = self._configService:GetLevelConfigData()
  local teamPos = teamEntity:GetGridPosition()
  local teamRotation = teamEntity:GetGridDirection()
  local entityService = self._world:GetService("LogicEntity")
  local tmpTeamEntity = entityService:CreateLogicEntity(EntityConfigIDConst.Team)
  tmpTeamEntity:SetGridPosition(teamPos)
  tmpTeamEntity:SetGridDirection(teamRotation)
  local tmpEntitys = {}
  table.insert(tmpEntitys, petEntity)
  tmpTeamEntity:Team():SetTeamPetEntities(tmpEntitys)
  self._world:Player():SetAddPartnerTempTeam(tmpTeamEntity)
  self:_DoCreateIntensifyBuffMap(tmpTeamEntity)
  self:_DoLogicSetCurPetsPassiveSkill(teamEntity, tmpTeamEntity)
  self._world:Player():SetAddPartnerTempTeam(nil)
  local team = teamEntity:Team()
  local order = team:GetTeamOrder()
  table.insert(order, petEntity:PetPstID():GetPstID())
  team:SetTeamOrder(order)
  local petEntitys = team:GetTeamPetEntities()
  table.insert(petEntitys, petEntity)
  team:SetTeamPetEntities(petEntitys)
  self:_DoLogicSetNewPetPassiveSkill(teamEntity, tmpTeamEntity)
  self:_DoLogicSetPetIntensifyBuff(tmpTeamEntity)
  self._world:Player():SetAddPartnerTempTeam(tmpTeamEntity)
  local GameStartBuffs = {}
  local battleService = self._world:GetService("Battle")
  battleService:InitWordBuff(GameStartBuffs)
  battleService:InitTalePetBuff(GameStartBuffs)
  self._world:GetService("Affix"):InitAffixBuff(GameStartBuffs)
  local battleStatCmpt = self._world:BattleStat()
  local allMiniMazeRelicList = battleStatCmpt:GetAllMiniMazeRelicList()
  if allMiniMazeRelicList then
    for _, relicID in ipairs(allMiniMazeRelicList) do
      battleService:ApplyRelic(relicID, false, reApply)
    end
  end
  self._world:Player():SetAddPartnerTempTeam(nil)
  tmpTeamEntity:Team():SetTeamPetEntities({})
  self:UnLoadTmpTeamBuff(tmpTeamEntity)
  self._world:DestroyEntity(tmpTeamEntity)
end

function PartnerServiceLogic:UnLoadTmpTeamBuff(tmpTeamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:RemoveAllBuffInstance(tmpTeamEntity)
end

function PartnerServiceLogic:_CheckFeatureOnPartnerJoin(petEntity)
  local featureService = self._world:GetService("FeatureLogic")
  if featureService then
    featureService:OnPartnerPetJoinCheckFeature(petEntity)
  end
end

function PartnerServiceLogic:_DoCreateIntensifyBuffMap(tmpTeamEntity)
  local pets = tmpTeamEntity:Team():GetTeamPetEntities()
  local battleStatCmpt = self._world:BattleStat()
  for _, petEntity in ipairs(pets) do
    local equipIntensifyParams = petEntity:SkillInfo():GetEquipIntensifyParam()
    if equipIntensifyParams then
      battleStatCmpt:AddBuffIntensifyParam(equipIntensifyParams)
    end
  end
end

function PartnerServiceLogic:_DoLogicSetCurPetsPassiveSkill(teamEntity, tmpTeamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:ReBuildCurrentPetsPassiveSkillToPartner(teamEntity, tmpTeamEntity)
end

function PartnerServiceLogic:_DoLogicSetNewPetPassiveSkill(teamEntity, tmpTeamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:BuildNewPartnerPassiveSkill(teamEntity, tmpTeamEntity)
end

function PartnerServiceLogic:_DoLogicSetPetIntensifyBuff(tmpTeamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:BuildPetIntensifyBuff(tmpTeamEntity)
end

function PartnerServiceLogic:ReplaceBuffTarget(buffTargetType)
  local isAddingPartner = self._world:Player():IsAddingPartner()
  if isAddingPartner then
    if buffTargetType == BuffTargetType.Team then
      buffTargetType = BuffTargetType.AddPartnerTmpTeam
    elseif buffTargetType == BuffTargetType.AllPet then
      buffTargetType = BuffTargetType.AddPartnerAllPartnerPet
    elseif buffTargetType == BuffTargetType.PetElement then
      buffTargetType = BuffTargetType.AddPartnerAllPartnerPetElement
    elseif buffTargetType == BuffTargetType.PetJob then
      buffTargetType = BuffTargetType.AddPartnerTmpPetJob
    elseif buffTargetType == BuffTargetType.AllTalePet then
      buffTargetType = BuffTargetType.AddPartnerTmpAllTalePet
    elseif buffTargetType == BuffTargetType.AllNonTalePet then
      buffTargetType = BuffTargetType.AddPartnerTmpAllNonTalePet
    else
      buffTargetType = BuffTargetType.None
    end
    return buffTargetType
  else
    return buffTargetType
  end
end

function PartnerServiceLogic:_CalcChoosePartner()
  local battleStatCmpt = self._world:BattleStat()
  local curWaveIndex = battleStatCmpt:GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local cfgMiniMazeWave = levelConfigData:GetMiniMazeWaveCfg(curWaveIndex)
  if not cfgMiniMazeWave then
    return
  end
  if not cfgMiniMazeWave.PartnerGroupID then
    return
  end
  local eachGroupCount = 1
  local choosePartners = {}
  for _, partnerGroupID in ipairs(cfgMiniMazeWave.PartnerGroupID) do
    local partnerGroupCfg = Cfg.cfg_mini_maze_partner_group[partnerGroupID]
    if partnerGroupCfg then
      local arr = partnerGroupCfg.PartnerIDArray
      if arr and 0 < #arr then
        local partnerArray = table.cloneconf(arr)
        partnerArray = self:_CalcValidPartnerDepot(partnerArray)
        local randomSvc = self._world:GetService("RandomLogic")
        for i = 1, eachGroupCount do
          local randomRes = randomSvc:LogicRand(1, #partnerArray)
          local partnerID = partnerArray[randomRes]
          table.insert(choosePartners, partnerID)
        end
      end
    end
  end
  if 0 < #choosePartners then
    local battleStateCmpt = self._world:BattleStat()
    battleStateCmpt:SetWaveOptionalPartnerIDList(curWaveIndex, choosePartners)
    return choosePartners
  end
end

function PartnerServiceLogic:_CalcValidPartnerDepot(groupPartnerArray)
  local partnerArray = groupPartnerArray
  local tmpArr = {}
  local battleStatCmpt = self._world:BattleStat()
  local abandonedList = battleStatCmpt:GetAbandonedPartnerIDList()
  if abandonedList then
    for _, partnerID in ipairs(partnerArray) do
      if not table.icontains(abandonedList, partnerID) then
        table.insert(tmpArr, partnerID)
      end
    end
    partnerArray = tmpArr
  end
  local tmpArr1 = {}
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPets = teamEntity:Team():GetTeamPetEntities()
  local teamPetTemplateIDList = {}
  local bindPetTemplateIDList = {}
  for i, e in ipairs(teamPets) do
    local cPetPstID = e:PetPstID()
    local petTemplateID = cPetPstID:GetTemplateID()
    table.insert(teamPetTemplateIDList, petTemplateID)
    local petCfg = Cfg.cfg_pet[petTemplateID]
    if petCfg and petCfg.BinderPetID then
      table.insert(bindPetTemplateIDList, petCfg.BinderPetID)
    end
  end
  for _, partnerID in ipairs(partnerArray) do
    local partnerCfg = Cfg.cfg_mini_maze_partner_info[partnerID]
    if partnerCfg then
      local partnerPetID = partnerCfg.PetID
      if not table.icontains(teamPetTemplateIDList, partnerPetID) then
        local partnerPetCfg = Cfg.cfg_pet[partnerPetID]
        if partnerPetCfg and (not partnerPetCfg.BinderPetID or not table.icontains(bindPetTemplateIDList, partnerPetCfg.BinderPetID)) then
          table.insert(tmpArr1, partnerID)
        end
      end
    end
  end
  partnerArray = tmpArr1
  return partnerArray
end
