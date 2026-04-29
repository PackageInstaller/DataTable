_class("UITowerLayerItem", UICustomWidget)
UITowerLayerItem = UITowerLayerItem

function UITowerLayerItem:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.TowerLayerOnSelect, self.OnItemSelect)
end

function UITowerLayerItem:InitWidget()
  self.layerText = self:GetUIComponent("UILocalizationText", "layerText")
  self.valid = self:GetGameObject("valid")
  self.invalid = self:GetGameObject("invalid")
  self.bossBG = self:GetGameObject("bossBG")
  self.lockTextUp = self:GetUIComponent("UILocalizationText", "LockTextUp")
  self.lockTextDown = self:GetUIComponent("UILocalizationText", "LockTextDown")
  self.select = self:GetGameObject("select")
  self.cur = self:GetGameObject("cur")
  self.normal = self:GetGameObject("normal")
  self.boss = self:GetGameObject("boss")
  self.content = self:GetUIComponent("RectTransform", "content")
  self.tips = self:GetGameObject("Tips")
  self.reward = self:GetUIComponent("RawImageLoader", "reward")
end

function UITowerLayerItem:SetData(anchor, cfg, curLayer, passAll, curSelect, onSelect)
  self._onSelect = onSelect
  self._cfg = cfg
  local cfg_item = Cfg.cfg_item
  if anchor == 1 then
    self.content.anchoredPosition = Vector2(-136, 0)
  elseif anchor == 2 then
    self.content.anchoredPosition = Vector2(136, 0)
  end
  self.layerText:SetText(cfg.stage)
  self.layerText.color = Color.white
  if curLayer < cfg.stage then
    self.valid:SetActive(false)
    self:SetTextColor()
    self.invalid:SetActive(true)
    if cfg.RewardTip then
      self.tips:SetActive(true)
      self.reward:LoadImage(cfg_item[cfg.RewardTip].Icon)
    else
      self.tips:SetActive(false)
    end
  elseif curLayer > cfg.stage then
    local isBoss = cfg.BossLevel
    self.cur:SetActive(false)
    self.normal:SetActive(not isBoss)
    self.boss:SetActive(isBoss)
    self.valid:SetActive(true)
    self.invalid:SetActive(false)
    self.tips:SetActive(false)
  elseif passAll then
    local isBoss = cfg.BossLevel
    self.cur:SetActive(false)
    self.normal:SetActive(not isBoss)
    self.boss:SetActive(isBoss)
    self.valid:SetActive(true)
    self.invalid:SetActive(false)
    self.tips:SetActive(false)
  else
    self.cur:SetActive(true)
    self.layerText.color = Color.black
    self.normal:SetActive(false)
    self.boss:SetActive(false)
    self.valid:SetActive(true)
    self.invalid:SetActive(false)
    if cfg.RewardTip then
      self.tips:SetActive(true)
      self.reward:LoadImage(cfg_item[cfg.RewardTip].Icon)
    else
      self.tips:SetActive(false)
    end
  end
  self.select:SetActive(self._cfg.stage == curSelect)
end

function UITowerLayerItem:OnItemSelect(idx)
  self.select:SetActive(self._cfg.stage == idx)
end

function UITowerLayerItem:itemOnClick(go)
  self._onSelect(self._cfg.stage)
end

function UITowerLayerItem:SetTextColor()
  if self._cfg.BossLevel then
    self.bossBG:SetActive(true)
    self.lockTextUp.color = Color(0.592156862745098, 0.09411764705882353, 0.09411764705882353, 1)
    self.lockTextDown.color = Color(0.5333333333333333, 0.08235294117647059, 0.08235294117647059, 1)
  else
    self.bossBG:SetActive(false)
    self.lockTextUp.color = Color(0.4392156862745098, 0.4392156862745098, 0.4392156862745098, 1)
    self.lockTextDown.color = Color(0.4392156862745098, 0.4392156862745098, 0.4392156862745098, 1)
  end
end
