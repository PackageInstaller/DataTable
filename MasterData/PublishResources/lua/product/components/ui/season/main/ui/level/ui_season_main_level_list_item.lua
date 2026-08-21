_class("UISeasonMainLevelListItem", UICustomWidget)
UISeasonMainLevelListItem = UISeasonMainLevelListItem

function UISeasonMainLevelListItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMainLevelListItem:InitWidget()
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
  self._icon = self:GetUIComponent("Image", "Icon")
end

function UISeasonMainLevelListItem:SetData(data, onClick)
  self._data = data
  self._onClick = onClick
  self._lockTip:SetActive(not self._data:IsUnlock())
end

function UISeasonMainLevelListItem:RefreshByDiff(curDiff)
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
  local items = self.item:SpawnObjects("UISeasonMainLevelListAsset", #awards)
  for i = 1, #awards do
    local item = items[i]
    local award = awards[i]
    local id = award.ItemID
    local count = award.Count
    item:SetData(id, count)
  end
  self.levelName:SetText(StringTable.Get(levelCfg.Name))
  if self._curDiff == UISeasonLevelDiff.Normal then
    self.levelName.color = Color(0.807843137254902, 0.6196078431372549, 0.2549019607843137)
    self._icon.sprite = self._atlas:GetSprite("exp_s1_map_icon13")
  elseif self._curDiff == UISeasonLevelDiff.Hard then
    self.levelName.color = Color(0.796078431372549, 0.3137254901960784, 0.2235294117647059)
    self._icon.sprite = self._atlas:GetSprite("exp_s1_map_icon14")
  end
end

function UISeasonMainLevelListItem:PrepareAnim()
  self._root:SetActive(false)
end

function UISeasonMainLevelListItem:PlayEnterAnim()
  self._root:SetActive(true)
  self._anim:Play("uianim_UISeasonMainLevelListItem_in")
end

function UISeasonMainLevelListItem:PlaySwitchAnim()
  self._root:SetActive(true)
  self._anim:Play("uianim_UISeasonMainLevelListItem_switch_in")
end

function UISeasonMainLevelListItem:RootOnClick(go)
  local seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  if seasonManager:LockUI() then
    return
  end
  self._onClick(self._data)
end
