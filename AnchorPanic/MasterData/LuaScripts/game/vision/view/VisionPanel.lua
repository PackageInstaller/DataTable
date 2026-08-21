module("vision.VisionPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("vision/VisionPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle( _TT(153206))
    self:setSize(0, 0)
    self:setBg("bg_01.jpg", false, "vision")

    self:setUICode(LinkCode.Vision)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mDupList = {}
    self.mPropsList = {}
    self.mStagePropsList = {}
    self.mTargetItemList = {}
    self.currentClickId = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mBtnRank = self:getChildGO("mBtnRank")

    self.mDupScroll = self:getChildGO("mDupScroll"):GetComponent(ty.ScrollRect)
    self.mDupRect = self:getChildGO("mDupScroll"):GetComponent(ty.RectTransform)
    --self.mDupScrollOriginWidth = 0
    self.mSingleDupItem = self:getChildGO("mSingleDupItem")

    self.mStageInfoClose = self:getChildGO("mStageInfoClose")
    self.mStageInfoClose:SetActive(false)
    self.mStageInfoPanel = self:getChildGO("mStageInfoPanel")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mPropsContent = self:getChildTrans("mPropsContent")
    self.mBtnCloseInfo = self:getChildGO("mBtnCloseInfo")
    self.mTxtMaxScore = self:getChildGO("mTxtMaxScore"):GetComponent(ty.Text)

    self.mDupRoot = self:getChildTrans("mDupRoot")
    self.mleftInfo = self:getChildGO("leftInfo")

    self.mTxtScoreNum = self:getChildGO("mTxtScoreNum"):GetComponent(ty.Text)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTxtShop"):GetComponent(ty.Text).text = _TT(153207)
    self:getChildGO("mTxtRank"):GetComponent(ty.Text).text = _TT(153208)
    self:getChildGO("mTxtAwardTitle"):GetComponent(ty.Text).text = _TT(153209)
    self:getChildGO("mTxtScoreTips"):GetComponent(ty.Text).text = _TT(153210)
end

-- 激活
function active(self, args)
    super.active(self, args)
    --GameDispatcher:addEventListener(EventName.UPDATE_VISION_PANEL, self.showPanel, self)
    MoneyManager:setMoneyTidList({})
    -- 适配可能改变 mDupScroll 实际宽度：super.active 已应用屏幕适配后直接读取当前宽度，
    -- 切勿强制重建 mDupRect 自身（会覆盖屏幕适配算出的宽度），否则 onHideStageClick 会用旧宽度重置视口
    --self.mDupScrollOriginWidth = self.mDupRect.rect.width
    self:onHideStageClick()
    self:showPanel()

    self.mleftInfo:SetActive(true)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    --GameDispatcher:removeEventListener(EventName.UPDATE_VISION_PANEL, self.showPanel, self)
    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
    end
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    self:clearDupList()
    self:clearPropsList()
    self:closeStagePropsList()
    self:clearTargetItemList()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    --self:addUIEvent(self.mBtnReward, self.onBtnRewardClick)

    self:addUIEvent(self.mBtnShop, self.onBtnShopClick)
    self:addUIEvent(self.mBtnRank, self.onBtnRankClick)
    -- self:addUIEvent(self.mBtnDisturbance, self.onBtnDisturbanceClick)

    self:addUIEvent(self.mStageInfoClose, self.onHideStageClick)
    self:addUIEvent(self.mBtnCloseInfo, self.onHideStageClick)

    self:addUIEvent(self.mBtnFight, self.onBtnFightClick)
end

function onBtnShopClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
        linkId = LinkCode.ShopVision
    })
end

function onBtnRankClick(self)
    GameDispatcher:dispatchEvent(EventName.REQ_VISION_MIRROR_RANK_PANEL)
end

-- 打开 Vision 出战前英雄信息界面
function onBtnFightClick(self)
    local clientTime = GameManager:getClientTime()
    if self.lockTime < clientTime then
        gs.Message.Show(_TT(97061))
        return
    end

    local dupVo = vision.VisionManager:getVisionMirrorStageDataByLayer(self.currentClickId)
    if not dupVo then
        return
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_VISION_HERO_INFO_PANEL, {
        dupVo = dupVo,
        layer = self.currentClickId,
        battleType = PreFightBattleType.Vision,
        dupType = DupType.Vision,
        formationType = formation.TYPE.VISION
    })
end

function updateTime(self)
    local clientTime = GameManager:getClientTime()

    if self.lockTime - clientTime > 0 then
        self.mTxtTime.text = _TT(42102, TimeUtil.getFormatTimeBySeconds_1(self.lockTime - clientTime))
    else
        self.mTxtTime.text = _TT(97968, _TT(97970))
    end
end

function showPanel(self)
    -- self.endTime = GameManager:getWeekResetTime() -- vision.VisionManager:getVisionEndTime()
    self.lockTime = GameManager:getMonthResetTime()

    self.mTxtTime.text = _TT(97969)
    self.updateTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)
    self:updateTime()

    self:createDupList()
end

function autoSelectCanFightStage(self, layerList)
    if self.currentClickId then
        return
    end

    -- 默认高亮也取能挑战的最后一个（与滚动目标一致）
    local maxIndex = 0
    for i = 1, #layerList do
        local isLock = false
        if i > 1 then
            local preScore = vision.VisionManager:getServerScoreByStageId(layerList[i - 1].stageId)
            isLock = preScore <= 0
        end
        if not isLock then
            maxIndex = i
        else
            break
        end
    end
    local stageVo = layerList[maxIndex]
    if stageVo then
        self.currentClickId = stageVo.stageId
        self:updateDupSelect()
    end
end


function createDupList(self)
    self:clearDupList()
    local dataMap = vision.VisionManager:getVisionMirrorData()
    local layerList = {}
    for _, layerVo in pairs(dataMap) do
        table.insert(layerList, layerVo)
    end
    table.sort(layerList, function(a, b)
        return a.id < b.id
    end)

    for i = 1, #layerList do
        local vo = layerList[i]
        local item = SimpleInsItem:create(self.mSingleDupItem, self.mDupScroll.content, "myVisionDupItem")

        item:getChildGO("mTxtNum"):GetComponent(ty.Text).text = i

        local isLock = false

        if i == 1 then
            isLock = false
        else
            local preScore = vision.VisionManager:getServerScoreByStageId(layerList[i - 1].stageId)
            isLock = preScore <= 0
        end

         local passScore = vision.VisionManager:getServerScoreByStageId(layerList[i].stageId)
        local isPass = passScore > 0
        item:getChildGO("mIsLock"):SetActive(isLock)
        item:getChildGO("mIsPass"):SetActive(isPass)

        item:getChildGO("mTxtState"):GetComponent(ty.Text).text =  "" 
        local list = vision.VisionManager:getServerDupListByLayer(layerList[i].stageId)

        item.m_go:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath("vision/icon_"..#list..".png"),false)
        
        item:getChildGO("mImgAward"):GetComponent(ty.AutoRefImage):SetImg(isPass and UrlManager:getIconPath("vision/vision_open.png") or UrlManager:getIconPath("vision/vision_lock.png"),false)
        item:getChildGO("mIsLock"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath("vision/icon_"..#list..".png"),false)

        item:addUIEvent(nil, function()
            if isLock then
                -- 上一层尚未通关（无分数），未解锁
                gs.Message.Show("请先挑战通过上一层")
                return
            end
            self:onClickStageHandler(vo)
        end)

        table.insert(self.mDupList, {
            item = item,
            vo = vo
        })
    end

    self:autoSelectCanFightStage(layerList)

    if not self.isReshow then
        -- 参考 doundless（原垂直滚动：content.anchoredPosition.y 偏移定位最远可挑战层）；
        -- 异象残境改为横向滚动：用 horizontalNormalizedPosition 把最远可挑战层（maxIndex）居中到视口
        local maxIndex = 0
        for i = 1, #layerList do
            local isLock = false
            if i > 1 then
                local preScore = vision.VisionManager:getServerScoreByStageId(layerList[i - 1].stageId)
                isLock = preScore <= 0
            end
            if not isLock then
                maxIndex = i
            else
                break
            end
        end

        -- 直接读取当前已适配的视口宽度（屏幕适配后的值），不要再用 configUI 缓存的旧宽度
        --self.mDupScrollOriginWidth = self.mDupRect.rect.width
        -- 无动画，直接定位最远可挑战层到视口正中
        self.mDupScroll.horizontalNormalizedPosition = self:getDupCenterNorm(maxIndex)
    end
end

-- 计算使第 index 项在“当前视口（mDupRect，含点击收缩后的宽度）”正中的 horizontalNormalizedPosition
-- 直接用世界坐标变换取子项中心，与子项/视口 pivot 无关，避免手工 anchoredPosition 反推导致的错层
function getDupCenterNorm(self, index)
    local scroll = self.mDupScroll
    local contentTrans = scroll.content
    local viewportRect = self.mDupRect

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(contentTrans)
    local targetItem = self.mDupList[index] and self.mDupList[index].item
    if not targetItem then
        return 0
    end

    local contentWidth = contentTrans.rect.width
    local viewportWidth = viewportRect.rect.width
    local scrollable = contentWidth - viewportWidth
    if scrollable <= 0 then
        return 0
    end

    -- 子项中心在 content 本地坐标系下的 x（世界变换，pivot 无关）
    local itemTrans = targetItem.m_go:GetComponent(ty.RectTransform)
    local itemWorld = itemTrans:TransformPoint(gs.Vector3(itemTrans.rect.center.x, itemTrans.rect.center.y, 0))
    local itemCenterInContent = contentTrans:InverseTransformPoint(itemWorld).x

    -- 让子项中心对齐视口中心：itemCenterInContent - p*scrollable = viewportWidth/2
    local p = (itemCenterInContent - viewportWidth / 2) / scrollable
    return gs.Mathf.Clamp(p, 0, 1)
end

function updateDupSelect(self)
    for k, data in pairs(self.mDupList) do
        local isSelect = data.vo.stageId == self.currentClickId
        data.item:getChildGO("mIsSelect"):SetActive(isSelect)
    end
end

function onClickStageHandler(self, stageVo)
    self.mleftInfo:SetActive(false)
    -- 记录当前点击项在列表中的索引，供居中用
    local clickIndex = 0
    for k, data in ipairs(self.mDupList) do
        if data.vo.stageId == stageVo.stageId then
            clickIndex = k
            break
        end
    end
    if self.moveTween then
        self.moveTween:Kill()
    end
    self.moveTween = TweenFactory:move2LPosX(self.mDupRoot, -250, 0.3)
    -- 直接收缩 mDupScroll 宽度（无动画），露出关卡信息面板
    --gs.TransQuick:SizeDelta01(self.mDupRect, self.mDupScrollOriginWidth - 500)
    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mDupRect)
    -- -- 选中节点直接定位到收缩后视口正中（无动画）
    -- self:centerOnDupItem(clickIndex)

    self.mStageInfoPanel:SetActive(true)
    self.currentClickId = stageVo.stageId
    self.mDupVo = vision.VisionManager:getVisionMirrorStageDataByLayer(stageVo.stageId)
    self:updateDupSelect()
    self.mTxtName.text = stageVo:getName()
    --local realDupId = vision.VisionManager:getServerDupIdByLayer(stageVo.stageId)
    self.mTxtDes.text = _TT(stageVo.des)  --.. (realDupId ~= "" and ("  " .. realDupId) or "")
    self.mTxtMaxScore.text = _TT(153204, stageVo.limitPoint)

    self.mTxtScoreNum.text = vision.VisionManager:getServerScoreByStageId(stageVo.stageId)

    local point = vision.VisionManager:getServerScoreByStageId(self.currentClickId)

    self:closeStagePropsList()
    local propsList = AwardPackManager:getAwardListById(stageVo.firstAwardId)
    for k, propsVo in pairs(propsList) do
        local propsGrid = PropsGrid:createByData({
            tid = propsVo.tid,
            num = propsVo.num,
            parent = self.mPropsContent,
            scale = 0.7,
            showUseInTip = true
        })
        propsGrid:setHasRec(point > 0)
        table.insert(self.mStagePropsList, propsGrid)
    end
    self.mStageInfoClose:SetActive(true)
end

function onHideStageClick(self)
    self.currentClickId = nil
    self.mDupVo = nil
    self:updateDupSelect()
    self.mStageInfoPanel:SetActive(false)
    self.mStageInfoClose:SetActive(false)
     if self.moveTween then
        self.moveTween:Kill()
    end
    self.moveTween = TweenFactory:move2LPosX(self.mDupRoot, 0, 0.3)

    -- 直接恢复 mDupScroll 原始宽度（无动画）
    --gs.TransQuick:SizeDelta01(self.mDupRect, self.mDupScrollOriginWidth)
    self.mleftInfo:SetActive(true)
end

-- 将指定索引的节点滚动到“当前视口（已收缩的 mDupScroll）”正中间
function centerOnDupItem(self, index)
    -- 直接驱动 ScrollRect.horizontalNormalizedPosition，由 ScrollRect 自行回写并边界 clamp（无动画）
    self.mDupScroll.horizontalNormalizedPosition = self:getDupCenterNorm(index)
end

function closeStagePropsList(self)
    for i = 1, #self.mStagePropsList do
        self.mStagePropsList[i]:poolRecover()
    end
    self.mStagePropsList = {}
end

function clearTargetItemList(self)
    for i = 1, #self.mTargetItemList do
        self.mTargetItemList[i]:poolRecover()
    end
    self.mTargetItemList = {}
end

function clearDupList(self)
    for i = 1, #self.mDupList do
        self.mDupList[i].item:poolRecover()
    end
    self.mDupList = {}
end

function clearPropsList(self)
    for i = 1, #self.mPropsList do
        self.mPropsList[i]:poolRecover()
    end
    self.mPropsList = {}
end


return _M
