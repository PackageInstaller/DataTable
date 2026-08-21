_class("UIN15RaffleItem", UICustomWidget)
UIN15RaffleItem = UIN15RaffleItem

function UIN15RaffleItem:Constructor()
  self._atlas = self:GetAsset("UIN15.spriteatlas", LoadType.SpriteAtlas)
end

function UIN15RaffleItem:OnShow(uiParams)
  self:_GetComponents()
  self:_InitParmams(uiParams)
end

function UIN15RaffleItem:_InitParmams(uiParams)
  self._select_count = 0
  self._award_count = 0
end

function UIN15RaffleItem:_GetComponents()
  self._anim = self.view.gameObject:GetComponent("Animation")
  self._icon_bg_rect = self:GetUIComponent("RectTransform", "_icon_bg")
  self._get_award_count_rect = self:GetUIComponent("RectTransform", "_get_award_count")
  self._icon_raw = self:GetUIComponent("RawImageLoader", "_icon")
  self._award_count_txt = self:GetUIComponent("UILocalizationText", "_award_count_txt")
  self._goods_count_txt = self:GetUIComponent("UILocalizationText", "_goods_count_txt")
  self._get_award_count_txt = self:GetUIComponent("UILocalizationText", "_get_award_count_txt")
  self._get_award_obj = self:GetGameObject("_get_award")
  self._select_single_obj = self:GetGameObject("_select_single")
  self._select_more_obj = self:GetGameObject("_select_more")
  self._halo_obj = self:GetGameObject("_halo")
  self._get_award_count_obj = self:GetGameObject("_get_award_count")
end

function UIN15RaffleItem:_show()
  self._icon_raw:LoadImage(N15ToolFunctions.GetItemIcon(self._award_date.m_item_id))
  self._award_count_txt:SetText("x" .. self._award_date.m_lottery_count)
  self._goods_count_txt:SetText("x" .. self._award_date.m_count)
  self._get_award_obj:SetActive(false)
  self._get_award_count_obj:SetActive(false)
  self._halo_obj:SetActive(false)
  self._select_single_obj:SetActive(false)
  self._select_more_obj:SetActive(false)
  self:SetGrey(self._award_date.m_lottery_count)
end

function UIN15RaffleItem:SetData(award_date, item_press_callback, isBig, animCB)
  if isBig then
    self._icon_bg_raw = self:GetUIComponent("RawImageLoader", "_icon_bg")
  else
    self._icon_bg_img = self:GetUIComponent("Image", "_icon_bg")
  end
  self._isBig = isBig
  self._animCB = animCB
  self._select_count = 0
  self._award_date = award_date
  self._item_press_callback = item_press_callback
  self._award_count = self._award_date.m_count
  self:_show()
end

function UIN15RaffleItem:SetSelectHighLight()
  self._select_count = self._select_count + 1
  self._get_award_count_obj:SetActive(true)
  self._get_award_obj:SetActive(true)
  self._get_award_count_txt:SetText(StringTable.Get("str_n15_get", self._select_count))
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N15RaffleSucc)
end

function UIN15RaffleItem:SetGrey(time)
  local greyTab = {}
  table.insert(greyTab, self._icon_raw)
  if time <= 0 then
    if self._icon_bg_img then
      self._icon_bg_img.sprite = self._atlas:GetSprite("n15_shop_item4")
    elseif self._icon_bg_raw then
      self._icon_bg_raw:LoadImage("n15_shop_grand4")
    end
    N15ToolFunctions.SetGrey(greyTab, 1)
  else
    if self._icon_bg_img then
      self._icon_bg_img.sprite = self._atlas:GetSprite("n15_shop_item1")
    elseif self._icon_bg_raw then
      self._icon_bg_raw:LoadImage("n15_shop_grand1")
    end
    N15ToolFunctions.SetGrey(greyTab, 0)
  end
end

function UIN15RaffleItem:SetRaffleHighLight(single_high)
  self._halo_obj:SetActive(single_high)
end

function UIN15RaffleItem:SetGetAward(award_count)
  if not award_count then
    return
  end
  self._get_award_obj:SetActive(true)
  self._get_award_count_obj:SetActive(true)
  self._get_award_count_txt:SetText(StringTable.Get("str_n15_get", award_count))
end

function UIN15RaffleItem:GetAwardId()
  return self._award_date.m_award_id
end

function UIN15RaffleItem:GetState()
  return self._award_date.m_lottery_count == 0
end

function UIN15RaffleItem:PlayAnim()
  self._anim:Stop()
  if self._isBig then
    self._animCB("uieffanim_N15_Raffle_win_2")
    self._anim:Play("uieffanim_N15_DrawIntroItem_02")
  else
    self._animCB("uieffanim_N15_Raffle_win_1")
    self._anim:Play("uieffanim_N15_DrawIntroItem_01")
  end
end

function UIN15RaffleItem:IconOnClick(go)
  if self._item_press_callback then
    local tr = go.transform
    local pos = tr.position
    self._item_press_callback(self._award_date.m_item_id, pos)
  end
end
