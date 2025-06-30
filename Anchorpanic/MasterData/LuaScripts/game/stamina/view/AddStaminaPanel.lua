--[[ 
    增加抗疫血清面板
]]
module("stamina.AddStaminaPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("stamina/AddStaminaPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是
isShowMoneyBar = 0 -- 是否显示货币栏 1开启（仅2弹窗有效）

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle(_TT(26301))
end

function initData(self)
    self.curStamina = stamina.StaminaManager:getStamina()
    self.mItemList = {}
    self.mNeedCost = 0
    self.mIsByProps = true
    self.mCallFun = nil
    self.mCallObj = nil
    self.mSelectList = {}
    self.mMoneyItemList = {}
end

function configUI(self)
    self.mBtnOk = self:getChildGO("mBtnOk")
    self.mImgNo = self:getChildGO("mImgNo")
    self.mBtnProps = self:getChildGO("mBtnProps")
    self.mBtnMoney = self:getChildGO("mBtnMoney")
    self.mBtnToProps = self:getChildGO("mBtnToProps")
    self.mContentProps = self:getChildTrans("Content")
    self.mGroupMoney = self:getChildGO("GroupByMoney")
    self.mGroupProps = self:getChildGO("GroupByProps")
    self.mBtnMoneyNomal = self:getChildGO("mBtnMoneyNomal")
    self.mBtnPropsNomal = self:getChildGO("mBtnPropsNomal")
    self.mBtnMoneySelect = self:getChildGO("mBtnMoneySelect")
    self.mBtnPropsSelect = self:getChildGO("mBtnPropsSelect")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mTxtName1 = self:getChildGO("mTxtName1"):GetComponent(ty.Text)
    self.mTxtName2 = self:getChildGO("mTxtName2"):GetComponent(ty.Text)
    self.mTxtCount1 = self:getChildGO("mTxtCount1"):GetComponent(ty.Text)
    self.mTxtCount2 = self:getChildGO("mTxtCount2"):GetComponent(ty.Text)
    self.mTxtRemaind = self:getChildGO("mTxtRemaind"):GetComponent(ty.Text)
    self.mTxtOwnNum2 = self:getChildGO("mTxtOwnNum2"):GetComponent(ty.Text)
    self.mTxtOwnNum1 = self:getChildGO("mTxtOwnNum1"):GetComponent(ty.Text)
    self.mTxtTimeOne = self:getChildGO("mTxtTimeOne"):GetComponent(ty.Text)
    self.mTxtTimeAll = self:getChildGO("mTxtTimeAll"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtHasingDes = self:getChildGO("mTxtHasingDes"):GetComponent(ty.Text)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mTxtTimeAllLab = self:getChildGO("mTxtTimeAllLab"):GetComponent(ty.Text)
    self.mTxtTimeOneLab = self:getChildGO("mTxtTimeOneLab"):GetComponent(ty.Text)
    self.mImgIconS1 = self:getChildGO("mImgIconS1"):GetComponent(ty.AutoRefImage)
    self.mImgIconS2 = self:getChildGO("mImgIconS2"):GetComponent(ty.AutoRefImage)
    self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.AutoRefImage)
    self.mGroupItem1 = self:getChildGO("mGroupItem1"):GetComponent(ty.AutoRefImage)
    self.mGroupItem2 = self:getChildGO("mGroupItem2"):GetComponent(ty.AutoRefImage)
    self.mTxtOk = self:getChildGO("mTxtOk"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self.args)
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.closeAll, self)
    self:updateItemList()
    if (args.isByProps == nil) then
        args.isByProps = true
    end
    if args.isByProps == true then
        local propsList = bag.BagManager:getPropsListByEffect(UseEffectType.ADD_STAMINA)
        if propsList ~= nil then
            self.mIsByProps = #propsList > 0
        else
            self.mIsByProps = false
        end
    else
        self.mIsByProps = false
    end
    self.isInit = true
    self.mNeedCost = args.needCost
    self.mCallFun = args.callFun
    self.mCallObj = args.callObj
    self:onClickBtnStateChangeHandler(self.mIsByProps == false)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    stamina.StaminaManager:addEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.onStaminaUpdateHandler, self)
    local propsVo = props.PropsManager:getPropsVo({ tid = MoneyTid.ANTIEPIDEMIC_SERUM_TID, num = 1 })
    self.mImgColor.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(propsVo.color))
    self.mImgColorBg.color = gs.ColorUtil.GetColor(ColorUtil:getPropBgColor(propsVo.color))
    self:timeStep()
    self.timeId = self:addTimer(1, 0, self.timeStep)
end

function deActive(self)
    super.deActive(self)
    self:recoverItemList()
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.closeAll, self)
    --self.base_childGos["MoneyBar"]:SetActive(true)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    stamina.StaminaManager:removeEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.onStaminaUpdateHandler, self)
    self:resetAllItem()
    self:initData()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtEmptyTip.text = _TT(4017) -- "-当前暂无道具-"
    self.mTxtTitle.text = _TT(26301) -- "抗疫血清兑换"
    self.mTxtHasingDes.text = _TT(26325)--"体力值："
    self.mTxtTimeOneLab.text = _TT(1208) -- "恢复1ml"
    self.mTxtTimeAllLab.text = _TT(1209) -- "恢复全部"
    self:setBtnLabel(self.mBtnToProps, 26305, "血清组")
    self:setBtnLabel(self.mBtnMoneyNomal, 72105, "源晶补给")
    self:setBtnLabel(self.mBtnPropsNomal, 72104, "道具补给")
    self:setBtnLabel(self.mBtnMoneySelect, 72105, "源晶补给")
    self:setBtnLabel(self.mBtnPropsSelect, 72104, "道具补给")
end

-- UI事件管理
function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnOk, self.onClickConfirmHandler)
    self:addUIEvent(self.mBtnMoney, self.onClickBtnStateChangeHandler, nil, true)
    self:addUIEvent(self.mBtnProps, self.onClickBtnStateChangeHandler, nil, false)
end

--MoneyBar
function updateItemList(self)
    local list = { MoneyTid.ITIANIUM_TID, MoneyTid.ANTIEPIDEMIC_SERUM_TID }
    for i = 1, #list do
        local item = MoneyItem:poolGet()
        item:setData(self.base_childTrans["MoneyBar"], { tid = list[i], frontType = self.frontType })
        item:getChildGO("mBtnGet"):SetActive(false)
        item:getChildGO("mBtnArea"):GetComponent(ty.Button).enabled = false
        table.insert(self.mMoneyItemList, item)
    end
end
--回收MoneyBar
function recoverItemList(self)
    if #self.mMoneyItemList > 0 then
        for _, item in pairs(self.mMoneyItemList) do
            item:poolRecover()
        end
        self.mMoneyItemList = {}
    end
end


function timeStep(self)
    local refreshTime = stamina.StaminaManager:nextAddTime()
    local refreshAllTime = stamina.StaminaManager:allAddTime()
    local clientTime = GameManager:getClientTime()
    local time = refreshTime - clientTime
    local timeAll = refreshAllTime - clientTime
    if timeAll <= 0 then
        self.mTxtTimeOne.text = _TT(26327)--"已达上限"
        self.mTxtTimeAll.text = _TT(26327)--"已达上限"
        return
    end
    self.mTxtTimeOne.text = TimeUtil.getHMSByTime(time)
    self.mTxtTimeAll.text = TimeUtil.getHMSByTime(timeAll)
end

function resetAllItem(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i]
        item:destroy()
        item:poolRecover()
        table.remove(self.mItemList, i)
    end
    self.mItemList = {}
    self.mSelectList = {}
end

function onClickConfirmHandler(self)
    local limitTimes = stamina.StaminaManager:limitTimes()
    local buyTimes = stamina.StaminaManager:buyTimes()
    if buyTimes >= limitTimes then
        -- gs.Message.Show("剩余次数为0")
        gs.Message.Show(_TT(26309))
        return
    end

    local exchangeVo = stamina.StaminaManager:getExchangeVo(buyTimes + 1) -- buyTimes是从0开始
    local count = MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID)
    if exchangeVo.stamina + count > sysParam.SysParamManager:getValue(SysParamType.MAX_STAMINA) then
        -- gs.Message.Show("已超过血清上限，无法兑换")
        gs.Message.Show(_TT(26310))
        return
    end
    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.ITIANIUM_TID, exchangeVo.costIianium, true, true)
    if result and tips == "" then
        GameDispatcher:dispatchEvent(EventName.REQ_BUY_STAMINA)
    elseif result and tips ~= "" then
        UIFactory:alertMessge(tips, true, function()
            GameDispatcher:dispatchEvent(EventName.REQ_BUY_STAMINA)
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
        )
    elseif not result then
        UIFactory:alertMessge(tips, true, function()
            if MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) > 0 and MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) >= exchangeVo.costIianium then
                GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW)
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
            end
            self:close()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
        )
    end
end


function onStaminaUpdateHandler(self)
    local myStamina = stamina.StaminaManager:getStamina()
    -- 大于1才弹，自然恢复是1，所以不弹
    if self.curStamina and (myStamina - self.curStamina) > 1 then
        -- gs.Message.Show("恢复血清：" .. (myStamina - self.curStamina))
        gs.Message.Show(_TT(26311, (myStamina - self.curStamina)))
    end
    self.curStamina = myStamina
    if self.mCallFun and myStamina >= self.mNeedCost then
        self.mCallFun(self.mCallObj)
        self:close()
    else
        self:updateView()
    end
end

function onBagUpdateHandler(self)
    self:updateView()
end

function updateView(self)
    if self.mIsByProps then
        self:updatePropsView()
    else
        self:updateMoneyView()
    end
end

function updateMoneyView(self)
    local buyTimes = stamina.StaminaManager:buyTimes()
    local exchangeVo = stamina.StaminaManager:getExchangeVo(buyTimes + 1) -- buyTimes是从0开始
    local colorStr = MoneyUtil.getMoneyCountByTid(MoneyTid.ITIANIUM_TID) < exchangeVo.costIianium and "ed1941ff" or "ffffffff"
    self.mTxtOwnNum1.text = MoneyUtil.getMoneyCountByTid(MoneyTid.ITIANIUM_TID)
    self.mImgIconS1:SetImg(UrlManager:getPropsIconUrl(MoneyTid.ITIANIUM_TID), true)

    self.mTxtCount1.text = " X" .. exchangeVo.costIianium
    self.mTxtCount2.text = " X" .. exchangeVo.stamina

    self.mBtnOk:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0163.png"), false)
    self.mTxtOk.text = _TT(3532)
    local limitTimes = stamina.StaminaManager:limitTimes()
    local buyTimes = stamina.StaminaManager:buyTimes()
    if (limitTimes <= 0) then
        self.mTxtRemaind.text = ""
    else
        if limitTimes <= buyTimes then
            self.mBtnOk:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0222.png"), false)
            self.mTxtOk.text = _TT(26330)
        end
        local colorStr = limitTimes <= buyTimes and "bd2a2a" or "202226"
        local timeStr = HtmlUtil:color((limitTimes - buyTimes), colorStr)
        self.mTxtRemaind.text = _TT(26312, timeStr)
    end

    local propsVo1 = props.PropsManager:getPropsVo({ tid = MoneyTid.ITIANIUM_TID, num = 1 })
    self.mTxtName1.text = propsVo1.name
    self.mGroupItem1:SetImg(UrlManager:getPropsIconUrl(MoneyTid.ITIANIUM_TID), false)

    local propsVo2 = props.PropsManager:getPropsVo({ tid = MoneyTid.ANTIEPIDEMIC_SERUM_TID, num = 1 })
    self.mTxtName2.text = propsVo2.name
    self.mGroupItem2:SetImg(UrlManager:getPropsIconUrl(MoneyTid.ANTIEPIDEMIC_SERUM_TID), false)
end

function updatePropsView(self)

    self:resetAllItem()
    local propsList = bag.BagManager:getPropsListByEffect(UseEffectType.ADD_STAMINA)
    self.mImgNo:SetActive(#propsList <= 0)
    table.sort(propsList, function(a, b)
        return a.tid < b.tid
    end)
    if (#propsList > 0) then
        for i = 1, #propsList do
            local item = stamina.AddStaminaPropsItem.new()
            propsList[i].tweenId = i
            item:setData(self.mContentProps, propsList[i])
            if self.isInit then
                item:onStart()
            end
            table.insert(self.mItemList, item)
        end
        self.isInit = false
    end
end

function onClickBtnStateChangeHandler(self, isMoney)
    self.mIsByProps = not isMoney

    if isMoney == false then
        self.isInit = true
        self.mBtnPropsSelect:SetActive(true)
        self.mBtnMoneySelect:SetActive(false)
        self:setBtnLabel(self.mBtnOk, 26328, "使用")
    else
        self.mBtnPropsSelect:SetActive(false)
        self.mBtnMoneySelect:SetActive(true)
        self:setBtnLabel(self.mBtnOk, 26329, "购买")
    end
    self.mBtnMoneyNomal:SetActive(self.mBtnPropsSelect.activeSelf == true)
    self.mBtnPropsNomal:SetActive(self.mBtnMoneySelect.activeSelf == true)
    self.mGroupMoney:SetActive(self.mBtnMoneySelect.activeSelf == true)
    self.mGroupProps:SetActive(self.mBtnPropsSelect.activeSelf == true)

    self:updateView()
end
-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

function onClickClose(self)
    self:close()
end

function closeAll(self)
    super.closeAll(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]