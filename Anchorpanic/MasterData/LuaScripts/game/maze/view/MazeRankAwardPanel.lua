module("maze.MazeRankAwardPanel", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("maze/MazeRankAwardPanel.prefab")
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

    self.m_textAwardType = self:getChildGO("TextAwardType"):GetComponent(ty.Text)

    self.m_scroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.m_scroller:SetItemRender(maze.MazeRankAwardItem)

    self.m_leftGroupItem = self:getChildGO("LeftGroupItem").transform
    self.m_leftGroupItem2 = self:getChildGO("LeftGroupItem2").transform
    self.m_leftCurr = self:getChildGO("LeftImgCurr")

    self.m_rightAwardTitle = self:getChildGO("TextRightAwardTitle"):GetComponent(ty.Text)
    self.m_textTime = self:getChildGO("TextTime"):GetComponent(ty.Text)

    self.m_rightGroupItem = self:getChildGO("RightGroupItem").transform
    self.m_rightGroupItem2 = self:getChildGO("RightGroupItem2").transform
    self.m_rightCurr = self:getChildGO("RightImgCurr")
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
    
    -- self.m_textTime.text = _TT(46822, TimeUtil.getFormatTimeBySeconds_1(endTime))

    
    local currentTime = GameManager:getClientTime()
    local reamainTime = GameManager:getWeekResetTime() - currentTime
    self.m_textTime.text = _TT(46822,TimeUtil.getFormatTimeBySeconds_1(reamainTime))
end

function updateView(self, cusIsInit)
    local list = maze.MazeManager:getRankAwardList()
    local list2 = {}
    for i = 2, #list - 1 do
        table.insert(list2, list[i])
    end
    if (cusIsInit == nil or cusIsInit == true) then
        self.m_scroller.DataProvider = list2
    else
        self.m_scroller:ReplaceAllDataProvider(list2)
    end

    self:recoverAllGrid()

    local myRank = maze.MazeManager.myRank
    self.m_textAwardType.text = "排行奖励"

    local _propsGrid
    local awardVo = list[1]
    local rewards = AwardPackManager:getAwardListById(awardVo.rewards)
    for i = 1, #rewards do
        local vo = rewards[i]
        if (i == 1) then
            _propsGrid = PropsGrid:create(self.m_leftGroupItem, { vo.tid, vo.num }, 0.62)
        else
            _propsGrid = PropsGrid:create(self.m_leftGroupItem2, { vo.tid, vo.num }, 0.62)
        end

        table.insert(self.m_propsGridList, _propsGrid)
    end

    local lastRank = list[#list].leftRank
    self.m_rightAwardTitle.text = lastRank .. _TT(162)

    awardVo = list[#list]
    rewards = AwardPackManager:getAwardListById(awardVo.rewards)
    for i = 1, #rewards do
        local vo = rewards[i]
        if (i == 1) then
            _propsGrid = PropsGrid:create(self.m_rightGroupItem, { vo.tid, vo.num }, 0.62)
        else
            _propsGrid = PropsGrid:create(self.m_rightGroupItem2, { vo.tid, vo.num }, 0.62)
        end

        table.insert(self.m_propsGridList, _propsGrid)
    end

    self.m_leftCurr:SetActive(myRank == 1)
    self.m_rightCurr:SetActive(lastRank <= myRank)

    if (myRank > 1 and myRank < lastRank) then
        for i = 1, #list2 do
            local minRank = list2[i].left_rank
            local maxRank = list2[i].right_rank
            if (minRank <= myRank and myRank <= maxRank) then
                self.m_scroller:SetItemIndex(i, -312 + 58, 0, 0.3)
                break
            end
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
