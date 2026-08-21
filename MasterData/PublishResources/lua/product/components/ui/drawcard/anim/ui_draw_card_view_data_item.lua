_class("UIDrawCardViewDataItem", Object)
UIDrawCardViewDataItem = UIDrawCardViewDataItem

function UIDrawCardViewDataItem:Constructor(id)
  self._id = id
  local cfg = Cfg.cfg_pet[self._id]
  self._star = cfg.Star
end

function UIDrawCardViewDataItem:ID()
  return self._id
end

function UIDrawCardViewDataItem:IsDuplicate()
  return self._isDuplicate
end

function UIDrawCardViewDataItem:Star()
  return self._star
end

function UIDrawCardViewDataItem:ConvertItems()
  return self._convertItems
end

function UIDrawCardViewDataItem:SetDuplicate(isDuplicate, times)
  self._isDuplicate = isDuplicate
  if self._isDuplicate then
    local items = {}
    local coinCfg = Cfg.cfg_pet_coin({
      PetID = self._id
    })
    local module = GameGlobal.GetModule(PetModule)
    if coinCfg and 0 < #coinCfg then
      coinCfg = coinCfg[1]
      local pet = module:GetPetByTemplateId(self._id)
      local times = pet:RepeatGetTimes() - times + 1
      if coinCfg.CoinRewardCount then
        times = math.min(times, #coinCfg.CoinRewardCount)
        local id = coinCfg.CoinID
        local count = coinCfg.CoinRewardCount[times]
        items[#items + 1] = NewRoleAsset(id, count)
      end
    end
    local cfg = Cfg.cfg_pet[self._id]
    for i = 1, #cfg.ExchangeItem do
      local val = string.split(cfg.ExchangeItem[i], ",")
      local id = tonumber(val[1])
      local count = tonumber(val[2])
      items[#items + 1] = NewRoleAsset(id, count)
    end
    self._convertItems = items
  end
end
