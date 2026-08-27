local UINAct21SumExcgHardDisk = class("UINAct21SumExcgHardDisk", UIBaseNode)
local base = UIBaseNode
local UINAct21SumExcgHardDiskItem = require("Game.ActivitySummer.UI.ActSum21Exchange.UINAct21SumExcgHardDiskItem")
local cs_EventTriggerListener = CS.EventTriggerListener

function UINAct21SumExcgHardDisk:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Last, self, self.OnLastClick)
  UIUtil.AddButtonListener(self.ui.btn_Next, self, self.OnNextClick)
  self.itemPool = UIItemPool.New(UINAct21SumExcgHardDiskItem, self.ui.obj_HDItem)
  self.ui.obj_HDItem:SetActive(false)
  self.unitShelfWith = self.ui.tran_totalShelf.rect.width
  local eventTigger = cs_EventTriggerListener.Get(self.ui.scroll)
  eventTigger:onBeginDrag("+", BindCallback(self, self.OnRectBeginDrag))
  eventTigger:onEndDrag("+", BindCallback(self, self.OnRectEndDrag))
end

function UINAct21SumExcgHardDisk:InitHDNode(sectorIData, poolIdcallback)
  local poolIdList = sectorIData:GetActSectorIDataPoolIdList()
  if poolIdList == nil or #poolIdList <= 0 then
    return
  end
  self.poolIdcallback = poolIdcallback
  self.poolIdList = poolIdList
  self.poolIdDic = {}
  for k, poolId in ipairs(self.poolIdList) do
    self.poolIdDic[poolId] = k
  end
  self:_InitUI(poolIdList)
  self:_SelectPool(sectorIData.roundId, true)
end

function UINAct21SumExcgHardDisk:_InitUI(poolIdList)
  self:_InitHDItem(poolIdList)
  self:_InitShelfCount(#poolIdList)
end

function UINAct21SumExcgHardDisk:_InitHDItem(poolIdList)
  self.itemPool:HideAll()
  for idx, poolId in ipairs(poolIdList) do
    local item = self.itemPool:GetOne()
    item:InitHardDiskItem(idx, poolId)
  end
  self.totalRectWith = self.ui.ItemUnitWith * #poolIdList
end

function UINAct21SumExcgHardDisk:_InitShelfCount(totalCount)
  local hight = self.ui.tran_totalShelf.rect.height
  self.ui.tran_totalShelf.sizeDelta = Vector2.New(self.unitShelfWith * totalCount, hight)
end

function UINAct21SumExcgHardDisk:_SelectPool(curPoolId, isInit)
  self.curPoolId = curPoolId or 1
  self.curIndex = self.poolIdDic[curPoolId] or 1
  self:_SetCurShelfPointPos(self.curIndex)
  self:_SetBtnGroupEnabled(self.curIndex)
  if isInit then
    self:_RefreshItemAnchorPos(self.curIndex)
  else
    self:_DOTweenItemAnchorPos(self.curIndex)
  end
  if self.poolIdcallback ~= nil then
    self.poolIdcallback(self.curPoolId, self.curIndex)
  end
end

function UINAct21SumExcgHardDisk:_SelectPoolByIndex(curIdx)
  local poolId = self.poolIdList[curIdx]
  self:_SelectPool(poolId)
end

function UINAct21SumExcgHardDisk:_SetCurShelfPointPos(curIdx)
  self.ui.tran_curShelf.anchoredPosition = Vector3.New(self.unitShelfWith * (curIdx - 1), 0, 0)
end

function UINAct21SumExcgHardDisk:_SetBtnGroupEnabled(curIdx)
  self.ui.btn_Last.interactable = curIdx ~= 1
  self.ui.btn_Next.interactable = curIdx ~= #self.poolIdList
end

function UINAct21SumExcgHardDisk:_DOTweenItemAnchorPos(curIdx)
  self.ui.tran_rect:DOKill()
  self.ui.tran_rect:DOAnchorPosX(-self.ui.ItemUnitWith * (curIdx - 1), 0.25)
end

function UINAct21SumExcgHardDisk:_RefreshItemAnchorPos(curIdx)
  self.ui.tran_rect.anchoredPosition = Vector3.New(-self.ui.ItemUnitWith * (curIdx - 1), 0, 0)
end

function UINAct21SumExcgHardDisk:OnLastClick()
  self:_OnClickChangePool(-1)
end

function UINAct21SumExcgHardDisk:OnNextClick()
  self:_OnClickChangePool(1)
end

function UINAct21SumExcgHardDisk:_OnClickChangePool(idxOffset)
  local newIdx = self.poolIdDic[self.curPoolId] + idxOffset
  newIdx = math.clamp(newIdx, 1, #self.poolIdList)
  local poolId = self.poolIdList[newIdx]
  self:_SelectPool(poolId)
  AudioManager:PlayAudioById(1135)
end

function UINAct21SumExcgHardDisk:OnRectBeginDrag(go, eventData)
  self._beginDragPosX = eventData.position.x
  self._ratio = 1 / #self.poolIdList
end

function UINAct21SumExcgHardDisk:OnRectEndDrag(go, eventData)
  local offset = self._beginDragPosX - eventData.position.x
  self.ui.scroll:StopMovement()
  local hPos = self.ui.scroll.horizontalNormalizedPosition
  if hPos <= 0 then
    self:_SelectPoolByIndex(1)
    return
  end
  if 1 <= hPos then
    self:_SelectPoolByIndex(#self.poolIdList)
    return
  end
  if math.abs(offset) < self.ui.ItemUnitWith / 3 then
    self:_DOTweenItemAnchorPos(self.curIndex)
    return
  end
  if math.abs(offset) > self.ui.ItemUnitWith / 3 and math.abs(offset) < self.ui.ItemUnitWith then
    local idxOffset = 0 < offset and 1 or -1
    self:_OnClickChangePool(idxOffset)
    return
  end
  local curPage = 1
  if math.abs(offset) > self.ui.ItemUnitWith then
    curPage = 1
    for i = 1, #self.poolIdList do
      if hPos < self._ratio * i then
        curPage = i
        break
      end
    end
  end
  self:_SelectPoolByIndex(curPage)
end

function UINAct21SumExcgHardDisk:RefreshHD(curPickedNum, allRewardNum)
  for i = 1, self.curIndex - 1 do
    local item = self.itemPool.listItem[i]
    if item ~= nil then
      item:SetHardDiskItemDissolve(1)
    end
  end
  local item = self.itemPool.listItem[self.curIndex]
  if item ~= nil then
    item:SetHardDiskItemDissolve(curPickedNum / allRewardNum)
  end
end

function UINAct21SumExcgHardDisk:PlayHDItemTween(poolID, curPickedNum, allRewardNum)
  local idx = self.poolIdDic[poolID]
  idx = math.clamp(idx, 1, #self.poolIdList)
  if self.oldItem ~= nil then
    self.oldItem:KillTween()
    self.oldItem = nil
  end
  local item = self.itemPool.listItem[self.curIndex]
  if item ~= nil then
    item:PlayFxDOTween(curPickedNum, allRewardNum)
    self.oldItem = item
  end
end

function UINAct21SumExcgHardDisk:OnDelete()
  self.itemPool:DeleteAll()
  self.ui.tran_rect:DOKill()
  base.OnDelete(self)
end

return UINAct21SumExcgHardDisk
