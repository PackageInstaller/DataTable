---@class ActivityPortConstructionPanel : ActivityPortConstructionPanel_Generate
---##################### 【ActivityPortConstructionPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ActivityPortConstructionPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ActivityPortConstructionPanel = require "ActivityPortConstructionPanel_Generate"

function ActivityPortConstructionPanel:InitLogic(data)
    self.msgEventHandler = {
        --刷新任务按钮状态
        {GameMsgType.MissionRefresh, self.RefreshUI},
    }
end

--function ActivityPortConstructionPanel:StartCreating(time)
--
--end

--function ActivityPortConstructionPanel:StartEnter(time)
--
--end

--function ActivityPortConstructionPanel:StartRemoving(time)
--
--end

--function ActivityPortConstructionPanel:StartExit(time)
--
--end

function ActivityPortConstructionPanel:OnOpen(data, initiative)
    self.bg1.image.color = Color.New(1, 1, 1, 0)
    self.bg1.transform.localScale = Vector3.New(1.2, 1.2, 1)
    self.bg2.image.color = Color.New(1, 1, 1, 0)
    self.bg2.transform.localScale = Vector3.New(1.2, 1.2, 1)
    self.bg3.image.color = Color.New(1, 1, 1, 0)
    self.bg3.transform.localScale = Vector3.New(1.2, 1.2, 1)
    self.timeBg.canvasGroup.alpha = 0
    self.timeBg.transform.localPosition = Vector3.New(920 + 40, 456,0)
    
    self.taskLoopList.canvasGroup.alpha = 0
    self.taskLoopList.transform.localPosition = Vector3.New(480 + 40, -186,0)
    self.tweenList = {}
    if initiative then
        self.taskDataList = {}
        self:bindList()
        self._activityConfig = data.cfg
        self:RefreshUI(true)
    end
    self.descText.text.text = LocalStrEnum["ActivityPortConstructionDesc"]
    self.descTextShadow.text.text = LocalStrEnum["ActivityPortConstructionDesc"]
    self:RefreshUI()
    self:doOpenAni()
end

function ActivityPortConstructionPanel:bindList()
    self.taskLoopList.loopListView2:InitListView(#self.taskDataList, function(listView, index)
        local loopListViewItem2 = listView:GetShownItemByItemIndex(index)
        if loopListViewItem2 == nil then
            loopListViewItem2 = listView:NewListViewItem("CommonTaskBox")
        end
        local itemObj = loopListViewItem2.gameObject
        EngineUtil.FillPeer(self.commonTaskBox, itemObj)
        local taskData = self.taskDataList[index + 1]
        local taskProgressTarget = Me:getTaskProgressTarget(taskData.server.id, GE.MissionSystemType.task)
        --itemObj.taskMsgTxt.text.text = taskData.config.TaskSynopsis

        local showTaskProgress = taskData.server.progress < taskProgressTarget and taskData.server.progress or taskProgressTarget
        -- if showTaskProgress == taskProgressTarget then
        --     itemObj.taskNameTxt.text.text = string.format("%s  (<color=#1b83d9>%s</color><color=#838383>/%s</color>)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        -- else
        --     itemObj.taskNameTxt.text.text = string.format("%s  (<color=#e8703b>%s</color><color=#838383>/%s</color>)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        -- end
        itemObj.taskNameTxt.text.text = string.format("%s  (%s/%s)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        itemObj.finish:SetActive(taskData.server.state == GE.MissionState.Received)
        
        if taskData.server.state == GE.MissionState.Unclaimed then
            itemObj.getBtn:SetActive(true)
            itemObj.getBtn.scaleButton.onClick:RemoveAllListeners()
            itemObj.getBtn.scaleButton.onClick:AddListener(function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                local missionId = {
                    taskData.server.id
                }
                Me:GetMissionRewardReq(missionId, function(data)
                    self:RefreshUI()
                end)
            end)
        else
            itemObj.getBtn:SetActive(false)
        end

        if taskData.server.state == GE.MissionState.Progress and taskData.config.TurnTo ~= 0 then
            itemObj.goToBtn:SetActive(true)
            itemObj.goToBtn.scaleButton.onClick:RemoveAllListeners()
            itemObj.goToBtn.scaleButton.onClick:AddListener(function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                local canTurnTo = UICommonUtils.CanUseSkipJudge(taskData.config.TurnTo, true)
                if canTurnTo then
                    UICommonUtils.CommonTurnTo(taskData.config.TurnTo, self.uiConfig.id, function()
                        --跳转后隐藏活动界面
                        ClientData:RecordActivityPanelLastSelectId(nil)
                        UIMgr:hideUI("ActivityPanel")
                    end)
                end
            end)
        else
            itemObj.goToBtn:SetActive(false)
        end

        self:FillTemplateContent(self.customBox, itemObj.rewardList, tablex.size(taskData.config.Award), function (index, rewardObj)
            rewardObj.transform.localScale = Vector3.New(0.5,0.5,1)
            local rewardData = taskData.config.Award[index]
            rewardObj.customBox:setMono(self)
            rewardObj.customBox:SetUIData(rewardData, {navType = GE.NavigationType.ActivityPanel})
        end)
        return loopListViewItem2
    end)
end

function ActivityPortConstructionPanel:RefreshUI(initiative)
    self.taskDataList = {}
    local taskgroup = self._activityConfig.TaskGroup[1]
    local taskList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.PortConstruction, taskgroup)
    local taskCount, finishCount = 0, 0
    for _, task in ipairs(taskList) do
        local missionData = Me:getMissionListById(task.id)
        taskCount = taskCount + 1
        if missionData and missionData.state == GE.MissionState.Received then
            finishCount = finishCount + 1
        end
        table.insert(self.taskDataList, {
            config = task,
            server = missionData,
        })
    end
    table.sort(self.taskDataList, function(a, b)
        local aState = a.server and a.server.state or 0
        local bState = b.server and b.server.state or 0
        if aState ~= bState then
            return aState < bState
        end
        return a.config.id < b.config.id
    end)
    self.taskLoopList.loopListView2:SetListItemCount(#self.taskDataList)
    self.taskLoopList.loopListView2:RefreshAllShownItem2()
    self.activityProgressText.text.text = string.format("%d/%d", finishCount, taskCount)
end

function ActivityPortConstructionPanel:doOpenAni()
    local seq1 = self:CreateEnterSequence(self.bg1, 0.4, 0.4)
    local seq2 = self:CreateEnterSequence(self.bg2, 0.3, 0.3)
    local seq3 = self:CreateEnterSequence(self.bg3, 0.3, 0.3)
    -- 按前后顺序有节奏地播放，例如每个之间间隔 0.2 秒
    local mainSequence = DG.Tweening.DOTween.Sequence()
    mainSequence:Append(seq1)
    mainSequence:AppendInterval(0.1)  -- 节奏间隔
    mainSequence:Append(seq2)
    mainSequence:AppendInterval(0.1)
    mainSequence:Append(seq3)
    table.insert(self.tweenList, mainSequence)
    local enterSeq = self:FadeInAndSlideLeft(self.timeBg, -40, 0.8)
    table.insert(self.tweenList, enterSeq)
    enterSeq = self:FadeInAndSlideLeft(self.taskLoopList, -40, 0.8)
    table.insert(self.tweenList, enterSeq)
    -- 将总 Sequence 加入管理列表，这样一次 Kill 就能停止所有
    --table.insert(self.tweenList, mainSequence)
end

-- 工具函数：为一个 bg 创建“淡入 + 弹性缩放入场”的 Sequence
function ActivityPortConstructionPanel:CreateEnterSequence(bg, fadeDuration, scaleDuration)
    local seq = DG.Tweening.DOTween.Sequence()
    -- 同时进行：透明度从当前值到 1，缩放从当前值到 1.2
    seq:Append(bg.image:DOFade(1, fadeDuration):SetEase(DG.Tweening.Ease.InOutSine))
    seq:Join(  -- Join 让缩放与淡入同步进行
        bg.transform:DOScale(1, scaleDuration):SetEase(DG.Tweening.Ease.OutBack) -- 带弹性回弹
    )
    -- 如果希望 1.2 再缓慢回到 1 而不是直接回弹，可以改用下面这种：
    -- seq:Append(bg.transform:DOScale(1.2, scaleDuration):SetEase(DG.Tweening.Ease.InOutSine))
    -- seq:Append(bg.transform:DOScale(1, scaleDuration):SetEase(DG.Tweening.Ease.InOutSine))
    
    return seq
end

function ActivityPortConstructionPanel:FadeInAndSlideLeft(target, moveOffset, duration)
    local seq = DG.Tweening.DOTween.Sequence()
    -- 同时执行：淡入到 1，且本地 X 坐标相对移动 moveOffset
    seq:Append(target.canvasGroup:DOFade(1, duration):SetEase(DG.Tweening.Ease.InOutSine))
    seq:Join(
        target.transform:DOLocalMoveX(moveOffset, duration)
            :SetEase(DG.Tweening.Ease.OutQuad)
            :SetRelative()   -- 关键：设为相对移动模式
    )
    
    -- 如果起始需要确保物体在正确位置，可以先设置初始值
    -- target.image.color = Color with alpha 0  （通过 DOFade 会自动处理，如果之前 alpha 不是 0 可先设置）
    -- target.transform.localPosition = startPos
    
    return seq
end

function ActivityPortConstructionPanel:OnClose(initiative)
    for _, tween in ipairs(self.tweenList) do
        if tween then
            tween:Kill()
        end
    end
    self.tweenList = {}
end

--function ActivityPortConstructionPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ActivityPortConstructionPanel:OnRefresh(data)
--
--end

--[[
/Main/TaskLoopList/Viewport/Content/CommonTaskBox/GoToBtn onClick 
--]]
function ActivityPortConstructionPanel:goToBtn_ScaleButton_onClick(goToBtn)

end

--[[
/Main/TaskLoopList/Viewport/Content/CommonTaskBox/GetBtn onClick 
--]]
function ActivityPortConstructionPanel:getBtn_ScaleButton_onClick(getBtn)

end

return ActivityPortConstructionPanel
