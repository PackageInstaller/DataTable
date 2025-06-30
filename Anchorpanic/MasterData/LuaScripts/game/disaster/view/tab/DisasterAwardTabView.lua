module("disaster.DisasterAwardTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("disaster/tab/DisasterAwardTabView.prefab")

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
    -- self.mListTrans = self:getChildTrans("mList")
    self.mScrollReward = self:getChildGO("mScrollReward"):GetComponent(ty.LyScroller)
    self.mScrollReward:SetItemRender(disaster.DisasterAwardItem)
    self.mTxtMyRankSmall = self:getChildGO("mTxtMyRankSmall"):GetComponent(ty.Text)
    self.mTxtMyRankBig = self:getChildGO("mTxtMyRankBig"):GetComponent(ty.Text)
    self.mAwardContent = self:getChildTrans("mAwardContent")
end

function active(self, args)
    super.active(self, args)
    self:updateRewardView()
    self:onGetEndTime()
end

function deActive(self)
    super.deActive(self)
    self:clearProps()
    self:recoverTimer()
end

-- 获取赛季结束时间
function onGetEndTime(self)
    self.mEndTime = disaster.DisasterManager:getDisasterOverTime() -- doundless.DoundlessManager:getDoundlessEndTime()
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
        self.mTxtTime.text = _TT(104021,TimeUtil.getFormatTimeBySeconds_1(remainTime)) 
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

function updateRewardView(self)
    -- local filterType = self:getType()
    -- if not self.mPropsGrids then
    --     self.mPropsGrids = {}
    -- end
    -- self:clearProps()

    -- local warId = doundless.DoundlessManager:getServerWayId()
    -- local cityVo = doundless.DoundlessManager:getDoundlessCityDataByWar(warId)
    local rewardList = disaster.DisasterManager:getDisasterRankAwardData()
    -- local rewardList = cityVo:getCityRewardsData(filterType)

    for i = 1, 4 do
        rewardList[i].tweenId = i * 2
    end
    if self.mScrollReward.Count <= 0 then
        self.mScrollReward.DataProvider = rewardList
    else
        self.mScrollReward:ReplaceAllDataProvider(rewardList)
    end

    local rank = disaster.DisasterManager:getMyRank()

    self.mTxtMyRankSmall.gameObject:SetActive(rank > 3 or rank <= 0)
    self.mTxtMyRankBig.gameObject:SetActive(rank <= 3 and rank > 0)
    if rank <= 0 then
        self.mTxtMyRankSmall.text = "<size=26>" .. _TT(161) .. "</size>"
    elseif rank <= 3 then
        self.mTxtMyRankBig.text = rank
    else
        self.mTxtMyRankSmall.text = rank
    end

    local rewId = 0
    for i = 1, #rewardList do
        if rewardList[i].leftRank <= rank and rewardList[i].rightRank >= rank then
            rewId = rewardList[i].rewards
        elseif rewardList[i].rightRank == rank and rank == 0 and tonumber(disaster.DisasterManager:getAllFight()) > 0 then
            rewId = disaster.DisasterManager:getLowRankAwardData().rewards
        end
    end

    if rank == 0 then
        self.mTxtMyRankSmall.text = "<size=24>未上榜</size>"
    end

    if rewId > 0 then
        local playerList = AwardPackManager:getAwardListById(rewId)
        for _, vo in ipairs(playerList) do
            local propsGrid = PropsGrid:createByData({
                tid = vo.tid,
                num = vo.num,
                parent = self.mAwardContent,
                scale = 1.4,
                showUseInTip = true
            })
            table.insert(self.mPropsGrids, propsGrid)
        end
    -- else
    --     self.mTxtMyRankSmall.text = "<size=24>未上榜</size>"
    end

end

-- 删除预制体
function clearProps(self)
    if #self.mPropsGrids > 0 then
        for i, _ in ipairs(self.mPropsGrids) do
            self.mPropsGrids[i]:poolRecover()
        end
        self.mPropsGrids = {}
    end
end

function recoverTimer(self)
    if self.endTimeSign then
        LoopManager:removeTimerByIndex(self.endTimeSign)
        self.endTimeSign = nil
    end
end

return _M
