--[[ 
-----------------------------------------------------
@filename       : ActivityPromoView2
@Description    : 宣传推广页面1——晶耀供给（月卡）
@date           : 2023-06-08 19:22:18
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.activity.view.ActivityPromoView2', Class.impl(activity.ActivityPromoView1))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivityPromoView2.prefab")

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
    self.mPropsGridList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mAwardTrans = self:getChildTrans("mAwardTrans")
    self.mGroupAwardTrans = self:getChildTrans("mGroupAwardTrans")
end

--激活
function active(self)
    super.active(self)
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:closeAllPropsGrid()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

function updateView(self)
    self:closeAllPropsGrid()
    local buyPropGrid = PropsGrid:createByData({ tid = sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_QUICKLY_MONEY_ID), num = sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_QUICKLY_GET), parent = self.mAwardTrans, scale = 1, showUseInTip = true })
    local dailyPropGrid = PropsGrid:createByData({ tid = sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_MONEY_TID), num = sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_DAILY_GET), parent = self.mGroupAwardTrans, scale = 1, showUseInTip = true })
    local extroPropGrid = PropsGrid:createByData({ tid = sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_EXTRAGIFT_TID), num = sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_EXTRAGIFT_NUM), parent = self.mGroupAwardTrans, scale = 1, showUseInTip = true })
    table.insert(self.mPropsGridList, buyPropGrid)
    table.insert(self.mPropsGridList, dailyPropGrid)
    table.insert(self.mPropsGridList, extroPropGrid)
end

function closeAllPropsGrid(self)
    if #self.mPropsGridList > 0 then
        for _, propsGrid in ipairs(self.mPropsGridList) do
            propsGrid:poolRecover()
            propsGrid = nil
        end
        self.mPropsGridList = {}
    end
end

--跳转月卡
function onClickBuyHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.MonthCard })
    self:close()
end

return _M