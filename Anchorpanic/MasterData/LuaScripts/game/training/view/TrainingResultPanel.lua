module("training.TrainingResultPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("training/TrainingResultPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.m_gridList = {}
    self.m_itemList = {}
end

function configUI(self)
    self.mScrollContent = self:getChildTrans("Content")
    self.mScroller = self:getChildTrans("Scroll View")

    self.mGroupGain = self:getChildTrans("GroupGain")
    self.mGainItem = self:getChildGO("GainItem")
    self.mTextTitle = self:getChildGO("TextTitle"):GetComponent(ty.Text)
    self.mTextTime = self:getChildGO("TextTime"):GetComponent(ty.Text)
    self.mTextTip = self:getChildGO("TextTip"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    -- GameDispatcher:addEventListener(EventName.RES_ONE_TRAINING_END, self.__updateView, self)
    -- GameDispatcher:addEventListener(EventName.RES_TRAINING_PANEL_INFO, self.__updateView, self)
    -- self.m_loopSn = LoopManager:addTimer(1, 0, self, self.__updateTickTime)
    self:__updateView()
end

function deActive(self)
    super.deActive(self)
    -- GameDispatcher:removeEventListener(EventName.RES_ONE_TRAINING_END, self.__updateView, self)
    -- GameDispatcher:removeEventListener(EventName.RES_TRAINING_PANEL_INFO, self.__updateView, self)
    -- self.m_scroller:ResetItem()
    -- LoopManager:removeTimerByIndex(self.m_loopSn)
    -- self.m_loopSn = nil
    self:clearGridList()
end

function initViewText(self)
    self.mTextTip.text = _TT(43018) --"当前未获得任何成果"
    self.mTextTitle.text = _TT(43019) --"平均效率"
end

function addAllUIEvent(self)
end

function __updateView(self)
    self:__updateGridList()
    -- self:__updateGainList()
    self:__updateTickTime()
end

function __updateGridList(self)
    self:clearGridList()

    local list = training.TrainingManager.gainAwardList
    table.sort(list, bag.BagManager.sortPropsListByDescending)
    if #list > 7 then
        gs.TransQuick:Pivot(self.mScrollContent, 0, 1)
        gs.TransQuick:Anchor(self.mScrollContent, 0, 1, 0, 1)
        gs.TransQuick:UIPos(self.mScrollContent, 0, 0)
        self.mScrollContent:GetComponent(ty.ContentSizeFitter).horizontalFit = gs.ContentSizeFitter.FitMode.PreferredSize
        self.mScrollContent:GetComponent(ty.HorizontalLayoutGroup).childAlignment = gs.TextAnchor.MiddleLeft
    else
        gs.TransQuick:Pivot(self.mScrollContent, 0.5, 0.5)
        gs.TransQuick:Anchor(self.mScrollContent, 0, 1, 1, 1)
        self.mScrollContent:GetComponent(ty.ContentSizeFitter).horizontalFit = gs.ContentSizeFitter.FitMode.Unconstrained
        self.mScrollContent:GetComponent(ty.HorizontalLayoutGroup).childAlignment = gs.TextAnchor.MiddleCenter
    end

    for i = #list, 1, -1 do
        local grid = PropsGrid:create(self.mScrollContent, list[i], 1)
        table.insert(self.m_gridList, grid)
    end
    self.mTextTip.gameObject:SetActive(#list <= 0)
end

function __updateGainList(self)
    self:clearItemList()
    local trainingConfigVo = training.TrainingManager:getTrainingConfigVo()
    for i = 1, #trainingConfigVo.preGainList do
        local data = trainingConfigVo.preGainList[i]
        local item = SimpleInsItem:create(self.mGainItem, self.mGroupGain, "BranchStoryTrainingGainItem")
        item:getChildGO("ImgGain"):GetComponent(ty.AutoRefImage):SetImg(MoneyUtil.getMoneyIconUrlByTid(data.tid), true)
        item:setText("TextGain", nil, HtmlUtil:color(data.num, "fee600") .. "/" .. _TT(154)) --分钟
        table.insert(self.m_itemList, item)
    end
end

function __updateTickTime(self)
    local deltaTime = training.TrainingManager:getDeltaTime()
    self.mTextTime.text = HtmlUtil:size(_TT(43009), 18) .. HtmlUtil:color(TimeUtil.getHMSByTime(deltaTime), "81cdff") --"训练时长："
end

function clearGridList(self)
    for i = #self.m_gridList, 1, -1 do
        local item = self.m_gridList[i]
        item:poolRecover()
    end
    self.m_gridList = {}
end

function clearItemList(self)
    for i = #self.m_itemList, 1, -1 do
        local item = self.m_itemList[i]
        item:poolRecover()
    end
    self.m_itemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
