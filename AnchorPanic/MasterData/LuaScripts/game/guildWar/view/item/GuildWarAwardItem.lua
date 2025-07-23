module("guildWar.GuildWarAwardItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mContent = self:getChildTrans("mContent")
    self.mGroupRank = self:getChildGO("mGroupRank")
    self.mGroupAward = self:getChildGO("mGroupAward")
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtRankBig = self:getChildGO("mTxtRankBig"):GetComponent(ty.Text)
    --self.mTxtRankDec = self:getChildGO("mTxtRankDec"):GetComponent(ty.Text)
    --self.mTxtInterval = self:getChildGO("mTxtInterval"):GetComponent(ty.Text)
    --self.mImgIcon = self:getChildGO("mImgIcon_01"):GetComponent(ty.AutoRefImage)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mPropsGridList = {}
end

function setData(self, param)
    super.setData(self, param)
    self:recoverAllGrid()
    local list = {}

    list = AwardPackManager:getAwardListById(self.data.rewards)

    if #list > 0 then
        for i, vo in ipairs(list) do
            local propsGrid = PropsGrid:createByData({
                tid = vo.tid,
                num = vo.num,
                parent = self.mContent,
                scale = 1.4,
                showUseInTip = true
            })
            table.insert(self.mPropsGridList, propsGrid)
        end
    end
    -- self.mGroupRank:SetActive(self.data.type == arena.ArenaAwardType.RANKAWARD)
    -- self.mGroupAward:SetActive(self.data.type ~= arena.ArenaAwardType.RANKAWARD)
   
    local isTop = self.data.leftRank == self.data.rightRank and self.data.rightRank <= 3
    self.m_childGos["mTxtRank"]:SetActive(not isTop)
    self.mTxtRank.gameObject:SetActive(not isTop)
    self.mTxtRankBig.gameObject:SetActive(isTop)
    self.mImgColor.gameObject:SetActive(isTop)
    if isTop then
        self.mTxtRankBig.text = self.data.leftRank
        self.m_childGos["mTop"]:SetActive(true)
        local color
        for i = 1, 3 do
            self.m_childGos["mTop" .. i]:SetActive(self.data.leftRank == i and self.data.rightRank == i)
        end

        if self.data.leftRank == 1 then
            color = "ffc66dff"
        elseif self.data.leftRank == 2 then
            color = "D376f9ff"
        elseif self.data.leftRank == 3 then
            color = "6dbcffff"
        end

        self.mImgColor.color = gs.ColorUtil.GetColor(color)
    else
        self.m_childGos["mTop"]:SetActive(false)
    end
    self.mTxtRank.text = self.data:getRankDifference()
end

function recoverAllGrid(self)
    if #self.mPropsGridList > 0 then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
        self.mPropsGridList = {}
    end
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

function onDelete(self)
    super.onDelete(self)
end

return _M