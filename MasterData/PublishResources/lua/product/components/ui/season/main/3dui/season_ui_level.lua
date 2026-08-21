_class("SeasonUILevel", Object)
SeasonUILevel = SeasonUILevel

function SeasonUILevel:Constructor(gameObject, atlas, levelCfg)
  self._gameObject = gameObject
  self._atlas = atlas
  self._levelCfg = levelCfg
  self._view = self._gameObject:GetComponent(typeof(UIView))
  self:_GetComponents()
end

function SeasonUILevel:_GetComponents()
  self._rootTransform = self._view:GetUIComponent("Transform", "Root")
  self._name = self._view:GetUIComponent("UILocalizationText", "Name")
  self._starGO = self._view:GetGameObject("Star")
  self._star = {}
  self._star[1] = self._view:GetUIComponent("Image", "1")
  self._star[2] = self._view:GetUIComponent("Image", "2")
  self._star[3] = self._view:GetUIComponent("Image", "3")
end

function SeasonUILevel:SetData(eventPoint, componentInfo)
  if eventPoint then
    self._eventPoint = eventPoint
    local cfg = self._eventPoint:GetMissionCfg()
    local showStar = false
    local starMask = 0
    local passInfo = componentInfo.m_pass_mission_info[cfg.ID]
    if passInfo then
      if cfg.ThreeStarCondition3 and 0 < cfg.ThreeStarCondition3 then
        showStar = true
        starMask = passInfo.star
      end
    elseif self._eventPoint:Diff() == UISeasonLevelDiff.Hard then
      local normalCfg = Cfg.cfg_season_mission({
        GroupID = self._eventPoint:GroupID(),
        OrderID = UISeasonLevelDiff.Normal
      })
      if normalCfg then
        passInfo = componentInfo.m_pass_mission_info[normalCfg[1].ID]
        if passInfo then
          showStar = true
          starMask = 0
        end
      end
    end
    self._name:SetText(StringTable.Get(cfg.Name))
    self._starGO:SetActive(showStar)
    if showStar then
      local starCount = (starMask & 1) + (starMask >> 1 & 1) + (starMask >> 2 & 1)
      for i = 1, #self._star do
        local spriteName = self._levelCfg.spriteGray
        if i <= starCount then
          spriteName = self._levelCfg.sprite
        end
        self._star[i].sprite = self._atlas:GetSprite(spriteName)
      end
    end
    local cfg = self._eventPoint:GetEventPointCfg()
    if cfg and cfg.UILevelOffset then
      self._rootTransform.localPosition = Vector3(cfg.UILevelOffset[1], cfg.UILevelOffset[2], cfg.UILevelOffset[3])
    end
    self:RefreshPosition()
  else
    self._gameObject:SetActive(false)
  end
end

function SeasonUILevel:RefreshPosition()
  if self._eventPoint then
    local show = self._eventPoint:IsShow()
    self._gameObject:SetActive(show)
    self._gameObject.transform.position = self._eventPoint:Position()
  end
end
