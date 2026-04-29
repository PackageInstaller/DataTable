_class("UISeasonStageSingleAwardListS3", UICustomWidget)
UISeasonStageSingleAwardListS3 = UISeasonStageSingleAwardListS3

function UISeasonStageSingleAwardListS3:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonStageSingleAwardListS3:InitWidget()
  self._awardsGen = self:GetUIComponent("UISelectObjectPath", "Awards")
  self._bgImg = self:GetUIComponent("Image", "BgImg")
  self._atlas = self:GetAsset("UIS1Main.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonStageSingleAwardListS3:OnHide()
end

function UISeasonStageSingleAwardListS3:SetData(awardList)
  self._awardList = awardList
  local levelDiff = self._awardList.levelDiff
  if levelDiff then
  end
  local count = #self._awardList
  self._awardsGen:SpawnObjects("UISeasonStageAwardItemS3", count)
  local list = self._awardsGen:GetAllSpawnList()
  self._list = list
  for i, v in ipairs(list) do
    v:Flush(self._awardList[i], levelDiff)
  end
end

function UISeasonStageSingleAwardListS3:SetWaitAnim()
  if self._list then
    for index, awardCell in ipairs(self._list) do
      awardCell:SetWaitAnim()
    end
  end
end

function UISeasonStageSingleAwardListS3:PlayAnim(totalAnimDelay)
  if self._list then
    local curCellDelay = 50
    if totalAnimDelay then
      curCellDelay = curCellDelay + totalAnimDelay
    end
    local eachItemDelay = 50
    for index, awardCell in ipairs(self._list) do
      awardCell:PlayAnim(curCellDelay)
      curCellDelay = curCellDelay + eachItemDelay
    end
  end
end
