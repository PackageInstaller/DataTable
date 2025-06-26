--[[ 
-----------------------------------------------------
@filename       : EliminateChallengePanel
@Description    : 消消乐挑战界面入口
@date           : 2020-12-24 16:23:40
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('eliminate.EliminateChallengePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("eliminate/EliminateChallengePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowCloseAll = 0 --是否显示导航按钮

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(101009)) --"消消乐"
    -- self:setUICode(LinkCode.HomePage)
    -- self:setBg(string.format("eliminate_challenge_bg_%s.jpg", 1), false, "eliminate")
end

-- 取父容器
function getParentTrans(self)
    return super.getParentTrans(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mSelectAreaConfigVo = nil
end

function configUI(self)
    super.configUI(self)
    
    
    self.mBtnTask = self:getChildGO("mBtnTask")
    self.mScrollerAreaListGo = self:getChildGO("ScrollerAreaList")
    self.mScrollerStageListGo = self:getChildGO("ScrollerStageList")
    self.mScrollerAreaList = self.mScrollerAreaListGo:GetComponent(ty.LyScroller)
    self.mScrollerStageList = self.mScrollerStageListGo:GetComponent(ty.LyScroller)
    self.mScrollerAreaList:SetItemRender(eliminate.EliminateAreaItem)
    self.mScrollerStageList:SetItemRender(eliminate.EliminateStageItem)
    self.mImgEliminateBg = self:getChildGO("mImgEliminateBg"):GetComponent(ty.AutoRefImage)
end

function initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnTask, self.onClickTaskHandler)
end

function close(self)
    super.close(self)
end

function onClickClose(self)
    super.onClickClose(self)
    self.mSelectAreaConfigVo = nil
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self.mSelectAreaConfigVo = nil
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.UPDATE_ELIMINATE_PANEL_DATA, self.onUpdatePanelDataHandler, self)
    GameDispatcher:addEventListener(EventName.SELECT_ELIMINATE_AREA_PANEL, self.onSelectAreaHandler, self)
    GameDispatcher:addEventListener(EventName.SELECT_ELIMINATE_STAGE_PANEL, self.onSelectStageHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ELIMINATE_TASK, self.onUpdateTaskHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ELIMINATE_TASK_LIST, self.onUpdateTaskListHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ELIMINATE_PASS_STAGE_LIST, self.onUpdatePassStageListHandler, self)
    self:updateView(true)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_ELIMINATE_PANEL_DATA, self.onUpdatePanelDataHandler, self)
    GameDispatcher:removeEventListener(EventName.SELECT_ELIMINATE_AREA_PANEL, self.onSelectAreaHandler, self)
    GameDispatcher:removeEventListener(EventName.SELECT_ELIMINATE_STAGE_PANEL, self.onSelectStageHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ELIMINATE_TASK, self.onUpdateTaskHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ELIMINATE_TASK_LIST, self.onUpdateTaskListHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ELIMINATE_PASS_STAGE_LIST, self.onUpdatePassStageListHandler, self)
end

function onClickTaskHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ELIMINATE_TASK_PANEL)
end

function onSelectAreaHandler(self, areaConfigVo)
    self.mSelectAreaConfigVo = areaConfigVo
    self:updateView(true)
end

function onSelectStageHandler(self, stageConfigVo)
    self:updateView(false)
    GameDispatcher:dispatchEvent(EventName.OPEN_ELIMINATE_STAGE_PANEL, stageConfigVo)
end

function onUpdateTaskHandler(self)
    self:updateTaskBubble()
end

function onUpdateTaskListHandler(self)
    self:updateTaskBubble()
end

function onUpdatePassStageListHandler(self)
    self:updateView(false)
end

function onUpdatePanelDataHandler(self)
    self:updateView(true)
end

function updateView(self, cusIsInit)
    self:recoverListData(self.mScrollerAreaList.DataProvider)
    self:recoverListData(self.mScrollerStageList.DataProvider)

    local areaScrollList = {}
    local areaConfigList = eliminate.EliminateManager:getAreaConfigList()
    for i = 1, #areaConfigList do
        local areaConfigVo = areaConfigList[i]
        if(self.mSelectAreaConfigVo == nil)then
            self.mSelectAreaConfigVo = areaConfigVo
        end

        local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollerVo:setDataVo(areaConfigVo)
        scrollerVo:setSelect(self.mSelectAreaConfigVo == areaConfigVo)
        table.insert(areaScrollList, scrollerVo)
    end
    if (cusIsInit == nil or cusIsInit == true) then
        self.mScrollerAreaList.DataProvider = areaScrollList
    else
        self.mScrollerAreaList:ReplaceAllDataProvider(areaScrollList)
    end

    local scrollToStageIndex = 0
    local stageScrollList = {}
    local stageIdList = self.mSelectAreaConfigVo.stageIdList
    for i = 1, #stageIdList do
        local stageConfigVo = eliminate.EliminateManager:getMapStageConfigVo(stageIdList[i])
        local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        stageConfigVo.areaId=self.mSelectAreaConfigVo.areaId
        scrollerVo:setDataVo(stageConfigVo)
        scrollerVo:setSelect(false)
        table.insert(stageScrollList, scrollerVo)
        if(stageConfigVo:isOpen() and not stageConfigVo:isLock())then
            scrollToStageIndex = i - 1
        end
    end
    table.insert(stageScrollList, LuaPoolMgr:poolGet(LyScrollerSelectVo))
    table.insert(stageScrollList, LuaPoolMgr:poolGet(LyScrollerSelectVo))

    if (cusIsInit == nil or cusIsInit == true) then
        self.mScrollerStageList.DataProvider = stageScrollList
        if(scrollToStageIndex <= #stageIdList - 2)then
            self.mScrollerStageList:ScrollToImmediately(math.max(0, scrollToStageIndex - 2))
        else
            self.mScrollerStageList:ScrollToImmediately(scrollToStageIndex)
        end
    else
        self.mScrollerStageList:ReplaceAllDataProvider(stageScrollList)
    end
    -- 曲线救国强制缓动触发刷新
    self.mScrollerStageList:JumpToPosition(gs.Vector2(self.mScrollerStageList:GetContent().anchoredPosition.x + 0.01, 0), 0.01)

    self.mImgEliminateBg:SetImg(UrlManager:getBgPath(string.format("eliminate/eliminate_challenge_bg_%s.jpg", self.mSelectAreaConfigVo.areaId)))
    -- self:setBg(string.format("eliminate_challenge_bg_%s.jpg", self.mSelectAreaConfigVo.areaId), false, "eliminate")

    self:updateTaskBubble()
end

function updateTaskBubble(self)
    if(eliminate.EliminateManager:hasTaskAward())then
        RedPointManager:add(self.mBtnTask.transform, nil, 20, 30)
    else
        RedPointManager:remove(self.mBtnTask.transform)
    end
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
