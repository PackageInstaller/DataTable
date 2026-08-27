local UIDormFightFormation = class("UIDormFightFormation", UIBaseWindow)
local base = UIBaseWindow
local UIDormFightFmtEditNode = require("Game.DormFight.UI.UIDormFightFmtEditNode")
local UIDormFightNormalNode = require("Game.DormFight.UI.UIDormFightNormalNode")
local JumpManager = require("Game.Jump.JumpManager")
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local cs_tweening = CS.DG.Tweening

function UIDormFightFormation:OnInit()
  self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  self.editNode = nil
  self.normalNode = UIDormFightNormalNode.New()
  self.normalNode:Init(self.ui.obj_notEditorNode)
  self.otherUserHead = UINUserHead.New()
  self.otherUserHead:Init(self.ui.obj_UINUserHead)
  local editorModelSeq = cs_tweening.DOTween.Sequence()
  editorModelSeq:Pause()
  editorModelSeq:SetAutoKill(false)
  self.editorModelSeq = editorModelSeq
  self.normalNodeSeq = self:__InitPageSeq(self.ui.can_notEditorNode, function()
    self.normalNode:Hide()
  end)
  self.editorSeq = self:__InitPageSeq(self.ui.can_editorNode, function()
    if self.editNode == nil then
      self.ui.obj_editorNode:SetActive(false)
    else
      self.editNode:Hide()
    end
  end)
  self.curPageSeq = self.normalNodeSeq
  self.curPageSeq:Restart()
end

function UIDormFightFormation:InitUIDormFightFormation(fmtCtrl)
  self.fmtCtrl = fmtCtrl
  JumpManager.couldUseItemJump = false
  if self.editNode == nil then
    self.ui.obj_editorNode:SetActive(false)
  else
    self.editNode:Hide()
  end
  self.normalNode:InitDormFightNormalNode(fmtCtrl)
  self:InitOtherInfoUI()
  local dormFightCtrl = self.fmtCtrl.dormFightCtrl
  if dormFightCtrl.otherPickHeroInfo ~= nil and dormFightCtrl.otherPickHeroInfo.duelId == dormFightCtrl:GetCurrentDuelId() then
    self:OnOtherSelectReady()
  end
end

function UIDormFightFormation:EnterEditorMode()
  if self.editNode == nil then
    self.editNode = UIDormFightFmtEditNode.New()
    self.editNode:Init(self.ui.obj_editorNode)
    self.editNode:InitFmtEditNode(self.fmtCtrl)
  end
  self.editNode:Show()
  self.editNode:OpenEditNode()
  self:__SwitchPageTween(self.editorSeq)
end

function UIDormFightFormation:ExitEditorMode()
  self.normalNode:Show()
  self.editNode:CloseEditNode()
  self:__SwitchPageTween(self.normalNodeSeq)
end

function UIDormFightFormation:InitOtherInfoUI()
  if self.fmtCtrl == nil or self.fmtCtrl.dormFightCtrl == nil then
    return
  end
  local userInfoData = self.fmtCtrl.dormFightCtrl:GetOtherUserData()
  if userInfoData == nil then
    return
  end
  local name = userInfoData:GetUserName()
  local resLoader = self.fmtCtrl:GetResloader()
  self:SetOtherNameText(name)
  self.otherUserHead:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), resLoader)
end

function UIDormFightFormation:GetOtherName()
  if self.fmtCtrl == nil or self.fmtCtrl.dormFightCtrl == nil then
    return ""
  end
  local userData = self.fmtCtrl.dormFightCtrl:GetOtherUserData()
  return userData:GetUserName()
end

function UIDormFightFormation:SetOtherNameText(name)
  local otherName = name
  self.ui.tex_Name.text = otherName
end

function UIDormFightFormation:SetActiveNormalStateUI(value)
  self.ui.obj_notEditorNode:SetActive(value)
end

function UIDormFightFormation:OnOtherSelectReady()
  self.ui.obj_RequestFriendItem:SetActive(true)
end

function UIDormFightFormation:__SwitchPageTween(curPageSeq)
  if self.curPageSeq == curPageSeq then
    return
  end
  self.curPageSeq:PlayBackwards()
  curPageSeq:Restart()
  self.curPageSeq = curPageSeq
end

function UIDormFightFormation:__InitPageSeq(pageFade, rewindAct)
  local pageSeq = cs_tweening.DOTween.Sequence()
  pageSeq:Append(pageFade:DOFade(0, 0.5):From())
  pageSeq:Join(pageFade.transform:DOAnchorPosY(pageFade.transform.anchoredPosition.y - 200, 0.5):From())
  pageSeq:OnRewind(rewindAct)
  pageSeq:Pause()
  pageSeq:SetAutoKill(false)
  return pageSeq
end

function UIDormFightFormation:OnDelete()
  self.normalNode:Delete()
  self.normalNode = nil
  self.otherUserHead:Delete()
  self.otherUserHead = nil
  if self.editNode ~= nil then
    self.editNode:Delete()
    self.editNode = nil
  end
  UIUtil.SetGlobalHideTopStatus(false)
  UIUtil.SetGlobalIsBlockEsc(false)
  base.OnDelete(self)
end

return UIDormFightFormation
