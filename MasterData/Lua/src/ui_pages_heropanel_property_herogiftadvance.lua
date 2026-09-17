local this = class("heroGiftAdvance", G_UIModuleBase)
local talentRankTpl = L_GameTpl:getTalentRankTpl()

function this.bind()
  return {
    currentLv = "",
    advanceLv = "",
    requireLv = "",
    gold = "",
    heroInfo = true,
    heroInfo_advanceBtn = true,
    list_rankStar = {
      moduleName = "modulePages/cellRankStar"
    },
    unlockDesText = "",
    unlockDesTextActive = false,
    go_giftPropList = true,
    go_giftPropVX = true,
    giftPropList = {
      moduleName = "pages/HeroPanel/gift/cellGiFtProp"
    }
  }
end

function this.methods()
  return {
    onClick_advance = function(self)
      if not self.boolGold then
        L_HeroManager:heroHintInfo(1)
        return
      elseif not self.boolLv then
        local data_tip = {
          txtContent = L_WordsTpl:getValue("notice_stargift_jump"),
          confirmCallback = handler(self, self.changeToProperty)
        }
        L_GameUtil.showCommonTip(data_tip)
        return
      elseif not self:checkGiftIsFull() then
        L_HeroManager:heroHintInfo(7)
        return
      end
      local heroId = self.parent:getHeroId()
      local data = {u32 = heroId}
    end,
    giftPropList = {
      openGiftsBg = function(self, itemId, itemType)
        L_ItemTplManager:showInfoTip(itemType, itemId)
      end
    },
    onClick_TalentBtn = function(self)
      local hero = self.parent:getHero()
      L_HeroManager:showHeroSelection(L_Const.heroModuleType.Talent, L_HeroStore:getHeroGuid(hero))
    end
  }
end

function this:changeToProperty()
  self.parent:onSelectionChange(L_Const.heroModuleType.Property, {openExp = true})
end

function this:checkGiftIsFull()
  local heroId = self.parent:getHeroId()
  local hero = self.parent:getHero(heroId)
  local heroRank = L_HeroStore:getHeroRank(hero)
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local rankData = talentRankTpl:getHeroRankTpls(heroConfigId)
  local rankBreakthroughItem = rankData[heroRank].rankBreakthroughItem
  if heroRank - 1 == self:getMaxRank(heroConfigId) then
    return false
  end
  for _, v in ipairs(rankBreakthroughItem) do
    local itemId, itemNeedNum = v[2], v[3]
    local itemNum = L_ItemManager:parseCommonItem(itemId).num
    if itemNeedNum > itemNum then
      return false
    end
  end
  return true
end

function this:getMaxRank(heroId)
  local rankData = talentRankTpl:getHeroRankTpls(heroId)
  return #rankData - 1
end

function this:refreshPage()
  local heroId = self.parent:getHeroId()
  local hero = self.parent:getHero(heroId)
  local heroRank = L_HeroStore:getHeroRank(hero)
  local heroLevel = L_HeroStore:getHeroLevel(hero)
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local rankCfg = talentRankTpl:getMaxTpl(heroConfigId)
  local heroMaxRank = talentRankTpl:getRank(rankCfg)
  local rankData = talentRankTpl:getHeroRankTpls(heroConfigId)
  self.bind.heroInfo = true
  self.parent:setHeroInfo({
    lv = heroLevel,
    exp = L_HeroStore:getHeroExp(hero),
    addExp = 0,
    rank = heroRank + 1,
    isShowBreakSkill = true
  })
  self:refreshGiveOrAdvacnce()
  self:checkPlayerLevelSatisified(heroRank)
  if heroRank - 1 == self:getMaxRank(heroConfigId) then
    return
  end
  local lv = L_HeroManager:lvChange(heroLevel)
  self.bind.currentLv = "Lv." .. L_HeroManager:lvChange(rankData[heroRank].rankLevelLimit)
  self.bind.advanceLv = "Lv." .. L_HeroManager:lvChange(rankData[heroRank + 1].rankLevelLimit)
  self.boolLv, self.bind.requireLv = self:checkRequiredLevel(hero, rankData)
  self.boolGold, self.bind.gold = self:checkGoldRequirement(hero, rankData)
  local tmp = {}
  for i = 1, heroMaxRank do
    table.insert(tmp, {
      heroRank = heroRank + 1,
      id = i
    })
  end
  self.bind.list_rankStar:clear()
  self.bind.list_rankStar:insert_array(tmp)
  self:refreshGiftList()
end

function this:checkRequiredLevel(hero, rankData)
  local requiredLevel = rankData[L_HeroStore:getHeroRank(hero)].rankLevelLimit
  if requiredLevel <= L_HeroStore:getHeroLevel(hero) then
    return true, tostring(requiredLevel)
  else
    return false, L_GameUtil.fillColor(requiredLevel, L_Const.colorHtml.red001)
  end
end

function this:checkGoldRequirement(hero, rankData)
  local requiredGold = rankData[L_HeroStore:getHeroRank(hero)].rankBreakthroughCoin
  if requiredGold <= L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold) then
    return true, tostring(requiredGold)
  else
    return false, L_GameUtil.fillColor(requiredGold, L_Const.colorHtml.red001)
  end
end

function this:checkPlayerLevelSatisified(rank)
  local heroId = self.parent:getHeroId()
  local hero = self.parent:getHero(heroId)
  local giftIsFull = self:checkGiftIsFull()
  if not giftIsFull then
    self.bind.unlockDesTextActive = false
  end
  local isNotMax = rank - 1 ~= self:getMaxRank(L_HeroStore:getHeroConfigId(hero))
  if not giftIsFull and isNotMax then
    self.bind.unlockDesTextActive = false
  end
  local bCompelte = true
  self.bind.heroInfo_advanceBtn = bCompelte
  self.bind.unlockDesTextActive = not bCompelte
  if not bCompelte then
    self.bind.unlockDesText = L_ConditionManager:getSingleDesc(condition)
  end
end

function this:refreshGiveOrAdvacnce()
  local giftIsFull = true
  local heroId = self.parent:getHeroId()
  local hero = self.parent:getHero(heroId)
  local isNotMax = L_HeroStore:getHeroRank(hero) - 1 ~= self:getMaxRank(L_HeroStore:getHeroConfigId(hero))
  self.bind.heroInfo_advanceBtn = giftIsFull and isNotMax
end

function this:refreshGiftList()
  local heroId = self.parent:getHeroId()
  local hero = self.parent:getHero(heroId)
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local heroRank = L_HeroStore:getHeroRank(hero)
  local rankData = talentRankTpl:getHeroRankTpls(heroConfigId)
  local rankBreakthroughItem = rankData[heroRank].rankBreakthroughItem
  local hasMaxRank = heroRank - 1 == self:getMaxRank(heroConfigId)
  self.bind.go_giftPropList = not hasMaxRank
  self.bind.go_giftPropVX = not hasMaxRank
  self.bind.giftPropList:clear()
  local tempData = {}
  for i, v in ipairs(rankBreakthroughItem) do
    local pos = self.bindComponents["cellGiftItemPos" .. i] and self.bindComponents["cellGiftItemPos" .. i].anchoredPosition or L_Vector3.getTemp()
    local itemType = v[1]
    local itemId = v[2]
    local itemNeedNum = v[3]
    local item = L_ItemManager:parseCommonItem(itemId)
    local itemNum = item.num
    local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
    tempData[i] = {
      id = itemId,
      itemType = itemType,
      equipIcon = conf.icon,
      transPosition = pos,
      num = string.format("%d/%d", itemNum, itemNeedNum)
    }
  end
  self.bind.giftPropList:insert_array(tempData)
end

return this
