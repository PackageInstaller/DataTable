local BattleAssetPreloader = System.NewClass("BattleAssetPreloader")
local _PrepareDirector = CS.AMTimeline.AMResourcesCache.PrepareDirector

function BattleAssetPreloader:ctor()
end

function BattleAssetPreloader:StartPreLoadAssets(finishCall)
  function self.callBack()
    if finishCall then
      finishCall()
    end
  end
  
  self:_Clear()
  self:PrepareAllAwakerAnimationAssets()
end

function BattleAssetPreloader:PrepareAllAwakerAnimationAssets()
  self.awakerAnimAssetsLoader = MultiResourcesLoader()
  local assetPaths = {}
  self:PrepareCommonAssets(assetPaths)
  self:PrepareStartTimeline(assetPaths)
  self:PrepareAwakerModelAssets(assetPaths)
  self:PrepareAwakerAnimationAssets(assetPaths)
  self:PrepareKeeperSkillTimeline()
  self.awakerAnimAssetsLoader:Load(assetPaths, self.callBack)
end

function BattleAssetPreloader:PrepareCommonAssets(assetPaths)
  for type, resConfig in pairs(bc.FloatRes) do
    table.insert(assetPaths, resConfig.prefab)
  end
  for k, v in pairs(BattleCommonRes.ResourcesList) do
    table.insert(assetPaths, v)
  end
  for k, v in pairs(BattleCommonRes.ScoolResources) do
    if self:IsScoolExisted(k) then
      for k1, v1 in pairs(v) do
        table.insert(assetPaths, v1)
      end
    end
  end
end

function BattleAssetPreloader:PrepareStartTimeline(assetPaths)
  local battleTid = bg.battleData and bg.battleData.battleTid or 0
  local battleCfg = DT.BattleConfig[battleTid]
  if battleCfg and battleCfg.StartTimeline then
    _PrepareDirector(battleCfg.StartTimeline)
  end
end

function BattleAssetPreloader:PrepareAwakerModelAssets(resPaths)
  local roleDataModelMap = bg.battleDataCenter.roleDataModelMap
  for k, v in pairs(roleDataModelMap) do
    if v.configData then
      local skinId = v:GetSkinId()
      local animationConfig = AwakerDataUtils.GetAwakerAnimationConfig(v.roleType, v.tid, skinId)
      local spineFileName = animationConfig.spineName
      table.insert(resPaths, spineFileName)
    end
  end
end

function BattleAssetPreloader:PrepareAwakerAnimationAssets(resPaths)
  local roleDataModelMap = bg.battleDataCenter.roleDataModelMap
  for k, v in pairs(roleDataModelMap) do
    if v.configData then
      local skinId = v:GetSkinId()
      local animationConfig = AwakerDataUtils.GetAwakerAnimationConfig(v.roleType, v.tid, skinId)
      local spineFileName = animationConfig.spineName
      local spineName = PathStrUtils.GetBaseName(spineFileName)
      if v.roleType == bc.RoleType.Awaker then
        self:PrepareAwakerSkillList(resPaths, animationConfig, spineName, v.configData.SkillList)
      elseif v.roleType == bc.RoleType.Monster then
        for key, keyData in pairs(v.configData) do
          if string.find(key, "SkillList") and keyData then
            self:PrepareAwakerSkillList(resPaths, animationConfig, spineName, keyData)
          end
        end
        self:PrepareMonsterTimeline(spineName)
      end
    end
  end
  for k, v in pairs(roleDataModelMap) do
    if v.configData then
      local skinId = v:GetSkinId()
      local animationConfig = AwakerDataUtils.GetAwakerAnimationConfig(v.roleType, v.tid, skinId)
      self:PrepareSfxAssets(resPaths, animationConfig.attackSfx)
      self:PrepareSfxAssets(resPaths, animationConfig.AttackhitSfxBlister)
      self:PrepareSfxAssets(resPaths, animationConfig.Attack2hitSfxBlister)
      self:PrepareSfxAssets(resPaths, animationConfig.Skill1Sfx)
      self:PrepareSfxAssets(resPaths, animationConfig.Skill1hitSfxBlister)
      self:PrepareSfxAssets(resPaths, animationConfig.Skill2Sfx)
      self:PrepareSfxAssets(resPaths, animationConfig.Skill2hitSfx)
      self:PrepareSfxAssets(resPaths, animationConfig.Skill2hitSfxBlister)
      self:PrepareSfxAssets(resPaths, animationConfig.Skill3Sfx)
      self:PrepareSfxAssets(resPaths, animationConfig.Skill3hitSfx)
      self:PrepareSfxAssets(resPaths, animationConfig.Skill3hitSfxBlister)
      self:PrepareSfxAssets(resPaths, animationConfig.dieSfx)
      self:PrepareSfxAssetById(resPaths, animationConfig.ShieldSfx)
      self:PrepareSfxAssets(resPaths, {
        animationConfig.integer
      })
    end
  end
end

function BattleAssetPreloader:PrepareSfxAssetById(resPaths, sfxId)
  local sfxConfig = DT.BattleSfxConfig[sfxId]
  if sfxConfig and sfxConfig.FileName then
    local sfxFile = bg.battleDataCenter:ReplaceSfxPath(sfxConfig.FileName)
    table.insert(resPaths, sfxFile)
  end
end

function BattleAssetPreloader:PrepareSfxAssets(resPaths, sfxIds)
  if sfxIds then
    for _, sfxId in ipairs(sfxIds) do
      self:PrepareSfxAssetById(resPaths, sfxId)
    end
  end
end

function BattleAssetPreloader:PrepareAwakerSkillList(resPaths, animationConfig, spineName, skillList)
  if not skillList then
    return
  end
  for i = 1, #skillList do
    self:PrepareAwakerSkill(resPaths, animationConfig, spineName, skillList[i])
  end
end

function BattleAssetPreloader:PrepareAwakerSkill(resPaths, animationConfig, spineName, skillId)
  local skillCfg = DT.Skill[skillId]
  if not skillCfg.PerformType or 0 == #skillCfg.PerformType then
    return
  end
  if not skillCfg.Perform then
    return
  end
  for i = 1, #skillCfg.PerformType do
    local performType = skillCfg.PerformType[i]
    if performType == bc.SkillPerformType.Spine then
      local sfxIds = self:GetMonsterAttackSfx(animationConfig, skillCfg.Perform[i])
      self:PrepareSfxAssets(resPaths, sfxIds)
    else
      local timelineData = DT.TimelineEventData[spineName]
      if skillCfg.Perform and skillCfg.Perform[i] and timelineData and timelineData[skillCfg.Perform[i]] then
        _PrepareDirector(timelineData[skillCfg.Perform[i]].file)
      end
    end
  end
end

function BattleAssetPreloader:PrepareMonsterTimeline(spineName)
  local timelineData = DT.TimelineEventData[spineName] or {}
  for _, timelineInfo in pairs(timelineData) do
    _PrepareDirector(timelineInfo.file)
  end
end

function BattleAssetPreloader:PrepareKeeperSkillTimeline()
  local roleDataModelMap = bg.battleDataCenter.roleDataModelMap
  for k, v in pairs(roleDataModelMap) do
    if v.roleType ~= bc.RoleType.Player then
    else
      local skillFile = KeeperSkillUtils.GetSkillTimelinePath(v.keeperSkill)
      if not skillFile then
      else
        _PrepareDirector(skillFile)
        BattleKeeperSkillAssetCache.Instance:SetAsResident(skillFile)
      end
    end
  end
end

function BattleAssetPreloader:GetMonsterAttackSfx(animationConfig, skillPerform)
  local sfxIds
  if skillPerform == bc.SkillPerformName.Attack then
    sfxIds = animationConfig.attackSfx
  elseif skillPerform == bc.SkillPerformName.Skill1 then
    sfxIds = animationConfig.Skill1Sfx
  elseif skillPerform == bc.SkillPerformName.Skill2 then
    sfxIds = animationConfig.Skill2Sfx
  end
  return sfxIds
end

function BattleAssetPreloader:IsScoolExisted(scool)
  local roleDataModelMap = bg.battleDataCenter.roleDataModelMap
  if not roleDataModelMap then
    return false
  end
  for k, v in pairs(roleDataModelMap) do
    if v.roleType == bc.RoleType.Awaker and scool == v.configData.School then
      return true
    end
  end
  return false
end

function BattleAssetPreloader:OnLowMemory()
  if bg.battleRender then
    return
  end
  self:Clear()
end

function BattleAssetPreloader:Clear()
  self:_Clear()
  CS.AMTimeline.AMResourcesCache.RemoveUnusedResources()
end

function BattleAssetPreloader:_Clear()
  if self.awakerAnimAssetsLoader then
    self.awakerAnimAssetsLoader:Clear()
    self.awakerAnimAssetsLoader = nil
  end
end

BattleAssetPreloader.Instance = BattleAssetPreloader()
return BattleAssetPreloader
