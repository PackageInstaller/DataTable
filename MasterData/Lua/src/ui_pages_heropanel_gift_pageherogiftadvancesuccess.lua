local this = class("pageHeroGiftAdvanceSuccess", G_UIPageBase)
local talentRankTpl = L_GameTpl:getTalentRankTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local attId = {
  L_Const.battleAtt.MAXHP,
  L_Const.battleAtt.ATK,
  L_Const.battleAtt.DEF,
  L_Const.battleAtt.MDEF
}

function this.bind()
  return {
    advanceSucceedCurLv = "",
    advanceSucceedNextLv = "",
    breakSkillContentActive = false,
    breakSkillList = {
      moduleName = "pages/HeroPanel/hero/cellBreakSuccessSkill"
    },
    advancePropertyList = {
      moduleName = "pages/HeroPanel/hero/heroProperty"
    },
    list_rankStar = {
      moduleName = "modulePages/cellRankStar"
    }
  }
end

function this.methods()
  return {
    onClick_closeAdvance = function(self)
      if L_UI:checkPageOpen("pageHeroGiftAdvanceSuccess") then
        L_UI:close("pageHeroGiftAdvanceSuccess")
      end
    end
  }
end

function this:preOpen(options)
  self.heroId = 0
  if options then
    self.heroId = options.heroId
  end
  self:starGiftsAdvance()
end

function this:close()
end

function this:starGiftsAdvance()
  self.bind.advanceProperty = ""
  local hero = L_HeroStore:getHero(self.heroId)
  local heroRank = L_HeroStore:getHeroRank(hero)
  local rankCfg = talentRankTpl:getMaxTpl(L_HeroStore:getHeroConfigId(hero))
  local heroMaxRank = talentRankTpl:getRank(rankCfg)
  local heroLevel = L_HeroStore:getHeroLevel(hero)
  local rankData = talentRankTpl:getHeroRankTpls(L_HeroStore:getHeroConfigId(hero))
  local lv = string.format("%02d", heroLevel)
  local heroId = self.heroId
  self.bind.advanceSucceedCurLv = tostring(rankData[heroRank - 1].rankLevelLimit)
  self.bind.advanceSucceedNextLv = tostring(rankData[heroRank].rankLevelLimit)
  local tmp = {}
  for i = 1, heroMaxRank do
    table.insert(tmp, {heroRank = heroRank, id = i})
  end
  self.bind.list_rankStar:clear()
  self.bind.list_rankStar:insert_array(tmp)
  local oldRank = heroRank - 1
  local newRank = heroRank
  local property = {}
  local heroConfigAtt = L_AttributeManager:parseHeroConfigAtt(heroId, lv)
  local heroStarConfigAtt = L_HeroManager:getHeroStarGiftByHeroIdAndRank(L_HeroStore:getHeroConfigId(hero), newRank, {})
  local mergeAttr = L_AttributeManager:mergeAttDic(heroConfigAtt, heroStarConfigAtt)
  local baseAtt = {}
  for i, v in pairs(attId) do
    local id, value = L_AttributeManager:getHeroAttValue(mergeAttr, v)
    property[v] = value
    baseAtt[v] = true
  end
  for i, v in pairs(heroStarConfigAtt) do
    local group, value = L_AttributeManager:getHeroAttValue(mergeAttr, i)
    if not baseAtt[group] then
      property[group] = value
    end
  end
  local propertyHeroLv = {}
  heroConfigAtt = L_AttributeManager:parseHeroConfigAtt(heroId, lv)
  local tpl = talentRankTpl:getHeroRankTpl(L_HeroStore:getHeroConfigId(hero), oldRank)
  heroStarConfigAtt = L_HeroManager:getHeroStarGiftByHeroIdAndRank(L_HeroStore:getHeroConfigId(hero), oldRank, talentRankTpl:getRankBreakthroughItem(tpl))
  mergeAttr = L_AttributeManager:mergeAttDic(heroConfigAtt, heroStarConfigAtt)
  for i, v in pairs(attId) do
    local id, value = L_AttributeManager:getHeroAttValue(mergeAttr, v)
    propertyHeroLv[v] = value
  end
  for i, v in pairs(mergeAttr) do
    local group, value = L_AttributeManager:getHeroAttValue(mergeAttr, i)
    if not baseAtt[group] then
      propertyHeroLv[group] = value
    end
  end
  self.bind.advancePropertyList:clear()
  local propertyData = {}
  local previewAttId = {}
  for i, v in ipairs(attId) do
    table.insert(previewAttId, v)
  end
  for i, v in pairs(property) do
    if not baseAtt[i] then
      table.insert(previewAttId, i)
    end
  end
  for i, v in pairs(previewAttId) do
    local bgBool = false
    if math.floor(i % 2) > 0 then
      bgBool = true
    end
    local currentProperty = property[v] or 0
    local currentPropertyHeroLv = propertyHeroLv[v] or 0
    local addNum = currentProperty - currentPropertyHeroLv
    local tpl = battleInfoTpl:getTplById(v)
    if not (addNum <= 0) then
      table.insert(propertyData, {
        toggle_state = not bgBool,
        curAttr = battleInfoTpl:getShowTxtComma(previewAttId[i], propertyHeroLv[previewAttId[i]] or 0),
        nextAttr = battleInfoTpl:getShowTxtComma(previewAttId[i], property[previewAttId[i]] or 0),
        name = battleInfoTpl:getName(tpl),
        icon = battleInfoTpl:getIcon(tpl),
        active_icon = true,
        id = previewAttId[i]
      })
    end
  end
  L_HeroManager:sortAttrId(propertyData)
  self.bind.advancePropertyList:insert_array(propertyData)
  self:setBreakSkillList()
end

function this:setBreakSkillList()
  local hero = L_HeroStore:getHero(self.heroId)
  local heroRank = L_HeroStore:getHeroRank(hero)
  local rankData = talentRankTpl:getHeroRankTpls(L_HeroStore:getHeroConfigId(hero))
  local rankTpl = rankData[heroRank]
  if not rankTpl then
    return
  end
  local skills = rankTpl.skill
  self.bind.breakSkillContentActive = true
  self.bind.breakSkillList:clear()
  local breakSkillData = {}
  for _, skillId in ipairs(skills) do
    table.insert(breakSkillData, {
      skillId = skillId,
      heroId = self.heroId
    })
  end
  self.bind.breakSkillList:insert_array(breakSkillData)
  self.bind.breakSkillContentActive = not table.isEmpty(breakSkillData)
end

return this
