_class("UIN29DetectiveBreakTips", UIController)
UIN29DetectiveBreakTips = UIN29DetectiveBreakTips

function UIN29DetectiveBreakTips:Constructor()
end

function UIN29DetectiveBreakTips:LoadDataOnEnter(TT, res, uiParams)
  self._localDb = uiParams[1]
  self._idStage = self._localDb:BreakIdStage()
  self._idReasoning = self._localDb:BreakIdReasoning()
end

function UIN29DetectiveBreakTips:OnShow(uiParams)
  self._archivePreview = self:GetUIComponent("UISelectObjectPath", "archivePreview")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._uiWidgetArchive = self._archivePreview:SpawnObject("UIN29DetectiveArchiveContent")
  local componentInfo = self._localDb:DetectiveComponent():GetComponentInfo()
  self._uiWidgetArchive:SetDetectiveLocalDb(self._localDb)
  self._uiWidgetArchive:SetIdReasoning(self._idReasoning)
  self._uiWidgetArchive:FlushBreak(componentInfo.cur_info)
end

function UIN29DetectiveBreakTips:OnHide()
end

function UIN29DetectiveBreakTips:BtnCloseOnClick(go)
  self:CloseDialogAnimation()
end

function UIN29DetectiveBreakTips:BtnLoadGameOnClick(go)
  local allStage = self._localDb:GetAllStage()
  for k, v in pairs(allStage) do
    self._idStage = k
  end
  self:CloseDialogAnimation(function()
    self:CallUIMethod("UIN29DetectiveLogin", "OnStartPlayGame", UIN29DetectiveLocalDb.Game_Archive, self._idStage)
  end)
end

function UIN29DetectiveBreakTips:BtnContinueGameOnClick(go)
  self:CloseDialogAnimation(function()
    self:CallUIMethod("UIN29DetectiveLogin", "OnStartPlayGame", self._idReasoning, self._idStage)
  end)
end

function UIN29DetectiveBreakTips:CloseDialogAnimation(cbFinish)
  self:StartTask(function(TT)
    self._animation:Play("uieff_UIN29DetectiveBreakTips_out")
    YIELD(TT, 167)
    self:CloseDialog()
    if cbFinish then
      cbFinish()
    end
  end)
end
