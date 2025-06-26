--[[ 
-----------------------------------------------------
@filename       : CycleSettPanel
@Description    : 事影循回结算界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("cycle.CycleSettPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleSettPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mScoreList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mScrollData = self:getChildGO("mScrollData"):GetComponent(ty.ScrollRect)
    self.mDataSettItem = self:getChildGO("mDataSettItem")
    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mTxtAddExp = self:getChildGO("mTxtAddExp"):GetComponent(ty.Text)
    self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)
    self.mTxtTalentPoint = self:getChildGO("mTxtTalentPoint"):GetComponent(ty.Text)
    self.mTxtPointValue = self:getChildGO("mTxtPointValue"):GetComponent(ty.Text)

    self.mTxtTalent = self:getChildGO("mTxtTalent"):GetComponent(ty.Text)

    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
    super.active(self)
    GameDispatcher:dispatchEvent(EventName.HIDE_CYCLE_TOP_PANEL)
    self.mTxtTalent.gameObject:SetActive(false)

    self.mBtnClose:SetActive(false)
    self:showView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    if (self.eventSn) then
        LoopManager:removeFrameByIndex(self.eventSn)
        self.eventSn = nil
    end

    self:clearScoreList()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickHandler)
end

function onClickHandler(self)
    self:close()
end

function showView(self)

    -- local point, exp, showData, oldLv, newLv, talent = cycle.CycleManager:getCycleSettleInfo()
    -- point = 1
    -- exp = 600
    -- showData = {}
    -- oldLv = 1
    -- newLv = 5
    -- talent = 3

    self.mTxtLv.gameObject:SetActive(false)
    local point, exp, showData, oldLv, newLv, talent = cycle.CycleManager:getCycleSettleInfo()
    local curExp = cycle.CycleManager.mHistoryInfo.exp
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_MAP_PANEL)
    cycle.CycleManager:resetCycleSettleInfo()

    self.mNewLv = newLv
    self.mOldLv = oldLv
    self.needCount = newLv - oldLv
    self.mTxtPointValue.text = _TT(27564) .. point
    self.exp = exp
    self.curExp = curExp

    self.talent = talent

    cusLog("天赋点数:"..talent)
    --self.mTxtTalentPoint.gameObject:SetActive(false)

    local allPointData = cycle.CycleManager:getAllPointData()
    for k, v in pairs(allPointData) do
        local item = SimpleInsItem:create(self.mDataSettItem, self.mScrollData.content, "CycleSettPanelscoreItem")
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(v.des)
        local times = 0
        if showData[v.id] then
            times = showData[v.id]
        end
        item:getChildGO("mTxtScore"):GetComponent(ty.Text).text = times -- times
        item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text = _TT(27565) .. times * v.score
        item:getChildGO("mTxtPoint"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("c6d4e1ff")
        table.insert(self.mScoreList, item)
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_SETT_PANEL)
    local item = SimpleInsItem:create(self.mDataSettItem, self.mScrollData.content, "CycleSettPanelscoreItem")
    item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(27566)
    local diff = cycle.CycleManager:getCycleHistoryDifficult()
    --临时用GM测试 会不存在数据
    if diff then
        item:getChildGO("mTxtScore"):GetComponent(ty.Text).text = diff -- times
        item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text = _TT(27567, cycle.CycleManager:getDifficultVoById(diff).pointMultiple / 10000) --"积分合计 x " .. 
        item:getChildGO("mTxtPoint"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("18ec68ff")
    end

    table.insert(self.mScoreList, item)


    self.mCurrentTime = 0
    self.mMaxTime = 2
    local lvVo
    self.mMaxLv = cycle.CycleManager:getMaxLv()
    if self.mNewLv < self.mMaxLv then
        lvVo = cycle.CycleManager:getCycleLvData(self.mNewLv + 1)
    else
        lvVo = cycle.CycleManager:getCycleLvData(self.mMaxLv)
    end

    if self.mNewLv == self.mMaxLv then
        self.mImgProgress.fillAmount = 1
        self.mTxtLv.text = _TT(27568)
        self.m_childGos["mTxtAddExp"]:SetActive(false)
        self.mTxtLv.gameObject:SetActive(true)
        self.mBtnClose:SetActive(true)
        self:showLvTxt(self.mMaxLv)
        self.mTxtTalentPoint.text = "+" .. self.talent
        self.mTxtTalent.gameObject:SetActive(self.talent > 0)
    else

        if lvVo then
            self.needExp = lvVo.needExp
        else
            self.needExp = 0
        end
        --self.needExp = lvVo.needExp

        self.singTime = self.mMaxTime / (self.needCount + 1)
        self.eventSn = LoopManager:addFrame(0, 0, self, self.onLoopEvent)
    end
end

function showLvTxt(self, lv)
    if lv > 0 and lv < 10 then
        self.mTxtLevel.text = "0" .. lv
    else
        self.mTxtLevel.text = lv
    end
end

function onLoopEvent(self)
    self.mCurrentTime = self.mCurrentTime + gs.Time.deltaTime

    if self.mCurrentTime <= self.mMaxTime then
        -- 剩余时间
        local rem = self.mCurrentTime % self.singTime
        local curCount = math.floor(self.mCurrentTime / self.singTime)

        if curCount == self.needCount then
            self:showLvTxt(self.mNewLv)
            if self.mNewLv == self.mMaxLv then
                self.mImgProgress.fillAmount = 1
            else
                self.mImgProgress.fillAmount = (rem / self.singTime) * (self.curExp / self.needExp)
            end
    
        else
            local curLv = self.mOldLv + curCount
            self:showLvTxt(curLv)
            self.mImgProgress.fillAmount = rem / self.singTime
        end
    else

        if self.mNewLv < self.mMaxLv then
            self.mTxtLv.text = _TT(27569)
            self.mTxtAddExp.text = "+" .. self.exp
            self.mImgProgress.fillAmount = self.curExp / self.needExp
            self.m_childGos["mTxtAddExp"]:SetActive(true)
        end
        self.mTxtLv.gameObject:SetActive(true)

        self.mTxtTalentPoint.text = "+" .. self.talent
        self.mTxtTalent.gameObject:SetActive(self.talent > 0)
        self.mBtnClose:SetActive(true)
        if (self.eventSn) then
            LoopManager:removeFrameByIndex(self.eventSn)
            self.eventSn = nil
        end
    end
end

function clearScoreList(self)
    for i = 1, #self.mScoreList do
        self.mScoreList[i]:recover()
    end
    self.mScoreList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27569):	"获得经验值"
	语言包: _TT(27568):	"经验值已满"
	语言包: _TT(27566):	"关卡难度"
	语言包: _TT(27565):	"积分+"
	语言包: _TT(27564):	"积分"
]]
