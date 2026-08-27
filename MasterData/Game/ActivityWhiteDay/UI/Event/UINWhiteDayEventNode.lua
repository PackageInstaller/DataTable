local UINWhiteDayEventNode = class("UINWhiteDayEventNode", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")

function UINWhiteDayEventNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_TaskBtn, self, self.__OnClickTaskBtn)
end

function UINWhiteDayEventNode:InitWDEventNode(AWDCtrl, AWDLineData, closeCallback)
  self.AWDCtrl = AWDCtrl
  self.AWDLineData = AWDLineData
  self.closeCallback = closeCallback
  self:RefreshWDEventHeroUI()
  self:RefreshWDEventTaskUI()
end

function UINWhiteDayEventNode:RefreshWDEventHeroUI()
  local assistHeroId = self.AWDLineData:GetWDLDAssistHeroID()
  if assistHeroId == nil then
    local isGirl = PlayerDataCenter.inforData:GetSex()
    local headId
    if isGirl then
      headId = ConstGlobalItem.ProfessorGridHead
    else
      headId = ConstGlobalItem.ProfessorBodyHead
    end
    local cfg = ConfigData.portrait[headId]
    if cfg == nil then
      return
    end
    local icon = cfg.icon
    if not string.IsNullOrEmpty(icon) then
      self.ui.img_HeroPic.sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
    end
  else
    local heroData = PlayerDataCenter.heroDic[assistHeroId]
    local skinId = heroData.skinId
    self.ui.img_HeroPic.sprite = CRH:GetHeroSkinSprite(assistHeroId, skinId)
  end
end

function UINWhiteDayEventNode:RefreshWDEventTaskUI()
  local taskId = self.AWDLineData:GetWDLEventTaksId()
  local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
  local taskCfg = ConfigData.task[taskId]
  if taskData == nil or taskCfg == nil or ConfigData.taskStep[taskId] == nil then
    self:__OnClickClose()
    return
  end
  self.ui.tex_Task.text = taskData:GetTaskFirstStepIntro()
  local isComplete = taskData:CheckComplete()
  self.ui.tex_Complete:SetActive(isComplete)
  self.ui.tex_ProgressBar.gameObject:SetActive(not isComplete)
  if isComplete then
    self.ui.tex_TaskBtn:SetIndex(1)
    self.ui.slider_task.value = 1
  else
    local schedule, aim = taskData:GetTaskProcess()
    self.ui.tex_TaskBtn:SetIndex(0)
    self.ui.tex_ProgressBar:SetIndex(0, tostring(schedule), tostring(aim))
    self.ui.slider_task.value = schedule / aim
  end
  for index, itemId in ipairs(taskCfg.rewardIds) do
    local itemNum = taskCfg.rewardNums[index]
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      return
    end
    if itemCfg.action_type == eItemActionType.ActExp then
      self.ui.tex_Award:SetIndex(0, tostring(itemNum))
      break
    end
    if itemCfg.action_type == eItemActionType.ActAcc then
      self.ui.tex_Award:SetIndex(1, TimeUtil:TimestampToTime(itemNum))
      break
    end
    do
      local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
      self.ui.tex_Award:SetIndex(2, itemName, tostring(itemNum))
    end
    break
  end
  local eventType = ConfigData.activity_white_day_event.taskId2TypeDic[taskId]
  if eventType == nil then
    error("can't get WD event task's event type")
  end
  local eventCfg = ConfigData.activity_white_day_event[eventType]
  self.ui.tex_EventDesc.text = LanguageUtil.GetLocaleText(eventCfg.event_des)
  self.taskData = taskData
  self.taskCfg = taskCfg
  self.isComplete = isComplete
end

function UINWhiteDayEventNode:__OnClickTaskBtn()
  if self.isComplete then
    if self.taskData ~= nil then
      local AWDData = self.AWDLineData:GetAWDData()
      
      local function TryPlayExp()
        self.AWDCtrl:WDTryShowFactroyLevelUp(AWDData, function()
          local whiteDayWin = UIManager:GetWindow(UIWindowTypeID.WhiteDay)
          if whiteDayWin ~= nil then
            whiteDayWin.infoBtnNode:TryPlayWDLevelExpTween()
          end
        end)
      end
      
      local function showReward()
        local lineId = self.AWDLineData:GetWDLDLineID()
        MsgCenter:Broadcast(eMsgEventId.WhiteDayOrderChange, lineId)
        local rewards, nums = self.taskData:GetTaskCfgRewards()
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseList(rewards, nums)
        CRData:SetCRShowOverFunc(TryPlayExp)
        if CRData:IsCRDHasCouldShow() then
          UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
            if window == nil then
              return
            end
            window:AddAndTryShowReward(CRData)
          end)
        else
          TryPlayExp()
        end
        self:__OnClickClose()
        if table.indexof(rewards, ConstGlobalItem.WhiteTimeShort) then
          MsgCenter:Broadcast(eMsgEventId.WhiteDayOrderChange, self.AWDLineData:GetWDLDLineID(), true)
        end
      end
      
      self.AWDCtrl:WDEndlessTaskCommit(AWDData, self.taskData.id, showReward)
    end
  else
    if self.taskCfg == nil then
      return
    end
    local jumpId = self.taskCfg.jump_id
    local jumpArgs = self.taskCfg.jumpArgs
    if jumpId ~= nil and 0 < jumpId then
      self:__OnClickClose()
      JumpManager:Jump(jumpId, function(jumpCallback)
        if jumpCallback ~= nil then
          jumpCallback()
        end
      end, nil, jumpArgs)
    end
  end
end

function UINWhiteDayEventNode:__OnClickClose()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
end

function UINWhiteDayEventNode:OnDelete()
  base.OnDelete(self)
end

return UINWhiteDayEventNode
