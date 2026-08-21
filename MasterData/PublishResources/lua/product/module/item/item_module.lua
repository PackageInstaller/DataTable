_class("ItemModule", GameModule)
ItemModule = ItemModule

function ItemModule:Constructor()
  self.m_items = ItemContainer:New()
  self.m_fac = ItemExtFactory:New()
  self.m_local_update_list = {}
  self.m_chess = 0
end

function ItemModule:Init()
  self.caller:RegisterPushHandler(CEventMobileNotifyItemInfoChange, self.HandleItemInfoChange, self)
  self.caller:RegisterPushHandler(CEventMobileNotifyItemConverChange, self.HandleItemConverChange, self)
  if EDITOR then
    local drop_cfgs = Cfg.cfg_drop({})
    local item_cfg = Cfg.cfg_item({})
    for k, v in pairs(drop_cfgs) do
      if v.AssetID ~= 0 then
        local itemtemplate = Cfg.cfg_item[v.AssetID]
        if itemtemplate == nil then
          Log.error("cfg_drop asset cant find ", v.AssetID)
        end
      end
    end
  end
end

function ItemModule:FindItem(pst_id)
  return self.m_items:FindItem(pst_id)
end

function ItemModule:GetItemCount(tempId)
  local items = {}
  self.m_items:GetAllItemInfo(items, function(item)
    return item:GetTemplateID() == tempId
  end)
  if #items == 0 then
    local cnt = 0
    local role_module = GameGlobal.GetModule(RoleModule)
    local info = role_module:GetNotEnough()
    if info ~= nil and info[tempId] ~= nil then
      cnt = cnt - info[tempId]
    end
    return cnt
  end
  local cnt = 0
  for _, item in ipairs(items) do
    cnt = cnt + item:GetCount()
  end
  return cnt
end

function ItemModule:GetItemByTempId(tempId)
  local items = {}
  self.m_items:FindItems(tempId, items)
  return items
end

function ItemModule:InitItemInfos(list)
  local itemcount = table.count(list)
  Log.debug("ItemModule time count ", itemcount)
  for _, v in pairs(list) do
    local item = Item:New(self.m_fac, v)
    self.m_items:AddItem(item)
  end
end

function ItemModule:GetAllItemInfos()
  local items = {}
  self.m_items:GetAllItemInfo(items)
  return items
end

function ItemModule:UIHomePhotoHasNew()
  local items = {}
  self.m_items:GetAllItemInfo(items, function(v)
    return v:GetTemplate().ItemSubType == ItemSubType.ItemSubType_Photo
  end)
  for key, item in pairs(items) do
    local isNew = item:IsNew()
    if isNew then
      return true
    end
  end
  return false
end

function ItemModule:HasNew()
  local items = self:GetAllItemInfos()
  for key, item in pairs(items) do
    local isNew = item:IsNew()
    if isNew then
      local cfg_item = Cfg.cfg_item[item:GetTemplate().ID]
      if cfg_item and cfg_item.ItemSubType ~= ItemSubType.ItemSubType_Photo and cfg_item.ItemSubType ~= ItemSubType.ItemSubType_Medal and cfg_item.ItemSubType ~= ItemSubType.ItemSubType_Medal_Board and cfg_item.ShowType ~= 2 and cfg_item.ShowNew and cfg_item.ShowNew == 1 then
        return true
      end
    end
  end
  return false
end

function ItemModule:HasNewSubTypeItem(itemType, overlay)
  local items = self:GetItemListBySubType(itemType)
  for key, item in pairs(items) do
    local isNew = overlay and item:IsNewOverlay() or item:IsNew()
    if isNew then
      local cfg_item = Cfg.cfg_item[item:GetTemplate().ID]
      if cfg_item.ShowNew and cfg_item.ShowNew == 1 then
        return true
      end
    end
  end
  return false
end

function ItemModule:GetAllInBagItemInfos()
  local items = {}
  self.m_items:GetAllItemInfo(items, function(v)
    return v:GetTemplate().InBag == true
  end)
  return items
end

function ItemModule:GetItemInfosByType(itemType)
  local items = {}
  self.m_items:GetAllItemInfo(items, function(v)
    return itemType == ItemType.ItemType_None or v:GetTemplate().ItemType == itemType
  end)
  self:SortItems(items)
  return items
end

function ItemModule:GetInBagItemInfosByType(itemType)
  local items = {}
  self.m_items:GetAllItemInfo(items, function(v)
    return (itemType == ItemType.ItemType_None or v:GetTemplate().ItemType == itemType) and v:GetTemplate().InBag == true
  end)
  self:SortItems(items)
  return items
end

function ItemModule:SortItems(items)
  table.sort(items, function(a, b)
    local ta = a:GetTemplate()
    local tb = b:GetTemplate()
    if ta.BagSortIndex == tb.BagSortIndex then
      if ta.Color == tb.Color then
        return ta.ID < tb.ID
      end
      return ta.Color > tb.Color
    end
    return ta.BagSortIndex > tb.BagSortIndex
  end)
  return items
end

function ItemModule:SortRoleAsset(assets)
  table.sort(assets, function(a, b)
    local ta = Cfg.cfg_item[a.assetid]
    if ta == nil then
      Log.error("SortRoleAsset error cfg_item catn find ", a.assetid)
      return true
    end
    local tb = Cfg.cfg_item[b.assetid]
    if tb == nil then
      Log.error("SortRoleAsset error cfg_item catn find ", a.assetid)
      return true
    end
    if ta.BagSortIndex == tb.BagSortIndex then
      if ta.Color == tb.Color then
        return ta.ID < tb.ID
      end
      return ta.Color > tb.Color
    end
    return ta.BagSortIndex > tb.BagSortIndex
  end)
  return assets
end

function ItemModule:BattleResultSortAsset(assets)
  table.sort(assets, function(a, b)
    local ta = Cfg.cfg_item[a.assetid]
    local tb = Cfg.cfg_item[b.assetid]
    if ta == nil then
      Log.error(" Cfg.cfg_item cant find assetid ", a.assetid)
    end
    if tb == nil then
      Log.error(" Cfg.cfg_item cant find assetid ", b.assetid)
    end
    if ta.Color == tb.Color then
      return ta.ID < tb.ID
    end
    return ta.Color > tb.Color
  end)
  return assets
end

function ItemModule:GetItemListBySubType(subtype)
  local items = {}
  self.m_items:GetAllItemInfo(items, function(v)
    return v:GetTemplate().ItemSubType == subtype
  end)
  return items
end

function ItemModule:GetItemGiftType(itemGiftID)
  local cfgGift = Cfg.cfg_item_gift[itemGiftID]
  if cfgGift then
    return cfgGift.ItemGiftType
  end
  return nil
end

function ItemModule:GetPhyGiftData(itemGiftID)
  local cfgItemGift = Cfg.cfg_item_gift[itemGiftID]
  if nil == cfgItemGift then
    return 0
  end
  local nPhyEffect = 0
  for _, value in pairs(cfgItemGift.ItemList) do
    if value[1] == RoleAssetID.RoleAssetPhyPoint then
      nPhyEffect = value[2]
      break
    end
  end
  return nPhyEffect
end

function ItemModule:GetItemToPetExp(itemTID)
  local cfg = Cfg.cfg_item_pet_exp[itemTID]
  if cfg then
    return cfg.Exp
  end
end

function ItemModule:UseItem(TT, param)
  Log.fatal(" param.item_pstid=", param.item_pstid)
  Log.fatal(" param.item_template_id=", param.item_template_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileUseItem)
  request.use_param.item_pstid = param.item_pstid or 0
  request.use_param.item_tempid = param.item_template_id or 0
  request.use_param.use_count = param.use_count or 0
  request.use_param.param1 = param.param1 or 0
  request.use_param.param2 = param.param2 or 0
  request.use_param.param3 = param.param3 or 0
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.nRet)
  return res, replyEvent
end

function ItemModule:RequestUseItemByPstID(TT, item_pstid, count, param1, param2, param3)
  Log.debug("ItemModule:RequestUseItemByPstID()")
  local itemUseParameter = {
    item_pstid = item_pstid,
    use_count = count,
    param1 = param1,
    param2 = param2,
    param3 = param3
  }
  return self:UseItem(TT, itemUseParameter)
end

function ItemModule:RequestUseItemByTemplateID(TT, item_template_id, count, param1, param2, param3)
  Log.debug("ItemModule:RequestUseItemByTemplateID()")
  local itemUseParameter = {
    item_template_id = item_template_id,
    use_count = count,
    param1 = param1,
    param2 = param2,
    param3 = param3
  }
  return self:UseItem(TT, itemUseParameter)
end

function ItemModule:RequestSellItem(TT, item_pstid, num)
  local res = AsyncRequestRes:New()
  if not item_pstid or not num then
    Log.fatal("RequestSellItem no item_pstid or num")
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  if item_pstid <= 0 or num <= 0 then
    Log.fatal("RequestSellItem args err", item_pstid, num)
    res:SetSucc(false)
    res:SetResult(-2)
    return res
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileSellItem)
  request.m_item_pstid = item_pstid
  request.m_num = num
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent.m_reward_list
end

function ItemModule:RequestChooseGift(TT, item_pstid, choose_id, use_count)
  Log.debug("ItemModule:RequestChooseGift()")
  local res = AsyncRequestRes:New()
  if not item_pstid or not choose_id then
    Log.fatal("RequestChooseGift no item_pstid or num")
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  if item_pstid <= 0 or choose_id < 0 then
    Log.fatal("RequestChooseGift args err", item_pstid, choose_id)
    res:SetSucc(false)
    res:SetResult(-2)
    return res
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChooseGift)
  request.m_item_pstid = item_pstid
  request.m_choose_id = choose_id
  request.m_use_count = use_count
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function ItemModule:HandleItemInfoChange(msg)
  for _, item_info in pairs(msg.m_update_list) do
    local item = self:FindItem(item_info.item_pstid)
    if not item then
      local new_item = Item:New(self.m_fac, item_info)
      if not new_item then
        Log.fatal("new item error ---------")
        return
      end
      self.m_items:AddItem(new_item)
    else
      item:SetData(item_info)
    end
  end
  for _, v in pairs(msg.m_delete_list) do
    self.m_items:DelItem(v)
  end
  if msg.not_enough ~= nil and table.count(msg.not_enough) >= 0 then
    local role_module = GameGlobal.GetModule(RoleModule)
    role_module:SetNotEnough(msg.not_enough)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ItemCountChanged)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBookRedPointStatus)
end

function ItemModule:HandleItemConverChange(msg)
  if self._autoConverOpen then
    Log.debug("###[CommonConver] 下发转化消息")
    for i, v in pairs(msg.m_update_list) do
      if not self.m_local_update_list[i] then
        self.m_local_update_list[i] = v
      else
        self.m_local_update_list[i] = self.m_local_update_list[i] + v
      end
    end
  end
end

function ItemModule:GameSingleAddItem(itemId)
  local info = item_data_info:New()
  info.item_pstid = itemId
  info.owner_pstid = 0
  info.template_id = itemId
  info.count = 100
  info.gain_time = 0
  info.durability = 0
  info.flags = 0
  info.custom_data = nil
  local item = self:FindItem(itemId)
  if not item then
    local new_item = Item:New(self.m_fac, info)
    if not new_item then
      Log.fatal("new item error ---------")
      return
    end
    self.m_items:AddItem(new_item)
  else
    item:SetData(info)
  end
end

function ItemModule:ReqTaskSubmitItem(TT, items)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTaskSubmitItem)
  request.items = items
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.nRet)
  return res, replyEvent
end

function ItemModule:HandleOpenGift(msg)
  local gift_id = msg.m_gift_id
  local reward_list = msg.m_reward_list
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OpenGiftReward, gift_id, reward_list)
end

function ItemModule:SetItemUnnew(TT, item_pstid)
  self:_RequestItemFlag(TT, item_pstid, ItemDataFlags.Item_Flag_Is_New_Obtain, false)
end

function ItemModule:SetItemUnnewOverlay(TT, item_pstid)
  self:_RequestItemOverlayFlag(TT, item_pstid, ItemDataFlags.Item_Flag_Is_New_Overlay, false)
end

function ItemModule:SetItemListUnnew(TT, item_list)
  self:_RequestClearItemListFlag(TT, item_list, ItemDataFlags.Item_Flag_Is_New_Obtain)
end

function ItemModule:SetItemListUnnewOverlay(TT, item_list)
  self:_RequestClearItemListFlag(TT, item_list, ItemDataFlags.Item_Flag_Is_New_Overlay)
end

function ItemModule:_RequestItemFlag(TT, item_pstid, flag, value)
  Log.debug("ItemModule:RequestItemFlag()")
  local res = AsyncRequestRes:New()
  if not item_pstid then
    Log.fatal("RequestSellItem no item_pstid")
    res:SetSucc(false)
    res:SetResult(-1)
  end
  if item_pstid <= 0 then
    Log.fatal("RequestSellItem item_pstid err", item_pstid)
    res:SetSucc(false)
    res:SetResult(-2)
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileItemObtainFlag)
  request.item_pstid = item_pstid
  request.flag = flag
  if value and true == value then
    request.value = 1
  else
    request.value = 0
  end
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function ItemModule:_RequestItemOverlayFlag(TT, item_pstid, flag, value)
  Log.debug("ItemModule:_RequestItemOverlayFlag()")
  local res = AsyncRequestRes:New()
  if not item_pstid then
    Log.fatal("_RequestItemOverlayFlag no item_pstid")
    res:SetSucc(false)
    res:SetResult(-1)
  end
  if item_pstid <= 0 then
    Log.fatal("_RequestItemOverlayFlag item_pstid err", item_pstid)
    res:SetSucc(false)
    res:SetResult(-2)
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventItemNewOverlayFlag)
  request.item_pstid = item_pstid
  request.flag = flag
  if value and true == value then
    request.value = 1
  else
    request.value = 0
  end
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function ItemModule:_RequestClearItemListFlag(TT, item_pstid_list, flag)
  Log.debug("ItemModule:_RequestClearItemListFlag()")
  local res = AsyncRequestRes:New()
  if not item_pstid_list then
    Log.fatal("_RequestClearItemListFlag no item_pstid")
    res:SetSucc(false)
    res:SetResult(-1)
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileItemListClearFlag)
  request.item_psitd_list = item_pstid_list
  request.flag = flag
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function ItemModule:HasNewBook()
  local bookCfg = Cfg.cfg_book({})
  local bookCount = table.count(bookCfg)
  if bookCount <= 0 then
    return false
  end
  for _, v in pairs(bookCfg) do
    local chapterCfgs = Cfg.cfg_book_chapter({
      BookId = v.BookId
    })
    if chapterCfgs then
      for _, v1 in pairs(chapterCfgs) do
        if self:IsNewBookChapter(v1.ItemId) then
          return true
        end
      end
    end
  end
  return false
end

function ItemModule:IsNewBookChapter(itemId)
  if itemId == nil or itemId <= 0 then
    return false
  end
  local items = self:GetItemByTempId(itemId)
  local isnil = true
  for key, value in pairs(items) do
    isnil = false
    return value:IsNewOverlay()
  end
  return false
end

function ItemModule:SetBookChapterStatus(TT, itemId)
  if itemId == nil or itemId <= 0 then
    return
  end
  local items = self:GetItemByTempId(itemId)
  for key, value in pairs(items) do
    self:SetItemUnnewOverlay(TT, value:GetID())
  end
end

function ItemModule:IsChoosePetGift(itemId)
  local giftType = self:GetItemGiftType(itemId)
  if giftType ~= ItemGiftType.ItemGiftType_Choose then
    return false
  end
  local cfgGift = Cfg.cfg_item_gift[itemId]
  if not cfgGift then
    return false
  end
  local itemList = cfgGift.ItemList
  if itemList == nil or #itemList <= 0 then
    return false
  end
  local petModule = GameGlobal.GetModule(PetModule)
  for i = 1, #itemList do
    local giftId = itemList[i][1]
    if not petModule:IsPetID(giftId) then
      return false
    end
  end
  return true
end

function ItemModule:ItemUpgradeByTemplate(TT, template_id)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventItemUpgradeReq)
  request.item_id = template_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnItemUpgrade, template_id)
  return res
end

function ItemModule:ItemDecomposeByTemplate(TT, template_id, count)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventItemDecomposeReq)
  request.item_id = template_id
  request.item_count = count
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function ItemModule:ExchangeBreakThoughItem(TT, src_id, src_count, dest_id, dest_count)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCommonBreakThoughExchangeReq)
  request.src_item_id = src_id
  request.src_item_count = src_count
  request.dest_item_id = dest_id
  request.dest_item_count = dest_count
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function ItemModule:GetAvailableLimitDrawcardCoupon(type)
  local items = self:GetItemListBySubType(type)
  if not next(items) then
    return nil
  end
  local now = GetSvrTimeNow()
  local loginMd = GameGlobal.GetModule(LoginModule)
  for _, item in pairs(items) do
    local cfg = item:GetTemplate()
    if string.isnullorempty(cfg.CompulsiveDeadTime) then
      Log.exception("限时抽卡券没有配强制失效时间:", cfg.ID)
    end
    if now < loginMd:GetTimeStampByTimeStr(cfg.CompulsiveDeadTime, Enum_DateTimeZoneType.E_ZoneType_GMT) then
      return item
    end
  end
end

function ItemModule:GetErrorMsg(code)
  if not code then
    return
  else
    if code == ITEM_RESULT_CODE.ITEM_NOT_EXIST then
      return StringTable.Get("str_item_public_item_not_exist")
    else
    end
  end
end

function ItemModule:CommonAutoConversionEventOpen(value)
  Log.debug("###[CommonConver] 开关转化消息接受:", value)
  if value then
    self.m_local_update_list = {}
  end
  self._autoConverOpen = value
end

function ItemModule:GetConverList()
  Log.debug("###[CommonConver] 获取转化道具")
  local retList = {}
  for key, value in pairs(self.m_local_update_list) do
    Log.debug("###[CommonConver] 获取转化道具,id:", key, "|count:", value)
    retList[key] = value
  end
  Log.debug("###[CommonConver] 获取转化结束，清空缓存")
  self.m_local_update_list = {}
  return retList
end

function ItemModule:GetChessItemId()
  return self.m_chess
end

function ItemModule:HandleCEventChessData(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChessDataReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  self.m_chess = replyEvent.cfg_id
  res:SetResult(replyEvent.ret)
  return res
end

function ItemModule:HandleCEventChessItem(TT, template_id)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChessItemReq)
  request.cfg_id = template_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == ITEM_RESULT_CODE.ITEM_SUCCEED then
    self.m_chess = template_id
  end
  return res
end
