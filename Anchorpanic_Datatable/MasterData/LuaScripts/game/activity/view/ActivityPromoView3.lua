--[[ 
-----------------------------------------------------
@filename       : ActivityPromoView3
@Description    : 宣传推广页面3——成长礼遇
@date           : 2023-06-08 19:22:18
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.activity.view.ActivityPromoView3', Class.impl(activity.ActivityPromoView1))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivityPromoView3.prefab")

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
    super.configUI(self)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

--跳转成长礼遇
function onClickBuyHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.GrowthFund })
    self:close()
end

return _M