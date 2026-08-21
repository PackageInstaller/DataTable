_class("UIHomeLandTaskActivity", UICustomWidget)
UIHomeLandTaskActivity = UIHomeLandTaskActivity

function UIHomeLandTaskActivity:LoadDataOnEnter(TT, res, uiParams)
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
end

function UIHomeLandTaskActivity:OnShow()
  self:InitWidget()
  self:_AttachEvents()
end

function UIHomeLandTaskActivity:InitWidget()
  self._bg = self:GetUIComponent("Image", "bgImage")
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._contentText = self:GetUIComponent("UILocalizationText", "contentText")
end

function UIHomeLandTaskActivity:RefreshUI()
  local title, content = self.homelandClient:GetHomelandTaskManager():GetRuningTaskGroup():GetGroupInfo()
  self._titleText:SetText(StringTable.Get(title))
  self._contentText:SetText(StringTable.Get(content))
end

function UIHomeLandTaskActivity:OnHide()
  self:_DetachEvents()
end

function UIHomeLandTaskActivity:_AttachEvents()
  self:AttachEvent(GameEventType.OnHomeLandTaskFinished, self._OnHomeLandTaskFinished)
end

function UIHomeLandTaskActivity:_DetachEvents()
  self:DetachEvent(GameEventType.OnHomeLandTaskFinished, self._OnHomeLandTaskFinished)
end

function UIHomeLandTaskActivity:_OnHomeLandTaskFinished()
  self:RefreshUI()
end

function UIHomeLandTaskActivity:BtnOnClick()
end
