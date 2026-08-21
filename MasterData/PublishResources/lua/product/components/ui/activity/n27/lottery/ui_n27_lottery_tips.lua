_class("UIN27LotteryTips", UIController)
UIN27LotteryTips = UIN27LotteryTips

function UIN27LotteryTips:Constructor()
end

function UIN27LotteryTips:OnShow(uiParams)
  self._awardInfo = uiParams[1]
  self._deltaPosition = uiParams[2]
  if self._awardInfo == nil then
    return
  end
  self._center = self:GetUIComponent("RectTransform", "center")
  self._offsetRoot = self:GetUIComponent("RectTransform", "offsetRoot")
  self._itemIcon = self:GetUIComponent("RawImageLoader", "itemIcon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._description = self:GetUIComponent("UILocalizationText", "description")
  self._ownCount = self:GetUIComponent("UILocalizationText", "ownCount")
  self._itemNum = self:GetUIComponent("UILocalizationText", "itemNum")
  self._animation = self:GetUIComponent("Animation", "anim")
  self:Flush()
  self:FlushPosition()
end

function UIN27LotteryTips:GetOffset()
  self._offsetX = self._offsetRoot.rect.width * 0.5
  self._offsetY = self._offsetRoot.rect.height * 0.5
  local descHeight = self._description.preferredHeight
  local offsetRootHeight = math.max(descHeight + 83, 168)
  self._offsetY = offsetRootHeight * 0.5
  self._anchorOffsets = {}
  self._anchorOffsets[1] = Vector2(-50 - self._offsetX, -50 - self._offsetY)
  self._anchorOffsets[2] = Vector2(50 + self._offsetX, -50 - self._offsetY)
  self._anchorOffsets[3] = Vector2(50 + self._offsetX, 50 + self._offsetY)
  self._anchorOffsets[4] = Vector2(-50 - self._offsetX, 50 + self._offsetY)
end

function UIN27LotteryTips:Flush()
  if self._awardInfo == nil then
    return
  end
  local itemId = self._awardInfo.m_item_id
  UIWidgetHelper.SetItemText(self, itemId, "name", "description")
  UIWidgetHelper.SetItemCount(self, itemId, "ownCount", function(count)
    local strCount = HelperProxy:GetInstance():FormatItemCount(count)
    return StringTable.Get("str_item_public_owned") .. strCount
  end)
  local itemCfg = Cfg.cfg_item[self._awardInfo.m_item_id]
  if itemCfg then
    local res = itemCfg.Icon
    self._itemIcon:LoadImage(res)
  end
  self._itemNum:SetText(string.format("x%d", self._awardInfo.m_count))
end

function UIN27LotteryTips:FlushPosition()
  self:GetOffset()
  if self._deltaPosition == nil then
    return
  end
  self._offsetRoot.position = self._center.position + self._deltaPosition
  local index = 0
  local anchoredPosition = self._offsetRoot.anchoredPosition
  if 0 < anchoredPosition.x then
    if 0 < anchoredPosition.y then
      index = 1
    else
      index = 4
    end
  elseif 0 < anchoredPosition.y then
    index = 2
  else
    index = 3
  end
  local anchoredPosition = self._offsetRoot.anchoredPosition
  self._offsetRoot.anchoredPosition = anchoredPosition + self._anchorOffsets[index]
end

function UIN27LotteryTips:ShowAwardTips(dataItem, clickPosition)
end

function UIN27LotteryTips:CloseBtnOnClick()
  self:PlayAnimation("uieffanim_UIN27LotteryTips_out", 267, function()
    self:CloseDialog()
  end)
end

function UIN27LotteryTips:PlayAnimation(animName, duration, cbComplete)
  local lockName = "UIN27LotteryTips:PlayAnimation_" .. animName
  TaskManager:GetInstance():StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play(animName)
    YIELD(TT, duration)
    self:UnLock(lockName)
    if cbComplete then
      cbComplete()
    end
  end)
end
