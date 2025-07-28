-- 海底主界面
module("seabed.SeabedShopPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedShopPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle("海底")
    self:setSize(0, 0)
    self:setBg("seabed_main.jpg", false, "seabed")
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mShopList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnQuit = self:getChildGO("mBtnQuit")
    self.mShopScroll = self:getChildGO("mShopScroll"):GetComponent(ty.ScrollRect)

    self.mShopItem = self:getChildGO("mShopItem")

    self.mSelectShopItem = self:getChildGO("mSelectShopItem")
    self.mImgSelectColor = self:getChildGO("mImgSelectColor"):GetComponent(ty.AutoRefImage)
    self.mImgSelectShopIcon = self:getChildGO("mImgSelectShopIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtSelectShopName = self:getChildGO("mTxtSelectShopName"):GetComponent(ty.Text)
    self.mTxtSelectShopDes = self:getChildGO("mTxtSelectShopDes"):GetComponent(ty.Text)
    self.mSelectIsBuy = self:getChildGO("mSelectIsBuy")
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mTxtSelectCostCount = self:getChildGO("mTxtSelectCostCount"):GetComponent(ty.Text)
    self.mImgCostProps = self:getChildGO("mImgCostProps"):GetComponent(ty.AutoRefImage)
    self.mSelectIsNotHas = self:getChildGO("mSelectIsNotHas")
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_SHOP_PANEL, self.showPanel, self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)

    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_SHOP_PANEL, self.showPanel, self)
    self:clearShopList()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

    self:addUIEvent(self.mBtnBuy, self.onBtnBuyClickHandler)
    self:addUIEvent(self.mBtnQuit, self.onBtnQuitClickHandler)
end

function showPanel(self)

    if seabed.SeabedManager:canShowAddBuff() or seabed.SeabedManager:canShowRemoveBuff() then
        GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_BUFF_CHANGE_PANEL)
    end

    self:clearShopList()
    self.shopInfo = seabed.SeabedManager:getSeabedShopInfo()
    local actionPoint, coin = seabed.SeabedManager:getSeabedResource()
    for i = 1, #self.shopInfo.goods_list, 1 do
        local good = self.shopInfo.goods_list[i]
        local item = SimpleInsItem:create(self.mShopItem, self.mShopScroll.content, "mSeabedShopItem")

        local shopVo = seabed.SeabedManager:getSeabedShopDataById(good.id)

        local vo
        local isHas
        if good.type == seabed.SeabedBattleType.Buff then
            vo = seabed.SeabedManager:getSeabedBuffDataById(shopVo.param)
            isHas = seabed.SeabedManager:getHisBuffIsHas(shopVo.param)
        else
            vo = seabed.SeabedManager:getSeabedCollectionDataById(shopVo.param)
            isHas = seabed.SeabedManager:getHisCollectionIsHas(shopVo.param)
        end

        item:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getIconPath("seabed/color_0" .. vo.color .. ".png"), false)
        item:getChildGO("mImgShopIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon), false)
        item:getChildGO("mTxtShopName"):GetComponent(ty.Text).text = _TT(vo.name)
        item:getChildGO("mIsBuy"):SetActive(good.is_buy == 1)
        item:getChildGO("mTxtCostCount"):GetComponent(ty.Text).text = good.price
        item:getChildGO("mTxtCostCount"):GetComponent(ty.Text).color = good.price <= coin and gs.ColorUtil.GetColor("000000ff") or gs.ColorUtil.GetColor("d23627ff")

        item:getChildGO("mIsNotHas"):SetActive(not isHas)
        item:getChildGO("mImgSelect"):SetActive(false)
        item.isSelect = false
        item:addUIEvent("mBtnClick", function()
            self:onClickShopItem(i)
        end)

        table.insert(self.mShopList, item)
    end
    self:onClickShopItem(1)
end

function onClickShopItem(self, index)
    self.selectIndex = index

    for i = 1, #self.mShopList, 1 do
        self.mShopList[i].isSelect = i == index
        self.mShopList[i]:getChildGO("mImgSelect"):SetActive(i == index)
    end

    local vo
    local isHas
    local good = self.shopInfo.goods_list[index]
    local shopVo = seabed.SeabedManager:getSeabedShopDataById(good.id)
    if good.type == seabed.SeabedBattleType.Buff then
        vo = seabed.SeabedManager:getSeabedBuffDataById(shopVo.param)
        isHas = seabed.SeabedManager:getHisBuffIsHas(shopVo.param)
    else
        vo = seabed.SeabedManager:getSeabedCollectionDataById(shopVo.param)
        isHas = seabed.SeabedManager:getHisCollectionIsHas(shopVo.param)
    end

    self.mImgSelectColor:SetImg(UrlManager:getIconPath("seabed/color_0" .. vo.color .. ".png"), false)
    self.mImgSelectShopIcon:SetImg(UrlManager:getIconPath(vo.icon), false)

    self.mTxtSelectShopName.text = _TT(vo.name)
    self.mTxtSelectShopDes.text = _TT(vo.des)
    self.mSelectIsBuy:SetActive(good.is_buy == 1)
    self.mTxtSelectCostCount.text = good.price
    local actionPoint, coin = seabed.SeabedManager:getSeabedResource()
    self.mTxtSelectCostCount.color =  good.price <= coin and gs.ColorUtil.GetColor("ffffffff") or gs.ColorUtil.GetColor("d23627ff")
   
    self.mSelectIsNotHas:SetActive(not isHas)

    self.mBtnBuy:SetActive(good.is_buy == 0)
end

function onBtnBuyClickHandler(self)
    local actionPoint, coin = seabed.SeabedManager:getSeabedResource()
    if coin >= self.shopInfo.goods_list[self.selectIndex].price then
        GameDispatcher:dispatchEvent(EventName.REQ_SEABED_SHOP_BUY_ITEM, {
            goodsId = self.shopInfo.goods_list[self.selectIndex].id
        })
    else
        gs.Message.Show("金币不足")
    end
end

function onBtnQuitClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_SEABED_SHOP_QUIT)
end

function clearShopList(self)
    for i = 1, #self.mShopList, 1 do
        self.mShopList[i]:poolRecover()
    end
    self.mShopList = {}
end

function onClickClose(self)
    -- super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_TOP_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_ALL_PANEL)
end

return _M
