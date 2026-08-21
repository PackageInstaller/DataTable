_class("UISeasonStageMultiAwardList", UICustomWidget)
UISeasonStageMultiAwardList = UISeasonStageMultiAwardList

function UISeasonStageMultiAwardList:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonStageMultiAwardList:InitWidget()
  self._seasonAwardGen = self:GetUIComponent("UISelectObjectPath", "Content")
  self._sr = self:GetUIComponent("ScrollRect", "ScrollView")
end

function UISeasonStageMultiAwardList:OnHide()
end

function UISeasonStageMultiAwardList:SetData(multiAwardList)
  self._multiAwardList = multiAwardList
  local count = #self._multiAwardList
  self._seasonAwardGen:SpawnObjects("UISeasonStageSingleAwardList", count)
  local list = self._seasonAwardGen:GetAllSpawnList()
  self._list = list
  for i, v in ipairs(list) do
    v:SetData(self._multiAwardList[i])
  end
  self:ResetScrollPos()
end

function UISeasonStageMultiAwardList:ResetScrollPos()
  self._sr.horizontalNormalizedPosition = 0
end

function UISeasonStageMultiAwardList:PlayAnim(totalAnimDelay)
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

function UISeasonStageMultiAwardList:SetWaitAnim()
  if self._list then
    for index, singleList in ipairs(self._list) do
      singleList:SetWaitAnim()
    end
  end
end
