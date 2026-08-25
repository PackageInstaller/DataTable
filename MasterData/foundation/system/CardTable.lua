local CardTable = {}
CardTable.CardAttribute = {
  Consume = "Consume",
  Nothingness = "Nothingness",
  CardDestroy = "CardDestroy",
  Inherent = "Inherent",
  Useless = "Useless",
  Canttrans = "Canttrans",
  Cantbetrans = "Cantbetrans",
  CantRemove = "CantRemove",
  NoDiscard = "NoDiscard",
  Joker = "Joker",
  Reserve = "Reserve",
  CantDuplicate = "CantDuplicate",
  DuplicateInHand = "DuplicateInHand",
  UltiEnergyAll = "UltiEnergyAll",
  UltiEnergyDouble = "UltiEnergyDouble",
  Offend = "Offend",
  Actors = "Actors",
  Shell = "Shell",
  Defense = "Defense",
  Gland = "Gland",
  FromConfigString = function(self, configStr)
    if "Consume" == configStr then
      return self.Consume
    elseif "Useless" == configStr then
      return self.Useless
    elseif "CardDestroy" == configStr then
      return self.CardDestroy
    elseif "Nothingness" == configStr then
      return self.Nothingness
    elseif "Inherent" == configStr then
      return self.Inherent
    elseif "Canttrans" == configStr then
      return self.Canttrans
    elseif "Cantbetrans" == configStr then
      return self.Cantbetrans
    elseif "CantRemove" == configStr then
      return self.CantRemove
    elseif "Offend" == configStr then
      return self.Offend
    elseif "NoDiscard" == configStr then
      return self.NoDiscard
    elseif "Actors" == configStr then
      return self.Actors
    elseif "Joker" == configStr then
      return self.Joker
    elseif "Reserve" == configStr then
      return self.Reserve
    elseif "Shell" == configStr then
      return self.Shell
    elseif "CantDuplicate" == configStr then
      return self.CantDuplicate
    elseif "Defense" == configStr then
      return self.Defense
    elseif "DuplicateInHand" == configStr then
      return self.DuplicateInHand
    elseif "Gland" == configStr then
      return self.Gland
    end
  end,
  ToConfigString = function(self, config)
    if config == self.Consume then
      return "Consume"
    elseif config == self.Useless then
      return "Useless"
    elseif config == self.CardDestroy then
      return "CardDestroy"
    elseif config == self.Nothingness then
      return "Nothingness"
    elseif config == self.Inherent then
      return "Inherent"
    elseif config == self.Canttrans then
      return "Canttrans"
    elseif config == self.Cantbetrans then
      return "Cantbetrans"
    elseif config == self.CantRemove then
      return "CantRemove"
    elseif config == self.Offend then
      return "Offend"
    elseif config == self.NoDiscard then
      return "NoDiscard"
    elseif config == self.Actors then
      return "Actors"
    elseif config == self.Joker then
      return "Joker"
    elseif config == self.Reserve then
      return "Reserve"
    elseif config == self.Shell then
      return "Shell"
    elseif config == self.CantDuplicate then
      return "CantDuplicate"
    elseif config == self.Defense then
      return "Defense"
    elseif config == self.DuplicateInHand then
      return "DuplicateInHand"
    elseif config == self.Gland then
      return "Gland"
    end
  end
}
CardTable._schoolCards = {}
CardTable._upgradeCards = {}
CardTable._canUpgradeCards = {}
CardTable._typeCards = {}
CardTable._rareCards = {}
CardTable._cardTids = {}
CardTable._canTransCards = {}
CardTable._canChooseTransCards = {}
CardTable._cantRemoves = {}
CardTable._subTypeCards = {}
CardTable._cantDuplicate = {}

function CardTable.Init(force)
  if CardTable.isInit and not force then
    return
  end
  CardTable.isInit = true
  for _, v in pairs(DT.Item) do
    if 5 ~= v.Type then
    else
      local schools = CommonUtils.GetTableValue(CardTable._schoolCards, v.SchoolID)
      if not schools[v.ID] then
        schools[v.ID] = 1
      end
      local can_upgrads = CommonUtils.GetTableValue(CardTable._canUpgradeCards, v.UpgradeCard > 0 and 1 or 0)
      if not can_upgrads[v.ID] then
        can_upgrads[v.ID] = 1
      end
      local upgrades = CommonUtils.GetTableValue(CardTable._upgradeCards, v.IsUpgrade and 1 or 0)
      if not upgrades[v.ID] then
        upgrades[v.ID] = 1
      end
      local types = CommonUtils.GetTableValue(CardTable._typeCards, v.CardTypes)
      if not types[v.ID] then
        types[v.ID] = 1
      end
      local rares = CommonUtils.GetTableValue(CardTable._rareCards, v.Quality or "")
      if not rares[v.ID] then
        rares[v.ID] = 1
      end
      local subTypes = CommonUtils.GetTableValue(CardTable._subTypeCards, v.SubType)
      if not subTypes[v.ID] then
        subTypes[v.ID] = 1
      end
      if v.CardSpecialAttrs then
        for _, group in ipairs(v.CardSpecialAttrs) do
          local attrID = group
          if attrID == CardTable.CardAttribute.CantTrans then
            CardTable._canChooseTransCards[v.ID] = true
          elseif attrID == CardTable.CardAttribute.CantBetrans then
            CardTable._canTransCards[v.ID] = true
          elseif attrID == CardTable.CardAttribute.CantRemove then
            CardTable._cantRemoves[v.ID] = true
          elseif attrID == CardTable.CardAttribute.CantDuplicate then
            CardTable._cantDuplicate[v.ID] = true
          end
        end
      end
    end
  end
end

return CardTable
