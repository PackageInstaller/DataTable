_class("UIWeekTowerAwardsController", UIController)
UIWeekTowerAwardsController = UIWeekTowerAwardsController

function UIWeekTowerAwardsController:OnShow(uiParams)
  self._questCmpt = uiParams[1]
  self._questsUIPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._itemTipsPool = self:GetUIComponent("UISelectObjectPath", "assetTips")
  self:RefreshUI(true)
end

function UIWeekTowerAwardsController:RefreshUI(playEnterAnim)
  local questList = self._questCmpt:GetQuestInfo()
  table.sort(questList, function(a, b)
    local aStatus = a:Status()
    local bStatus = b:Status()
    if aStatus ~= bStatus then
      if aStatus == QuestStatus.QUEST_Taken then
        return false
      elseif bStatus == QuestStatus.QUEST_Taken then
        return true
      end
    end
    return a:ID() < b:ID()
  end)
  local questUIList = self._questsUIPool:SpawnObjects("UIWeekTowerAwardsItem", #questList)
  for i = 1, #questUIList do
    questUIList[i]:SetData(self._questCmpt, questList[i], playEnterAnim, i)
  end
end

function UIWeekTowerAwardsController:CloseBtnOnClick()
  self:CloseDialog()
end

function UIWeekTowerAwardsController:BGOnClick()
  self:CloseDialog()
end

function UIWeekTowerAwardsController:ShowAssetTips(id, pos)
  if not self._assetTips then
    self._assetTips = self._itemTipsPool:SpawnObject("UISelectInfo")
  end
  self._assetTips:SetData(id, pos)
end
