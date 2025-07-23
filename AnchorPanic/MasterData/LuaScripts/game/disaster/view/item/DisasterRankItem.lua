module("disaster.DisasterRankItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mContent = self:getChildTrans("mContent")
    self.mGroupRank = self:getChildGO("mGroupRank")
    self.mGroupAward = self:getChildGO("mGroupAward")
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtRankBig = self:getChildGO("mTxtRankBig"):GetComponent(ty.Text)
    -- self.mTxtRankDec = self:getChildGO("mTxtRankDec"):GetComponent(ty.Text)
    -- self.mTxtInterval = self:getChildGO("mTxtInterval"):GetComponent(ty.Text)
    -- self.mImgIcon = self:getChildGO("mImgIcon_01"):GetComponent(ty.AutoRefImage)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mHeadContent = self:getChildTrans("mHeadContent")
    self.mTxtPower = self:getChildGO("mTxtPower"):GetComponent(ty.Text)
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

    local isTop = self.data.rank <= 3
    self.m_childGos["mTxtRank"]:SetActive(not isTop)
    self.mTxtRank.gameObject:SetActive(not isTop)
    self.mTxtRankBig.gameObject:SetActive(isTop)
    self.mImgColor.gameObject:SetActive(isTop)
    if isTop then
        self.mTxtRankBig.text = self.data.rank
        self.m_childGos["mTop"]:SetActive(true)
        local color
        for i = 1, 3 do
            self.m_childGos["mTop" .. i]:SetActive(self.data.rank == i)
        end

        if self.data.rank == 1 then
            color = "ffc66dff"
        elseif self.data.rank == 2 then
            color = "D376f9ff"
        elseif self.data.rank == 3 then
            color = "6dbcffff"
        end

        self.mImgColor.color = gs.ColorUtil.GetColor(color)
    else
        self.m_childGos["mTop"]:SetActive(false)
    end
    self.mTxtRank.text = self.data.rank
    self.mTxtName.text = FilterWordUtil:filterTemp(self.data.name)

    if (not self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.mPlayerHeadGrid:setData(self.data.avatar_id)
    self.mPlayerHeadGrid:setParent(self.mHeadContent)
    self.mPlayerHeadGrid:setHeadFrame(self.data.avatar_frame)
    self.mPlayerHeadGrid:setScale(0.6)
    self.mPlayerHeadGrid:setCallBack(self, self.__onClickHeadHandler)
    self.mTxtPower.text = self.data.rank_val
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
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

function __onClickHeadHandler(self, args)
    if (self.data.id ~= role.RoleManager:getRoleVo().playerId) then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = self.data.id })
    end
end

return _M
