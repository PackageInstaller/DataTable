_class("UIN32MultiLineMapNormalNode", UICustomWidget)
UIN32MultiLineMapNormalNode = UIN32MultiLineMapNormalNode

function UIN32MultiLineMapNormalNode:OnShow(uiParams)
  self:InitWidget()
end

function UIN32MultiLineMapNormalNode:InitWidget()
  self.bg = self:GetUIComponent("Image", "bg")
  self.name = self:GetUIComponent("UILocalizedTMP", "name")
  self.name2 = self:GetUIComponent("UILocalizationText", "name_boss")
  self.star = self:GetGameObject("star")
  self.bg_normal_plotGo = self:GetGameObject("bg_normal_plot")
  self.bg_bossGo = self:GetGameObject("bg_boss")
  self.star1 = self:GetUIComponent("Image", "Star1")
  self.star2 = self:GetUIComponent("Image", "Star2")
  self.star3 = self:GetUIComponent("Image", "Star3")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._stars = {
    self.star1,
    self.star2,
    self.star3
  }
  self._atlas = self:GetAsset("UIN32Multiline.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._bgGo = self:GetGameObject("bg")
end

function UIN32MultiLineMapNormalNode:GetNodeCfg()
  local NodeCfg = {SLeval = 111111, Passed = 888}
  NodeCfg[DiscoveryStageType.FightNormal] = {
    [1] = {
      normal = "n32_dzm_dt_di02",
      press = "",
      lock = "",
      textColor = Color(0.2549019607843137, 0.1568627450980392, 0.06666666666666667),
      textShadow = Color(0 / 255, 0 / 255, 0 / 255),
      normalStar = "n32_dzm_dt_di07",
      passStar = "n32_dzm_dt_di06"
    },
    [2] = {
      normal = "",
      press = "",
      lock = "",
      textColor = Color(0.9450980392156862, 1.0, 0.4588235294117647),
      textShadow = Color(0.43529411764705883, 0.20392156862745098, 0.09803921568627451),
      normalStar = "n32_dzm_dt_di07",
      passStar = "n32_dzm_dt_di06"
    }
  }
  NodeCfg[DiscoveryStageType.FightBoss] = {
    [1] = {
      normal = "n32_dzm_dt_di03",
      press = "",
      lock = "",
      textColor = Color.New(0.8313725490196079, 0.5803921568627451, 0.3568627450980392),
      textShadow = Color.New(1.0, 1.0, 1.0),
      normalStar = "n32_dzm_dt_di07",
      passStar = "n32_dzm_dt_di06"
    },
    [2] = {
      normal = "",
      press = "",
      lock = "",
      textColor = Color.New(1.0, 1.0, 1.0),
      textShadow = Color.New(0.9333333333333333, 0 / 255, 0.13333333333333333),
      normalStar = "",
      passStar = ""
    }
  }
  NodeCfg[DiscoveryStageType.Plot] = {
    [1] = {
      normal = "n32_dzm_dt_di04",
      press = "",
      lock = "",
      textColor = Color.New(0.2549019607843137, 0.1568627450980392, 0.06666666666666667),
      textShadow = Color.New(0 / 255, 0 / 255, 0 / 255)
    },
    [2] = {
      normal = "",
      press = "",
      lock = "",
      textColor = Color.New(0.9450980392156862, 1.0, 0.4588235294117647),
      textShadow = Color.New(0.43529411764705883, 0.20392156862745098, 0.09803921568627451)
    }
  }
  NodeCfg[NodeCfg.SLeval] = {
    [1] = {
      normal = "",
      press = "",
      lock = "",
      textColor = Color.New(1.0, 1.0, 1.0),
      textShadow = Color.New(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
      normalStar = "",
      passStar = ""
    },
    [2] = {
      normal = "",
      press = "",
      lock = "",
      textColor = Color.New(1.0, 1.0, 1.0),
      textShadow = Color.New(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
      normalStar = "",
      passStar = ""
    }
  }
  return NodeCfg
end

function UIN32MultiLineMapNormalNode:SetData(levelId, multilineData, cb)
  self._levelId = levelId
  local lineCfg = Cfg.cfg_component_multiline_mission[levelId]
  local passInfo = multilineData:GetPassMissionInfo(lineCfg.MissionID)
  self._missionID = lineCfg.MissionID
  self._onClick = cb
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self.name:SetText(StringTable.Get(missionCfg.Name))
  self.name2:SetText(StringTable.Get(missionCfg.Name))
  self.name.gameObject:SetActive(missionCfg.Type ~= DiscoveryStageType.FightBoss)
  self.name2.gameObject:SetActive(missionCfg.Type == DiscoveryStageType.FightBoss)
  self.bg_normal_plotGo:SetActive(missionCfg.Type ~= DiscoveryStageType.FightBoss)
  self.bg_bossGo:SetActive(missionCfg.Type == DiscoveryStageType.FightBoss)
  local NodeCfg = self:GetNodeCfg()
  local hardParam = 1
  local typeCfg
  if lineCfg.WayPointType == 4 then
    typeCfg = NodeCfg[NodeCfg.SLeval]
  else
    typeCfg = NodeCfg[missionCfg.Type]
  end
  local bg, textColor, shadowColor
  if passInfo then
    textColor = typeCfg[hardParam].textColor
    local module = self:GetModule(MissionModule)
    local stars = module:ParseStarInfo(passInfo.star)
    bg = typeCfg[hardParam].normal
    for i = 1, 3 do
      local pass = i <= stars
      local url = pass and typeCfg[hardParam].passStar or typeCfg[hardParam].normalStar
      self._stars[i].sprite = self._atlas:GetSprite(url)
      self._stars[i].gameObject:SetActive(not string.isnullorempty(url))
    end
    self.star:SetActive(missionCfg.Type ~= DiscoveryStageType.Plot)
  else
    textColor = typeCfg[hardParam].textColor
    bg = typeCfg[hardParam].normal
    local stars = 0
    for i = 1, 3 do
      local pass = i <= stars
      local url = pass and typeCfg[hardParam].passStar or typeCfg[hardParam].normalStar
      self._stars[i].sprite = self._atlas:GetSprite(url)
      self._stars[i].gameObject:SetActive(not string.isnullorempty(url))
    end
    self.star:SetActive(missionCfg.Type ~= DiscoveryStageType.Plot)
  end
  self:_SetRed(false)
  self.bg.sprite = self._atlas:GetSprite(bg)
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
end

function UIN32MultiLineMapNormalNode:_SetRed(isShow)
  local redObj = self:GetGameObject("red")
  redObj:SetActive(isShow)
end

function UIN32MultiLineMapNormalNode:BtnOnClick(go)
  self:StartTask(function(TT)
    local lockName = "UIN32MultiLineMapNormalNode_click_ani"
    self:Lock(lockName)
    self._anim:Play("uieff_UIN32MultiLineMapNormalNode_click")
    YIELD(TT, 367)
    self:UnLock(lockName)
    self._onClick(self._levelId, self._missionID, self._isStoryNode, self._rectTransform.position)
  end)
end

function UIN32MultiLineMapNormalNode:SetVisible(bVisible)
  self:GetGameObject():SetActive(bVisible)
end

function UIN32MultiLineMapNormalNode:GetPosition()
  return self:GetGameObject().transform.position
end

function UIN32MultiLineMapNormalNode:PlayEnterAni()
  self._anim:Play("uieff_UIN32MultiLineMapNormalNode_in")
end

function UIN32MultiLineMapNormalNode:GetMissionID()
  return self._missionID
end
