--[[ 
-----------------------------------------------------
@filename       : WelfareOptFightSupplyView
@Description    : 战斗补给
@Author         : sxt
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.tab.WelfareOptFightSupplyView",Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("welfareOpt/tab/WelfareOptFightSupplyView.prefab")

function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end

-- 初始化
function configUI(self)
    self.mBgImg = self:getChildGO("Bg"):GetComponent(ty.AutoRefImage)
    self.mNormalBtn = self:getChildGO("NormalBtn")
    self.mHightBtn = self:getChildGO("HightBtn")
    self.mNormalImg = self.mNormalBtn:GetComponent(ty.AutoRefImage)
    self.mHightImg = self.mHightBtn:GetComponent(ty.AutoRefImage)

    self.mOnceBtn = self:getChildGO("OnceBtn")
    self.mOnceTxt = self:getChildGO("OnceTxt"):GetComponent(ty.Text)
    self.mOncePropImg = self:getChildGO("OncePropImg"):GetComponent(ty.AutoRefImage)
    self.mOncePropTxt = self:getChildGO("OncePropTxt"):GetComponent(ty.Text)

    self.mMoreBtn = self:getChildGO("MoreBtn")
    self.mMoreTxt = self:getChildGO("MoreTxt"):GetComponent(ty.Text)
    self.mMorePropImg = self:getChildGO("MorePropImg"):GetComponent(ty.AutoRefImage)
    self.mMorePropTxt = self:getChildGO("MorePropTxt"):GetComponent(ty.Text)

    self.mNomralRedPoint = self:getChildGO("NormalRedPoint")
    self.mHightRedPoint = self:getChildGO("HightRedPoint")
    self.mOnceRedPoint = self:getChildGO("OnceRedPoint")
    self.mMoreRedPoint = self:getChildGO("MoreRedPoint")

    self.mBtnRule = self:getChildGO("BtnRule")
    self.mRuleTxt = self:getChildGO("RuleTxt"):GetComponent(ty.Text)

    self.mBtnTrans = self:getChildGO("BtnTrans")
    self:setGuideTrans("guide_BtnFightSupplyTrans",  self.mBtnTrans.transform)
    self:setGuideTrans("guide_BtnFightSupplyOnce",  self.mOnceBtn.transform)
end

function initViewText(self)
    self.mRuleTxt.text = _TT(48125)
end
--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({  MoneyTid.NORMAL_SUBSIDY_TID,MoneyTid.HIGH_SUBSIDY_TID })
  
    GameDispatcher:addEventListener(EventName.UPDATE_WELFARE_FIGHTSUPPLY,self.__updateView,self)
    self.mIndex = 1

    self:__onNormalBtnClickHandler()
    --self:showPanel()
end

function __updateView(self)
    self:showPanel()
end

function showPanel(self)
    self.data = welfareOpt.WelfareOptManager:getDataFightSupplyData(self.mIndex)

    self.mOncePropImg:SetImg(UrlManager:getPropsIconUrl(self.data.costOneId),false)
    self.mOncePropTxt.text = self.data.costOneNum

    local moreData = props.PropsManager:getPropsConfigVo(self.data.costTenId)
    self.mMorePropImg:SetImg(UrlManager:getPropsIconUrl(self.data.costTenId),false)
    self.mMorePropTxt.text = self.data.costTenNum

    self:updateRedPoint()
end

function updateRedPoint(self)
    for i = 1, 2 do
        local data = welfareOpt.WelfareOptManager:getDataFightSupplyData(i)
       

        local oneNum = bag.BagManager:getPropsCountByTid(data.costOneId)
        local needOneNum  = data.costOneNum

        local myNum = bag.BagManager:getPropsCountByTid(data.costTenId)
        local needNum  = data.costTenNum

        if i == 1 then
            self.mNomralRedPoint:SetActive(oneNum>=needOneNum)
        else
            self.mHightRedPoint:SetActive(oneNum>=needOneNum)
        end
       
        if self.mIndex == i then
            self.mMoreRedPoint:SetActive(myNum >= needNum)
            self.mOnceRedPoint:SetActive(oneNum >= needOneNum)
        end
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_WELFARE_FIGHTSUPPLY,self.__updateView,self)
    --GameDispatcher:removeEventListener(EventName.UPDATE_WELFARE_FIGHTSUPPLY,self.showPanel,self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mNormalBtn,self.__onNormalBtnClickHandler)
    self:addUIEvent(self.mHightBtn,self.__onHightBtnClickHandler)

    self:addUIEvent(self.mOnceBtn,self.__onOnceBtnClickHandler)
    self:addUIEvent(self.mMoreBtn,self.__onMoreBtnClickHandler)

    self:addUIEvent(self.mBtnRule,self.__onRuleBtnClickHandler)
end

function __onRuleBtnClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_WELFAREOPT_FIGHTSUPPLYPRO_PANEL,{type = self.mIndex})
end

function __onOnceBtnClickHandler(self)
    local num = bag.BagManager:getPropsCountByTid(self.data.costOneId)
    local needNum  = self.data.costOneNum

    if(num < needNum) then
        gs.Message.Show(_TT(48106))
    else
        GameDispatcher:dispatchEvent(EventName.REQ_WELFARE_FIGHTSUPPLY,{type = self.mIndex,times = 1})
    end
end

function __onMoreBtnClickHandler(self)
    local num = bag.BagManager:getPropsCountByTid(self.data.costTenId)
    local needNum  = self.data.costTenNum

    if(num < needNum) then
        gs.Message.Show(_TT(48106))
    else
        GameDispatcher:dispatchEvent(EventName.REQ_WELFARE_FIGHTSUPPLY,{type = self.mIndex,times = 10})
    end
end

--默认按钮
function __onNormalBtnClickHandler(self)
    self.mIndex = 1

    self.mNormalImg :SetImg(UrlManager:getPackPath("welfareOpt/FightSupply/FightSupply_1.png"),false)
    self.mHightImg:SetImg(UrlManager:getPackPath("welfareOpt/FightSupply/FightSupply_2_normal.png"),false)
    
    self.mBgImg:SetImg(UrlManager:getBgPath("welfareOpt/welfareOpt_bg_3.jpg"),false)
    self:showPanel()
end

--高级按钮
function __onHightBtnClickHandler(self)
    self.mIndex = 2

    self.mNormalImg :SetImg(UrlManager:getPackPath("welfareOpt/FightSupply/FightSupply_1_normal.png"),false)
    self.mHightImg:SetImg(UrlManager:getPackPath("welfareOpt/FightSupply/FightSupply_2.png"),false)

    self.mBgImg:SetImg(UrlManager:getBgPath("welfareOpt/welfareOpt_bg_2.jpg"),false)
    self:showPanel()
end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
