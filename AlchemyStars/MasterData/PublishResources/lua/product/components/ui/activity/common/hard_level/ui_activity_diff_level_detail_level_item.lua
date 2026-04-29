_class("UIActivityDiffLevelDetailLevelItem", UICustomWidget)
UIActivityDiffLevelDetailLevelItem = UIActivityDiffLevelDetailLevelItem

function UIActivityDiffLevelDetailLevelItem:OnShow(uiParam)
  self._atlas = self:GetAsset("UIDiffMission.spriteatlas", LoadType.SpriteAtlas)
  self:GetComponents()
end

function UIActivityDiffLevelDetailLevelItem:GetComponents()
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._finishGo = self:GetGameObject("finish")
  self._teamPool = self:GetUIComponent("UISelectObjectPath", "team")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._typeImg = self:GetUIComponent("Image", "type")
end

function UIActivityDiffLevelDetailLevelItem:SetData(data, cb)
  if data == nil then
    local pools = self._teamPool:GetAllSpawnList()
    for i = 1, #pools do
      local item = pools[i]
      item:SetData(0)
    end
    return
  end
  self._data = data
  self._cb = cb
  self._nameTex:SetText(self._data:GetName())
  self._finishGo:SetActive(self._data:IsComplete())
  self._rect.anchoredPosition = self._data:GetPosition()
  local sprite
  if self._data:GetLevelType() == DiffMissionType.Boss then
    sprite = self._atlas:GetSprite("map_black_icon15")
  else
    sprite = self._atlas:GetSprite("map_black_icon12")
  end
  self._typeImg.sprite = sprite
  local team = self._data:GetTeam()
  self._teamPool:SpawnObjects("UIActivityDiffLevelDetailTeamItem", 5)
  local pools = self._teamPool:GetAllSpawnList()
  if not self._data:IsComplete() then
    for i = 1, #pools do
      local item = pools[i]
      item:SetData(0)
    end
    return
  end
  for i = 1, #pools do
    local item = pools[i]
    local pstid = team[i]
    if pstid == nil then
      pstid = 0
    end
    item:SetData(pstid)
  end
end

function UIActivityDiffLevelDetailLevelItem:BgOnClick(go)
  if self._cb then
    self._cb(self._data)
  end
end
