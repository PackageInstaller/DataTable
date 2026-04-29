_class("UIN4CCTaskController", UIController)
UIN4CCTaskController = UIN4CCTaskController

function UIN4CCTaskController:_PlayAnim(type, callback)
  local tb = {
    ["in"] = {
      animName = "uianim_UIN4CCTaskController_in",
      duration = 500
    },
    out = {
      animName = "uianim_UIN4CCTaskController_out",
      duration = 500
    }
  }
  local info = tb[type]
  if info then
    UIWidgetHelper.PlayAnimation(self, "_anim", tb[type].animName, tb[type].duration, callback)
  elseif callback then
    callback()
  end
end

function UIN4CCTaskController:_PlayAnim_Cells(type, callback)
  for i, v in ipairs(self._cells) do
    if type == "in" then
      v:PlayAnimationInSequence(i)
    elseif type == "out" then
      v:PlayAnimOut(callback)
    end
  end
end

function UIN4CCTaskController:LoadDataOnEnter(TT, res, uiParams)
  local context = uiParams and uiParams[1]
  if context == nil then
    res:SetSucc(false)
    return
  end
  self._questIds = uiParams and uiParams[2] or {}
  self._campaign = context._campaign
  self._component = context._taskComponent
end

function UIN4CCTaskController:OnShow(uiParams)
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self._closeCb = uiParams[3]
  self:_PlayAnim("in")
  self:_Refresh()
  self:_PlayAnim_Cells("in")
  self:_AttachEvents()
end

function UIN4CCTaskController:OnHide()
  self:_DetachEvents()
end

function UIN4CCTaskController:_Refresh()
  self:_SetCellList()
end

function UIN4CCTaskController:_SetCellListData()
  local tb = {}
  for _, v in ipairs(self._questIds) do
    local quest = self._component:GetQuestInfoById(v)
    table.insert(tb, quest)
  end
  self._cellDatas = tb
  self._questStatus = self._component:GetCampaignQuestStatus(self._cellDatas)
end

function UIN4CCTaskController:_SetCellList()
  self:_SetCellListData()
  local objs = UIWidgetHelper.SpawnObjects(self, "Content", "UIN4CCTaskCell", #self._cellDatas)
  for i, v in ipairs(objs) do
    local quest = self._cellDatas[i]
    local state = self._questStatus[quest]
    v:SetData(i, self._component, quest, state, function(questInfo)
      self:_ClaimOneBtn(questInfo)
    end, self._tipsCallback)
  end
  self._cells = objs
end

function UIN4CCTaskController:_ClaimOneBtn(questInfo)
  self._claimItems = {
    questInfo.quest_id
  }
  self._component:Start_HandleQuestTake(questInfo.quest_id, function(res, rewards)
    self:_OnRecvRewards(res, rewards)
  end)
end

function UIN4CCTaskController:_OnRecvRewards(res, rewards)
  if not self.view then
    return
  end
  if res and res:GetSucc() then
    UISeasonHelper.ShowUIGetRewards(rewards)
  else
    self._campaign:CheckErrorCode(res.m_result, self._seasonId, function()
      self:_Refresh()
    end, function()
      self:CloseDialog()
    end)
  end
end

function UIN4CCTaskController:CloseBtnOnClick(go)
  self:_PlayAnim_Cells("out")
  self:_PlayAnim("out", function()
    if self._closeCb then
      self._closeCb()
    end
    self:CloseDialog()
  end)
end

function UIN4CCTaskController:_AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self._Refresh)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN4CCTaskController:_DetachEvents()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self._Refresh)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN4CCTaskController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:CloseDialog()
  end
end
