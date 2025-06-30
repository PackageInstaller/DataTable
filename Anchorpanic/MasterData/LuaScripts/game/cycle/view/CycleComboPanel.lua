module("cycle.CycleComboPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleComboPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("common_bg_008.jpg",false)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mCombotems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mComboScroll = self:getChildGO("mComboScroll"):GetComponent(ty.ScrollRect)
end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:dispatchEvent(EventName.SHOW_CYCLE_TOP_PANEL)
    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
        title = "",
        showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON,TOP_SHOW_TYPE.COIN,TOP_SHOW_TYPE.HOPE,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
    })
    GameDispatcher:addEventListener(EventName.SWITCH_CYCLE_COMBO_SELECT,self.onSwithComboHandler,self)

    self:showPanel()
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    GameDispatcher:removeEventListener(EventName.SWITCH_CYCLE_COMBO_SELECT,self.onSwithComboHandler,self)
    self:clearRecruitItems()

    if self.tweenSn then
        LoopManager:removeFrameByIndex(self.tweenSn)
        self.tweenSn = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function onSwithComboHandler(self,id)
    for i = 1, #self.mCombotems do
        self.mCombotems[i]:setSelect(i == id)
    end

    self.mClampList = {}
    for i = #self.mCombotems - 1, 0, -1 do
        table.insert(self.mClampList, 1 / (#self.mCombotems - 1) * i)
    end

    --local v = self.mClampList[#self.mClampList - id + 1]
    -- verticalNormalizedPosition
    --self.mBuffScroll.horizontalNormalizedPosition = v
    self:tweenToPos(#self.mCombotems - id  + 1,30)
end

function showPanel(self)
    self:clearRecruitItems()
    local needRecruit = cycle.CycleManager:getCycleComboData()
    for k,v in pairs(needRecruit) do
        local item = cycle.CycleComboItem:poolGet()
        item:setData(self.mComboScroll.content, v)

        self:setGuideTrans("CycleComboItem_" .. k, item.UITrans)
    
        table.insert(self.mCombotems, item)
    end
end

function clearRecruitItems(self)
    for i = 1, #self.mCombotems do
        self.mCombotems[i]:poolRecover()
    end
    self.mCombotems = {}
end

function tweenToPos(self, selectId, frame)
    self.lastSelectId = selectId
    local needPos = self.mClampList[selectId]
    if self.tweenSn then
        LoopManager:removeFrameByIndex(self.tweenSn)
        self.tweenSn = nil
        self.len = 0
    end

    local targetPos = needPos - self.mComboScroll.horizontalNormalizedPosition
    self.len = 0
    self.tweenSn = LoopManager:addFrame(0, frame, self, function()
        self.len = 1 / frame + self.len
        local endPos = self:easeOutCubic(self.mComboScroll.horizontalNormalizedPosition, needPos, self.len)
        self.mComboScroll.horizontalNormalizedPosition = endPos
    end)
end

function easeOutCubic(self, sPos, ePos, value)
    value = value - 1
    ePos = ePos - sPos
    return ePos * (value * value * value + 1) + sPos
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27540):	"选择组合"
]]
