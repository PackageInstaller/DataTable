--[[ 
-----------------------------------------------------
@filename       : ActivityLimitShopGift
@Description    : 宣传推广页面1——1元礼包
@date           : 2023-06-08 19:22:18
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.activity.view.ActivityLimitShopGift', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivityLimitShopGift.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数,k
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mItemList={}
    self.mAwardList={}
    self.mTimeSn=nil
    self.mType=0
end

-- 初始化
function configUI(self)
    self.mItem = self:getChildGO("mItem")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mShopTrans = self:getChildTrans("mShopTrans")
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtRightTitle = self:getChildGO("mTxtRightTitle"):GetComponent(ty.Text)
end

--激活
function active(self,args)
    super.active(self)
    self.mType=args.type
    self:updateVeiw()
    GameDispatcher:addEventListener(EventName.UPDATE_LIMIT_SHOP_BUY_PANEL, self.updateVeiw, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:onCloseAllItem()
    GameDispatcher:removeEventListener(EventName.UPDATE_LIMIT_SHOP_BUY_PANEL, self.updateVeiw, self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtRightTitle.text = _TT(50084)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
end

function updateVeiw(self)
    local type = self.mType
    if activity.ActitvityExtraManager:getRemainingBuyNumByType(type)<=0 then
        self:close()
        return
    end
    self.mTxtTitle.text = activity.ActitvityExtraManager:getShopTypeConfigVoByType(type):getDesc()
    self:onCloseAllItem()
    for _, vo in ipairs(activity.ActitvityExtraManager:getLimitShopTypeDic()[type]) do
        local Item = SimpleInsItem:create(self.mItem, self.mShopTrans, "shopItem_2")
        for i, v in ipairs(vo:getAwardList()) do
            local PropGrid = PropsGrid:createByData({ tid = v.tid, num = v.num, parent = Item:getChildTrans("mTransItem"), scale = 1, showUseInTip = true })
            table.insert(self.mAwardList,PropGrid)
        end
        Item:addUIEvent("mBtnBuy",function ()
            if vo:getPayType() ~= MoneyType.MONEY then
                local isEnought, tips = MoneyUtil.judgeNeedMoneyCountByTid(vo:getPayType(), vo:getPrice(), true, true)
                if (isEnought) then
                    GameDispatcher:dispatchEvent(EventName.REQ_LIMIT_SHOP_BUY, { id = vo:getId(), num = 1 })
                else
                    UIFactory:alertMessge(tips, true, function()
                        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
                        self:close()
                    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
                    )
                end
            else
                local SuccCallBack=function ()
                    if activity.ActitvityExtraManager:getRemainingBuyNumByType(type)<=0 then
                        self:close()
                    end
                end
                recharge.sendRecharge(recharge.RechargeType.LIMITSHOP_GIFT, nil, vo:getId(),SuccCallBack)
            end
        end)
        local click = function ()
            local deltaTime = vo:getEndTime() - GameManager:getClientTime()
            self.mTxtTime.text = TimeUtil.getHMSByTime(deltaTime)
            return deltaTime
        end
        local data={Vo=vo,timeHandle=click}
        Item:setArgs(data)
        Item:getChildGO("mTxtMoney"):SetActive(vo:getPayType() == MoneyType.MONEY)
        Item:getChildGO("mImgMoney"):SetActive(vo:getPayType() ~= MoneyType.MONEY)
        Item:getChildGO("mIconIttem"):GetComponent(ty.AutoRefImage):SetImg(vo:getIcon(), true)
        Item:getChildGO("mImgMoney"):GetComponent(ty.AutoRefImage):SetImg(MoneyUtil.getMoneyIconUrlByTid(vo:getPayType()), true)
        Item:getChildGO("mTxtResidue"):SetActive(vo:getIsCanBuy())
        Item:getChildGO("mBtnSoldOut"):SetActive(not vo:getIsCanBuy())
        Item:getChildGO("mSoldOut"):SetActive(not vo:getIsCanBuy())
        Item:getChildGO("mImgValue"):SetActive(vo:getIsCanBuy())
        Item:getChildGO("mTxtSoldOut"):GetComponent(ty.Text).text = _TT(25011)
        Item:getChildGO("mTxtValue"):GetComponent(ty.Text).text = vo:getValue()
        Item:getChildGO("mTxtValueDes"):GetComponent(ty.Text).text = _TT(50085)
        Item:getChildGO("mTxtPrice"):GetComponent(ty.Text).text = vo:getPrice()
        Item:getChildGO("mTxtResidue"):GetComponent(ty.Text).text = vo:getResidue()
        self.mTxtRightTitle.gameObject:SetActive(vo:getBuyType()<=1)
        table.insert(self.mItemList,Item)  
    end
    self:addTimerHandle()
end

function addTimerHandle(self)
    if self.mTimeSn then
        LoopManager:removeTimerByIndex(self.mTimeSn)
        self.mTimeSn=nil
    end
    self:updateTime()
    self.mTimeSn = LoopManager:addTimer(1,0,self,self.updateTime)
end

function updateTime(self)
    for _, item in ipairs(self.mItemList) do
      local deltaTime= item:getArgs().timeHandle()
      if deltaTime<=0 then
        self:close()
        return
      end
    end
end

function onCloseAllItem(self)
    if #self.mItemList>0 then
        for _, item in ipairs(self.mItemList) do
            item:poolRecover()
            item=nil
        end
    end
    self.mItemList={}
    if #self.mAwardList>0 then
        for _, item in ipairs(self.mAwardList) do
            item:poolRecover()
            item=nil
        end
    end
    self.mAwardList={}
    if self.mTimeSn then
        LoopManager:removeTimerByIndex(self.mTimeSn)
        self.mTimeSn=nil
    end
end


return _M