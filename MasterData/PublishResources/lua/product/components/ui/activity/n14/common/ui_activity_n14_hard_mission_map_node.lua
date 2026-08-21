_class("UIActivityN14HardMissionMapNode", UICustomWidget)
UIActivityN14HardMissionMapNode = UIActivityN14HardMissionMapNode

function UIActivityN14HardMissionMapNode:Constructor()
end

function UIActivityN14HardMissionMapNode:OnShow(uiParams)
  self:InitWidget()
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGo), UIEvent.Press, function(go)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGo), UIEvent.Release, function(go)
  end)
end

function UIActivityN14HardMissionMapNode:InitWidget()
  self.bg = self:GetUIComponent("Image", "bg")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.name2 = self:GetUIComponent("UILocalizationText", "name_boss")
  self.star = self:GetGameObject("star")
  self.mask = self:GetUIComponent("Image", "mask")
  self.lock = self:GetUIComponent("Image", "lock")
  self.star1 = self:GetUIComponent("Image", "Star1")
  self.star2 = self:GetUIComponent("Image", "Star2")
  self.star3 = self:GetUIComponent("Image", "Star3")
  self._circleOutline = self:GetUIComponent("H3D.UGUI.CircleOutline", "name")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._stars = {
    self.star1,
    self.star2,
    self.star3
  }
  self._buttonBg = {
    type1 = {
      "bg1",
      "bg2",
      "bg3"
    }
  }
  self._atlas = self:GetAsset("UIN14.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._bgGo = self:GetGameObject("bg")
  self._btnGo = self:GetGameObject("btn")
  self._maskGo = self:GetGameObject("mask")
  self._passGo = self:GetGameObject("pass")
end

function UIActivityN14HardMissionMapNode:SetData(lineCfg, passInfo, cb, type, cfg, condition, missionCfgs)
  self._missionID = lineCfg.CampaignMissionId
  self._onClick = cb
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  local missionTypeCfg = missionCfgs[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self.name:SetText(StringTable.Get(missionCfg.Name))
  self.name2:SetText(StringTable.Get(missionCfg.Name))
  self.name2.gameObject:SetActive(false)
  local hardParam = type
  local typeCfg = cfg[missionTypeCfg.WayPointType]
  local bg
  local mask = typeCfg[hardParam].press
  local lock = typeCfg[hardParam].lock
  local textColor
  if passInfo then
    textColor = typeCfg[hardParam].textColor
    local module = self:GetModule(MissionModule)
    bg = typeCfg[hardParam].normal
  else
    textColor = typeCfg[hardParam].textColor
    bg = typeCfg[hardParam].normal
  end
  self.cfg = lineCfg
  self.condition = condition
  self:ConditionShow(condition)
  self._btnGo:SetActive(true)
  self._maskGo:SetActive(passInfo ~= nil or not condition)
  self._passGo:SetActive(passInfo ~= nil)
  self.bg.sprite = self._atlas:GetSprite(bg)
  self.mask.sprite = self._atlas:GetSprite(mask)
  self.lock.sprite = self._atlas:GetSprite(lock)
  self._circleOutline.effectColor = typeCfg[hardParam].textShadow
  textColor.a = not (passInfo == nil and condition) and textColor.a * 0.2 or textColor.a
  self.name.color = textColor
  textColor.a = 1
  if 0 <= lineCfg.MapPosY then
    self._anim:Play("uieff_UIXH1MissionNode_belowin")
  else
    self._anim:Play("uieff_UIXH1MissionNode_topin")
  end
end

function UIActivityN14HardMissionMapNode:_SetRed(isShow)
  local redObj = self:GetGameObject("red")
  redObj:SetActive(isShow)
end

function UIActivityN14HardMissionMapNode:ConditionShow(condition)
  self.lock.gameObject:SetActive(not condition)
end

function UIActivityN14HardMissionMapNode:btnOnClick(go)
  if not self.condition then
    local lvName = ""
    for i, v in pairs(self.cfg.NeedMissionList) do
      local cfgv = Cfg.cfg_campaign_mission[v]
      lvName = lvName .. StringTable.Get(cfgv.Name)
      if i == #self.cfg.NeedMissionList then
        break
      end
      lvName = lvName .. " "
    end
    ToastManager.ShowToast(StringTable.Get("str_activity_common_will_open_after_clearance", lvName))
    return
  end
  self._onClick(self._missionID, false, self._rectTransform.position)
end
