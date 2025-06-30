module('chat.ChatMscView', Class.impl('lib.component.BaseContainer'))

UIRes = UrlManager:getUIPrefabPath("chat/ChatMscView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end


function getAdaptaTrans(self)
    return self:getChildTrans("AdaptaGroup")
end

-- 取父容器
function getParentTrans(self)
    return GameView.subPop
end

function initData(self)
    -- 最大音量
    self.mMaxVolmu = 30
    -- 当前音量
    self.mCurVolmu = 0
    -- 当前录音的时间戳
    self.mNowRecordTime = 0
    -- 最大录音时长
    self.mMaxRecordTimes = tonumber(sdk.XunFeiParam.speechTimes)
end

-- 初始化
function configUI(self)
    self.mGroupContent = self:getChildGO('mGroupContent')
    self.mImgVoiceIconWhite = self:getChildGO('mImgVoiceIconWhite'):GetComponent(ty.Image)
    self.mImgCancel = self:getChildGO('mImgCancel')
    self.mTxtCancelSend = self:getChildGO('mTxtCancelSend'):GetComponent(ty.Text)
    self.mTxtTimeCount = self:getChildGO('mTxtTimeCount'):GetComponent(ty.Text)
    self.mTxtTip = self:getChildGO('mTxtTip'):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtCancelSend.text = _TT(501) --"手指上滑，取消录音"
    self.mTxtTip.text = _TT(501) --"手指上滑，取消录音"
end

--激活
function active(self)
    super.active(self)
    -- self:updateState(false)
    sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_VOLMU_CHANGE, self.onVolmuChangeHandler, self)
    LoopManager:addTimer(1, 0, self, self.onTimeHandler)
    self.mNowRecordTime = GameManager:getClientTime()
    self:initView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    sdk.SdkManager:removeEventListener(sdk.SdkManager.SDK_VOLMU_CHANGE, self.onVolmuChangeHandler, self)
    LoopManager:removeTimer(self, self.onTimeHandler)
end

function updateState(self, isCancel)
    if(isCancel)then
        self.mGroupContent:SetActive(false)
        self.mImgCancel:SetActive(true)
    else
        self.mGroupContent:SetActive(true)
        self.mImgCancel:SetActive(false)
    end
end

function initView(self)
    self.mTxtTimeCount.text = "0s"
    self.mImgVoiceIconWhite.fillAmount = 0
end

function onTimeHandler(self)
    local deltaTime = math.max(GameManager:getClientTime() - self.mNowRecordTime, 0)
    if(deltaTime >= self.mMaxRecordTimes) then 
        GameDispatcher:dispatchEvent(EventName.REQ_END_RECORD)
        LoopManager:removeTimer(self, self.onTimeHandler)
    end
    self.mTxtTimeCount.text = deltaTime .. "s"
    self.mImgVoiceIconWhite.fillAmount = self:getMod(self.mImgVoiceIconWhite.fillAmount + 0.01)
end

function getMod(self, float)
    if(float > 1)then
        return float - 1
    end
    return float
end

function onVolmuChangeHandler(self, args)
    self.mCurVolmu = tonumber(args)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
