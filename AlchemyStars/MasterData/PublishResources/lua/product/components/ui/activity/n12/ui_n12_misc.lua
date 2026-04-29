local N12LevelType = {Daily = 1, Challenge = 2}
_enum("N12LevelType", N12LevelType)
local NormalLevelType = {
  Easy = 1,
  Normal = 2,
  Hard = 3
}
_enum("NormalLevelType", NormalLevelType)
local HardLevelType = {
  Easy = 1,
  Normal = 2,
  Hard = 3,
  Nightmare = 4,
  Hell = 5
}
_enum("HardLevelType", HardLevelType)
local GainType = {Friend = 1, Enemy = 2}
_enum("GainType", GainType)
local ElementIcon = {
  "bing_color",
  "huo_color",
  "sen_color",
  "lei_color"
}
_enum("ElementIcon", ElementIcon)
local HardLevelTypeText = {
  [HardLevelType.Easy] = "str_n12_btn_easy",
  [HardLevelType.Normal] = "str_n12_btn_normal",
  [HardLevelType.Hard] = "str_n12_btn_hard",
  [HardLevelType.Nightmare] = "str_n12_btn_nightmare",
  [HardLevelType.Hell] = "str_n12_btn_hell"
}
_enum("HardLevelTypeText", HardLevelTypeText)
local GainType = {Friend = 1, Enemy = 2}
_enum("GainType", GainType)
local GainTypeSprite = {
  [GainType.Friend] = "n12_citiao_icon_zengyi",
  [GainType.Enemy] = "n12_citiao_icon_jianyi"
}
_enum("GainTypeSprite", GainTypeSprite)
local HardLevelInfoItemType = {
  [true] = {
    [true] = "UIN12HardLevelItem",
    [false] = "UIN12HardLevelScoreItem"
  },
  [false] = {
    [true] = "UIN12HardLevelItemArray",
    [false] = "UIN12HardLevelScoreItemArray"
  }
}
_enum("HardLevelInfoItemType", HardLevelInfoItemType)
local HardLevelCellImg = {
  "n12_tiaozhan_bossicon_1",
  "n12_tiaozhan_bossicon_3",
  "n12_tiaozhan_bossicon_5",
  "n12_tiaozhan_bossicon_2",
  "n12_tiaozhan_bossicon_4"
}
_enum("HardLevelCellImg", HardLevelCellImg)
local N12ToolFunctions = {
  GetRemainTime = function(time)
    local day, hour, minute
    day = math.floor(time / 86400)
    hour = math.floor(time / 3600) % 24
    minute = math.floor(time / 60) % 60
    local timestring = ""
    if 0 < day then
      timestring = day .. StringTable.Get("str_activity_common_day")
      if 0 < hour then
        timestring = timestring .. hour .. StringTable.Get("str_activity_common_hour")
      end
    elseif 0 < hour then
      timestring = hour .. StringTable.Get("str_activity_common_hour")
      if 0 < minute then
        timestring = timestring .. minute .. StringTable.Get("str_activity_common_minute")
      end
    elseif 0 < minute then
      timestring = minute .. StringTable.Get("str_activity_common_minute")
    else
      timestring = StringTable.Get("str_activity_common_less_minute")
    end
    return timestring
  end,
  GetBossCfgs = function(campaignMissionId)
    local bossCfgs
    local cfg_campaign_mission = Cfg.cfg_campaign_mission[campaignMissionId]
    if not cfg_campaign_mission then
      return bossCfgs
    end
    local cfg_level = Cfg.cfg_level[cfg_campaign_mission.FightLevel]
    if not cfg_level then
      return bossCfgs
    end
    local cfg_monster = Cfg.cfg_monster
    local cfg_monster_class = Cfg.cfg_monster_class
    for i = 1, #cfg_level.MonsterWave do
      local cfg_monster_wave = Cfg.cfg_monster_wave[cfg_level.MonsterWave[i]]
      if cfg_monster_wave then
        local cfg_refresh = Cfg.cfg_refresh[cfg_monster_wave.WaveBeginRefreshID]
        if cfg_refresh then
          local cfg_refresh_monster = Cfg.cfg_refresh_monster[cfg_refresh.MonsterRefreshIDList[1]]
          if cfg_refresh_monster then
            for key, value in pairs(cfg_refresh_monster.MonsterIDList) do
              local cfg_monster_temp = cfg_monster[value]
              if cfg_monster_temp then
                local cfg_monster_class_temp = cfg_monster_class[cfg_monster_temp.ClassID]
                if cfg_monster_class_temp and cfg_monster_class_temp.MonsterType == MonsterType.Boss then
                  if bossCfgs == nil then
                    bossCfgs = {}
                  end
                  table.insert(bossCfgs, cfg_monster_temp)
                end
              end
            end
          end
        end
      end
    end
    return bossCfgs
  end,
  GetAffixDesc = function(affixCfg)
    local params = {}
    if affixCfg.EntryParam and affixCfg.EntryParam[1] then
      for key, value in ipairs(affixCfg.EntryParam[1]) do
        if type(value) == "string" then
          params[#params + 1] = StringTable.Get(value)
        elseif type(value) == "number" then
          params[#params + 1] = value
        end
      end
    end
    return StringTable.Get(affixCfg.Desc, table.unpack(params))
  end,
  GetLocalDBInt = function(key, defaultValue)
    local loginModule = GameGlobal.GetModule(LoginModule)
    return LocalDB.GetInt(key .. loginModule:GetRoleShowID(), defaultValue)
  end,
  SetLocalDBInt = function(key, value)
    local loginModule = GameGlobal.GetModule(LoginModule)
    return LocalDB.SetInt(key .. loginModule:GetRoleShowID(), value)
  end,
  SetAffixText = function(localizationText, affixCfg)
    local text = localizationText
    text:SetText(N12ToolFunctions.GetAffixDesc(affixCfg))
    text.fontSize = 28
    text.lineSpacing = 0.76
    text.resizeTextMinSize = 24
    text.resizeTextMaxSize = 28
    local settings = text:GetGenerationSettings(text.rectTransform.rect.size)
    local textGenerator = text.cachedTextGenerator
    textGenerator:Invalidate()
    textGenerator:Populate(text.text, settings)
    UnityEngine.Canvas.ForceUpdateCanvases()
    if textGenerator.lines.Count >= 3 then
      local language = Localization.GetCurLanguage()
      if language == LanguageType.idn or language == LanguageType.us then
        text.fontSize = 24
        text.lineSpacing = 0.7
        text.resizeTextMinSize = 22
        text.resizeTextMaxSize = 24
      end
    end
  end
}
_enum("N12ToolFunctions", N12ToolFunctions)
local N12OperationRecordKey = {
  NormalLevelType = "NormalLevelType",
  HardLevelIndex = "HardLevelIndex",
  HardLevelType = "HardLevelType",
  OldMaxScore = "OldMaxScore",
  NewMaxScore = "NewMaxScore",
  ShowChallengeTaskRewards = "ShowChallengeTaskRewards",
  EnteredEntrust = "EnteredEntrust"
}
_enum("N12OperationRecordKey", N12OperationRecordKey)
