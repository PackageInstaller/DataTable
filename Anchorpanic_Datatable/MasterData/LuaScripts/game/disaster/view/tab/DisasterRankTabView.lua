
module("disaster.DisasterRankTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("disaster/tab/DisasterRankTabView.prefab")

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
    self.mTxtWar = self:getChildGO("mTxtWar"):GetComponent(ty.Text)
    self.mScrollReward = self:getChildGO("mScrollReward"):GetComponent(ty.LyScroller)
    self.mScrollReward:SetItemRender(disaster.DisasterRankItem)
    self.mTxtMyRankBig = self:getChildGO("mTxtMyRankBig"):GetComponent(ty.Text)
    --self.mAwardContent = self:getChildTrans("mAwardContent")

    self.mMyHeadContent = self:getChildTrans("mMyHeadContent")
    self.mTxtMyName = self:getChildGO("mTxtMyName"):GetComponent(ty.Text)
    self.mTxtMyPower = self:getChildGO("mTxtMyPower"):GetComponent(ty.Text)
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

    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
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
    self.mTxtWar.text =  disaster.DisasterManager:getDisasterWarTxt()
    local rewardList = disaster.DisasterManager:getDisasterList()
    table.sort(rewardList,function (data1,data2)
        return data1.rank < data2.rank
    end)
    -- for i = 1, 4 do
    --     rewardList[i].tweenId = i * 2
    -- end
    if self.mScrollReward.Count <= 0 then
        self.mScrollReward.DataProvider = rewardList
    else
        self.mScrollReward:ReplaceAllDataProvider(rewardList)
    end

    local rank = disaster.DisasterManager:getDisasterRank()
   
    if rank == 0 then
        self.mTxtMyRankBig.text = "<size=24>未上榜</size>"
    else
        self.mTxtMyRankBig.text = rank
    end

    if (not self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.mPlayerHeadGrid:setData(role.RoleManager:getRoleVo():getAvatarId())
    self.mPlayerHeadGrid:setParent(self.mMyHeadContent)
    self.mPlayerHeadGrid:setHeadFrame(role.RoleManager:getRoleVo():getAvatarFrameId())
    self.mPlayerHeadGrid:setScale(0.6)

    self.mTxtMyName.text = role.RoleManager:getRoleVo():getPlayerName()
    self.mTxtMyPower.text = disaster.DisasterManager:getAllFight()
    --self.mPlayerHeadGrid:setCallBack(self, self.onClickHeadHandler)
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
