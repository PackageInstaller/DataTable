module("cycle.CycleEventPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleEventPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 3 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end

-- 析构
function dtor(self)
end

function initData(self)
end


function __playOpenAction(self)
end

function __closeOpenAction(self)
    if self.isPop == 1 then
        self:close()
    end
end


-- 初始化
function configUI(self)
    super.configUI(self)

    self.mImgBG = self:getChildGO("mImgBG"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtDes_02 = self:getChildGO("mTxtDes_02"):GetComponent(ty.Text)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(cycle.CycleEventItem)
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
end

-- 激活
function active(self, args)
    super.active(self, args)
    GameView.UINode["STORY"].gameObject:SetActive(false)
    GameDispatcher:dispatchEvent(EventName.SHOW_CYCLE_TOP_PANEL)
    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_EVENT_PANEL, self.onUpdateEventPanel, self)
   
    self.cellId = args.cellId
    self.mEventId = args.eventId
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_EVENT_PANEL, self.onUpdateEventPanel, self)
end

function onUpdateEventPanel(self)
    self:showPanel()
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.m_childGos["mBtnSkip"], self.onSkip)
end

function showPanel(self)
    cusLog("尝试获取" .. self.cellId .. "的服务器数据")
    cycle.CycleManager:setEventClicked(false)
    self.mLyScroller.gameObject:SetActive(false)
    self.m_childGos["mBtnSkip"]:SetActive(true)
    local cellMsgVo = cycle.CycleManager:getCellDataById(self.cellId)
    local eventData = cycle.CycleManager:getCycleEventData(cellMsgVo.eventId)

    local lastSelectEventVo = cycle.CycleManager:getLastSelectChildEvent()

    local canSkip = false
    if lastSelectEventVo then
        if lastSelectEventVo:getEventIsCasino() or lastSelectEventVo:getEventIsCambler() then
            local originalEventDataVo = cycle.CycleManager:getCycleEventData(cellMsgVo.originalId)
            self.mTxtTitle.text = _TT(originalEventDataVo.optionTitle)
            self.mImgBG:SetImg(UrlManager:getBgPath(originalEventDataVo.backGroundImg), true)
            self.mStrHelper = _TT(originalEventDataVo.optionDes)
            canSkip = true
        end
    end

    cusLog("打开了事件界面")
    if canSkip then
        self:onSkip()
    else
        self.mTxtTitle.text = _TT(eventData.optionTitle)
        self.mImgBG:SetImg(UrlManager:getBgPath(eventData.backGroundImg), true)
        self.mStrHelper = _TT(eventData.optionDes)

        if self.mCvTextTimer then
            self:removeTimerByIndex(self.mCvTextTimer)
            self.mCvTextTimer = nil
        end

        self:typeWriter(self.mStrHelper)
    end

    for i = #cellMsgVo.normalArgs,1,-1 do
        local childEventVo = cycle.CycleManager:getCycleEventData(cellMsgVo.normalArgs[i])
        if childEventVo:getEventIsCasino() and cellMsgVo:getOptionArgsTimes(cellMsgVo.normalArgs[i]) == 0 then
            table.remove(cellMsgVo.normalArgs,i)
        end
    end

    if self.mLyScroller.Count > 0 then
        self.mLyScroller:ReplaceAllDataProvider(cellMsgVo.normalArgs)
    else
        self.mLyScroller.DataProvider = cellMsgVo.normalArgs
    end
    
    local lineData = cycle.CycleManager:getCurrentCycleLineData()
    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
        title = _TT(lineData.name),
        showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON, TOP_SHOW_TYPE.COIN, TOP_SHOW_TYPE.HOPE,
                        TOP_SHOW_TYPE.BUFFLIST,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
    })

end

-- 打字机
function typeWriter(self, mString)
    local CharLength = string.toCharArray(mString)
    if next(CharLength) then
        local charIndex = 1
        local strLen = table.getn(CharLength)
        local str = CharLength[charIndex]
        self.mTxtDes_02.text = str
        local time = sysParam.SysParamManager:getValue(78) / 1000
        self.mCvTextTimer = self:addTimer(time, 0, function()
            charIndex = charIndex + 1
            if charIndex <= strLen then
                str = str .. CharLength[charIndex]
                self.mTxtDes_02.text = str
            else
                self:removeTimerByIndex(self.mCvTextTimer)
                self.mCvTextTimer = nil
                self.m_childGos["mBtnSkip"]:SetActive(false)
                self.mAnimator:SetTrigger("show")
                self.mLyScroller.gameObject:SetActive(true)
                GameView.UINode["STORY"].gameObject:SetActive(true)
            end
        end)
    end

end

function onSkip(self)
    self.m_childGos["mBtnSkip"]:SetActive(false)
    self.mTxtDes_02.text = self.mStrHelper
    self.mAnimator:SetTrigger("show")
    self.mLyScroller.gameObject:SetActive(true)
    GameView.UINode["STORY"].gameObject:SetActive(true)
    if self.mCvTextTimer then
        self:removeTimerByIndex(self.mCvTextTimer)
        self.mCvTextTimer = nil
    end
end

-- function recoverCollection(self)
--     if next(self.mCollectionItems) then
--         for k, v in pairs(self.mCollectionItems) do
--             v:poolRecover()
--         end
--         self.mCollectionItems = {}
--     end

-- end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
