--[[ 
-----------------------------------------------------
@filename       : MoneyItem
@Description    : 货币栏item
@date           : 2022-05-30 16:07:23
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('money.MoneyItem', Class.impl(BaseReuseItem))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("money/MoneyItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 析构  
function dtor(self)
end

function initData(self)
    self.isSelect = false
    self.isBeMutex = false
end

-- 初始化
function configUI(self)
    self.mImgIconGo = self:getChildGO("mImgIcon")
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnArea = self:getChildGO("mBtnArea")
end

-- 激活
function active(self)
    super.active(self)

    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onPlayerMoneyUpdateHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)

    -- 其他途径主动更新货币（所有其他货币更新以外都走这条消息, 不要加模块的消息在这里）
    GameDispatcher:addEventListener(EventName.MONEY_BAR_UPDATE, self.onOtherUpdateMoney, self)

end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onPlayerMoneyUpdateHandler,
    self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)

    -- 其他途径主动更新货币（所有其他货币更新以外都走这条消息, 不要加模块的消息在这里）
    GameDispatcher:removeEventListener(EventName.MONEY_BAR_UPDATE, self.onOtherUpdateMoney, self)

end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mImgIconGo, self.onIconClick)
    self:addUIEvent(self.mBtnGet, self.onGetClick)
    self:addUIEvent(self.mBtnArea, self.onAreaClick)
end

-- 打开快捷购买窗口
function checkOpenShopBuyPanel(self, shopType, tid)
    local shopVo = shop.ShopManager:getShopItemByTid(shopType, tid)
    if shopVo then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_PANEL, shopVo)
        return true
    else
        return false
    end
end

-- 玩家货币改变
function onPlayerMoneyUpdateHandler(self, cusTid)

    if noviceActivity.NoviceActivityManager:getNoviceUpdate() == false then
        --noviceActivity.NoviceActivityManager:setTodoEvent(self.updateCount,self)
        return
    end

    if cusTid == self.mTid then
        self:updateCount()
    end
end

-- 其他途径主动更新货币（所有其他货币更新以为都走这条消息）
function onOtherUpdateMoney(self, cusTid)
    if cusTid == self.mTid then
        self:updateCount()
    end
end

-- 背包更新
function onBagUpdateHandler(self)
    if table.indexof(PROPS_MONEY_TID_LIST, self.mTid) ~= false then
        self:updateCount()
    end
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mTid = cusData.tid
    self.mType = cusData.frontType

    self:updateMoneyIcon()
    self:updateCount()
    self:updateGetBtn()
end

-- 更新货币图标
function updateMoneyIcon(self)
    self.mImgIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.mTid), true)
end

-- 更新货币数
function updateCount(self)
    if self.mType == 2 then
        self.mTxtCount.color = gs.ColorUtil.GetColor("40484Bff")
    else
        self.mTxtCount.color = gs.ColorUtil.GetColor("ffffffff")
    end
    self.mTxtCount.text = self:getMoneyFormat()
end

-- 更新获取按钮
function updateGetBtn(self)
    if self.mType == 2 then
        self.mBtnGet:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0177.png"), false)
    else
        self.mBtnGet:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0176.png"), false)
    end

    local isShow = false
    local showTidList = {
        MoneyTid.GOLD_COIN_TID,
        MoneyTid.ITIANIUM_TID,
        MoneyTid.ANTIEPIDEMIC_SERUM_TID,
        -- MoneyTid.PAY_ITIANIUM_TID,
        MoneyTid.RECRUIT_TOP_TICKET_TID,
        MoneyTid.RECRUIT_ACT_TICKET_TID,
        MoneyTid.ARENA_CHALLENGE_TICKET_TID,
        MoneyTid.RECRUIT_ACT_TICKET_TID,
        MoneyTid.UAV_TID,
        MoneyTid.RECRUIT_BRACELETS_TICKET_TID,
        MoneyTid.RECRUIT_ACT_BRACELETS_TICKET_TID,
        MoneyTid.FASHION_TID,
        MoneyTid.ITEM_2171, MoneyTid.ITEM_2172, MoneyTid.ITEM_2173, MoneyTid.ITEM_2174, MoneyTid.ITEM_2175, MoneyTid.ITEM_2176,MoneyTid.ROUNDPRIZE_PROPS,MoneyTid.ROUNDPRIZE_PROPS_TWO
    }

    for k, v in pairs(showTidList) do
        if self.mTid == v then
            isShow = true
            break
        end
    end

    self.mBtnGet:SetActive(isShow)
end

-- 获取货币格式
function getMoneyFormat(self)
    local count = MoneyUtil.getMoneyCountByTid(self.mTid)
    if self.mTid == MoneyTid.POWER_TID then
        local needPower, providePower = buildBase.BuildBaseManager:getNeedAndConsumePower()
        count = needPower .. "/" .. providePower
    elseif self.mTid == MoneyTid.UAV_TID then
        local needPower = buildBase.BuildBaseManager:getAllDrone()
        count = needPower .. "/" .. sysParam.SysParamManager:getValue(5003)
    elseif count and self.mTid == MoneyTid.ANTIEPIDEMIC_SERUM_TID then
        count = count .. "/" .. stamina.StaminaManager:getCurLvlMaxStamina()
    elseif count and self.mTid == MoneyTid.GUILD_FUND_TID then
        count = guild.GuildManager:getGuildCoin()
    else
        count = MoneyUtil.shortValueStr(count)
    end
    return count
end

-- 货币图标点击
function onIconClick(self)

    if self.mTid == MoneyTid.POWER_TID then
        buildBase.BuildBaseManager:dispatchEvent(buildBase.BuildBaseManager.SHOW_POWER_TIPS)
    else
        local propsVo = props.PropsManager:getPropsConfigVo(self.mTid)
        TipsFactory:propsTips({ propsVo = propsVo }, { rectTransform = self.mImgIcon.transform })
    end

end

-- 获得按钮点击
function onGetClick(self)
    if self.mTid == MoneyTid.GOLD_COIN_TID then
        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_VIEW)
    elseif self.mTid == MoneyTid.ITIANIUM_TID then
        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW)
    elseif self.mTid == MoneyTid.ANTIEPIDEMIC_SERUM_TID then
        GameDispatcher:dispatchEvent(EventName.OPEN_ADD_STAMINA_PANEL, { isByProps = true, needCost = 0, callFun = nil, callObj = nil })
    elseif self.mTid == MoneyTid.RECRUIT_TOP_TICKET_TID then
        self:checkOpenShopBuyPanel(ShopType.NOMAL, self.mTid)
    elseif self.mTid == MoneyTid.RECRUIT_COMMON_TICKET_TID then
        self:checkOpenShopBuyPanel(ShopType.NOMAL, self.mTid)
    elseif self.mTid == MoneyTid.ARENA_CHALLENGE_TICKET_TID then
        self:checkOpenShopBuyPanel(ShopType.NOMAL, self.mTid)
    elseif self.mTid == MoneyTid.RECRUIT_ACT_TICKET_TID then
        self:checkOpenShopBuyPanel(ShopType.NOMAL, self.mTid)
    elseif self.mTid == MoneyTid.RECRUIT_ACT_BRACELETS_TICKET_TID then
        self:checkOpenShopBuyPanel(ShopType.NOMAL, self.mTid)
    elseif self.mTid == MoneyTid.RECRUIT_BRACELETS_TICKET_TID then
        self:checkOpenShopBuyPanel(ShopType.NOMAL, self.mTid)
    elseif self.mTid == MoneyTid.POWER_TID then
    elseif self.mTid == MoneyTid.FASHION_TID then
        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW, { moneyList = { MoneyTid.PAY_ITIANIUM_TID, MoneyTid.FASHION_TID }, ratio = sysParam.SysParamManager:getValue(SysParamType.FASHION_ICAN_CONVERSION_RATIO) })
    elseif self.mTid == MoneyTid.UAV_TID then
        GameDispatcher:dispatchEvent(EventName.OPEN_UAV_SPEEDUP_VIEW)
    elseif table.indexof(MoneyTid.GUILD_SKILL_ITEM_LIST, self.mTid) ~= false then
        self:checkOpenShopBuyPanel(ShopType.GUILD, self.mTid)
    elseif self.mTid == MoneyTid.ROUNDPRIZE_PROPS then
        self:checkOpenShopBuyPanel(ShopType.HIDE_SHOP, self.mTid)
    elseif self.mTid == MoneyTid.ROUNDPRIZE_PROPS_TWO then
        self:checkOpenShopBuyPanel(ShopType.HIDE_SHOP_TWO, self.mTid)
    else

        -- gs.Message.Show(MoneyUtil.getMoneyNameByTid(self.mTid))
    end
end

-- 货币区域点击
function onAreaClick(self)
    if self.mTid == MoneyTid.GOLD_COIN_TID then
        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_VIEW)
    elseif self.mTid == MoneyTid.ITIANIUM_TID then
        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW)
    elseif self.mTid == MoneyTid.ANTIEPIDEMIC_SERUM_TID then
        GameDispatcher:dispatchEvent(EventName.OPEN_ADD_STAMINA_PANEL, { isByProps = true, needCost = 0, callFun = nil, callObj = nil })
    elseif self.mTid == MoneyTid.RECRUIT_TOP_TICKET_TID then
        self:checkOpenShopBuyPanel(ShopType.NOMAL, self.mTid)
    elseif self.mTid == MoneyTid.RECRUIT_COMMON_TICKET_TID then
        self:checkOpenShopBuyPanel(ShopType.NOMAL, self.mTid)
    elseif self.mTid == MoneyTid.ARENA_COIN_TID then
        GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_PANEL)
    elseif self.mTid == MoneyTid.RECRUIT_ACT_TICKET_TID then
        self:checkOpenShopBuyPanel(ShopType.NOMAL, self.mTid)
    elseif self.mTid == MoneyTid.RECRUIT_ACT_BRACELETS_TICKET_TID then
        self:checkOpenShopBuyPanel(ShopType.NOMAL, self.mTid)
    elseif self.mTid == MoneyTid.NORMAL_SUBSIDY_TID then
        local vo = props.PropsManager:getPropsConfigVo(MoneyTid.NORMAL_SUBSIDY_TID)
        TipsFactory:propsTips({ propsVo = vo, isShowUseBtn = true })
    elseif self.mTid == MoneyTid.HIGH_SUBSIDY_TID then
        local vo = props.PropsManager:getPropsConfigVo(MoneyTid.HIGH_SUBSIDY_TID)
        TipsFactory:propsTips({ propsVo = vo, isShowUseBtn = true })
    elseif self.mTid == MoneyTid.FASHION_TID then
        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW, { moneyList = { MoneyTid.PAY_ITIANIUM_TID, MoneyTid.FASHION_TID }, ratio = sysParam.SysParamManager:getValue(SysParamType.FASHION_ICAN_CONVERSION_RATIO) })
    elseif self.mTid == MoneyTid.POWER_TID then
        -- GameDispatcher:dispatchEvent(EventName.OPEN_POWER_TIPS_VIEW)
    else
        -- gs.Message.Show(MoneyUtil.getMoneyNameByTid(self.mTid))
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]