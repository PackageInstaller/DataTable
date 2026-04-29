_class("UIReviewProgressAward", UICustomWidget)
UIReviewProgressAward = UIReviewProgressAward

function UIReviewProgressAward:SetData(idx, curIndex, progress, curProgress, hadReceive)
  self.root = self:GetUIComponent("RectTransform", "root")
  local parent = self.root.parent:GetComponent(typeof(UnityEngine.RectTransform))
  local width = parent.rect.width
  self.root.anchoredPosition = Vector2(width * progress / 100, 0)
  local state = 1
  if curIndex == -1 then
    state = 3
  elseif progress <= curProgress then
    if hadReceive then
      state = 3
    else
      state = 2
    end
  else
    state = 1
  end
  self:_SetState(state)
end

function UIReviewProgressAward:_SetState(state)
  local widgetNameGroup = {
    {
      "icon_cantCollected"
    },
    {
      "icon_canCollected"
    },
    {
      "icon_collected"
    }
  }
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetNameGroup)
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UIReviewProgressAward:PlayEnterAni(index)
  local delay = 400 + (index - 1) * 50
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", nil, "uieffanim_UIReviewProgressAward_in", delay)
end
