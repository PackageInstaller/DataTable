_class("LLBuffLogicRandomCard", LLBuffLogicBase)
LLBuffLogicRandomCard = LLBuffLogicRandomCard

function LLBuffLogicRandomCard:Constructor(buffObj, logicParam)
  self.cardPoolID = logicParam.cardPoolID
  self.castNum = logicParam.castNum
  if self.castNum == nil then
    self.castNum = 3
  end
end

function LLBuffLogicRandomCard:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  self.cardDataList = LuckLandData:GetInstance():CurCardDatas()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    local randCardCastNum = LocalDB.GetInt("LLBuffLogicRandomCard_Count")
    if randCardCastNum == nil then
      randCardCastNum = 0
    end
    randCardCastNum = randCardCastNum + 1
    if randCardCastNum >= self.castNum then
      self:DoLogicSingle(target)
      LocalDB.SetInt("LLBuffLogicRandomCard_Count", 0)
    else
      LocalDB.SetInt("LLBuffLogicRandomCard_Count", randCardCastNum)
    end
  end
end

function LLBuffLogicRandomCard:DoLogicSingle(target)
  local module = GameGlobal:GetLuckLandModule()
  local poolList = {}
  poolList[1] = self.cardPoolID
  local cards = module:RandomCards(poolList, 1)
  for i = 1, #cards do
    local cardID = cards[i]
    local name = StringTable.Get(cardID._cfg.CardName)
    ToastManager.ShowToast(StringTable.Get("str_luckland_make_fantsy_card", name))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandSelectCard, cardID._cfg.ID, 1)
    local mgr = LuckLandInnerGameHelper.GetEntityMgr()
    if mgr then
      local pets = mgr:GetBackpackPets()
      if pets then
        local lastPet = pets[#pets]
        if lastPet then
          self.cardDataList:AddCardData(cardID._cfg.ID, lastPet:ID(), 1)
        end
      end
    end
  end
end
