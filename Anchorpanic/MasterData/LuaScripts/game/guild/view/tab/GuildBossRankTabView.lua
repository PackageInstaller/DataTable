-- @FileName:   GuildBossRankTabView.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-06 20:20:48
-- @Copyright:   (LY) 2023 雷焰网络

module("guild.GuildBossRankTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("guild/tab/GuildBossRankTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)

end

function configUI(self)
    super.configUI(self)

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDamage = self:getChildGO("mTxtDamage"):GetComponent(ty.Text)
    self.mTxtInfoRankBig = self:getChildGO("mTxtInfoRankBig"):GetComponent(ty.Text)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtRank_02 = self:getChildGO("mTxtRank_02"):GetComponent(ty.Text)

    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(guild.GuildBossRankItem)
end

function initViewText(self)
    self.mTxtRank_02:GetComponent(ty.Text).text = _TT(161)

end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.ONRECEIVE_GUILDBOSS_RANK, self.refreshView, self)

    GameDispatcher:dispatchEvent(EventName.ONREQ_GUILDBOSS_RANK)
end

--非激活
function deActive(self)
    GameDispatcher:removeEventListener(EventName.ONRECEIVE_GUILDBOSS_RANK, self.refreshView, self)
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
end

function refreshView(self)
    local guildBossInfo = guild.GuildManager:getGuildBossRankInfo()
    if table.empty(guildBossInfo) then
        return
    end

    local selfRank = guildBossInfo.selfRank
    self.mTxtName.text = selfRank.guild_name
    self.mTxtDamage.text = selfRank.damage

    self.mTxtInfoRankBig.gameObject:SetActive(selfRank.rank <= 10 and selfRank.rank ~= 0)
    self.mTxtInfoRankBig.text = selfRank.rank

    self.mTxtRank.gameObject:SetActive(selfRank.rank > 10)
    self.mTxtRank_02.gameObject:SetActive(selfRank.rank <= 0)

    if selfRank.rank <= 3 and selfRank.rank > 0 then
        self.mTxtRank.text = ""
    elseif selfRank.rank <= 100 then
        self.mTxtRank.text = selfRank.rank
    else
        self.mTxtRank.text = "<size=24>" .. selfRank.rank .. "</size>"
    end

    local list = {}
    for i = 1, #guildBossInfo.allRank do
        table.insert(list, guildBossInfo.allRank[i])
    end

    table.sort(list, function(a, b)
        return a.rank < b.rank
    end)

    -- local len = math.min(4, #list)
    -- for i = 1, len do
    --     list[i].tweenId = i * 3.5
    -- end

    if (self.mScroller.Count <= 0) then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end
end

return _M
