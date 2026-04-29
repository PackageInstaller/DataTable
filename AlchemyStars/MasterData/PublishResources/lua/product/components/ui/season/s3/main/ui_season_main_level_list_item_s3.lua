_class("UISeasonMainLevelListItemS3", UICustomWidget)
UISeasonMainLevelListItemS3 = UISeasonMainLevelListItemS3

function UISeasonMainLevelListItemS3:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMainLevelListItemS3:InitWidget()
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

function UISeasonMainLevelListItemS3:SetData(data, onClick)
  self._data = data
  self._onClick = onClick
  self._lockTip:SetActive(not self._data:IsUnlock())
end

function UISeasonMainLevelListItemS3:RefreshByDiff(curDiff)
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
  local items = self.item:SpawnObjects("UISeasonMainLevelListAssetS3", #awards)
  for i = 1, #awards do
    local item = items[i]
    local award = awards[i]
    local id = award.ItemID
    local count = award.Count
    item:SetData(id, count)
  end
  self.levelName:SetText(StringTable.Get(levelCfg.Name))
  local atlas = self:GetAsset("UIS3Scene.spriteatlas", LoadType.SpriteAtlas)
  if self._curDiff == UISeasonLevelDiff.Normal then
    self._bg.sprite = atlas:GetSprite("exp_s3_map_gq_di03")
    self._lockImage.sprite = atlas:GetSprite("exp_s3_map_gq_mask01")
  elseif self._curDiff == UISeasonLevelDiff.Hard then
    self._bg.sprite = atlas:GetSprite("exp_s3_map_gq_di04")
    self._lockImage.sprite = atlas:GetSprite("exp_s3_map_gq_mask02")
  end
end

function UISeasonMainLevelListItemS3:PrepareAnim()
  self._root:SetActive(false)
end

function UISeasonMainLevelListItemS3:PlayEnterAnim()
  self._root:SetActive(true)
  self._anim:Play("uieff_UISeasonMainLevelListItemS3_in")
end

function UISeasonMainLevelListItemS3:PlaySwitchAnim()
  self._root:SetActive(true)
end

function UISeasonMainLevelListItemS3:PlayOutAnim()
  self._anim:Play("uieff_UISeasonMainLevelListItemS2_out")
end

function UISeasonMainLevelListItemS3:RootOnClick(go)
  local seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  if seasonManager:LockUI() then
    return
  end
  self._onClick(self._data)
end
