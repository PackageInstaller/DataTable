module("maze.MazeRankAwardItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

	self.m_textRank = self:getChildGO("ItemTextRank"):GetComponent(ty.Text)
    self.m_mask = self:getChildGO("ItemImgMask")
    self.m_curr = self:getChildGO("ItemImgCurr")
    self.m_groupAward = self:getChildGO("ItemGroupItem").transform
    self.m_groupAward2 = self:getChildGO("ItemGroupItem2").transform
    
    self.m_propsGridList = {}
end

function setData(self, param)
    super.setData(self, param)
    self:recoverAllGrid()

    local arenaRewardDataRo = self.data
    local minRank = arenaRewardDataRo.leftRank
    local maxRank = arenaRewardDataRo.rightRank

    if(minRank == maxRank) then
        self.m_textRank.text = minRank
    else
        self.m_textRank.text = minRank .. "-" .. maxRank
    end
    local myRank = 0
    if(param.type == arena.ArenaAwardType.DAILY)then
        myRank = arena.ArenaManager.myDailyRank
    elseif(param.type == arena.ArenaAwardType.SEASON)then
        myRank = arena.ArenaManager.mySeasonRank
    end

    if(minRank<=myRank and myRank<=maxRank)then
        self.m_mask:SetActive(false)
        self.m_curr:SetActive(true)
    else
        self.m_mask:SetActive(true)
        self.m_curr:SetActive(false)
    end

    local list = AwardPackManager:getAwardListById(arenaRewardDataRo.rewards)
    for i = 1, #list do
        local vo = list[i]
        local _propsGrid
        if(i == 1)then
            _propsGrid = PropsGrid:create(self.m_groupAward, {vo.tid, vo.num}, 0.62)
        else
            _propsGrid = PropsGrid:create(self.m_groupAward2, {vo.tid, vo.num}, 0.62)
        end

        table.insert(self.m_propsGridList, _propsGrid)
    end
end

function recoverAllGrid(self)
    for i = 1, #self.m_propsGridList do
        local propsGrid = self.m_propsGridList[i]
        propsGrid:poolRecover()
    end
    self.m_propsGridList = {}
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
