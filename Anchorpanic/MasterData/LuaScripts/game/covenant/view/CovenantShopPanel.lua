--[[ 
-----------------------------------------------------
@filename       : CovenantShopPanel
@Description    : 盟约商店
@date           : 2021-06-15 14:12:00
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('covenant.CovenantShopPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantShopPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("covenant_helper.jpg", false, "covenant")
end
--析构  
function dtor(self)
end

function initData(self)
    self.mItemList = {}
end

-- 初始化
function configUI(self)
    self.mScroller = self:getChildTrans('mScroller')
    self.mScrollContent = self:getChildTrans('Content')

    -- self:setGuideTrans("funcTips_infiniteCity_tabar", self:getChildTrans("mGroupFuncTipsTabar"))
end

--激活
function active(self)
    super.active(self)

    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.__onDataUpdateHandler, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.__onItemUpdateHandler, self)
    -- shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.__onShopUpdateHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.__onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.__onUpdateMoneyHandler, self)

    MoneyManager:setMoneyTidList({ MoneyTid.PRESTIGE_COIN_TID })

    self:updateShopList()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.__onDataUpdateHandler, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.__onItemUpdateHandler, self)
    -- shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.__onShopUpdateHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.__onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.__onUpdateMoneyHandler, self)
    -- self:removeItem()
    self:clearItemList()
    -- self:killTween()

    LoopManager:removeFrameByIndex(self.frameId)
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
    -- self:addUIEvent(self.aa,self.onClick)
end

-- 当前商店类型
function getShopType(self)
    return ShopType.COVENANT
end

function updateShopList(self)
    self:clearItemList()
    gs.TransQuick:LPosX(self.mScrollContent, 0)
    -- self.mScrollContent:GetComponent(ty.HorizontalLayoutGroup).enabled = false
    local list = shop.ShopManager:getShopItemList(self:getShopType())
    table.sort(list, self.sortFun)

    for i, vo in ipairs(list) do
        if vo:isEnoughPlayerLvl() then
            local item = covenant.CovenantShopItem:poolGet()
            item:setData(self.mScrollContent, vo)
            item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
            table.insert(self.mItemList, item)
        end
    end
end

function sortFun(a, b)
    if a:isSoldout() and not b:isSoldout() then
        return false
    elseif b:isSoldout() and not a:isSoldout() then
        return true
    elseif a:isEnoughPerstigeStage() and not b:isEnoughPerstigeStage() then
        return true
    elseif b:isEnoughPerstigeStage() and not a:isEnoughPerstigeStage() then
        return false
    else
        return a:getId() < b:getId()
    end
end

function onItemChange(self, args)
    self.mScrollContent:GetComponent(ty.ContentSizeFitter).enabled = false
    self.mScrollContent:GetComponent(ty.ContentSizeFitter).enabled = true
    if args.isShow then
        if self.showItem then
            -- 回收之前打开的
            self.showItem:closeContent()
            self.showItem = nil
        end
        self.showItem = args.item
        self:onScollTo(args.item)
    else
        self.showItem = nil
    end
end

function clearItemList(self)
    for i = 1, #self.mItemList do
        local item = self.mItemList[i]
        item:removeEventListener(item.EVENT_CHANGE, self.onItemChange, self)
        item:poolRecover()
    end
    self.mItemList = {}
    self.showItem = nil
end

function onScollTo(self, item)
    local scollTo = function()
        if self.mScrollContent.rect.size.x >= self.mScroller.rect.size.x then
            local itemPosX = item.UITrans.anchoredPosition.x
            local itemSizeX = item.UITrans.rect.size.x
            local scollPosX = math.abs(self.mScrollContent.localPosition.x)
            local tempX = scollPosX

            if (itemPosX + itemSizeX / 2) > (scollPosX + self.mScroller.rect.size.x) then
                tempX = scollPosX + ((itemPosX + itemSizeX / 2) - (scollPosX + self.mScroller.rect.size.x))
                tempX = math.max(scollPosX, tempX)
            else
                local posX = itemPosX - itemSizeX / 2
                tempX = math.min(posX, scollPosX)
            end

            tempX = -math.min(math.abs(tempX), self.mScrollContent.rect.size.x)
            TweenFactory:move2LPosX(self.mScrollContent, tempX, 0.2)
        end
    end
    self.frameId = LoopManager:addFrame(3, 1, self, scollTo)
end

-- 玩家等级变化
function __onUpdatePlayerInfoHandler(self)
    self:__onDataUpdateHandler()
end

-- 货币变化
function __onUpdateMoneyHandler(self)
    self:__onDataUpdateHandler()
end

-- 商品数据更新
function __onDataUpdateHandler(self)
    self:updateShopList()
end

-- 更新某个商品
function __onItemUpdateHandler(self, cusData)
    -- local type = cusData.type
    -- local id = cusData.id
    -- for _, item in pairs(self.mItemList) do
    --     local vo = item:getShopVo()
    --     if vo.type == type and vo.id == id then
    --         item:updataView()
    --     end
    -- end
    -- 重新刷新下，需要排序
    self:updateShopList()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
