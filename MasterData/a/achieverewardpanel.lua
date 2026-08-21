---@class AchieveRewardPanel : AchieveRewardPanel_Generate
---##################### 【AchieveRewardPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【AchieveRewardPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local AchieveRewardPanel = require "AchieveRewardPanel_Generate"

function AchieveRewardPanel:InitLogic(data)

end

--function AchieveRewardPanel:StartCreating(time)
--
--end

--function AchieveRewardPanel:StartEnter(time)
--
--end

--function AchieveRewardPanel:StartRemoving(time)
--
--end

--function AchieveRewardPanel:StartExit(time)
--
--end

function AchieveRewardPanel:OnOpen(data, initiative)
    if data then
        self.nowMode = data.nowMode
        LuaLogger.ds("self.nowMode = ",self.nowMode)
    else
        self.nowMode = GE.MissionType.Achieve
    end
    
    self:setViewInfo()
end

function AchieveRewardPanel:setViewInfo()
    if self.nowMode == GE.MissionType.Achieve then
        self.titleText.text.text = "成就等级"
        self:setAchieveViewInfo()
    elseif self.nowMode == GE.MissionType.EveryDay then
        self.titleText.text.text = "日活奖励"
        self:setTaskViewInfo()
    elseif self.nowMode == GE.MissionType.EveryWeek then
        self.titleText.text.text = "周活奖励"
        self:setTaskViewInfo()
    end
end

function AchieveRewardPanel:setAchieveViewInfo()
    local rewardList = Config.GetLevelconfigInfoByType(GE.LevelDataType.achieve)
    table.sort(rewardList, function(a, b)
        local aSortKey = 3
        if a.levelup_extra and next(a.levelup_extra) then
            local missionData = Me:getMissionListById(a.levelup_extra[1])
            if missionData then
                aSortKey = missionData.state
            end
        end
        local bSortKey = 3
        if b.levelup_extra and next(b.levelup_extra) then
            local missionData = Me:getMissionListById(b.levelup_extra[1])
            if missionData then
                bSortKey = missionData.state
            end
        end
        if aSortKey ~= bSortKey then
            return aSortKey < bSortKey
        end
        return a.id < b.id
    end)

    self:FillTemplateContent(self.rewardBox, self.modeAllList, tablex.size(rewardList), function(index, rewardBox)
        rewardBox.canvasGroup.alpha = 0
        local rewardData = rewardList[index]
        if rewardData.levelup_extra and next(rewardData.levelup_extra) then
            local missionData = Me:getMissionListById(rewardData.levelup_extra[1])
            local missionConfig = Config.GetTaskTableInfo(rewardData.levelup_extra[1])
            rewardBox:SetActive(true)
            if missionData then
                rewardBox.taskGetBtn:SetActive(missionData.state == GE.MissionState.Unclaimed)
                rewardBox.taskInBtn:SetActive(missionData.state == GE.MissionState.Progress or missionData.state == GE.MissionState.Lock)
                rewardBox.taskOkBtn:SetActive(missionData.state == GE.MissionState.Received)
                rewardBox.mask:SetActive(missionData.state == GE.MissionState.Received)
            else
                rewardBox.taskGetBtn:SetActive(false)
                rewardBox.taskInBtn:SetActive(true)
                rewardBox.taskOkBtn:SetActive(false)
                rewardBox.mask:SetActive(false)
            end
            
            self:FillTemplateContent(self.customBox, rewardBox.rewardList, tablex.size(missionConfig.Award), function(k, itemObj)
                local customBox = itemObj.customBox
                customBox:setMono(self)
                customBox:SetUIData(missionConfig.Award[k], {navType = GE.NavigationType.TaskPanel,})
            end)
            rewardBox.levelTips.text.text = "成就等级"
            rewardBox.levelTxt.text.text = "成就等级达到"..rewardData.level
  
            rewardBox.taskGetBtn.button.onClick:RemoveAllListeners()
            rewardBox.taskGetBtn.button.onClick:AddListener(function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                local missionId = {
                    missionData.id
                }
                Me:GetMissionRewardReq(missionId, function(data)
                    self:setViewInfo()
                end)
            end)

            --显示动画
            DLuaTimer:DoAfter(0.05 * index, function()
                rewardBox.canvasGroup:DOFade(1, 0.2)
            end)
        else
            rewardBox:SetActive(false)
        end
    end)

    LuaLogger.ds("rewardList", tablex.dump(rewardList))

end

function AchieveRewardPanel:setTaskViewInfo()
    self:InitMissionInfoByPoint()
    --local rewardList = Config.GetLevelconfigInfoByType(GE.LevelDataType.achieve)
    self:FillTemplateContent(self.rewardBox, self.modeAllList, tablex.size(self.taskTable), function(index, rewardBox)
        local taskData = self.taskTable[index]
        if taskData.config.id  then--and next(taskData.config.id)
            local missionData = Me:getMissionListById(taskData.config.id)
            local missionConfig = Config.GetTaskTableInfo(taskData.config.id)
            rewardBox:SetActive(true)
            rewardBox.pointImg:SetActive(true)
            rewardBox.achieveLevl:SetActive(false)
            rewardBox.taskGetBtn:SetActive(missionData.state == GE.MissionState.Unclaimed)
            rewardBox.taskInBtn:SetActive(missionData.state == GE.MissionState.Progress or missionData.state == GE.MissionState.Lock)
            rewardBox.taskOkBtn:SetActive(missionData.state == GE.MissionState.Received)

            self:FillTemplateContent(self.customBox, rewardBox.rewardMsgList, tablex.size(missionConfig.Award), function(k, itemObj)
                local customBox = itemObj.customBox
                customBox:setMono(self)
                customBox:SetUIData(missionConfig.Award[k], {navType = GE.NavigationType.TaskPanel})
            end)

            rewardBox.pointTxt.text.text = missionConfig.complete[2]
            rewardBox.taskGetBtn.scaleButton.onClick:RemoveAllListeners()
            rewardBox.taskGetBtn.scaleButton.onClick:AddListener(function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                local missionId = {
                    missionData.id
                }
                Me:GetMissionRewardReq(missionId, function(data)
                    self:setViewInfo()
                end)
            end)
        else
            rewardBox:SetActive(false)
        end
    end)

    LuaLogger.ds("self.taskTable", tablex.dump(self.taskTable))

end

--获取累计积分的任务
function AchieveRewardPanel:InitMissionInfoByPoint()
    self.taskTable = {}
    for _, v in pairs(Me:getMissionList()) do
        if v.type == GE.MissionSystemType.task then
            local taskConfig = Config.GetTaskTableInfo(v.id)
            if taskConfig then
                local temp = {
                    server = v, config = taskConfig
                }
                if taskConfig.taskType == GE.MissionType.EveryDay and self.nowMode == GE.MissionType.EveryDay then
                    if taskConfig.type == GE.DayTaskType.DayPoint then
                        table.insert(self.taskTable, temp)
                    end
                elseif taskConfig.taskType == GE.MissionType.EveryWeek and self.nowMode == GE.MissionType.EveryWeek then
                    if taskConfig.type == GE.WeekTaskType.WeekPoint then
                        table.insert(self.taskTable, temp)
                    end
                end
            end
        end
    end

    table.sort(self.taskTable, function(a, b)
        if a.server.state == b.server.state then
            return a.server.id < b.server.id
        else
            return a.server.state < b.server.state
        end
    end)
end

--function AchieveRewardPanel:OnClose(initiative)
--
--end

--function AchieveRewardPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function AchieveRewardPanel:OnRefresh(data)
--
--end

--[[
/mask onClick 
--]]
function AchieveRewardPanel:mask_Button_onClick(mask)
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.mask.button.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.mask.button.interactable = true
        UIMgr:closeUI(self)
    end)
end

--[[
/PanelBg/Art/TitleBg/CloseBtn onClick 
--]]
function AchieveRewardPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.closeBtn.scaleButton.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.closeBtn.scaleButton.interactable = true
        UIMgr:closeUI(self)
    end)
end

--[[
/CustomBox/EquipBtn onClick 
--]]
function AchieveRewardPanel:equipBtn_ScaleButton_onClick(equipBtn)

end

return AchieveRewardPanel
