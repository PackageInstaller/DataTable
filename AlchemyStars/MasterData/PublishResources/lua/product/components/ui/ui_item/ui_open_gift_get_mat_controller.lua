_class("UIOpenGiftGetMatController", UIController)
UIOpenGiftGetMatController = UIOpenGiftGetMatController

function UIOpenGiftGetMatController:OnShow(uiParams)
  self._itemModule = self:GetModule(ItemModule)
  self._itemInfos = uiParams[1]
  self._title = uiParams[2]
  self._titleTex = self:GetUIComponent("UILocalizationText", "title")
  self._titleTex:SetText(self._title)
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._itemInfo = itemInfo:SpawnObject("UISelectInfo")
  local itemCount = #self._itemInfos
  self._pool:SpawnObjects("UIOpenGiftGetMatItem", itemCount)
  local items = self._pool:GetAllSpawnList()
  for i = 1, #items do
    local itemInfo = self._itemInfos[i]
    local giftId = itemInfo.id
    local itemCount = itemInfo.count
    local item = items[i]
    item:SetData(i, giftId, itemCount, function(id, pos)
      self:ItemClick(id, pos)
    end)
  end
end

function UIOpenGiftGetMatController:ItemClick(id, pos)
  self._itemInfo:SetData(id, pos)
end

function UIOpenGiftGetMatController:btnOnClick(go)
  self._rewards = {}
  self._openIdx = 0
  self._maxCount = #self._itemInfos
  self:StartOpen()
end

function UIOpenGiftGetMatController:StartOpen()
  self:Lock("UIOpenGiftGetMatController:StartOpen")
  for i = 1, #self._itemInfos do
    local itemInfo = self._itemInfos[i]
    local giftId = itemInfo.id
    local giftPstId = itemInfo.pstid
    local count = itemInfo.count
    local idx = itemInfo.idx
    local chooseIdx = idx - 1
    self:StartTask(function(TT)
      Log.debug("###[UIOpenGiftGetMatController] RequestChooseGift start ! openIdx[", self._openIdx, "] id[", giftId, "] idx[", idx, "] count[", count, "]")
      local res, msg = self._itemModule:RequestChooseGift(TT, giftPstId, chooseIdx, count)
      self._openIdx = self._openIdx + 1
      if res:GetSucc() then
        local ra = RoleAsset:New()
        ra.assetid, ra.count = self:GetAwardId(giftId, idx, count)
        table.insert(self._rewards, ra)
      else
        local result = res:GetResult()
        Log.error("###[UIOpenGiftGetMatController] RequestChooseGift fail ! openIdx[", self._openIdx, "] giftId[", giftId, "] idx[", idx, "] count[", count, "] result[", result, "]")
      end
      self:ShowGetItemController()
    end)
  end
end

function UIOpenGiftGetMatController:GetAwardId(giftid, idx, count)
  local cfg_gift = Cfg.cfg_item_gift[giftid]
  if not cfg_gift then
    Log.error("###[UIOpenGiftGetMatController] cfg_gift is nil ! id --> ", giftid)
  end
  local itemList = cfg_gift.ItemList
  local item = itemList[idx]
  local itemid = item[1]
  local count = item[2] * count
  return itemid, count
end

function UIOpenGiftGetMatController:ShowGetItemController()
  if self._openIdx == self._maxCount then
    self:UnLock("UIOpenGiftGetMatController:StartOpen")
    self:ShowDialog("UIGetItemController", self._rewards)
    self:OpenSucc()
    self:CloseDialog()
  end
end

function UIOpenGiftGetMatController:bgOnClick(go)
  self:CloseDialog()
end

function UIOpenGiftGetMatController:OpenSucc()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnOpenGiftsSucc)
end
