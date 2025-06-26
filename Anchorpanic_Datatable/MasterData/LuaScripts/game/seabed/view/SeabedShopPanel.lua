-- 海底主界面
module("seabed.SeabedShopPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedShopPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 1 --是否显示全屏纯黑防穿帮底图
isScreensave = 1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(111017))
    self:setSize(0, 0)
    self:setBg("seabed_main.jpg", false, "seabed")
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mShopDic= {}
    self.mAniList = {}
    self.mShowBuffAniList = {}
    self.mShowBuffList = {}
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

    self.mBtnBuff = self:getChildGO("mBtnBuff")
    self.mTxtBuff = self:getChildGO("mTxtBuff"):GetComponent(ty.Text)
    self.mTxtBuffNum = self:getChildGO("mTxtBuffNum"):GetComponent(ty.Text)

    self.mBtnColl = self:getChildGO("mBtnColl")
    self.mTxtColl = self:getChildGO("mTxtColl"):GetComponent(ty.Text)
    self.mTxtCollNum = self:getChildGO("mTxtCollNum"):GetComponent(ty.Text)

    self.mShowBuffInfo = self:getChildGO("mShowBuffInfo")
    self.mBtnHideShowBuff = self:getChildGO("mBtnHideShowBuff")
    self.mTxtShowBuff = self:getChildGO("mTxtShowBuff"):GetComponent(ty.Text)
    self.mShowBuffScroll = self:getChildGO("mShowBuffScroll"):GetComponent(ty.ScrollRect)

    self.mShowCollectionInfo = self:getChildGO("mShowCollectionInfo")
    self.mBtnHideShowCollection = self:getChildGO("mBtnHideShowCollection")
    self.mTxtShowCollection = self:getChildGO("mTxtShowCollection"):GetComponent(ty.Text)
    self.mShowCollectionScroll = self:getChildGO("mShowCollectionScroll"):GetComponent(ty.ScrollRect)

    self.mBuffItem = self:getChildGO("mBuffItem")

    self.mBuyAni = self:getChildGO("mSelectShopItem"):GetComponent(ty.Animator)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_SHOP_PANEL, self.updateShopGoods, self)
end

function open(self)
    super.open(self)
    self:showPanel()
end

function initViewText(self)
    self:getChildGO("mTxtShop"):GetComponent(ty.Text).text = _TT(112247)
    self.mTxtBuff.text = _TT(111043)
    self.mTxtColl.text = _TT(111044)
end


-- 反激活（销毁工作）
function deActive(self)

    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_SHOP_PANEL, self.updateShopGoods, self)
  	self:clearAniList()   
 	self:clearShopDic()
    self:clearShowBuffList()
end



function updateShopGoods(self,args)
    self.mBuyAni:SetTrigger("show")
    self.mTxtBuffNum.text = #seabed.SeabedManager:getCurBuffList()
    self.mTxtCollNum.text = #seabed.SeabedManager:getCurCollectionList()
    
    self.shopInfo = seabed.SeabedManager:getSeabedShopInfo()
    local actionPoint, coin = seabed.SeabedManager:getSeabedResource()
    for id, item in pairs(self.mShopDic) do
        local shopVo = seabed.SeabedManager:getSeabedShopDataById(id)
        local good = self:getShopInfo(id)

        local vo
        local isHas
        if good.type == seabed.SeabedBattleType.Buff then
            vo = seabed.SeabedManager:getSeabedBuffDataById(shopVo.param)
            isHas = seabed.SeabedManager:getHisBuffIsHas(shopVo.param)
        else
            vo = seabed.SeabedManager:getSeabedCollectionDataById(shopVo.param)
            isHas = seabed.SeabedManager:getHisCollectionIsHas(shopVo.param)
        end

        item:getChildGO("mIsBuy"):SetActive(good.is_buy == 1)
        item:getChildGO("mTxtCostCount"):GetComponent(ty.Text).color = good.price <= coin and gs.ColorUtil.GetColor("000000ff") or gs.ColorUtil.GetColor("d23627ff")
        item:getChildGO("mIsNotHas"):SetActive(not isHas)
    end
    self:onClickShopItem(args.id)
end

function getShopInfo(self,goodId)
    for i=1,#self.shopInfo.goods_list do
        if self.shopInfo.goods_list[i].id == goodId then
            return self.shopInfo.goods_list[i]
        end
    end
end


-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

    self:addUIEvent(self.mBtnBuy, self.onBtnBuyClickHandler)
    self:addUIEvent(self.mBtnQuit, self.onBtnQuitClickHandler)

    self:addUIEvent(self.mBtnColl, self.onBtnCollClickHandler)
    self:addUIEvent(self.mBtnHideShowCollection, self.onBtnHideShowCollectionClickHandler)

    self:addUIEvent(self.mBtnBuff, self.onBtnBuffClickHandler)
    self:addUIEvent(self.mBtnHideShowBuff, self.onBtnHideShowBuffClickHandler)
end

function showPanel(self)
    self.mTxtBuffNum.text = #seabed.SeabedManager:getCurBuffList()
    self.mTxtCollNum.text = #seabed.SeabedManager:getCurCollectionList()
    -- if seabed.SeabedManager:canShowAddBuff() or seabed.SeabedManager:canShowRemoveBuff() then
    --     GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_BUFF_CHANGE_PANEL)
    -- end

    self:clearShopDic()
    self.shopInfo = seabed.SeabedManager:getSeabedShopInfo()
    local actionPoint, coin = seabed.SeabedManager:getSeabedResource()
    local defId = 0

    table.sort(self.shopInfo.goods_list,function (vo1,vo2)
        return vo1.price > vo2.price
    end)
    

    for i = 1, #self.shopInfo.goods_list, 1 do
      
        local good = self.shopInfo.goods_list[i]
        local item = SimpleInsItem:create(self.mShopItem, self.mShopScroll.content, "mSeabedShopItem")
        local shopVo = seabed.SeabedManager:getSeabedShopDataById(good.id)
        if i == 1 then
            defId = good.id
        end
        local vo
        local isHas
        if good.type == seabed.SeabedBattleType.Buff then
            vo = seabed.SeabedManager:getSeabedBuffDataById(shopVo.param)
            isHas = seabed.SeabedManager:getHisBuffIsHas(shopVo.param)
        else
            vo = seabed.SeabedManager:getSeabedCollectionDataById(shopVo.param)
            isHas = seabed.SeabedManager:getHisCollectionIsHas(shopVo.param)
        end
        item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(false)
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

        local timeSn = LoopManager:setTimeout(i * 0.04, self, function()
            item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(true)
            item.m_go:GetComponent(ty.UIDoTween):BeginTween()
        end)

        item:addUIEvent("mBtnClick", function()
            self:onClickShopItem(good.id)
        end)
        table.insert(self.mAniList, timeSn)
        self.mShopDic[good.id] = item
    end
    self:onClickShopItem(defId)
end

function onClickShopItem(self, goodId)
    self.selectId = goodId
    for id, item in pairs(self.mShopDic) do
        item.isSelect = id == goodId
        item:getChildGO("mImgSelect"):SetActive(item.isSelect)
    end

    local vo
    local isHas
    local good = self:getShopInfo(goodId)
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
    local good = self:getShopInfo(self.selectId)
    if coin >= good.price then
        GameDispatcher:dispatchEvent(EventName.REQ_SEABED_SHOP_BUY_ITEM, {
            goodsId = good.id
        })
    else
        gs.Message.Show(_TT(111145))
    end
end

function onBtnQuitClickHandler(self)
    -- seabed.SeabedManager.eventType = seabed.SeabedEventType.Def
    -- GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_SHOP_PANEL)


    GameDispatcher:dispatchEvent(EventName.REQ_SEABED_SHOP_QUIT)
end

function clearShopDic(self)
    for id, item in pairs(self.mShopDic) do
        item:poolRecover()
    end
    self.mShopDic = {}
end

function onClickClose(self)
    -- super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_TOP_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_ALL_PANEL)
end

function onBtnHideShowBuffClickHandler(self)
    self.mShowBuffInfo:SetActive(false)
    self:clearShowBuffList()
end

function onBtnBuffClickHandler(self)
    local buffList = seabed.SeabedManager:getCurBuffList()
    if #buffList == 0 then
        gs.Message.Show(_TT(111046))
        return
    end

    self.mTxtShowBuff.text = _TT(111047) .. #buffList
    self:clearShowBuffList()
    for i = 1, #buffList, 1 do
        local item = SimpleInsItem:create(self.mBuffItem, self.mShowBuffScroll.content, "mSeabedBuffItemBattle")
        local vo = seabed.SeabedManager:getSeabedBuffDataById(buffList[i])
        item:getChildGO("mBtnClick"):SetActive(false)
        item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(false)
        item:getChildGO("mImgBuffIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon), false)
        item:getChildGO("mTxtBuffName"):GetComponent(ty.Text).text = _TT(vo.name)
        item:getChildGO("mTxtBuffDes"):GetComponent(ty.Text).text = _TT(vo.des)
        item:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath("seabed/color_0"..vo.color..".png"), false)
        item:getChildGO("mIsNotHas"):SetActive(false)
        local timeSn = LoopManager:setTimeout(i*0.03,self,function ()
            item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(true)
            item.m_go:GetComponent(ty.UIDoTween):BeginTween()
        end)
        table.insert(self.mShowBuffAniList, timeSn)
        table.insert(self.mShowBuffList, item)
    end
    self.mShowBuffInfo:SetActive(true)
end

function onBtnCollClickHandler(self)
    local collectionList = seabed.SeabedManager:getCurCollectionList()
    if #collectionList == 0 then
        gs.Message.Show(_TT(111048))
        return
    end

    self.mTxtShowCollection.text = _TT(111049).. #collectionList
    self:clearShowBuffList()
    for i = 1, #collectionList, 1 do
        local item = SimpleInsItem:create(self.mBuffItem, self.mShowCollectionScroll.content, "mSeabedBuffItemBattle")
        local vo = seabed.SeabedManager:getSeabedCollectionDataById(collectionList[i])
        item:getChildGO("mBtnClick"):SetActive(false)
        item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(false)
        item:getChildGO("mImgBuffIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon), false)
        item:getChildGO("mTxtBuffName"):GetComponent(ty.Text).text = _TT(vo.name)
        item:getChildGO("mTxtBuffDes"):GetComponent(ty.Text).text = _TT(vo.des)
        item:getChildGO("mIsNotHas"):SetActive(false)
        item:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath("seabed/color_0"..vo.color..".png"), false)
        local timeSn = LoopManager:setTimeout(i*0.03,self,function ()
            item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(true)
            item.m_go:GetComponent(ty.UIDoTween):BeginTween()
        end)
        table.insert(self.mShowBuffAniList, timeSn)
        table.insert(self.mShowBuffList, item)
    end
    self.mShowCollectionInfo:SetActive(true)
end

function clearShowBuffList(self)
    self:clearShowBuffAniList()
    for i = 1, #self.mShowBuffList, 1 do
        self.mShowBuffList[i]:poolRecover()
    end
    self.mShowBuffList = {}
end

function clearShowBuffAniList(self)
    for i = 1, #self.mShowBuffAniList, 1 do
        LoopManager:clearTimeout(self.mShowBuffAniList[i])
    end
    self.mShowBuffAniList = {}
end

function clearAniList(self)
    for i = 1, #self.mAniList do
        LoopManager:clearTimeout(self.mAniList[i])
    end
    self.mAniList = {}
end

function onBtnHideShowCollectionClickHandler(self)
    self.mShowCollectionInfo:SetActive(false)
    self:clearShowBuffList()
end

return _M
