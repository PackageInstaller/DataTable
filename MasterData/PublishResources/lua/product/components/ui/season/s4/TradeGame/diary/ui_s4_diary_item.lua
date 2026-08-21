_class("UIS4DiaryItem", UICustomWidget)
UIS4DiaryItem = UIS4DiaryItem

function UIS4DiaryItem:OnShow(uiParams)
  self:InitWidget()
end

function UIS4DiaryItem:InitWidget()
  self.title = self:GetUIComponent("UILocalizationText", "Title")
  self.eventIcon = self:GetUIComponent("RawImageLoader", "EventIcon")
  self.eventName = self:GetUIComponent("UILocalizationText", "EventName")
  self.collected = self:GetUIComponent("Image", "Collected")
  self.lockMask = self:GetUIComponent("Image", "LockMask")
  self.Bg = self:GetUIComponent("Image", "Bg")
  self.collectedObj = self:GetGameObject("Collected")
  self.lockMaskObj = self:GetGameObject("LockMask")
  self._atlas = self:GetAsset("UIS4TradeGame.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetUIComponent("Animation", "UIS4DiaryItem")
end

function UIS4DiaryItem:SetData(id, have, isHarborEvent)
  self.id = id
  self.isHarborEvent = isHarborEvent
  self:SetBg(isHarborEvent)
  self:SetDetail()
  self.lockMaskObj:SetActive(not have)
  self.eventName.gameObject:SetActive(have)
  self.title.gameObject:SetActive(have)
  self.collectedObj:SetActive(have)
  self:PlayItemAnimIn()
end

function UIS4DiaryItem:SetBg(isHarborEvent)
  local collected, lockMask, BG
  if isHarborEvent then
    collected = "exp_s4_sj_btn01"
    lockMask = "exp_s4_sj_mask02"
    BG = "exp_s4_sj_di01"
  else
    collected = "exp_s4_sj_btn02"
    lockMask = "exp_s4_sj_mask03"
    BG = "exp_s4_sj_di02"
  end
  self.collected.sprite = self._atlas:GetSprite(collected)
  self.lockMask.sprite = self._atlas:GetSprite(lockMask)
  self.Bg.sprite = self._atlas:GetSprite(BG)
end

function UIS4DiaryItem:SetDetail()
  local globalCfg = Cfg.cfg_component_business_global({})
  local eventCfg = Cfg.cfg_component_business_event({})
  local EventName, EventIcon, title, key, LoadCfg
  if self.isHarborEvent then
    key = self.id
    title = "str_season_s4_trade_harbor_event"
    LoadCfg = globalCfg
  else
    key = self.id + 1000
    title = "str_season_s4_trade_sea_event"
    LoadCfg = eventCfg
  end
  EventName = LoadCfg[key].EventName
  EventIcon = LoadCfg[key].EventIcon
  self.title:SetText(StringTable.Get(title))
  self.eventName:SetText(StringTable.Get(EventName))
  self.eventIcon:LoadImage(EventIcon)
end

function UIS4DiaryItem:BtnOnClick(go)
  if self.lockMaskObj.activeSelf then
    ToastManager.ShowToast(StringTable.Get("str_season_s4_trade_event_lock_tip"))
    return
  end
  self:ShowDialog("UIS4ShowEventController", self.id, self.isHarborEvent, nil)
end

function UIS4DiaryItem:PlayItemAnimIn()
  local LockName = "UIS4DiaryItem_AnimIN"
  self:StartTask(function(TT)
    YIELD(TT, self.id * 40)
    if not tolua:isnull(self._anim) then
      self._anim:Play("uianim_UIS4DiaryItem_in")
    end
    YIELD(TT, 200)
  end)
end
