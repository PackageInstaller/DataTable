local CS = _ENV.CS
local Vector2 = CS.UnityEngine.Vector2
local DOTween = CS.DG.Tweening.DOTween
local GainTipsItem, Super = System.NewComponent("GainTipsItem")

function GainTipsItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = Function_ReliqueCount_TipsResource(uiNode)
  self.data = data
  self.isPlayingAnim = false
  self.playCb = nil
  self.transform = self.ui.uiNode.transform
  self.width = UIRootMgr.GetUIRootWidth()
  self:InitTransParams()
end

function GainTipsItem:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Image_Icon, function()
    if 0 == self.data.configId then
      return ""
    end
    local config = ItemDataUtils.GetItemConfig(self.data.configId)
    if not config then
      Logger.Debug("config not found, configId  ========> " .. self.data.configId)
      return
    end
    do return ItemDataUtils.GetSmallIcon end
    return ItemDataUtils.GetSmallIcon, self.data.configId, self.data.configId
  end)
  binder:BindToText(self.ui.Text_Desc, function()
    if 0 == self.data.configId then
      return self.data.desc
    end
    local config = ItemDataUtils.GetItemConfig(self.data.configId)
    if not config then
      Logger.Debug("config not found, configId  ========> " .. self.data.configId)
      return
    end
    local str = string.format("%s", self.data.desc)
    if config.Type == CommonDefine.ItemType.Currency then
      str = self.data.desc
    end
    return str
  end)
end

function GainTipsItem:OnUnbind()
  DOTweenUtils.KillAllTweensByTarget(self)
end

function GainTipsItem:InitTransParams()
  local rectTransform = self.transform
  rectTransform.anchorMin = Vector2(0, 0.5)
  rectTransform.anchorMax = Vector2(0, 0.5)
  rectTransform.anchoredPosition = Vector2(self.width, rectTransform.localPosition.y)
end

function GainTipsItem:PlayAnim()
  local sequence = DOTween.Sequence(self)
  sequence:Append(self.transform:DOAnchorPosX(self.width - self.transform.sizeDelta.x, 0.3))
  sequence:Append(self.transform:DOAnchorPosY(0, 0.8))
  sequence:Append(self.transform:DOAnchorPosY(180, 0.9))
  sequence:Join(self.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)):DOFade(0, 0.9):OnComplete(function()
    if self.playCb then
      self.playCb()
    end
  end))
end

function GainTipsItem:SetAnimTimer()
  self.timer = TimerManager.Instance:CreateTimer(self.animTime, 1, nil, function()
    self.isPlayingAnim = false
    TimerManager.Instance:StopTimer(self.timer)
    self.timer = nil
    if self.playCb then
      self.playCb()
    end
  end)
end

function GainTipsItem:SetPlayCallback(callback)
  self.playCb = callback
end

return GainTipsItem
