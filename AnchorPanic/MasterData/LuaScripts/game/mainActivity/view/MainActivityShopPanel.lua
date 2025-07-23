--[[
-----------------------------------------------------
@filename       : MainActivityShopPanel
@Description    : 活动玩法商店
@date           : 2023/5/24 15:00
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------]]
module("mainActivity.MainActivityShopPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("mainActivity/MainActivityShopPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowCloseAll = 0 --是否显示导航按钮

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(92004))
    self:setBg("activity_main_bg02.jpg", false, "mainActivity")
    self:setUICode(LinkCode.MainActivityShop)
end
-- 析构函数
function dtor(self)
    super.dtor(self)
end
-- 初始化数据
function initData(self)
    super.initData(self)
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(mainActivity.MainActivityShopItem)
    self.mTxtCloseTimer = self:getChildGO("mTxtCloseTimer"):GetComponent(ty.Text)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.m_childGos["mTxtCloseTitle"]:GetComponent(ty.Text).text = _TT(85014) --活动结束时间：
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({MoneyTid.ACTIVITY_COIN_TID})
    self:updateData()
    self:updatePanel()
    -- MoneyManager:setMoneyTidList({})
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    -- if self.m_MoneyBarItem then
    --     self.m_MoneyBarItem:poolRecover()
    --     self.m_MoneyBarItem = nil
    -- end
    self:cleanLyScroller()
end

--
function updateData(self)
    local shopList = mainActivity.MainActivityManager:getShopConfigList()
    -- self.leftTime = self.mEndTime - GameManager:getClientTime()
    if shopList and next(shopList) then
        if shopList[1].tweenId == nil then
            for i = 1, #shopList do
                shopList[i].tweenId = i * 1.5
            end
        end
    end
    if self.mScroller.Count > 0 then
        self.mScroller:ReplaceAllDataProvider(shopList)
    else
        self.mScroller.DataProvider = shopList
    end
end

function updatePanel(self)
    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Shop)
    local updateLeftTime = function()
        self.mTxtCloseTimer.text = mainActivityVo:getRemainingTime()
    end
    updateLeftTime()
    self:addTimer(1, 0, updateLeftTime)
end

--MoneyBar
function __updateMoneyItem(self)
    self.m_MoneyBarItem = MoneyItem:poolGet()
    self.m_MoneyBarItem:setData(self.base_childTrans["MoneyBar"], {tid = MoneyTid.ACTIVITY_COIN_TID, frontType = self.frontType})
    self.m_MoneyBarItem:getChildGO("mBtnGet"):SetActive(false)
    self.m_MoneyBarItem:getChildGO("mBtnArea"):GetComponent(ty.Button).enabled = false
end

function cleanLyScroller(self)
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
end

function __closeOpenAction(self)
    if self.isPop == 1 then
        self:close()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
