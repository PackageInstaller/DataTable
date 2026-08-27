local UIFmtChallengeInfo = class("UIFmtChallengeInfo", UIBaseWindow)
local base = UIBaseWindow
local UINStgClgInfoTaskItem = require("Game.StageChallenge.UI.ChallengeInfo.UINStgClgInfoTaskItem")
local UIHeroUtil = require("Game.CommonUI.Hero.UIHeroUtil")

function UIFmtChallengeInfo:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Confirn, self, self._OnClickConfirm)
  self.fixedTaskItem = UINStgClgInfoTaskItem.New()
  self.fixedTaskItem:Init(self.ui.challengeTaskDefaultItem)
  self.optTaskItemPool = UIItemPool.New(UINStgClgInfoTaskItem, self.ui.challengeTaskItem, false)
  self._ChangeTaskOpenFunc = BindCallback(self, self._ChangeTaskOpen)
end

function UIFmtChallengeInfo:InitFmtChallengeInfo(stgChallengeData, confirmFunc)
  self.stgChallengeData = stgChallengeData
  self.confirmFunc = confirmFunc
  self.optTaskOpenDic = stgChallengeData:GetStgClgOptionalTaskOpenDic(true)
  self:_UpdPowerLimit()
  self:_UpdChallengeTask()
  local tipStr = stgChallengeData:GetClgCustomLeftTip()
  if not IsNull(tipStr) then
    self:SetCustomLeftTip(tipStr)
  end
end

function UIFmtChallengeInfo:SetCustomLeftTip(str)
  if str == nil then
    return
  end
  self.ui.tex_Intro.text = str
end

function UIFmtChallengeInfo:_UpdPowerLimit()
  local sctPowerLimitCfg = self.stgChallengeData:GetStgChallengePowerLimitCfg()
  if sctPowerLimitCfg == nil then
    return
  end
  local rank = sctPowerLimitCfg.rank_range[2]
  UIHeroUtil.UpdHeroStar(self.ui.img_Star, self.ui.img_StarHalf, rank)
  local lvLimit = sctPowerLimitCfg.level_range[2]
  self.ui.defaultConditionTexList[1]:SetIndex(0, tostring(lvLimit))
  local potentialLimit = sctPowerLimitCfg.potential_range[2]
  self.ui.defaultConditionTexList[2]:SetIndex(0, tostring(potentialLimit))
  local skillLvLimit = sctPowerLimitCfg.skill_level_range[2]
  self.ui.defaultConditionTexList[3]:SetIndex(0, tostring(skillLvLimit))
  local athShield = sctPowerLimitCfg.shield_module_dic[proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm]
  self.ui.defaultConditionTexList[4]:SetIndex(athShield and 2 or 1)
  local friendshipShield = sctPowerLimitCfg.shield_module_dic[proto_csmsg_SystemFunctionID.SystemFunctionID_friendship]
  self.ui.defaultConditionTexList[5]:SetIndex(friendshipShield and 2 or 1)
  local sctBuilding1Shield = sctPowerLimitCfg.shield_module_dic[proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1]
  self.ui.defaultConditionTexList[6]:SetIndex(sctBuilding1Shield and 2 or 1)
end

function UIFmtChallengeInfo:_UpdChallengeTask()
  local taskIdList = self.stgChallengeData:GetStgChallengeTaskList()
  local taskNum = #taskIdList
  if taskNum <= 0 then
    return
  end
  local taskId = taskIdList[1]
  local taskCfg = ConfigData.task[taskId]
  local isComplete = self.stgChallengeData:IsStgChallengeTaskComplete(taskId)
  self.fixedTaskItem:InitStgClgInfoTaskItem(taskCfg, isComplete, true)
  self.optTaskItemPool:HideAll()
  for i = 2, taskNum do
    taskId = taskIdList[i]
    taskCfg = ConfigData.task[taskId]
    isComplete = self.stgChallengeData:IsStgChallengeTaskComplete(taskId)
    local isOpen = self.optTaskOpenDic[taskId]
    local taskItem = self.optTaskItemPool:GetOne()
    taskItem:InitStgClgInfoTaskItem(taskCfg, isComplete, false, isOpen, self._ChangeTaskOpenFunc)
  end
end

function UIFmtChallengeInfo:_ChangeTaskOpen(taskId, isOpen)
  if isOpen then
    self.optTaskOpenDic[taskId] = true
  else
    self.optTaskOpenDic[taskId] = nil
  end
end

function UIFmtChallengeInfo:_OnClickConfirm()
  self.stgChallengeData:SetStgClgOptionalTaskOpenDic(self.optTaskOpenDic)
  if self.confirmFunc ~= nil then
    self.confirmFunc()
  end
  MsgCenter:Broadcast(eMsgEventId.OnStageChanllengeTaskChange)
  self:Delete()
end

function UIFmtChallengeInfo:_BackAction()
  self:Delete()
end

function UIFmtChallengeInfo:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFmtChallengeInfo:OnDelete()
  self.fixedTaskItem:Delete()
  self.optTaskItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIFmtChallengeInfo
