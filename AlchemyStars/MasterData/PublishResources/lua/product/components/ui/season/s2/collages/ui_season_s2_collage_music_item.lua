_class("UISeasonS2CollageMusicItem", UICustomWidget)
UISeasonS2CollageMusicItem = UISeasonS2CollageMusicItem

function UISeasonS2CollageMusicItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonS2CollageMusicItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.musicName = self:GetUIComponent("UILocalizationText", "musicName")
  self.author = self:GetUIComponent("UILocalizationText", "author")
  self.unlock = self:GetGameObject("Unlock")
  self.lock = self:GetGameObject("Lock")
  self.condition = self:GetUIComponent("UILocalizationText", "condition")
  self.new = self:GetGameObject("new")
  self._layout = self:GetUIComponent("LayoutElement", "UISeasonS2CollageMusicItem")
  self._bg = self:GetUIComponent("Image", "Unlock")
  self._mask = self:GetUIComponent("Image", "mask")
  self._atlas = self:GetAsset("UIS2Collages.spriteatlas", LoadType.SpriteAtlas)
  self._light = self:GetGameObject("Light")
  self._disc = self:GetUIComponent("RectTransform", "Disc")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._playingEff = self:GetUIComponent("RawImage", "eff_yinpu")
  self._playingMat = self._playingEff.material
end

function UISeasonS2CollageMusicItem:SetData(data, onClick)
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
end

function UISeasonS2CollageMusicItem:SetNew(new)
  self.new:SetActive(new)
end

function UISeasonS2CollageMusicItem:Select()
  self._bg.sprite = self._atlas:GetSprite("exp_s2_book_fengmian_2")
  self._mask.sprite = self._atlas:GetSprite("exp_s2_book_fengmian_1")
  self.musicName.color = Color(0.3058823529411765, 0.20392156862745098, 0.11764705882352941)
  self.author.color = Color(0.6901960784313725, 0.4, 0.09019607843137255)
  self._light:SetActive(true)
  self._anim:Stop()
  self._anim:Play("uieffanim_UISeasonS1CollageMusicItem_play")
  self:PlayEft()
end

function UISeasonS2CollageMusicItem:Deselect()
  self._bg.sprite = self._atlas:GetSprite("exp_s2_book_fengmian_4")
  self._mask.sprite = self._atlas:GetSprite("exp_s2_book_fengmian_3")
  self.musicName.color = Color(0.8705882352941177, 0.6941176470588235, 0.49411764705882355)
  self.author.color = Color(0.6901960784313725, 0.4, 0.09019607843137255)
  self._light:SetActive(false)
  self._anim:Stop()
  self._anim:Play("uieffanim_UISeasonS1CollageMusicItem_stop")
  self:PauseEft()
end

function UISeasonS2CollageMusicItem:PlayEft()
  self._playingMat:SetFloat("_Speed", 12)
end

function UISeasonS2CollageMusicItem:PauseEft()
  self._playingMat:SetFloat("_Speed", 0)
end

function UISeasonS2CollageMusicItem:RootOnClick(go)
  self._onClick(self._data)
end

function UISeasonS1CollageMusicItem:PlayExitAnim()
  self._anim:Stop()
  self._anim:Play("uieffanim_UISeasonS1CollageMusicItem_out")
end
