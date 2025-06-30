module("cycle.CycleShopPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleShopPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("cycle_bg_003.jpg", false, "cycle")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mShopItemList = {}

    self.mInvestAllItems = {}
    self.mNowGoodId = 0
end

-- 初始化
function configUI(self)
    super.configUI(self)

    ---------------------------------------------------  bgInfo  ---------------------------------------------------
    self.mBgGroup = self:getChildGO("mBgGroup")
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtShopInfo = self:getChildGO("mTxtShopInfo"):GetComponent(ty.Text)

    ---------------------------------------------------  shopInfo  ---------------------------------------------------
    self.mShopGroup = self:getChildGO("mShopGroup")
    self.mShopScrollView = self:getChildGO("mShopScrollView"):GetComponent(ty.ScrollRect)
    self.mBtnShopClose = self:getChildGO("mBtnShopClose")
    self.mTxtResetCost = self:getChildGO("mTxtResetCost"):GetComponent(ty.Text)
    self.mBtnShopReset = self:getChildGO("mBtnShopReset")

    self.mShopItem = self:getChildGO("mShopItem")

    ---------------------------------------------------  investInfo  ---------------------------------------------------
    self.mInvestInfo = self:getChildGO("mInvestInfo")

    ---------------------------------------------------==  mainInfo  ==---------------------------------------------------
    self.mInvestMainInfo = self:getChildGO("mInvestMainInfo")
    self.mBtnAllInvestBuff = self:getChildGO("mBtnAllInvestBuff")
    self.mTxtAllInvestBuff = self:getChildGO("mTxtAllInvestBuff"):GetComponent(ty.Text)

    self.mTxtMainDes = self:getChildGO("mTxtMainDes"):GetComponent(ty.Text)
    self.mTxtRem = self:getChildGO("mTxtRem"):GetComponent(ty.Text)
    self.mTxtRemValue = self:getChildGO("mTxtRemValue"):GetComponent(ty.Text)

    self.mBtnInv = self:getChildGO("mBtnInv")
    self.mTxtInvInfo = self:getChildGO("mTxtInvInfo"):GetComponent(ty.Text)
    self.mTxtInvDes = self:getChildGO("mTxtInvDes"):GetComponent(ty.Text)

    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mTxtGetInfo = self:getChildGO("mTxtGetInfo"):GetComponent(ty.Text)
    self.mTxtGetDes = self:getChildGO("mTxtGetDes"):GetComponent(ty.Text)

    self.mBtnMainRet = self:getChildGO("mBtnMainRet")
    self.mTxtMainRet = self:getChildGO("mTxtMainRet"):GetComponent(ty.Text)
    ---------------------------------------------------==  investInfo  ==---------------------------------------------------
    self.mInvestAllInfo = self:getChildGO("mInvestAllInfo")

    self.mTxtAllInfo = self:getChildGO("mTxtAllInfo"):GetComponent(ty.Text)
    self.mTxtMax = self:getChildGO("mTxtMax"):GetComponent(ty.Text)

    self.mTxtMaxValue = self:getChildGO("mTxtMaxValue"):GetComponent(ty.Text)

    self.mBtnAllRet = self:getChildGO("mBtnAllRet")
    self.mInvestScroll = self:getChildGO("mInvestScroll"):GetComponent(ty.ScrollRect)
    self.mInvestItem = self:getChildGO("mInvestItem")

    ---------------------------------------------------==  investGetInfo  ==---------------------------------------------------
    self.mInvestGetInfo = self:getChildGO("mInvestGetInfo")

    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)
    self.mTxtGetRem = self:getChildGO("mTxtGetRem"):GetComponent(ty.Text)
    self.mTxtGetValue = self:getChildGO("mTxtGetValue"):GetComponent(ty.Text)
    self.mTxtGetDesInfo = self:getChildGO("mTxtGetDesInfo"):GetComponent(ty.Text)

    self.mLyGetNumberStepper = self:getChildGO("mLyGetNumberStepper"):GetComponent(ty.LyNumberStepper)

    self.mBtnGetRet = self:getChildGO("mBtnGetRet")
    self.mBtnGetSure = self:getChildGO("mBtnGetSure")

    ---------------------------------------------------==  investInvInfo  ==---------------------------------------------------
    self.mInvestInvInfo = self:getChildGO("mInvestInvInfo")

    self.mTxtInv = self:getChildGO("mTxtInv"):GetComponent(ty.Text)
    self.mTxtInvRem = self:getChildGO("mTxtInvRem"):GetComponent(ty.Text)

    self.mTxtInvValue = self:getChildGO("mTxtInvValue"):GetComponent(ty.Text)
    self.mTxtInvDesInfo = self:getChildGO("mTxtInvDesInfo"):GetComponent(ty.Text)

    self.mLyInvNumberStepper = self:getChildGO("mLyInvNumberStepper"):GetComponent(ty.LyNumberStepper)
    self.mBtnInvRet = self:getChildGO("mBtnInvRet")
    self.mBtnInvSure = self:getChildGO("mBtnInvSure")

    ---------------------------------------------------==  mRecruitInfo  ==---------------------------------------------------
    self.mRecruitInfo = self:getChildGO("mRecruitInfo")
    self.mBtnSure = self:getChildGO("mBtnSure")
    self.mBtnCancle = self:getChildGO("mBtnCancle")
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
    self.mTxtTip1 = self:getChildGO("mTxtTip1"):GetComponent(ty.Text)
    self.mTitle = self:getChildGO("mTitle"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mImgCoinIcon = self:getChildGO("mImgCoinIcon"):GetComponent(ty.AutoRefImage)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtHeroName.text = _TT(27548)
    self.mTxtName.text = _TT(27549)
    self.mTxtShopInfo.text = _TT(27550)

    self.mTxtAllInvestBuff.text = _TT(27570)
    self.mTxtMainDes.text = _TT(27571)
    self.mTxtRem.text = _TT(27572)

    self.mTxtInvInfo.text = _TT(27573)
    self.mTxtInvDes.text = _TT(27574)

    self.mTxtGetInfo.text = _TT(27575)
    self.mTxtGetDes.text = _TT(27576)

    self.mTxtMainRet.text = _TT(27577)
    self.mTxtAllInfo.text = _TT(27578)

    self.mTxtMax.text = _TT(27579)

    self.mTxtGet.text = _TT(27575)
    self.mTxtGetRem.text = _TT(27572)
    self.mTxtGetDesInfo.text = _TT(27580)

    self.mTxtInv.text = _TT(27573)
    self.mTxtInvRem.text = _TT(27572)
    self.mTxtInvDesInfo.text = _TT(27581)
end

function active(self, args)
    super.active(self)
    MoneyManager:setMoneyTidList({})
 

    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_SHOP_PANEL, self.onUpdateHandler, self)

    self.openType = args.openType
    self:defShow()
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    self:clearShopItemList()
    self:clearInvestAllItems()
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_SHOP_PANEL, self.onUpdateHandler, self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addOnClick(self.mBtnShopClose, self.onBtnShopCloseClickHandler)
    self:addOnClick(self.mBtnShopReset, self.onBtnShopRefeshClickHandler)

    self:addOnClick(self.mBtnAllInvestBuff, self.onBtnAllInvestBuffClickHandler)
    self:addOnClick(self.mBtnInv, self.onBtnInvClickHandler)
    self:addOnClick(self.mBtnGet, self.onBtnGetClickHandler)
    self:addOnClick(self.mBtnMainRet, self.onBtnMainRetClickHandler)

    self:addOnClick(self.mBtnAllRet, self.onBtnAllRetClickHandler)

    self:addOnClick(self.mBtnGetRet, self.onBtnGetRetClickHandler)
    self:addOnClick(self.mBtnGetSure, self.onBtnGetSureClickHandler)

    self:addOnClick(self.mBtnInvRet, self.onBtnInvRetClickHandler)
    self:addOnClick(self.mBtnInvSure, self.onBtnInvSureClickHandler)

    self:addOnClick(self.mBtnSure, self.onSureBuyRecruit)
    self:addOnClick(self.mBtnCancle, self.onCancleBuyRecruit)
end

-- 投资奖赏界面
function onBtnAllInvestBuffClickHandler(self)
    self.mInvestMainInfo:SetActive(false)
    self.mInvestAllInfo:SetActive(true)
end

-- 投资入口
function onBtnInvClickHandler(self)
    self.mInvestMainInfo:SetActive(false)
    self.mInvestInvInfo:SetActive(true)
end

-- 提取入口
function onBtnGetClickHandler(self)
    if cycle.CycleManager:getCanWithdraw() == 1 then
        self.mInvestMainInfo:SetActive(false)
        self.mInvestGetInfo:SetActive(true)
    else
        gs.Message.Show(_TT(27582))
    end
end

-- 主界面返回按钮
function onBtnMainRetClickHandler(self)
    self.mInvestMainInfo:SetActive(false)
    self.mShopGroup:SetActive(true)
end

-- 奖赏界面返回点击
function onBtnAllRetClickHandler(self)
    self.mInvestMainInfo:SetActive(true)
    self.mInvestAllInfo:SetActive(false)
end

-- 提取界面返回点击
function onBtnGetRetClickHandler(self)
    self.mInvestMainInfo:SetActive(true)
    self.mInvestGetInfo:SetActive(false)
end

-- 存钱界面返回点击
function onBtnInvRetClickHandler(self)
    self.mInvestMainInfo:SetActive(true)
    self.mInvestInvInfo:SetActive(false)
end

function onBtnShopCloseClickHandler(self)
    local cellId = cycle.CycleManager:getCurrentCell()
    local cellMsgVo = cycle.CycleManager:getCellDataById(cellId)

    GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
        cellId = cellId,
        args = { cellMsgVo.normalArgs[1] }
    })
end

function onBtnShopRefeshClickHandler(self)
    if self.remTimer > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_REFRESH_SHOP)
    else
        gs.Message.Show(_TT(27583))
    end
end

-- 确认购买招募券
function onSureBuyRecruit(self)
    local coin = cycle.CycleManager:getResourceInfo().coin
    --local vo = cycle.CycleManager:getCycleShopData(self.mNowGoodId)

    local price = cycle.CycleManager:getGoodsMsgDataPrice(self.mNowGoodId)

    if coin >= price then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_SHOP_BUY, {
            goodsId = self.mNowGoodId
        })
    else
        gs.Message.Show(_TT(27585))
    end
    self:onCancleBuyRecruit()
end

-- 取消购买招募券
function onCancleBuyRecruit(self)
    self.mShopGroup:SetActive(true)
    self.mRecruitInfo:SetActive(false)
end

function onUpdateHandler(self)
    self:showPanel()
end

function defShow(self)
    -- 默认打开商店
    if self.openType == OPEN_DEF_TYPE.SHOP then

        --self:initInvAndGetInfo()
        self.mShopGroup:SetActive(true)

        self.mInvestMainInfo:SetActive(false)
        self.mInvestAllInfo:SetActive(false)
        self.mInvestGetInfo:SetActive(false)
        self.mInvestInvInfo:SetActive(false)
        self.mRecruitInfo:SetActive(false)
        self.base_childGos["mGroupTop"]:SetActive(true)
        -- 仅仅打开无限投资查看界面
    elseif self.openType == OPEN_DEF_TYPE.INVESTALL then
        self.mShopGroup:SetActive(false)
        self.mInvestAllInfo:SetActive(true)

        self.mInvestMainInfo:SetActive(false)
        self.mInvestGetInfo:SetActive(false)
        self.mInvestInvInfo:SetActive(false)
        self.mRecruitInfo:SetActive(false)
        self.mBtnAllRet:SetActive(false)
        self.base_childGos["mGroupTop"]:SetActive(false)
        --mTopGroup
    end
end

function showPanel(self)

    GameDispatcher:dispatchEvent(EventName.SHOW_CYCLE_TOP_PANEL)
    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
        title = _TT(27523),
        showTypeList = { TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON, TOP_SHOW_TYPE.COIN, TOP_SHOW_TYPE.HOPE, TOP_SHOW_TYPE.BUFFLIST, TOP_SHOW_TYPE.FORMATION,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR }
    })
    
    if self.openType == OPEN_DEF_TYPE.SHOP then
        self:updateGoodsInfo()
        self:initInvAndGetInfo()

        self.mBtnGet:GetComponent(ty.Button).interactable = cycle.CycleManager:getCanWithdraw() == 1
    end
    self:updateInvestAllInfo()
end

function updateGoodsInfo(self)
    local goodsMsgData, curticket = cycle.CycleManager:getGoodsMsgData()

    if curticket ~= 0 then
        cycle.CycleManager:setCurTicketAndType(curticket, RECUIT_TYPE.SHOP)
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_HERO_SELECT_PANEL)
    end

    local goodsList = {}
    for k, v in pairs(goodsMsgData) do
        table.insert(goodsList, v)
    end
    table.sort(goodsList, function(vo1, vo2)
        return vo1.id < vo2.id
    end)

    local cellId = cycle.CycleManager:getCurrentCell()
    local cellMsgVo = cycle.CycleManager:getCellDataById(cellId)
    -- 开启了投资商店
    if cellMsgVo.normalArgs[1] == 1 then
        local goodMsgVo = cycle.CycleGoodMsgVo.new()
        goodMsgVo.id = -1
        goodMsgVo.type = GOODS_TYPE.INVEST
        goodMsgVo.isBuy = 0
        table.insert(goodsList, 1, goodMsgVo)
    end

    self:clearShopItemList()

    local coin = cycle.CycleManager:getResourceInfo().coin
    for i = 1, #goodsList do
        local item = SimpleInsItem:create(self.mShopItem, self.mShopScrollView.content, "CycleShopPanelgoodsList")
        local msgVo = goodsList[i]
        item:getChildGO("type1"):SetActive(msgVo.type == GOODS_TYPE.BUFF)
        item:getChildGO("type2"):SetActive(msgVo.type == GOODS_TYPE.TICKET)
        item:getChildGO("type3"):SetActive(msgVo.type == GOODS_TYPE.INVEST)
        item:getChildGO("mIsNotHas"):SetActive(false)


        if msgVo.type == GOODS_TYPE.BUFF then
            local shopData = cycle.CycleManager:getCycleShopData(msgVo.id)
            local collectionData = cycle.CycleManager:getCycleCollectionDataById(shopData.param)
            item:getChildGO("mImgBuff"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCycelCollectionIcon(collectionData.icon), false)
            item:getChildGO("mTxtBuffName"):GetComponent(ty.Text).text = _TT(collectionData.name)
            item:getChildGO("mTxtBuffDes"):GetComponent(ty.Text).text = _TT(collectionData.des)


            item:getChildGO("mTxtPriceType1"):GetComponent(ty.Text).text = msgVo.price
            item:getChildGO("mTxtPriceType1"):GetComponent(ty.Text).color = coin >= msgVo.price and gs.ColorUtil.GetColor("ffffffff") or gs.ColorUtil.GetColor("f94234ff")
            item:getChildGO("mIsNotHas"):SetActive(not cycle.CycleManager:getCycleCollageCanHas(shopData.param) and msgVo.isBuy == 0)
            item:getChildGO("mTxtNotHas"):GetComponent(ty.Text).text = _TT(77856)

            if collectionData.eleType == -1 then
                item:getChildGO("mImgEleType"):SetActive(false)
            else
                item:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(collectionData.eleType), false)
                item:getChildGO("mImgEleType"):SetActive(true)
            end    
        elseif msgVo.type == GOODS_TYPE.TICKET then

            local shopData = cycle.CycleManager:getCycleShopData(msgVo.id)

            local recruitVo = cycle.CycleManager:getCycleRecruitData(shopData.param)

            item:getChildGO("mTxtTicketName"):GetComponent(ty.Text).text = _TT(recruitVo.name)
            item:getChildGO("mTxtPriceType2"):GetComponent(ty.Text).text = msgVo.price
            item:getChildGO("mTxtPriceType2"):GetComponent(ty.Text).color = coin >= msgVo.price and gs.ColorUtil.GetColor("ffffffff") or gs.ColorUtil.GetColor("f94234ff")
            item:getChildGO("mImgTicket"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(recruitVo.icon), false)

        elseif msgVo.type == GOODS_TYPE.INVEST then

        end

        item:getChildGO("isBuy"):SetActive(msgVo.isBuy == 1)
        self:addUIEvent(item:getChildGO("mBtnClick"), self.onShopItemClick, nil, msgVo)
        table.insert(self.mShopItemList, item)
    end

    self.remTimer = cycle.CycleManager:getCycleShopRefeshTimes()
    self.mTxtResetCost.text = _TT(27584) .. self.remTimer

    if self.remTimer <= 0 then
        self.mTxtResetCost.gameObject:SetActive(false)
        self.mBtnShopReset:SetActive(false)
    end
end

function updateInvestAllInfo(self)
    self:clearInvestAllItems()
    local maxValue = cycle.CycleManager:getInvestMaxValue()
    self.mTxtMaxValue.text = maxValue

    local dic = cycle.CycleManager:getCycleInvestShopData()
    for k, v in pairs(dic) do
        --过滤满级
        if v.needCoin > 0 then
            local item = SimpleInsItem:create(self.mInvestItem, self.mInvestScroll.content, "CycleShopPanelinvestItem")
            item:getChildGO("mTxtDes"):GetComponent(ty.Text).text = _TT(v.des)
            item:getChildGO("mTxtNeedCoin"):GetComponent(ty.Text).text = v.needCoin

            local cg = item:getChildGO("mGroupItem"):GetComponent(ty.CanvasGroup)
            local img = item:getChildGO("mImgState"):GetComponent(ty.AutoRefImage)
            if v.needCoin <= maxValue then
                cg.alpha = 1
                img:SetImg(UrlManager:getCommon5Path("common_0145.png"), false)
            else
                cg.alpha = 0.5
                img:SetImg(UrlManager:getCommon5Path("common_0085.png"), false)
            end

            table.insert(self.mInvestAllItems, item)
        end

    end
end

function clearInvestAllItems(self)
    for i = 1, #self.mInvestAllItems do
        self.mInvestAllItems[i]:poolRecover()
    end
    self.mInvestAllItems = {}
end

function onShopItemClick(self, vo)
    cusLog("点击了商店购买" .. vo.id)
    self.mNowGoodId = vo.id
    if vo.type == GOODS_TYPE.INVEST then
        self.mInvestMainInfo:SetActive(true)
        self.mShopGroup:SetActive(false)
        return
    elseif vo.type == GOODS_TYPE.TICKET or vo.type == GOODS_TYPE.BUFF then
        self.mRecruitInfo:SetActive(true)
        self:updateRecruitInfo()
        self.mShopGroup:SetActive(false)
        return
    end

    local coin = cycle.CycleManager:getResourceInfo().coin

    local price = cycle.CycleManager:getGoodsMsgDataPrice( self.mNowGoodId)
    if coin >= price then
        local cellId = cycle.CycleManager:getCurrentCell()
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_SHOP_BUY, {
            goodsId = vo.id
        })
    else
        gs.Message.Show(_TT(27585))
    end
end

function updateRecruitInfo(self)
    local shopData = cycle.CycleManager:getCycleShopData(self.mNowGoodId)
    local vo = nil
    if shopData.type == GOODS_TYPE.TICKET then
        vo = cycle.CycleManager:getCycleRecruitData(shopData.param)
        self.mImgIcon:SetImg(UrlManager:getIconPath(vo.icon))
        self.mTxtDes.text = _TT(vo.des)
    elseif shopData.type == GOODS_TYPE.BUFF then
        vo = cycle.CycleManager:getCycleCollectionDataById(shopData.param)
        self.mImgIcon:SetImg(UrlManager:getCycelCollectionIcon(vo.icon))
        self.mTxtDes.text = _TT(vo.des2)
    end
    self.mTitle.text = _TT(vo.name)

    --local coin = cycle.CycleManager:getResourceInfo().coin
    local price = cycle.CycleManager:getGoodsMsgDataPrice(self.mNowGoodId)
    self.mTxtTip.text =  _TT(77857) --"是否消耗:"



    self.mTxtTip1.text = _TT(77858, price, _TT(vo.name))
end

function clearShopItemList(self)
    for i = 1, #self.mShopItemList do
        self.mShopItemList[i]:poolRecover()
    end
    self.mShopItemList = {}
end

function initInvAndGetInfo(self)
    -- 存有的
    local historyCount = cycle.CycleManager:getInvestCurrentCoin()
    -- 现有的
    local hasCount = cycle.CycleManager:getResourceInfo().coin
    self.mTxtRemValue.text = historyCount
    self.mTxtGetValue.text = historyCount
    self.mTxtInvValue.text = historyCount

    local getCount = cycle.CycleManager:getInvestWithdrawCoinLimit()
    local getMax = sysParam.SysParamManager:getValue(4507)

    local invCount = cycle.CycleManager:getInvestDepositCoinLimit()
    local invMax = sysParam.SysParamManager:getValue(4506)

    local canGetMax = getMax - getCount
    canGetMax = gs.Mathf.Clamp(canGetMax, 0, historyCount)

    local canInvMax = invMax - invCount
    canInvMax = gs.Mathf.Clamp(canInvMax, 0, hasCount)

    self.mLyGetNumberStepper:Init(canGetMax, 0, 1, canGetMax, self.onStepChange, self)
    self.mLyInvNumberStepper:Init(canInvMax, 0, 1, canInvMax, self.onStepChange, self)
end

function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        gs.Message.Show(_TT(27609))
    elseif cusType == 2 then
        gs.Message.Show(_TT(27610))
    end
end

-- 存钱界面取钱确认点击
function onBtnInvSureClickHandler(self)
    if self.mLyInvNumberStepper.CurrCount > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_DEPOSIT_COIN, {
            coin = self.mLyInvNumberStepper.CurrCount
        })
    else
        gs.Message.Show(_TT(27586))
    end
end

-- 提取界面取钱确认点击
function onBtnGetSureClickHandler(self)
    if cycle.CycleManager:getCanWithdraw() == 1 then
        if self.mLyGetNumberStepper.CurrCount > 0 then
            GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_DEPOSIT_COIN, {
                coin = -self.mLyGetNumberStepper.CurrCount
            })
        else
            gs.Message.Show(_TT(27587))
        end
    else
        gs.Message.Show(_TT(27588))
    end

end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27588):	"暂时还没有解锁取钱功能"
	语言包: _TT(27587):	"请至少取一个货币"
	语言包: _TT(27586):	"请至少存一个货币"
	语言包: _TT(27585):	"货币不足"
	语言包: _TT(27584):	"剩余刷新次数:"
	语言包: _TT(27585):	"货币不足"
	语言包: _TT(27583):	"无法继续刷新商店"
	语言包: _TT(27582):	"暂未解锁取钱功能"
	语言包: _TT(27523):	"商店"
	语言包: _TT(27581):	"请选择你要存储的货币数"
	语言包: _TT(27572):	"余额"
	语言包: _TT(27573):	"投资入口"
	语言包: _TT(27580):	"请选择你要取出的货币数"
	语言包: _TT(27572):	"余额"
	语言包: _TT(27575):	"余额提取"
	语言包: _TT(27579):	"历史最高"
	语言包: _TT(27578):	"投资奖励的解锁状态将在探索结束后更新"
	语言包: _TT(27577):	"返回"
	语言包: _TT(27576):	"提取投资存储余额"
	语言包: _TT(27575):	"余额提取"
	语言包: _TT(27574):	"用本次代币投资"
	语言包: _TT(27573):	"投资入口"
	语言包: _TT(27572):	"余额"
	语言包: _TT(27571):	"余额会在每次探索中继承"
	语言包: _TT(27570):	"查看投资奖赏"
	语言包: _TT(27550):	"中国有句古话:xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	语言包: _TT(27549):	"伊西丝"
	语言包: _TT(27548):	"古怪商人"
]]