module("cycle.CyclePostwarPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CyclePostwarPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mPostwarItemList = {}
    self.mCollectionItems = {}
    self.mIsOpenBuffList = false
end

function getAdaptaTrans(self)
    return self.base_childTrans["mGroupTop"]
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mPostwarItem = self:getChildGO("mPostwarItem")
    self.mPostwarScroll = self:getChildGO("mPostwarScroll"):GetComponent(ty.ScrollRect)

    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtReason = self:getChildGO("mTxtReason"):GetComponent(ty.Text)
    self.mTxtReasonValue = self:getChildGO("mTxtReasonValue"):GetComponent(ty.Text)
    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mLVProgress = self:getChildGO("mLVProgress"):GetComponent(ty.Image)
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mBtnBuffList = self:getChildGO("mBtnBuffList")
    self.mTxtBuffCount = self:getChildGO("mTxtBuffCount"):GetComponent(ty.Text)
    self.mBtnFormation = self:getChildGO("mBtnFormation")
    self.mCollection = self:getChildGO("mCollection")
    self.mCollectionContent = self:getChildTrans("mCollectionContent")
    self.mCollectionItem = self:getChildGO("mCollectionItem")
    self.mTxtCommander = self:getChildGO("mTxtCommander"):GetComponent(ty.Text)

    self.mBtnClose = self:getChildGO("mBtnClose")
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self.mEventId = args.eventId

    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_POSTWAR_PANEL, self.onUpdateCyclePostwarPanel, self)

    self.mIsOpenBuffList = false
    self.mCollection:SetActive(self.mIsOpenBuffList)
    self.gBtnClose:SetActive(false)
    self.gBtnCloseAll:SetActive(false)
    self:showPanel()
end

function clearPostwarItems(self)
    for i = 1, #self.mPostwarItemList do
        self.mPostwarItemList[i]:poolRecover()
    end
    self.mPostwarItemList = {}
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_POSTWAR_PANEL, self.onUpdateCyclePostwarPanel, self)
    self:clearPostwarItems()
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:recoverCollection()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuffList, self.openBuffList)
    self:addUIEvent(self.mBtnFormation, self.openFormation)
    self:addUIEvent(self.mBtnClose, function() 
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
            cellId = self.mCurCellId,
            args = {0, 0}
        })
    end)
end

function openBuffList(self)
    self.mIsOpenBuffList = not self.mIsOpenBuffList
    if self.mCollectionList == nil or #self.mCollectionList == 0 then
        self.mIsOpenBuffList = false
        return
    end
    self:recoverCollection()
    if self.mIsOpenBuffList then 
        for k,v in pairs(self.mCollectionList) do
            local item = SimpleInsItem:create(self.mCollectionItem, self.mCollectionContent, "collectionItem")
            local icon = item:getChildGO("mImgCollection"):GetComponent(ty.AutoRefImage)
            local name = item:getChildGO("mTxtCollectionName"):GetComponent(ty.Text)
            local des = item:getChildGO("mTxtDes"):GetComponent(ty.Text)
            icon:SetImg(UrlManager:getIconPath(v.icon))
            name.text = _TT(v.name)
            des.text = _TT(v.des2)
            table.insert(self.mCollectionItems, item)
        end
    end
    self.mCollection:SetActive(self.mIsOpenBuffList)
end

function openFormation(self)
end

function onUpdateCyclePostwarPanel(self)
    self:showPanel()
end

function showPanel(self)

    GameDispatcher:dispatchEvent(EventName.SHOW_CYCLE_TOP_PANEL)
    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
        title = _TT(27561),
        showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON,TOP_SHOW_TYPE.COIN,TOP_SHOW_TYPE.HOPE,TOP_SHOW_TYPE.BUFFLIST,TOP_SHOW_TYPE.FORMATION,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
    })

    cycle.CycleManager:setPostwarClicked(false)
    self.mTxtReason.text = _TT(77610)
    self.mTxtCommander.text = _TT(77611)
    local curInfo = cycle.CycleManager:getResourceInfo()
    self.mTxtReasonValue.text = curInfo.reason_point .. "/" .. curInfo.reason_point_limit
    self.mTxtLevel.text = curInfo.lv
    local lvVo = cycle.CycleManager:getCycleLevelDataByLv(curInfo.lv)
    self.mTxtProgress.text = curInfo.exp .. "/" .. lvVo.nextExp
    self.mLVProgress.fillAmount = curInfo.exp / lvVo.nextExp

    self.mCollectionList = cycle.CycleManager:getLayerCollageList()
    if self.mCollectionList then 
        collectCount = #self.mCollectionList
    end
    self.mTxtBuffCount.text = collectCount

    self.mTxtTitle.text = _TT(cycle.CycleManager:getCurrentCycleLineData().name)

    --cycle.CycleManager:copyLastCellEventId(self.mEventId)
    self.mCurCellId = cycle.CycleManager:getCurrentCell()
    cusLog("战后物资获取界面 获取了 cellId:" .. self.mCurCellId .. "的数据")
    self.mCellData = cycle.CycleManager:getCellDataById(self.mCurCellId)

    self:clearPostwarItems()

    if self.mCellData == nil then
        self:close()
        return
    end

    for k, v in pairs(self.mCellData.postwarArgs) do
        if v.is_used ~= 1 then 
            local item = cycle.CyclePostwarItem:poolGet()
            item:setData(self.mPostwarScroll.content, v)
            table.insert(self.mPostwarItemList, item)
        end
    end
end

function recoverCollection(self)
    for k,v in pairs(self.mCollectionItems) do
        v:poolRecover()
    end
    self.mCollectionItems = {}
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27561):	"战后结算"
]]
