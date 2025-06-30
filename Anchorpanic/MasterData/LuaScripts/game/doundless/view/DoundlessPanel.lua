module("doundless.DoundlessPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("doundless/DoundlessPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle("无限城")
    self:setSize(0, 0)
    self:setBg("Infinitycity_bg_01.jpg", false, "doundless")

    self:setUICode(LinkCode.Doundless)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mDupList = {}
    self.mPropsList = {}

    self.mStagePropsList = {}

    self.mTargetItemList = {}

    self.mPlayeList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtWar = self:getChildGO("mTxtWar"):GetComponent(ty.Text)
    self.mTxtCity = self:getChildGO("mTxtCity"):GetComponent(ty.Text)
    self.mTxtLockTime = self:getChildGO("mTxtLockTime"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mBtnReward = self:getChildGO("mBtnReward")
    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mBtnDisturbance = self:getChildGO("mBtnDisturbance")
    self.mTxtDisturbance = self:getChildGO("mTxtDisturbance"):GetComponent(ty.Text)

    self.mImgSkill = self:getChildGO("mImgSkill"):GetComponent(ty.AutoRefImage)
    self.mTxtSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)

    self.mTxtChange = self:getChildGO("mTxtChange"):GetComponent(ty.Text)
    self.mTxtPoint = self:getChildGO("mTxtPoint"):GetComponent(ty.Text)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtNeedPoint = self:getChildGO("mTxtNeedPoint"):GetComponent(ty.Text)

    self.mDupScroll = self:getChildGO("mDupScroll"):GetComponent(ty.ScrollRect)
    self.mDupRect = self:getChildGO("mDupScroll"):GetComponent(ty.RectTransform)
    self.mSingleDupItem = self:getChildGO("mSingleDupItem")

    self.mStageInfoClose = self:getChildGO("mStageInfoClose")
    self.mStageInfoPanel = self:getChildGO("mStageInfoPanel") 
    -- self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mPropsContent = self:getChildTrans("mPropsContent")
    self.mBtnAnemyFormation = self:getChildGO("mBtnAnemyFormation")
    self.mTxtScoreNum = self:getChildGO("mTxtScoreNum"):GetComponent(ty.Text)
    self.mBtnCloseInfo = self:getChildGO("mBtnCloseInfo")
    self.mTxtMaxScore = self:getChildGO("mTxtMaxScore"):GetComponent(ty.Text)

    self.mTargetScroll = self:getChildGO("mTargetScroll"):GetComponent(ty.ScrollRect)
    self.mTargetItem = self:getChildGO("mTargetItem")

    self.mDupRoot = self:getChildTrans("mDupRoot")
    self.mleftInfo = self:getChildGO("leftInfo")

    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")

    self:setGuideTrans("functips_doundless_leftTop", self:getChildTrans("functips_doundless_leftTop"))
    self:setGuideTrans("functips_doundless_leftBottom", self:getChildTrans("functips_doundless_leftBottom"))
    self:setGuideTrans("functips_doundless_skill", self:getChildTrans("functips_doundless_skill"))

    self:setGuideTrans("functips_doundless_stageTitle", self:getChildTrans("functips_doundless_stageTitle"))
    self:setGuideTrans("mFunctips_doundless_stageTarget", self:getChildTrans("mFunctips_doundless_stageTarget"))
    self:setGuideTrans("mFunctips_doundless_stageScore", self:getChildTrans("mFunctips_doundless_stageScore"))
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTxtChangeTips"):GetComponent(ty.Text).text = _TT(97015)
    self:getChildGO("mTxtPointTips"):GetComponent(ty.Text).text = _TT(97019)
    self:getChildGO("mTxtRankTips"):GetComponent(ty.Text).text = _TT(97020)
    -- self:getChildGO("mTxtNeedPointTips"):GetComponent(ty.Text).text = _TT(97021)
end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_DOUNDLESS_PANEL, self.showPanel, self)
    MoneyManager:setMoneyTidList({})
    self:showPanel()
    self:onHideStageClick()

    self.mleftInfo:SetActive(true)
end

-- 反激活（销毁工作）
function deActive(self)
    --self.lastY = self.mDupScroll.content.anchoredPosition.y
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DOUNDLESS_PANEL, self.showPanel, self)
    if self.tweenSn then
        LoopManager:removeFrameByIndex(self.tweenSn)
        self.tweenSn = nil
    end

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
    end
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    self:clearPlayerList()
    self:clearTargetItemList()
    self:closeStagePropsList()
    self:clearPropsList()
    self:clearDupList()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnReward, self.onBtnRewardClick)

    self:addUIEvent(self.mBtnShop, self.onBtnShopClick)
    self:addUIEvent(self.mBtnRank, self.onBtnRankClick)
    self:addUIEvent(self.mBtnDisturbance, self.onBtnDisturbanceClick)

    self:addUIEvent(self.mStageInfoClose, self.onHideStageClick)
    self:addUIEvent(self.mBtnCloseInfo, self.onHideStageClick)

    self:addUIEvent(self.mBtnFight, self.onBtnFightClick)
    self:addUIEvent(self.mBtnAnemyFormation, self.onOpenFormationPanel)

    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, {
        id = LinkCode.Doundless
    })
end

function updateTime(self)
    -- self.lockTime = GameManager:getWeekResetTime() - 7 * 3600
    local clientTime = GameManager:getClientTime()

    if self.lockTime - clientTime > 0 then
        self.mTxtLockTime.text = _TT(97968, TimeUtil.getFormatTimeBySeconds_1(self.lockTime - clientTime))
    else
        self.mTxtLockTime.text = _TT(97968, _TT(97970))
    end

    --     self.mTxtTime.text =
    -- _TT(97969,TimeUtil.getFormatTimeBySeconds_1(self.endTime - clientTime))
    -- "剩余时间:<color=#fa3a2b>" .. TimeUtil.getFormatTimeBySeconds_1(self.endTime - clientTime) .. "</color>"
end

function showPanel(self)
    -- self.endTime = GameManager:getWeekResetTime() -- doundless.DoundlessManager:getDoundlessEndTime()
    self.lockTime = GameManager:getWeekResetTime() - 7 * 3600

    self.mTxtTime.text = _TT(97969)
    self.updateTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)
    self:updateTime()

    self.roundId = doundless.DoundlessManager:getServeRoundId()
    self.warId = doundless.DoundlessManager:getServerWayId()
    self.cityId = doundless.DoundlessManager:getServerCityId()
    self.maxDup = doundless.DoundlessManager:getCanOpenDupId()

    self:clearPlayerList()
    self:clearPropsList()
    self:clearDupList()

    local w, h = ScreenUtil:getScreenSize(nil)
    gs.TransQuick:SizeDelta02(self.mDupRect, h)

    local name = doundless.getCityName(self.cityId)

    self.mTxtCity.text = name

    local warName = doundless.getWarName(self.warId)
    local cityData = doundless.DoundlessManager:getDoundlessCityDataByWar(self.warId)
    self.mTxtWar.text = warName .. " " .. cityData.leftLevel .. "-" .. cityData.rightLevel

    self.myInfo = doundless.DoundlessManager:getMyPlayerInfo()
    local state = doundless.DoundlessManager:getServerSettleState()
    if state == 1 then
        self.mTxtChange.text = _TT(97017)
    elseif state == 2 then
        self.mTxtChange.text = _TT(97016)
    elseif state == 3 then
        self.mTxtChange.text = _TT(97018)
    end

    self.mTxtPoint.text = doundless.DoundlessManager:getServerPoint()
    self.mTxtRank.text = doundless.DoundlessManager:getServerRank()
    self.mTxtNeedPoint.text = cityData:getSingleCityData(self.cityId).stayPoint
    -- self:getChildGO("mTxtNeedPointTips"):SetActive(self.cityId > 1)

    self:getChildGO("mTxtNeedPointTips"):GetComponent(ty.Text).text = self.cityId > 1 and _TT(97021) or _TT(97063)

    local roundVo = doundless.DoundlessManager:getDoundlessRoundData(self.roundId, self.warId, self.cityId)

    local skillRo = fight.SkillManager:getSkillRo(roundVo.mSkillId)
    self.mImgSkill:SetImg(UrlManager:getSkillIconPath(skillRo:getIcon()), false)
    self.mTxtSkillName.text = skillRo:getName()

    self.mDisturbanceId = doundless.DoundlessManager:getDistubanceId()
    local distanceVo = cityData:getDistributeData(self.cityId, self.mDisturbanceId)
    self.mTxtDisturbance.text = _TT(97014) .. distanceVo.radio

    local maxIndex = 0
    local list =  doundless.DoundlessManager:getDupList()--  roundVo.mDupList
    local isAllPass = doundless.DoundlessManager:getServerScoreByStageId(list[#list]) > 0

    for i = 1, #list do
        local vo = doundless.DoundlessManager:getDoundlessCityStageDataById(list[i])

        if self.maxDup == vo.stageId then
            maxIndex = i
        end

        local item = SimpleInsItem:create(self.mSingleDupItem, self.mDupScroll.content, "myDoundlessDupItem")

        item.m_go:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
            "doundless/doundless_dup_" .. self.cityId .. ".png"), false)
        for i = 1, 6 do
            item:getChildGO("arr" .. i):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
                "doundless/doundless_arr_" .. self.cityId .. ".png"), false)
        end
        item:getChildGO("mEffect_0" .. self.cityId):SetActive(self.maxDup == vo.stageId)

        item:getChildGO("mIsSelect"):SetActive(self.clickId == vo.stageId)
        item:getChildGO("mIsSelect0" .. self.cityId):SetActive(self.clickId == vo.stageId)

        local point = doundless.DoundlessManager:getServerScoreByStageId(vo.stageId)

        item:getChildGO("mTxtScore"):GetComponent(ty.Text).text =_TT(97013, point)
        item:getChildGO("mTxtScoreMax"):GetComponent(ty.Text).text = _TT(97971,vo.limitPoint)
        
        item:getChildGO("mUnLockEff"):SetActive(point <= 0 and self.maxDup < vo.stageId)
        item:getChildGO("mScoreInfo"):SetActive(point > 0)

        item:getChildGO("mTxtNum"):GetComponent(ty.Text).text = vo.indexName
        item:getChildGO("mTxtNum"):SetActive(self.maxDup <= vo.stageId)

        item:getChildGO("mTxtNumPass"):GetComponent(ty.Text).text = vo.indexName
        item:getChildGO("mTxtNumPass"):SetActive(self.maxDup > vo.stageId)

        item:getChildGO("mIsPass0" .. self.cityId):SetActive(self.maxDup > vo.stageId)

        -- item:getChildGO("mImgSelect"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
        --     "doundless/doundless_select_" .. self.cityId .. ".png"), false)

        local playList = doundless.DoundlessManager:getMaxDupPlayerList(vo.stageId)
        local playTrans = item:getChildTrans("mHeadContent")
        for i = 1, 5 do
            if playList[i] then
                local playerGrid = PlayerHeadGrid:create(playTrans, playList[i].avatar_id, 0.5, false)
                playerGrid:setHeadFrame(playList[i].avatar_frame_id)
                playerGrid:setCallBack(self, function()
                    self:onClickMoreInfoHandler(vo)
                end)
                table.insert(self.mPlayeList, playerGrid)
            end
        end
        item:getChildGO("mBtnMore"):SetActive(#playList > 5)
        item:addUIEvent("mBtnMore", function()
            self:onClickMoreInfoHandler(vo)
        end)

        item:addUIEvent(nil, function()
            self:onClickStageHandler(vo)
        end)

        local propsTrans = item:getChildTrans("mPropsContent")
        local propsList = AwardPackManager:getAwardListById(vo.firstAwardId)

        for k, propsVo in pairs(propsList) do
            local propsGrid = PropsGrid:createByData({
                tid = propsVo.tid,
                num = propsVo.num,
                parent = propsTrans,
                scale = 0.6,
                showUseInTip = true
            })
            propsGrid:setHasRec(point > 0)
            table.insert(self.mPropsList, propsGrid)
        end
        -- item
        table.insert(self.mDupList, {
            item = item,
            vo = vo
        })

        if i == 1 then
            self:setGuideTrans("guide_Doundless_DupItem_1", item.m_go.transform)
        end
    end

    if isAllPass == false and not self.isReshow then
        local index = gs.Mathf.Clamp(maxIndex - 2, 0, #list)
        local targetY = index * -259
        local frame = 60
        self.len = 0
        if self.tweenSn then
            LoopManager:removeFrameByIndex(self.tweenSn)
            self.tweenSn = nil
        end

        self.tweenSn = LoopManager:addFrame(0, frame, self, function()
            self.len = 1 / frame + self.len
            local endPos = self:easeOutCubic(self.mDupScroll.content.anchoredPosition.y, targetY, self.len)
            gs.TransQuick:UIPosY(self.mDupScroll.content, endPos)
        end)
    end
    --gs.TransQuick:UIPosY(self.mDupScroll.content,self.lastY)
end

function easeOutCubic(self, sPos, ePos, value)
    value = value - 1
    ePos = ePos - sPos
    return ePos * (value * value * value + 1) + sPos
end

function updateDupSelect(self)
    for k, data in pairs(self.mDupList) do
        if data.vo.stageId == self.currentClickId then
            -- data.item:getChildGO("mTxtNum"):SetActive(false)
            data.item:getChildGO("mIsSelect"):SetActive(true)
            data.item:getChildGO("mIsSelect0" .. self.cityId):SetActive(true)
        else
            -- data.item:getChildGO("mTxtNum"):SetActive(true)
            data.item:getChildGO("mIsSelect"):SetActive(false)
            data.item:getChildGO("mIsSelect0" .. self.cityId):SetActive(false)
        end
    end
end

function onClickStageHandler(self, stageVo)
    self.mleftInfo:SetActive(false)
    if self.moveTween then
        self.moveTween:Kill()
    end
    self.moveTween = TweenFactory:move2LPosX(self.mDupRoot, -250, 0.3)
    self.mStageInfoPanel:SetActive(true)
    self.mBtnFuncTips:SetActive(false)
    self.currentClickId = stageVo.stageId
    self:updateDupSelect()
    -- self.mTxtDes.text = "暂时没有描述"
    self.mTxtName.text = stageVo.indexName
    self.mTxtMaxScore.text = _TT(97060, stageVo.limitPoint)
    local point = doundless.DoundlessManager:getServerScoreByStageId(self.currentClickId)
    self.mTxtScoreNum.text = point

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

    self:clearTargetItemList()
    for i = 1, #stageVo.targetList do
        local id = stageVo.targetList[i]
        local vo = doundless.DoundlessManager:getDoundlessCityTargetData(id)

        local item = SimpleInsItem:create(self.mTargetItem, self.mTargetScroll.content, "myDoundlessPanelTargetItem")
        item:getChildGO("mTxtDes"):GetComponent(ty.Text).text = _TT(vo.des) .. _TT(97051, vo.point)

        table.insert(self.mTargetItemList, item)
    end

    self.mBtnFight:SetActive(stageVo.stageId <= self.maxDup)
end

function onClickMoreInfoHandler(self, stageVo)
    GameDispatcher:dispatchEvent(EventName.OPEN_DOUNDLESS_LOG_PANEL, stageVo.stageId)
end

function clearPlayerList(self)
    for i = 1, #self.mPlayeList do
        self.mPlayeList[i]:poolRecover()
    end
    self.mPlayeList = {}
end

function clearTargetItemList(self)
    for i = 1, #self.mTargetItemList do
        self.mTargetItemList[i]:poolRecover()
    end
    self.mTargetItemList = {}
end

function onHideStageClick(self)
    self.currentClickId = nil
    self:updateDupSelect()
    self.mStageInfoPanel:SetActive(false)
    self.mBtnFuncTips:SetActive(true)
    if self.moveTween then
        self.moveTween:Kill()
    end
    self.moveTween = TweenFactory:move2LPosX(self.mDupRoot, 0, 0.3)
    self.mleftInfo:SetActive(true)
end

function closeStagePropsList(self)
    for i = 1, #self.mStagePropsList do
        self.mStagePropsList[i]:poolRecover()
    end
    self.mStagePropsList = {}
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

function onBtnRewardClick(self)
    doundless.DoundlessManager:setCanOpenView(doundless.CanOpenType.Award)
    GameDispatcher:dispatchEvent(EventName.REQ_UPDATE_DOUNDLESS_INFO)
end

function onBtnShopClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
        linkId = LinkCode.ShopDoundless
    })
end

function onBtnRankClick(self)
    doundless.DoundlessManager:setCanOpenView(doundless.CanOpenType.Rank)
    GameDispatcher:dispatchEvent(EventName.REQ_UPDATE_DOUNDLESS_INFO)
end

function onBtnDisturbanceClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DOUNDLESS_DISTURBANCE_PANEL)
end

function onOpenFormationPanel(self)
    local dupVo = doundless.DoundlessManager:getDoundlessCityStageDataById(self.currentClickId)
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, {
        dupVo = dupVo
    })
end

function onBtnFightClick(self)
    local clientTime = GameManager:getClientTime()
    if self.lockTime < clientTime then
        gs.Message.Show(_TT(97061))
        return
    end

    local dupVo = doundless.DoundlessManager:getDoundlessCityStageDataById(self.currentClickId)
    local formationType = formation.TYPE.DOUNDLESSLOCK
    if dupVo.isNormal == 1 then
        formationType = formation.TYPE.DOUNDLESS
    end

    formation.checkFormationFight(PreFightBattleType.Doundless, DupType.Doundless, self.currentClickId,
        formationType, nil, nil, nil)
end

return _M
