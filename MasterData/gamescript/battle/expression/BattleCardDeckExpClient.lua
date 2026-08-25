local BattleCardDeckExpClient, Super = System.NewClass("BattleCardDeckExpClient", BaseExpression)
local EmptyCard

function BattleCardDeckExpClient:ctor(cmdParser, deckName)
  Super.ctor(self)
  self.deckName = deckName
  self.cmdParser = cmdParser
  self.memberValues = {}
  self.cmdFuncs = {}
  self.cardList = self:_GenerateCardList(deckName)
  Super.InitGetter(self)
end

function BattleCardDeckExpClient:_GenerateCardList(deckName)
  if not bg.battleScene then
    return {}
  end
  local camp = self.cmdParser:GetMyCamp()
  if string.find(deckName, "Enemy") then
    camp = bc.BattleCamp:GetEnemyCamp(camp)
    deckName = string.replace(deckName, "Enemy", "", false)
    self.cardDeck = deckName
  end
  if bg.isPVE then
    camp = bc.BattleCamp.Camp1
  end
  self.camp = camp
  local deckNameList = string.split(deckName, "And")
  local cardList = {}
  for _, cardDeck in ipairs(deckNameList) do
    local cardMgr = bg.battleRender.cardMgr
    if bg.isPVP then
      cardMgr = bg.battleRender.cardMgr:GetCardMgrByCamp(camp)
    end
    local list = cardMgr:GetCardListByDeck(cardDeck, camp)
    for _, card in ipairs(list) do
      table.insert(cardList, card)
    end
  end
  return cardList
end

function BattleCardDeckExpClient:GetAttr(attrName)
  if "CardCount" == attrName then
    return #self.cardList
  end
  if "GetCardByType" == attrName then
    do return self._GetEmptyCard end
    return self._GetEmptyCard, self
  end
  return 0
end

function BattleCardDeckExpClient:_GetEmptyCard()
  if not EmptyCard then
    EmptyCard = {}
    local mt = {
      __index = function()
        return 0
      end
    }
    setmetatable(EmptyCard, mt)
  end
  return EmptyCard
end

function BattleCardDeckExpClient:DefaultFunc(funcName)
  if "GetCardByType" == funcName then
    do return self._GetEmptyCard end
    return self._GetEmptyCard, self
  end
  return 0
end

return BattleCardDeckExpClient
