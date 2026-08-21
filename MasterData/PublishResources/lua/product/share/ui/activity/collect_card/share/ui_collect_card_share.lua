_class("UICollectCardShare", UIController)
UICollectCardShare = UICollectCardShare

function UICollectCardShare:Constructor()
end

function UICollectCardShare:GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._sBg = self:GetGameObject("S")
  self._nBg = self:GetGameObject("N")
  self._cardName = self:GetUIComponent("UILocalizationText", "cardName")
  self._shareTips = self:GetUIComponent("UILocalizationText", "shareTips")
end

function UICollectCardShare:OnShow(uiParams)
  self:GetComponents()
  self._cardid = uiParams[1]
  self:OnValue()
end

function UICollectCardShare:OnValue()
  local cfg = Cfg.cfg_component_collect_card[self._cardid]
  self._cardName:SetText("【" .. StringTable.Get(cfg.Name) .. "】")
  self._icon:LoadImage(cfg.IconBig)
  self._sBg:SetActive(cfg.Type == 2)
  self._nBg:SetActive(cfg.Type == 1)
  local info = GameGlobal.GameLogic().ClientInfo
  local source = info.m_login_source
  local tips
  if source == MobileClientLoginChannel.MCLC_WX then
    tips = "str_collect_card_share_wechat"
  else
    tips = "str_collect_card_share_qq"
  end
  self._shareTips:SetText(StringTable.Get(tips))
  self:Share()
end

function UICollectCardShare:OnHide()
end

function UICollectCardShare:Share(go)
  self:Lock("UICollectCardShare")
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    self:ShowDialog("UIShare", self:GetName(), ShareAnchorType.BottomRight, function()
      self:CloseDialog()
    end, ShareAnchorType.Hide, nil, nil, nil, nil, nil, "red")
    self:UnLock("UICollectCardShare")
  end, self)
end
