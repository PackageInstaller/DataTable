_class("UISeasonMainOvalTipS3", Object)
UISeasonMainOvalTipS3 = UISeasonMainOvalTipS3

function UISeasonMainOvalTipS3:Constructor(seasonID, req, onClick)
  self._seasonID = seasonID
  self._req = req
  self._onClick = onClick
  self._gameObject = req.Obj
  self._rectTransform = self._gameObject:GetComponent(typeof(UnityEngine.RectTransform))
  self._uiView = self._gameObject:GetComponent(typeof(UIView))
  self._uiView:SetShow(true, self)
  self._icon = self._uiView:GetGameObject("Icon")
  self._iconImg = self._uiView:GetUIComponent("Image", "Icon")
  self._arrowObj = self._uiView:GetGameObject("Arrow")
  self._arrowRect = self._uiView:GetUIComponent("RectTransform", "Arrow")
  self._arrowIcon = self._uiView:GetUIComponent("Image", "ArrowIcon")
  self._name2Asset = {}
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  if self._uiSeasonModule:IsBackTrack() then
    self._atlas = UIResourceManager.GetAsset("UISeasonMain.spriteatlas", LoadType.SpriteAtlas, self._name2Asset)
  else
    self._atlas = UIResourceManager.GetAsset("UIS3Scene.spriteatlas", LoadType.SpriteAtlas, self._name2Asset)
  end
end

function UISeasonMainOvalTipS3:TargetWorldPos()
  if self._type == UISeasonOvalTipType.Player then
    local target = self._target
    return target:Position()
  elseif self._type == UISeasonOvalTipType.Mission then
    local target = self._target
    return target:Position()
  elseif self._type == UISeasonOvalTipType.Daily then
    local target = self._target
    return target:Position()
  elseif self._type == UISeasonOvalTipType.Box then
    local target = self._target
    return target:Position()
  elseif self._type == UISeasonOvalTipType.Task then
    local target = self._target
    return target:Position()
  end
end

function UISeasonMainOvalTipS3:Show()
  self._isIn = false
  local show = true
  if self._target and self._type == UISeasonOvalTipType.Task then
    show = self._target:IsShow()
  end
  self._gameObject:SetActive(show)
end

function UISeasonMainOvalTipS3:Hide()
  self._isIn = true
  self._gameObject:SetActive(false)
end

function UISeasonMainOvalTipS3:Delete()
  self._req = nil
  self._gameObject = nil
  self._uiView:SetShow(false, self)
  self._uiView = nil
  for _, req in pairs(self._name2Asset) do
    req:Dispose()
  end
end

function UISeasonMainOvalTipS3:GetReq()
  return self._req
end

function UISeasonMainOvalTipS3:Dispose()
  self._req:Dispose()
  self:Delete()
end

function UISeasonMainOvalTipS3:IsInOval()
  return self._isIn
end

function UISeasonMainOvalTipS3:Sync(pos, rot)
  self._rectTransform.anchoredPosition = pos
  self._arrowRect.localRotation = rot
end

function UISeasonMainOvalTipS3:Type()
  return self._type
end

function UISeasonMainOvalTipS3:Target()
  return self._target
end

function UISeasonMainOvalTipS3:IconOnClick()
  self._onClick(self)
end

function UISeasonMainOvalTipS3:ArrowIconOnClick()
  self._onClick(self)
end

function UISeasonMainOvalTipS3:ResetTarget(target, type)
  self._uiView:SetShow(false, self)
  self._uiView:SetShow(true, self)
  self._type = type
  local cameraCfg = Cfg.cfg_season_camera[self._seasonID]
  if self._type == UISeasonOvalTipType.Player then
    self._target = target
    self._icon:SetActive(true)
    local min = cameraCfg.PlayerTipHideRange[1]
    local max = cameraCfg.PlayerTipHideRange[2]
    local maxSize = cameraCfg.CameraSizeMin
    local minSize = cameraCfg.CameraSizeMax
    self._tipHideParam = (max - min) / (maxSize - minSize)
    self._tipHideMinDistance = min
    self._cameraMinSize = minSize
  elseif self._type == UISeasonOvalTipType.Mission then
    self._target = target
    self._icon:SetActive(false)
    local cfg = Cfg.cfg_season_map_eventpoint[self._target:GetID()]
    if cfg.OvalTipHideRange then
      local min = cfg.OvalTipHideRange[1]
      local max = cfg.OvalTipHideRange[2]
      local maxSize = cameraCfg.CameraSizeMin
      local minSize = cameraCfg.CameraSizeMax
      self._tipHideParam = (max - min) / (maxSize - minSize)
      self._tipHideMinDistance = min
      self._cameraMinSize = minSize
    end
  elseif self._type == UISeasonOvalTipType.Daily then
    self._target = target
    self._icon:SetActive(false)
    local cfg = Cfg.cfg_season_map_eventpoint[self._target:GetID()]
    if cfg.OvalTipHideRange then
      local min = cfg.OvalTipHideRange[1]
      local max = cfg.OvalTipHideRange[2]
      local maxSize = cameraCfg.CameraSizeMin
      local minSize = cameraCfg.CameraSizeMax
      self._tipHideParam = (max - min) / (maxSize - minSize)
      self._tipHideMinDistance = min
      self._cameraMinSize = minSize
    end
  elseif self._type == UISeasonOvalTipType.Box then
    self._target = target
    self._icon:SetActive(false)
    local cfg = Cfg.cfg_season_map_eventpoint[self._target:GetID()]
    if cfg.OvalTipHideRange then
      local min = cfg.OvalTipHideRange[1]
      local max = cfg.OvalTipHideRange[2]
      local maxSize = cameraCfg.CameraSizeMin
      local minSize = cameraCfg.CameraSizeMax
      self._tipHideParam = (max - min) / (maxSize - minSize)
      self._tipHideMinDistance = min
      self._cameraMinSize = minSize
    end
  elseif self._type == UISeasonOvalTipType.Task then
    self._target = target
    self._icon:SetActive(false)
    local cfg = Cfg.cfg_season_map_eventpoint[self._target:GetID()]
    if cfg.OvalTipHideRange then
      local min = cfg.OvalTipHideRange[1]
      local max = cfg.OvalTipHideRange[2]
      local maxSize = cameraCfg.CameraSizeMin
      local minSize = cameraCfg.CameraSizeMax
      self._tipHideParam = (max - min) / (maxSize - minSize)
      self._tipHideMinDistance = min
      self._cameraMinSize = minSize
    end
  end
  if self._uiSeasonModule:IsBackTrack() then
    self:_RefreshIconBackTrack()
  else
    self:_RefreshIcon()
  end
  self:Hide()
end

function UISeasonMainOvalTipS3:GetCanShowDistance(cameraSize)
  if self._tipHideMinDistance then
    return self._tipHideMinDistance + (cameraSize - self._cameraMinSize) * self._tipHideParam
  end
  return 0
end

function UISeasonMainOvalTipS3:_RefreshIcon()
  if self._type == UISeasonOvalTipType.Player then
    self._arrowIcon.sprite = self._atlas:GetSprite("exp_S3_map_arrowhead_yellow")
    local player = self._uiSeasonModule:SeasonManager():SeasonPlayerManager():GetPlayer()
    self._iconImg.sprite = self._atlas:GetSprite(player:CurModule():Cfg().PlayIconOval)
  elseif self._type == UISeasonOvalTipType.Mission then
    self._arrowIcon.sprite = self._atlas:GetSprite("exp_S3_map_arrowhead_red")
  elseif self._type == UISeasonOvalTipType.Daily then
    self._arrowIcon.sprite = self._atlas:GetSprite("exp_S3_map_arrowhead_blue")
  elseif self._type == UISeasonOvalTipType.Box then
    self._arrowIcon.sprite = self._atlas:GetSprite("exp_S3_map_arrowhead_blue")
  elseif self._type == UISeasonOvalTipType.Task then
    self._arrowIcon.sprite = self._atlas:GetSprite("exp_S3_map_arrowhead_blue")
  end
end

function UISeasonMainOvalTipS3:_RefreshIconBackTrack()
  if self._type == UISeasonOvalTipType.Player then
    self._arrowIcon.sprite = self._atlas:GetSprite("exp_s1_map_icon05")
    local seasonID = self._uiSeasonModule:GetSeasonID()
    if seasonID == UISeasonID.S1 then
      self._iconImg.sprite = self._atlas:GetSprite("exp_s1_map_head02")
    elseif seasonID == UISeasonID.S2 then
      local atlas = UIResourceManager.GetAsset("UIS2Main.spriteatlas", LoadType.SpriteAtlas, self._name2Asset)
      local mode = GameGlobal.GetModule(SeasonModule):UIModule():SeasonManager():SeasonMapManager():Mode()
      if mode == SeasonMapMode.Mode1 then
        self._iconImg.sprite = atlas:GetSprite("exp_s2_map_head02")
      elseif mode == SeasonMapMode.Mode2 then
        self._iconImg.sprite = atlas:GetSprite("exp_s2_map_head04")
      end
    end
  elseif self._type == UISeasonOvalTipType.Mission then
    self._arrowIcon.sprite = self._atlas:GetSprite("exp_s1_map_icon04")
  elseif self._type == UISeasonOvalTipType.Daily then
    self._arrowIcon.sprite = self._atlas:GetSprite("exp_s1_map_icon31")
  elseif self._type == UISeasonOvalTipType.Box then
    self._arrowIcon.sprite = self._atlas:GetSprite("exp_s1_map_icon06")
  elseif self._type == UISeasonOvalTipType.Task then
    self._arrowIcon.sprite = self._atlas:GetSprite("exp_s1_map_icon33")
  end
end
