local UINHomeNoticeItem = class("UINHomeNoticeItem", UIBaseNode)
local base = UIBaseNode
local CS_DoTween = CS.DG.Tweening.DOTween

function UINHomeNoticeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.m_OnPlayOver = BindCallback(self, self.OnPlayOver)
end

function UINHomeNoticeItem:InitNoticeItem(noticeData, OnTweenPlayOver, resloader)
  self.OnTweenPlayOver = OnTweenPlayOver
  self.ui.tex_Content.text = noticeData:GetNoticeStr()
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_HomeSide"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, noticeData:GetIcon())
  end)
  local sequence = CS_DoTween.Sequence()
  sequence:Append(self.ui.tipsItem:DOLocalMoveX(0, 0.5))
  sequence:Append(self.ui.tipsItem:DOLocalMoveX(-600, 0.5):SetDelay(3))
  sequence:AppendCallback(self.m_OnPlayOver)
  sequence:SetAutoKill(true)
  sequence:Play()
  self.sequence = sequence
end

function UINHomeNoticeItem:OnPlayOver()
  if self.OnTweenPlayOver ~= nil then
    self.OnTweenPlayOver()
  end
  self.sequence = nil
end

function UINHomeNoticeItem:OnDelete()
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
  base.OnDelete(self)
end

return UINHomeNoticeItem
