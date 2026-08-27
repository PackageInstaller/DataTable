local UITipsCacheItem = class("UISideTipsItem", UIBaseNode)
local base = UIBaseNode
local eCacheState = require("Game.Message.Side.eCacheState")
local cs_DoTween = CS.DG.Tweening.DOTween

function UITipsCacheItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._onFadeOut = BindCallback(self, self._FadeOutTween)
  self._onFadeIn = BindCallback(self, self._FadeInTween)
  self._onSeqComplete = BindCallback(self, self._SeqComplete)
  self._offsetY = self.transform.rect.height
  self._halfOffsetY = self._offsetY / 2
  self._showTime = 0.3
  self._oriposition = self.transform.position
end

function UITipsCacheItem:InitTipsCacheItem(msgData, uiMessageSide)
  self.msgData = msgData
  self.uiMessageSide = uiMessageSide
  self:_InitData(msgData)
  self:_InitUI(msgData)
  self:_InitTweenSeq()
end

function UITipsCacheItem:_InitData(msgData)
  self._waitSecond = msgData.waitTime
  self.curState = eCacheState.FadeIn
end

function UITipsCacheItem:_InitUI(msgData)
  self.transform:SetAsLastSibling()
  self.ui.obj_efficiency:SetActive(false)
  self.ui.obj_normal:SetActive(false)
  self.ui.obj_isCommonMessage:SetActive(false)
  local content = msgData.content
  if msgData.tipsType == eMessageSideType.normal or msgData.tipsType == nil then
    self.ui.obj_normal:SetActive(true)
    self.ui.tex_Content.text = content
  elseif msgData.tipsType == eMessageSideType.efficiency then
    self.ui.obj_efficiency:SetActive(true)
    local class = type(content)
    if class == "number" then
      local color = Color.white
      if 0 < content then
        color = self.ui.col_orange
        content = "+" .. tostring(content)
      else
        color = self.ui.col_red
        content = tostring(content)
      end
      self.ui.tex_EfficiencyNum.color = color
    end
    self.ui.tex_EfficiencyNum.text = content
  elseif msgData.tipsType == eMessageSideType.ecParameter then
    self.ui.obj_isCommonMessage:SetActive(true)
    local itemId = content.itemId
    local addNum = content.num
    if itemId == nil or addNum == nil then
      error("ecParameter cfg is wrong itemId:" .. tostring(itemId))
      return
    end
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("ecParameter itemCfg cfg is wrong itemId:" .. tostring(itemId))
      return
    end
    self.ui.img_common.sprite = CRH:GetSprite(itemCfg.icon)
    self.ui.tex_commonName.text = LanguageUtil.GetLocaleText(itemCfg.name)
    self.ui.tex_commonNum.text = "+" .. tostring(addNum)
  end
end

function UITipsCacheItem:_InitTweenSeq()
  if self._tweenSeq ~= nil then
    self._tweenSeq:Restart(false)
  else
    self.ui.fade.alpha = 0
    local tweenSeq = cs_DoTween.Sequence()
    tweenSeq:SetAutoKill(false)
    tweenSeq:SetUpdate(true)
    tweenSeq:InsertCallback(0, self._onFadeIn)
    tweenSeq:AppendInterval(self._showTime)
    tweenSeq:AppendCallback(function()
      self.curState = eCacheState.Show
    end)
    tweenSeq:AppendInterval(self._waitSecond)
    tweenSeq:AppendCallback(self._onFadeOut)
    tweenSeq:AppendInterval(self._showTime)
    tweenSeq:OnComplete(self._onSeqComplete)
    self._tweenSeq = tweenSeq
  end
end

function UITipsCacheItem:_FadeInTween()
  self.ui.fade:DOKill()
  self.ui.fade.alpha = 1
  self.ui.fade:DOFade(0, self._showTime):From()
  self.transform:DOKill()
  if not self.IsLayout(self.msgData) then
    self.transform.position = self._oriposition
  end
  self.transform:DOLocalMoveX(self.transform.sizeDelta.x * 1.1, self._showTime):From(true):SetRelative(true)
end

function UITipsCacheItem:_FadeOutTween()
  if self.curState == eCacheState.Show then
    self.curState = eCacheState.FadeOut
    self.ui.fade:DOKill()
    self.ui.fade.alpha = 1
    self.ui.fade:DOFade(0, self._showTime)
    if self.IsLayout(self.msgData) then
      self.transform:SetParent(self.uiMessageSide.ui.NormalParent)
      self.uiMessageSide.ui.layout:SetLayoutVertical()
    end
    self.transform:DOAnchorPosY(self._halfOffsetY, self._showTime)
  end
end

function UITipsCacheItem:_SeqComplete()
  if self.curState == eCacheState.Useless then
    return
  end
  self._tweenSeq:Complete(false)
  self.transform:DOKill()
  self.ui.fade:DOKill()
  self.ui.fade.alpha = 0
  self.transform.position = self._oriposition
  self.curState = eCacheState.Useless
end

function UITipsCacheItem.IsLayout(msgData)
  if msgData.tipsType == eMessageSideType.ecParameter then
    return true
  end
end

function UITipsCacheItem:OnDelete()
  if self._tweenSeq ~= nil then
    self._tweenSeq:Kill(true)
    self._tweenSeq = nil
  end
  self.transform:DOKill()
  self.ui.fade:DOKill()
  base.OnDelete(self)
end

return UITipsCacheItem
