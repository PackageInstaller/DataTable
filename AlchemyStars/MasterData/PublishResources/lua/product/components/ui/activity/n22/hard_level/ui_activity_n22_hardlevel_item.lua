_class("UIActivityN22HardLevelItem", UICustomWidget)
UIActivityN22HardLevelItem = UIActivityN22HardLevelItem

function UIActivityN22HardLevelItem:Constructor(uiview)
  self._view = uiview
  self:OnShow()
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._press), UIEvent.Press, function(go)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._press), UIEvent.Release, function(go)
  end)
end

function UIActivityN22HardLevelItem:OnShow()
  self._titleImg = self._view:GetUIComponent("Image", "TitleBg")
  self._normal = self._view:GetUIComponent("Image", "normal")
  self._pass = self._view:GetUIComponent("Image", "pass")
  self._close = self._view:GetUIComponent("Image", "close")
  self._clickimg = self._view:GetUIComponent("Image", "clickimg")
  self._press = self._view:GetGameObject("press")
  self._name = self._view:GetUIComponent("UILocalizationText", "name")
  self._nameRoot = self._view:GetGameObject("nameRoot")
  self._animation = self._view:GetUIComponent("Animation", "anim")
  self._localPos = self._view.transform.localPosition:Clone()
end

function UIActivityN22HardLevelItem:OnHide()
end

function UIActivityN22HardLevelItem:SetData(idx, cfg, passInfo, cur, atlas)
  local levelCfg = UIActivtiyN22HardLevelController.LevelCfg[idx]
  self._titleImg.sprite = atlas:GetSprite(levelCfg.title)
  self._normal.sprite = atlas:GetSprite(levelCfg.normal)
  self._pass.sprite = atlas:GetSprite(levelCfg.close)
  self._close.sprite = atlas:GetSprite(levelCfg.close)
  self._clickimg.sprite = atlas:GetSprite(levelCfg.click)
  self._clickimg.gameObject:SetActive(false)
  if idx < cur then
    if not passInfo then
      Log.exception("没有通关信息：", idx)
    end
    self._pass.gameObject:SetActive(true)
    self._close.gameObject:SetActive(false)
  elseif cur < idx then
    self._pass.gameObject:SetActive(false)
    self._close.gameObject:SetActive(true)
  else
    self._normal.gameObject:SetActive(true)
    self._pass.gameObject:SetActive(false)
    self._close.gameObject:SetActive(false)
  end
  local missionCfg = Cfg.cfg_campaign_mission[cfg.CampaignMissionId]
  self._name:SetText(StringTable.Get(missionCfg.Name))
end

function UIActivityN22HardLevelItem:LocalPosition()
  return self._localPos
end

function UIActivityN22HardLevelItem:Anim_Pass()
end

function UIActivityN22HardLevelItem:Anim_Open()
end

function UIActivityN22HardLevelItem:SetActive(bShow)
  self._view.gameObject:SetActive(bShow)
end
