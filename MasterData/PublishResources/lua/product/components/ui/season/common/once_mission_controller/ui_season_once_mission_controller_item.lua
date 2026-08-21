_class("UISeasonOnceMissionControllerItem", UICustomWidget)
UISeasonOnceMissionControllerItem = UISeasonOnceMissionControllerItem

function UISeasonOnceMissionControllerItem:OnShow(uiParams)
  self._atlas = self:RootUIOwner():GetAsset("UISeasonOnceMission.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UISeasonOnceMissionControllerItem:InitWidget()
  self.rootImg = self:GetUIComponent("Image", "Root")
  self.noneStarts = self:GetGameObject("NoneStarts")
  self.unFinish = self:GetGameObject("unFinish")
  self.finish = self:GetGameObject("finish")
  self.starsGo = self:GetGameObject("Stars")
  self.title = self:GetUIComponent("UILocalizationText", "Title")
  self.stars = self:GetUIComponent("Transform", "Stars")
  self._root = self:GetUIComponent("RectTransform", "Root")
  self._itemRect = self:GetUIComponent("RectTransform", "_anim")
  self._stars = {
    self:GetGameObject("Star1"),
    self:GetGameObject("Star2"),
    self:GetGameObject("Star3")
  }
  self._grayStars = {
    self:GetGameObject("StarGray1"),
    self:GetGameObject("StarGray2"),
    self:GetGameObject("StarGray3")
  }
  self._starLightImg = {
    self:GetUIComponent("Image", "Star1"),
    self:GetUIComponent("Image", "Star2"),
    self:GetUIComponent("Image", "Star3")
  }
  self._starGrayImg = {
    self:GetUIComponent("Image", "StarGray1"),
    self:GetUIComponent("Image", "StarGray2"),
    self:GetUIComponent("Image", "StarGray3")
  }
  self.finishImg = self:GetUIComponent("Image", "finishImg")
  self.finishEffImg = self:GetUIComponent("Image", "finishEffImg")
end

function UISeasonOnceMissionControllerItem:SetData(lineCfg, passInfo, uiStyle, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._callback = cb
  self._uiStyle = uiStyle
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self._itemRect.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
  self.title:SetText(StringTable.Get(missionCfg.Name))
  self._bHasThreeStar = false
  if missionCfg.ThreeStarCondition3 then
    self._bHasThreeStar = true
  end
  self.starsGo:SetActive(self._bHasThreeStar)
  self.noneStarts:SetActive(not self._bHasThreeStar)
  self.rootImg.sprite = self._atlas:GetSprite(self._uiStyle.pointBg)
  for k, lightStar in pairs(self._starLightImg) do
    lightStar.sprite = self._atlas:GetSprite(self._uiStyle.pointStarLight)
  end
  for k, grayStar in pairs(self._starGrayImg) do
    grayStar.sprite = self._atlas:GetSprite(self._uiStyle.pointStarGray)
  end
  self.finishImg.sprite = self._atlas:GetSprite(self._uiStyle.pointFinishBg)
  self.finishEffImg.sprite = self._atlas:GetSprite(self._uiStyle.pointFinishEffBg)
  local bFinsh = passInfo and passInfo.star
  if self._bHasThreeStar then
    local starCount = 0
    if bFinsh then
      starCount = GameGlobal.GetModule(MissionModule):ParseStarInfo(passInfo.star) or 0
    end
    for i = 1, 3 do
      local pass = i <= starCount
      self._stars[i]:SetActive(pass)
      self._grayStars[i]:SetActive(not pass)
    end
  else
    self.finish:SetActive(bFinsh)
    self.unFinish:SetActive(not bFinsh)
    if bFinsh then
      self:_PlayAnim("finish")
    end
  end
  if bFinsh then
    self:_PlayAnim(self._uiStyle.in_animation)
  else
    self:_PlayAnim(self._uiStyle.idle_animation)
  end
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
end

function UISeasonOnceMissionControllerItem:RootOnClick(go)
  self._callback(self._missionID, self._isStoryNode)
end

function UISeasonOnceMissionControllerItem:_PlayAnim(idx, callback)
  local tb = {
    brown_idle = {
      animName = "uieff_UISeasonOnceMissionControllerItem_brown_idle"
    },
    brown_in = {
      animName = "uieff_UISeasonOnceMissionControllerItem_brown_in"
    },
    red_idle = {
      animName = "uieff_UISeasonOnceMissionControllerItem_red_idle"
    },
    red_in = {
      animName = "uieff_UISeasonOnceMissionControllerItem_red_in"
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end
