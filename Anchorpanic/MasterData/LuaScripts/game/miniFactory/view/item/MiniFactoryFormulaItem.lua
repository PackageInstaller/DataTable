--[[ 
-----------------------------------------------------
@filename       : MiniFactoryItemGroupView
@Description    : 按钮的界面
@date           : 2022-03-03 13:38:58
@Author         : lyx
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("miniFac.MiniFactoryFormulaItem", Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("factory/MiniFactoryFormulaItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    self.mTimeSn = nil
    self.isShow = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mImgBg = self:getChildGO("mImgBg")
    self.mImgLock = self:getChildGO("mImgLock")
    self.mGropHspl = self:getChildGO("mGropHspl")
    self.mGroupLockBg = self:getChildGO("mGroupLockBg")
    self.mGroupNotHpsl = self:getChildGO("mGroupNotHpsl")
    self.mTxtPro = self:getChildGO("mTxtPro"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtLock = self:getChildGO("mTxtLock"):GetComponent(ty.Text)
    self.mTxtState = self:getChildGO("mTxtState"):GetComponent(ty.Text)
    self.mTxtComplete = self:getChildGO("mTxtComplete"):GetComponent(ty.Text)
    self.mImgNotHpslBg = self:getChildGO("mImgNotHpslBg"):GetComponent(ty.Image)
    self.mImgProp = self:getChildTrans("mImgProp"):GetComponent(ty.AutoRefImage)
    self.mProgressBar = self:getChildGO("mProgressBar"):GetComponent(ty.ProgressBar)
    self.mProgressBar:InitData(0)
end

--激活
function active(self)
    super.active(self)
    self.mParent = self:getParentTrans().transform
    self:addOnClick(self.mImgBg, self.onClickHandler)
    self.mTxtComplete.text = _TT(60528)
end
function addAllUIEvent(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

function destroy(self)
    super.destroy(self)
    if (self.mTimeSn) then
        LoopManager:removeTimerByIndex(self.mTimeSn)
        self.mTimeSn = nil
    end
end

function setData(self, configVo)
    self.mConfigVo = configVo
    self:updateSubBtn()
end

function updateSubBtn(self)
    self.mGropHspl:SetActive(true)
    self.mGroupNotHpsl:SetActive(true)

    if funcopen.FuncOpenManager:isOpen(self.mConfigVo.funcId, false) == false or funcopen.FuncOpenManager:getFuncOpenData(self.mConfigVo.funcId).lv >= 999 then
        self.mTxtLock.text = funcopen.FuncOpenManager:getIsOpenTip(self.mConfigVo.funcId)
        if funcopen.FuncOpenManager:getFuncOpenData(self.mConfigVo.funcId).lv >= 999 then
            self.mTxtLock.text = _TT(60511)
        end
        self.isShow = false
        self.mGropHspl:SetActive(false)
        self.mGroupNotHpsl:SetActive(true)
        self.mTxtName.text = _TT(self.mConfigVo.showName)
        self.mImgNotHpslBg.color = gs.ColorUtil.GetColor("382525ff")
        return
    elseif funcopen.FuncOpenManager:isOpen(self.mConfigVo.funcId, false) then
        self.mImgNotHpslBg.color = gs.ColorUtil.GetColor("242728ff")
        self.mGropHspl:SetActive(true)
        self.mGroupNotHpsl:SetActive(false)
        self.mTxtName.text = _TT(self.mConfigVo.showName)
        self.isShow = true
        local orderVo = miniFac.MiniFactoryManager:getOrderVo(self.mConfigVo.type)
        if orderVo then
            self.mOrderVo = orderVo
        end
        if self.mOrderVo then
            local formulaVo = miniFac.MiniFactoryManager:getFactoryFormulaVoById(self.mOrderVo.orderId)
            self.mImgProp:SetImg(UrlManager:getPropsIconUrl(formulaVo.tid), false)
            if (self.mOrderVo:getRemainTime() <= 0) then
                self.mProgressBar.gameObject:SetActive(false)
                self.mTxtComplete.gameObject:SetActive(true)
                self.mTxtPro.gameObject:SetActive(false)
                self.mTxtComplete.gameObject:SetActive(true)
                self.mTxtState.text = _TT(60527)--"生产完成"
            else
                self.mProgressBar.gameObject:SetActive(true)
                self.mTxtComplete.gameObject:SetActive(false)
                self:onTickHandler()
                self.mTxtState.text = _TT(60524)--"生产中"
                if not self.mTimeSn then
                    self.mTimeSn = LoopManager:addTimer(1, 0, self, self.onTickHandler)
                end
            end
        elseif not self.mOrderVo then
            self.mGropHspl:SetActive(false)
            self.mGroupNotHpsl:SetActive(false)
        end
    end
    if (self.mGropHspl.activeSelf == false) or (self.mGropHspl.activeSelf == true and self.mTxtComplete.gameObject.activeSelf == true) then
        GameDispatcher:dispatchEvent(EventName.UPDATE_MINIFAC_ANISTATE, { type = self.mConfigVo.type, state = "stop" })
    else
        GameDispatcher:dispatchEvent(EventName.UPDATE_MINIFAC_ANISTATE, { type = self.mConfigVo.type, state = "action" })
    end
    self.mImgLock:SetActive(self.mGroupNotHpsl.activeSelf == true)
end

function onTickHandler(self)
    if self.mOrderVo:getRemainTime() <= 0 and (table.indexof(miniFac.MiniFactoryManager:getCompleteOrderList(), self.mOrderVo.id)) then
        LoopManager:removeTimerByIndex(self.mTimeSn)
        self.mTimeSn = nil
        GameDispatcher:dispatchEvent(EventName.UPDATE_FACTORY_INFO)
        GameDispatcher:dispatchEvent(EventName.UPDATE_MINIFAC_ANISTATE, { type = self.mConfigVo.type, state = "stop" })
    else
        local config = miniFac.MiniFactoryManager:getFactoryFormulaVoById(self.mOrderVo.orderId)
        local sumTime = config.cost * self.mOrderVo.orderNum
        self.mProgressBar:SetValue(sumTime - self.mOrderVo:getRemainTime(), sumTime, true)
        self.mTxtPro.text = TimeUtil.getHMSByTime(self.mOrderVo:getRemainTime())
    end
end

function onClickHandler(self)
    if funcopen.FuncOpenManager:getFuncOpenData(self.mConfigVo.funcId).lv >= 999 then
        gs.Message.Show(_TT(60511))
        return
    elseif funcopen.FuncOpenManager:isOpen(self.mConfigVo.funcId, true) == false then
        return
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_WORK_SHOP_VIEW, self.mConfigVo.type)
    end
end

function onClickOverHandler(self)
    if self.mTxtState.text == _TT(60527) then
        --GameDispatcher:dispatchEvent(EventName.OPEN_WORK_SHOP_VIEW, self.mConfigVo.type)
        --miniFac.MiniFactoryManager:setRecordBtnTid(self.mOrderVo.tid)
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]