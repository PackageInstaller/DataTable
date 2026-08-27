local UINHomeSideNoticeItem = class("UINHomeSideNoticeItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
local cs_DoTween = CS.DG.Tweening.DOTween

function UINHomeSideNoticeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_tipsItem, self, self.OnClickBtn)
end

function UINHomeSideNoticeItem:InitSideResItem(CloseSide, resloader, refeshAllNotices)
  self.CloseSide = CloseSide
  self.resloader = resloader
  self.refeshAllNotices = refeshAllNotices
end

function UINHomeSideNoticeItem:RefreshSideResItem(noticeData)
  self.noticeData = noticeData
  self.ui.tex_Content.text = noticeData:GetNoticeStr()
  self.timeStamp = noticeData.timeStamp
  self.jumpInfo = noticeData.jumpInfo
  self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_HomeSide"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, noticeData:GetIcon())
  end)
  self:RefreshTime()
end

function UINHomeSideNoticeItem:RefreshTime()
  local timePassed = PlayerDataCenter.timestamp - self.timeStamp
  if timePassed <= 60 then
    self.ui.tex_Timer:SetIndex(0, "1")
  elseif timePassed <= 3600 then
    self.ui.tex_Timer:SetIndex(0, tostring(math.floor(timePassed / 60)))
  elseif timePassed <= 86400 then
    self.ui.tex_Timer:SetIndex(1, tostring(math.floor(timePassed / 3600)))
  else
    local dataTable = TimeUtil:TimestampToDate(self.timeStamp, nil, true)
    self.ui.tex_Timer:SetIndex(2, tostring(dataTable.month), tostring(dataTable.day))
  end
end

function UINHomeSideNoticeItem:OnClickBtn()
  NoticeManager:DeleteNotice(self.noticeData)
  if self.jumpInfo == nil then
    if self.refeshAllNotices ~= nil then
      self.refeshAllNotices()
    end
    return
  end
  JumpManager:Jump(self.jumpInfo.jumpType, function(jumpCallback)
    if self.CloseSide ~= nil then
      self.CloseSide()
    end
    if jumpCallback ~= nil then
      jumpCallback()
    end
  end, nil, self.jumpInfo.argList)
end

function UINHomeSideNoticeItem:PlayHideTween(callback)
  self.outTweenSequence = cs_DoTween.Sequence():Append(self.transform:DOLocalMoveX(-self.transform.sizeDelta.x, 0.2):SetRelative(true)):AppendCallback(function()
    if callback ~= nil then
      callback()
    end
  end):Pause():SetAutoKill(true)
  self.outTweenSequence:Restart()
end

function UINHomeSideNoticeItem:OnDelete()
  if self.outTweenSequence ~= nil then
    self.outTweenSequence:Kill()
    self.outTweenSequence = nil
  end
  base.OnDelete(self)
end

return UINHomeSideNoticeItem
