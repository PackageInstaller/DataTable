_class("UISeasonStageMultiAwardListS8", UICustomWidget)
UISeasonStageMultiAwardListS8 = UISeasonStageMultiAwardListS8

function UISeasonStageMultiAwardListS8:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonStageMultiAwardListS8:InitWidget()
  self._seasonAwardGen = self:GetUIComponent("UISelectObjectPath", "Content")
  self._sr = self:GetUIComponent("ScrollRect", "ScrollView")
end

function UISeasonStageMultiAwardListS8:OnHide()
end

function UISeasonStageMultiAwardListS8:SetData(multiAwardList)
  self._multiAwardList = multiAwardList
  local count = #self._multiAwardList
  self._seasonAwardGen:SpawnObjects("UISeasonStageSingleAwardListS8", count)
  local list = self._seasonAwardGen:GetAllSpawnList()
  self._list = list
  for i, v in ipairs(list) do
    v:SetData(self._multiAwardList[i])
  end
  self:ResetScrollPos()
end

function UISeasonStageMultiAwardListS8:ResetScrollPos()
  self._sr.horizontalNormalizedPosition = 0
end

function UISeasonStageMultiAwardListS8:PlayAnim(totalAnimDelay)
  if self._list then
    local singleListAnimDelay = 0
    if totalAnimDelay then
      singleListAnimDelay = singleListAnimDelay + totalAnimDelay
    end
    local eachItemDelay = 50
    for index, singleList in ipairs(self._list) do
      singleList:PlayAnim(singleListAnimDelay)
      local cellCount = #self._multiAwardList[index]
      singleListAnimDelay = singleListAnimDelay + cellCount * eachItemDelay
    end
  end
end

function UISeasonStageMultiAwardListS8:SetWaitAnim()
  if self._list then
    for index, singleList in ipairs(self._list) do
      singleList:SetWaitAnim()
    end
  end
end
