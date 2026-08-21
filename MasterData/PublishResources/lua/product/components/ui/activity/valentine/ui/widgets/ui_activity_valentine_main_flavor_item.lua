_class("UIActivityValentineMainFlavorItem", UICustomWidget)
UIActivityValentineMainFlavorItem = UIActivityValentineMainFlavorItem

function UIActivityValentineMainFlavorItem:Constructor()
end

function UIActivityValentineMainFlavorItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIActivityValentineMainFlavorItem:_GetComponents()
  self._hookImg = self:GetUIComponent("Image", "hookImg")
  self._foodName = self:GetUIComponent("UILocalizationText", "foodName")
  self._hookImgObj = self:GetGameObject("hookImg")
end

function UIActivityValentineMainFlavorItem:SetData(cfg, isDone)
  self._cfg = cfg
  self:InitData(isDone)
end

function UIActivityValentineMainFlavorItem:InitData(isDone)
  local questModule = GameGlobal.GetModule(QuestModule)
  local taskId = self._cfg.TaskID
  local task = questModule:GetQuest(taskId)
  self._foodName:SetText(StringTable.Get(self._cfg.Info))
  if isDone or task and task:Status() >= QuestStatus.QUEST_Completed then
    self._hookImgObj:SetActive(true)
  else
    self._hookImgObj:SetActive(false)
  end
end
