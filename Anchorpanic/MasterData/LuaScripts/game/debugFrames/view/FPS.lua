--[[****************************************************************************
Brief  : 显示FPS，内存信息界面
Author :lizhenghui
****************************************************************************
]]
module('debugFrames.FPS', Class.impl('lib.component.BaseContainer'))
UIRes = UrlManager:getUIPrefabPath('debug/FPS.prefab')

EVENT_VISIBLE_CHANGE = "EVENT_VISIBLE_CHANGE"

function initData(self)
    self.m_frames = 0
    self.m_lastRealTime = gs.Time.realtimeSinceStartup
    self.m_isOpen = false

    self.mMaxDeltaTime = 0
end

--初始化UI
function configUI(self)
    self.mTxtArea = self:getChildGO("mTxtArea"):GetComponent(ty.Text)
    self.mTxtArea2 = self:getChildGO("mTxtArea2"):GetComponent(ty.Text)
    self.mBtnShow = self:getChildGO("mBtnShow")

    self.mBtnResetTime = self:getChildGO("mBtnResetTime")
    self.mBtnShowConsole = self:getChildGO("mBtnShowConsole")
    --self.mBtnShowStoryData = self:getChildGO("mBtnStoryData")
   
end

--激活
function active(self)
    self:_startTimer()
    self:addOnClick(self.mBtnShow, self.onShowAll)
    self:addOnClick(self.mBtnResetTime, self.onResetTime)
    self:addOnClick(self.mBtnShowConsole,self.onShowConsole)
end
--非激活
function deActive(self)
    self:_stopTimer()
    self:removeOnClick(self.mBtnShow)
end

function getParentTrans(self)
    return GameView.gm
end


function _startTimer(self)
    LoopManager:addFrame(1, 0, self, self._step)
end

function _stopTimer(self)
    LoopManager:removeFrame(self, self._step)
end

function _step(self, deltaTime)
    self.m_frames = self.m_frames + 1
    local realtime = gs.Time.realtimeSinceStartup
    if realtime > self.m_lastRealTime + 1 then
        -- local fps = self.m_frames --/(realtime - self.m_lastRealTime)
        -- self.m_txtFPS.text = "FPS：" .. math.floor(fps * 100) / 100
        --local intTime = realtime - self.m_lastRealTime
        if gs.Time.deltaTime >= self.mMaxDeltaTime then
            self.mMaxDeltaTime = gs.Time.deltaTime
        end

        local abModel = (gs.Game.IsLoadAB and gs.ApplicationUtil.IsEditorRun) and "FBI WARNING：加载ab包模式运行\n" or ""

        local fpsText = abModel .. "FPS：" .. self.m_frames .. "||" .. string.format("%.3f", self.mMaxDeltaTime);
        self.m_frames = 0
        self.m_lastRealTime = realtime

        local luaText = "lua内存：" .. GCUtil.getLuaMemoryMB() .. " Mb"
        local csharpText = "C#内存：" .. GCUtil.getCSharpMemoryMB() .. " Mb"
        local snLenText = "流水号：" .. SnMgr:curSn() .. " 时长:" .. TimeUtil.getFormatTimeBySeconds_1(os.time() - GameManager.clientSetupTime)

        local gcStatusText = "LuaGC " .. tostring(GCUtil.isLuaGCEnable()) ..
        " C#GC " .. tostring(GCUtil.isCSharpGCEnable()) ..
        " LoadPriority " .. tostring(gs.ApplicationUtil:GetLoadingPriority())

        local updateCount = gs.LoopBehaviour.Instance:GetUpdateCount();
        local loopCount = gs.LoopBehaviour.Instance:GetLoopTimerCount();
        local luaLoopTimer = LoopManager:getTimerCount() + fight.LiveLooper:getTimerCount()
        + RateLooper:getTimerCount() + RateLooperUnScale:getTimerCount();
        local luaLoopFrame = LoopManager:getFrameCount() + fight.LiveLooper:getFrameCount()
        + RateLooper:getFrameCount() + RateLooperUnScale:getFrameCount();

        local resCacheCount = gs.ResMgr:GetResourceCacheCount();

        local updateText = "Update:C " .. updateCount .. " LUA " .. luaLoopFrame
        local timerText = "Timer:C " .. loopCount .. " LUA " .. luaLoopTimer
        local gameObjectPoolText = "ObjPool :" .. gs.GOPoolMgr:GetPoolObjectCount()
        .. " LightWeight(Other) :" .. gs.GOPoolMgr:GetLightWeightObjectCount()
        local resText = "ResCount : " .. resCacheCount
        local resAddText = "ResAdd : " .. gs.ResMgr:GetResourceAddHistory(5)
        local resRemoveText = "ResRemove : " .. gs.ResMgr:GetResourceRemoveHistory(5)

        self.mTxtArea.text = fpsText .. "\n" .. luaText .. "\n" .. csharpText .. "\n" .. snLenText .. "\n"
        self.mTxtArea2.text = gcStatusText .. "\n" .. updateText .. "\n" .. timerText .. "\n"
        .. gameObjectPoolText .. "\n" .. resText .. "\n" .. resAddText .. "\n" .. resRemoveText
    end
end

function onShowAll(self)
    self.mTxtArea2.gameObject:SetActive(self.mTxtArea2.gameObject.activeSelf == false)
end

function onResetTime(self)
    self.mMaxDeltaTime = 0
end

function onShowConsole(self)
    gs.ApplicationUtil.ShowDebugView()
end


-- function onShowStoryData(self)
--     storyTalk.StoryTalkManager:debugStoryDFA()
-- end

--打开
function open(self)
    if self.m_isOpen then return end

    self.m_isOpen = true
    local parentTrans = self:getParentTrans()
    if parentTrans and self.UITrans and self.UITrans.parent ~= parentTrans then
        self.UITrans:SetParent(parentTrans, false)
        self:active()
    end
end

-- 关闭
function close(self)
    if not self.m_isOpen then return end

    self.m_isOpen = false
    if self.UITrans then
        self.UITrans:SetParent(GameView.UICache, false)
    end
    self:deActive()
end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
