_class("UIActivityLineLevelNodeBaseWidget", Object)
UIActivityLineLevelNodeBaseWidget = UIActivityLineLevelNodeBaseWidget

function UIActivityLineLevelNodeBaseWidget:Constructor(uiView)
  self._uiView = uiView
  self._star1 = self._uiView:GetGameObject("star1")
  self._star2 = self._uiView:GetGameObject("star2")
  self._star3 = self._uiView:GetGameObject("star3")
  self._name = self._uiView:GetUIComponent("UILocalizationText", "name")
  self._stars = {}
  if self._star1 then
    self._stars[#self._stars + 1] = self._star1
  end
  if self._star2 then
    self._stars[#self._stars + 1] = self._star2
  end
  if self._star3 then
    self._stars[#self._stars + 1] = self._star3
  end
end

function UIActivityLineLevelNodeBaseWidget:Refresh(name, stars)
  self._name:SetText(name)
  for i = 1, 3 do
    if self._stars[i] then
      local pass = i <= stars
      if pass then
        self._stars[i]:SetActive(true)
      else
        self._stars[i]:SetActive(false)
      end
    end
  end
end

_class("UIActivityLineLevelNodeBase", UICustomWidget)
UIActivityLineLevelNodeBase = UIActivityLineLevelNodeBase

function UIActivityLineLevelNodeBase:OnShow(uiParams)
  self._normal = UIActivityLineLevelNodeBaseWidget:New(self:GetUIComponent("UIView", "normal"))
  self._plot = UIActivityLineLevelNodeBaseWidget:New(self:GetUIComponent("UIView", "plot"))
  self._boss = UIActivityLineLevelNodeBaseWidget:New(self:GetUIComponent("UIView", "boss"))
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._normalGo = self:GetGameObject("normal")
  self._plotGo = self:GetGameObject("plot")
  self._bossGo = self:GetGameObject("boss")
  self:OnInit()
end

function UIActivityLineLevelNodeBase:SetData(lineCfg, passInfo, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._onClick = cb
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  local type = missionCfg.Type
  self._bossGo:SetActive(false)
  self._normalGo:SetActive(false)
  self._plotGo:SetActive(false)
  local stars = 0
  if passInfo then
    local module = self:GetModule(MissionModule)
    stars = module:ParseStarInfo(passInfo.star)
  end
  if type == DiscoveryStageType.FightNormal then
    self._normalGo:SetActive(true)
    self._normal:Refresh(StringTable.Get(missionCfg.Name), stars)
  elseif type == DiscoveryStageType.FightBoss then
    self._bossGo:SetActive(true)
    self._boss:Refresh(StringTable.Get(missionCfg.Name), stars)
  elseif type == DiscoveryStageType.Plot then
    self._plotGo:SetActive(true)
    self._plot:Refresh(StringTable.Get(missionCfg.Name), stars)
  end
  self:PlayAnimation()
end

function UIActivityLineLevelNodeBase:BtnOnClick(go)
  self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
end

function UIActivityLineLevelNodeBase:OnInit()
end

function UIActivityLineLevelNodeBase:PlayAnimation()
end
