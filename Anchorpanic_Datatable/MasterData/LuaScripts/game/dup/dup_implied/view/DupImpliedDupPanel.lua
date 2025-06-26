--[[ 
-----------------------------------------------------
@filename       : DupImpliedDupPanel
@Description    : 默示之境副本页面
@date           : 2021-07-05 17:53:11
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.view.DupImpliedDupPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupImplied/DupImpliedDupPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52087))
    self:setBg("dupImplied_bg_2.jpg", false, "dupImplied")
    self:setUICode(LinkCode.DupImplied)
end

--析构  
function dtor(self)
end

function initData(self)
    self.mCurStageItem = nil
    self.mDupItemList = {}
end

-- 初始化
function configUI(self)
    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mBtnReset = self:getChildGO('mBtnReset')
    self.mImgPass = self:getChildTrans('mImgPass')
    self.mBtnTrophy = self:getChildGO('mBtnTrophy')
    self.mGroupMap = self:getChildTrans("mGroupMap")
    self.mImgToucher = self:getChildGO('mImgToucher')
    self.mGroupInfo = self:getChildTrans("mGroupInfo")
    self.mGroupStage = self:getChildTrans("mGroupStage")
    self.mCenterPoint = self:getChildTrans("mCenterPoint")
    self.mGroupPassTips = self:getChildGO('mGroupPassTips')
    self.mGroupAbnormal = self:getChildGO('mGroupAbnormal')
    self.mImgSpecialTips = self:getChildGO('mImgSpecialTips')
    self.mImgDissolve = self:getChildGO("mImgDissolve"):GetComponent(ty.Image)
    self.mTxtSpecialName = self:getChildGO('mTxtSpecialName'):GetComponent(ty.Text)

    self:setGuideTrans("funcTips_implied_1", self:getChildTrans("mGroupFuncImplied1"))
    self:setGuideTrans("funcTips_implied_2", self:getChildTrans("mGroupFuncImplied2"))
    self:setGuideTrans("funcTips_implied_3", self:getChildTrans("mGroupFuncImplied3"))
end

--激活
function active(self, args)
    super.active(self, args)
    dup.DupImpliedManager:addEventListener(dup.DupImpliedManager.EVENT_IMPLIED_INFO_UPDATE, self.onInfoUpdate, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_IMPLIED_DUP_INFO_VIEW, self.onOpenDupInfoHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DUP_IMPLIED_DUP_INFO_VIEW, self.onCloseDupInfoHandler, self)
    if args then
        if not args.stageId then
            local vo = dup.DupImpliedManager:getDupVo(args.dupId)
            self.mStageId = vo.stage
        else
            self.mStageId = args.stageId
        end
    end
    if not dup.DupImpliedManager:getStageIsOpen(self.mStageId) then
        self.mStageId = nil
    end

    self:updateStage()
    -- self:updateView()
    if dup.DupImpliedManager.isStageEnd then
        self:setTimeout(1, function()
            self:showRoundEndTips()
        end)
        dup.DupImpliedManager.isStageEnd = false
    end

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    dup.DupImpliedManager:removeEventListener(dup.DupImpliedManager.EVENT_IMPLIED_INFO_UPDATE, self.onInfoUpdate, self)
    GameDispatcher:removeEventListener(EventName.OPEN_DUP_IMPLIED_DUP_INFO_VIEW, self.onOpenDupInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_DUP_IMPLIED_DUP_INFO_VIEW, self.onCloseDupInfoHandler, self)
    LoopManager:removeFrameByIndex(self.frameId)
    -- self:clearItemList()
    self:recoverListItem()
    self:recoverAbnormalListItem()
    self:onCloseDupViewHandler()
    self.mCurStageItem = nil
    LoopManager:removeFrame(self, self.onFrame)
    self.mImgDissolve.material:SetFloat("_Clip", 3)

    self:tweenOff(true)

    self:destroyMapView()
end

function onClickClose(self)
    super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_ENTER_PANEL)
end

function setMoneyBar(self)

end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mImgToucher, self.onCloseDupInfoHandler)
    self:addUIEvent(self.mBtnTrophy, self.onOpenTrophyShow)
    self:addUIEvent(self.mBtnReset, self.onResetHandler)
    self:addUIEvent(self.mGroupPassTips, self.onCloseRoundEndTips)
    self:addUIEvent(self.mGroupAbnormal, self.onOpenAbnormalView)
    self:addUIEvent(self.mBtnRank, self.onOpenRank)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
    self:addUIEvent(self:getChildGO("mBtnBook"), self.onClickBookView)
end

function onClickBookView(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_OpenMatrixBook_PANEL)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.DupImplied })
end

-- 轮次结束
function showRoundEndTips(self)
    self.mGroupPassTips.transform:SetParent(self.UIBaseTrans, false)
    self.mGroupPassTips:SetActive(true)

    gs.TransQuick:ScaleY(self.mImgPass, 0)
    self.passTween = self.mImgPass:DOScaleY(1, 0.1)
    self.passTween:OnComplete(function()
        self:setTimeout(2, function()
            self:onCloseRoundEndTips()
        end)
    end)
end

function onCloseRoundEndTips(self)
    self.passTween:Kill()
    self.passTween = nil
    gs.TransQuick:ScaleY(self.mImgPass, 1)
    self.passTween = self.mImgPass:DOScaleY(0, 0.1)
    self.passTween:OnComplete(function()
        self.mGroupPassTips:SetActive(false)
        self.mGroupPassTips.transform:SetParent(self.UITrans, false)
    end)
end

function onOpenAbnormalView(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_ABNORMAL_SHOW_PANEL, { stageId = self.mStageId })
end

-- 打开排行奖励
function onOpenRank(self)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_RANK_PANEL)
    GameDispatcher:dispatchEvent(EventName.OPEN_RANK_MAIN_PANEL, { type = rank.RankConst.RANK_IMPLIED })
end

-- 打开战利品展示
function onOpenTrophyShow(self)
    if #dup.DupImpliedManager:getOwnMatrixList(self.mStageId) <= 0 then
        -- gs.Message.Show("未获得矩阵")
        gs.Message.Show(_TT(42100))
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_MATRIX_SHOW_PANEL, { stageId = self.mStageId })
end

function onResetHandler(self)
    -- 是否重置关卡？（关卡首领将随机生成，已获得的矩阵也将重置）
    UIFactory:alertMessge(_TT(27133), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_DUP_IMPLIED_RESET, { stageId = self.mStageId })
        self:onCloseDupViewHandler()
    end, _TT(1), nil, true, nil, _TT(2))
end

function onScollContentClick(self)
    self:onCloseDupInfoHandler()
end

function onOpenDupInfoHandler(self, cusDupId)
    if self.mCurSelectDupId ~= nil then 
        if self.mCurSelectDupId == cusDupId then return end

        if self.gInfoView then
            self.gInfoView:showUpdateUIAnimator()
        end
    end
    self.mCurSelectDupId = cusDupId
    for i, item in ipairs(self.mDupItemList) do
        if item.dupData.dupId == cusDupId then
            self.tweenInfo = { dupId = cusDupId, posX = self.mGroupMap.localPosition.x, posY = self.mGroupMap.localPosition.y }
            TweenFactory:move2Lpos(self.mGroupMap, self.mGroupMap.localPosition - self.mCenterPoint:InverseTransformPoint(item.UITrans.position), 0.3, nil, function()
                self:__onOpenDupInfoHandler(cusDupId)
            end)
        end
    end
end
function onCloseDupInfoHandler(self)
    self:onCloseDupViewHandler()
    self:tweenOff()
end

function tweenOff(self, isNow)
    if not self.tweenInfo then
        return
    end
    for i, item in ipairs(self.mDupItemList) do
        if item.dupData.dupId == self.tweenInfo.dupId then
            if isNow then
                gs.TransQuick:LPos(self.mGroupMap, gs.Vector3(self.tweenInfo.posX, self.tweenInfo.posY, 0))
            else
                TweenFactory:move2Lpos(self.mGroupMap, gs.Vector3(self.tweenInfo.posX, self.tweenInfo.posY, 0), 0.3)
            end
        else
            item:setActive(true)
        end
    end
end

-- 副本信息
function __onOpenDupInfoHandler(self, cusDupId)
    if self.gInfoView == nil then
        self.gInfoView = dup.DupImpliedDupInfoView.new()
    end
    self.gInfoView:show(self.mGroupInfo, cusDupId)
    self.mImgToucher:SetActive(true)
end
-- 关闭副本详情
function onCloseDupViewHandler(self)
    if self.gInfoView then 
        self.gInfoView:showExitUIAnimator()
    end

    LoopManager:setTimeout(0.3, self, function()
        if self.gInfoView then
            self.gInfoView:destroy()
            self.gInfoView = nil
        end
    end)

    self.mCurSelectDupId = nil
    self.mImgToucher:SetActive(false)
end

function onInfoUpdate(self)
    local curDiffId = dup.DupImpliedManager:getImpliedDiffId()
    if curDiffId == 0 then 
        self:close()
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_ENTER_PANEL)
        GameDispatcher:dispatchEvent(EventName.CLOSE_DUP_IMPLIED_ENTER_PANEL)
        return
    end

    -- if GameManager:checkDialy5Reset() then
    --     return
    -- else
        self.mStageId = nil
        self.mCurStageItem = nil
        self:onCloseDupInfoHandler()
    --end

    self:updateStage()
    self:setMapView()
    self:updateAbnormal()
end

function updateView(self)
    -- self:showDupList()
    self:setMapView()
    self:updateAbnormal()
end


-- 设置当前的地图
function setMapView(self)
    self:destroyMapView()
    -- self:setDissolve()

    local stageData = dup.DupImpliedManager:getStageData(self.mStageId)
    --self:setBg(string.format("dup_implied_bg_%s.jpg", stageData.imgId), false, "dup")

    -- local mapViewGo = gs.GOPoolMgr:Get(UrlManager:getUIPrefabPath(string.format("dupImplied/DupImpliedMap_%s.prefab", self.mStageId)))
    local mapViewGo = gs.GOPoolMgr:Get(UrlManager:getUIPrefabPath("dupImplied/DupImpliedMap_new.prefab"))
    mapViewGo.transform:SetParent(self.mGroupMap, false)
    self.mapViewGo = mapViewGo

    self.mMapViewGos, self.mMapViewTrans = GoUtil.GetChildHash(self.mapViewGo)

    local dupList = dup.DupImpliedManager:getCurDiffStageList(self.mStageId)
    for i = 1, #dupList do
        if self.mMapViewGos["dupItem_" .. i] then
            local item = dup.DupImpliedDupItem.new()
            item:setup(self.mMapViewGos["dupItem_" .. i])
            item:setData(dupList[i])
            table.insert(self.mDupItemList, item)
        end
    end

    -- local passCount, allCount = dup.DupImpliedManager:getStageProgress(self.mStageId)
    -- if passCount == 0 then
    --     self.mBtnReset:SetActive(false)
    -- else
    --     self.mBtnReset:SetActive(true)
    -- end
end

function destroyMapView(self)
    if self.mapViewGo then

        for i = 1, #self.mDupItemList do
            local item = self.mDupItemList[i]
            item:destroy()
        end
        self.mDupItemList = {}

        gs.GameObject.Destroy(self.mapViewGo)
        self.mapViewGo = nil
    end
end

function setDissolve(self)
    self.clipValue = 0.35
    LoopManager:removeFrame(self, self.onFrame)
    LoopManager:addFrame(1, 0, self, self.onFrame)
end

function onFrame(self)
    self.clipValue = self.clipValue + 0.02
    if self.clipValue >= 3 then
        LoopManager:removeFrame(self, self.onFrame)
    end
    self.mImgDissolve.material:SetFloat("_Clip", self.clipValue)
end

-- 更新境界选项卡
function updateStage(self)
    self:recoverListItem()
    local list = dup.DupImpliedManager:getOpenStageList()
    local isInit = false
    for i, v in ipairs(list) do
        local item = SimpleInsItem:create(self:getChildGO("GroupEnterItem"), self.mGroupStage, "DupImpliedDupPanelEnterItem")
        item:setText("mTxtName", v.name)

        -- local dupVo = dup.DupImpliedManager:getCurDupVo(v.id)
        -- if not dupVo then
        --     dupVo = dup.DupImpliedManager:getDupVo(dup.DupImpliedManager:getMaxDupId(v.id))
        -- end
        -- item:setText("mTxtProgress", nil, string.format("挑战进度：第%s层", dupVo.sort))
        if dup.DupImpliedManager:getStageAllTime(v.id) == 0 then
            item:setText("mTxtTime", nil, "--")
        else
            local timeStr = TimeUtil.getMSByTime(dup.DupImpliedManager:getStageAllTime(v.id))
            item:setText("mTxtTime", nil, timeStr)
        end
        item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(string.format("dupImplied/dupImplied_%s.png", (2 + i))), true)
        item:getChildGO("mImgPass"):SetActive(dup.DupImpliedManager:getStageIsPass(v.id))
        item:getChildGO("mImgSelect"):SetActive(false)
        gs.TransQuick:LPosX(item:getChildTrans("mGroupClick"), 0)
        item:addUIEvent("mGroupClick", function()
            self:onStageSelect(v.id, item)
        end)
        table.insert(self.mStageItemList, item)

        if not isInit then
            if not self.mStageId then
                -- self.mStageId = v.id
                self:onStageSelect(v.id, item)
                isInit = true
            elseif self.mStageId == v.id then
                self.mStageId = nil
                self:onStageSelect(v.id, item)
                isInit = true
            end
        end
    end
end

function onStageSelect(self, stageId, item)
    if self.mCurStageItem then
        self.mCurStageItem:getChildGO("mImgSelect"):SetActive(false)
        gs.TransQuick:LPosX(self.mCurStageItem:getChildTrans("mGroupClick"), 0)
    end
    self.mCurStageItem = item

    self.mCurStageItem:getChildGO("mImgSelect"):SetActive(true)
    gs.TransQuick:LPosX(self.mCurStageItem:getChildTrans("mGroupClick"), 13)

    if self.mStageId == stageId then
        return
    end
    self.mStageId = stageId

    self:updateView()
end

-- 回收项
function recoverListItem(self)
    if self.mStageItemList then
        for i, v in pairs(self.mStageItemList) do
            v:poolRecover()
        end
    end
    self.mStageItemList = {}
end

-- 更新异常列表
function updateAbnormal(self)
    self:recoverAbnormalListItem()
    local list = dup.DupImpliedManager:getAbnormalList(self.mStageId)
    for i=1,#list do
        local item = SimpleInsItem:create(self:getChildGO("GroupAbnormalItem"), self:getChildTrans("mGroupAbnormal"), "DupImpliedAbnormalItem")

        local data = dup.DupImpliedManager:getAbnormalBaseData(list[i])
        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(data:getIcon()),false)
        table.insert(self.mAbnormalItemList, item)
    end
end
-- 回收项
function recoverAbnormalListItem(self)
    if self.mAbnormalItemList then
        for i, v in pairs(self.mAbnormalItemList) do
            v:poolRecover()
        end
    end
    self.mAbnormalItemList = {}
end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
