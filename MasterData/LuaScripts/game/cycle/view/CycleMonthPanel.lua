module("cycle.CycleMonthPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleMonthPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.awardPropsList = {}
    self.itemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtRemTimer = self:getChildGO("mTxtRemTimer"):GetComponent(ty.Text)
    self.mTxtTitle1 = self:getChildGO("mTxtTitle1"):GetComponent(ty.Text)
    self.mTxtTitle2 = self:getChildGO("mTxtTitle2"):GetComponent(ty.Text)
    self.mTxtTitle3 = self:getChildGO("mTxtTitle3"):GetComponent(ty.Text)
    self.mTxtAllPoint = self:getChildGO("mTxtAllPoint"):GetComponent(ty.Text)

    self.mTaskScroll = self:getChildGO("mTaskScroll"):GetComponent(ty.ScrollRect)
    self.mItem = self:getChildGO("mItem")
    self.mItem:SetActive(false)
end

function initViewText(self)
    self.mTxtTitle1.text = _TT(77985)
    self.mTxtTitle2.text = _TT(77986)
    self.mTxtTitle3.text = _TT(77988)
end

function updateTime(self)
    local clientTime = GameManager:getClientTime()
    local endTime = cycle.CycleManager:getCycleMonthEndTime()
    local remTime = endTime - clientTime
    if remTime > 0 then
        self.mTxtRemTimer.text = _TT(77989)..TimeUtil.getFormatTimeBySeconds_9(remTime)
    else
        self:close()
    end
end

-- 激活
function active(self, args)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_MONTH_PANEL,self.showPanel,self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_MONTH_PANEL,self.showPanel,self)
    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end
    self:clearItems()
end

function showPanel(self)
    self:clearItems()
    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    self:updateTime()
    self.updateTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)

    local curPoint = cycle.CycleManager:getCycleMonthPoint()
    local maxPoint = cycle.CycleManager:getCycleMonthMaxPoint()
    if curPoint > maxPoint then
        curPoint = maxPoint
    end
    self.mTxtAllPoint.text = _TT(77987, curPoint, maxPoint)

    local list = cycle.CycleManager:getCycleMonthRewardData()
    for i = 1, #list, 1 do
        local item = SimpleInsItem:create(self.mItem,self.mTaskScroll.content,"cycleMonthTaskItem")
        local awardPropsVo = list[i].reward[1]
        local grid = PropsGrid:createByData({ tid = awardPropsVo[1], num = awardPropsVo[2], parent = item:getChildTrans("mContentProps") ,scale = 0.8})
        local top = 80
        local bot = -85
        if i <=5 then
            local index = i%5
          
            if index == 1 then
                top = 100
                bot = -95
            elseif index == 2 then
                top = 50
                bot = -38
            elseif index == 3 then
                top = 0
                bot = 8
            elseif index == 4 then
                top = 50
                bot = -38
            elseif index ==0 then 
                top = 100
                bot = -95
            end
        else
            local index = (i - 5)%4
            if index == 1 then
                top = 50
                bot = -38
            elseif index == 2 then
                top = 0
                bot = 8
            elseif index == 3 then
                top = 50
                bot = -38
            elseif index == 0 then
                top = 100
                bot = -95
            end
        end
        item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text = list[i].id
        item:getChildGO("mPropsContent"):GetComponent(ty.VerticalLayoutGroup).padding.top = top
        item:getChildGO("mPropsContent"):GetComponent(ty.VerticalLayoutGroup).padding.bottom = bot

        -- item:getChildGO("mPropsContentGeted"):GetComponent(ty.VerticalLayoutGroup).padding.top = top
        -- item:getChildGO("mPropsContentGeted"):GetComponent(ty.VerticalLayoutGroup).padding.bottom = bot

        local isLock = list[i].id > curPoint
        local isGain = cycle.CycleManager:getGainedList(list[i].id)
        item:getChildGO("mImgLock"):SetActive(isLock)
        item:getChildGO("mImgGeted"):SetActive(isGain)
        item:getChildGO("mPropsTransGeted"):SetActive(isLock or isGain)

        item:getChildGO("mImgLine"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("cycle/"..list[i].icon),false)
        item:getChildGO("mImgLinePro"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("cycle/"..list[i].icon),false)
        if list[i].id == curPoint then
            item:getChildGO("mImgLinePro"):GetComponent(ty.AutoRefImage).fillAmount = 0.5
        elseif list[i].id < curPoint then
            item:getChildGO("mImgLinePro"):GetComponent(ty.AutoRefImage).fillAmount = 1
        elseif list[i].id > curPoint then
            item:getChildGO("mImgLinePro"):GetComponent(ty.AutoRefImage).fillAmount = 0
        end

        item:getChildGO("mImgPointPro"):SetActive(list[i].id <= curPoint)
        item:getChildGO("mBtnGet"):SetActive(not isLock and not isGain)
        item:addUIEvent("mBtnGet",function()
            if not isLock and not isGain then
                GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_MONTH_REWARD)
            end
        end)
        table.insert(self.awardPropsList, grid)
        table.insert(self.itemList, item)
    end
end

function clearItems(self)
    for i = 1, #self.awardPropsList, 1 do
        self.awardPropsList[i]:poolRecover()
    end
    self.awardPropsList = {}
    for i = 1, #self.itemList, 1 do
        self.itemList[i]:poolRecover()
    end
    self.itemList = {}
end


return _M