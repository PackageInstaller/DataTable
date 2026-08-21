_class("UIN29DetectiveBreakLoad", UIController)
UIN29DetectiveBreakLoad = UIN29DetectiveBreakLoad

function UIN29DetectiveBreakLoad:Constructor()
  self._idStage = 0
  self._idReasoning = UIN29DetectiveLocalDb.Game_Continue
end

function UIN29DetectiveBreakLoad:LoadDataOnEnter(TT, res, uiParams)
  self._localDb = UIN29DetectiveLocalDb:New()
end

function UIN29DetectiveBreakLoad:OnShow(uiParams)
  self._archivePreview = self:GetUIComponent("UISelectObjectPath", "archivePreview")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._uiWidgetArchive = self._archivePreview:SpawnObject("UIN29DetectiveArchiveContent")
  self._localDb:GameLoadDB()
  self._idStage, self._idReasoning = self._localDb:BreakPosition()
  local componentInfo = self._localDb:DetectiveComponent():GetComponentInfo()
  self._uiWidgetArchive:SetDetectiveLocalDb(self._localDb)
  self._uiWidgetArchive:SetIdReasoning(self._idReasoning)
  self._uiWidgetArchive:FlushBreak(componentInfo.cur_info)
end

function UIN29DetectiveBreakLoad:OnHide()
end

function UIN29DetectiveBreakLoad:BtnCloseOnClick(go)
  self:CloseDialogAnimation()
end

function UIN29DetectiveBreakLoad:BtnNewGameOnClick(go)
  self:CloseDialogAnimation(function()
    self:CallUIMethod("UIN29DetectiveLogin", "OnStartPlayGame", UIN29DetectiveLocalDb.Game_New, 1)
  end)
end

function UIN29DetectiveBreakLoad:BtnContinueGameOnClick(go)
  self:CloseDialogAnimation(function()
    self:CallUIMethod("UIN29DetectiveLogin", "OnStartPlayGame", self._idReasoning, self._idStage)
  end)
end

function UIN29DetectiveBreakLoad:CloseDialogAnimation(cbFinish)
  self:StartTask(function(TT)
    self._animation:Play("uieff_UIN29DetectiveBreakLoad_out")
    YIELD(TT, 167)
    self:CloseDialog()
    if cbFinish then
      cbFinish()
    end
  end)
end
