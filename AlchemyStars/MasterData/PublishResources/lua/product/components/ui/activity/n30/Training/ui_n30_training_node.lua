_class("UIN30TrainingNode", UICustomWidget)
UIN30TrainingNode = UIN30TrainingNode

function UIN30TrainingNode:OnShow(uiParams)
  self:InitWidget()
end

function UIN30TrainingNode:InitWidget()
  self.bg = self:GetUIComponent("Image", "bg")
  self.lock = self:GetUIComponent("Image", "lock")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.name2 = self:GetUIComponent("UILocalizationText", "name_boss")
  self.star = self:GetGameObject("star")
  self.star1 = self:GetUIComponent("Image", "Star1")
  self.star2 = self:GetUIComponent("Image", "Star2")
  self.star3 = self:GetUIComponent("Image", "Star3")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._stars = {
    self.star1,
    self.star2,
    self.star3
  }
  self._atlas = self:GetAsset("UIN30.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._bgGo = self:GetGameObject("bg")
  self._maskGo = self:GetGameObject("mask")
  self._pass = self:GetGameObject("pass")
end

function UIN30TrainingNode:GetNodeCfg()
  local NodeCfg = {SLeval = 111111, Passed = 888}
  NodeCfg[DiscoveryStageType.FightNormal] = {
    [1] = {
      normal = "n30_yhjf_di02",
      press = "",
      lock = "n30_yhjf_di04",
      textColor = Color(0.2549019607843137, 0.1568627450980392, 0.06666666666666667),
      textShadow = Color(0 / 255, 0 / 255, 0 / 255),
      normalStar = "",
      passStar = "n31_xxg_star01"
    },
    [2] = {
      normal = "",
      press = "",
      lock = "",
      textColor = Color(0.9450980392156862, 1.0, 0.4588235294117647),
      textShadow = Color(0.43529411764705883, 0.20392156862745098, 0.09803921568627451),
      normalStar = "",
      passStar = ""
    }
  }
  NodeCfg[DiscoveryStageType.FightBoss] = {
    [1] = {
      normal = "n30_yhjf_di03",
      press = "",
      lock = "n30_yhjf_di04",
      textColor = Color.New(0.8313725490196079, 0.5803921568627451, 0.3568627450980392),
      textShadow = Color.New(1.0, 1.0, 1.0),
      normalStar = "",
      passStar = ""
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
      normal = "n30_yhjf_di02",
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

function UIN30TrainingNode:SetAtlas(atlas)
  self._atlas = atlas
end

function UIN30TrainingNode:SetData(lineCfg, passInfo, cb, last, last2)
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
  self.name:SetText(StringTable.Get(missionCfg.Name))
  self.name2:SetText(StringTable.Get(missionCfg.Name))
  self.name.gameObject:SetActive(missionCfg.Type ~= DiscoveryStageType.FightBoss)
  self.name2.gameObject:SetActive(missionCfg.Type == DiscoveryStageType.FightBoss)
  local NodeCfg = self:GetNodeCfg()
  local hardParam = 1
  local typeCfg
  if lineCfg.WayPointType == 4 then
    typeCfg = NodeCfg[NodeCfg.SLeval]
  else
    typeCfg = NodeCfg[missionCfg.Type]
  end
  local bg, lock, textColor, shadowColor
  if passInfo then
    textColor = typeCfg[hardParam].textColor
    local module = self:GetModule(MissionModule)
    local stars = module:ParseStarInfo(passInfo.star)
    bg = typeCfg[hardParam].normal
    for i = 1, 3 do
      local pass = i <= stars
      local url = pass and typeCfg[hardParam].passStar or typeCfg[hardParam].normalStar
    end
    self._pass:SetActive(true)
  else
    textColor = typeCfg[hardParam].textColor
    bg = typeCfg[hardParam].normal
    lock = typeCfg[hardParam].lock
    local stars = 0
    for i = 1, 3 do
      local pass = i <= stars
      local url = pass and typeCfg[hardParam].passStar or typeCfg[hardParam].normalStar
    end
    self._pass:SetActive(false)
  end
  self:_SetRed(false)
  self.bg.sprite = self._atlas:GetSprite(bg)
  if lock then
    self.lock.sprite = self._atlas:GetSprite(lock)
  else
    self.lock.gameObject:SetActive(false)
  end
  if last2 then
    local cfg = Cfg.cfg_component_line_mission({
      CampaignMissionId = self._missionID
    })
    if cfg[1] and cfg[1].NeedMissionId then
      self.lock.gameObject:SetActive(true)
      local roleModule = GameGlobal.GetModule(RoleModule)
      local pstid = roleModule:GetPstId()
      local dbStr = "chess" .. cfg[1].NeedMissionId .. pstid
      local dbHas = LocalDB.GetInt(dbStr, 0)
      if dbHas and dbHas == 1 then
        dbHas = dbHas + 1
        LocalDB.SetInt(dbStr, dbHas)
        self:StartTask(function(TT)
          self._isonClick = true
        end)
      else
        self._isonClick = true
        self.lock.gameObject:SetActive(false)
      end
    end
  elseif last then
    self.lock.gameObject:SetActive(true)
  else
    self.lock.gameObject:SetActive(false)
    self._isonClick = true
  end
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  if 0 <= lineCfg.MapPosY then
    self._anim:Play("uieff_UIN30TrainingNode_up")
  else
    self._anim:Play("uieff_UIN30TrainingNode_down")
  end
end

function UIN30TrainingNode:_SetRed(isShow)
  local redObj = self:GetGameObject("red")
  redObj:SetActive(isShow)
end

function UIN30TrainingNode:BtnOnClick(go)
  if self._onClick and self._isonClick then
    self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
  else
    ToastManager.ShowToast(StringTable.Get("str_n30_train_locked_prev_popup"))
  end
end
