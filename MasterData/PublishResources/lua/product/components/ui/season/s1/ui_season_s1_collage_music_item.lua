_class("UISeasonS1CollageMusicItem", UICustomWidget)
UISeasonS1CollageMusicItem = UISeasonS1CollageMusicItem

function UISeasonS1CollageMusicItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonS1CollageMusicItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.musicName = self:GetUIComponent("RollingText", "musicName")
  self.author = self:GetUIComponent("UILocalizationText", "author")
  self.unlock = self:GetGameObject("Unlock")
  self.lock = self:GetGameObject("Lock")
  self.condition = self:GetUIComponent("UILocalizationText", "condition")
  self.new = self:GetGameObject("new")
  self._layout = self:GetUIComponent("LayoutElement", "UISeasonS1CollageMusicItem")
  self._bg = self:GetUIComponent("Image", "Unlock")
  self._mask = self:GetUIComponent("Image", "mask")
  self._atlas = self:GetAsset("UIS1Collages.spriteatlas", LoadType.SpriteAtlas)
  self._light = self:GetGameObject("Light")
  self._disc = self:GetUIComponent("RectTransform", "Disc")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._playingEff = self:GetUIComponent("RawImage", "eff_yinpu")
  self._playingMat = self._playingEff.material
end

function UISeasonS1CollageMusicItem:SetData(data, onClick)
  self._data = data
  self._onClick = onClick
  self:SetNew(self._data:IsNew())
  if not self._data:IsValid() then
    Log.exception("音乐为解锁无法显示:", self._data:ID())
  end
  local cfg = Cfg.cfg_role_music[self._data:ID()]
  if self._data:IsUnlock() then
    self.unlock:SetActive(true)
    self.lock:SetActive(false)
    self.musicName:RefreshText(StringTable.Get(cfg.Name))
    self.author:SetText(StringTable.Get(cfg.Author))
    self.icon:LoadImage(cfg.Icon)
  else
    self.unlock:SetActive(false)
    self.lock:SetActive(true)
    self.condition:SetText(StringTable.Get(cfg.UnLockDes))
  end
  self:Deselect()
end

function UISeasonS1CollageMusicItem:SetNew(new)
  self.new:SetActive(new)
end

function UISeasonS1CollageMusicItem:Select()
  self._bg.sprite = self._atlas:GetSprite("exp_s1_book_fengmian_2")
  self._mask.sprite = self._atlas:GetSprite("exp_s1_book_fengmian_1")
  self._light:SetActive(true)
  self._anim:Stop()
  self._anim:Play("uieffanim_UISeasonS1CollageMusicItem_play")
  self:PlayEft()
end

function UISeasonS1CollageMusicItem:Deselect()
  self._bg.sprite = self._atlas:GetSprite("exp_s1_book_fengmian_4")
  self._mask.sprite = self._atlas:GetSprite("exp_s1_book_fengmian_3")
  self._light:SetActive(false)
  self._anim:Stop()
  self._anim:Play("uieffanim_UISeasonS1CollageMusicItem_stop")
  self:PauseEft()
end

function UISeasonS1CollageMusicItem:PlayEft()
  self._playingMat:SetFloat("_Speed", 12)
end

function UISeasonS1CollageMusicItem:PauseEft()
  self._playingMat:SetFloat("_Speed", 0)
end

function UISeasonS1CollageMusicItem:RootOnClick(go)
  self._onClick(self._data)
end

function UISeasonS1CollageMusicItem:PlayExitAnim()
  self._anim:Stop()
  self._anim:Play("uieffanim_UISeasonS1CollageMusicItem_out")
end
