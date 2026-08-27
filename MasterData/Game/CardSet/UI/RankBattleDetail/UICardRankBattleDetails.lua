local base = UIBaseWindow
local UICardRankBattleDetails = class("UICardRankBattleDetails", base)
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local UINUserTitle = require("Game.CommonUI.Title.UINNormalTitleItem")
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local UINCardSetCardItemWithName = require("Game.CardSet.UI.RankBattleDetail.UINCardSetCardItemWithName")
local CardSetCardData = require("Game.CardSet.Data.CardSetCardData")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local UINCardSetBtFloat = require("Game.CardSet.UI.BattleResult.UINCardSetBtFloat")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local UINFairyHeadItem = require("Game.Fairy.UI.Common.UINFairyHeadItem")
local UINCardSetRoundTogItem = require("Game.CardSet.UI.RankBattleDetail.UINCardSetRoundTogItem")
local CardSetUtil = require("Game.CardSet.CardSetUtil")
local CS_ResLoader = CS.ResLoader

function UICardRankBattleDetails:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnClickClose)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack()
  self._heroItem = UINUserHead.New()
  self._heroItem:Init(self.ui.uINUserHead)
  self._userTitle = UINUserTitle.New()
  self._userTitle:Init(self.ui.uINAppellation)
  self._heroItemPool = UIItemPool.New(UINHeroHeadWithStarItem, self.ui.uINHeroHeadWithStar, false)
  self._envItemPool = UIItemPool.New(UINCardSetCardItemWithName, self.ui.envItem, false)
  self._togItemPool = UIItemPool.New(UINCardSetRoundTogItem, self.ui.tog_item, false)
  self._resLoader = CS_ResLoader.Create()
  self._longPressFunc = BindCallback(self, self._OnCardLongPress)
  self._pressUpFunc = BindCallback(self, self._OnCardPressUp)
  self.fairyHead = UINFairyHeadItem.New()
  self.fairyHead:Init(self.ui.fairyHeadItem)
  self.fairyHead:SetFairyHeadItemLvShow(true)
end

function UICardRankBattleDetails:InitCardRankBattleDetails(rankAvatar, cardMsgList, rankId)
  self.isHaveMultRound = 1 < #cardMsgList
  self.ui.point:SetActive(self.isHaveMultRound)
  self.ui.toggleGroup:SetActive(self.isHaveMultRound)
  if not self.isHaveMultRound then
    self:__RefreshRoundInfo(cardMsgList[1], rankAvatar, rankId)
    self.ui.tex_BattlePoint.text = tostring(cardMsgList[1].score)
  else
    local totalScore = 0
    local maxScoreIndex = 1
    local maxScore = -1, self._togItemPool:HideAll()
    table.sort(cardMsgList, function(a, b)
      local aRound = a.round
      local bRound = b.round
      if aRound == 0 then
        aRound = math.maxinteger
      end
      if bRound == 0 then
        bRound = math.maxinteger
      end
      if aRound ~= bRound then
        return aRound < bRound
      end
      return a.eid < b.eid
    end)
    for index, cardMsg in ipairs(cardMsgList) do
      totalScore = totalScore + cardMsg.score
      if maxScore < cardMsg.score then
        maxScore = cardMsg.score
        maxScoreIndex = index
      end
      local togItem = self._togItemPool:GetOne()
      togItem:InitCardRankTogItem(index, function()
        self:__RefreshRoundInfo(cardMsg, rankAvatar, rankId)
      end, function()
        self:__SelectRound(index)
      end)
    end
    self.ui.tex_BattlePoint.text = tostring(totalScore)
    self:__SelectRound(maxScoreIndex)
  end
end

function UICardRankBattleDetails:__SelectRound(index)
  for _, item in pairs(self._togItemPool.listItem) do
    item:SetCardRankTogItemIsSelected(item.index == index)
  end
end

function UICardRankBattleDetails:__RefreshRoundInfo(cardMsg, rankAvatar, rankId)
  self.ui.tex_PlayerName.text = rankAvatar.name
  self._heroItem:InitUserHeadUI(rankAvatar.avatarId, rankAvatar.avatarFrame, self._resLoader)
  local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
  self._titleBgAtlas = self._resLoader:LoadABAsset(atlasPath)
  if rankAvatar.title and rankAvatar.title.titlePrefix ~= 0 then
    self._userTitle:Show()
    self._userTitle:InitNormalTitleItem(rankAvatar.title.titlePrefix, rankAvatar.title.titlePostfix, rankAvatar.title.titleBackGround, self._resLoader, self._titleBgAtlas)
  else
    self._userTitle:Hide()
  end
  local isEmpty = cardMsg.difficulty == 0
  if isEmpty then
    self.ui.tex_Diff.text = "-"
    self.ui.tex_Point.text = "-"
    self.ui.tex_Additon:SetIndex(1, "-")
    self.ui.tex_Time.text = "-"
    self._heroItemPool:HideAll()
    self.fairyHead:Hide()
    self._envItemPool:HideAll()
    return
  end
  self.ui.tex_Diff.text = CardSetUtil.GetCardSetDiffName(rankId, cardMsg.difficulty)
  self.ui.tex_Point.text = tostring(cardMsg.score)
  self.ui.tex_Additon:SetIndex(0, tostring(cardMsg.scoreCoe / 10))
  self.ui.tex_Time.text = tostring(BattleUtil.FrameToTimeString(cardMsg.frame, true))
  self._heroItemPool:HideAll()
  local onBattleHeros = {}
  if cardMsg.form then
    for key, rankHero in ipairs(cardMsg.form.heroes) do
      table.insert(onBattleHeros, rankHero)
    end
    table.sort(onBattleHeros, function(a, b)
      return a.formIdx < b.formIdx
    end)
  end
  for k, v in ipairs(onBattleHeros) do
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
    local heroItem = self._heroItemPool:GetOne()
    heroItem:InitHead(heroData, true)
  end
  if cardMsg.form and cardMsg.form.fairy then
    local fairyRankMsg = cardMsg.form.fairy
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
    self.fairyHead:InitFairyHeadItem(fairyData, self._resLoader)
    self.fairyHead:Show()
    self.fairyHead.transform:SetAsLastSibling()
  else
    self.fairyHead:Hide()
  end
  local cardDataList = {}
  local actId = ConfigData.activity_card_main.cardRankId2ActIdMap[rankId]
  if cardMsg.selectInfo then
    for k, v in ipairs(cardMsg.selectInfo.data) do
      local cardData = CardSetCardData.CreateCardDataByIdAndData(actId, v.cardId, v.cardUid)
      if cardData then
        cardData:SetCardEffectId(v.param)
        table.insert(cardDataList, cardData)
      end
    end
  end
  table.sort(cardDataList, function(a, b)
    local typeA = a:GetCardSetCardType()
    local typeB = b:GetCardSetCardType()
    if typeA ~= typeB then
      return typeA < typeB
    end
    return a:GetCardSetCardId() < b:GetCardSetCardId()
  end)
  self._envItemPool:HideAll()
  for k, cardData in ipairs(cardDataList) do
    if cardData:GetCardSetCardType() == CardSetEnum.eCardType.Buff then
    else
      local item = self._envItemPool:GetOne()
      item:InitCardSetCardItemWithName(cardData, self._resLoader, self._longPressFunc, self._pressUpFunc)
    end
  end
end

function UICardRankBattleDetails:_OnCardLongPress(cardItem, cardData)
  if self._floatNode == nil then
    self._floatNode = UINCardSetBtFloat.New()
    self._floatNode:Init(self.ui.obj_Details)
  end
  self._floatNode:InitCardSetBtFloat(cardItem.transform, cardData, self._resLoader)
  self._floatNode:Show()
end

function UICardRankBattleDetails:_OnCardPressUp(cardItem, cardData)
  if self._floatNode then
    self._floatNode:Hide()
  end
end

function UICardRankBattleDetails:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UICardRankBattleDetails:_BackAction()
  self:Delete()
end

function UICardRankBattleDetails:OnDelete()
  self._heroItemPool:DeleteAll()
  self.fairyHead:Delete()
  if self._resLoader then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  if self._floatNode then
    self._floatNode:Delete()
    self._floatNode = nil
  end
  base.OnDelete(self)
end

return UICardRankBattleDetails
