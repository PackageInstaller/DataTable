--[[ 
-----------------------------------------------------
@filename       : FashionPairtsItem
@Description    : 皮肤商店item
@date           : 2023-3-28 15:59:00
@Author         : SXT
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.purchase.fashionShop.view.item.FashionPairtsItem", Class.impl("lib.component.BaseItemRender"))
--对应的ui文件
function onInit(self, go)
    super.onInit(self, go)
    self.mNextFashionVo = nil
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mGroupTime = self:getChildGO("mGroupTime")
    self.mImgSellOut = self:getChildGO("mImgSellOut")
    self.mGroupMoney = self:getChildGO("mGroupMoney")
    self.mImgDiscount = self:getChildGO("mImgDiscount")
    self.mTxtBuy = self:getChildGO("mTxtBuy"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtSellOut = self:getChildGO("mTxtSellOut"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtDiscount = self:getChildGO("mTxtDiscount"):GetComponent(ty.Text)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mTxtFashionName = self:getChildGO("mTxtFashionName"):GetComponent(ty.Text)
    self.mTxtFashionSeries = self:getChildGO("mTxtFashionSeries"):GetComponent(ty.Text)
    self.mImgMoneyIcon = self:getChildGO("mImgMoneyIcon"):GetComponent(ty.AutoRefImage)

    self.mTagContent = self:getChildGO("mTagContent")
    self.mTag1 = self:getChildGO("mTag1")
    self.mTag2 = self:getChildGO("mTag2")
    self.mTag3 = self:getChildGO("mTag3")

    -- self.mTxtTag1 = self:getChildGO("mTxtTag1"):GetComponent(ty.Text)
    -- self.mTxtTag2 = self:getChildGO("mTxtTag2"):GetComponent(ty.Text)
    -- self.mTxtTag3 = self:getChildGO("mTxtTag3"):GetComponent(ty.Text)
end
-- 初始化数据
function initData(self)
    super.initData(self)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_SKIN_SHOW, self.updateSetIndex, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SKIN_SHOP_ITEM, self.updateState, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateState, self)
    --   GameDispatcher:addEventListener(EventName.UPDATE_SCROLLTO, self.updateShow, self)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SKIN_SHOW, self.updateSetIndex, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SKIN_SHOP_ITEM, self.updateState, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateState, self)
    --   GameDispatcher:addEventListener(EventName.UPDATE_SCROLLTO, self.updateShow, self)
    if self.time then
        LoopManager:removeTimerByIndex(self.time)
        self.time = nil
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.mImgIcon.gameObject, self.onClickShowHandler)
end

function setData(self, param)
    super.setData(self, param)

    -- self.mTxtTag1.text = _TT(84507)
    -- self.mTxtTag2.text = _TT(84508)
    -- self.mTxtTag3.text = _TT(84509)

    self.mFashionVo = param

    self.mTxtHeroName.text = self.mFashionVo:getHeroName()
    -- self.mTxtHeroName.text = self.mFashionVo:getHeroName()
    self.mGroupTime:SetActive(self.mFashionVo:getTime() > 0)
    self.mTxtFashionSeries.text = self.mFashionVo:getFashionSeries()
    -- 
    self.mTxtSellOut.text = _TT(50046)--已持有
    self.mImgDiscount:SetActive(self.mFashionVo:getDiscount() > 0)
    self.mTxtDiscount.text = self.mFashionVo:getDiscount() .. "%" .. _TT(25037)

    -- local tapList = self.mFashionVo.heroFashionData.tap
   
    -- self.mTag1:SetActive(table.indexof01(tapList,1) > 0)
    -- self.mTag2:SetActive(table.indexof01(tapList,2) > 0)
    -- self.mTag3:SetActive(table.indexof01(tapList,3) > 0)

    self:updateState()
    if (self.mFashionVo:getCanUpdate()) then
        if self.time then
            LoopManager:removeTimerByIndex(self.time)
            self.time = nil
        end
        self:updateTime()
        self.time = LoopManager:addTimer(1, 0, self, self.updateTime)
    end

    self.colorVo = fashion.FashionManager:getFasionColorVo(self.mFashionVo.fashionDic[1],self.mFashionVo.fashionDic[2],self.mFashionVo.fashionDic[3])
    local propsVo = props.PropsManager:getPropsConfigVo( self.colorVo.costTid)


    self.mTxtFashionName.text = propsVo:getName()
    if #propsVo:getName() > 5 then
        self.mTxtFashionName.fontSize = 26
    else
        self.mTxtFashionName.fontSize = 30
    end

    if (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) then
        self.mImgIcon:SetImg(UrlManager:getIconPath("fashionPairts_Har/"..self.colorVo.fashionIcon)  , true)
    else
        self.mImgIcon:SetImg(UrlManager:getIconPath("fashionPairts/"..self.colorVo.fashionIcon)  , true)
    end
   
end

function onClickShowHandler(self)

    GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW_BUY, {
        heroTid = self.mFashionVo.fashionDic[1],
        fashionId = self.mFashionVo.fashionDic[2],
        isShow3D = true,
        defPairtsId = self.mFashionVo.fashionDic[3],
        fashionVo = self.mFashionVo
    })

    -- if not self.mFashionVo.isShow then
    --     -- GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_VIEW, self.mFashionVo)
    --     GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.HeroFashionShow, param = self.mFashionVo})
    -- else
    --     GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOW, self.mFashionVo)
    -- end
end

function updateTime(self)
    self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_10(self.mFashionVo:getTime())
    self:updateState()
    -- if self.mFashionVo:getTime() <= 0 then
    --     self.mNextFashionVo = self:updateNextDataByCurData(self.mFashionVo)
    --     GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOP)
    --     GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOW, self.mNextFashionVo)
    --     if self.time then
    --         LoopManager:removeTimerByIndex(self.time)
    --         self.time = nil
    --     end
    -- end
end
--更新下一个数据
function updateNextDataByCurData(self, curData)
    return purchase.FashionShopManager:getCurShopList()[curData.id]
end

--更新层级
function updateSetIndex(self, curData)
    if curData.id == self.mFashionVo.id then
        self.UITrans:SetAsFirstSibling()
    else
        self.UITrans:SetSiblingIndex(curData.id - 1)
    end
end

--更新状态
function updateState(self)
  

    local textColor = (MoneyUtil.getMoneyCountByTid(self.mFashionVo:getMoneyTid()) >= self.mFashionVo:getMoneyCount()) and "000000ff" or "D53529ff"
    if not self.mFashionVo.isShow then
        self.mImgSellOut:SetActive(self.mFashionVo:getIsSellOut())
        textColor = (MoneyUtil.getMoneyCountByTid(self.mFashionVo:getMoneyTid()) >= self.mFashionVo:getMoneyCount()) and "202226ff" or "D53529ff"
    end
    self.mGroupMoney:SetActive((not self.mFashionVo:getIsSellOut()))

    local payType = self.mFashionVo:getMoneyTid()
    if payType == MoneyType.MONEY then
        self.mImgMoneyIcon.gameObject:SetActive(false)
        textColor = "000000ff"
        self.mTxtBuy.text = HtmlUtil:color("¥"..self.mFashionVo:getMoneyCount()/100, textColor)
    else
        self.mImgMoneyIcon.gameObject:SetActive((not self.mFashionVo:getIsSellOut()))
        self.mImgMoneyIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.mFashionVo:getMoneyTid()), true)
        self.mTxtBuy.text = HtmlUtil:color(self.mFashionVo:getMoneyCount(), textColor)
    end
   
    
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]