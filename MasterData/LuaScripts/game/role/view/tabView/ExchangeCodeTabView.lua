module('role.ExchangeCodeTabView', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('role/tab/ExchangeCodeTab.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 480)
    self:setTxtTitle(_TT(25118)) --"值班选择"
    -- self:setBg("common_bg_016.jpg", false)
    -- self:setUICode(LinkCode.HomePage)
end
--析构函数
function dtcor(self)
    super.dtcor(self)

end
-- 初始化数据
function initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mInput = self:getChildGO("mInput"):GetComponent(ty.InputField)
    -- self.mDefaultText = self.mInput.placeholder:GetComponent(ty.Text)
    self.mInput.characterLimit = sysParam.SysParamManager:getValue(SysParamType.EXCHANGE_CODE_LEN)
    self.mBtnExchange = self:getChildGO('mBtnExchange')
    -- self.mTextTitle = self:getChildGO("mTextTitle"):GetComponent(ty.Text)
    self.mEventTrigger = self.mInput.gameObject:GetComponent(ty.LongPressOrClickEventTrigger)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnExchange, 25119, "礼包兑换")
    -- self.mDefaultText.text = _TT(25181)--"点击此处输入"
    -- self.mTextTitle.text = _TT(25120)--"请输入兑换码"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExchange, self.__onClickExchangeHandler)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.RES_EXCHANGE_CODE, self.__updateView, self)
    local function onClick()
        self.mInput.placeholder.gameObject:SetActive(false)
    end
    self.mEventTrigger.onClick:AddListener(onClick)
    local function inputEnd(content)
        self.mInput.placeholder.gameObject:SetActive(true)
    end
    self.mInput.onEndEdit:AddListener(inputEnd)
    self:__updateView()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.RES_EXCHANGE_CODE, self.__updateView, self)
    self.mEventTrigger.onClick:RemoveAllListeners()
    self.mInput.onEndEdit:RemoveAllListeners()
end

function __onClickExchangeHandler(self)
    local clickIntervalTime = sysParam.SysParamManager:getValue(98)
    if self.clickTime ~= nil and GameManager:getClientTime() - self.clickTime < clickIntervalTime then
        gs.Message.Show(_TT(87, clickIntervalTime))
        return
    end

    if (self.mInput.text == "") then
        gs.Message.Show(_TT(25120))--"请输入兑换码"
    else
        GameDispatcher:dispatchEvent(EventName.REQ_EXCHANGE_CODE, { code = self.mInput.text })

        self.clickTime = GameManager:getClientTime()
    end
end

function __updateView(self)
    self.mInput.text = ""
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]