_class("UIActivityReturnSystemTabGift", UICustomWidget)
UIActivityReturnSystemTabGift = UIActivityReturnSystemTabGift

function UIActivityReturnSystemTabGift:SetData(campaign, remainingTimeCallback, tipsCallback)
  self._campaign = campaign
  self:Refresh()
end

function UIActivityReturnSystemTabGift:OnShow(uiParams)
  self._isOpen = true
end

function UIActivityReturnSystemTabGift:OnHide()
end

function UIActivityReturnSystemTabGift:Refresh()
  if self._isOpen then
    self:_SetGiftBoardGroup()
  end
end

function UIActivityReturnSystemTabGift:_SetGiftBoardGroup()
  local component = UIActivityReturnSystemHelper.GetComponentByTabName(self._campaign, "gift", 1)
  local giftList = component:GetAllGiftIDByType(CampaignGiftType.ECGT_BACK)
  local giftCount = table.count(giftList)
  Log.debug("UIActivityReturnSystemTabGift:_SetGiftBoardGroup() giftCount = ", giftCount)
  giftCount = math.max(giftCount, 3)
  local sop = self:GetUIComponent("UISelectObjectPath", "GiftBoardGroup")
  sop:SpawnObjects("UIActivityReturnSystemBoard", giftCount)
  self._giftBoard = sop:GetAllSpawnList()
  for i, v in ipairs(self._giftBoard) do
    v:SetData(self._campaign, component, giftList[i], function()
      self:Refresh()
    end)
  end
end
