_class("UILuckLandRankItem", UICustomWidget)
UILuckLandRankItem = UILuckLandRankItem

function UILuckLandRankItem:OnShow(uiParams)
  self:_InitWidget()
end

function UILuckLandRankItem:_InitWidget()
  self._rankText = self:GetUIComponent("UILocalizedTMP", "RankText")
  self._headIcon = self:GetUIComponent("RawImageLoader", "HeadIcon")
  self._head_icon_rect = self:GetUIComponent("RectTransform", "HeadIcon")
  self._nickName = self:GetUIComponent("UILocalizationText", "NickName")
  self._score = self:GetUIComponent("UILocalizationText", "Score")
  self._rGO = {}
  self._rGO[1] = self:GetGameObject("R1")
  self._rGO[2] = self:GetGameObject("R2")
  self._rGO[3] = self:GetGameObject("R3")
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UILuckLandRankItem:SetData(index, info)
  self._index = index
  for i = 1, 3 do
    self._rGO[i]:SetActive(false)
  end
  if index <= 3 then
    self._rGO[index]:SetActive(true)
    self._rankText:SetText("")
  elseif 100 < index then
    self._rankText:SetText("100+")
  else
    self._rankText:SetText(tostring(index))
  end
  local headIcon = info.head
  local cfg_header = Cfg.cfg_role_head_image[headIcon]
  if cfg_header then
    self._headIcon:LoadImage(cfg_header.Icon)
    HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._head_icon_rect, cfg_header.Tag)
  end
  self._nickName:SetText(info.nick)
  self._score:SetText(info.damage)
end

function UILuckLandRankItem:PlayAnimation()
  self._animation:Play("uieff_UILuckLandRankItem_in")
end
