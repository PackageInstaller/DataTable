--[[ 
-----------------------------------------------------
@filename       : MiniFactoryFormulaListItem
@Description    : 迷你工厂-配方列表项
@date           : 2022-03-1 17:27:27
@Author         : lyx
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("miniFac.MiniFactoryFormulaListItem", Class.impl("lib.component.BaseItemRender"))

--初始化
function onInit(self, go)
    super.onInit(self, go)
    self.mBtnBg = self:getChildGO("mImgBg")
    self.mLockBg = self:getChildGO("mLockBg")
    self.mGridNode = self:getChildTrans("mGridNode")
    self.mGroupCanGet = self:getChildGO("mGroupCanGet")
    self.mImgBg = self.mBtnBg:GetComponent(ty.AutoRefImage)
    self.mGroupProductioning = self:getChildGO("mGroupProductioning")
    self.mTextTip = self:getChildGO("mTextTip"):GetComponent(ty.Text)
    self.mImgTime = self:getChildGO("mImgTime"):GetComponent(ty.Image)
    self.mTxtCanGet = self:getChildGO("mTxtCanGet"):GetComponent(ty.Text)
    self.mTXtOwnNum = self:getChildGO("mTXtOwnNum"):GetComponent(ty.Text)
    self.mTxtProTime = self:getChildGO("mTxtProTime"):GetComponent(ty.Text)
    self.mTxtProductName = self:getChildGO("mTxtProductName"):GetComponent(ty.Text)
    self.mTXtUnLockReason = self:getChildGO("mTXtUnLockReason"):GetComponent(ty.Text)

    GameDispatcher:addEventListener(EventName.UPDATE_BTNSTATE, self.updateBtnState, self)
    GameDispatcher:addEventListener(EventName.FACTORY_LIST_ITEM_STATE, self.updateProductionState, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FACTORY_INFO, self.updateInfo, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.updateOwnNum, self)
    self.mTextTip.text = _TT(60524)--生产中
end

function setData(self, param)
    self.data = param:getDataVo()
    self:updateItem()
    if (miniFac.MiniFactoryManager:getRecordBtnTid() == self.data.tid) or (miniFac.MiniFactoryManager:getRecordBtnTid() == 0) then
        if self.data.lvLimit <= role.RoleManager:getRoleVo():getPlayerLvl() then
            self:onOpenDetailHandler()
            self:updateBtnState(self.data.tid)
        end
    end
    local state = 0
    if miniFac.MiniFactoryManager:getOrderVo(self.data.type) ~= nil then
        self.mOrderVo = miniFac.MiniFactoryManager:getOrderVo(self.data.type)
        if self.mOrderVo.tid == self.data.tid then
            state = self.mOrderVo:getRemainTime() > 0 and 1 or 2
        end
    end
    self:updateProductionState(state)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BTNSTATE, self.updateBtnState, self)
    GameDispatcher:removeEventListener(EventName.FACTORY_LIST_ITEM_STATE, self.updateProductionState, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FACTORY_INFO, self.updateInfo, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.updateOwnNum, self)
    self:recoverAllGrid()
end

function updateItem(self)
    local formulaConfigVo = self.data

    if (formulaConfigVo) then
        local num = bag.BagManager:getPropsCountByTid(formulaConfigVo.tid)
        local propsVo = props.PropsManager:getTypePropsVoByTid(formulaConfigVo.tid)
        if propsVo.type == PropsType.SPECIAL then
            num = MoneyUtil.getMoneyCountByTid(propsVo.tid)
        end
        self.mTXtOwnNum.text = _TT(60544, num)
        self.mTxtProTime.color = gs.ColorUtil.GetColor("40484Bff")
        self.mTXtOwnNum.color = gs.ColorUtil.GetColor("40484Bff")
        self.mTxtProductName.color = gs.ColorUtil.GetColor("40484Bff")
        self.mImgBg:SetImg(UrlManager:getCommon5Path("common_0166.png"), false)
        self.mImgTime:SetImg(UrlManager:getPackPath("miniFactory/miniFactory_4.png"), false)
        local propInfo = props.PropsManager:getTypePropsVoByTid(formulaConfigVo.tid)
        self.mTxtProductName.text = propInfo.name
        self.mTxtProTime.text = TimeUtil.getHMSByTime(formulaConfigVo.cost)

        local propCount = nil
        if props.PropsManager:getTypePropsVoByTid(formulaConfigVo.payId).type ~= PropsType.Money then
            propCount = bag.BagManager:getPropsCountByTid(formulaConfigVo.payId)
        else
            propCount = MoneyUtil.getMoneyCountByTid(formulaConfigVo.payId)
        end

        if (self.propsGrid) then
            self:recoverAllGrid()
        end
        local orderNum = 1
        local order = miniFac.MiniFactoryManager:getOrderVo(self.data.type)
        if order and order.tid == self.data.tid then
            orderNum = order.orderNum
        end
        self.propsGrid = PropsGrid:create(self.mGridNode, { tid = formulaConfigVo.tid, num = orderNum * formulaConfigVo.itemNum }, 0.7)
        local lv = role.RoleManager:getRoleVo():getPlayerLvl()
        self.mLockBg:SetActive(formulaConfigVo.lvLimit > lv)
        if formulaConfigVo.lvLimit > lv then
            self.mTXtUnLockReason.text = _TT(60525, formulaConfigVo.lvLimit)
            self:addOnClick(self.mBtnBg, self.onClickMaskItem, nil, formulaConfigVo.lvLimit)
        else
            self:addOnClick(self.mBtnBg, self.onOpenDetailHandler)
        end
        self.mTxtProTime.gameObject:SetActive(self.data.lvLimit <= role.RoleManager:getRoleVo():getPlayerLvl())
    end
end
--刷新生产状态
function updateProductionState(self, state)
    self.mOrderVo = miniFac.MiniFactoryManager:getOrderVo(self.data.type)
    if self.mOrderVo and self.mOrderVo.tid == self.data.tid then
        if state == 0 then
            self.mGroupProductioning:SetActive(self.mOrderVo:getRemainTime() > 0)
            self.mGroupCanGet:SetActive(self.mGroupProductioning.activeSelf == false)
            return
        end
        self.mGroupProductioning:SetActive(state == 1)
        self.mGroupCanGet:SetActive(state == 2)
    else
        self.mGroupProductioning:SetActive(false)
        self.mGroupCanGet:SetActive(false)
    end
end

--刷新按钮选中状态
function updateBtnState(self, tid)
    local color = tid == self.data.tid and "ffffffff" or "40484Bff"
    local imgBgPath = tid == self.data.tid and "common_0167.png" or "common_0166.png"
    local imgTimePath = tid == self.data.tid and "miniFactory/miniFactory_8.png" or "miniFactory/miniFactory_4.png"
    self.mTXtOwnNum.color = gs.ColorUtil.GetColor(color)
    self.mImgBg:SetImg(UrlManager:getCommon5Path(imgBgPath), false)
    self.mImgTime:SetImg(UrlManager:getPackPath(imgTimePath), false)
    self.mTxtProTime.color = gs.ColorUtil.GetColor(color)
    self.mTxtProductName.color = gs.ColorUtil.GetColor(color)
end

function onClickMaskItem(self, lv)
    gs.Message.Show(_TT(60525, lv))
end

function onOpenDetailHandler(self)
    if self.data then
        GameDispatcher:dispatchEvent(EventName.OPEN_WORK_SHOP_DETAIL_PANEL, self.data.tid)
        miniFac.MiniFactoryManager:setSelectVo(self.data)
        miniFac.MiniFactoryManager:setRecordBtnTid(self.data.tid)
    end
end
--更新状态和信息
function updateInfo(self)
    if self.data.tid == miniFac.MiniFactoryManager:getRecordBtnTid() then
        GameDispatcher:dispatchEvent(EventName.OPEN_WORK_SHOP_DETAIL_PANEL, self.data.tid)
        miniFac.MiniFactoryManager:setSelectVo(self.data)
        miniFac.MiniFactoryManager:setRecordBtnTid(self.data.tid)
    end
end

--更新持有量
function updateOwnNum(self)
    local num = bag.BagManager:getPropsCountByTid(self.data.tid)
    local propsVo = props.PropsManager:getTypePropsVoByTid(self.data.tid)
    if propsVo.type == PropsType.SPECIAL then
        num = MoneyUtil.getMoneyCountByTid(propsVo.tid)
    end
    self.mTXtOwnNum.text = _TT(60544, num)
end

function recoverAllGrid(self)
    self.propsGrid:poolRecover()
    self.propsGrid = nil
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]