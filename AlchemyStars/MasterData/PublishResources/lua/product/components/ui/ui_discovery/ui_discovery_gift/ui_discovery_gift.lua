_class("UIDiscoveryGift", UICustomWidget)
UIDiscoveryGift = UIDiscoveryGift

function UIDiscoveryGift:Constructor()
end

function UIDiscoveryGift:OnShow()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._shopModule = GameGlobal.GetModule(ShopModule)
  self._GiftData, self._GiftCfg = self._shopModule:GetGiftMarketData()
  self:AttachEvent(GameEventType.ActivityCurrencyBuySuccess, self.OnCurrencyBuySuccess)
  self:AttachEvent(GameEventType.MidasPayError, self.OnCurrencyBuyError)
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
end

function UIDiscoveryGift:OnCurrencyBuySuccess(gotid)
  Log.debug("###[lxs] OnCurrencyBuySuccess")
  GameGlobal.TaskManager():StartTask(self.RequestGiftData, self, gotid)
end

function UIDiscoveryGift:RequestGiftData(TT, gotid)
  self:Lock("UIDiscoveryGift:RequestGiftData")
  local resGift = self._shopModule:ApplyGiftMarketData(TT)
  self:UnLock("UIDiscoveryGift:RequestGiftData")
  if resGift:GetSucc() then
    self._GiftData, self._GiftCfg = self._shopModule:GetGiftMarketData()
    self:RefreshPool(gotid)
  else
    local result = resGift:GetResult()
    Log.error("###[UIDiscoveryGift] ApplyGiftMarketData fail ! result:", result)
  end
end

function UIDiscoveryGift:OnCurrencyBuyError()
  Log.debug("###[lxs] OnCurrencyBuyError")
  self:RefreshPool()
end

function UIDiscoveryGift:OnHide()
  self:UnLock("UIDiscoveryGift:RequestGiftData")
end

function UIDiscoveryGift:SetData(hide)
  self._shopModule = GameGlobal.GetModule(ShopModule)
  self._hide = hide
  self:RefreshPool()
  self:AutoShowGiftController()
end

local localkey = "UIDiscoveryGift"

function UIDiscoveryGift:AutoShowGiftController()
  self._module = self:GetModule(MissionModule)
  self._data = self._module:GetDiscoveryData()
  local firstMissionID = self._data.firstMissionID
  if not firstMissionID then
    return
  end
  if self._innerList and next(self._innerList) then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstid = roleModule:GetPstId()
    local show
    for index, value in ipairs(self._innerList) do
      local giftid = value.gift_id
      local cfg_gift = Cfg.cfg_shop_giftmarket_goods[giftid]
      local LockMission = cfg_gift.LockMission
      if LockMission and 0 < LockMission and firstMissionID == LockMission then
        local key = localkey .. giftid .. pstid
        local val = LocalDB.GetInt(key, 0)
        if val == 0 then
          local good = value
          local cfgv = self._GiftCfg[giftid]
          self:ShowDialog("UIDiscoveryGiftController", good, cfgv)
          LocalDB.SetInt(key, 1)
          break
        end
      end
    end
  end
end

function UIDiscoveryGift:RefreshPool(gotid)
  if not self._hide then
    self:GetGameObject():SetActive(true)
    local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    local svrTime = svrTimeModule:GetServerTime() * 0.001
    local giftList = self._GiftData.goods
    local showList = {}
    local cfgs = Cfg.cfg_shop_giftmarket_goods({})
    for k, v in pairs(giftList) do
      local giftid = v.gift_id
      local cfg = cfgs[giftid]
      local type = cfg.GiftType
      if type == ShopGiftType.SGT_CommonTime then
        table.insert(showList, v)
      end
    end
    Log.debug("###[UIDiscoveryGift] start show gift list ! count:", table.count(showList))
    if showList and next(showList) then
      self._innerList = {}
      for index, value in ipairs(showList) do
        Log.debug("###[UIDiscoveryGift] giftList gift id :", value.gift_id)
        if value.deadline_time > 0 and 0 < math.floor(value.deadline_time - svrTime) then
          Log.debug("###[UIDiscoveryGift] innerList gift id :", value)
          if gotid and gotid == value.gift_id then
            Log.debug("###[UIDiscoveryGift] gotid : ", gotid)
          else
            table.insert(self._innerList, value)
          end
        end
      end
      local len = #self._innerList
      self._pool:SpawnObjects("UIDiscoveryGiftItem", len)
      local pools = self._pool:GetAllSpawnList()
      for i = 1, len do
        local item = pools[i]
        local good = self._innerList[i]
        local cfgv = self._GiftCfg[good.gift_id]
        item:SetData(good, cfgv, function()
          self:RefreshPool()
        end)
      end
      return true
    end
  end
  self:GetGameObject():SetActive(false)
end
