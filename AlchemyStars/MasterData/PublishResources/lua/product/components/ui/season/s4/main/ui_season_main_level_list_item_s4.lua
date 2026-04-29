_class("UISeasonMainLevelListItemS4", UICustomWidget)
UISeasonMainLevelListItemS4 = UISeasonMainLevelListItemS4

function UISeasonMainLevelListItemS4:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMainLevelListItemS4:InitWidget()
  self.levelName = self:GetUIComponent("UILocalizationText", "levelName")
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
end

function UISeasonMainLevelListItemS4:SetData(data, onClick)
  self._data = data
  self._onClick = onClick
  self._lockTip:SetActive(not self._data:IsUnlock())
end

function UISeasonMainLevelListItemS4:RefreshByDiff(curDiff)
  self._curDiff = curDiff
  local levelCfg = self._data:GetMissionCfgByDiff(self._curDiff)
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
  local items = self.item:SpawnObjects("UISeasonMainLevelListAssetS4", #awards)
  for i = 1, #awards do
    local item = items[i]
    local award = awards[i]
    local id = award.ItemID
    local count = award.Count
    item:SetData(id, count)
  end
  self.levelName:SetText(StringTable.Get(levelCfg.Name))
  local atlas = self:GetAsset("UIS4Scene.spriteatlas", LoadType.SpriteAtlas)
  if self._curDiff == UISeasonLevelDiff.Normal then
    self._bg.sprite = atlas:GetSprite("exp_s4_map_gq_di02")
    self._lockImage.sprite = atlas:GetSprite("exp_s4_map_gq_mask01")
  elseif self._curDiff == UISeasonLevelDiff.Hard then
    self._bg.sprite = atlas:GetSprite("exp_s4_map_gq_di03")
    self._lockImage.sprite = atlas:GetSprite("exp_s4_map_gq_mask02")
  end
end

function UISeasonMainLevelListItemS4:PrepareAnim()
  self._root:SetActive(false)
end

function UISeasonMainLevelListItemS4:PlayEnterAnim()
  self._root:SetActive(true)
  self._anim:Play("uieff_UISeasonMainLevelListItemS3_in")
end

function UISeasonMainLevelListItemS4:PlaySwitchAnim()
  self._root:SetActive(true)
end

function UISeasonMainLevelListItemS4:PlayOutAnim()
  self._anim:Play("uieff_UISeasonMainLevelListItemS2_out")
end

function UISeasonMainLevelListItemS4:RootOnClick(go)
  local seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  if seasonManager:LockUI() then
    return
  end
  self._onClick(self._data)
end
