_class("UIQuestSeasonItem", UICustomWidget)
UIQuestSeasonItem = UIQuestSeasonItem

function UIQuestSeasonItem:OnShow(uiParams)
  self._transition = self:GetUIComponent("ATransitionComponent", "UIQuestSeasonItem")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "UIQuestSeasonItem")
  self._canvasGroup.blocksRaycasts = false
  self._rect = self:GetUIComponent("UISelectObjectPath", "rect")
end

function UIQuestSeasonItem:RefrenshList()
end

function UIQuestSeasonItem:AnimatedListIntro()
end

function UIQuestSeasonItem:OnClose()
  self._transition:PlayLeaveAnimation(true)
  self._canvasGroup.blocksRaycasts = false
  if self._seasonQuest then
    self._seasonQuest:SetResponseEvent(false)
  end
end

function UIQuestSeasonItem:SetData()
  self._transition:PlayEnterAnimation(true)
  self._canvasGroup.blocksRaycasts = true
  self:_GetComponents()
  if not self._seasonQuest then
    local className, prefabName = UISeasonHelper.GetCurSeasonQuestContent()
    if not string.isnullorempty(className) then
      self._seasonQuest = UIWidgetHelper.SpawnObject(self, "rect", className, prefabName)
    end
  end
  if self._seasonQuest then
    local params = {}
    params.ownerName = "UIQuestSeasonItem"
    
    function params.closeCallback()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.SeasonQuestCloseCB)
    end
    
    self._seasonQuest:SetData(params)
    self._seasonQuest:SetResponseEvent(true)
  end
end

function UIQuestSeasonItem:OnHide()
end

function UIQuestSeasonItem:_GetComponents()
end
