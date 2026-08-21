_class("UISeasonS3CollageMusicItem", UICustomWidget)
UISeasonS3CollageMusicItem = UISeasonS3CollageMusicItem

function UISeasonS3CollageMusicItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonS3CollageMusicItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.musicName = self:GetUIComponent("UILocalizationText", "musicName")
  self.author = self:GetUIComponent("UILocalizationText", "author")
  self.unlock = self:GetGameObject("Unlock")
  self.lock = self:GetGameObject("Lock")
  self.condition = self:GetUIComponent("UILocalizationText", "condition")
  self.new = self:GetGameObject("new")
  self._layout = self:GetUIComponent("LayoutElement", "UISeasonS3CollageMusicItem")
  self._bg = self:GetUIComponent("Image", "Unlock")
  self._mask = self:GetUIComponent("Image", "mask")
  self._atlas = self:GetAsset("UIS3Collages.spriteatlas", LoadType.SpriteAtlas)
  self._light = self:GetGameObject("Light")
  self._disc = self:GetUIComponent("RectTransform", "Disc")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._playingEff = self:GetUIComponent("RawImage", "eff_yinpu")
  self._playingMat = self._playingEff.material
end

function UISeasonS3CollageMusicItem:SetData(data, onClick)
  self._data = data
  self._onClick = onClick
  self:SetNew(self._data:IsNew())
  if not self._data:IsValid() then
    Log.exception("音乐未解锁无法显示:", self._data:ID())
  end
  local cfg = Cfg.cfg_role_music[self._data:ID()]
  if self._data:IsUnlock() then
    self.unlock:SetActive(true)
    self.lock:SetActive(false)
    self.musicName:SetText(StringTable.Get(cfg.Name))
    self.author:SetText(StringTable.Get(cfg.Author))
    self.icon:LoadImage(cfg.Icon)
  else
    self.unlock:SetActive(false)
    self.lock:SetActive(true)
    self.condition:SetText(StringTable.Get(cfg.UnLockDes))
  end
  self:Deselect()
  self._anim:Play("uieffanim_UISeasonS3CollageMusicItem_in")
end

function UISeasonS3CollageMusicItem:SetNew(new)
  self.new:SetActive(new)
end

function UISeasonS3CollageMusicItem:Select()
  self._bg.sprite = self._atlas:GetSprite("exp_s3_book_fengmian_1")
  self.musicName.color = Color(0.247, 0.62, 1, 1)
  self.author.color = Color(0.847, 0.847, 0.847, 1)
  self._light:SetActive(true)
  self._anim:Stop()
  self._anim:Play("uieffanim_UISeasonS3CollageMusicItem_play")
  self:PlayEft()
end

function UISeasonS3CollageMusicItem:Deselect()
  self._bg.sprite = self._atlas:GetSprite("exp_s3_book_fengmian_3")
  self.musicName.color = Color(0.188, 0.329, 0.612, 1)
  self.author.color = Color(0.58, 0.58, 0.58, 1)
  self._light:SetActive(false)
  self._anim:Stop()
  self._anim:Play("uieffanim_UISeasonS3CollageMusicItem_stop")
  self:PauseEft()
end

function UISeasonS3CollageMusicItem:PlayEft()
  self._playingMat:SetFloat("_Speed", 12)
end

function UISeasonS3CollageMusicItem:PauseEft()
  self._playingMat:SetFloat("_Speed", 0)
end

function UISeasonS3CollageMusicItem:RootOnClick(go)
  self._onClick(self._data)
end

function UISeasonS3CollageMusicItem:PlayExitAnim()
  self._anim:Stop()
end
