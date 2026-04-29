_class("UISeasonMainLevelListItemS2", UICustomWidget)
UISeasonMainLevelListItemS2 = UISeasonMainLevelListItemS2

function UISeasonMainLevelListItemS2:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMainLevelListItemS2:InitWidget()
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
  self._atlas = self:GetAsset("UISeasonMain.spriteatlas", LoadType.SpriteAtlas)
  self._bg = self:GetUIComponent("Image", "Root")
end

function UISeasonMainLevelListItemS2:SetData(data, onClick)
  self._data = data
  self._onClick = onClick
  self._lockTip:SetActive(not self._data:IsUnlock())
end

function UISeasonMainLevelListItemS2:RefreshByDiff(curDiff)
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
  local items = self.item:SpawnObjects("UISeasonMainLevelListAssetS2", #awards)
  for i = 1, #awards do
    local item = items[i]
    local award = awards[i]
    local id = award.ItemID
    local count = award.Count
    item:SetData(id, count)
  end
  self.levelName:SetText(StringTable.Get(levelCfg.Name))
  local atlas = self:GetAsset("UIS2Scene.spriteatlas", LoadType.SpriteAtlas)
  if self._curDiff == UISeasonLevelDiff.Normal then
    self._bg.sprite = atlas:GetSprite("exp_s2_map_di07")
  elseif self._curDiff == UISeasonLevelDiff.Hard then
    self._bg.sprite = atlas:GetSprite("exp_s2_map_di08")
  end
end

function UISeasonMainLevelListItemS2:PrepareAnim()
  self._root:SetActive(false)
end

function UISeasonMainLevelListItemS2:PlayEnterAnim()
  self._root:SetActive(true)
  self._anim:Play("uieff_UISeasonMainLevelListItemS2_in")
end

function UISeasonMainLevelListItemS2:PlaySwitchAnim()
  self._root:SetActive(true)
end

function UISeasonMainLevelListItemS2:PlayOutAnim()
  self._anim:Play("uieff_UISeasonMainLevelListItemS2_out")
end

function UISeasonMainLevelListItemS2:RootOnClick(go)
  local seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  if seasonManager:LockUI() then
    return
  end
  self._onClick(self._data)
end
