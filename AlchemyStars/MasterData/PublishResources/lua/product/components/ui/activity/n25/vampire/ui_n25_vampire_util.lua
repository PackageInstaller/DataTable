_class("UIN25VampireUtil", Object)
UIN25VampireUtil = UIN25VampireUtil

function UIN25VampireUtil.ShowTryPetInfoUI(comp, petId)
  local cfgs = Cfg.cfg_component_bloodsucker_pet_attribute({ComponentID = comp, PetId = petId})
  for _, cfg in pairs(cfgs) do
    local customPetData = UICustomPetData:New(cfg)
    customPetData:SetShowBtnStatus(true)
    customPetData:SetBtnInfoCallback(function()
      GameGlobal.UIStateManager():ShowDialog("UIN25VampireTips")
    end)
    customPetData:SetBtnInfoName("N25_mcwf_btn6")
    GameGlobal.UIStateManager():ShowDialog("UIShopPetDetailController", customPetData:GetPetId(), false, false, false, customPetData)
    return
  end
end

function UIN25VampireUtil.EnterBattle(TT, missionId)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, campaign._id, nil, nil)
    return false
  end
  local localProcess = campaign:GetLocalProcess()
  if not localProcess then
    return false
  end
  campaign:ReLoadCampaignInfo_Force(TT, res)
  UIN25VampireUtil.BloodsuckerComponet = localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  UIN25VampireUtil.BloodsuckerComponentId = UIN25VampireUtil.BloodsuckerComponet:GetComponentCfgId()
  local bloodsuckerInfo = localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  local talentInfo = bloodsuckerInfo.talent_info
  UIN25VampireUtil.SetOldLevel(talentInfo.talent_level)
  UIN25VampireUtil.SetOldExp(talentInfo.cur_exp)
  UIN25VampireUtil.SetOldInfo(talentInfo)
  UIN25VampireUtil.SetOldComponentInfo(bloodsuckerInfo.pass_pet_list)
  local missiontModule = GameGlobal.GetModule(MissionModule)
  local ctx = missiontModule:TeamCtx()
  ctx:InitVampireTeams()
  ctx:Init(TeamOpenerType.Vampire, {
    missionId,
    ECampaignMissionComponentId.ECampaignMissionComponentId_Bloodsucker,
    UIN25VampireUtil.BloodsuckerComponentId
  })
  ctx:ShowDialogUITeams(false)
end

function UIN25VampireUtil.SaveTeamInfo(TT, petids)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, campaign._id, nil, nil)
    return false, false
  end
  local localProcess = campaign:GetLocalProcess()
  if not localProcess then
    return false, false
  end
  campaign:ReLoadCampaignInfo_Force(TT, res)
  local bloodsuckerComponet = localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  local tryPetList = UIN25VampireUtil.GetTryPetList(UIN25VampireUtil.GetComponentConfigId())
  local hasExpire = false
  local petModule = GameGlobal.GetModule(PetModule)
  local petInfos = {}
  for i = 1, #petids do
    local petInfo = PetNodeInfo:New()
    local petId = petids[i]
    local pet = petModule:GetPetByTemplateId(petId)
    if pet then
      petInfo.is_try = false
      petInfo.pet_id = pet:GetTemplateID()
    else
      petInfo.is_try = true
      petInfo.pet_id = petId
      local isFind = false
      if tryPetList then
        for j = 1, #tryPetList do
          if tryPetList[j] == petId then
            isFind = true
            break
          end
        end
      end
      if isFind == false then
        if petInfo.pet_id ~= 0 then
          hasExpire = true
        end
        petInfo.pet_id = 0
        petids[i] = 0
      end
    end
    petInfos[#petInfos + 1] = petInfo
  end
  bloodsuckerComponet:HandleBloodsuckerChangeFormation(TT, res, petInfos)
  if res:GetSucc() then
    return true, hasExpire
  end
  return false, hasExpire
end

function UIN25VampireUtil.GetOldLevel()
  return UIN25VampireUtil.OLD_LEVEL
end

function UIN25VampireUtil.SetOldLevel(level)
  UIN25VampireUtil.OLD_LEVEL = level
end

function UIN25VampireUtil.GetOldExp()
  return UIN25VampireUtil.OLD_EXP
end

function UIN25VampireUtil.SetOldExp(exp)
  UIN25VampireUtil.OLD_EXP = exp
end

function UIN25VampireUtil.GetComponentConfigId()
  return UIN25VampireUtil.BloodsuckerComponentId
end

function UIN25VampireUtil.CreatePetData(tmpId)
  if tmpId <= 0 then
    return nil
  end
  local cfgs = Cfg.cfg_component_bloodsucker_pet_attribute({
    ComponentID = UIN25VampireUtil.GetComponentConfigId(),
    PetId = tmpId
  })
  if cfgs == nil then
    return nil
  end
  for _, cfg in pairs(cfgs) do
    local tmp = _G.pet_data
    local tempData = tmp:New()
    tempData.pet_pstid = tmpId
    tempData.template_id = tmpId
    tempData.current_skin = 0
    local pet = Pet:New(tempData)
    tempData.grade = cfg.Grade
    tempData.level = pet:GetMaxLevel()
    tempData.awakening = cfg.Awakening
    tempData.equip_lv = cfg.Equip
    tempData.affinity_level = pet:GetPetAffinityMaxLevel()
    pet:SetData(tempData)
    return pet
  end
  return nil
end

function UIN25VampireUtil.PetCompleteFirstPass(templateId)
  local info = UIN25VampireUtil.BloodsuckerComponet:GetComponentInfo()
  if not info.pass_pet_list then
    return false
  end
  for i = 1, #info.pass_pet_list do
    if info.pass_pet_list[i] == templateId then
      return true
    end
  end
  return false
end

function UIN25VampireUtil.IsTryPet(templateId)
  local petModule = GameGlobal.GetModule(PetModule)
  local pet = petModule:GetPetByTemplateId(templateId)
  if not pet then
    return true
  end
  return false
end

function UIN25VampireUtil.GetTryPetList(componentConfigId)
  local cfgs = Cfg.cfg_component_bloodsucker_try_pet({ComponentID = componentConfigId})
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local nowTime = timeModule:GetServerTime() / 1000
  local curCfg
  local maxTime = 0
  for k, cfg in pairs(cfgs) do
    local tryTime = loginModule:GetTimeStampByTimeStr(cfg.TryTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    if nowTime > tryTime and maxTime <= tryTime then
      maxTime = tryTime
      curCfg = cfg
    end
  end
  if curCfg then
    return curCfg.PetList
  end
  return {}
end

function UIN25VampireUtil.ShowRewards(rewards, callback)
  local petIdList = {}
  local mPet = GameGlobal.GetModule(PetModule)
  for _, reward in pairs(rewards) do
    if mPet:IsPetID(reward.assetid) then
      table.insert(petIdList, reward)
    end
  end
  if table.count(petIdList) > 0 then
    GameGlobal.UIStateManager():ShowDialog("UIPetObtain", petIdList, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
        if callback then
          callback()
        end
      end)
    end)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
    if callback then
      callback()
    end
  end)
end

function UIN25VampireUtil.SetOldInfo(info)
  UIN25VampireUtil.OLD_INFO = info
end

function UIN25VampireUtil.GetOldInfo()
  return UIN25VampireUtil.OLD_INFO
end

function UIN25VampireUtil.SetOldComponentInfo(info)
  UIN25VampireUtil.OLD_CptInfo = info
end

function UIN25VampireUtil.GetOldComponentInfo()
  return UIN25VampireUtil.OLD_CptInfo
end

function UIN25VampireUtil.GetVampireResultPets(petIds)
  if not petIds then
    return
  end
  local pets = {}
  for index, petId in ipairs(petIds) do
    local pet = VampirePet:New(petId)
    table.insert(pets, pet)
  end
  return pets
end
