local base = UIBaseNode
local UINDormFightInvitedSideItem = class("UINDormFightInvitedSideItem", base)
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local cs_DoTween = CS.DG.Tweening.DOTween

function UINDormFightInvitedSideItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.userHead = UINUserHead.New()
  self.userHead:Init(self.ui.uINUserHead)
  local oldSize = self.ui.go_side.transform.sizeDelta
  self.inTweenSequence = cs_DoTween.Sequence():AppendCallback(function()
    self.ui.go_side.transform.sizeDelta = oldSize
    self.ui.sideList:SetLayoutVertical()
  end):Append(self.ui.side.transform:DOLocalMoveX(-self.ui.side.transform.sizeDelta.x, 0.4):From(true):SetRelative(true)):Pause():SetAutoKill(false):SetUpdate(true)
end

function UINDormFightInvitedSideItem:SideShowNotice(noticeData, resloader)
  self.resloader = resloader
  self.noticeData = noticeData
  self.inTweenSequence:Restart()
  self.ui.tex_Intro_side.text = noticeData:GetNoticeStr()
  self.ui.tex_Intro_side:StartScrambleTypeWriter()
  if noticeData.extraData ~= nil and noticeData.extraData.userInfoData ~= nil then
    local userInfoData = noticeData.extraData.userInfoData
    self.ui.tex_Title_side.text = userInfoData:GetUserName()
    self.ui.tex_Title_side:StartScrambleTypeWriter()
    self.userHead:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), resloader)
  end
end

function UINDormFightInvitedSideItem:HideSideNotice(callback)
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

function UINDormFightInvitedSideItem:OnDelete()
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

return UINDormFightInvitedSideItem
