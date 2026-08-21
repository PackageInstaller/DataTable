_class("UISeasonMainLevelListItemS6", UICustomWidget)
UISeasonMainLevelListItemS6 = UISeasonMainLevelListItemS6

function UISeasonMainLevelListItemS6:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMainLevelListItemS6:InitWidget()
  self.title_has_produce = self:GetUIComponent("UILocalizationText", "title_has_produce")
  self.title_story = self:GetUIComponent("UILocalizationText", "title_story")
  self.title_no_produce = self:GetUIComponent("UILocalizationText", "title_no_produce")
  self.star = self:GetGameObject("star")
  self._stars = {
    self:GetGameObject("star1"),
    self:GetGameObject("star2"),
    self:GetGameObject("star3")
  }
  self.item = self:GetUIComponent("UISelectObjectPath", "item")
  self._lockTip = self:GetGameObject("LockTip")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._root = self:GetGameObject("Root")
  self._bg = self:GetUIComponent("Image", "Root")
  self._lockImage = self:GetUIComponent("Image", "LockTip")
  self._storyGo = self:GetGameObject("story")
  self._fight_produceGo = self:GetGameObject("fight_produce")
  self._fight_no_produce = self:GetGameObject("fight_no_produce")
  self._finishTipGo = self:GetGameObject("finishTip")
end

function UISeasonMainLevelListItemS6:SetData(data, onClick)
  self._data = data
  self._onClick = onClick
  self._lockTip:SetActive(not self._data:IsUnlock())
end

function UISeasonMainLevelListItemS6:RefreshByDiff(curDiff)
  self._curDiff = curDiff
  local levelCfg = self._data:GetMissionCfgByDiff(self._curDiff)
  local isStoryLevel = levelCfg.Type == SeasonEventPointType.MainStory
  local isHasProduceLevel = false
  if not isStoryLevel then
    isHasProduceLevel = levelCfg.ThreeStarCondition3 and levelCfg.ThreeStarCondition3 > 0
  end
  self._storyGo:SetActive(isStoryLevel)
  self._fight_produceGo:SetActive(not isStoryLevel and isHasProduceLevel)
  self._fight_no_produce:SetActive(not isStoryLevel and not isHasProduceLevel)
  self._finishTipGo:SetActive(false)
  if isHasProduceLevel then
    local star = self._data:GetStarByDiff(self._curDiff)
    for i = 1, 3 do
      self._stars[i]:SetActive(i <= star)
    end
    local awards = self._data:GetAwardsByDiff(self._curDiff)
    local tmp = {}
    for i = 1, #awards do
      tmp[#awards - i + 1] = awards[i]
    end
    awards = tmp
    local items = self.item:SpawnObjects("UISeasonMainLevelListAssetS6", #awards)
    for i = 1, #awards do
      local item = items[i]
      local award = awards[i]
      local id = award.ItemID
      local count = award.Count
      item:SetData(id, count)
    end
  else
    local isPass = self._data:IsPassDiff(self._curDiff)
    self._finishTipGo:SetActive(isPass)
  end
  local txtName = StringTable.Get(levelCfg.Name)
  self.title_has_produce:SetText(txtName)
  self.title_story:SetText(txtName)
  self.title_no_produce:SetText(txtName)
  local atlas = self:GetAsset("UIS6Scene.spriteatlas", LoadType.SpriteAtlas)
  if isStoryLevel then
    self._bg.sprite = atlas:GetSprite("exp_s6_map_gqlb_di01")
  else
    self._bg.sprite = atlas:GetSprite("exp_s6_map_gqlb_di02")
  end
end

function UISeasonMainLevelListItemS6:PrepareAnim()
  self._root:SetActive(false)
end

function UISeasonMainLevelListItemS6:PlayEnterAnim()
  self._root:SetActive(true)
  self._anim:Play("uieff_UISeasonMainLevelListItemS3_in")
end

function UISeasonMainLevelListItemS6:PlaySwitchAnim()
  self._root:SetActive(true)
end

function UISeasonMainLevelListItemS6:PlayOutAnim()
  self._anim:Play("uieff_UISeasonMainLevelListItemS2_out")
end

function UISeasonMainLevelListItemS6:RootOnClick(go)
  local seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  if seasonManager:LockUI() then
    return
  end
  self._onClick(self._data)
end
