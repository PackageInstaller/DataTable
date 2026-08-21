--[[ 
-----------------------------------------------------
@filename       : DailyRechargePanel
@Description    : 每日充值
@date           : 2026-06-01
@Author         : auto
@copyright      : (LY) 雷焰网络
-----------------------------------------------------
]] module("dailyRecharge.DailyRechargePanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dailyRecharge/DailyRechargePanel.prefab")

destroyTime = 0
panelType = -1
isBlur = 0
escapeClose = 1

function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)
    -- 任务条目缓存，关闭或刷新时回收
    self.mTaskList = {}
    -- 奖励格子缓存，关闭或刷新时回收
    self.mPropsGrid = {}
end

function configUI(self)
    super.configUI(self)

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnClose2 = self:getChildGO("mBtnClose2")
    self.mBtnList = {self:getChildGO("mBtn1"), self:getChildGO("mBtn2"), self:getChildGO("mBtn3")}
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtAll = self:getChildGO("mTxtAll"):GetComponent(ty.Text)

    self.mIconImg = self:getChildGO("mIconImg"):GetComponent(ty.AutoRefImage)
    self.mTxtPrice = self:getChildGO("mTxtPrice"):GetComponent(ty.Text)
    self.mTxtLim = self:getChildGO("mTxtLim"):GetComponent(ty.Text)
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mBtnGet = self:getChildGO("mBtnGet")

    self.mTxtRemTime = self:getChildGO("mTxtRemTime"):GetComponent(ty.Text)

    self.mScrollView = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)
    self.mTaskItem = self:getChildGO("mTaskItem")

    self.mGeted = self:getChildGO("mGeted")
end

function active(self, args)
    super.active(self, args)
    -- 监听领取成功或服务端数据刷新后更新面板
    GameDispatcher:addEventListener(EventName.UPDATE_DAILY_RECHARGE_PANEL, self.updateInfo, self)
    StorageUtil:saveBool0(gstor.FIRST_DAILY_RECHARGE, true)
    dailyRecharge.DailyRechargeManager:updateRed()
    self.defIndex = 1
    self:showPanel()
    self:updateTime()
    -- 每秒刷新活动剩余时间
    self:addTimer(1, 0, self.updateTime)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DAILY_RECHARGE_PANEL, self.updateInfo, self)
    self:removeTimer(self.updateTime)
    -- 清理页签红点，避免复用时残留
    for i = 1, #self.mBtnList, 1 do
        RedPointManager:remove(self.mBtnList[i].transform)
    end
    self:clearPropsGrid()
    self:clearTaskList()
end

function initViewText(self)
    self.mTxtLim.text = "每日限购"
end

function addAllUIEvent(self)
    for i = 1, #self.mBtnList, 1 do
        self:addUIEvent(self.mBtnList[i], self.onBtnClick, nil, i)
    end

    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnClose2,self.onClickClose)
    self:addUIEvent(self.mBtnGet, self.onClickGet)
end

-- 点击购买按钮，打开当前档位绑定的直购礼包界面
function onClickGet(self)
    local vo = dailyRecharge.DailyRechargeManager:getDailyRechargeConfigVo(self.defIndex)
    local directBuyVo = vo and purchase.DirectBuyManager:getDirectBuyVoById(vo.sellGiftId)
    if directBuyVo then
        GameDispatcher:dispatchEvent(EventName.OPEN_DIRECT_BUY_MONEY_PANEL, directBuyVo)
    end
end

-- 切换充值档位页签
function onBtnClick(self, index)
    self.defIndex = index
    self:updateInfo()
end

-- 初始化页签文案并刷新默认档位内容
function showPanel(self)
    local list = dailyRecharge.DailyRechargeManager:getDailyRechargeConfigList()
    for i = 1, #list, 1 do
        self.mBtnList[i].transform:Find("mTxt"):GetComponent(ty.Text).text = _TT(153104 + i)
    end
    self:updateInfo()
end

-- 刷新当前档位的礼包信息、累计充值金额与奖励列表
function updateInfo(self)
    for i = 1, #self.mBtnList, 1 do
        self.mBtnList[i].transform:Find("mSelect").gameObject:SetActive(i == self.defIndex)
    end
    self:clearPropsGrid()
    self:clearTaskList()
    self:updateRed()

    local vo = dailyRecharge.DailyRechargeManager:getDailyRechargeConfigVo(self.defIndex)
    -- 左侧礼包信息取配置 sellGiftId 对应的直购礼包数据
    local directBuyVo = purchase.DirectBuyManager:getDirectBuyVoById(vo.sellGiftId)
    if directBuyVo then
        self.mIconImg:SetImg(UrlManager:getPropsIconUrl(directBuyVo:getItemTid()), true)
        self.mTxtPrice.text = directBuyVo:getPayType() == MoneyType.MONEY and _TT(50011, directBuyVo:getPrice()) or directBuyVo:getPrice()
    
        local limitNum = directBuyVo:getLimit()
        local hadBuyNum = purchase.DirectBuyManager:getHadBuyNum(directBuyVo:getId())
        -- 无限购显示 ∞，限购显示剩余次数/总次数
        if limitNum == 0 and directBuyVo:getLimitType() == purchase.DirectBuyLimitType.UN_LIMIT then
            self.mTxtCount.text = "∞"
        else
            self.mTxtCount.text = _TT(45013,math.max(limitNum - hadBuyNum, 0),limitNum) 
        end
        
        self.mGeted:SetActive(limitNum - hadBuyNum == 0)
    end
    -- 今日累计充值金额按元展示
    self.mTxtAll.text = _TT(153104, dailyRecharge.DailyRechargeManager:getTodayPay() / 100)

    
    

    -- 按服务端领取状态生成展示列表：可领取 > 进行中 > 已领取，同状态按天数升序
    local showList = {}
    for i = 1, #vo.payReward, 1 do
        local serverData = dailyRecharge.DailyRechargeManager:getDailyRechargeData(self.defIndex, i)
        local state = serverData and serverData.state or 0
        table.insert(showList, { day = i, state = state })
    end
    table.sort(showList, function(data1, data2)
        local sort1 = data1.state == 1 and 1 or data1.state == 2 and 3 or 2
        local sort2 = data2.state == 1 and 1 or data2.state == 2 and 3 or 2
        if sort1 == sort2 then
            return data1.day < data2.day
        end
        return sort1 < sort2
    end)

    for i = 1, #showList, 1 do
        local data = showList[i]
        local day = data.day
        local item = SimpleInsItem:create(self.mTaskItem, self.mScrollView.content, "dailyRechargeItem")
        local price = math.floor(vo.leftNum / 100)
        item:getChildGO("mTxtTaskDes"):GetComponent(ty.Text).text = _TT(153103, day, price)
        local state = data.state
        local isCanGain = state == 1
        local isRecived = state == 2

        item:getChildGO("mTxtGet"):GetComponent(ty.Text).text = _TT(3)

        -- state: 0/空=进行中，1=可领取，2=已领取
        item:getChildGO("mBtnRecive"):SetActive(isCanGain)
        item:getChildGO("mImgRecived"):SetActive(isRecived)
        item:getChildGO("mImgIng"):SetActive(not isCanGain and not isRecived)
        item:addUIEvent("mImgIng",function ()
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.DirectBuy })
            self:close()
        end)
        item:addUIEvent("mBtnRecive", function()
            GameDispatcher:dispatchEvent(EventName.REQ_DAILY_RECHARGE_GAIN_AWARD, { gear = self.defIndex, day = day })
        end)
        -- 创建每日奖励道具格子
        local rewardList = vo:getPayRewardByDay(day)
        for j = 1, #rewardList, 1 do
            local propsGrid = PropsGrid:createByData({
                tid = rewardList[j][1],
                num = rewardList[j][2],
                parent = item:getChildTrans("mAwardTrans"),
                scale = 0.8,
                showUseInTip = true
            })
            table.insert(self.mPropsGrid, propsGrid)
        end

        table.insert(self.mTaskList, item)

    end
end

-- 刷新活动剩余时间；活动结束或不存在时关闭面板
function updateTime(self)
    local activityVo = activity.ActivityManager:getActivityVoById(activity.ActivityId.DailyRecharge)
    if activityVo then
        local remainingTime = activityVo:getEndTime() - GameManager:getClientTime()
        self.mTxtRemTime.text = remainingTime <= 0 and "活动已结束" or _TT(3530) .. TimeUtil.getFormatTimeBySeconds_9(remainingTime)
        if remainingTime <= 0 then
            self:removeTimer(self.updateTime)
            self:close()
        end
    else
        self:removeTimer(self.updateTime)
        self:close()
    end
end

-- 刷新各档位页签可领取红点
function updateRed(self)
    for i = 1, #self.mBtnList, 1 do
        if dailyRecharge.DailyRechargeManager:getIsCanGainByGear(i) then
            RedPointManager:add(self.mBtnList[i].transform, nil, -64.5, 14)
        else
            RedPointManager:remove(self.mBtnList[i].transform)
        end
    end
end

-- 回收每日奖励任务条目
function clearTaskList(self)
    for i = 1, #self.mTaskList, 1 do
        self.mTaskList[i]:poolRecover()
    end
    self.mTaskList = {}
end

-- 回收奖励道具格子
function clearPropsGrid(self)
    for i = 1, #self.mPropsGrid, 1 do
        self.mPropsGrid[i]:poolRecover()
    end
    self.mPropsGrid = {}

end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]
