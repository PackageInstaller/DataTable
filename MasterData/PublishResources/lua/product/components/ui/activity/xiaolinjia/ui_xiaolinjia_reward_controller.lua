_class("UIXiaoLinJiaRewardController", UIController)
UIXiaoLinJiaRewardController = UIXiaoLinJiaRewardController

function UIXiaoLinJiaRewardController:OnShow(uiParams)
  self._campaign = uiParams[1]
  self._missionList = uiParams[2]
  self.anim = self:GetUIComponent("Animation", "anim")
  self._cmptId = ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST
  self._component = self._campaign:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST)
  self._componentInfo = self._component:GetComponentInfo()
  
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:Refresh()
end

function UIXiaoLinJiaRewardController:OnHide()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIXiaoLinJiaRewardController:Refresh()
  self:_SetDynamicList()
end

function UIXiaoLinJiaRewardController:_SetDynamicListData()
  local questInfo = self._component:GetQuestInfo()
  self._dynamicListInfo = {}
  for index, mission in pairs(self._missionList) do
    if not mission:GetIsLock() then
      local svrCfg = mission:GetServerCfg()
      for _, taskId in pairs(svrCfg.TaskList) do
        table.insert(self._dynamicListInfo, self:GetTaskItem(questInfo, taskId))
      end
    end
  end
  self._questStatus = self._component:GetCampaignQuestStatus(self._dynamicListInfo)
  self._component:SortQuestInfoByCampaignQuestStatus(self._dynamicListInfo)
end

function UIXiaoLinJiaRewardController:GetTaskItem(questInfo, taskId)
  for _, v in pairs(questInfo) do
    if v._questInfo.quest_id == taskId then
      return v
    end
  end
  return nil
end

function UIXiaoLinJiaRewardController:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "dynamicList"), "UIXiaoLinJiaRewardItem", function(listItem, itemIndex)
      self:_SetCellData(listItem, itemIndex)
    end)
  end
  local itemCount = #self._dynamicListInfo
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
end

function UIXiaoLinJiaRewardController:_SetCellData(listItem, index)
  local quest = self._dynamicListInfo[index]
  local status = self._questStatus[quest]
  if quest ~= nil then
    listItem:SetData(index, self._campaign, quest, status, self._componentInfo, function(questInfo)
      self._component:Start_HandleQuestTake(questInfo.quest_id, function(res, rewards)
        self:_OnGetRewards(res, rewards)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnXiaoLinJiaMainPanelRefresh, true)
      end)
    end, self._tipsCallback)
  end
end

function UIXiaoLinJiaRewardController:HandleOneKeyTakeQuest()
  self._component:Start_HandleOneKeyTakeQuest(function(res, rewards)
    self:_OnGetRewards(res, rewards)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnXiaoLinJiaMainPanelRefresh, true)
  end)
end

function UIXiaoLinJiaRewardController:_DynamicListPlayAnimation()
end

function UIXiaoLinJiaRewardController:CloseBtnOnClick()
  self:Lock("UIXiaoLinJiaRewardController_Close")
  self.anim:Play("uieffanim_UIXiaoLinJiaIntroController_out")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:CloseDialog()
    self:UnLock("UIXiaoLinJiaRewardController_Close")
  end)
end

function UIXiaoLinJiaRewardController:OneClickGetRewardBtnOnClick()
  self:HandleOneKeyTakeQuest()
end

function UIXiaoLinJiaRewardController:_OnGetRewards(res, rewards)
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:Refresh()
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
end

function UIXiaoLinJiaRewardController:OnUIGetItemCloseInQuest(type)
  self:Refresh()
end
