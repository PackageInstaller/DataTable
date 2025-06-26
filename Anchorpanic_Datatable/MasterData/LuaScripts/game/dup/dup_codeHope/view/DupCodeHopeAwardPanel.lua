module("dup.DupCodeHopeAwardPanel", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("dupCodeHope/DupCodeHopeAwardPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.m_propsGridList = {}
end

function configUI(self)
    super.configUI(self)

    self.mTxtAwardType = self:getChildGO("TextAwardType"):GetComponent(ty.Text)

    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(dup.DupCodeHopeAwardItem)

    self.mLeftGroupItem = self:getChildGO("LeftGroupItem").transform
    self.mLeftGroupItem2 = self:getChildGO("LeftGroupItem2").transform
    self.mLeftCurr = self:getChildGO("LeftImgCurr")

    self.mRightAwardTitle = self:getChildGO("TextRightAwardTitle"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("TextTime"):GetComponent(ty.Text)

    self.mRightGroupItem = self:getChildGO("RightGroupItem").transform
    self.mRightGroupItem2 = self:getChildGO("RightGroupItem2").transform
    self.mRightCurr = self:getChildGO("RightImgCurr")
end

function active(self)
    super.active(self)
    self:updateView()

    self:addTimer(1, 0, self.onTimer)
    self:onTimer()
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

function recoverAllGrid(self)
    for i = 1, #self.m_propsGridList do
        self.m_propsGridList[i]:poolRecover()
    end
    self.m_propsGridList = {}
end

-- 点击切卡组
function onClickTabHandler(self, cusTabType)
    self:updateView()
end

function onTimer(self)
    -- local wday = tonumber(os.date("%w")) == 0 and 7 or tonumber(os.date("%w"))
    -- wday = (wday == 1 and tonumber(os.date("%H")) < 5) and 8 or wday 
    -- local endTime = ((8 - wday) * 24 * 3600) - os.date("%H") * 3600 - os.date("%M") * 60 - os.date("%S") + 5 * 3600
    -- self.mTxtTime.text = _TT(29142, TimeUtil.getFormatTimeBySeconds_1(endTime))

    local currentTime = GameManager:getClientTime()
    local reamainTime = GameManager:getWeekResetTime() - currentTime
    self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_1(reamainTime)
end

function updateView(self, cusIsInit)
    local list = dup.DupCodeHopeManager:getRewardList()
    local list2 = {}
    for i = 2, #list - 1 do
        table.insert(list2, list[i])
    end
    if (cusIsInit == nil or cusIsInit == true) then
        self.mScroller.DataProvider = list2
    else
        self.mScroller:ReplaceAllDataProvider(list2)
    end

    self:recoverAllGrid()

    local myRank = 0
    if (type == arena.ArenaAwardType.DAILY) then
        myRank = arena.ArenaManager.myDailyRank
    elseif (type == arena.ArenaAwardType.SEASON) then
        myRank = arena.ArenaManager.mySeasonRank
    end
    self.mTxtAwardType.text = _TT(29143)

    local propsGrid

    local awardVo = list[1]
    local rewards = AwardPackManager:getAwardListById(awardVo.rewards)
    for i = 1, #rewards do
        local vo = rewards[i]
        if (i == 1) then
            propsGrid = PropsGrid:create(self.mLeftGroupItem, { vo.tid, vo.num }, 0.62)
        else
            propsGrid = PropsGrid:create(self.mLeftGroupItem2, { vo.tid, vo.num }, 0.62)
        end

        table.insert(self.m_propsGridList, propsGrid)
    end

    local lastRank = list[#list].leftRank
    self.mRightAwardTitle.text = lastRank .. _TT(162)

    awardVo = list[#list]
    rewards = AwardPackManager:getAwardListById(awardVo.rewards)
    for i = 1, #rewards do
        local vo = rewards[i]
        if (i == 1) then
            propsGrid = PropsGrid:create(self.mRightGroupItem, { vo.tid, vo.num }, 0.62)
        else
            propsGrid = PropsGrid:create(self.mRightGroupItem2, { vo.tid, vo.num }, 0.62)
        end

        table.insert(self.m_propsGridList, propsGrid)
    end



    self.mLeftCurr:SetActive(myRank == 1)
    self.mRightCurr:SetActive(lastRank <= myRank)

    if (myRank > 1 and myRank < lastRank) then
        for i = 1, #list2 do
            local minRank = list2[i].left_rank
            local maxRank = list2[i].right_rank
            if (minRank <= myRank and myRank <= maxRank) then
                self.mScroller:SetItemIndex(i, -312 + 58, 0, 0.3)
                break
            end
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(29143):	"排行奖励"
]]
