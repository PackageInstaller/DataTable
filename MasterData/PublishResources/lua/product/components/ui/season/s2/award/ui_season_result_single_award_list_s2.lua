_class("UISeasonResultSingleAwardListS2", UICustomWidget)
UISeasonResultSingleAwardListS2 = UISeasonResultSingleAwardListS2

function UISeasonResultSingleAwardListS2:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonResultSingleAwardListS2:InitWidget()
  self._bgResMap = {}
  self._bgResMap[UISeasonLevelDiff.Normal] = "exp_s1_map_di24"
  self._bgResMap[UISeasonLevelDiff.Hard] = "exp_s1_map_di35"
  self._awardsGen = self:GetUIComponent("UISelectObjectPath", "Awards")
  self._bgImg = self:GetUIComponent("Image", "BgImg")
  self._atlas = self:GetAsset("UIS1Main.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonResultSingleAwardListS2:OnHide()
end

function UISeasonResultSingleAwardListS2:SetData(awardsTb)
  self._taskIDList = {}
  self._awardsTb = awardsTb
  local levelDiff = self._awardsTb.levelDiff
  if levelDiff then
  end
  local count = self._awardsTb.cellCount
  self._awardsGen:SpawnObjects("UIWidgetSeasonResultRewardS2", count)
  local items = self._awardsGen:GetAllSpawnList()
  local itemIndex = 1
  if awardsTb.starRewards then
    local starRewards = awardsTb.starRewards
    for i = 1, #starRewards do
      local roleAsset = starRewards[i]
      local taskID = items[itemIndex]:Init(roleAsset.count, roleAsset.assetid, true)
      items[itemIndex]:SetLevelDiff(levelDiff)
      table.insert(self._taskIDList, taskID)
      itemIndex = itemIndex + 1
    end
  end
  if awardsTb.extStarRewards then
    local extStarRewards = awardsTb.extStarRewards
    for i = 1, #extStarRewards do
      local roleAsset = extStarRewards[i]
      local taskID = items[itemIndex]:Init(roleAsset.count, roleAsset.assetid, true)
      items[itemIndex]:SetLevelDiff(levelDiff)
      table.insert(self._taskIDList, taskID)
      itemIndex = itemIndex + 1
    end
  end
  if awardsTb.firstPassRawrds then
    local firstPassRawrds = awardsTb.firstPassRawrds
    for i = 1, #firstPassRawrds do
      local roleAsset = firstPassRawrds[i]
      local taskID = items[itemIndex]:Init(roleAsset.count, roleAsset.assetid, false, false, true)
      items[itemIndex]:SetLevelDiff(levelDiff)
      table.insert(self._taskIDList, taskID)
      itemIndex = itemIndex + 1
    end
  end
  if awardsTb.extFirstPassRewards then
    local extFirstPassRewards = awardsTb.extFirstPassRewards
    for i = 1, #extFirstPassRewards do
      local roleAsset = extFirstPassRewards[i]
      local taskID = items[itemIndex]:Init(roleAsset.count, roleAsset.assetid, false, false, true)
      items[itemIndex]:SetLevelDiff(levelDiff)
      table.insert(self._taskIDList, taskID)
      itemIndex = itemIndex + 1
    end
  end
  if awardsTb.normalRewards then
    local normalRewards = awardsTb.normalRewards
    for i = 1, #normalRewards do
      local roleAsset = normalRewards[i]
      if roleAsset.assetid ~= RoleAssetID.RoleAssetExp then
        items[itemIndex]:Init(roleAsset.count, roleAsset.assetid, false)
        items[itemIndex]:SetLevelDiff(levelDiff)
        itemIndex = itemIndex + 1
      end
    end
  end
end
