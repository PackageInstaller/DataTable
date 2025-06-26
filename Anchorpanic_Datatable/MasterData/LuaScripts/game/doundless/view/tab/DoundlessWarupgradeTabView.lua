module("doundless.DoundlessWarupgradeTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("doundless/tab/DoundlessWarupgradeTabView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mPropsGrids = {}
end

function configUI(self)
    super.configUI(self)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mScrollReward = self:getChildGO("mScrollReward"):GetComponent(ty.LyScroller)
    self.mScrollReward:SetItemRender(doundless.DoundlessPromoteItem)
end

function active(self, args)
    super.active(self, args)
    self:updateRewardView()
    self:onGetEndTime()
end

function deActive(self)
    super.deActive(self)

    self:recoverTimer()
end

-- 获取赛季结束时间
function onGetEndTime(self)
    self.mEndTime =  GameManager:getWeekResetTime() --doundless.DoundlessManager:getDoundlessEndTime()
    self:recoverTimer()
    self:updateTime()
    self.endTimeSign = LoopManager:addTimer(1, 0, self, self.updateTime)
end

-- 定时器
function updateTime(self)
    local clientTime = GameManager:getClientTime()
    local remainTime = self.mEndTime - clientTime
    if (remainTime < 0) then
    else
        self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_1(remainTime)
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTxtRankTips"):GetComponent(ty.Text).text = _TT(97048)
    self:getChildGO("mTxtRewardTips"):GetComponent(ty.Text).text = _TT(97050)
end

function updateRewardView(self)
    --local warId = doundless.DoundlessManager:getServerWayId()
    --local cityVo = doundless.DoundlessManager:getDoundlessCityDataByWar(warId)
    local war1 = sysParam.SysParamManager:getValue(SysParamType.WARUP1)
    local war2 = sysParam.SysParamManager:getValue(SysParamType.WARUP2)
    local rewardList = {}
    table.insert(rewardList, {
        name = _TT(97030),
        award = war1
    })
    table.insert(rewardList, {
        name = _TT(97031),
        award = war2
    })

    for i = 1, 4 do
        if rewardList[i] then
            rewardList[i].tweenId = i * 2
        end
    end
    if self.mScrollReward.Count <= 0 then
        self.mScrollReward.DataProvider = rewardList
    else
        self.mScrollReward:ReplaceAllDataProvider(rewardList)
    end
end

function recoverTimer(self)
    if self.endTimeSign then
        LoopManager:removeTimerByIndex(self.endTimeSign)
        self.endTimeSign = nil
    end
end

return _M
