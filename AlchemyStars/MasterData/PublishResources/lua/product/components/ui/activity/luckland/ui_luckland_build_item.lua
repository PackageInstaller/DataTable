_class("UILuckLandBuildItem", UICustomWidget)
UILuckLandBuildItem = UILuckLandBuildItem

function UILuckLandBuildItem:OnShow(uiParams)
  self:InitWidget()
end

function UILuckLandBuildItem:InitWidget()
  self._guideShow = true
  self.buildIconRawImageLoader = self:GetUIComponent("RawImageLoader", "BuildIcon")
  self.buildLevelText = self:GetUIComponent("UILocalizationText", "BuildLevelText")
  self.canLevelUp = self:GetUIComponent("Image", "CanLevelUp")
  self.canLevelUp.gameObject:SetActive(false)
  self.topImg = self:GetGameObject("TopImg")
  self.resRoot = self:GetGameObject("ResRoot")
  self.resDataText = self:GetUIComponent("UILocalizationText", "ResDataText")
  self.resRoot:SetActive(false)
  self._buildIconGO = self:GetGameObject("BuildIcon")
end

function UILuckLandBuildItem:SetData(data, cb)
  self.data = data
  self.cb = cb
  self:RefreshBuildUI()
  if self.data == nil then
    self.topImg:SetActive(true)
  else
    self.topImg:SetActive(false)
  end
end

function UILuckLandBuildItem:RefreshBuildUI()
  if self.data == nil then
    return
  end
  self.buildIconRawImageLoader:LoadImage(self.data:Icon())
  self.buildLevelText:SetText("Lv<size=44>" .. self.data:GetCurLevel() .. "</size>")
  local MaxLevel = self.data:MaxLevel()
  if self.data:GetCurLevel() == MaxLevel then
    self.canLevelUp.gameObject:SetActive(false)
    return
  end
  local cost = self.data:UpgradeCost(self.data:ID())
  if cost and LuckLandInnerGameHelper.CanCostMoney(cost) then
    if self._guideShow then
      self.canLevelUp.gameObject:SetActive(true)
    end
  else
    self.canLevelUp.gameObject:SetActive(false)
  end
end

function UILuckLandBuildItem:ShowMoney()
  if self.data == nil then
    return false
  end
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  if entityMgr then
    local buildingEntity = entityMgr:GetBuildingByTemplateID(self.data:ID())
    if buildingEntity then
      local directGold = buildingEntity:GetDirectGold()
      local resGold = buildingEntity:CalculateRes()
      if directGold == nil then
        directGold = 0
      end
      if resGold == nil then
        resGold = 0
      end
      local finGold = resGold + directGold
      if 0 < finGold then
        self.resRoot:SetActive(true)
        self.resDataText:SetText("" .. finGold)
        self._fadeInTimer = GameGlobal.Timer():AddEvent(500, function()
          self._fadeInTimer = nil
          self.resRoot:SetActive(false)
        end)
        return true
      end
    end
  end
  return false
end

function UILuckLandBuildItem:BgOnClick(go)
  self:ShowDialog("UILuckLandBuildingLevelUp", self.data, function(levelup)
    if self.cb then
      local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
      if entityMgr then
        local buildingEntity = entityMgr:GetBuildingByTemplateID(self.data:ID())
        self.cb(levelup, buildingEntity:GetBuildingType())
      else
        self.cb(levelup)
      end
    end
  end)
end

function UILuckLandBuildItem:ShowBuild(show)
  self._guideShow = show
  if show then
    self.topImg:SetActive(self.data == nil)
    self._buildIconGO:SetActive(self.data ~= nil)
    self:RefreshBuildUI()
  else
    self.topImg:SetActive(true)
    self._buildIconGO:SetActive(false)
    self.canLevelUp.gameObject:SetActive(false)
  end
end

function UILuckLandBuildItem:OnClose()
  if self._fadeInTimer then
    GameGlobal.Timer():CancelEvent(self._fadeInTimer)
    self._fadeInTimer = nil
  end
end
