--[[
-----------------------------------------------------
@filename       : GuildBossSeasonAwardTabView
@Description    : 巅峰竞技场奖励界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]

module("guild.GuildBossSeasonAwardTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("guild/tab/GuildBossSeasonAwardTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mPropsGrids = {}
end

function configUI(self)
    super.configUI(self)
    self.mGrouplist = self:getChildTrans("list")
    self.mDanAwardContent = self:getChildTrans('mDanAwardContent')
    self.mTxtCurDan = self:getChildGO("mTxtCurDan"):GetComponent(ty.Text)

    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mTxtTitleLeft = self:getChildGO("mTxtTitleLeft"):GetComponent(ty.Text)
    self.mTxtTile_01 = self:getChildGO("mTxtTile_01"):GetComponent(ty.Text)
    self.mTxt_02 = self:getChildGO("mTxt_02"):GetComponent(ty.Text)

    self.mScrollReward = self:getChildGO("mScrollReward"):GetComponent(ty.LyScroller)
    self.mScrollReward:SetItemRender(guild.GuildBossSeasonAwardItem)
end

function initViewText(self)
    self.mTxtTitleLeft.text = "当前排行"
    self.mTxtTile_01.text = "排行"

    self.mTxt_02.text = "(活动结束邮件发送)"
end

function active(self, args)
    super.active(self, args)

    self:updateRewardView()
    self:onGetEndTime()
end

function updateRewardView(self)
    local rewardList = guild.GuildManager:getGuildBossSeasonRewardConfigList()
    if self.mScrollReward.Count <= 0 then
        self.mScrollReward.DataProvider = rewardList
    else
        self.mScrollReward:ReplaceAllDataProvider(rewardList)
    end

    local guildBossInfo = guild.GuildManager:getGuildBossAllInfo()
    local curRank = guildBossInfo.guild_rank

    local curReward = nil
    for i = 1, #rewardList do
        if curRank == 0 then
            if curRank >= rewardList[i].maxRank then
                curReward = rewardList[i]
                break
            end
        else
            if curRank >= rewardList[i].minRank and curRank <= rewardList[i].maxRank then
                curReward = rewardList[i]
                break
            end
        end
    end

    if curRank <= 0 then
        self.mTxtCurDan.text = "<size=26>" .. _TT(161) .. "</size>"
    else
        self.mTxtCurDan.text = curRank
    end

    if curReward then
        self:clearProps()
        for _, vo in ipairs(curReward:getAwardlist()) do
            local propsGrid = PropsGrid:createByData({tid = vo.tid, num = vo.num, parent = self.mDanAwardContent, scale = 0.63, showUseInTip = true})
            table.insert(self.mPropsGrids, propsGrid)
        end
    end
end

--删除预制体
function clearProps(self)
    for i, _ in ipairs(self.mPropsGrids or {}) do
        self.mPropsGrids[i]:poolRecover()
    end
    self.mPropsGrids = {}
end

--获取赛季结束时间
function onGetEndTime(self)
    local bossOpenDt, bossEndDt = guild.GuildManager:getGuildBossOpenEndTimeDt()
    self.mBossEndDt = bossEndDt
    self.mBossOpenDt = bossOpenDt

    self:updateTime()
    self:recoverTimer()
    self.endTimeSign = LoopManager:addTimer(1, 0, self, self.updateTime)
end

function recoverTimer(self)
    if self.endTimeSign then
        LoopManager:removeTimerByIndex(self.endTimeSign)
        self.endTimeSign = nil
    end
end

--定时器
function updateTime(self)
    if self.mBossOpenDt ~= nil and self.mBossEndDt ~= nil then
        local curClientDt = GameManager:getClientTime()
        if curClientDt < self.mBossOpenDt then
            self.mTxtTime.text = _TT(94501) .. TimeUtil.getNewRoleShowTime(self.mBossOpenDt - curClientDt)
        elseif curClientDt < self.mBossEndDt then
            self.mTxtTime.text = _TT(94502) .. TimeUtil.getNewRoleShowTime(self.mBossEndDt - curClientDt)
        elseif curClientDt > self.mBossEndDt then
            self.mTxtTime.text = _TT(94503)
        end
    else
        self.mTxtTime.text = _TT(94503)
    end
end

function deActive(self)
    super.deActive(self)
    self:clearProps()
    self:recoverTimer()
end

return _M
