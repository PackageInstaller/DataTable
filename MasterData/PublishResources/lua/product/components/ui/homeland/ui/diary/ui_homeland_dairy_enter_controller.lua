_class("UIHomeLandDiaryEnterController", UIController)
UIHomeLandDiaryEnterController = UIHomeLandDiaryEnterController
local DiaryOpenType = {Diary = 1, Story = 2}
_enum("DiaryOpenType", DiaryOpenType)

function UIHomeLandDiaryEnterController:Constructor(TT, res, uiParams)
end

function UIHomeLandDiaryEnterController:OnShow()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
  self:AttachEvent(GameEventType.StoryTaskTraceSuccess, self.StoryTaskTraceSuccess)
  self._dairyEnterData = UIHomelandDairyEnterData:New()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
end

function UIHomeLandDiaryEnterController:OnHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
  self:DetachEvent(GameEventType.StoryTaskTraceSuccess, self.StoryTaskTraceSuccess)
end

function UIHomeLandDiaryEnterController:Flush()
  local itemCount = 2
  self._content:SpawnObjects("UIHomeLandDiaryEnterItem", itemCount)
  local data = {}
  local uiItems = self._content:GetAllSpawnList()
  for i, uiItem in ipairs(uiItems) do
    uiItem:Flush(i, data, self._dairyEnterData, self.EnterCallBack)
  end
end

function UIHomeLandDiaryEnterController:EnterCallBack(type)
  if type == DiaryOpenType.Diary then
    self:ShowDialog("UIHomeLandDiaryController")
  elseif type == DiaryOpenType.Story then
    self:ShowDialog("UIHomelandStoryTaskController")
  end
end

function UIHomeLandDiaryEnterController:ClosebtnOnClick()
  self:CloseDialog()
end

function UIHomeLandDiaryEnterController:AfterUILayerChanged()
  self:Flush()
end

function UIHomeLandDiaryEnterController:HasPrefs(key)
  self._dairyEnterData.HasPrefs(key)
end

function UIHomeLandDiaryEnterController:SetPrefs(key)
  self._dairyEnterData.SetPrefs(key)
end

function UIHomeLandDiaryEnterController:StoryTaskTraceSuccess()
  self:CloseDialog()
end
