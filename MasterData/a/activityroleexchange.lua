---@class ActivityRoleExchange : ActivityRoleExchange_Generate
---##################### 【ActivityRoleExchange Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ActivityRoleExchange Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ActivityRoleExchange = require "ActivityRoleExchange_Generate"

function ActivityRoleExchange:InitLogic(data)
    self.msgEventHandler = {
        --刷新任务按钮状态
        {GameMsgType.MissionRefresh, self.RefreshUI},
    }
    --倒计时timer
    self._countDownTimer = nil
    self.timer = {}--界面元素渐入定时器
end

--function ActivityRoleExchange:StartCreating(time)
--
--end

--function ActivityRoleExchange:StartEnter(time)
--
--end

--function ActivityRoleExchange:StartRemoving(time)
--
--end

--function ActivityRoleExchange:StartExit(time)
--
--end

-- data = {
--     isFromActivity = bool --是否是活动入口进来
--     cfg = table --活动配置数据
-- }
function ActivityRoleExchange:OnOpen(data, initiative)
    if initiative then
        self._activityConfig = data.cfg
        self:RefreshUI(true)
        self:RefreshTickets()
    end
    local ActivityRoleChoose = UIMgr:GetUI("ActivityRoleChoose")
    local active = ActivityRoleChoose and ActivityRoleChoose.gameObject.activeSelf
    self:SetExchangeBtnState(not active)
    -- self:refreshCountDown()
    --右上角标题名称
    self.titleText.text.text = self._activityConfig.nameKey
    self.titleTextShadow.text.text = self._activityConfig.nameKey
end

-- --刷新倒计时
-- function ActivityRoleExchange:refreshCountDown()
--     if self._countDownTimer then
--         DLuaTimer:RemoveTimer(self._countDownTimer)
--         self._countDownTimer = nil
--     end
--     local originData = ClientData:GetCustomData(GE.CustomDataKey.ActivityEndTime) or {}
--     LuaLogger.ds("ActivityRoleExchange:refreshCountDown originData", tablex.dump(originData))
--     local activityEndTime = originData[tostring(self._activityConfig.id)] or 0
--     --没倒计时
--     if activityEndTime == 0 then
--         return
--     end
--     local nowTime = Me.servertime
--     local remainTime = activityEndTime - nowTime
--     if remainTime < 0 then
--         local activityPanel = UIMgr:GetUI("ActivityPanel")
--         if activityPanel then
--             activityPanel:RefreshPanel()
--         end
--         return
--     end
--     local d, h, m, s = DLuaUtil.GetDHMS(activityEndTime - nowTime)
--     local str = h .. "小时" .. m .. "分" .. s .. "秒"
--     self.countDownText.text.text = string.format(LocalStrEnum.Exchange_CountDown, str)
--     self._countDownTimer = DLuaTimer:DoAfter(1, function()
--         self:refreshCountDown()
-- 	end)
-- end

--刷新页面
function ActivityRoleExchange:RefreshUI(initiative)
    local taskgroup = self._activityConfig.TaskGroup[1]
    local taskList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.HeroExchange, taskgroup)
    self._finalTaskConfigList = {}
    local getTicketTaskConfigList = {}
    for k, v in pairs(taskList) do
        if v.type == 1 then
            table.insert(getTicketTaskConfigList, v)
        elseif v.type == 3 then
            table.insert(self._finalTaskConfigList, v)
        end
    end
    self:FillTemplateContent(self.taskBox, self.content, tablex.size(getTicketTaskConfigList), function (index, box)
        local cfgData = getTicketTaskConfigList[index]
        box.title.text.text = "No." .. index
        --描述
        box.desc.text.text = cfgData.TaskSynopsis
        --按钮状态
        local missionData = Me:getMissionListById(cfgData.id)
        LuaLogger.ds("ActivityRoleExchange:RefreshUI missionData", tablex.dump(missionData))
        box.get:SetActive(missionData.state == GE.MissionState.Unclaimed)
        box.redPoint:SetActive(missionData.state == GE.MissionState.Unclaimed)
        box.go:SetActive(missionData.state == GE.MissionState.Progress and cfgData.TurnTo ~= 0)
        box.notGet:SetActive(missionData.state == GE.MissionState.Progress and cfgData.TurnTo == 0 or 
            missionData.state == GE.MissionState.Received)
        box.finished:SetActive(missionData.state == GE.MissionState.Received or
            missionData.state == GE.MissionState.Closed)
        --跳转
        if missionData.state == GE.MissionState.Progress then
            box.notGet.text.text.text = "未完成"
        else
            box.notGet.text.text.text = "已领取"
        end
        box.go.button.onClick:RemoveAllListeners()
        box.go.button.onClick:AddListener(function ()
            local canTurnTo = UICommonUtils.CanUseSkipJudge(cfgData.TurnTo, true)
            if canTurnTo then
                UICommonUtils.CommonTurnTo(cfgData.TurnTo, nil, function ()
                    --跳转后隐藏活动界面
                    UIMgr:hideUI("ActivityPanel")
                end)
            end
        end)
        --完成任务
        box.get.button.onClick:RemoveAllListeners()
        box.get.button.onClick:AddListener(function ()
            Me:GetMissionRewardReq({cfgData.id}, function(data)
                self:RefreshTickets()
            end)
        end)
        --初始化格子入场动画
        if initiative then
            box.canvasGroup.alpha = 0
            local timer = DLuaTimer:DoAfter(0.07 * index, function()
                if box and box.canvasGroup then
                    box.canvasGroup.alpha = 0
                    box.canvasGroup:DOFade(1, 0.2)
                end
            end)
            table.insert(self.timer, timer)
        end
    end)
    --最终奖励图片
    local finalRewardCfg = self._finalTaskConfigList[1]
    local itemId = finalRewardCfg.Award[1][2]
    local itemCfg = Config.GetItemInfo(itemId)
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemCfg.icon), function (sprite)
        self.rewardIcon.image.sprite = sprite
        self.rewardIcon.image:SetNativeSize()
        self.rewardIcon:SetActive(true)
    end)
    --最终奖励数量
    local num = finalRewardCfg.Award[1][3]
    self.rewardNum.text.text = num
    local finalMissionData = Me:getMissionListById(finalRewardCfg.id)
    LuaLogger.ds("ActivityRoleExchange:RefreshUI finalMissionData", tablex.dump(finalMissionData))
    --已领取遮罩
    self.finishMask:SetActive(finalMissionData.state == GE.MissionState.Received)
    --可领取表现
    self.highLight:SetActive(finalMissionData.state == GE.MissionState.Unclaimed)
end

function ActivityRoleExchange:RefreshTickets()
    --持有兑换数量
    local ticketNum = Me:getItemNumById(100015)
    self.remainNum.text.text = LocalStrEnum.Exchange_RemainTimes .. ticketNum
end

function ActivityRoleExchange:OnClose(initiative)
    if self._countDownTimer then
        DLuaTimer:RemoveTimer(self._countDownTimer)
        self._countDownTimer = nil
    end
    --清理界面元素渐入定时器
    for _, timer in pairs(self.timer) do
        DLuaTimer:RemoveTimer(timer)
    end
    self.timer = {}
end

--function ActivityRoleExchange:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ActivityRoleExchange:OnRefresh(data)
--
--end

---设置右下角领取按钮状态
---@param bool boolean 是否显示
function ActivityRoleExchange:SetExchangeBtnState(bool)
    self.tips:SetActive(bool)
end

--[[
/bg/content/taskBox/go onClick 
--]]
function ActivityRoleExchange:go_Button_onClick(go)

end

--[[
/bg/content/taskBox/get onClick 
--]]
function ActivityRoleExchange:get_Button_onClick(get)

end

--[[
/bg/content/taskBox/notGet onClick 
--]]
function ActivityRoleExchange:notGet_Button_onClick(notGet)

end

--[[
/bg/tips/exchangeBtn onClick 右下角兑换角色按钮
--]]
function ActivityRoleExchange:exchangeBtn_ScaleButton_onClick(exchangeBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    UIMgr:popUICover("ActivityRoleChoose", {
        activityId = self._activityConfig.id
    }, nil, nil, nil, function()
        self:SetExchangeBtnState(false)
    end)
end

--[[
/bg/finalReward onClick  左下角最终奖励按钮
--]]
function ActivityRoleExchange:finalReward_Button_onClick(finalReward)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    local task = self._finalTaskConfigList[1]
    local finalMissionData = Me:getMissionListById(task.id)
    if finalMissionData and finalMissionData.state == GE.MissionState.Unclaimed then
        Me:GetMissionRewardReq({task.id}, function(data)
            -- --更新最新数据
            -- local originData = ClientData:GetCustomData(GE.CustomDataKey.ActivityEndTime) or {}
            -- -- originData[tostring(self._activityConfig.id)] = Me.nextResetTime
            -- originData[tostring(self._activityConfig.id)] = Me.servertime + 10  --测试用10秒后结束
            -- Me:RecordCustomData({
            --     [GE.CustomDataKey.ActivityEndTime] = originData
            -- },function()
            --     -- self:refreshCountDown()
            -- end)
        end)
    end
end

return ActivityRoleExchange
