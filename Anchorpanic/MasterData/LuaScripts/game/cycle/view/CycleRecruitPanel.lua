module("cycle.CycleRecruitPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleRecruitPanel.prefab")

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
    self.mRecruitItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    --self.mTxtRecruitTitle = self:getChildGO("mTxtRecruitTitle"):GetComponent(ty.Text)
    self.mRecruitScroll = self:getChildGO("mRecruitScroll"):GetComponent(ty.ScrollRect)
    self.mBtnOK = self:getChildGO("mBtnOK")
end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:dispatchEvent(EventName.SHOW_CYCLE_TOP_PANEL)

    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
        title = _TT(27562),
        showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON,TOP_SHOW_TYPE.COIN,TOP_SHOW_TYPE.HOPE,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
    })

    self:showPanel()
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:clearRecruitItems()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnOK, self.onBtnOKClickHandler)
end

function onBtnOKClickHandler(self)
    if self.heroCount <= 0 then
       gs.Message.Show(_TT(27563))
       return 
    end

    GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STEP_INFO, {
        step = CYCLE_STEP.ENTER_MAP,
        args = {}
    })
end

function showPanel(self)
    self:clearRecruitItems()

    self.heroCount = 0
    self.sureCount = 0
    
    local needRecruit = cycle.CycleManager:getCycleTicketList()
    for i = 1, #needRecruit do

        local vo = cycle.CycleManager:getCycleRecruitData(needRecruit[i].ticket_id)
        local item = cycle.CycleRecruitItem:poolGet()


        local data = cycle.CycleManager:getCycleHeroData(needRecruit[i].pos)

        if data.isUsed == true then
            self.sureCount = self.sureCount + 1
        end
       
        if data.heroId > 0 then
            self.heroCount = self.heroCount + 1
        end
        item:setData(self.mRecruitScroll.content, {
            vo = vo,
            heroId = data.heroId,
            isUsed = data.isUsed,
            posId = data.posId,
            ticketId = data.ticketId
        },i)
        table.insert(self.mRecruitItems, item)
    end

    self.mBtnOK:SetActive(self.sureCount == #self.mRecruitItems)
end

function clearRecruitItems(self)
    for i = 1, #self.mRecruitItems do
        self.mRecruitItems[i]:poolRecover()
    end
    self.mRecruitItems = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27563):	"至少需要一名战员才可探索"
	语言包: _TT(27562):	"战前招募"
]]
