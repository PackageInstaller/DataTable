module("buildBase.BuildBaseFacProduceItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mNeedPropList = {}
    self.mCoinProp = nil
    self.mGroupUnlock = self:getChildGO("mGroupUnlock")
    self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)
    self.mTxtPropName = self:getChildGO("mTxtPropName"):GetComponent(ty.Text)
    self.mTxtNeedTime = self:getChildGO("mTxtNeedTime"):GetComponent(ty.Text)
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)

    self.mPropbg = self:getChildGO("mPropbg"):GetComponent(ty.AutoRefImage)
    self.mPropIcon = self:getChildGO("mPropIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtCont = self:getChildGO("mTxtCont"):GetComponent(ty.Text)
    self.mPropCont = self:getChildTrans("mPropCont")
    self.mProducePropNode = self:getChildTrans("mProducePropNode")
    self.mNeedPropNode = self:getChildTrans("mNeedPropNode")
    self.mPriceNode = self:getChildTrans("mPriceNode")
    self.mClickArea = self:getChildGO("mClickArea")

    self.mPropItem1 = self:getChildGO("mPropItem1")
    self.mTxtNone1 = self:getChildGO("mTxtNone1"):GetComponent(ty.Text)
    self.mPropNode1 = self:getChildTrans("mPropNode1")
    self.mPropItem2 = self:getChildGO("mPropItem2")
    self.mTxtNone2 = self:getChildGO("mTxtNone2"):GetComponent(ty.Text)
    self.mPropNode2 = self:getChildTrans("mPropNode2")
    self.mTxtPrice = self:getChildGO("mTxtPrice"):GetComponent(ty.Text)
    self.mImgEmptyPrice = self:getChildGO("mImgEmptyPrice")
    self:addOnClick(self.mClickArea, self.onClickItemHandler)
end

function setData(self, param)
    super.setData(self, param)
    self.mFacVo = self:getData()
    self.enoughMeterial = true
    self:updateView()
end

function updateView(self)
    self:recoverPropGrid()
    local propVo = props.PropsManager:getPropsVo2(self.mFacVo.propProps)
    self.mTxtNone1.text = "-/-"
    self.mTxtNone2.text = "-/-"
    self.mPropbg:SetImg(UrlManager:getPackPath(string.format("buildBase/produce_icon_bg_%s.png", propVo.color)), true)
    self.mPropIcon:SetImg(UrlManager:getPropsIconUrl(self.mFacVo.propProps[1]), false)

    if propVo.count > 1 then
        self.mTxtCont.text = propVo.count
        self.mPropCont:GetComponent(ty.ContentSizeFitter):SetLayoutHorizontal()
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mPropCont) --立即刷新
        self.mPropCont.gameObject:SetActive(true)
    else
        self.mPropCont.gameObject:SetActive(false)
    end

    local hasNum = 0
    local needNum = 0
    if self.mFacVo.requiredProps[1] then
        local propGrid = PropsGrid:create(self.mPropNode1, self.mFacVo.requiredProps[1], 1, false)
        propGrid:setIsShowCount(false)
        propGrid:setIsShowCount2(false)

        hasNum = bag.BagManager:getPropsCountByTid(self.mFacVo.requiredProps[1][1])
        needNum = self.mFacVo.requiredProps[1][2]
        if (hasNum >= needNum) then
            if hasNum > 999 then
                hasNum = "999+"
            end
            self.mTxtNone1.text = "<color=#ffffff>" .. hasNum .. "</color>/" .. needNum
        else
            self.enoughMeterial = false
            self.mTxtNone1.text = "<color=#fa3a2b>" .. hasNum .. "</color>/" .. needNum
        end
        table.insert(self.mNeedPropList, propGrid)
    end
    if self.mFacVo.requiredProps[2] then
        local propGrid = PropsGrid:create(self.mPropNode2, self.mFacVo.requiredProps[2], 1, false)
        propGrid:setIsShowCount(false)
        propGrid:setIsShowCount2(false)

        hasNum = bag.BagManager:getPropsCountByTid(self.mFacVo.requiredProps[2][1])
        needNum = self.mFacVo.requiredProps[2][2]
        if (hasNum >= needNum) then
            if hasNum > 999 then
                hasNum = "999+"
            end
            self.mTxtNone2.text = "<color=#ffffff>" .. hasNum .. "</color>/" .. needNum
        else
            self.enoughMeterial = false
            self.mTxtNone2.text = "<color=#fa3a2b>" .. hasNum .. "</color>/" .. needNum
        end
        table.insert(self.mNeedPropList, propGrid)
    end

    if self.mFacVo.requiredCoin[2] == 0 then
        self.mImgEmptyPrice:SetActive(true)
        self.mTxtPrice.gameObject:SetActive(false)
    else
        self.mImgEmptyPrice:SetActive(false)
        self.mTxtPrice.gameObject:SetActive(true)
        self.mCoinProp = PropsGrid:create(self.mPriceNode, self.mFacVo.requiredCoin, 1, false)
        self.mCoinProp:setIsShowCount2(false)
        hasNum = MoneyUtil.getMoneyCountByTid(self.mFacVo.requiredCoin[1])
        if hasNum < self.mFacVo.requiredCoin[2] then
            self.enoughMeterial = false
        end
        self.mTxtPrice.text = self.mFacVo.requiredCoin[2]
        self.mTxtPrice.color = gs.ColorUtil.GetColor(hasNum < self.mFacVo.requiredCoin[2] and "fa3a2bff" or "ffffffff")
    end
    local facLv = buildBase.BuildBaseManager:getShipLv(buildBase.BuildBaseManager:getNowBuildId())
    self.mGroupUnlock:SetActive(self.mFacVo.needLevel > facLv)
    self.mTxtCondition.text = _TT(76183, self.mFacVo.needLevel)
    self.mTxtCost.text = self.mFacVo.store
    self.mTxtPropName.text = propVo:getName()
    self.mTxtNeedTime.text = TimeUtil.getHMSByTime(self.mFacVo.needTime)
end

function onClickItemHandler(self)
    if self.enoughMeterial then
        GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_PRODUCE_INFO_PANEL, { produceVo = self.mFacVo })
    else
        gs.Message.Show(_TT(76022))
    end
end

function recoverPropGrid(self)
    if (self.mCoinProp) then
        self.mCoinProp:poolRecover()
    end
    self.mCoinProp = nil

    for k, v in pairs(self.mNeedPropList) do
        v:poolRecover()
    end
    self.mNeedPropList = {}
end

function deActive(self)
    super.deActive(self)
    self:recoverPropGrid()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]