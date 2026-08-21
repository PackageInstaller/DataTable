_class("UIN29DetectiveReasoningPopController", UIController)
UIN29DetectiveReasoningPopController = UIN29DetectiveReasoningPopController

function UIN29DetectiveReasoningPopController:LoadDataOnEnter(TT, res, uiParams)
end

function UIN29DetectiveReasoningPopController:OnShow(uiParams, TT)
  self._StageId = uiParams[1]
  self:_GetComponent()
  self:PlayEnterAnim(TT)
  self:ShowNext()
end

function UIN29DetectiveReasoningPopController:OnHide()
end

function UIN29DetectiveReasoningPopController:_GetComponent()
end

function UIN29DetectiveReasoningPopController:PlayEnterAnim(TT)
  self:Lock("UIN29DetectiveReasoningPopController")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28AVGShowEvidence)
  YIELD(TT, 6200)
  self:UnLock("UIN29DetectiveReasoningPopController")
end

function UIN29DetectiveReasoningPopController:ShowNext()
  self:ShowDialog("UIN29DetectiveReasoning", self._StageId)
end
