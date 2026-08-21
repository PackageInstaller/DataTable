---@class DispatchMainPanel : DispatchMainPanel_Generate
---##################### 【DispatchMainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【DispatchMainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local DispatchMainPanel = require "DispatchMainPanel_Generate"

function DispatchMainPanel:InitLogic(data)
    self._curPage = 1
    self._timerList = {}
      self.msgEventHandler = {
        {GameMsgType.DispatchDataUpdate, self.onDataUpdata},
    }
end

--function DispatchMainPanel:StartCreating(time)
--
--end

--function DispatchMainPanel:StartEnter(time)
--
--end

--function DispatchMainPanel:StartRemoving(time)
--
--end

--function DispatchMainPanel:StartExit(time)
--
--end

function DispatchMainPanel:OnOpen(data, initiative)
    self.bg1.image.color = Color.New(1, 1, 1, 1)
    self.bg1.transform.localScale = Vector3.one
    self.main.canvasGroup.alpha = 1
    self.main.transform.localScale = Vector3.one
    self.main.canvasGroup.interactable = true
    if initiative then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.DispatchPanel, self)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            --self.animator:SetTrigger("out")
            --self.animOverCallBack:SetCallBack(function()
            UIMgr:closeSpecificUI(self)
            self.customBackPanel.customBackPanel:ClearBackFunc()

            --end)
        end)
    else
    end
    if data and data.page then
        self._curPage = data.page
    end
    self:initData()
    self:initUI()
    self:refreshMain()
end

function DispatchMainPanel:initData()
    self.page2List = {}
    local dispatchCfg = Config.GetAllConfig("DispatchTable")
    for _, cfg in pairs(dispatchCfg) do
        if cfg.type == 2 then
            table.insert(self.page2List, cfg)
        end
    end
    table.sort(self.page2List, function (a, b)
        return a.group < b.group
    end)
end

function DispatchMainPanel:initUI()
    self.customMsgPanel:SetActive(false)
    self.chapterRewardBox:SetActive(false)
    self.chapterRewardBg:SetActive(false)
    self.rewardReviewBg:SetActive(false)
    self.taskPanelBg:SetActive(false)
    
    self.chapterRewardBtn.scaleButton.onClick:RemoveAllListeners()
    self.chapterRewardBtn.scaleButton.onClick:AddListener(function ()
        self.chapterRewardBg:SetActive(true)
        self:refreshChanpterReward()
    end)
end

function DispatchMainPanel:onDataUpdata()
    self.randomTaskList = Me:getDispatchRandomTaskList() or {}
    self.showTaskList = {}
    for _, taskInfo in pairs(self.randomTaskList) do
        if taskInfo~={} then
            table.insert(self.showTaskList, taskInfo)
        end
    end
    self.taskBtn:SetActive(tablex.size(self.showTaskList) > 0)
    self.taskBtn.redPoint:SetActive(RedPointMgr:DispatchTaskBtnRedJudge())
end

function DispatchMainPanel:refreshChanpterReward()
    local dataList = {}
    for _, dispatchCfg in pairs(self.page2List) do
        local pregress = Me:getDispatchChapterProgress(dispatchCfg.id)
        local isComplete = pregress == 1 and true or false
        local isReceive = false
        if isComplete then
            isReceive = Me:dispatchChapterRewardIsReceive(dispatchCfg.id)
        end
        table.insert(dataList,{
            cfg = dispatchCfg,
            isComplete = isComplete,
            isReceive = isReceive,
        })
    end
    table.sort(dataList, function (a, b)
        if a.isReceive ~= b.isReceive then
            return a.isReceive == false
        elseif a.isComplete ~= b.isComplete then
            return a.isComplete == true
        else
            return a.cfg.group < b.cfg.group
        end
    end)
    self:FillTemplateContent(self.chapterRewardBox, self.chapterRewardBg.rewardList, tablex.size(dataList), function (index, itemObj)
        local data = dataList[index]
        local indexText
        if data.cfg.group < 10 then
            indexText = "0"..data.cfg.group
        else
            indexText = tostring(data.cfg.group)
        end
        itemObj.index.text.text = indexText
        itemObj.mask:SetActive(data.isReceive)
        itemObj.desc.text.text = data.cfg.name
        if data.isComplete == false then
            itemObj.bgReceive:SetActive(false)
            itemObj.finishText:SetActive(false)
            itemObj.inProgressText:SetActive(true)
        else
            if data.isReceive == true then
                itemObj.bgReceive:SetActive(false)
                itemObj.finishText:SetActive(true)
                itemObj.inProgressText:SetActive(false)
            else
                itemObj.bgReceive:SetActive(true)
            end
        end

        local finishAward = data.cfg.finishAward
        self:FillTemplateContent(self.customBox, itemObj.rewardList, tablex.size(finishAward), function(k, itemObj)
            itemObj.transform.localScale = Vector3.New(0.6,0.6,0.6)
            local customBox = itemObj.customBox
            local tempData = finishAward[k]
            tempData.tipsPassEventState = false
            customBox:setMono(self)
            customBox:SetUIData(finishAward[k], {navType = GE.NavigationType.DispatchPanel})
        end)
        itemObj.btn.button.onClick:RemoveAllListeners()
        itemObj.btn.button.onClick:AddListener(function ()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            if data.isComplete == false or data.isReceive == true then
                return
            end
            Me:dispatchChapterRewardReq({chapterId = data.cfg.id}, function(rewardData)
                if rewardData.ret == 0 then
                    for _, reward in pairs(rewardData.rewardList) do
                        reward.type = GE.RewardType.ItemProp
                    end
                    Me:ReceiveReward( rewardData.rewardList, function()
                        self:refreshChanpterReward()
                        self:refreshMain()
                    end)
                end
            end)
        end)
    end)
end

function DispatchMainPanel:refreshRewardReview(pointGroup)
    if not pointGroup then
        return
    end
    --local pointIdList = Config.GetDispatchPointByGroup(pointGroup)
    self.rewardReviewBg:SetActive(true)
    local rewardIdList = {}
    for _, pointGroupId in pairs(pointGroup) do
        local pointList = Config.GetDispatchPointByGroup(pointGroupId)
        for _, pointCfg in pairs(pointList) do
            if pointCfg.awardPreview then
                for _, reward in pairs(pointCfg.awardPreview) do
                    rewardIdList[reward[2]] = true
                end
            end
        end
    end
    local tempList = {}
    for rewardId, value in pairs(rewardIdList) do
        table.insert(tempList, rewardId)
    end
    
    self:FillTemplateContent(self.customBox, self.rewardReviewBg.rewardList, tablex.size(tempList), function (index, itemObj)
        local customBox = itemObj.customBox
        local rewardId = tempList[index]
        local customData = {
            id = rewardId,
            type = GE.RewardType.ItemProp,
            tipsPassEventState = false,
        }
        customBox:setMono(self)
        customBox:SetUIData(customData, { navType = GE.NavigationType.TaskPanel})
    end)
end

function DispatchMainPanel:refreshTaskPanel()
    self.randomTaskList = Me:getDispatchRandomTaskList() or {}
    self.showTaskList = {}
    for _, taskInfo in pairs(self.randomTaskList) do
        if taskInfo ~= {} then
            table.insert(self.showTaskList, taskInfo)
        end
    end
    table.sort(self.showTaskList, function (a, b)
        if a.lineId == 0 and b.lineId ~= 0 then
            return true
        elseif a.lineId ~= 0 and b.lineId == 0 then
            return false
        else
            return a.dispatchId < b.dispatchId
        end
    end)
    local count = tablex.size(self.showTaskList)
    if count <= 0 then
        self.taskPanelBg:SetActive(false)
    end
    self:FillTemplateContent(self.taskNode, self.taskPanelBg.root, tablex.size(self.showTaskList), function (index, itemObj)
        local taskData = self.showTaskList[index]
        if not taskData then
            return
        end
        local dispatchCfg = Config.GetDispatchInfo( taskData.dispatchId)
        if not dispatchCfg then
            LuaLogger.e("DispatchMainPanel:refreshTaskPanel dispatchCfg is nil, taskData.dispatchId:"..taskData.dispatchId)
            return
        end
        itemObj.taskName.text.text = dispatchCfg.name
        itemObj.lv.text.text = dispatchCfg.unLock[2]
        itemObj.num.text.text = dispatchCfg.characterNum
        local costTimeList = dispatchCfg.costTime[1] or {}
        local useTime = 0
        for _, t in ipairs(costTimeList) do
            useTime = useTime + t
        end
        itemObj.cost.text.text = string.format("%.2f小时", useTime / 3600)
        itemObj.rawardGet:SetActive(false)
      
        local isShowRewardPreview = false
        local showLineId = 0
        if taskData.lineId == 0 then
            --任务未开始
            isShowRewardPreview = true
            showLineId = Config.GetDispatchPointByGroup(dispatchCfg.pointGroup[1])[1].id
            itemObj.inWait:SetActive(true)
            itemObj.inProgress:SetActive(false)
            itemObj.inComplete:SetActive(false)
            itemObj.inStop:SetActive(false)

            if self._timerList[dispatchCfg.id] then
                DLuaTimer:RemoveTimer(self._timerList[dispatchCfg.id])
                self._timerList[dispatchCfg.id] = nil
            end
            local remainTime = taskData.endTime - DLuaUtil:GetGreenwichTime()
            if remainTime <= 0 then
                itemObj:SetActive(false)
                count = count - 1
            end
            self:setCountDownText(itemObj.inWait.time, remainTime)
            self._timerList[dispatchCfg.id] = DLuaTimer:DoRepeatForever(1, function()
                remainTime = taskData.endTime - DLuaUtil:GetGreenwichTime()
                self:setCountDownText(itemObj.inWait.time, remainTime)
                if remainTime <= 0 then
                    self:refreshTaskPanel()
                    if self._timerList[dispatchCfg.id] then
                        DLuaTimer:RemoveTimer(self._timerList[dispatchCfg.id])
                        self._timerList[dispatchCfg.id] = nil
                    end
                end
            end)
        else
            local dispatchTaskData = Me:getDispatchTaskDataById(taskData.dispatchId)
            if not dispatchTaskData then
                return
            end
            if dispatchTaskData.state == GE.DispatchState.Dispatching then
                isShowRewardPreview = true
                showLineId = taskData.lineId
                itemObj.inWait:SetActive(false)
                itemObj.inProgress:SetActive(true)
                itemObj.inComplete:SetActive(false)
                itemObj.inStop:SetActive(false)

                if self._timerList[dispatchCfg.id] then
                    DLuaTimer:RemoveTimer(self._timerList[dispatchCfg.id])
                    self._timerList[dispatchCfg.id] = nil
                end
                local remainTime = dispatchTaskData.finishTime - DLuaUtil:GetGreenwichTime()
                self:setCountDownText(itemObj.inProgress.time, remainTime)
                self._timerList[dispatchCfg.id] = DLuaTimer:DoRepeatForever(1, function()
                    remainTime = dispatchTaskData.finishTime - DLuaUtil:GetGreenwichTime()
                    self:setCountDownText(itemObj.inProgress.time, remainTime)
                    if remainTime <= 0 then
                        if self._timerList[dispatchCfg.id] then
                            DLuaTimer:RemoveTimer(self._timerList[dispatchCfg.id])
                            self._timerList[dispatchCfg.id] = nil
                        end
                    end
                end)
            elseif dispatchTaskData.state == GE.DispatchState.Finish then
                itemObj.inWait:SetActive(false)
                itemObj.inProgress:SetActive(false)
                local isStop = false
                local pointInfo = dispatchTaskData.pointInfo
                local pointList = Config.GetDispatchPointByGroup(taskData.lineId)
                if tablex.size(pointInfo) < tablex.size(pointList) then
                    isStop = true
                else
                    local allZero = true
                    for _, hp in pairs(pointInfo[tablex.size(pointList)].endEnergy) do
                        if hp > 0 then
                            allZero = false
                            break
                        end
                    end
                    if allZero then
                        isStop = true
                    end
                end
                if isStop then
                    itemObj.inStop:SetActive(true)
                    itemObj.inComplete:SetActive(false)
                else
                    itemObj.inStop:SetActive(false)
                    itemObj.inComplete:SetActive(true)
                end
                itemObj.rawardGet:SetActive(true)
                local rewardDataList = {}
                for _, v in pairs(pointInfo) do
                    if v.reward then
                        for _, reward in pairs(v.reward) do
                            table.insert(rewardDataList, reward)
                        end
                    end
                end
                rewardDataList = Me:mergeRewardList(rewardDataList)
                self:fillCustomBox(itemObj.rawardGet.rDRoot, rewardDataList, 0.75)
            end
        end
        if isShowRewardPreview then
            itemObj.rawardDis:SetActive(true)
            
            local dataList = {}
            for _, reward in pairs(dispatchCfg.awardPreview or {}) do
                table.insert(dataList, {id = reward[2], num = reward[3]})
            end
            self:fillCustomBox(itemObj.rawardDis.rDRoot, dataList, 0.75)
        else
            itemObj.rawardDis:SetActive(false)
        end

        itemObj.scaleButton.onClick:RemoveAllListeners()
        itemObj.scaleButton.onClick:AddListener(function ()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            if taskData.lineId ~= 0 then
                local dispatchTaskData = Me:getDispatchTaskDataById(taskData.dispatchId)
                if dispatchTaskData and dispatchTaskData.state == GE.DispatchState.Finish then
                    Me:dispatchEndReq({dispatchIdList = {taskData.dispatchId}}, function(data)
                        if data.ret == 0 then
                            local rewardList = data.rewardList or {}
                            for _, reward in pairs(rewardList) do
                                reward.type = GE.RewardType.ItemProp
                            end
                            self:refreshTaskPanel()
                            Me:ReceiveReward(rewardList, function()
                                --self:refreshTaskPanel()
                            end)
                            
                            CoveManager.instance()._roleMgr:disPatchEndRecover()
                        end
                    end)
                    return
                end
            else
                self:openDetailPanel(taskData.dispatchId)
            end
        end)
    end)

    self.taskPanelBg.t1.transform.localPosition = Vector3.New(-1 * (300 + (count - 1) * 244), -5, 0)
    self.taskPanelBg.t2.transform.localPosition = Vector3.New((300 + (count - 1) * 244), -5, 0)
end

function DispatchMainPanel:fillCustomBox(root, dataList, size)
    self:FillTemplateContent(self.customBox, root, tablex.size(dataList), function (index, itemObj)
        local customBox = itemObj.customBox
        if size then
            itemObj.transform.localScale = Vector3.New(size, size, size)
        else
            itemObj.transform.localScale = Vector3.New(1,1,1)
        end
        local customData = {
            navType = GE.NavigationType.DispatchPanel,
            tipsPassEventState = false,
        }
        customBox:setMono(self)
        customBox:SetUIData(dataList[index], customData)
    end)
end

function DispatchMainPanel:setCountDownText(countDownText, remainTime)
    if remainTime <= 0 then
        countDownText.text.text = "00:00:00"
    else
        local hours = math.floor(remainTime / 3600)
        local minutes = math.floor((remainTime % 3600) / 60)
        local seconds = remainTime % 60
        countDownText.text.text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
    end
end

function DispatchMainPanel:refreshMain()
    local chaperNum = tablex.size(self.page2List)
    self.chapterNodeList = {}
    local completeNum = 0
    local existReward = false
    self:FillTemplateContent(self.chapterNode, self.eventList, chaperNum, function (index, itemObj)
        local isLock = true
        local chapterData = self.page2List[index]
        local isJudge = PlayerPrefs.GetInt("CloseDispatchChapterCondition", 0) == 0
        if isJudge then
            isLock = not Me:canOpenFunctionByCfg(chapterData.unLock)
        else
            isLock = false
        end
        if isLock then
            itemObj.lock:SetActive(true)
            itemObj.info:SetActive(false)
            itemObj.lockIndex.text.text = chapterData.group
            itemObj.redPoint:SetActive(false)
            itemObj.scaleButton.onClick:RemoveAllListeners()
            itemObj.scaleButton.onClick:AddListener(function ()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                --self:openDetailPanel(chapterData.id)
                UICommonUtils.CommonLockJudge(chapterData.unLock, true)
            end)
        else
            itemObj.lock:SetActive(false)
            itemObj.info:SetActive(true)
            itemObj.chapterName.text.text = chapterData.name
            itemObj.index.text.text = chapterData.group

            if self._timerList[chapterData.id] then
                DLuaTimer:RemoveTimer(self._timerList[chapterData.id])
                self._timerList[chapterData.id] = nil
            end
            local dispatchTaskInfo = Me:getDispatchTaskDataById(chapterData.id)
            if dispatchTaskInfo then
                if dispatchTaskInfo.state == GE.DispatchState.Finish then
                    itemObj.redPoint:SetActive(true)
                    itemObj.countDownBg:SetActive(false)
                    itemObj.completeBg:SetActive(true)
                    local isWin = Me:getDispatchIsWin(chapterData.id)
                    itemObj.completeBg.clock1:SetActive(isWin)
                    itemObj.completeBg.clock2:SetActive(not isWin)
                    local color = isWin and Color.NewFromStr("93EA8F") or Color.NewFromStr("ffae2e")
                    itemObj.completeBg.desc.text.color = color
                elseif dispatchTaskInfo.state == GE.DispatchState.Dispatching then
                    itemObj.redPoint:SetActive(false)
                    itemObj.countDownBg:SetActive(true)
                    itemObj.completeBg:SetActive(false)
                    local remainTime = dispatchTaskInfo.finishTime - DLuaUtil:GetGreenwichTime()
                    self:setCountDownText(itemObj.countDownText, remainTime)
                    self._timerList[chapterData.id] = DLuaTimer:DoRepeatForever(1, function()
                        remainTime = dispatchTaskInfo.finishTime - DLuaUtil:GetGreenwichTime()
                        self:setCountDownText(itemObj.countDownText, remainTime)
                        if remainTime <= 0 then
                            if self._timerList[chapterData.id] then
                                DLuaTimer:RemoveTimer(self._timerList[chapterData.id])
                                self._timerList[chapterData.id] = nil
                            end
                        end
                    end)
                end
            else
                itemObj.completeBg:SetActive(false)
                itemObj.countDownBg:SetActive(false)
                itemObj.redPoint:SetActive(false)
            end
            local pregress = Me:getDispatchChapterProgress(chapterData.id)
            local isComplete = pregress == 1 and true or false
            local isReceive = false
            if isComplete then
                completeNum = completeNum + 1
                isReceive = Me:dispatchChapterRewardIsReceive(chapterData.id)
                itemObj.complete:SetActive(true)
                itemObj.progress:SetActive(false)
                if isReceive == false then
                    existReward = true
                end
            else
                itemObj.complete:SetActive(false)
                itemObj.progress:SetActive(true)
                itemObj.percentImg.image.fillAmount = pregress
                itemObj.percentText.text.text = string.format("进度 %.0f%%", pregress * 100)
            end
            itemObj.rewardBtn.scaleButton.onClick:RemoveAllListeners()
            itemObj.rewardBtn.scaleButton.onClick:AddListener(function ()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                --TODO 章节奖励预览

                self:refreshRewardReview(chapterData.pointGroup)
            end)
            itemObj.scaleButton.onClick:RemoveAllListeners()
            itemObj.scaleButton.onClick:AddListener(function ()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                self:openDetailPanel(chapterData.id)
            end)
        end
        --self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..giftCfg.Items_get[1][2]), self.info.image)
        self.chapterNodeList[chapterData.id] = itemObj
        --引导触发
        if index == chaperNum then
            GuideMgr:StartGuideTrigger("DispatchMainPanel")
        end
    end)
    --chapterReward
    self.chapterRewardBtn.curTex.text.text = completeNum
    self.chapterRewardBtn.maxTex.text.text = string.format("/ %d", chaperNum)
    self.chapterRewardBtn.light:SetActive(existReward)
    self.chapterRewardBtn.progress.image.fillAmount = chaperNum == 0 and 0 or completeNum / chaperNum

    self:onDataUpdata()
end

function DispatchMainPanel:openDetailPanel(chapterId)
    local duration = 0.5 -0.2
    local scale = 2
    self.openDetailSeq = DG.Tweening.DOTween.Sequence()
    self.main.canvasGroup.interactable = false
    self.openDetailSeq:Append(self.bg1.image:DOFade(0, duration + 0.2):SetEase(DG.Tweening.Ease.InQuad):OnComplete(function()
        UIMgr:popUI("DispatchDetailPanel", {id = chapterId})
    end))
    self.openDetailSeq:Join(self.bg1.transform:DOScale(scale, duration):SetEase(DG.Tweening.Ease.InQuad))
    self.openDetailSeq:Join(self.main.canvasGroup:DOFade(0, duration):SetEase(DG.Tweening.Ease.InQuad))
    self.openDetailSeq:Join(self.main.transform:DOScale(scale, duration):SetEase(DG.Tweening.Ease.InQuad))
end

function DispatchMainPanel:OnClose(initiative)
    if self.openDetailSeq then
        self.openDetailSeq:Kill()
        self.openDetailSeq = nil
    end
    for _, timer in pairs(self._timerList) do
        if timer then
            DLuaTimer:RemoveTimer(timer)
        end
    end
end

-- function DispatchMainPanel:OnDestroy()
-- 	for _, timer in pairs(self._timerList) do
--         if timer then
--             DLuaTimer:RemoveTimer(timer)
--         end
--     end

--     self.super:OnDestroy(self)
-- end

--function DispatchMainPanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/ChapterRewardBtn onClick 
--]]
function DispatchMainPanel:chapterRewardBtn_ScaleButton_onClick(chapterRewardBtn)

end

--[[
/ChapterRewardBg/Panel/List/Viewport/RewardList/ChapterRewardBox/Btn onClick 
--]]
function DispatchMainPanel:btn_Button_onClick(btn)

end

--[[
/ChapterRewardBg/Panel/ChapterRewardCloseBtn onClick 
--]]
function DispatchMainPanel:chapterRewardCloseBtn_ScaleButton_onClick(chapterRewardCloseBtn)
    --self.chapterRewardBg:SetActive(false)
    self:playCloseAnim(self.chapterRewardBg)
end

--[[
/AdjustRoot/AllReceiveBtn onClick 
--]]
function DispatchMainPanel:allReceiveBtn_ScaleButton_onClick(allReceiveBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    local dispatchTaskList = Me:getDispatchTaskList()
    local dispatchIdList = {}
    for _, taskData in pairs(dispatchTaskList) do
        if taskData.lineId ~= 0 and taskData.state == GE.DispatchState.Finish then
            table.insert(dispatchIdList, taskData.dispatchId)
        end
    end
    if tablex.size(dispatchIdList) == 0 then
        UICommonUtils.PopToast("无可领取奖励!")
        return
    end
    Me:dispatchEndReq({dispatchIdList = dispatchIdList}, function(data)
        if data.ret == 0 then
            local rewardList = data.rewardList or {}
            for _, reward in pairs(rewardList) do
                reward.type = GE.RewardType.ItemProp
            end
            Me:ReceiveReward(rewardList, function()
                self:refreshTaskPanel()
                self:refreshChanpterReward()
                self:refreshMain()
            end)
            CoveManager.instance()._roleMgr:disPatchEndRecover()
        end
    end)
end

--[[
/AdjustRoot/TaskBtn onClick 
--]]
function DispatchMainPanel:taskBtn_ScaleButton_onClick(taskBtn)
    RedPointMgr:SetRedDotState("RandomDispatchEventRed", false)
    RedPointMgr:Refresh("DispatchBtnRedJudge")
    self:onDataUpdata()
    self.taskPanelBg:SetActive(true)
    self:refreshTaskPanel()
end

--[[
/RewardReviewBg/Panel/RewardReviewCloseBtn onClick 
--]]
function DispatchMainPanel:rewardReviewCloseBtn_ScaleButton_onClick(rewardReviewCloseBtn)
    --self.rewardReviewBg:SetActive(false)
    self:playCloseAnim(self.rewardReviewBg)
end

--[[
/Chapter/Viewport/EventList/ChapterNode/Info/RewardBtn onClick 
--]]
function DispatchMainPanel:rewardBtn_ScaleButton_onClick(rewardBtn)

end

--[[
/ChapterRewardBg onClick 
--]]
function DispatchMainPanel:chapterRewardBg_Button_onClick(chapterRewardBg)
    --self.chapterRewardBg:SetActive(false)
    self:playCloseAnim(self.chapterRewardBg)
end

--[[
/RewardReviewBg onClick 
--]]
function DispatchMainPanel:rewardReviewBg_Button_onClick(rewardReviewBg)
    --self.rewardReviewBg:SetActive(false)
    self:playCloseAnim(self.rewardReviewBg)
end

--[[
/TaskPanelBg onClick 
--]]
function DispatchMainPanel:taskPanelBg_Button_onClick(taskPanelBg)
    self.taskPanelBg:SetActive(false)
end

---@param node DispatchMainPanel_Generate_chapterRewardBg
function DispatchMainPanel:playCloseAnim(node)
    node.animator.enabled = true
    node.animator:SetTrigger("Out")
    node.animOverCallBack:SetCallBack(function()
        node.gameObject:SetActive(false)
    end)
end

return DispatchMainPanel
