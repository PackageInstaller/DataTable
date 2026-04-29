_class("UIDrawCardViewData", Object)
UIDrawCardViewData = UIDrawCardViewData

function UIDrawCardViewData:Constructor(cards, duplicateTag, type, poolID, fixed_reward)
  self._cards = cards
  self._shakeType = type
  self._poolID = poolID
  self._fixedReward = fixed_reward
  self._petNewTab = {}
  self._star = {}
  self._items = {}
  local items = {}
  local star = 0
  local maxStarId = 0
  local module = GameGlobal.GetModule(PetModule)
  if self._shakeType == ShakeType.SHAKE_MULTIPLE then
    for idx, value in ipairs(cards) do
      local cfg = Cfg.cfg_pet[value.assetid]
      if star < cfg.Star then
        star = cfg.Star
        maxStarId = value.assetid
      end
      self._star[idx] = cfg.Star
      local isDuplicate = duplicateTag[idx] == PET_RESULT_CODE.PET_ADD_EXP_ONLY
      if isDuplicate then
        for i = 1, #cfg.ExchangeItem do
          local val = string.split(cfg.ExchangeItem[i], ",")
          local id = tonumber(val[1])
          local count = tonumber(val[2])
          if items[id] then
            items[id].count = items[id].count + count
          else
            local asset = RoleAsset:New()
            asset.assetid = id
            asset.count = count
            items[id] = asset
          end
        end
        local coinCfg = Cfg.cfg_pet_coin({
          PetID = value.assetid
        })
        if coinCfg and 0 < #coinCfg then
          coinCfg = coinCfg[1]
          local pet = module:GetPetByTemplateId(value.assetid)
          local times = pet:RepeatGetTimes()
          if coinCfg.CoinRewardCount then
            times = math.min(times, #coinCfg.CoinRewardCount)
            local id = coinCfg.CoinID
            local count = coinCfg.CoinRewardCount[times]
            if items[id] then
              items[id].count = items[id].count + count
            else
              local asset = RoleAsset:New()
              asset.assetid = id
              asset.count = count
              items[id] = asset
            end
          end
        end
      end
      self._petNewTab[idx] = not isDuplicate
      Log.fatal("多抽结果：" .. "[" .. idx .. "]:id->", value.assetid .. "，" .. cfg.Star .. "星" .. "，新获得：", not isDuplicate)
    end
    local idx = 1
    for key, value in pairs(items) do
      self._items[idx] = value
      idx = idx + 1
    end
  else
    local cfg = Cfg.cfg_pet[cards[1].assetid]
    star = cfg.Star
    maxStarId = cards[1].assetid
    local isDuplicate = duplicateTag[1] == PET_RESULT_CODE.PET_ADD_EXP_ONLY
    self._petNewTab[1] = not isDuplicate
    Log.fatal("单抽结果：" .. "[" .. 1 .. "]:id->", cfg.ID .. "，" .. star .. "星" .. "，新获得：", not isDuplicate)
    self._star[1] = star
  end
  if self._fixedReward and self._fixedReward[1] then
    local asset = {}
    asset.assetid = self._fixedReward[1].assetid
    asset.count = self._fixedReward[1].count
    asset.heartstone = true
    table.insert(self._items, 1, asset)
  end
  self._maxStar = star
  self.maxStarId = maxStarId
end

function UIDrawCardViewData:GetShakeType()
  return self._shakeType
end

function UIDrawCardViewData:GetCards()
  return self._cards
end

function UIDrawCardViewData:GetItems()
  return self._items
end

function UIDrawCardViewData:GetPoolID()
  return self._poolID
end

function UIDrawCardViewData:GetMaxStar()
  return self._maxStar
end

function UIDrawCardViewData:GetMaxStarId()
  return self.maxStarId
end

function UIDrawCardViewData:IsNewPet(idx)
  return self._petNewTab[idx]
end

function UIDrawCardViewData:GetUnskipCards(start)
  start = start or 1
  local t = {}
  for i = start, #self._cards do
    local isNew = self:IsNewPet(i)
    local star = self._star[i]
    if 4 < star and isNew then
      t[#t + 1] = self._cards[i]
    end
  end
  return t
end
