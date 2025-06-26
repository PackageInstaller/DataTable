module("dup.DupImpliedRankPanel", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("dupImplied/DupImpliedRankPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
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
    self.m_scroller:SetItemRender(dup.DupImpliedRankItem)

    self.m_textTileRank = self:getChildGO("TextRank"):GetComponent(ty.Text)
    self.m_textTileName = self:getChildGO("TextTitleName"):GetComponent(ty.Text)
    self.m_textTileScore = self:getChildGO("TextTitleScore"):GetComponent(ty.Text)
end


function initViewText(self)
    self.m_textTileRank.text = _TT(158)
    self.m_textTileName.text = _TT(160)
    self.m_textTileScore.text = _TT(159)--"通关时长"
end

function active(self)
    super.active(self)

    dup.DupImpliedManager:addEventListener(dup.DupImpliedManager.EVENT_IMPLIED_RANK_UPDATE, self.__updateView, self)
    -- 请求排行榜面板内容
    GameDispatcher:dispatchEvent(EventName.REQ_DUP_IMPLIED_RANK_DATA)
    self:__updateView()
end

function deActive(self)
    super.deActive(self)
    if (self.m_playerHeadGrid) then
        self.m_playerHeadGrid:poolRecover()
        self.m_playerHeadGrid = nil
    end
    dup.DupImpliedManager:removeEventListener(dup.DupImpliedManager.EVENT_IMPLIED_RANK_UPDATE, self.__updateView, self)

end

function __updateView(self, cusIsInit)
    if not dup.DupImpliedManager.myRank then
        return
    end
    local list = dup.DupImpliedManager:getRankList()
    if (cusIsInit == nil or cusIsInit == true) then
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

    local myRank = dup.DupImpliedManager.myRank
    local url = UrlManager:getArenaRankIconUrl(myRank)
    if (url) then
        self.m_iconRankGo:SetActive(true)
        self.m_iconRank:SetImg(url, false)
        self.m_textRank.text = ""
    else
        self.m_iconRankGo:SetActive(false)
        self.m_textRank.text = myRank == 0 and _TT(29144) or myRank
    end

    self.mTxtName.text = role.RoleManager:getRoleVo():getPlayerName()
    self.m_textScore.text = TimeUtil.getMSByTime(dup.DupImpliedManager.myPassTime)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
