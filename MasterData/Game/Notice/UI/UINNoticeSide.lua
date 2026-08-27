local UINNoticeSide = class("UINNoticeSide", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = CS.DG.Tweening.DOTween

function UINNoticeSide:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  local oldSize = self.ui.go_side.transform.sizeDelta
  self.inTweenSequence = cs_DoTween.Sequence():AppendCallback(function()
    self.ui.go_side.transform.sizeDelta = oldSize
    self.ui.sideList:SetLayoutVertical()
  end):Append(self.ui.side.transform:DOLocalMoveX(-self.ui.side.transform.sizeDelta.x, 0.4):From(true):SetRelative(true)):Pause():SetAutoKill(false):SetUpdate(true)
end

function UINNoticeSide:SideShowNotice(noticeData, resloader)
  self.resloader = resloader
  self.noticeData = noticeData
  self.inTweenSequence:Restart()
  self.ui.tex_Title_side.text = noticeData:GetNoticeTitle()
  self.ui.tex_Title_side:StartScrambleTypeWriter()
  self.ui.tex_Intro_side.text = noticeData:GetNoticeStr()
  self.ui.tex_Intro_side:StartScrambleTypeWriter()
  if not string.IsNullOrEmpty(noticeData:GetIcon()) then
    self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_HomeSide"), function(spriteAtlas)
      if spriteAtlas == nil or IsNull(self.ui) then
        return
      end
      self.ui.image_icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, noticeData:GetIcon())
    end)
  end
end

function UINNoticeSide:HideSideNotice(callback)
  if IsNull(self.gameObject) then
    return
  end
  self.callback = callback
  if self.outTweenSequence == nil then
    self.outTweenSequence = cs_DoTween.Sequence():Append(self.ui.side.transform:DOLocalMoveX(-self.ui.side.transform.sizeDelta.x * 1.5, 0.3):SetRelative(true)):Append(self.ui.go_side.transform:DOSizeDelta(Vector2.zero, 0.2):SetEase(CS.DG.Tweening.Ease.Linear):OnUpdate(function()
      self.ui.sideList:SetLayoutVertical()
    end)):AppendCallback(function()
      if self.callback ~= nil then
        self.callback()
      end
    end):Pause():SetAutoKill(false):SetUpdate(true)
  end
  self.outTweenSequence:Restart()
end

function UINNoticeSide:OnDelete()
  if self.inTweenSequence ~= nil then
    self.inTweenSequence:Kill()
    self.inTweenSequence = nil
  end
  if self.outTweenSequence ~= nil then
    self.outTweenSequence:Kill()
    self.outTweenSequence = nil
  end
  base.OnDelete(self)
end

return UINNoticeSide
