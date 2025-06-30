--[[ 
-----------------------------------------------------
@filename       : RegisterView
@Description    : 注册角色页面
@date           : 2021-11-11 15:24:28
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.storyTalk.view.RegisterView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("storyTalk/RegisterView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 0 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mMsgList = { 51002, 51003, 51004, 51005, 51006, 51007, 51008, 51009, 51010, 51011, 51012 }
    self.mIndex = 0
    self.mInfoList = {}
end

-- 初始化
function configUI(self)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mBtnRegisterGo = self:getChildGO("mBtnRegister")
    self.mBtnRegister = self:getChildGO("mBtnRegister"):GetComponent(ty.LongPressOrClickEventTrigger)
    self.mImgStar = self:getChildTrans("mImgStar")
    self.mImgLogin = self:getChildTrans("mImgLogin")
    self.mGroupInfo = self:getChildTrans("mGroupInfo")

    self.mImgEff = self:getChildTrans("mImgEff")

    self.mGroupSetup = self:getChildTrans("mGroupSetup"):GetComponent(ty.CanvasGroup)
    self.mTxtwelcome = self:getChildTrans("mTxtwelcome"):GetComponent(ty.Text)
    self.mTxtwelcomeGroup = self:getChildTrans("mTxtwelcome"):GetComponent(ty.CanvasGroup)
    -- self.bb = self:getChildTrans("bb")
end

--激活
function active(self)
    super.active(self)

    local function onBeginPress()
        self:onBeginPressHandler()
    end
    self.mBtnRegister.onLongPress:AddListener(onBeginPress)

    local function onEndPress()
        self:onEndPressHandler()
    end
    self.mBtnRegister.onPointerUp:AddListener(onEndPress)

    -- self.timeId2 = self:addTimer(1, #self.mMsgList, self.startEff, self.timerOver)
    self:startEff()
    AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_check.prefab"))

    local tweener = self.mImgLogin:DOLocalRotate(gs.Vector3(0, 0, -360), 1, CS.DG.Tweening.RotateMode.FastBeyond360)
    tweener:SetLoops(-1, gs.DT.LoopType.Restart)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverListItem()
    LoopManager:clearTimeout(self.m_printSn)
    if self.tweener then
        self.tweener:Kill()
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtTitle.text = _TT(51001)
    self.mTxtTips.text = _TT(51013)
    self.mTxtwelcome.text = _TT(1195)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function onBeginPressHandler(self)
	AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_fingerprint.prefab"))

    self.timeId = self:addTimer(1, 0, self.onTimer)

    if self.tweener then
        self.tweener:Kill()
    end
    self.mImgEff.gameObject:SetActive(true)
    gs.TransQuick:LPosY(self.mImgEff, 104)
    self.tweener = TweenFactory:move2LPosY(self.mImgEff, -104, 1, nil, function()
        TweenFactory:move2LPosY(self.mImgEff, 104, 1)
    end, true)
end


function onEndPressHandler(self)
    self:removeTimerByIndex(self.timeId)
    self.timeId = nil

    if self.tweener then
        self.tweener:Kill()
    end
    self.mImgEff.gameObject:SetActive(false)
end

function onTimer(self)
    self:onEndPressHandler()

    TweenFactory:canvasGroupAlphaTo(self.mGroupSetup, 1, 0, 1, nil, function()
        TweenFactory:canvasGroupAlphaTo(self.mTxtwelcomeGroup, 0, 1, 3, nil, function()
            self:setTimeout(1, function()
                GameDispatcher:dispatchEvent(EventName.CLOSE_REGISTER_VIEW)
                self:close()
            end)
        end)
    end)


    -- gs.Message.Show("验证成功")
    -- self:setTimeout(1, function()
    --     GameDispatcher:dispatchEvent(EventName.CLOSE_REGISTER_VIEW)
    -- end)
    -- self:close()
end

function __playOpenAction(self)

end

function __closeOpenAction(self)
    self:close()
end

function startEff(self)

    self.mIndex = self.mIndex + 1
    if self.mIndex > #self.mMsgList then
        self:timerOver()
        return
    end

    local item = SimpleInsItem:create(self:getChildGO("GroupInfoItem"), self.mGroupInfo, "RegisterViewInfoItem")
    table.insert(self.mInfoList, item)

    local msgContext = _TT(self.mMsgList[self.mIndex])
    self.m_msgCharArr = string.toCharArray(msgContext)
    self.m_curMsgLen = #self.m_msgCharArr
    self.m_lastPrintIdx = 1
    self:onPrintingStep()

end
-- 回收项
function recoverListItem(self)
    if self.mInfoList then
        for i, v in pairs(self.mInfoList) do
            v:poolRecover()
        end
    end
    self.mInfoList = {}
end

function stopPrint(self)
    LoopManager:clearTimeout(self.m_printSn)
    self.m_printSn = nil
    self.m_msgTxt.text = self.mMsgList[self.mIndex]
end

function onPrintingStep(self)
    local item = self.mInfoList[self.mIndex]
    if self.m_lastPrintIdx < self.m_curMsgLen then
        local char = self.m_msgCharArr[self.m_lastPrintIdx]
        item:setText("mTxtInfo", nil, item:getTextCom("mTxtInfo").text .. char)

        self.m_lastPrintIdx = self.m_lastPrintIdx + 1
        self.m_printSn = LoopManager:setTimeout(0.02, self, self.onPrintingStep)
    else
        self.m_printSn = nil
        item:setText("mTxtInfo", nil, _TT(self.mMsgList[self.mIndex]))
        self:startEff()
    end
end

function timerOver(self)
    self.mBtnRegisterGo:SetActive(true)

end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
