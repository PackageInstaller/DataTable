_class("UICN20N49Ryza_Shop", UIController)
UICN20N49Ryza_Shop = UICN20N49Ryza_Shop

function UICN20N49Ryza_Shop:Constructor()
  self._poolCount = Cfg.cfg_global.AlchemyShopShelfCount.IntValue or 3
  self._cellCount = 9
  self._curPoolIdx = 1
  self._maxCount = Cfg.cfg_global.AlchemyShopShelfMax.IntValue or 100
  self._shelfInfo = {}
  self._topid = Cfg.cfg_global.AlchemyMoneyItemID.IntValue
  self._isSelling = false
end

function UICN20N49Ryza_Shop:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_N20
  local componentIds = {
    ECampaignCN20ComponentID.ECN20_ALCHEMY
  }
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  self._com = self._campaign:GetComponent(ECampaignCN20ComponentID.ECN20_ALCHEMY)
  self._comCfgID = self._com:GetComponentCfgId()
  self.personProcess = UICN20N49Helper.GetComponent(self._campaign, "alchemyShop")
end

function UICN20N49Ryza_Shop:OnShow()
  self:InitWidgets()
  self:RefreshPoolInfo()
  self:_CheckGuide()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UICN20N49Ryza_Shop:InitWidgets()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._poolName = self:GetUIComponent("UILocalizationText", "poolName")
  self._topTex = self:GetUIComponent("UILocalizationText", "topTex")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, function()
    self:ShowDialog("UIIntroLoader", "UICN20N49AlchemyShopIntro", MaskType.MT_BlurMask)
  end, nil, true)
  local toptips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._toptipsInfo = toptips:SpawnObject("UITopTipsContext")
  self._anim = self:GetUIComponent("Animation", "UICN20N49Ryza_Shop")
  self._btn1go = self:GetUIComponent("CanvasGroup", "btn1go")
  self._btn2go = self:GetUIComponent("CanvasGroup", "btn2go")
  self._needGoldText = self:GetUIComponent("UILocalizationText", "NeedGold")
  self._progressRedGO = self:GetGameObject("ProgressRed")
  self._needGoldImageGO = self:GetGameObject("NeedGoldImage")
  self:RefreshProgress()
  self:SetBtnState()
end

function UICN20N49Ryza_Shop:RefreshProgress()
  local needLevelUPGold = self.personProcess:GetNextLevelNeedProgress()
  if needLevelUPGold <= 0 then
    self._needGoldText:SetText("")
    self._needGoldImageGO:SetActive(false)
  else
    self._needGoldImageGO:SetActive(true)
    self._needGoldText:SetText(StringTable.Get("str_cn20_n49_shop_progress_cur_need_gold", needLevelUPGold))
  end
  local red = UICN20N49Helper.CalcRed_Component(self._campaign, "alchemyShop")
  self._progressRedGO:SetActive(red)
end

function UICN20N49Ryza_Shop:SetBtnState(anim)
  if anim then
    local animName = self._isSelling and "uieffanim_UICN20N49Ryza_Shop_1out2in" or "uieffanim_UICN20N49Ryza_Shop_1in2out"
    self._anim:Play(animName)
  else
    local color1 = self._isSelling and 0 or 1
    local color2 = self._isSelling and 1 or 0
    self._btn1go.alpha = color1
    self._btn2go.alpha = color2
  end
  self._btn1go.blocksRaycasts = not self._isSelling
  self._btn2go.blocksRaycasts = self._isSelling
end

function UICN20N49Ryza_Shop:PoolBtnOnClick(go)
  self._curPoolIdx = self._curPoolIdx + 1
  if self._curPoolIdx > self._poolCount then
    self._curPoolIdx = 1
  end
  self:RefreshPoolInfo()
end

function UICN20N49Ryza_Shop:RefreshPoolInfo()
  self._poolName:SetText(StringTable.Get("str_cn20_n49_shop_pool_name", self._curPoolIdx))
  local shelfInfo = self:GetShelfData()
  self._pool:SpawnObjects("UICN20N49Ryza_ShopCell", self._cellCount)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, self._cellCount do
    local item = pools[i]
    local info = shelfInfo[i]
    item:SetData(i, info, function(idx)
      self:OnItemClick(idx)
    end)
  end
  self:ShowHideCellAddGo(true)
  self:RefreshTopUI()
end

function UICN20N49Ryza_Shop:AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:RefreshTopUI()
    self:RefreshProgress()
  end
end

function UICN20N49Ryza_Shop:RefreshTopUI()
  local count = GameGlobal.GetModule(ItemModule):GetItemCount(self._topid)
  self._topTex:SetText(count)
end

function UICN20N49Ryza_Shop:OnItemClick(idx)
  local tab = {}
  for k, v in pairs(self._shelfInfo) do
    tab[v.id] = v.count
  end
  self:ShowDialog("UICN20N49Ryza_ShopList", tab, function(tabID2Count)
    self:RefreshShelfInfo(tabID2Count)
  end, self._comCfgID)
end

function UICN20N49Ryza_Shop.GetItemPriceColor(id)
  local cfg = Cfg.cfg_component_alchemy_item[id]
  if cfg then
    return cfg.Price, cfg.Quality
  end
end

function UICN20N49Ryza_Shop.SortItemDataLsit(list)
  if list and next(list) then
    table.sort(list, function(a, b)
      local color_a = a.color
      local color_b = b.color
      if color_a == color_b then
        local price_a = a.price
        local price_b = b.price
        if price_a == price_b then
          return a.id < b.id
        else
          return price_a > price_b
        end
      else
        return color_a > color_b
      end
    end)
  end
end

function UICN20N49Ryza_Shop:RefreshShelfInfo(tabID2Count)
  local list = {}
  if tabID2Count and next(tabID2Count) then
    for k, v in pairs(tabID2Count) do
      if 0 < v then
        local UICN20N49RyzaItemData = UICN20N49RyzaItemData:New()
        UICN20N49RyzaItemData.id = k
        UICN20N49RyzaItemData.count = v
        local price, color = UICN20N49Ryza_Shop.GetItemPriceColor(k)
        UICN20N49RyzaItemData.price = price
        UICN20N49RyzaItemData.color = color
        table.insert(list, UICN20N49RyzaItemData)
      end
    end
    UICN20N49Ryza_Shop.SortItemDataLsit(list)
  end
  self._curPoolIdx = 1
  self._shelfInfo = list
  self:RefreshPoolInfo()
end

function UICN20N49Ryza_Shop:GetShelfData()
  local startIdx = (self._curPoolIdx - 1) * self._cellCount + 1
  local endIdx = self._curPoolIdx * self._cellCount
  local ret = {}
  for i = startIdx, endIdx do
    local info = self._shelfInfo[i]
    table.insert(ret, info)
  end
  return ret
end

function UICN20N49Ryza_Shop:OneKeyBtnOnClick(go)
  local itemList = UICN20N49Ryza_ShopList.GetItemList(self._comCfgID, true)
  if itemList and next(itemList) then
    table.sort(itemList, function(a, b)
      local price_a = a.price
      local price_b = b.price
      if price_a == price_b then
        return a.id < b.id
      else
        return price_a > price_b
      end
    end)
    local shelfInfo = {}
    local allCount = 0
    local full = false
    for i, v in ipairs(itemList) do
      if allCount + v.count >= self._maxCount then
        v.count = self._maxCount - allCount
        full = true
      end
      allCount = allCount + v.count
      table.insert(shelfInfo, v)
      if full then
        break
      end
    end
    self._shelfInfo = shelfInfo
    self._curPoolIdx = 1
    self:RefreshPoolInfo()
  end
end

function UICN20N49Ryza_Shop:SellBtnOnClick(go)
  if self._shelfInfo and next(self._shelfInfo) then
    local needMap = self:CheckTalentMat(self._shelfInfo)
    if needMap then
      self:ShowDialog("UICN20N49Ryza_ShopWarning", needMap, function()
        local list = self:GetSellList(needMap)
        self:RefreshPoolInfo()
        self:Sell(list)
      end, function()
        local list = self:GetSellList()
        self:Sell(list)
      end)
    else
      do
        local list = self:GetSellList()
        self:Sell(list)
      end
    end
  end
end

function UICN20N49Ryza_Shop:GetSellList(needList)
  if needList and next(needList) then
    local tmpList = {}
    for k, v in pairs(self._shelfInfo) do
      local less = true
      if needList[v.id] then
        local newCount = v.count - needList[v.id]
        if 0 < newCount then
          v.count = newCount
        else
          less = false
        end
      end
      if less then
        table.insert(tmpList, v)
      end
    end
    self._shelfInfo = tmpList
  end
  return self._shelfInfo
end

function UICN20N49Ryza_Shop:CheckTalentMat(itemList)
  if itemList and next(itemList) then
    local list = {}
    for k, v in pairs(itemList) do
      local data = {
        [1] = v.id,
        [2] = v.count
      }
      table.insert(list, data)
    end
    local ret = UICN20N49Helper.CheckContainTalentTreeCost(self._campaign, list)
    if ret and next(ret) then
      local needMap = {}
      for k, v in pairs(ret) do
        local id = v[1]
        local count = v[2]
        if needMap[id] then
          needMap[id] = needMap[id] + count
        else
          needMap[id] = count
        end
      end
      return needMap
    end
  end
  return false
end

function UICN20N49Ryza_Shop:Sell(list)
  if self._com:ComponentIsClose() then
    local tips = StringTable.Get("str_activity_error_107")
    ToastManager.ShowToast(tips)
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if list and next(list) then
    local map = self:List2Map(list)
    self:Lock("UICN20N49Ryza_Shop:Sell")
    GameGlobal.TaskManager():StartTask(self.OnSell, self, map)
  end
end

function UICN20N49Ryza_Shop:List2Map(list)
  local map = {}
  for k, v in pairs(list) do
    map[v.id] = v.count
  end
  return map
end

function UICN20N49Ryza_Shop:OnSell(TT, map)
  local res = AsyncRequestRes:New()
  local responese = self._com:HandleAlchemyShopSell(TT, res, map)
  self:UnLock("UICN20N49Ryza_Shop:Sell")
  if res:GetSucc() then
    local earn1 = responese.item_earn
    local earn2 = responese.tip_earn
    local star = responese.star_item
    Log.debug("###[UICN20N49Ryza_Shop] HandleAlchemyShopSell succ,earn1:", earn1, ",earn2:", earn2, ",star:", star)
    self:Lock("UICN20N49Ryza_Shop:OnSell_Anim")
    self._isSelling = true
    self:SetBtnState(true)
    self:ShowHideCellAddGo(false)
    local buyAnimRoot = self:GetBuyAnimRoot()
    buyAnimRoot:SetData(function()
      self._isSelling = false
      self:SetBtnState(true)
      self._curPoolIdx = 1
      self._shelfInfo = {}
      self:RefreshPoolInfo()
      self:ShowDialog("UICN20N49Ryza_ShopSell", responese)
      self:UnLock("UICN20N49Ryza_Shop:OnSell_Anim")
    end)
  else
    local result = res:GetResult()
    Log.error("###[UICN20N49Ryza_Shop] HandleAlchemyShopSell fail,result:", result)
  end
end

function UICN20N49Ryza_Shop:GetBuyAnimRoot()
  if not self._buyAnimRoot then
    local buyAnimRoot = self:GetUIComponent("UISelectObjectPath", "animRoot")
    self._buyAnimRoot = buyAnimRoot:SpawnObject("UICN20N49Ryza_ShopSellAnim")
  end
  return self._buyAnimRoot
end

function UICN20N49Ryza_Shop:OnHide()
  self:UnLock("UICN20N49Ryza_Shop:OnSell_Anim")
  self:UnLock("UICN20N49Ryza_Shop:Sell")
end

function UICN20N49Ryza_Shop.Color2SpName(color)
  local tmp = {
    [1] = "cn20_ljdp_gezi05",
    [2] = "cn20_ljdp_gezi05",
    [3] = "cn20_ljdp_gezi05",
    [4] = "cn20_ljdp_gezi04",
    [5] = "cn20_ljdp_gezi03",
    [6] = "cn20_ljdp_gezi03"
  }
  return tmp[color]
end

function UICN20N49Ryza_Shop.MulString()
  return "×"
end

function UICN20N49Ryza_Shop:IconBtnOnClick(go)
  self._toptipsInfo:SetData(self._topid, go)
end

function UICN20N49Ryza_Shop:TmpBtn1OnClick(go)
  if not self._com:ComponentIsClose() then
    self:ShowDialog("UICN20N49AlchemyShopLevelUP", self._campaign)
  else
    local tips = StringTable.Get("str_activity_error_107")
    ToastManager.ShowToast(tips)
    self:SwitchState(UIStateType.UIMain)
    return
  end
end

function UICN20N49Ryza_Shop:TmpBtn2OnClick(go)
  if not self.personProcess:ComponentIsClose() then
    self:ShowDialog("UICN20N49AlchemyShopRevenueLevelUpInfo", self._campaign)
  else
    local tips = StringTable.Get("str_activity_error_107")
    ToastManager.ShowToast(tips)
    self:SwitchState(UIStateType.UIMain)
    return
  end
end

function UICN20N49Ryza_Shop:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UICN20N49Ryza_Shop)
end

function UICN20N49Ryza_Shop:ShowHideCellAddGo(show)
  if self._pool then
    local pools = self._pool:GetAllSpawnList()
    for k, v in pairs(pools) do
      v:ShowHideCellAddGo(show)
    end
  end
end
