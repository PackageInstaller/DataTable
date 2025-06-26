module("infiniteCity.InfiniteCityRankItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.m_imgBg = self:getChildGO("ImgBg"):GetComponent(ty.Image)
    self.m_iconRankGo = self:getChildGO("IconRank")
    self.m_iconRank = self.m_iconRankGo:GetComponent(ty.AutoRefImage)
    self.m_textRank = self:getChildGO("TextRank"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("TextName"):GetComponent(ty.Text)
    self.m_textScore = self:getChildGO("TextScore"):GetComponent(ty.Text)

    self.m_headNode = self:getChildTrans("HeadGridNode")

    self.mGroup = self:getChildGO("mGroup")
end

function setData(self, param)
    super.setData(self, param)
    if table.nums(self.data) == 0 then
        -- 尾部补充item
        self.mGroup:SetActive(false)
        return
    end
    self.mGroup:SetActive(true)

    local rankData = self.data

    if (not self.m_playerHeadGrid) then
        self.m_playerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.m_playerHeadGrid:setData(rankData.avatar)
    self.m_playerHeadGrid:setParent(self.m_headNode)
    self.m_playerHeadGrid:setScale(0.35)
    self.m_playerHeadGrid:setHeadFrame(rankData.frame)

    local url = UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_%s.png", (62 + rankData.rank)))
    if (url) then
        self.m_iconRankGo:SetActive(true)
        self.m_iconRank:SetImg(url, false)
        self.m_textRank.text = ""
    else
        self.m_iconRankGo:SetActive(false)
        self.m_textRank.text = rankData.rank
    end
    self.mTxtName.text = rankData.playerName
    self.m_textScore.text = rankData.rankVal

    self.m_imgBg.color = gs.ColorUtil.GetColor(rankData.rank % 2 == 0 and "474d56FF" or "2a2d33FF")
end

function deActive(self)
    super.deActive(self)
    if (self.m_playerHeadGrid) then
        self.m_playerHeadGrid:poolRecover()
        self.m_playerHeadGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
