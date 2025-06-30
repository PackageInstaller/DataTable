module("arena.ArenaAwardItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mContent = self:getChildTrans("mContent")
    self.mGroupRank = self:getChildGO("mGroupRank")
    self.mGroupAward = self:getChildGO("mGroupAward")
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtRankBig = self:getChildGO("mTxtRankBig"):GetComponent(ty.Text)
    self.mTxtRankDec = self:getChildGO("mTxtRankDec"):GetComponent(ty.Text)
    self.mTxtInterval = self:getChildGO("mTxtInterval"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon_01"):GetComponent(ty.AutoRefImage)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mPropsGridList = {}
    self.mTxtRankDec.text = _TT(158)
    self.mTxtRank_03 = self:getChildGO("mTxtRank_03"):GetComponent(ty.Text)
end

function setData(self, param)
    super.setData(self, param)
    self:recoverAllGrid()
    local list = {}
    if self.data.type == arena.ArenaAwardType.RANKAWARD then
        list = self.data:getAwardlist()
    else
        list = self.data:getAwardList(self.data.type)
    end
    if #list > 0 then
        for i, vo in ipairs(list) do
            local propsGrid = PropsGrid:createByData({ tid = vo.tid, num = vo.num, parent = self.mContent, scale = 1.4, showUseInTip = true })
            table.insert(self.mPropsGridList, propsGrid)
        end
    end
    self.mGroupRank:SetActive(self.data.type == arena.ArenaAwardType.RANKAWARD)
    self.mGroupAward:SetActive(self.data.type ~= arena.ArenaAwardType.RANKAWARD)
    self.mTxtRank.gameObject:SetActive(true)
    self.mTxtInterval.gameObject:SetActive(self.data.type ~= arena.ArenaAwardType.RANKAWARD)
    if self.data.type ~= arena.ArenaAwardType.RANKAWARD then
        self.mTxtInterval.text = self.data:getScoreInterval();
        self.mTxtRank.text = _TT(self.data.rankName)
        self.mImgIcon:SetImg(self.data:getRankIcon(), false)
        self.m_childGos["mTxtRank_03"]:SetActive(false)
    else
        local isTop = self.data.leftRank == self.data.rightRank
        self.m_childGos["mTxtRank_03"]:SetActive(not isTop)
        self.mTxtRank.gameObject:SetActive(false)
        self.mTxtRankBig.gameObject:SetActive(isTop)
        self.mImgColor.gameObject:SetActive(isTop)
        if isTop then
            self.mTxtRankBig.text = self.data.leftRank


            -- self.mTxtRankBig.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(self.data.leftRank))
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
        self.mTxtRank_03.text = self.data:getRankDifference()
    end

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

--[[ 替换语言包自动生成，请勿修改！
]]