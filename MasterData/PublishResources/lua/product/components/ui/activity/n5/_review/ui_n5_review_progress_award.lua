_class("UIN5ReviewProgressAward", UICustomWidget)
UIN5ReviewProgressAward = UIN5ReviewProgressAward

function UIN5ReviewProgressAward:OnShow(uiParams)
  self:InitWidget()
end

function UIN5ReviewProgressAward:InitWidget()
  self.icon = self:GetUIComponent("Image", "icon")
  self.root = self:GetUIComponent("RectTransform", "root")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIN5ReviewProgressAward:SetData(idx, curIndex, progress, curProgress, status)
  local parent = self.root.parent:GetComponent(typeof(UnityEngine.RectTransform))
  local width = parent.rect.width
  self.root.anchoredPosition = Vector2(width * progress / 100, 0)
  local atlas = self:GetAsset("UIN5.spriteatlas", LoadType.SpriteAtlas)
  if curIndex == -1 then
    self.root.anchoredPosition = Vector2(width * progress / 100, 0)
    self.icon.sprite = atlas:GetSprite("hdhg_n5zjm_icon02")
  elseif status == 1 then
    self.root.anchoredPosition = Vector2(width * progress / 100, 0)
    self.icon.sprite = atlas:GetSprite("hdhg_n5zjm_icon02")
  elseif status == 2 then
    self.root.anchoredPosition = Vector2(width * progress / 100, 2)
    self.icon.sprite = atlas:GetSprite("hdhg_n5zjm_icon03")
  elseif status == 3 then
    self.root.anchoredPosition = Vector2(width * progress / 100, 0)
    self.icon.sprite = atlas:GetSprite("hdhg_n5zjm_icon01")
  end
  self.icon:SetNativeSize()
end

function UIN5ReviewProgressAward:PlayEnterAni(delay)
  self:StartTask(function(TT)
    YIELD(TT, delay)
    self.animation:Play("uieff_N24_Main_Review_icon01")
  end, self)
end
