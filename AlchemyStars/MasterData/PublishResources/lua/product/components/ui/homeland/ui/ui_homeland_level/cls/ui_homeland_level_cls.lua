_class("UIHomelandLevelData", Object)
UIHomelandLevelData = UIHomelandLevelData

function UIHomelandLevelData:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
end

function UIHomelandLevelData:Init()
  self.liveable = self.mHomeland:GetAmbientValue()
  self.LiveableExps = {}
  for liveable, cfgv in pairs(Cfg.cfg_homeland_sign()) do
    local item = HomelandLevelLiveableExpItemData:New(liveable)
    table.insert(self.LiveableExps, item)
  end
  self.expSources = {}
  for id, cfgv in pairs(Cfg.cfg_homeland_exp_source()) do
    local item = HomelandLevelExpSourceItemData:New(id)
    table.insert(self.expSources, item)
  end
  self:InitLevelData()
end

function UIHomelandLevelData:InitLevelData()
  local clientHomelandInfo = self.mHomeland.m_homeland_info
  self.level = clientHomelandInfo.level
  self.exp = clientHomelandInfo.exp
  local sign_info = clientHomelandInfo.sign_info
  self.awardSign = sign_info.cumulative_rewards
  self.signedToday = self.awardSign == nil or #self.awardSign == 0
  self.levels = {}
  for level, cfgv in ipairs(Cfg.cfg_homeland_level()) do
    local levelData = HomelandLevelItemData:New(level)
    table.insert(self.levels, levelData)
    local cfgvNext = Cfg.cfg_homeland_level[level + 1]
    if cfgvNext then
      levelData.expLow = cfgv.UpgradeCondition
      levelData.expHigh = cfgvNext.UpgradeCondition
    else
      local cfgvPrev = Cfg.cfg_homeland_level[level - 1]
      levelData.expLow = cfgvPrev.UpgradeCondition
      levelData.expHigh = cfgv.UpgradeCondition
    end
    local exist = false
    for _, levelGot in ipairs(sign_info.level_reward_list) do
      if level == levelGot then
        exist = true
        break
      end
    end
    if exist then
      levelData.state = HomelandLevelItemDataState.HasGot
    elseif level <= self.level then
      levelData.state = HomelandLevelItemDataState.CanGet
    else
      levelData.state = nil
    end
    levelData.dormitoryLimit = cfgv.ForgeDormitoryLimit
    levelData.landLimit = cfgv.ForgeLandLimit
    levelData.signReward = cfgv.SignRewardList[1][2]
    levelData.furnitureReward = cfgv.SignRewardList[2][2]
    levelData.livableValueMax = cfgv.LivableValueMax
    levelData.forgeSequenceCount = cfgv.QueueNum
    levelData.awards = {}
    if cfgv.RewardList then
      for index, award in ipairs(cfgv.RewardList) do
        local ra = RoleAsset:New()
        ra.assetid = award[1]
        ra.count = award[2]
        table.insert(levelData.awards, ra)
        if Cfg.cfg_item_architecture_skin[ra.assetid] then
          table.insert(levelData.unlockSkins, ra.assetid)
        end
      end
    end
    table.sort(levelData.awards, function(a, b)
      local colora = Cfg.cfg_item[a.assetid].Color
      local colorb = Cfg.cfg_item[b.assetid].Color
      if colora ~= colorb then
        return colora > colorb
      end
      return a.assetid < b.assetid
    end)
  end
end

function UIHomelandLevelData.CheckCode(result)
  if result == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    return true
  end
  local msg = StringTable.Get("str_homeland_error_code_" .. result)
  ToastManager.ShowHomeToast(msg)
  return false
end

function UIHomelandLevelData:GetLevelDescs(level)
  local res = {}
  local levelData = self:GetHomelandLevelItemDataByLevel(level)
  table.insert(res, StringTable.Get("str_homeland_level_desc_queue_num", levelData.forgeSequenceCount))
  table.insert(res, StringTable.Get("str_homeland_level_desc_dorm_limit", levelData.dormitoryLimit))
  table.insert(res, StringTable.Get("str_homeland_level_desc_land_limit", levelData.landLimit))
  for i = 1, #levelData.unlockSkins do
    local skinCfg = Cfg.cfg_item_architecture_skin[levelData.unlockSkins[i]]
    local skinNameKey = skinCfg.SkinName
    local archNameKey = Cfg.cfg_item_architecture[skinCfg.architecture_id].Name
    table.insert(res, StringTable.Get("str_homeland_level_desc_arch_skin", StringTable.Get(archNameKey), StringTable.Get(skinNameKey)))
  end
  return res
end

function UIHomelandLevelData:GetHomelandLevelLiveableExpItemDataByLiveable(liveable)
  for _, le in ipairs(self.LiveableExps) do
    if le.liveable == liveable then
      return le
    end
  end
end

function UIHomelandLevelData:GetHomelandLevelExpSourceItemDataById(id)
  for _, source in ipairs(self.expSources) do
    if source.id == id then
      return source
    end
  end
end

function UIHomelandLevelData:GetHomelandLevelItemDataByLevel(level)
  for _, levelData in ipairs(self.levels) do
    if levelData.level == level then
      return levelData
    end
  end
end

function UIHomelandLevelData:IsLevelMax()
  if Cfg.cfg_homeland_level[self.level + 1] then
    return false
  end
  return true
end

function UIHomelandLevelData:HasAward2Get()
  return self:HasLevelAward() or self:HasSignAward()
end

function UIHomelandLevelData:HasLevelAward()
  for _, levelData in ipairs(self.levels) do
    if levelData.state == HomelandLevelItemDataState.CanGet then
      return true
    end
  end
  return false
end

function UIHomelandLevelData:HasSignAward()
  local hasAwards = false
  for i = 1, #self.awardSign do
    if self.awardSign[i].count > 0 then
      hasAwards = true
    end
  end
  return not self.signedToday and hasAwards
end

function UIHomelandLevelData:HasSignedToday()
  return self.signedToday
end

function UIHomelandLevelData:CheckSignedToday()
  if self.signedToday then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_level_has_signed_today"))
  end
  return self.signedToday
end

function UIHomelandLevelData:OnLevelInfoChange(deltaLevel)
  self:InitLevelData()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandLevelOnLevelInfoChange, deltaLevel, self.level)
end

function UIHomelandLevelData:GetNextSignTime()
  local clientHomelandInfo = self.mHomeland.m_homeland_info
  local sign_info = clientHomelandInfo.sign_info
  local stampNextSign = sign_info.next_refresh_time
  return stampNextSign
end

_class("HomelandLevelLiveableExpItemData", Object)
HomelandLevelLiveableExpItemData = HomelandLevelLiveableExpItemData

function HomelandLevelLiveableExpItemData:Constructor(liveable)
  self.liveable = liveable
  local cfgv = Cfg.cfg_homeland_sign[liveable]
  self.exp = cfgv.Exp
end

_class("HomelandLevelExpSourceItemData", Object)
HomelandLevelExpSourceItemData = HomelandLevelExpSourceItemData

function HomelandLevelExpSourceItemData:Constructor(id)
  self.id = id
  local cfgv = Cfg.cfg_homeland_exp_source[id]
  self.name = StringTable.Get(cfgv.Name)
  self.details = {}
  if cfgv.Params then
    for _, param in ipairs(cfgv.Params) do
      local str = StringTable.Get(param[1], param[2])
      table.insert(self.details, str)
    end
  end
end

_class("HomelandLevelItemData", Object)
HomelandLevelItemData = HomelandLevelItemData

function HomelandLevelItemData:Constructor(level)
  self.level = level
  self.expLow = 0
  self.expHigh = 0
  self.state = nil
  self.dormitoryLimit = 0
  self.landLimit = 0
  self.signReward = 0
  self.furnitureReward = 0
  self.livableValueMax = 0
  self.forgeSequenceCount = 0
  self.unlockSkins = {}
  self.awards = {}
  local mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = mHomeland:GetHomelandLevelData()
end

_enum("HomelandLevelItemDataState", {HasGot = 1, CanGet = 2})
HomelandLevelItemDataState = HomelandLevelItemDataState
