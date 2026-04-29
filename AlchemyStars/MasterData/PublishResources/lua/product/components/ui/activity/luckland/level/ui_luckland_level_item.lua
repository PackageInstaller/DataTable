_class("UILuckLandLevelItem", UICustomWidget)
UILuckLandLevelItem = UILuckLandLevelItem

function UILuckLandLevelItem:OnShow(uiParams)
  self._atlas = self:GetAsset("LuckLand.spriteatlas", LoadType.SpriteAtlas)
  self:_InitWidget()
  self._bgSprite = {
    [1] = "n40_xydl_xxg_04-1",
    [2] = "n40_xydl_xxg_04-2",
    [3] = "n40_xydl_xxg_04-3",
    [4] = "n40_xydl_xxg_04-4",
    [5] = "n40_xydl_xxg_04-5",
    [6] = "n40_xydl_xxg_04-0"
  }
end

function UILuckLandLevelItem:_InitWidget()
  self._centerRect = self:GetUIComponent("RectTransform", "Center")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._starGO = self:GetGameObject("Star")
  self._starImg = {}
  self._starImg[1] = self:GetUIComponent("Image", "1")
  self._starImg[2] = self:GetUIComponent("Image", "2")
  self._starImg[3] = self:GetUIComponent("Image", "3")
  self._btnImg = self:GetUIComponent("Image", "Btn")
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UILuckLandLevelItem:SetData(cfg, index, component, isUnlock, play)
  self._cfg = cfg
  self._clientCfg = Cfg.cfg_luckland_client_mission[self._cfg.MissionID]
  self._index = index
  self._centerRect.anchoredPosition = Vector2(0, self._index % 2 * 266.4)
  self._component = component
  self._componentInfo = self._component:GetComponentInfo()
  self._isUnlock = isUnlock
  self:_SetUIInfo()
  if play then
    self:StartTask(function(TT)
      YIELD(TT, (index - 1) * 100)
      self:PlayAnimation(true)
    end, self)
  end
end

function UILuckLandLevelItem:_SetUIInfo()
  if not self._isUnlock then
    self.view:GetGameObject():SetActive(false)
    return
  end
  if not self._clientCfg then
    return
  end
  self.view:GetGameObject():SetActive(true)
  self._name:SetText(StringTable.Get(self._clientCfg.Name))
  local passInfo = self._componentInfo.m_pass_mission_info[self._clientCfg.ID]
  if passInfo then
    local starMask = passInfo.star
    for i = 1, 3 do
      if starMask >> i - 1 & 1 > 0 then
        self._starImg[i].sprite = self._atlas:GetSprite("n40_xydl_xxg_04-star01")
      else
        self._starImg[i].sprite = self._atlas:GetSprite("n40_xydl_xxg_04-star02")
      end
    end
  else
    for i = 1, 3 do
      self._starImg[i].sprite = self._atlas:GetSprite("n40_xydl_xxg_04-star02")
    end
  end
  local spriteName = self._bgSprite[self._cfg.Line]
  if self._cfg.Type == LuckLandLevelType.Initial then
    spriteName = self._bgSprite[6]
  elseif self._cfg.Type == LuckLandLevelType.Rank then
    spriteName = self._bgSprite[5]
  end
  self._btnImg.sprite = self._atlas:GetSprite(spriteName)
end

function UILuckLandLevelItem:BtnOnClick(go)
  self:ShowDialog("UILuckLandLevelInfo", self._cfg, self._clientCfg, self._component)
end

function UILuckLandLevelItem:IsUnlock()
  return self._isUnlock
end

function UILuckLandLevelItem:IsInitial()
  return self._cfg.Type == LuckLandLevelType.Initial
end

function UILuckLandLevelItem:PlayAnimation(isIn)
  if self._animation then
    if isIn then
      self._animation:Play("uieff_UILuckLandLevelItem_in")
    else
      self._animation:Play("uieff_UILuckLandLevelItem_out")
    end
  end
end
