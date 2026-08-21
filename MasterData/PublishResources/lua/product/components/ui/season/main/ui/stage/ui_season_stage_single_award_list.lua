_class("UISeasonStageSingleAwardList", UICustomWidget)
UISeasonStageSingleAwardList = UISeasonStageSingleAwardList

function UISeasonStageSingleAwardList:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonStageSingleAwardList:InitWidget()
  self._bgResMap = {}
  self._bgResMap[UISeasonLevelDiff.Normal] = "exp_s1_map_di24"
  self._bgResMap[UISeasonLevelDiff.Hard] = "exp_s1_map_di35"
  self._awardsGen = self:GetUIComponent("UISelectObjectPath", "Awards")
  self._bgImg = self:GetUIComponent("Image", "BgImg")
  self._atlas = self:GetAsset("UIS1Main.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonStageSingleAwardList:OnHide()
end

function UISeasonStageSingleAwardList:SetData(awardList)
  self._awardList = awardList
  local levelDiff = self._awardList.levelDiff
  if levelDiff then
    local bgName = self._bgResMap[levelDiff]
    if bgName then
      self._bgImg.sprite = self._atlas:GetSprite(bgName)
    end
  end
  local count = #self._awardList
  self._awardsGen:SpawnObjects("UISeasonStageAwardItem", count)
  local list = self._awardsGen:GetAllSpawnList()
  self._list = list
  for i, v in ipairs(list) do
    v:Flush(self._awardList[i], levelDiff)
  end
end

function UISeasonStageSingleAwardList:SetWaitAnim()
  if self._list then
    for index, awardCell in ipairs(self._list) do
      awardCell:SetWaitAnim()
    end
  end
end

function UISeasonStageSingleAwardList:PlayAnim(totalAnimDelay)
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
