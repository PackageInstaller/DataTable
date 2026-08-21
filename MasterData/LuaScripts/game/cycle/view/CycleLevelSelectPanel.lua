module("cycle.CycleLevelSelectPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleLevelSelectPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(331))
    self:setBg("")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.levelItems = {}
    self.propsItems = {}
    self.lockItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mLevelSelectTitle = self:getChildGO("mLevelSelectTitle"):GetComponent(ty.Text)
    self.mLevelSelectScroll = self:getChildGO("mLevelSelectScroll"):GetComponent(ty.ScrollRect)
    self.mRogueLikeLevelItem = self:getChildGO("mRogueLikeLevelItem")
    self.mLockItem = self:getChildGO("mLockItem")

    self.mBtnSelect = self:getChildGO("mBtnSelect")

    self.mEventTrigger = self.mLevelSelectScroll:GetComponent(ty.LongPressOrClickEventTrigger)

    local function _onBeginDrag()
        self:onBeginDragHandler()
    end
    self.mEventTrigger.onBeginDrag:AddListener(_onBeginDrag)

    local function _onEndDrag()
        self:onEndDragHandler()
    end
    self.mEventTrigger.onEndDrag:AddListener(_onEndDrag)
end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    self:updateView()
end

function deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:clearLockItem()
    self:clearPropsItem()
    self:clearLevelItem()
    self.mEventTrigger.onBeginDrag:RemoveAllListeners()
    self.mEventTrigger.onEndDrag:RemoveAllListeners()

    if self.mMoveSn then
        LoopManager:removeFrameByIndex(self.mMoveSn)
        self.mMoveSn = nil
    end

    if self.tweenSn then
        LoopManager:removeFrameByIndex(self.tweenSn)
        self.tweenSn = nil
    end
    -- self.tweenSn
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSelect, self.onBtnSelectClickHandler)
end

function onBtnSelectClickHandler(self)

    self.maxDifficult = cycle.CycleManager:getMaxDifficulty()
    if self.lastSelectId > self.maxDifficult + 1 then
        gs.Message.Show(_TT(27554))
        return
    end

    self:close()

    GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STEP_INFO, {
        step = CYCLE_STEP.SELECT_DIFFICULT,
        args = {self.lastSelectId}
    })
end

function updateView(self)

    self:clearLockItem()
    self:clearPropsItem()
    self:clearLevelItem()

    local roleVo = role.RoleManager:getRoleVo()
    local difDic = cycle.CycleManager:getDifficultData()

    self.mClampList = {}

    -- [1] [0]
    -- [1] [0.5] [0]
    -- [1] [0.66] [0.33] [0]

    for i = table.nums(difDic) - 1, 0, -1 do
        table.insert(self.mClampList, 1 / (table.nums(difDic) - 1) * i)
    end

    self.lastSelectId = 1
    self.maxDifficult = cycle.CycleManager:getMaxDifficulty()

    for id, data in pairs(difDic) do
        local item = SimpleInsItem:create(self.mRogueLikeLevelItem, self.mLevelSelectScroll.content, "CycleLevelSelectPanelmRogueLikeLevelItem")

        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(27555) .. id
        item:getChildGO("mTxtMultiple"):GetComponent(ty.Text).text = _TT(27556) .. data.pointMultiple

        local isLock = id > self.maxDifficult + 1
        item:getChildGO("mIsLock"):SetActive(isLock)
        self:addUIEvent(item:getChildGO("mBtnClick"), self.levelItemsClick, nil, {
            id = id
        })
        table.insert(self.levelItems, item)
    end
end

function levelItemsClick(self, args)
    self:tweenToPos(args.id, 30)
end

function clearLockItem(self)
    for i = 1, #self.lockItems do
        self.lockItems[i]:poolRecover()
        self.lockItems[i] = nil
    end
    self.lockItems = {}
end

function clearPropsItem(self)
    for i = 1, #self.propsItems do
        self.propsItems[i]:poolRecover()
    end
    self.propsItems = {}
end

function clearLevelItem(self)
    for i = 1, #self.levelItems do
        self.levelItems[i]:poolRecover()
    end
    self.levelItems = {}
end

function onBeginDragHandler(self)
    --self.mMoveSn = LoopManager:addFrame(0, 0, self, self.onMoveHandler)
end

function onEndDragHandler(self)
    -- if self.mMoveSn then
    --     LoopManager:removeFrameByIndex(self.mMoveSn)
    --     self.mMoveSn = nil
    -- end
    local selectId = 0
    local vPos = self.mLevelSelectScroll.verticalNormalizedPosition
    vPos = gs.Mathf.Clamp(vPos, 0.0001, 0.9999)
    for i = 1, #self.mClampList do
        if vPos <= self.mClampList[i] and vPos >= self.mClampList[i + 1] then
            local top = self.mClampList[i] - vPos
            local bottom = vPos - self.mClampList[i + 1]

            if top < bottom then
                selectId = i
            else
                selectId = i + 1
            end
        end
    end

    self:tweenToPos(selectId, 30)
end

-- function onMoveHandler(self)

-- end

function tweenToPos(self, selectId, frame)
    self.lastSelectId = selectId
    local needPos = self.mClampList[selectId]
    if self.tweenSn then
        LoopManager:removeFrameByIndex(self.tweenSn)
        self.tweenSn = nil
        self.len = 0
    end

    local targetPos = needPos - self.mLevelSelectScroll.verticalNormalizedPosition
    self.len = 0
    self.tweenSn = LoopManager:addFrame(0, frame, self, function()
        self.len = 1 / frame + self.len
        local endPos = self:easeOutCubic(self.mLevelSelectScroll.verticalNormalizedPosition, needPos, self.len)
        self.mLevelSelectScroll.verticalNormalizedPosition = endPos
    end)
end

function easeOutSine(self, sPos, ePos, value)
    ePos = ePos - sPos
    return ePos * gs.Mathf.Sin(value / 1 * (gs.MATHF_PI / 2)) + sPos
end

function easeOutCubic(self, sPos, ePos, value)
    value = value - 1
    ePos = ePos - sPos
    return ePos * (value * value * value + 1) + sPos
end


function easeOutElastic(self, sPos, ePos, value)
    ePos = ePos - sPos
    local d = 1
    local p = d * 0.3
    local s = 0
    local a = 0

    if value == 0 then
        return sPos
    end
    local rem = value / d
    if rem == 1 then
        return sPos + ePos
    end

    if a == 0 or a < gs.Mathf.Abs(ePos) then
        a = ePos
        s = p / 4
    else
        s = p / (2 * gs.MATHF_PI) * gs.Mathf.Asin(ePos / a)
    end

    return (a * gs.Mathf.Pow(2, -10 * value) * gs.Mathf.Sin((value * d - s) * (2 * gs.MATHF_PI) / p) + ePos + sPos)
end





return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27556):	"积分倍率:"
	语言包: _TT(27555):	"难度等级:"
	语言包: _TT(27554):	"所选关卡暂未解锁"
]]
