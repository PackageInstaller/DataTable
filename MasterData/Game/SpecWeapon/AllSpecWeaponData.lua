local AllSpecWeaponData = class("AllSpecWeaponData")
local SpecWeaponData = require("Game.SpecWeapon.SpecWeaponData")

function AllSpecWeaponData:ctor()
  local systemOpenCfg = ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_SpecWeapon]
  self._screening = systemOpenCfg ~= nil and systemOpenCfg.screening
end

function AllSpecWeaponData:CreateOrUpdateHeroWeapon(heroData, weaponId, step, level)
  if self._screening then
    return
  end
  local specWeapon = heroData:GetHeroDataSpecWeapon(weaponId)
  if specWeapon ~= nil then
    specWeapon:RefreshSpecWeapon(step, level)
  else
    specWeapon = SpecWeaponData.New()
    specWeapon:InitSpecWeapon(weaponId, step, level)
    heroData:BindHeroSpecWeapon(specWeapon)
  end
end

function AllSpecWeaponData:GetHeroSpecWeaponId(heroId)
  if self._screening then
    return nil
  end
  local heroMapping = ConfigData.spec_weapon_basic_config.heroWeaponMapping
  local weaponList = heroMapping[heroId]
  return weaponList ~= nil and weaponList[1] or nil
end

function AllSpecWeaponData:ContainHeroSpecWeapon(heroId)
  return self:GetHeroSpecWeaponId(heroId) ~= nil
end

function AllSpecWeaponData:IsUnlockSpecWeaponSystem()
  if self._screening then
    return false
  end
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SpecWeapon)
end

function AllSpecWeaponData:CreateVistualMaxWeapon(weaponId)
  if self._screening then
    return nil
  end
  local maxStep = ConfigData.spec_weapon_step.stepDic[weaponId]
  local maxLevel = ConfigData.spec_weapon_level.levelDic[weaponId]
  local specWeapon = SpecWeaponData.New()
  specWeapon:InitSpecWeapon(weaponId, maxStep, maxLevel)
  return specWeapon
end

function AllSpecWeaponData:LvupHeroSpecWeapon(weaponId, count, callBack)
  if not self:IsUnlockSpecWeaponSystem() then
    return
  end
  local cfg = ConfigData.spec_weapon_basic_config[weaponId]
  if cfg == nil or not CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
    return
  end
  local heroData = PlayerDataCenter:GetHeroData(cfg.hero_id)
  if heroData == nil then
    return
  end
  local specWeaponData = heroData:GetHeroDataSpecWeapon(weaponId)
  if specWeaponData == nil then
    return
  end
  count = count or 1
  if count == 1 and not specWeaponData:IsSpecWeaponCouldUprage() then
    return
  elseif 1 < count and not specWeaponData:IsSpecWeaponCouldMultipleUprage(count) then
    return
  end
  if self._network == nil then
    self._network = NetworkManager:GetNetwork(NetworkTypeID.SpecWeapon)
  end
  local curStep = specWeaponData:GetSpecWeaponCurStep()
  local curLevel = specWeaponData:GetSpecWeaponCurLevel()
  
  local function successFunc()
    MsgCenter:Broadcast(eMsgEventId.SpecWeaponLvUp)
    if callBack ~= nil then
      callBack()
    end
  end
  
  if curStep == 0 then
    self._network:CS_SpecWeapon_Unlock(weaponId, function()
      successFunc()
    end)
  elseif specWeaponData:IsSpecWeaponContinueStep() then
    self._network:CS_SpecWeapon_Step(weaponId, function()
      successFunc()
    end)
  else
    local targetLevel = specWeaponData:GetSpecWeaponCurLevel() + count
    self._network:CS_SpecWeapon_Upgrade(weaponId, targetLevel, function()
      successFunc()
    end)
  end
end

function AllSpecWeaponData:GetSpecWeaponLevelPointCfg(weaponId)
  return ConfigData.spec_weapon_points
end

function AllSpecWeaponData:IsSpecWeaponCloseQuickEnhanceTip()
  return self._isCloseQuickEnhanceTip
end

function AllSpecWeaponData:SetSpecWeaponCloseQuickEnhanceTip(flag)
  self._isCloseQuickEnhanceTip = flag
end

return AllSpecWeaponData
