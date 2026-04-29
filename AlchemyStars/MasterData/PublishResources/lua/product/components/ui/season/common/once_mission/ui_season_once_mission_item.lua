_class("UISeasonOnceMissionItem", UICustomWidget)
UISeasonOnceMissionItem = UISeasonOnceMissionItem

function UISeasonOnceMissionItem:OnShow(uiParams)
  self._atlas = self:RootUIOwner():GetAsset("UISeasonOnceMission.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UISeasonOnceMissionItem:InitWidget()
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
    self.stars:GetChild(0).gameObject,
    self.stars:GetChild(1).gameObject,
    self.stars:GetChild(2).gameObject
  }
end

function UISeasonOnceMissionItem:SetData(lineCfg, passInfo, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._callback = cb
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
  if self._bHasThreeStar then
    self.rootImg.sprite = self._atlas:GetSprite("cn12_zdg_di01")
    local starCount = 0
    if passInfo and passInfo.star then
      starCount = GameGlobal.GetModule(MissionModule):ParseStarInfo(passInfo.star) or 0
    end
    for i = 1, 3 do
      local pass = i <= starCount
      self._stars[i]:SetActive(pass)
    end
  else
    self.rootImg.sprite = self._atlas:GetSprite("cn12_zdg_di02")
    local bFinsh = passInfo and passInfo.star
    self.finish:SetActive(bFinsh)
    self.unFinish:SetActive(not bFinsh)
    if bFinsh then
      self:_PlayAnim("finish")
    end
  end
  UIWidgetHelper.PlayAnimation(self, "unFinish", "uieff_UISeasonOnceMissionItem_eye")
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
end

function UISeasonOnceMissionItem:RootOnClick(go)
  self._callback(self._missionID, self._isStoryNode)
end

function UISeasonOnceMissionItem:_PlayAnim(idx, callback)
  local tb = {
    ["in"] = {
      animName = "uieff_UISeasonOnceMissionItem_in"
    },
    up = {
      animName = "uieff_UISeasonOnceMissionItem_up"
    },
    down = {
      animName = "uieff_UISeasonOnceMissionItem_down"
    },
    finish = {
      animName = "uieff_UISeasonOnceMissionItem_finish"
    }
  }
  if tb[idx] ~= nil then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
  elseif callback ~= nil then
    callback()
  end
end
