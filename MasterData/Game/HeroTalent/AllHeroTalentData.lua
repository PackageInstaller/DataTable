local AllHeroTalentData = class("AllHeroTalentData")
local HeroTalentData = require("Game.HeroTalent.HeroTalentData")

function AllHeroTalentData:ctor()
  self._modelCfgDic = {}
  self._dic = {}
end

function AllHeroTalentData:InitHeroTalent()
  if ConfigData.buildinConfig.HeroTalentForbid then
    return false
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Talent) then
    return
  end
  local talentCfg = ConfigData.hero_talent
  for heroId, cfg in pairs(talentCfg) do
    local hero = PlayerDataCenter.heroDic[heroId]
    if hero ~= nil and hero.level >= ConfigData.game_config.heroTalentUnlockLevel then
      local data = HeroTalentData.New(cfg)
      self._dic[heroId] = data
      hero:BindHeroDataTalent(data)
    end
  end
end

function AllHeroTalentData:TryCreateAndBindHeroTalentByHeroId(heroId)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Talent) then
    return
  end
  local cfg = ConfigData.hero_talent[heroId]
  if cfg == nil then
    return
  end
  local hero = PlayerDataCenter.heroDic[heroId]
  if hero == nil or hero.level < ConfigData.game_config.heroTalentUnlockLevel then
    return
  end
  local data = HeroTalentData.New(cfg)
  self._dic[heroId] = data
  hero:BindHeroDataTalent(data)
end

function AllHeroTalentData:UpdateHeroTalent(msg)
  if msg == nil then
    return
  end
  for heroId, talent in pairs(msg) do
    local heroTalentData = self._dic[heroId]
    if heroTalentData == nil then
      error("talent is nil, heroId is " .. tostring(heroId))
    else
      heroTalentData:UpdateHeroTalent(talent)
      MsgCenter:Broadcast(eMsgEventId.HeroTalentLvUp, heroId)
    end
  end
end

function AllHeroTalentData:SetHeroTalentBranch(heroId, nodeId, branchId)
  local heroTalentData = self._dic[heroId]
  if heroTalentData == nil then
    return
  end
  heroTalentData:SetHeroTalentBranchInData(nodeId, branchId)
  MsgCenter:Broadcast(eMsgEventId.HeroTalentLvUp, heroId)
end

function AllHeroTalentData:GetHeroTalent(heroId)
  if self._dic == nil then
    return nil
  end
  return self._dic[heroId]
end

function AllHeroTalentData:HeroTalentIsSystemOpen(heroId)
  if ConfigData.buildinConfig.HeroTalentForbid then
    return false
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Talent) then
    return false
  end
  return ConfigData.hero_talent[heroId] ~= nil
end

function AllHeroTalentData:GetHeroTalentModelCfg(modelId)
  local cfg = self._modelCfgDic[modelId]
  if cfg ~= nil then
    return cfg
  end
  local path = "HeroTalentModelConfig.hero_talent_model_" .. tostring(modelId)
  local ok, err = pcall(function()
    cfg = require(path)
    cfg.modelPath = path
    self._modelCfgDic[modelId] = cfg
    return true
  end)
  if not ok then
    error("Can't get HeroTalentModelCfg, path = " .. path .. ",\n" .. tostring(err))
    return nil
  end
  return cfg
end

function AllHeroTalentData:RemoveHeroTalentModelCfg(modelId)
  local cfg = self._modelCfgDic[modelId]
  if cfg == nil then
    return
  end
  self._modelCfgDic[modelId] = nil
  package.loaded[cfg.modelPath] = nil
end

return AllHeroTalentData
