module("game.activity.view.ActivityFashionHisView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("activity/ActivityFashionHisView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(138508))
    self:setSize(1120, 520)
end

function initData(self)
    self.mBuyItemList = {}
    self.mPropsGridList = {}
end

function configUI(self)
    super.configUI(self)
    self.mBuyScrollContent = self:getChildGO("mBuyScroll"):GetComponent(ty.ScrollRect).content
    self.mBuyItem = self:getChildGO("mBuyItem")
    
    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)
end

function initViewText(self)
end

function active(self, args)
    super.active(self, args)
    self.openType = args.type

    if self.openType == activity.FashionHisType.FashionPermit then
        self:setTxtTitle(_TT(138512))
    else
        self:setTxtTitle(_TT(138508))
    end

    --GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_FASHION_HIS_VIEW, self.showPanel, self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    --GameDispatcher:removeEventListener(EventName.UPDATE_ACTIVITY_FASHION_HIS_VIEW, self.showPanel, self)
    self:clearListItem()

    if self.mTimeSn then
        LoopManager:removeTimerByIndex(self.mTimeSn)
        self.mTimeSn=nil
    end
end

function showPanel(self)

    self:clearListItem()
    local list = activity.ActitvityExtraManager:getFashionHisDataByType(self.openType)
    for i = 1, #list, 1 do
        local isBuy = activity.ActitvityExtraManager:getFashionHisIsBuy(list[i].id)
        list[i].isBuy = isBuy
        list[i].isBuySort = isBuy and 1 or 0
    end

    table.sort(list, function(a, b) 
        if a.isBuySort == b.isBuySort then
            return a.id < b.id
        else
            return a.isBuySort < b.isBuySort
        end
       
     end)

    for i = 1, #list do
        local item = SimpleInsItem:create(self.mBuyItem, self.mBuyScrollContent, "mFashionHisBuyItem")
        local fashionVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, list[i].expiredFashion[1],
            list[i].expiredFashion[2])

        local url = UrlManager:getFashionShopBodyPath(fashionVo.fashionIcon)
        item:getChildGO("mIconFashion"):GetComponent(ty.AutoRefImage):SetImg(url, false)
        local tapList = fashionVo.tap
        item:getChildGO("mTag1"):SetActive(table.indexof01(tapList, 1) > 0)
        item:getChildGO("mTag2"):SetActive(table.indexof01(tapList, 2) > 0)
        item:getChildGO("mTag3"):SetActive(table.indexof01(tapList, 3) > 0)

        --local isBuy = activity.ActitvityExtraManager:getFashionHisIsBuy(list[i].id)
        item:getChildGO("mBtnBuy"):SetActive(list[i].isBuy == false)
        item:getChildGO("mIsBuy"):SetActive(list[i].isBuy)

        item:getChildGO("mTxtPrice"):GetComponent(ty.Text).text = "¥".. list[i].price/100

        local propsList = AwardPackManager:getAwardListById(list[i].dropId)
        for k,v in pairs( propsList) do
            local vo = props.PropsManager:getTypePropsVoByTid(v.tid)
            if vo.effectType ~= UseEffectType.ADD_HERO_FASHION_CLOTHES then
                local propsGrid = PropsGrid:createByData({
                    tid = v.tid,
                    num = v.num,
                    parent = item:getChildTrans("mPropsGridContent"),
                    scale = 0.37,
                    showUseInTip = true
                })
                table.insert(self.mPropsGridList, propsGrid)
            end
        end
        item:addUIEvent("mIconFashion", function()
            GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW, {
                heroTid = list[i].expiredFashion[1],
                fashionId = list[i].expiredFashion[2],
                isShow3D = true
            })
            self:close()
        end)

        item:addUIEvent("mBtnBuy", function()
            recharge.sendRecharge(recharge.RechargeType.FASHION_HISTORY, nil, list[i].id)
            self:close()
        end)

        table.insert(self.mBuyItemList, item)
    end

    self.mTxtTimer.gameObject:SetActive(self.openType == activity.FashionHisType.FashionPermit)
    if self.openType == activity.FashionHisType.FashionPermit then
        self:updateTime()
        self.updateSn = self:addTimer(1, 0, self.updateTime)
    end
end


function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.PermitFashionHis) then
        local clientTime = GameManager:getClientTime()
        local RemainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.PermitFashionHis)
            :getEndTime() - clientTime
        local timeTxt = RemainingTime <= 0 and "活动已结束" or _TT(3530) ..
                            TimeUtil.getFormatTimeBySeconds_9(RemainingTime)
        self.mTxtTimer.text = timeTxt
        if RemainingTime <= 0 then
            if self.mTimeSn then
                LoopManager:removeTimerByIndex(self.mTimeSn)
                self.mTimeSn=nil
            end
            self:close()
            return
        end
    end
end

function clearListItem(self)
    for i = 1, #self.mPropsGridList do
        self.mPropsGridList[i]:poolRecover()
    end
    self.mPropsGridList = {}

    for i = 1, #self.mBuyItemList do
        self.mBuyItemList[i]:poolRecover()
    end
    self.mBuyItemList = {}
end

return _M
