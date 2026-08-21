--[[ 
-----------------------------------------------------
@filename       : DessertRankPanel
@Description    : 2048积分排行
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.Dessert.view.DessertRankPanel", Class.impl(View))

-- 对应的UI预制体
UIRes = UrlManager:getUIPrefabPath("dessert/DessertRankPanel.prefab")
panelType = -1-- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间，0表示关闭后立即销毁
isBlur = 1 -- 是否开启模糊背景（仅弹窗面板有效，默认开启，0关闭）
isAdapta = 0 -- 是否开启刘海屏适配，0关闭 1开启

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(62203))
    self:setSize(0, 0)
end
-- 初始化数据
function initData(self)
end

-- 初始化并缓存界面组件
function configUI(self)
    super.configUI(self)
    -- 我的排行信息
    self.mTxtMyRankBig = self:getChildGO("mTxtMyRankBig"):GetComponent(ty.Text)
    self.mTxtMyRank = self:getChildGO("mTxtMyRank"):GetComponent(ty.Text)
    self.mTxtMyName = self:getChildGO("mTxtMyName"):GetComponent(ty.Text)
    self.mTxtMyScore = self:getChildGO("mTxtMyScore"):GetComponent(ty.Text)
    self.mTxtMyGuild = self:getChildGO("mTxtMyGuild"):GetComponent(ty.Text)
    self.mMyHeadGridNode = self:getChildTrans("mMyHeadGridNode")

    -- 赛季段位相关显示，当前需求未启用
    --self.mTxtMyRankDec = self:getChildGO("mTxtMyRankDec"):GetComponent(ty.Text)
    --self.mImgSeasonDan = self:getChildGO("mImgSeasonDan"):GetComponent(ty.AutoRefImage)
    --self.mTxtSeasonDan = self:getChildGO("mTxtSeasonDan"):GetComponent(ty.Text)

    -- 排行榜滚动列表
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(dessert.DessertRankItem)
    self.mTxtTilte_02 = self:getChildGO("mTxtTilte_02"):GetComponent(ty.Text)
    -- self.mTxtMyLayer = self:getChildGO("mTxtMyLayer"):GetComponent(ty.Text)
end


function initViewText(self)
    --self.mTxtMyRankDec.text = _TT(159)
    -- 排行榜标题
    self.mTxtTilte_02.text = _TT(151207)
end

-- UI事件管理(关闭界面会自动移除
function addAllUIEvent(self)
end

-- 面板激活时请求排行榜数据并监听刷新
function active(self)
    super.active(self)
    GameDispatcher:dispatchEvent(EventName.REQ_RANK_DATA, { type = rank.RankConst.DESSERT })

    rank.RankManager:addEventListener(rank.RankManager.EVENT_RANK_UPDATE, self.updateView, self)
    self:updateView()
end

-- 面板关闭时移除监听并回收头像、列表资源
function deActive(self)
    super.deActive(self)
    rank.RankManager:removeEventListener(rank.RankManager.EVENT_RANK_UPDATE, self.updateView, self)

    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
end

-- 刷新排行榜列表和玩家自己的排行信息
function updateView(self)
    local rankData = rank.RankManager:getRankInfoVo(rank.RankConst.DESSERT)
    if not rankData then
        return
    end
    local list = rankData:getRankList()

    -- 前四名需要播放或显示特殊排行动效
    for i = 1, 4 do
        if list[i] then
            list[i].tweenId = i
        end
    end
    -- 首次赋值使用DataProvider，后续刷新替换全部数据
    if (self.mScroller.Count <= 0) then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end

    -- 重新创建玩家头像，避免旧头像框或头像数据残留
    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    if (not self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end

    local roleVo = role.RoleManager:getRoleVo()
    self.mPlayerHeadGrid:setData(roleVo:getAvatarId())
    self.mPlayerHeadGrid:setParent(self.mMyHeadGridNode)
    self.mPlayerHeadGrid:setHeadFrame(roleVo:getAvatarFrameId())
    self.mPlayerHeadGrid:setScale(1)
    self.mPlayerHeadGrid:setCallBack(self, self.onClickHeadHandler)
    local guildName = guild.GuildManager:getGuildName()
    self.mTxtMyGuild.text = guildName == "" and _TT(97053) or guildName
    local myRank = rankData.myRank

    -- local url = UrlManager:getArenaRankIconUrl(myRank)
    -- 根据玩家排名切换不同排行文本节点
    self.m_childGos["mImgColor2"]:SetActive(myRank < 4)
    self.mTxtMyRankBig.gameObject:SetActive(myRank <= 10 and myRank ~= 0)
    self.mTxtMyRank.gameObject:SetActive(myRank > 10)
    self.m_childGos["mTxtMyRank_02"]:SetActive(myRank <= 0)
    self.mTxtMyRankBig.text = myRank
    if myRank <= 0 then
        self.m_childGos["mTxtMyRank_02"]:GetComponent(ty.Text).text = _TT(161)
    elseif myRank <= 3 and myRank > 0 then
        self.mTxtMyRank.text = ""
    elseif myRank <= 100 then
        self.mTxtMyRank.text = myRank
    end
    self.mTxtMyName.text = roleVo:getPlayerName()
    self.mTxtMyScore.text = rankData.myRankVal
end

-- 点击玩家头像的回调，当前暂不打开角色信息面板
function onClickHeadHandler(self)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = role.RoleManager:getRoleVo().playerId })
end

return _M

--[[ 替换语言包自动生成，请勿修改?
]]
