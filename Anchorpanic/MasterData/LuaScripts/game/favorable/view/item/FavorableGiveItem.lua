module("favorable.FavorableGiveItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mBtnAdd = self:getChildGO("mBtnAdd")
    self.mBtnSub = self:getChildGO("mBtnSub")
    self.mBtnMax = self:getChildGO("mBtnMax")
    self.mImgSelected = self:getChildGO("mImgSelected")
    self.mGroupProps = self:getChildTrans("mGroupProps")
    self.mImgLike = self:getChildGO("mImgLike"):GetComponent(ty.Image)
    self.mTxtBtnMax = self:getChildGO("mTxtBtnMax"):GetComponent(ty.Text)
    self.mTxtPropsName = self:getChildGO("mTxtPropsName"):GetComponent(ty.Text)
    self.mTxtSelectNum = self:getChildGO("mTxtSelectNum"):GetComponent(ty.Text)
    self.mTxtBtnMax.text = _TT(70102)--"最大"

    self:addOnClick(self.mBtnMax, self.onMaxBtnClickHandler)
    self:addOnClick(self.mBtnSub, self.onSubBtnClickHandler)
    self:addOnClick(self.mBtnAdd, self.onClickHandler)
end

function onClickHandler(self)
    if (self.mCurrentCum < self.num) then
        self.nextCum = self.mCurrentCum + 1
    else
        gs.Message.Show(_TT(41713))--"道具已经到达最大数量,无法继续添加")
        return
    end

    local data = { tid = self.giveVo.propsTid, num = self.nextCum, likeAdd = self.addNum, id = self.giveVo.propsId }
    local ret = favorable.FavorableManager:addProps(data)

    if (ret) then
        --添加成功
        self.mCurrentCum = self.nextCum
    else
        gs.Message.Show(_TT(41714))--"亲密度已经到达最大等级,无需继续添加")
        return
    end

    self:updateNum()
    GameDispatcher:dispatchEvent(EventName.UPDATE_FAVORABLE_PREDATA)
end

function onMaxBtnClickHandler(self)
    local data = { tid = self.giveVo.propsTid, num = self.num, likeAdd = self.addNum, id = self.giveVo.propsId }
    local ret = favorable.FavorableManager:addProps(data)
    if (self.mCurrentCum >= self.num) then
        gs.Message.Show(_TT(41713))--"道具已经到达最大数量,无法继续添加")
    elseif (not ret) then
        gs.Message.Show(_TT(41714))--"亲密度已经到达最大等级,无需继续添加")
    end
    local max = favorable.FavorableManager:getMax(data)
    self.mCurrentCum = math.min(max, self.num)
    data.num = self.mCurrentCum
    favorable.FavorableManager:setProps(data)
    self:updateNum()
    GameDispatcher:dispatchEvent(EventName.UPDATE_FAVORABLE_PREDATA)
end

function onSubBtnClickHandler(self)
    if (self.mCurrentCum >= 1) then
        self.mCurrentCum = self.mCurrentCum - 1
    else
        self.mCurrentCum = 0
    end
    local data = { tid = self.giveVo.propsTid, num = self.mCurrentCum, likeAdd = self.addNum, id = self.giveVo.propsId }
    favorable.FavorableManager:subProps(data)
    self:updateNum()
    GameDispatcher:dispatchEvent(EventName.UPDATE_FAVORABLE_PREDATA)
end

function setData(self, data)
    super.setData(self, data)
    self.giveVo = data
    self.num = bag.BagManager:getPropsCountByTid(self.giveVo.propsTid)
    local propData = { tid = self.giveVo.propsTid, num = self.num }
    if self.propsGrid then
        self.propsGrid:poolRecover()
        self.propsGrid = nil
    end
    self.propsGrid = PropsGrid:create(self.mGroupProps, propData, 1, false, false)
    -- self.propsGrid:setClickEnable(false)
    self.mTxtPropsName.text = self.giveVo.propsConfigVo.name

    local isLike, likeValue = self.giveVo:getIsLike()
    local isDislike, dislikeValue = self.giveVo:getIsDislike()
    if (isLike) then
        self.mImgLike.color = gs.ColorUtil.GetColor("ff3859ff")
    elseif (isDislike) then
        self.mImgLike.color = gs.ColorUtil.GetColor("e1e1e1ff")
    else
        self.mImgLike.color = gs.ColorUtil.GetColor("38bafcff")
    end

    self.mCurrentCum = self.giveVo.seletctCount
    self.addNum = self.giveVo:getFavorableValue()
    self:updateNum()
    GameDispatcher:addEventListener(EventName.RESETGIFT, self.resetNum, self)
end

function resetNum(self)
    self.mCurrentCum = 0 
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.RESETGIFT, self.resetNum, self)
    if self.propsGrid then
        self.propsGrid:poolRecover()
        self.propsGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

function updateNum(self)
    self.mTxtSelectNum.text = self.mCurrentCum
    if (self.mCurrentCum == 0) then
        -- gs.TransQuick:SizeDelta01(self.rt, 364)
        --self.mImgSelected:SetActive(false)
    else
        -- gs.TransQuick:SizeDelta01(self.rt, 390)
        --self.mImgSelected:SetActive(true)
    end

    self.giveVo.seletctCount = self.mCurrentCum
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]