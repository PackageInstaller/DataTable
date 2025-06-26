--[[-----------------------------------------------------
@filename       : PermitPanel
@Description    : 通行证
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("permit.PermitPanel", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("permit/PermitPanel.prefab")
--构造函数
function ctor(self)
    super.ctor(self)
    --self:setSize(750, 600)
    --self:setTxtTitle("通行证")--通行证
    --self:setBg("permit_bg1.jpg", true, "permit")
end
-- 初始化数据
function initData(self)
    super.initData(self)
    --阶段奖励道具列表
    self.mPropsList = {}
    self.mCurIndex = 0
end

function configUI(self)
    super.configUI(self)
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mBtnTask = self:getChildGO("mBtnTask")
    self.mImgUnlock = self:getChildGO("mImgUnlock")
    self.mBtnActive = self:getChildGO("mBtnActive")
    self.mBtnOneKey = self:getChildGO("mBtnOneKey")
    self.mEffectNode = self:getChildGO("mEffectNode")
    self.mTansStageMoney = self:getChildTrans("mTansStageMoney")
    self.mTansStageNomal = self:getChildTrans("mTansStageNomal")
    self.mTxtExUL = self:getChildGO("mTxtExUL"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtExDsc = self:getChildGO("mTxtExDsc"):GetComponent(ty.Text)
    self.mTxtNextNum = self:getChildGO("mTxtNextNum"):GetComponent(ty.Text)
    self.mTxtPermitLv = self:getChildGO("mTxtPermitLv"):GetComponent(ty.Text)
    self.mProgressBar = self:getChildGO("mProgressBar"):GetComponent(ty.Image)
    self.mTxtShowProgress = self:getChildGO("mTxtShowProgress"):GetComponent(ty.Text)
    -- self.mImgShowHero = self:getChildGO("mImgShowHero"):GetComponent(ty.AutoRefImage)
    self.mScrollRect = self:getChildGO("mLyScroller"):GetComponent(ty.ScrollRect)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(permit.PermitItem)

    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mBtnShowSkin = self:getChildGO("mBtnShowSkin")
    self.mImgHeroHar = self:getChildGO("mImgHeroHar"):GetComponent(ty.AutoRefImage)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_PERMIT_LV, self.updateState, self)
    GameDispatcher:addEventListener(EventName.UPDATE_PERMIT_PANEL, self.updateView, self)
    GameDispatcher:addEventListener(EventName.UPDATE_PERMIT_RECIVE, self.updateState, self)
    self:updateView()
    self:updateTime()
    self:addTimer(1, 0, self.updateTime)
    self.mLyScroller:SetItemIndex(permit.PermitManager:getPermitIndex(), 0, 0, 0.1)

    local count = #permit.PermitManager:getPermitList() / 10
    local update = function(pos)
        local posX = math.abs(self.mScrollRect.content.transform.anchoredPosition.x) + self.mScrollRect.gameObject.transform.rect.width
        local width = self.mScrollRect.content.rect.width
        local curIndex = 10
        local stageWidth = (width / count)
        for i = 0, count do
            local stageWidthL = stageWidth * i
            local stageWidthR = (i <= count - 1) and ((i + 1) * stageWidth) or width
            if posX >= stageWidthL then
                curIndex = (i <= count - 1) and ((i + 1) * 10) or (i * 10)
            end
        end
        if self.mCurIndex ~= curIndex then
            self.mCurIndex = curIndex
            local stageVo = permit.PermitManager:getPermitList()[curIndex]
            self:updateStageInfo(stageVo)
        end
    end
    self.mScrollRect.onValueChanged:AddListener(update)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_PERMIT_LV, self.updateState, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_PERMIT_PANEL, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_PERMIT_RECIVE, self.updateState, self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
    self.mScrollRect.onValueChanged:RemoveAllListeners()
    RedPointManager:remove(self.mBtnOneKey.transform)
end

--[[    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtExDsc.text = "周经验上限"
    self:setBtnLabel(self.mBtnBuy, nil, "购买等级")
    self:setBtnLabel(self.mBtnTask, nil, "通行任务")
    self:setBtnLabel(self.mBtnActive, nil, "激活许可")
    self:setBtnLabel(self.mBtnOneKey, nil, "一键领取")

    self:getChildGO("mTxtType"):GetComponent(ty.Text).text = _TT(98106)
    self.mTxtHeroName.text = _TT(98109)

end
-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnActive, self.onClickBuyHandler)
    self:addUIEvent(self.mBtnBuy, self.onClickTopHandler, nil, true)
    self:addUIEvent(self.mBtnTask, self.onClickTopHandler, nil, false)
    self:addUIEvent(self.mBtnOneKey, self.onClickOneKeyReciveHandler)
    self:addUIEvent(self.mBtnShowSkin, self.onClickShowSkinHandler)
end

function onClickShowSkinHandler(self)
    local dic = sysParam.SysParamManager:getValue(SysParamType.PERMIT_MODEL_INFO)
    local tid = dic[1]
    local id = dic[2]
    GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW, { heroTid = tid, fashionId = id, isShow3D = true })
end

function updateView(self)
    self.mBtnActive:SetActive(permit.PermitManager:getIsBuyPermit(2) ~= true)
    local list = permit.PermitManager:getPermitList()
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
    self:updateState()

    local dic = sysParam.SysParamManager:getValue(SysParamType.PERMIT_MODEL_INFO)
    -- 部分渠道需要特殊处理
    local isHar = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious())
    self.mImgHeroHar.gameObject:SetActive(isHar)
    local fashionData = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, dic[1], dic[2])
    self.mImgHeroHar:SetImg(UrlManager:getBgPath("heroRecord_Har/" .. fashionData:getUrlBody()))
end
function closeAllProps(self)
    if self.mPropsList then
        for _, item in ipairs(self.mPropsList) do
            item:poolRecover()
        end
        self.mPropsList = {}
    end
end

function onClickTopHandler(self, isBuy)
    if isBuy then
        if permit.PermitManager:getPermitedLv() >= #permit.PermitManager:getPermitList() then
            gs.Message.Show("当前活动等级已满")
            return
        end
        GameDispatcher:dispatchEvent(EventName.OPEN_PERMIT_BUY_VIEW, {})
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Task })
    end
end

function onClickBuyHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_PERMIT_BUY_SHOW_VIEW, {})
end

function onClickOneKeyReciveHandler(self)
    GameDispatcher:dispatchEvent(EventName.ONE_KEY_RECIVER, {})
end

function updateState(self)
    self.mBtnBuy:GetComponent(ty.AutoRefImage):SetGray(#permit.PermitManager:getPermitList() <= permit.PermitManager:getPermitedLv())
    self.mEffectNode:SetActive(#permit.PermitManager:getPermitList() > permit.PermitManager:getPermitedLv())
    local msgVo = permit.PermitManager:getPermitedMsgVo()
    local curStageVo = permit.PermitManager:getCurPermitStageData()
    self:updateStageInfo(curStageVo)
    self.mTxtPermitLv.text = HtmlUtil:size(permit.PermitManager:getPermitedLv(), 44)
    if msgVo then
        self.mTxtExUL.text = _TT(45013, msgVo.week_exp, sysParam.SysParamManager:getValue(SysParamType.PERMIT_UP_LIMIT_EXP))
        local difValue = msgVo.exp / curStageVo.needExp
        self.mProgressBar.fillAmount = difValue
        self.mTxtShowProgress.text = _TT(45013, msgVo.exp, curStageVo.needExp)
    end
    self.mImgUnlock:SetActive((not permit.PermitManager:getIsBuyPermit(-1)))
    self.mBtnOneKey:SetActive(permit.PermitManager:getCanReciveNum() >= 1)
    if permit.PermitManager:getCanReciveNum() >= 1 then
        RedPointManager:add(self.mBtnOneKey.transform, nil, 124.5, 30)
    else
        RedPointManager:remove(self.mBtnOneKey.transform)
    end
end

function updateStageInfo(self, curStageVo)
    self:closeAllProps()
    for _, propVo in ipairs(curStageVo:getNoamlAwardList()) do
        local propGrid = PropsGrid:create(self.mTansStageNomal, { tid = propVo.tid, num = propVo.num ~= nil and propVo.num or 1 }, 0.7, false)
        propGrid:setHasRec(curStageVo:getIsNomalRecived() and curStageVo:getIsUnlock())
        table.insert(self.mPropsList, propGrid)
    end
    if #curStageVo:getSeniorAwardList() > 1 then
        gs.TransQuick:Scale0(self.mTansStageMoney, 0.5)
    else
        gs.TransQuick:Scale0(self.mTansStageMoney, 0.7)
    end
    for _, propVo1 in ipairs(curStageVo:getSeniorAwardList()) do
        local propGrid1 = PropsGrid:create(self.mTansStageMoney, { tid = propVo1.tid, num = propVo1.num ~= nil and propVo1.num or 1 }, 1, false)
        propGrid1:setIconGray((not curStageVo:getIsBuy()))
        propGrid1:setHasRec(curStageVo:getIsSeniorRecived() and curStageVo:getIsUnlock())
        table.insert(self.mPropsList, propGrid1)
    end
    self.mTxtNextNum.text = curStageVo.lv
end

function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Permit) then
        local clientTime = GameManager:getClientTime()
        local RemainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Permit):getEndTime() - clientTime
        local timeTxt = RemainingTime <= 0 and "活动已结束" or _TT(3530) .. HtmlUtil:colorAndSize(TimeUtil.getFormatTimeBySeconds_9(RemainingTime), "ffffffff", 18)
        self.mTxtTime.text = timeTxt
        if RemainingTime <= 0 then
            self:removeTimer(self.updateTime)
            return
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]