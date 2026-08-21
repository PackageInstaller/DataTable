_class("UISeasonStageMultiAwardListS7", UICustomWidget)
UISeasonStageMultiAwardListS7 = UISeasonStageMultiAwardListS7

function UISeasonStageMultiAwardListS7:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonStageMultiAwardListS7:InitWidget()
  self._seasonAwardGen = self:GetUIComponent("UISelectObjectPath", "Content")
  self._sr = self:GetUIComponent("ScrollRect", "ScrollView")
end

function UISeasonStageMultiAwardListS7:OnHide()
end

function UISeasonStageMultiAwardListS7:SetData(multiAwardList)
  self._multiAwardList = multiAwardList
  local count = #self._multiAwardList
  self._seasonAwardGen:SpawnObjects("UISeasonStageSingleAwardListS7", count)
  local list = self._seasonAwardGen:GetAllSpawnList()
  self._list = list
  for i, v in ipairs(list) do
    v:SetData(self._multiAwardList[i])
  end
  self:ResetScrollPos()
end

function UISeasonStageMultiAwardListS7:ResetScrollPos()
  self._sr.horizontalNormalizedPosition = 0
end

function UISeasonStageMultiAwardListS7:PlayAnim(totalAnimDelay)
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

function UISeasonStageMultiAwardListS7:SetWaitAnim()
  if self._list then
    for index, singleList in ipairs(self._list) do
      singleList:SetWaitAnim()
    end
  end
end
