--[[ 
-----------------------------------------------------
@filename       : ActivityPromoView1
@Description    : 宣传推广页面1——1元礼包
@date           : 2023-06-08 19:22:18
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.activity.view.ActivityPromoView1', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivityPromoView1.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mToggleRemaid = self:getChildGO("mToggleRemaid"):GetComponent(ty.Toggle)
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_INFO, self.onDirectBuyComplete, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_INFO, self.onDirectBuyComplete, self)

    if self.mToggleRemaid.isOn then
        GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, { moduleId = RemindConst.ACTIVITY_PROMO_SHOW })
    end
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
    self:addUIEvent(self.mBtnBuy, self.onClickBuyHandler)
end

function onClickBuyHandler(self)
    recharge.sendRecharge(recharge.RechargeType.GIFT_DIRECT_BUY, nil, recharge.rechargeDirectId.oneYuanGift, function()
        self:close()
    end)
end

function onDirectBuyComplete(self)
    self:close()
end

return _M