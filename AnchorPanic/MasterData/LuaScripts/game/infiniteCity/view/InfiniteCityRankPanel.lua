--[[ 
-----------------------------------------------------
@filename       : InfiniteCityRankPanel
@Description    : 无限城无限榜界面
@date           : 2021-03-09 10:10:11
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.view.InfiniteCityRankPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityRankPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("common_bg_5.jpg", false)
end

-- 初始化数据
function initData(self)
end

function configUI(self)
    super.configUI(self)

    self.m_iconRankGo = self:getChildGO("IconRank")
    self.m_iconRank = self.m_iconRankGo:GetComponent(ty.AutoRefImage)
    self.m_textRank = self:getChildGO("TextRank"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("TextName"):GetComponent(ty.Text)
    self.m_textScore = self:getChildGO("TextScore"):GetComponent(ty.Text)
    self.m_headNode = self:getChildGO("HeadGridNode").transform

    self.m_scroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.m_scroller:SetItemRender(infiniteCity.InfiniteCityRankItem)

    self.m_textTileRank = self:getChildGO("TextRank"):GetComponent(ty.Text)
    self.m_textTileName = self:getChildGO("TextTitleName"):GetComponent(ty.Text)
    self.m_textTileScore = self:getChildGO("TextTitleScore"):GetComponent(ty.Text)

    self.m_textTips = self:getChildGO("TextTips"):GetComponent(ty.Text)

    self.m_textEmpty = self:getChildGO("TextEmpty"):GetComponent(ty.Text)
    self.m_groupEmpty = self:getChildGO("GroupEmpty")
    self.m_groupBottom = self:getChildGO("GroupBottom")
end


function initViewText(self)
    self.m_textTileRank.text = _TT(158)
    self.m_textTileName.text = _TT(160)
    self.m_textTileScore.text = _TT(159)
    self.m_textEmpty.text = _TT(27127)--"——  暂无排名  ——"

    self.m_textTips.text = _TT(27128)--"排行榜数据每30分钟刷新一次"
end
-- 设置货币栏
function setMoneyBar(self)
end

function active(self)
    super.active(self)

    -- infiniteCity.InfiniteCityManager:addEventListener(infiniteCity.InfiniteCityManager.EVENT_RANK_DATA_UPDATE, self.__updateView, self)
    rank.RankManager:addEventListener(rank.RankManager.EVENT_RANK_UPDATE, self.__updateView, self)
    -- 请求排行榜
    -- GameDispatcher:dispatchEvent(EventName.REQ_INFINITE_CITY_RANK, {})
    GameDispatcher:dispatchEvent(EventName.REQ_RANK_DATA, { type = rank.RankConst.RANK_INFINITE_CITY })
    self:__updateView()
end

function deActive(self)
    super.deActive(self)
    if (self.m_playerHeadGrid) then
        self.m_playerHeadGrid:poolRecover()
        self.m_playerHeadGrid = nil
    end
    -- infiniteCity.InfiniteCityManager:removeEventListener(infiniteCity.InfiniteCityManager.EVENT_RANK_DATA_UPDATE, self.__updateView, self)
    rank.RankManager:removeEventListener(rank.RankManager.EVENT_RANK_UPDATE, self.__updateView, self)

end

function __updateView(self)
    local infoVo = rank.RankManager:getRankInfoVo(rank.RankConst.RANK_INFINITE_CITY)
    local list = infoVo and infoVo.rankList
    -- local list = infiniteCity.InfiniteCityManager:getRankList()
    if not list or #list <= 0 then
        self.m_groupEmpty:SetActive(true)
        self.m_groupBottom:SetActive(false)
        return
    end
    self.m_groupEmpty:SetActive(false)
    self.m_groupBottom:SetActive(true)
    if self.m_scroller.Count <= 0 then
        self.m_scroller.DataProvider = list
    else
        self.m_scroller:ReplaceAllDataProvider(list)
    end

    if (not self.m_playerHeadGrid) then
        self.m_playerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.m_playerHeadGrid:setData(role.RoleManager:getRoleVo():getAvatarId())
    self.m_playerHeadGrid:setParent(self.m_headNode)
    self.m_playerHeadGrid:setScale(0.45)

    -- local myRank = infiniteCity.InfiniteCityManager.myRank
    local myRank = infoVo.myRank
    local url = UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_%s.png", (62 + myRank)))

    if myRank > 0 and myRank <= 3 then
        self.m_iconRankGo:SetActive(true)
        self.m_iconRank:SetImg(url, false)
        self.m_textRank.text = ""
    else
        self.m_iconRankGo:SetActive(false)
        -- self.m_textRank.text = myRank == 0 and "未上榜" or myRank
        self.m_textRank.text = myRank == 0 and _TT(161) or myRank
    end

    self.mTxtName.text = role.RoleManager:getRoleVo():getPlayerName()
    -- self.m_textScore.text = infiniteCity.InfiniteCityManager.myScore
    self.m_textScore.text = infoVo.myRankVal
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
