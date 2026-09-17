local this = class("gameConstTpl")
local game_table = G_Tables.TDGameTable

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getValue(key, isNumber, default)
  local val = self.data[key]
  local data = game_table.GetData(key)
  local type = type(data)
  if val == nil then
    return default
  end
  if isNumber then
    return tonumber(val)
  else
    return val
  end
end

function this:getData(key, typeId, default)
  typeId = typeId or L_Const.GameTplType.int
  local val = game_table.GetData(key)
  if val == nil then
    return default
  end
  local data = L_GameUtil.convertValue(val, typeId)
  return data
end

function this:getMaleDefaultHeroConfigId()
  return self:getData("AVATAR_HERO_ID_MALE", L_Const.GameTplType.int)
end

function this:getFemaleDefaultHeroConfigId()
  return self:getData("AVATAR_HERO_ID_FEMALE", L_Const.GameTplType.int)
end

function this:getMaleDefaultHeroUnitId()
  return self:getData("AVATAR_UNIT_ID_MALE", L_Const.GameTplType.int)
end

function this:getFemaleDefaultHeroUnitId()
  return self:getData("AVATAR_UNIT_ID_FEMALE", L_Const.GameTplType.int)
end

function this:getFriendLimit()
  local val = self:getData("FRIEND_LIMITS", L_Const.GameTplType.list_int)
  return val and val[1] or nil
end

function this:getFriendApplicationLimit()
  local val = self:getData("FRIEND_LIMITS", L_Const.GameTplType.list_int)
  return val and val[2] or nil
end

function this:getBlackListLimit()
  local val = self:getData("FRIEND_LIMITS", L_Const.GameTplType.list_int)
  return val and val[3] or nil
end

function this:getFriendMarkLimit()
  return self:getData("PLAYER_NAME_MAX", L_Const.GameTplType.int)
end

function this:getReportDescLimit()
  return self:getData("REPORT_USER_NUM", L_Const.GameTplType.int)
end

function this:getFriendChatCD()
  return self:getData("CHAT_FRIENDS_CD", L_Const.GameTplType.int)
end

function this:getWorldChatCD()
  return self:getData("CHAT_WROLD_CD", L_Const.GameTplType.int)
end

function this:getTeamChatCD()
  return self:getData("CHAT_TEAM_CD", L_Const.GameTplType.int)
end

function this:getCityChatCD()
  return self:getData("CHAT_MAP_CD", L_Const.GameTplType.int)
end

function this:getPartyChatCD()
  return self:getData("CHAT_PARTY_CD", L_Const.GameTplType.int)
end

function this:getRecommandNumMaxLimit()
  return self:getData("FRIENDS_RECOMMENDED_RANGE_NUM", L_Const.GameTplType.int)
end

function this:getWorldChannelChatMaxLimit()
  return self:getData("CHAT_PLAYER_RECORDS_NUM_LOCAL", L_Const.GameTplType.int)
end

function this:getMaxChat()
  return self:getData("CHAT_MAX", L_Const.GameTplType.int)
end

function this:getPlayerRecordMaxNum()
  return self:getData("CHAT_PLAYER_RECORDS_NUM_LOCAL", L_Const.GameTplType.int)
end

function this:getChatFreqLimit()
  return self:getData("CHAT_FREQUENCY", L_Const.GameTplType.list_int)
end

function this:getChatSpamParam()
  return self:getData("CHAT_SPAM", L_Const.GameTplType.list_list_int)
end

function this:getHomeFoodStorage()
  return self:getData("HOME_CANTEEN_BASIC_STORAGE", L_Const.GameTplType.int)
end

function this:getEntrustStaminaReward()
  return self:getData("DUNGEON_ENTRUST_STAMINA_REWARD", L_Const.GameTplType.list_int)
end

function this:getEquipMentScoreFormulaParam()
  return self:getData("EQUIPMENT_SCORE_FORMULA_PARAM", L_Const.GameTplType.list_int)
end

function this:getMultiDungeonGrade()
  return self:getData("MULIT_DUNGEON_GRADE", L_Const.GameTplType.list_list_int)
end

function this:getMultiDungoenFeeLimit()
  return self:getData("DUNGEON_ADMISSION_FEE_LIMIT", L_Const.GameTplType.list_int)
end

function this:getSpecialMultiDungoenFeeLimit()
  return self:getData("SPECIAL_DUNGEON_ADMISSION_FEE_LIMIT", L_Const.GameTplType.list_int)
end

function this:getUiBookGetPlayTime()
  return self:getData("UI_BOOK_GET_PLAYTIME", L_Const.GameTplType.int)
end

function this:getUiAchievementCompletePlayTime()
  return self:getData("UI_ACHIEVEMENT_COMPLETE_PLAYTIME", L_Const.GameTplType.int)
end

function this:getJourneyFlyShowTime()
  return self:getData("UI_TRAVEL_COMPLETE_PLAYTIME", L_Const.GameTplType.int)
end

function this:getOptionLanguage()
  return self:getData("option_language", L_Const.GameTplType.list_string)
end

function this:getCurrencyElementList()
  return self:getData("ELEMENT_CURRENCY_SINGLE", L_Const.GameTplType.list_int)
end

function this:getJourneyUnlockFlyShowTime()
  return self:getData("UI_TRAVEL_UNLOCK_PLAYTIME", L_Const.GameTplType.int)
end

function this:getNestShopCurrencyBar()
  return self:getData("NESTCOOP_SHOP_BAR", L_Const.GameTplType.list_int)
end

function this:getNestcoopWindowTimeUrge()
  return self:getData("NESTCOOP_WINDOW_TIME_URGE", L_Const.GameTplType.int)
end

function this:getConnectPower()
  return self:getData("CONNECT_POWER", L_Const.GameTplType.int)
end

function this:getWeeklyDungeonLimit()
  return self:getData("Weeklychallengetimes", L_Const.GameTplType.int)
end

return this
