_class("UIHomelandAnonymousMovieItem", UICustomWidget)
UIHomelandAnonymousMovieItem = UIHomelandAnonymousMovieItem

function UIHomelandAnonymousMovieItem:Constructor()
  self._assestData = nil
end

function UIHomelandAnonymousMovieItem:OnShow(uiParams)
  self:InitWidget()
end

function UIHomelandAnonymousMovieItem:InitWidget()
  self._assest = self:GetUIComponent("RawImageLoader", "assest")
  self._received = self:GetUIComponent("Image", "received")
  self.anim = self:GetUIComponent("Animation", "received")
  self._receivedObj = self:GetGameObject("received")
  self._countText = self:GetUIComponent("UILocalizationText", "countText")
end

function UIHomelandAnonymousMovieItem:SetData(data, received)
  self._assestData = data
  self:InitData()
  self:SetReceived(received)
end

function UIHomelandAnonymousMovieItem:SetReceived(isShow)
  self._receivedObj:SetActive(isShow)
  if isShow then
    self.anim:Play("uieff_N26_UIHomelandAnonymousMovieItem_received")
  end
end

function UIHomelandAnonymousMovieItem:RewardOnClick(go)
  self:ShowDialog("UIItemTipsHomeland", self._assestData[1], go)
end

function UIHomelandAnonymousMovieItem:InitData()
  local itemcfg = Cfg.cfg_item[self._assestData[1]]
  self._assest:LoadImage(itemcfg.Icon)
  self._countText:SetText(self._assestData[2])
end
