_class("UIN29DetectiveArchiveLoad", UIController)
UIN29DetectiveArchiveLoad = UIN29DetectiveArchiveLoad

function UIN29DetectiveArchiveLoad:Constructor()
  self._idStage = 0
  self._idReasoning = UIN29DetectiveLocalDb.Game_Continue
end

function UIN29DetectiveArchiveLoad:LoadDataOnEnter(TT, res, uiParams)
  self._localDb = UIN29DetectiveLocalDb:New()
end

function UIN29DetectiveArchiveLoad:OnShow(uiParams)
  self._archivePreview = self:GetUIComponent("UISelectObjectPath", "archivePreview")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._uiWidgetArchive = self._archivePreview:SpawnObject("UIN29DetectiveArchiveContent")
  self._localDb:GameLoadDB()
  self._idStage, self._idReasoning = self._localDb:BreakPosition()
  local componentInfo = self._localDb:DetectiveComponent():GetComponentInfo()
  self._uiWidgetArchive:SetDetectiveLocalDb(self._localDb)
  self._uiWidgetArchive:FlushArchive(componentInfo)
end

function UIN29DetectiveArchiveLoad:OnHide()
end

function UIN29DetectiveArchiveLoad:BtnCloseOnClick(go)
  self:CloseDialogAnimation(nil)
end

function UIN29DetectiveArchiveLoad:BtnLoadingOnClick(go)
  if self:CallUIMethod("UIN29DetectiveLogin", "ExistBreak") then
    self:CloseDialogAnimation(function()
      self:ShowDialog("UIN29DetectiveBreakTips", self._localDb)
    end)
  else
    self:CloseDialogAnimation(function()
      self:CallUIMethod("UIN29DetectiveLogin", "OnStartPlayGame", UIN29DetectiveLocalDb.Game_Archive, self._idStage)
    end)
  end
end

function UIN29DetectiveArchiveLoad:CloseDialogAnimation(cbFinish)
  self:StartTask(function(TT)
    self._animation:Play("uieff_UIN29DetectiveArchiveLoad_out")
    YIELD(TT, 167)
    self:CloseDialog()
    if cbFinish then
      cbFinish()
    end
  end)
end
