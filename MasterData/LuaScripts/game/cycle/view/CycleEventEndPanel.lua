module("cycle.CycleEventEndPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleEventEndPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 3 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end


function __playOpenAction(self)
end

function __closeOpenAction(self)
    if self.isPop == 1 then
        self:close()
    end
end


-- 析构
function dtor(self)
end

function initData(self)
    --self.mIsOpenBuffList = false
    --self.mCollectionItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mImgBG = self:getChildGO("mImgBG"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtDes_02 = self:getChildGO("mTxtDes_02"):GetComponent(ty.Text)
  
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
end

-- 激活
function active(self, args)
    super.active(self, args)
    
    self.oldEventData = args.oldEventData
    self.endCall = args.endCall
    GameView.UINode["STORY"].gameObject:SetActive(false)
    GameDispatcher:dispatchEvent(EventName.SHOW_CYCLE_TOP_PANEL)
   
    self.m_childGos["mBtnSkip"]:SetActive(true)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    local lineData = cycle.CycleManager:getCurrentCycleLineData()
    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
        title = _TT(lineData.name),
        showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON, TOP_SHOW_TYPE.COIN, TOP_SHOW_TYPE.HOPE,
                        TOP_SHOW_TYPE.BUFFLIST,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
    })

    if self.endCall then
        self.endCall()
        self.endCall = nil
    end
end

function resetEndCall(self)
    self.endCall = nil
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    --self.mTxtReason.text = _TT(77610)
    --self.mTxtCommander.text = _TT(77611)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

    --self:addUIEvent(self.m_childGos["mBtn_03"], self.openBuffList)
    self:addUIEvent(self.m_childGos["mBtnSkip"], self.onSkip)
end

function showPanel(self)
    self.mTxtTitle.text = _TT(self.oldEventData.optionTitle)
    self.mImgBG:SetImg(UrlManager:getBgPath(self.oldEventData.backGroundImg), true)

    self.mStrHelper = _TT(self.oldEventData.optionDes)
    local lineData = cycle.CycleManager:getCurrentCycleLineData()
    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
        title = _TT(lineData.name),
        showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON, TOP_SHOW_TYPE.COIN, TOP_SHOW_TYPE.HOPE,
                        TOP_SHOW_TYPE.BUFFLIST,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
    })


    self:typeWriter(self.mStrHelper)

end


--打字机
function typeWriter(self, mString)
    self.isPrintEnd = false
    local CharLength = string.toCharArray(mString)
    if next(CharLength) then
        local charIndex = 1
        local strLen = table.getn(CharLength)
        local str = CharLength[charIndex]
        self.mTxtDes_02.text = str
        local time = sysParam.SysParamManager:getValue(78) / 1000
        self.mCvTextTimer = self:addTimer(time,0, function()
            charIndex = charIndex + 1
            if charIndex <= strLen then
                str = str .. CharLength[charIndex]
                self.mTxtDes_02.text = str
            else
                self.isPrintEnd = true
                self:removeTimerByIndex(self.mCvTextTimer)
                self.mCvTextTimer = nil
                --self.m_childGos["mBtnSkip"]:SetActive(false)
                self.mAnimator:SetTrigger("show")
                GameView.UINode["STORY"].gameObject:SetActive(true)
            end
        end)
    end

end

function onSkip(self)
    if self.isPrintEnd == true then
        self:close()
    else
        self.isPrintEnd = true
        self.mTxtDes_02.text = self.mStrHelper
        self.mAnimator:SetTrigger("show")
        GameView.UINode["STORY"].gameObject:SetActive(true)
        if self.mCvTextTimer then
            self:removeTimerByIndex(self.mCvTextTimer)
            self.mCvTextTimer = nil
        end
    end
    --self.m_childGos["mBtnSkip"]:SetActive(false)
    
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
