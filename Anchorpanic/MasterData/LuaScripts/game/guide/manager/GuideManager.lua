module('guide.GuideManager', Class.impl(Manager))

function ctor(self)
    super.ctor(self)
    self.m_passGuideList = {}
    -- 引导数据
    self.m_guideDict = nil
    self.m_guideTypeDict = {}
    -- 强制的流程引导数据
    self.m_guideFlowDict = nil
    self.m_curGuideRo = nil
    self.m_curGuideStepID = nil
    self.m_lastTimeScale = nil
    -- 等待网络事件的标志
    self.m_isWaitingNet = false
    -- 解析数据
    self:_parseData()

    self.m_waitGData = {}
    -- self.m_maskMat = gs.ResMgr:Load(UrlManager:getUIMaterial("RimLight.mat"))

    self.m_checked = false
    -- 是否获取了服务器的引导数据
    self.isGetGuideIds = false

end

-- function setupMaskTargetMat(self, img)
--     -- if img then
--     --     img.material = self.m_maskMat
--     -- end
-- end

-- function reductionMaskTarget(self, img)
--     if img then
--         img.material = nil
--     end
-- end

-- Override 重置数据
function resetData(self)
    self.m_passGuideList = {}
    self.m_checked = false
    self.isGetGuideIds = false
end

function checkResetGuide(self)
    -- 未获取到服务器的数据
    if StorageUtil:getString0('login_guide') == "1" then
        return false
    end

    if not self.isGetGuideIds then
        return false
    end

    if self.m_checked == true then
        return false
    end

    self.todoCallback = nil

    if #self.m_passGuideList > 0 then
        self.m_checked = true
        local keys = table.keys(self.m_guideFlowDict)
        table.sort(keys)
        for _, k in ipairs(keys) do
            local ro = self.m_guideFlowDict[k]
            local lastGuideID = self.m_passGuideList[ro:getGuideLine()]
            if lastGuideID and lastGuideID >= k then
                if ro:getDupId() and ro:getDupId() > 0 then
                    if battleMap.MainMapManager:isStageCanFight(ro:getDupId()) then
                        -- self.m_passGuideList[ro:getGuideLine()] = k - 1
                        -- 该打的, 没有打完
                        if not battleMap.MainMapManager:isStagePass(ro:getDupId()) then
                            self:clearPassGuide()
                            -- 重置已经过的引导数据
                            -- self.m_passGuideList[ro:getGuideLine()] = nil-- k - 1
                            self:getTodoEvent(ro)
                        end
                    end
                end
            end
        end
        return self.todoCallback ~= nil
    else
        if storyTalk.StoryTalkManager:lanuchFirstStory() then
            self.m_checked = true
            mainui.MainUIManager:setMainUIOpen(false)
            mainui.MainUIManager:cancelFirstCV()
            storyTalk.StoryTalkCondition:condition00()
            self.todoCallback = nil
            return true
        end

        return false
    end

end

function startTodoEvent(self)
    if self.todoCallback then
        mainui.MainUIManager:setMainUIOpen(false)
        mainui.MainUIManager:cancelFirstCV()
        self.todoCallback()
    end
   
    self.todoCallback = nil
end

function getTodoEvent(self, ro)
    if ro:getTalkId() and ro:getTalkId() ~= "" and ro:getTalkId() ~= 0 then
        self.todoCallback = function()
            storyTalk.StoryTalkManager:clearPassStory(ro:getTalkLine())
            if storyTalk.StoryTalkManager:canPlayStory(ro:getTalkId()) then
                local storyRo = storyTalk.StoryTalkManager:getStoryRo(ro:getTalkId())
                if ro:getJoinDup() and ro:getJoinDup() > 0 then
                    local function _delayCall()
                        fight.FightManager:reqBattleEnter(2, ro:getJoinDup())
                    end
                    local function _storyFinishCall()
                        LoopManager:setTimeout(0.01, self, _delayCall)
                    end
                    storyTalk.StoryTalkCondition:setStoryCallback(storyRo:getHappenType(), _storyFinishCall)
                end
            end
            storyTalk.StoryTalkManager:setCurStoryID(ro:getTalkId())
            GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_PANEL)
        end
    else
        -- 类型固定是2
        self.todoCallback = function()
            if ro:getJoinDup() and ro:getJoinDup() > 0 then
                local stageVo = battleMap.MainMapManager:getStageVo(ro:getJoinDup())
                if stageVo and stageVo.type == battleMap.MainMapStageType.Story then
                    self:_guide2JustStory(stageVo)
                else
                    fight.FightManager:reqBattleEnter(2, ro:getJoinDup())
                end
            end
        end
    end
end

-- 记录已完成的引导
-- 特别的补充说明: 非重置类引导 只要开始了 后端会当成已经完成去处理
-- 能重置的引导 逻辑正常走
function setPassGuideIds(self, ids)
    self.isGetGuideIds = true
    if table.empty(ids) then
        self.m_passGuideList = {}
    else
        for _, v in ipairs(ids) do
            self.m_passGuideList[v.line_id] = v.guide_id
        end
    end
end

-- 清空引导记录
function clearPassGuide(self)
    self.m_passGuideList = {}
end

function isPassFirstGuide(self)
    local guidID = self.m_passGuideList[1]
    if guidID and guidID >= 1015 then
        return true
    end
    return true
end

function canNeedGuide(self, guideId)
    return self.m_passGuideList[#self.m_passGuideList] == guideId
end

-- 初始化配置表
function _parseData(self)
    -- 解析数据
    self.m_guideDict = {}

    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if(GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3))then
        baseData = RefMgr:getData('guide_data_channel')
    else
        baseData = RefMgr:getData("guide_data")
    end

    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(guide.GuideDataRo)
        ro:parseData(key, data)
        self.m_guideDict[key] = ro

        local hType = ro:getHappenType()
        local lst = self.m_guideTypeDict[hType]
        if not lst then
            lst = {}
            self.m_guideTypeDict[hType] = lst
        end
        table.insert(lst, ro)
    end
    self.m_guideFlowDict = {}
    local baseData = RefMgr:getData('guide_flow_data')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(guide.GuideFlowDataRo)
        ro:parseData(key, data)
        self.m_guideFlowDict[key] = ro
    end
end

function guideRos(self)
    if self.m_guideDict == nil then
        self:_parseData()
    end
    return self.m_guideDict
end

function getGuideRo(self, guideID)
    self:guideRos()
    local ro = self.m_guideDict[guideID]
    if ro == nil then
        Debug:log_error("GuideManager", "不存在guideID: " .. guideID)
    end
    return ro
end
-- 通过触发类型获取对应的引导列表
function getGuideRosByHapplyType(self, happlyType)
    return self.m_guideTypeDict[happlyType]
end

function recoverTimeScale(self)
    if self.m_lastTimeScale then
        RateLooperUnScale:setStop(false)
        fight.FightManager:setupTimeScale(self.m_lastTimeScale)
        self.m_lastTimeScale = nil
    end
end

function switchFinishCall(self, beSuccessFlag)
    if self.m_curGuideRo then
        self.m_curGuideRo.__loading = nil
        if beSuccessFlag == true then
            self:reqCS_GUIDE_END(self.m_curGuideRo:getRefID())
            local group = self.m_curGuideRo:getGuideGroup()
            local keys = table.keys(group)
            table.sort(keys)
            guide.GuideCondition:guideCallback(self.m_curGuideRo:getHappenType(), true, self.m_curGuideRo)
        end
    end
    self.m_curGuideRo = nil
    self.m_curGuideStepID = nil
end

function getCurGuideRo(self)
    return self.m_curGuideRo
end

-- 当前是否存在引导内容
function getCurHasGuide(self)
    return self.m_curGuideRo ~= nil
end

function getCurStepID(self)
    return self.m_curGuideStepID
end

function getCurStepData(self)
    if self.m_curGuideRo and self.m_curGuideStepID then
        local group = self.m_curGuideRo:getGuideGroup()
        if group then
            return group[self.m_curGuideStepID]
        end
    end
    return nil
end

function getNextStepData(self)
    if self.m_curGuideRo and self.m_curGuideStepID then
        local group = self.m_curGuideRo:getGuideGroup()
        if group then
            return group[self.m_curGuideStepID + 1]
        end
    end
    return nil
end

function _guide2JustStory(self, stageVo)
    local finishCall = function(isSuccess, storyRo)
        if (isSuccess) then
            if (not battleMap.MainMapManager:isStagePass(stageVo.stageId)) then
                GameDispatcher:dispatchEvent(EventName.REQ_DUP_STORY_FINISH, {battleType = PreFightBattleType.MainMapStage, fieldId = stageVo.stageId})
            end
            guide.GuideCondition:condition14()
        end
    end
    storyTalk.StoryTalkManager:justStoryNoFight(PreFightBattleType.MainMapStage, stageVo.stageId, finishCall)
end

function startGuide(self, guideID, targetTrans)
    if self:canPlayGuide(guideID) then
        self.m_curGuideRo = self:getGuideRo(guideID)
        local group = self.m_curGuideRo:getGuideGroup()
        if table.empty(group) then
            local args = self.m_curGuideRo:getDup()
            if not table.empty(args) then
                local stageVo = battleMap.MainMapManager:getStageVo(args[2])
                if args[1] == 2 and stageVo and stageVo.type == battleMap.MainMapStageType.Story then
                    self:_guide2JustStory(stageVo)
                else
                    fight.FightManager:reqBattleEnter(args[1], args[2])
                end
            end
            self:switchFinishCall(true)
            logWarn("没有引导数据, 不作引导处理")
            -- 可能真是有没有数据的情况
            return
        end
        if not table.empty(self.m_curGuideRo:getAward()) then
            self.m_isWaitingNet = true
            self:reqCS_GUIDE_AWARD(guideID)
        end
        local keys = table.keys(group)
        table.sort(keys)
        self.m_curGuideStepID = keys[1]
        local gData = group[self.m_curGuideStepID]
        if gData then
            self:_showSysUI(group[self.m_curGuideStepID])

            -- 暂定时间
            if self.m_curGuideRo:getIsPause() == 1 then
                self.m_lastTimeScale = gs.Time.timeScale
                -- gs.Time.timeScale = 0
            else
                self.m_lastTimeScale = nil
            end

            GameDispatcher:dispatchEvent(EventName.OPEN_GUIDE_PANEL)

            if gData.control and gData.control ~= "" and not guide.GuideUITransHandler:getTrans(gData.control) or (gData.display_control and gData.display_control ~= "" and not guide.GuideUITransHandler:getTrans(gData.display_control)) then
                print("1 wait for ", gData.control)
                self.m_waitGData[1] = gData
                self.m_waitGData[2] = 1
                self:closeLoopCheck()
                self.m_loopSn = LoopManager:addTimer(0.1, 0, self, self.waitForControl)
                return true
            end
            GameDispatcher:dispatchEvent(EventName.REQ_GUIDE_REPORT, {guidId = self.m_curGuideRo:getRefID(), stepId = self.m_curGuideStepID})
            -- 初步指引
            GameDispatcher:dispatchEvent(EventName.START_GUIDE_STEP, {step = gData, trans = targetTrans})
            -- print("startGuide ==================", self.m_curGuideRo:getRefID())
            return true
        end
    end
    logError("startGuide ?????????????")
    self.m_curGuideRo = nil
    return false
end

function _showSysUI(self, gData)
    if gData and gData.uicode and gData.uicode > 0 then
        -- 打开对应的功能界面
        gs.PopPanelManager.CloseAll()
        -- GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = gData.uicode, noGuide = true })
        GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI)
        return true
    end
end
function recvGuideFlag(self)
    self.m_isWaitingNet = false
    if self.m_isReady2Next then
        self:runNextGuide(self.m_nextTargetTrans)
    end 
    self.m_nextTargetTrans = nil
end
function runNextGuideWithID(self, guideID, targetTrans)
    if self.m_curGuideRo and self.m_curGuideRo:getRefID() == guideID then
        self:runNextGuide(targetTrans)
    end
end

function handleWaitGData(self)
    if self.m_waitGData[1] and guide.GuideUITransHandler:getTrans(self.m_waitGData[1].control) then
        if self.m_waitGData[1].display_control and self.m_waitGData[1].display_control ~= "" then
            if not guide.GuideUITransHandler:getTrans(self.m_waitGData[1].display_control) then
                return false
            end
        end
        -- print("wait for ", self.m_waitGData[1].control, guide.GuideUITransHandler:getTrans(self.m_waitGData[1].control).name)
        local gData = self.m_waitGData[1]
        self.m_waitGData[1] = nil
        if self.m_curGuideRo then
            if self.m_waitGData[2] == 1 then
                -- 初步指引
                GameDispatcher:dispatchEvent(EventName.START_GUIDE_STEP, {step = gData})
                GameDispatcher:dispatchEvent(EventName.REQ_GUIDE_REPORT, {guidId = self.m_curGuideRo:getRefID(), stepId = self.m_curGuideStepID})
            else
                -- 下一步指引
                GameDispatcher:dispatchEvent(EventName.NEXT_GUIDE_STEP, {step = gData})
                GameDispatcher:dispatchEvent(EventName.REQ_GUIDE_REPORT, {guidId = self.m_curGuideRo:getRefID(), stepId = self.m_curGuideStepID})
            end
        end
        return true
    end
end
function waitForControl(self)
    if self:handleWaitGData() then
        self:closeLoopCheck()
    end
end

function closeLoopCheck(self)
    LoopManager:removeTimerByIndex(self.m_loopSn)
    self.m_loopSn = nil
end

function runNextGuide(self, targetTrans)

    if self.m_isWaitingNet == true then
        self.m_nextTargetTrans = targetTrans
        self.m_isReady2Next = true
        return
    end
    self.m_isReady2Next = false
    if self.m_curGuideRo then
        local group = self.m_curGuideRo:getGuideGroup()
        if group then
            local gData = group[self.m_curGuideStepID]
            if gData and gData.next_id then
                self.m_curGuideStepID = gData.next_id
                gData = group[self.m_curGuideStepID]
                if gData then
                    self:_showSysUI(gData)
                    if (gData.control and gData.control ~= "" and not guide.GuideUITransHandler:getTrans(gData.control)) or (gData.display_control and gData.display_control ~= "" and not guide.GuideUITransHandler:getTrans(gData.display_control)) then
                        -- print("2 wait for ", gData.control)
                        self.m_waitGData[1] = gData
                        self.m_waitGData[2] = 2
                        self:closeLoopCheck()
                        self.m_loopSn = LoopManager:addTimer(0.1, 0, self, self.waitForControl)
                        return
                    end

                    GameDispatcher:dispatchEvent(EventName.REQ_GUIDE_REPORT, {guidId = self.m_curGuideRo:getRefID(), stepId = self.m_curGuideStepID})
                    GameDispatcher:dispatchEvent(EventName.NEXT_GUIDE_STEP, {step = gData, trans = targetTrans})
                    return
                end
            end
        end

        local args = self.m_curGuideRo:getDup()
        if not table.empty(args) then
            local stageVo = battleMap.MainMapManager:getStageVo(args[2])
            if args[1] == 2 and stageVo and stageVo.type == battleMap.MainMapStageType.Story then
                self:_guide2JustStory(stageVo)
            else
                fight.FightManager:reqBattleEnter(args[1], args[2])
            end
        end

        GameDispatcher:dispatchEvent(EventName.CLOSE_GUIDE_PANEL)
        self:switchFinishCall(true)
        return
    end
    GameDispatcher:dispatchEvent(EventName.CLOSE_GUIDE_PANEL)
    self:switchFinishCall(false)
end

-- 判断是否可播放
function canPlayGuide(self, guideID)
    local tmpRo = self:getGuideRo(guideID)
    if tmpRo then
        local sID = self.m_passGuideList[tmpRo:getLineID()]
        if sID and sID >= guideID then 
            return false
        end

        if StorageUtil:getString0('login_guide') == "1" then
            return false
        end

        return true
    end
    return false
end

-- 通知服务器引导播放完
function reqCS_GUIDE_END(self, guideID)

    local isEditor = storyTalk.StoryTalkManager:getIsEditor()
    if isEditor then
        return
    else
    end

    local ro = self:getGuideRo(guideID)
    if ro then
        self.m_passGuideList[ro:getLineID()] = guideID
        SOCKET_SEND(Protocol.CS_GUIDE_END, {guide_id = guideID})
        print("reqCS_GUIDE_END ============ ", ro:getLineID(), guideID)
    end
end

function reqCS_GUIDE_AWARD(self, guideID)
    local isEditor = storyTalk.StoryTalkManager:getIsEditor()
    if isEditor then
        return
    else
    end
    
    local ro = self:getGuideRo(guideID)
    if ro then
        SOCKET_SEND(Protocol.CS_GUIDE_AWARD, {guide_id = guideID})
        print("reqCS_GUIDE_AWARD ============ ", guideID)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
