_class("UICollectCardReceiveItem", UICustomWidget)
UICollectCardReceiveItem = UICollectCardReceiveItem

function UICollectCardReceiveItem:OnShow(uiParam)
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._nameTex = self:GetUIComponent("UILocalizationText", "NameTex")
  self._specialBg = self:GetGameObject("SpecialBg")
  self._normalBg = self:GetGameObject("NormalBg")
  self._root = self:GetUIComponent("CanvasGroup", "root")
  self._anim = self:GetUIComponent("Animation", "UICollectCardReceiveItem")
end

function UICollectCardReceiveItem:SetData(idx, info)
  self._cardid = info.card_id
  self._cfg = Cfg.cfg_component_collect_card[self._cardid]
  local icon = self._cfg.Icon
  self._icon:LoadImage(icon)
  self._nameTex:SetText(StringTable.Get("str_collect_card_bag_tips6", info.player_name))
  self._specialBg:SetActive(self._cfg.Type == 2)
  self._normalBg:SetActive(self._cfg.Type == 1)
  self:PlayAnim(idx)
end

function UICollectCardReceiveItem:PlayAnim(idx)
  local yieldTime = idx // 5 * 66
  self._root.alpha = 0
  if 0 < yieldTime then
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._anim:Play()
    end)
  else
    self._anim:Play()
  end
end

function UICollectCardReceiveItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end
