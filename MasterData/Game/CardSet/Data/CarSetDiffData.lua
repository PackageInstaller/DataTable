local CarSetDiffData = class("CarSetDiffData")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")

function CarSetDiffData.CreateDiffData(actId, diffId)
  local diffCfg = ConfigData.activity_card_diff[actId][diffId]
  local data = CarSetDiffData.New(diffId, diffCfg)
  return data
end

function CarSetDiffData:ctor(diffId, diffCfg)
  self.__diffId = diffId
  self.__diffCfg = diffCfg
  if self.__diffCfg.challenge_id > 0 then
    self.__chanllengeDiffData = CarSetDiffData.CreateDiffData(diffCfg.id, diffCfg.challenge_id)
  end
end

function CarSetDiffData:GetCardSetDiffDiffId()
  return self.__diffId
end

function CarSetDiffData:GetIsCardSetDiffUnlock()
  local isUnlock = CheckCondition.CheckLua(self.__diffCfg.pre_condition, self.__diffCfg.pre_para1, self.__diffCfg.pre_para2, self.__diffCfg.pre_para3)
  if not isUnlock then
    return false, CheckCondition.GetUnlockInfoLua(self.__diffCfg.pre_condition, self.__diffCfg.pre_para1, self.__diffCfg.pre_para2, self.__diffCfg.pre_para3)
  end
  return true
end

function CarSetDiffData:GetCardSetDiffLv()
  return self.__diffCfg.difficulty_id
end

function CarSetDiffData:GetCardSetDiffName()
  return LanguageUtil.GetLocaleText(self.__diffCfg.difficulty_name)
end

function CarSetDiffData:GetCardSetBaseReward()
  return self.__diffCfg.reward_value
end

function CarSetDiffData:GetCardSetRewardCoe()
  return self.__diffCfg.reward_coe
end

function CarSetDiffData:GetCardSetBaseScore()
  return self.__diffCfg.score_value
end

function CarSetDiffData:GetCardSetScoreCoe()
  return self.__diffCfg.score_coe
end

function CarSetDiffData:GetCardSetBasePow()
  return self.__diffCfg.combat_value
end

function CarSetDiffData:GetCardSetPowCoe()
  return self.__diffCfg.combat_coe
end

function CarSetDiffData:GetCardSetOfficialSupportId()
  return self.__diffCfg.official_assist
end

function CarSetDiffData:GetCardSetDiffCostBattlePoint()
  return self.__diffCfg.point_deplete
end

function CarSetDiffData:IsCardSetDiffOpenFriend()
  return self.__diffCfg.is_open_friend
end

function CarSetDiffData:IsChallengeCardSetDiff()
  return self.__diffCfg.isCardDiffChallenge
end

function CarSetDiffData:GetCardSetDiffChallengeData()
  return self.__chanllengeDiffData
end

function CarSetDiffData:GetCardSetDiffDes()
  local desStr
  for k, id in ipairs(self.__diffCfg.catalog) do
    local cfg = ConfigData.activity_card_diff_catlog[id]
    if cfg == nil then
      error("cant get activity_card_diff_catlog, id:" .. tostring(id))
    else
      local str = LanguageUtil.GetLocaleText(cfg.catalog_des)
      if desStr == nil then
        desStr = str
      else
        desStr = desStr .. "\n" .. str
      end
    end
  end
  return desStr
end

function CarSetDiffData:GetCardSetDiffBanEffectDic()
  return self.__diffCfg.ban_effect_dic
end

function CarSetDiffData:GetCardSetDiffBanCardIdDic()
  return self.__diffCfg.ban_card_id_dic
end

function CarSetDiffData:GetCardSetDiffHideCardIdDic()
  return self.__diffCfg.hide_card_id_dic
end

return CarSetDiffData
