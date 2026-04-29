_class("UISeasonStoryReviewS3", UIController)
UISeasonStoryReviewS3 = UISeasonStoryReviewS3

function UISeasonStoryReviewS3:OnShow(uiParams)
  self._talkIDList = uiParams[1]
  self:_GetComponents()
  self:_InitComponent()
end

function UISeasonStoryReviewS3:_GetComponents()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._rect = self:GetUIComponent("RectTransform", "Content")
  self._scroll = self:GetUIComponent("ScrollRect", "Scroll View")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UISeasonStoryReviewS3:_InitComponent()
  self._reviewItems = self._content:SpawnObjects("UISeasonStoryReviewItemS3", #self._talkIDList)
  for i, reviewItem in pairs(self._reviewItems) do
    reviewItem:SetData(self._talkIDList[i])
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._rect)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._rect)
  self._scroll.normalizedPosition = Vector2(0, 0)
end

function UISeasonStoryReviewS3:FullBtnOnClick()
  self:StartTask(function(TT)
    self:Lock("uianim_UISeasonStoryReviewController_out")
    self._anim:Play("uianim_UISeasonStoryReviewController_out")
    YIELD(TT, 334)
    self:UnLock("uianim_UISeasonStoryReviewController_out")
    self:CloseDialog()
  end)
end
