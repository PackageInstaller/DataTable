_class("UIActivityN21CCShowCardController", UIController)
UIActivityN21CCShowCardController = UIActivityN21CCShowCardController

function UIActivityN21CCShowCardController:OnShow(uiParams)
  local groupData = uiParams[1]
  self._activityConst = uiParams[2]
  self._item = uiParams[3]
  self._count = uiParams[4]
  self._index = uiParams[5]
  local loader = self:GetUIComponent("UISelectObjectPath", "Loader")
  self._showItem = loader:SpawnObject("UIActivityN21CCItem")
  self._showItem:Refresh(groupData, true)
  self:OpenLevelGroup(groupData)
end

function UIActivityN21CCShowCardController:OpenLevelGroup(levelGroupData)
  self:StartTask(function(TT)
    self:Lock("UIActivityN21CCShowCardController_OpenLevelGroup")
    self._item:SetStatus(false)
    self._showItem:PlayEnterAnim(self._count, self._index)
    YIELD(TT, 1000)
    levelGroupData:ClearNewStatus()
    levelGroupData:ClearOnceRedStatus()
    self:ShowDialog("UIActivityN21CCLevelDetail", true, levelGroupData, self._activityConst)
    YIELD(TT, 200)
    self._item:SetStatus(true)
    self:CloseDialog()
    self:UnLock("UIActivityN21CCShowCardController_OpenLevelGroup")
  end)
end
