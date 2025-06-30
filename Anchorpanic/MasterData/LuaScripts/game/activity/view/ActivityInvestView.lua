module('game.activity.view.ActivityInvestView', Class.impl(TabSubView))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivityInvestView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)

    self.mAccrueItems = {}
    self.mPropsItems = {}

    self.mAwardItems = {}

    self.mShowAwardItems = {}
end
-- 析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtEndTimer = self:getChildGO("mTxtEndTimer"):GetComponent(ty.Text)
    self.mLoginContent = self:getChildTrans("mLoginContent")
    self.mLoginItem = self:getChildGO("mLoginItem")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCurrent = self:getChildGO("mTxtCurrent"):GetComponent(ty.Text)
    self.mBtnBuy = self:getChildGO("mBtnBuy"):GetComponent(ty.Button)
    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)

    self.mDayBg = self:getChildGO("mDayBg"):GetComponent(ty.RectTransform)
    self.mDayImg = self:getChildGO("mDayImg"):GetComponent(ty.RectTransform)
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mAwardItem = self:getChildGO("mAwardItem")

    self.mBtnCloseAward = self:getChildGO("mBtnCloseAward")
    self.mBtnHideAward = self:getChildGO("mBtnHideAward")
    self.mAwardTipsRT = self:getChildGO("mAwardTips")
    self.mAwardShowContent = self:getChildTrans("mAwardShowContent")
    self.mTxtAwardInfo = self:getChildGO("mTxtAwardInfo"):GetComponent(ty.Text)
end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})

    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_INVEST_VIEW, self.showPanel, self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACTIVITY_INVEST_VIEW, self.showPanel, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:clearPropsItems()
    self:clearAccrueItems()
    self:clearAwardItems()
    self:clearShowAward()
    self.mBtnCloseAward:SetActive(false)

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuy, self.onBtnBuyClick)
    self:addUIEvent(self.mBtnHideAward, self.onBtnHideClick)
end

function onBtnHideClick(self)
    self.mBtnCloseAward:SetActive(false)
end

function onBtnBuyClick(self)
    local gradeId = activity.ActivityManager:getInvestGrade()
    local curMoney = activity.ActivityManager:getInvestTotalCount()
    self.needMoney = sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_INVEST_NEED_MONEY) / 100
    if curMoney >= self.needMoney or gradeId > 0 then
        local prefixVersion =
        download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)
        if not StorageUtil:getBool1(prefixVersion .. "invest") then
            StorageUtil:saveBool1(prefixVersion .. "invest", true)
            activity.ActivityManager:updateRed()
        end

        local redTran = self.mBtnBuy.transform
        RedPointManager:remove(redTran, nil, 0, 0)
    end

    if gradeId > 0 then
        gs.Message.Show(_TT(136513))
        return
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_INVEST_BUY_VIEW)
end

function showPanel(self)
    self:clearPropsItems()
    self:clearAccrueItems()
    self:clearAwardItems()
    self:clearShowAward()

    local curDay = activity.ActivityManager:getActivityDay()
    local curId = activity.ActivityManager:getInvestGrade()

    self.mBtnBuy.interactable = curId == 0 
    self.mTxtGet.text = curId == 0 and _TT(136516) or _TT(136515)
    self.needMoney = sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_INVEST_NEED_MONEY) / 100
    self.mTxtTitle.text = string.substitute(_TT(136504),self.needMoney)

    local curMoney = activity.ActivityManager:getInvestTotalCount()
    self.mTxtCurrent.text = string.substitute(_TT(136506), curMoney,
        self.needMoney)

    local investAccrueList = activity.ActivityManager:getInvestAccrueData()

    local maxId = 0

    for i = 1, #investAccrueList do
        local item = SimpleInsItem:create(self.mLoginItem, self.mLoginContent, "mInvestAccrueItem")
        item:getChildGO("mTxtTitle"):GetComponent(ty.Text).text =
            string.substitute(_TT(136505), investAccrueList[i].day)

        local geted = activity.ActivityManager:getInvestItemRewardGeted(i)
        item:getChildGO("mGeted"):SetActive(geted)
        item:getChildGO("mBtnGet"):SetActive(not geted)
        item:getChildGO("mBtnGet"):GetComponent(ty.Button).interactable = curDay >= investAccrueList[i].day and 
        curMoney >= self.needMoney

        local propsList = AwardPackManager:getAwardListById(investAccrueList[i].dropId)
        for k, v in pairs(propsList) do
            local propsGrid = PropsGrid:createByData({
                tid = v.tid,
                num = v.num,
                parent = item:getChildTrans("mPropsContent"),
                scale = 0.6,
                showUseInTip = true
            })
            table.insert(self.mPropsItems, propsGrid)
        end

        item:addUIEvent("mBtnGet", function()
            if curDay < investAccrueList[i].day then
                gs.Message.Show(_TT(136507))
                return
            end

            if curMoney < self.needMoney then
                gs.Message.Show(_TT(136514))
                return
            end

            GameDispatcher:dispatchEvent(EventName.REQ_ACTIVITY_INVEST_GET, {
                type = 2,
                id = investAccrueList[i].id
            })
        end)

        local redTran = item:getChildTrans("mBtnGet")
        if activity.ActivityManager:canDefGetRed(investAccrueList[i].id) then
            RedPointManager:add(redTran, nil, 71.4, 33)
        else
            RedPointManager:remove(redTran, nil, 0, 0)
        end
        table.insert(self.mAccrueItems, item)
    end

    local investVo
    if curId == 0 then
        investVo = activity.ActivityManager:getInvestDataById(1)
    else
        investVo = activity.ActivityManager:getInvestDataById(curId)
    end

    local rewardList = {}
    for k, v in pairs(investVo.dayReward) do
        table.insert(rewardList, {
            id = k,
            reward = v.reward
        })
    end
    table.sort(rewardList, function(a, b)
        return a.id < b.id
    end)

    local x = 150

    if curDay > #rewardList then
        curDay = #rewardList
    end
    gs.TransQuick:SizeDelta01(self.mDayImg, (curDay - 1) * x)
    gs.TransQuick:SizeDelta01(self.mDayBg, (#rewardList - 1) * x)

    for i = 1, #rewardList do
        local item = SimpleInsItem:create(self.mAwardItem, self.mAwardContent, "mInvestAwardItem")
        item:getChildGO("mTxtDay"):GetComponent(ty.Text).text = string.substitute(_TT(136509), rewardList[i].id)

        local dayed = curDay < rewardList[i].id
        item:getChildGO("mImgCanNoClick"):SetActive(dayed)
        item:getChildGO("mImgCanClick"):SetActive(not dayed)

        local isPass = activity.ActivityManager:getInvestAssetRewardGeted(rewardList[i].id)

        item:getChildGO("isPass"):SetActive(isPass)
        
        local redTran = item:getChildTrans("mClickBg")
        item:getChildGO("mReceive"):SetActive(false)
        if activity.ActivityManager:canGetGradeRed(rewardList[i].id) then
            item:getChildGO("mReceive"):SetActive(true)
            RedPointManager:add(redTran, nil, 38.8, 20)
        else
            RedPointManager:remove(redTran, nil, 0, 0)
        end



        gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), (rewardList[i].id - 1) * x, 1.3)
        item:addUIEvent(nil, function()
            if curId <= 0 then
                gs.Message.Show(_TT(136508))
                return
            end

            if isPass then
                gs.Message.Show(_TT(411))
                return
            end

            if not dayed and curId > 0 then
                GameDispatcher:dispatchEvent(EventName.REQ_ACTIVITY_INVEST_GET, {
                    type = 1,
                    id = rewardList[i].id
                })
                return
            end

            self:openAwardInfo(rewardList[i].reward, item.m_trans, rewardList[i].id)
        end)

       
       
        table.insert(self.mAwardItems, item)
    end

    local redTran = self.mBtnBuy.transform
    if activity.ActivityManager:canBuyInvest() then
        RedPointManager:add(redTran, nil, 112.6, 20)
    else
        RedPointManager:remove(redTran, nil, 0, 0)
    end

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    self:updateTime()
    self.updateTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)
end

function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Activity_Invest) then
        local clientTime = GameManager:getClientTime()
        local remainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Activity_Invest)
            :getEndTime() - clientTime
        local timeTxt = remainingTime <= 0 and "活动已结束" or _TT(3530) ..
                            HtmlUtil:colorAndSize(TimeUtil.getFormatTimeBySeconds_9(remainingTime), "323232ff", 22)

        self.mTxtEndTimer.text = timeTxt

        if remainingTime <= 0 then
            LoopManager:removeTimerByIndex(self.updateTimeSn)
            self.updateTimeSn = nil
            --self:close()
            return
        end
    end
end

function openAwardInfo(self, reward, trans, day)

    self.mBtnCloseAward:SetActive(true)

    gs.TransQuick:Pos(self.mAwardTipsRT.transform, math.min( trans.position.x,4.58),trans.position.y,trans.position.z)

    self.mTxtAwardInfo.text = _TT(136510,day)
    self:clearShowAward()

    local propsItem = PropsGrid:createByData({
        tid = reward[1],
        num = reward[2],
        parent = self.mAwardShowContent,
        scale = 0.85,
        showUseInTip = true
    })
    table.insert(self.mShowAwardItems, propsItem)
end

function clearShowAward(self)
    for i = 1, #self.mShowAwardItems do
        self.mShowAwardItems[i]:poolRecover()
    end
    self.mShowAwardItems = {}
end

function clearAccrueItems(self)
    for i = 1, #self.mAccrueItems do
        self.mAccrueItems[i]:poolRecover()
    end
    self.mAccrueItems = {}
end

function clearPropsItems(self)
    for i = 1, #self.mPropsItems do
        self.mPropsItems[i]:poolRecover()
    end
    self.mPropsItems = {}
end

function clearAwardItems(self)
    for i = 1, #self.mAwardItems do
        self.mAwardItems[i]:poolRecover()
    end
    self.mAwardItems = {}
end

return _M
