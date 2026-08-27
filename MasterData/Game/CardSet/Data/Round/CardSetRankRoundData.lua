local CardSetRankRoundData = class("CardSetRankRoundData")

function CardSetRankRoundData:ctor(roundCfg)
  self._roundCfg = roundCfg
end

function CardSetRankRoundData:UpdCsRankRoundData(storageMsg)
  self._highestScore = 0
  self._heroMsgList = table.emptytable
  self._fairyMsg = nil
  self._inVerify = nil
  self._locked = storageMsg.locked
  local roundMsg = storageMsg.curRoundData and storageMsg.curRoundData.rankData
  if roundMsg == nil then
    return
  end
  self._highestScore = roundMsg.score
  self._inVerify = roundMsg.checking
  if roundMsg.form then
    self._heroMsgList = roundMsg.form.heroes
    self._fairyMsg = roundMsg.form.fairy
  end
end

function CardSetRankRoundData:GetCsRankRoundId()
  return self._roundCfg.round_id
end

function CardSetRankRoundData:GetCsRankRoundDes()
  return LanguageUtil.GetLocaleText(self._roundCfg.round_des)
end

function CardSetRankRoundData:GetCsRankRoundScore()
  return self._highestScore
end

function CardSetRankRoundData:IsExistCsRankRoundHeroLock()
  return #self._heroMsgList > 0
end

function CardSetRankRoundData:GetCsRankRoundHeroList()
  local HeroData = require("Game.PlayerData.Hero.HeroData")
  local heroDataList = {}
  table.sort(self._heroMsgList, function(a, b)
    return a.formIdx < b.formIdx
  end)
  for k, v in ipairs(self._heroMsgList) do
    local heroCfg = ConfigData.hero_data[v.heroId]
    local heroData = HeroData.New({
      basic = {
        id = v.heroId,
        level = v.level,
        exp = 0,
        star = v.rank,
        potentialLvl = 0,
        ts = -1,
        career = heroCfg.career,
        company = heroCfg.camp,
        skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(0, v.heroId)
      }
    })
    table.insert(heroDataList, heroData)
  end
  return heroDataList
end

function CardSetRankRoundData:GetCsRankRoundLocked()
  return self._locked
end

function CardSetRankRoundData:GetCsRankRoundFairyData()
  if self._fairyMsg == nil then
    return nil
  end
  local fairyRankMsg = self._fairyMsg
  local fairyMsg = {
    base = {
      uid = 1,
      dataId = fairyRankMsg.id,
      level = fairyRankMsg.level,
      exp = 0,
      rank = fairyRankMsg.rank,
      name = nil,
      favor = false
    },
    skill = {
      data = {}
    }
  }
  local num = 0
  for k, v in pairs(fairyRankMsg.skill) do
    num = num + 1
    table.insert(fairyMsg.skill.data, {
      id = k,
      grades = v,
      slot = num
    })
  end
  local FairyData = require("Game.Fairy.Data.FairyData")
  local fairyData = FairyData.GenFairyData(fairyMsg)
  return fairyData
end

function CardSetRankRoundData:CardSetRankScoreIsVerify(score)
  return score > self._roundCfg.rank_check_value
end

function CardSetRankRoundData:CardSetRankRoundIsInVerify()
  return self._inVerify
end

return CardSetRankRoundData
