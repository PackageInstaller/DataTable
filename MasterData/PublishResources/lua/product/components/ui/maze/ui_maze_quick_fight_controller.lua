_class("UIMazeQuickFightController", UIController)
UIMazeQuickFightController = UIMazeQuickFightController

function UIMazeQuickFightController:Constructor()
end

function UIMazeQuickFightController:OnShow(uiParams)
  self._rewards = uiParams[1]
  self._light = uiParams[2]
  self._sort = uiParams[3] or false
  self:GetComponents()
  self:OnValue()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N8MazeSweep)
end

function UIMazeQuickFightController:GetComponents()
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._itemInfo = itemInfo:SpawnObject("UISelectInfo")
  self._AwardPool = self:GetUIComponent("UISelectObjectPath", "AwardPool")
  self._cost = self:GetUIComponent("UILocalizationText", "cost")
end

function UIMazeQuickFightController:OnValue()
  self._cost:SetText(self._light)
  local count = #self._rewards
  local itemModule = self:GetModule(ItemModule)
  local rewards
  if self._sort then
    rewards = self._rewards
  else
    rewards = itemModule:SortRoleAsset(self._rewards)
  end
  local items = self._AwardPool:SpawnObjects("UIMazeQuickFightItem", count)
  for i = 1, #items do
    local item = items[i]
    local award = Award:New()
    award:InitWithCount(rewards[i].assetid, rewards[i].count)
    item:SetData(award, function(id, pos)
      self:ItemClick(id, pos)
    end)
  end
end

function UIMazeQuickFightController:ButtonOnClick(go)
  self:CloseDialog()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnQuickFightClose)
end

function UIMazeQuickFightController:ItemClick(id, pos)
  self._itemInfo:SetData(id, pos)
end

function UIMazeQuickFightController:OnHide()
end
