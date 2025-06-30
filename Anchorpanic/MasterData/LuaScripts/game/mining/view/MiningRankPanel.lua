--[[ 
-----------------------------------------------------
@filename       : MiningRankPanel
@Description    : 挖矿积分排行榜
@date           : 2023-12-14 16:21:58
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.mining.view.MiningRankPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("mining/MiningRankPanel.prefab")
panelType = -1-- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0--是否开启适配刘海 0 否 1 是

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(62203))
    self:setSize(0, 0)
end
-- 初始化数据
function initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mTxtMyRankBig = self:getChildGO("mTxtMyRankBig"):GetComponent(ty.Text)
    self.mTxtMyRank = self:getChildGO("mTxtMyRank"):GetComponent(ty.Text)
    self.mTxtMyName = self:getChildGO("mTxtMyName"):GetComponent(ty.Text)
    self.mTxtMyScore = self:getChildGO("mTxtMyScore"):GetComponent(ty.Text)
    self.mTxtMyGuild = self:getChildGO("mTxtMyGuild"):GetComponent(ty.Text)
    self.mMyHeadGridNode = self:getChildTrans("mMyHeadGridNode")
    --self.mTxtMyRankDec = self:getChildGO("mTxtMyRankDec"):GetComponent(ty.Text)
    --self.mImgSeasonDan = self:getChildGO("mImgSeasonDan"):GetComponent(ty.AutoRefImage)
    --self.mTxtSeasonDan = self:getChildGO("mTxtSeasonDan"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(mining.MiningRankItem)
    self.mTxtTilte_02 = self:getChildGO("mTxtTilte_02"):GetComponent(ty.Text)
    -- self.mTxtMyLayer = self:getChildGO("mTxtMyLayer"):GetComponent(ty.Text)
end


function initViewText(self)
    --self.mTxtMyRankDec.text = _TT(159)
    self.mTxtTilte_02.text = "当前排行"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function active(self)
    super.active(self)
    GameDispatcher:dispatchEvent(EventName.REQ_RANK_DATA, { type = rank.RankConst.RANK_MINING })

    rank.RankManager:addEventListener(rank.RankManager.EVENT_RANK_UPDATE, self.updateView, self)
    self:updateView()
end

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

function updateView(self)
    local rankData = rank.RankManager:getRankInfoVo(rank.RankConst.RANK_MINING)
    if not rankData then
        return
    end
    local list = rankData:getRankList()

    for i = 1, 4 do
        if list[i] then
            list[i].tweenId = i
        end
    end
    if (self.mScroller.Count <= 0) then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end
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

--段位不同显示图片
function onClickHeadHandler(self)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = role.RoleManager:getRoleVo().playerId })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]