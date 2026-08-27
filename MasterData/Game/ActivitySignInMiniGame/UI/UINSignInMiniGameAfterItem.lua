local UINSignInMiniGameAfterItem = class("UINSignInMiniGameDayItem", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local cs_DoTween = CS.DG.Tweening.DOTween

function UINSignInMiniGameAfterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
end

function UINSignInMiniGameAfterItem:InitSignInMiniGameAfterItem(ctrl, signData, resLoader, index, isNeedAnim)
  local userInfoData = PlayerDataCenter.inforData
  local leftDay = ctrl:GetLeftDayWithCurTime(signData.signTime)
  local range = ctrl:GetSignDataRange(index, signData)
  local totalDay = ctrl:GetTotalSignDay()
  self.minigameCtrl = ctrl
  self.ui.tex_playerName.text = userInfoData:GetUserName()
  self.ui.tex_UID.text = "UID:" .. userInfoData:GetUserUID()
  self.userHeadNode:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), resLoader)
  if leftDay < 1 then
    self.ui.tex_date.text = LanguageUtil.GetLocaleText(ConfigData.sign_minigame_text[13].content)
  else
    self.ui.tex_date.text = leftDay .. LanguageUtil.GetLocaleText(ConfigData.sign_minigame_text[14].content)
  end
  local actId = ctrl:GetActId()
  local emojiCfg = ConfigData.sign_minigame_emoji[actId] and ConfigData.sign_minigame_emoji[actId][signData.emojiId]
  if emojiCfg == nil then
    error(string.format("Cant get sign_minigame_emoji cfg, actId:%s, emojiId:%s", actId, signData.emojiId))
  else
    local atlasName = ctrl:GetActSignInMiniGameAtlasName()
    self.ui.img_emoji.sprite = AtlasUtil.GetSpriteFromAtlas(atlasName, emojiCfg.name, resLoader)
  end
  local textCfg = ConfigData.sign_minigame_text[signData.textId]
  if textCfg ~= nil then
    self.ui.tex_text.text = string.format(LanguageUtil.GetLocaleText(textCfg.content), index, totalDay)
  end
  if isNeedAnim then
    if self.animTween == nil then
      self.animTween = cs_DoTween.Sequence()
      self.animTween:AppendCallback(function()
        self.ui.tween_Hot:DORestartById("hot")
        self.ui.tex_tag:SetIndex(range - 1)
        self.ui.img_tag:SetIndex(range - 1)
        self.ui.img_tag.image.color = Color.New(1, 1, 1, 0)
        AudioManager:PlayAudioById(1251)
      end):Join(self.ui.tex_likeNum:DOCounter(0, signData.hot, 1.5)):AppendCallback(function()
        self.ui.tween_Tag:DORestartById("Anim")
      end):AppendInterval(1):AppendCallback(function()
        self.minigameCtrl:ShowAward()
      end):SetAutoKill(false):Pause()
    end
    self.animTween:Restart()
  else
    self.ui.tex_likeNum.text = signData.hot
    self.ui.tex_tag:SetIndex(range - 1)
    self.ui.img_tag:SetIndex(range - 1)
  end
end

function UINSignInMiniGameAfterItem:OnDelete()
  base.OnDelete(self)
  self.userHeadNode:Delete()
  if self.animTween ~= nil then
    self.animTween:Kill()
    self.animTween = nil
  end
end

return UINSignInMiniGameAfterItem
