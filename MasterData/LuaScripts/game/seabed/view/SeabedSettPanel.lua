--[[ 
-----------------------------------------------------
@filename       : CycleSettPanel
@Description    : 海底结算界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("seabed.SeabedSettPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedSettPanel.prefab")

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

    -- self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    -- self.mTxtAddExp = self:getChildGO("mTxtAddExp"):GetComponent(ty.Text)
    -- self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)
    self.mTxtTalentPoint = self:getChildGO("mTxtTalentPoint"):GetComponent(ty.Text)
    self.mTxtPointValue = self:getChildGO("mTxtPointValue"):GetComponent(ty.Text)

    self.mTxtTalent = self:getChildGO("mTxtTalent"):GetComponent(ty.Text)

    -- self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTalent.text = _TT(111161)
end

-- 激活
function active(self, args)
    super.active(self)
    seabed.SeabedManager:resetAddBuffList()
    seabed.SeabedManager:resetRemoveBuffList()

    -- GameDispatcher:dispatchEvent(EventName.HIDE_CYCLE_TOP_PANEL)
    -- self.mTxtTalent.gameObject:SetActive(false)

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

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickHandler)
end

function onClickHandler(self)
    self:close()
end

function getSingleData(self, id)
    for i = 1, #self.statsList, 1 do
        if self.statsList[i].id == id then
            return self.statsList[i]
        end
    end
    return {
        id = id,
        count = 0
    }
end

function showView(self)
    self.point, self.talentPoint, self.statsList = seabed.SeabedManager:getSeabedSettInfo()
    seabed.SeabedManager:resSeabedSettInfo()

    local pointDic = seabed.SeabedManager:getSeabedPointData()
    for id, vo in pairs(pointDic) do
        local item = SimpleInsItem:create(self.mDataSettItem, self.mScrollData.content, "CycleSettPanelscoreItem")
        local msgVo = self:getSingleData(id)

        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(vo.des)

        item:getChildGO("mTxtScore"):GetComponent(ty.Text).text = msgVo.count -- times
        item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text = _TT(27565) .. vo.score * msgVo.count
        item:getChildGO("mTxtPoint"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("c6d4e1ff")
        table.insert(self.mScoreList, item)
    end
    local dif, multip = seabed.SeabedManager:getSeabedPointMultipleData()
    local item = SimpleInsItem:create(self.mDataSettItem, self.mScrollData.content, "CycleSettPanelscoreItem")
    item:getChildGO("mTxtName"):GetComponent(ty.Text).text = "关卡难度"
    item:getChildGO("mTxtScore"):GetComponent(ty.Text).text = dif -- _TT(multip / 10000) -- times
    item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text = _TT(27556) .. multip / 10000
    item:getChildGO("mTxtPoint"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("c6d4e1ff")
    table.insert(self.mScoreList, item)

    self.mTxtPointValue.text = "积分" .. self.point
    self.mTxtTalentPoint.text = "+" .. self.talentPoint
    self.mBtnClose:SetActive(true)
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
