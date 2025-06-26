--[[
-----------------------------------------------------
@filename       : DormitoryMainUI
@Description    : 宿舍主UI
@date           : 2021-07-21 17:26:02
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.view.DormitoryMainUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dormitory/DormitoryMainUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")
    self:setTxtTitle(_TT(52021))
    self:setUICode(LinkCode.Dormitory)
end
--析构
function dtor(self)
end

function initData(self)
    self.mItemList = {}
    if gs.Application.isEditor then
        dormitory.DormitoryCamera = require("game/dormitory/utils/DormitoryCamera")
    end
    self.mDormitoryCamera = dormitory.DormitoryCamera.new()

    self.hideUI = false
    self.quotaCount = 0

    self.mBubbleList = {}

    self.mHideLiveTime = 0
end
-- 设置货币栏
function setMoneyBar(self)
end
-- 初始化
function configUI(self)
    self.mGroupItem = self:getChildGO("mGroupItem")
    self.mGroupInfo = self:getChildGO("mGroupInfo")
    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    self.mTouchArea = self:getChildGO("mTouchArea"):GetComponent(ty.LongPressOrClickEventTrigger)
    self.Content = self:getChildTrans("Content")
    self.mBtnSave = self:getChildGO("mBtnSave")
    self.mBtnReset = self:getChildGO("mBtnReset")
    self.mBtnAllStorage = self:getChildGO("mBtnAllStorage")

    self.mGroupMenu = self:getChildGO("mGroupMenu")
    self.mFurnitureMenu = self:getChildTrans("mFurnitureMenu")
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnSure = self:getChildGO("mBtnSure")
    self.mBtnStorage = self:getChildGO("mBtnStorage")
    self.mBtnRotate = self:getChildGO("mBtnRotate")

    -- self.mTabContent = self:getChildTrans("TabContent")

    self.mBtnEdit = self:getChildGO("mBtnEdit")
    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mBtnHideUI = self:getChildGO("mBtnHideUI")
    self.mGroupHideUI = self:getChildGO("mGroupHideUI")
    self.mImgHideUI = self:getChildGO("mImgHideUI")
    self.mImgShowUI = self:getChildGO("mImgShowUI")
    self.mBtnInfo = self:getChildGO("mBtnInfo")
    self.mBtnSettleInfo = self:getChildGO("mBtnSettleInfo")

    self.mTxtAllCount = self:getChildGO("mTxtAllCount"):GetComponent(ty.Text)
    self.mGroupBring = self:getChildGO("mGroupBring")
    self.mImgBring = self:getChildGO("mImgBring"):GetComponent(ty.Image)
    self.mGroupQuotalimit = self:getChildGO("mGroupQuotalimit")
    self.mTextQuotalimit1 = self:getChildGO("mTextQuotalimit1"):GetComponent(ty.Text)
    self.mTextQuotalimit2 = self:getChildGO("mTextQuotalimit2"):GetComponent(ty.Text)
    self.mTextQuotalimitLabel = self:getChildGO("mTextQuotalimitLabel"):GetComponent(ty.Text)
    self.mItemBubble = self:getChildGO("mItemBubble")
    self.mGroupBubble = self:getChildGO("mGroupBubble")
    self.mGroupLiveOption = self:getChildGO("mGroupLiveOption")
    self.mBtnLiveMove = self:getChildGO("mBtnLiveMove")
    self.mBtnLiveInter = self:getChildGO("mBtnLiveInter")
    self.mTextLiveName = self:getChildGO("mTextLiveName"):GetComponent(ty.Text)

    self.mTextBaseAura = self:getChildGO("mTextBaseAura"):GetComponent(ty.Text)
    self.mTexeEditAura = self:getChildGO("mTexeEditAura"):GetComponent(ty.Text)

    self.mTextRecovery_1 = self:getChildGO("mTextRecovery_1"):GetComponent(ty.Text)
    self.mTextRecovery_2 = self:getChildGO("mTextRecovery_2"):GetComponent(ty.Text)
    self.mBtnInteract = self:getChildGO("mBtnInteract")

    self.mScroll1 = self:getChildGO("mScroll1")
    self.mScroll2LyScroll = self:getChildGO("mScroll2"):GetComponent(ty.LyScroller)
    self.mScroll2LyScroll:SetItemRender(dormitory.DormitoryFurnitureItem)
    self.Root_5 = self:getChildGO("Root_5")

    self.mImgSettleInfoNor = self:getChildGO("mImgSettleInfoNor")
    self.mImgSettleInfoSelect = self:getChildGO("mImgSettleInfoSelect")
    self.mImgInfoNor = self:getChildGO("mImgInfoNor")
    self.mImgInfoSelect = self:getChildGO("mImgInfoSelect")

    self.mTextLiveInter = self:getChildGO("mTextLiveInter"):GetComponent(ty.Text)
    self.mTextLiveMove = self:getChildGO("mTextLiveMove"):GetComponent(ty.Text)

    self.mEditorSuit = self:getChildGO("mEditorSuit")

    self.mItemBubble:SetActive(false)
    self.mGroupLiveOption:SetActive(false)
    self.mGroupBring:SetActive(false)
    self.mGroupBubble:SetActive(false)
    self.Root_5:SetActive(true)
    self.mBtnInteract:SetActive(false)

    self.mImgSettleInfoNor:SetActive(true)
    self.mImgSettleInfoSelect:SetActive(false)

    self.mImgInfoNor:SetActive(true)
    self.mImgInfoSelect:SetActive(false)

    self:onHideUI()
    self:setGuideTrans("funcTips_guide_dormitory_1", self:getChildTrans("mImgBgAura"))
    self:setGuideTrans("funcTips_guide_dormitory_2", self:getChildTrans("mImgRecovery"))
    self:setGuideTrans("funcTips_guide_dormitory_3", self.mBtnShop.transform)
    self:setGuideTrans("funcTips_guide_dormitory_4", self.mBtnEdit.transform)
    self:setGuideTrans("funcTips_guide_dormitory_5", self.mBtnSettleInfo.transform)
end

function initViewText(self)
    self.mTextLiveInter.text = _TT(49719)
    self.mTextLiveMove.text = _TT(49720)
end

--激活
function active(self, args)
    super.active(self)

    if GameManager.IS_DEBUG and not GameManager.HIDE_DEBUG_INFO then
        self.mEditorSuit:SetActive(true)
    else
        self.mEditorSuit:SetActive(false)
    end

    if gs.Application.isEditor then
        dormitory.DormitoryFurnitureItem = require("game/dormitory/view/item/DormitoryFurnitureItem")
    end

    self.m_RoomId = args

    GameDispatcher:dispatchEvent(EventName.REQ_DORMITORY_INFO)

    GameDispatcher:addEventListener(EventName.SAVA_DORMITORT_FINISH, self.outEdit, self)
    GameDispatcher:addEventListener(EventName.START_DRAG_FURNITURE, self.onStartDragHanlder, self)
    GameDispatcher:addEventListener(EventName.END_DRAG_FURNITURE, self.onEndDragHanlder, self)
    GameDispatcher:addEventListener(EventName.SELECT_FURNITURE_PUT, self.onSelectFurniturePutHanlder, self)
    GameDispatcher:addEventListener(EventName.PUT_FURNITURE_RETURN, self.onPutFurnitureReturnHandler, self)
    GameDispatcher:addEventListener(EventName.FURNITURE_MOVE, self.onFurnitureMoveHandler, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_HERO_MOVE_START, self.onMoveHeroStar, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_HERO_MOVE_END, self.onMoveHeroEnd, self)

    GameDispatcher:addEventListener(EventName.DORMITORY_SETLIVEBULLETXT, self.setBubbleText, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_UPDATEBULLEPOS, self.updateLiveBubblePos, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_HIDELIVEBULLE, self.hideLiveBubble, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_CAMERAUPDATEPOS, self.updateAllLiveBubblePos, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_CLICKLIVE, self.onClickLive_ShowLiveOption, self)

    GameDispatcher:addEventListener(EventName.DORMITORY_QUTACOUNTUPDATE, self.updateQuotaCount, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FURNITURE, self.onCheckBubbleHandler, self)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.updateAura, self)
    GameDispatcher:addEventListener(EventName.DORMITORT_UPDATAMOVEINTERACTDATA, self.refreshInteractBtnState, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_INTERACT_FINISH, self.addJoyStich, self)

    GameDispatcher:addEventListener(EventName.CLOSE_DORMITORYLIVE_PANEL, self.onCloseLiveInfoPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DORMITORYINFO_PANEL, self.onCloseInfoPanel, self)

    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onCheckBubbleHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    dormitory.DormitoryManager:addEventListener(dormitory.DormitoryManager.EVENT_DORMITORY_INIT, self.updateAura, self)

    self.mGroupInfo:SetActive(true)
    self.mGroupMenu:SetActive(false)
    self.mGroupItem:SetActive(false)

    if self.mDormitoryCamera then
        self.mDormitoryCamera:initCamera()
        self.mDormitoryCamera:onStartTween()

        if not gs.Application.isMobilePlatform then
            LoopManager:addFrame(1, 0, self, self.onFrame)
        end
    end

    self:onAddPointerEvent()
    self:updateAura()
    self:setGuideTrans("guide_Dormitory_Edit", self.mBtnEdit.transform)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.SAVA_DORMITORT_FINISH, self.outEdit, self)
    GameDispatcher:removeEventListener(EventName.START_DRAG_FURNITURE, self.onStartDragHanlder, self)
    GameDispatcher:removeEventListener(EventName.END_DRAG_FURNITURE, self.onEndDragHanlder, self)
    GameDispatcher:removeEventListener(EventName.SELECT_FURNITURE_PUT, self.onSelectFurniturePutHanlder, self)
    GameDispatcher:removeEventListener(EventName.PUT_FURNITURE_RETURN, self.onPutFurnitureReturnHandler, self)
    GameDispatcher:removeEventListener(EventName.FURNITURE_MOVE, self.onFurnitureMoveHandler, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_HERO_MOVE_START, self.onMoveHeroStar, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_HERO_MOVE_END, self.onMoveHeroEnd, self)

    GameDispatcher:removeEventListener(EventName.DORMITORY_SETLIVEBULLETXT, self.setBubbleText, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_UPDATEBULLEPOS, self.updateLiveBubblePos, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_HIDELIVEBULLE, self.hideLiveBubble, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_CAMERAUPDATEPOS, self.updateAllLiveBubblePos, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_CLICKLIVE, self.onClickLive_ShowLiveOption, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_QUTACOUNTUPDATE, self.updateQuotaCount, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FURNITURE, self.onCheckBubbleHandler, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.updateAura, self)
    GameDispatcher:removeEventListener(EventName.DORMITORT_UPDATAMOVEINTERACTDATA, self.refreshInteractBtnState, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_INTERACT_FINISH, self.addJoyStich, self)

    GameDispatcher:removeEventListener(EventName.CLOSE_DORMITORYLIVE_PANEL, self.onCloseLiveInfoPanel, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_DORMITORYINFO_PANEL, self.onCloseInfoPanel, self)

    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onCheckBubbleHandler, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    dormitory.DormitoryManager:removeEventListener(dormitory.DormitoryManager.EVENT_DORMITORY_INIT, self.updateAura, self)

    dormitory.DormitoryManager.hasSelectFurniture = false

    self:onRemovePointerEvent()

    -- self:recoverFurnitureListItem()
    self:recoverHeroListItem()

    self:redLatePageRedPoint()

    dormitory.DormitoryManager:resetMoveInfoList()

    dormitory.DormitoryManager:clearPropsList(true)
    dormitory.DormitoryManager:clearAllFurniture()

    self:removeHideLiveTimer()
    self:removeUpdateBubbleLifeFrame()

    if self.mDormitoryCamera and self.mDormitoryCamera.destroy then
        self.mDormitoryCamera:destroy()
        LoopManager:removeFrame(self, self.onFrame)
    end
    self.mBubbleList = {}

    self:deleteJoyStich()

    if self.mArcScroll then
        self.mArcScroll:deActive()
        self.mArcScroll = nil
    end
end

--更新交互按钮的显示隐藏
function refreshInteractBtnState(self, args)
    local curControllerLiveTid = dormitory.DormitoryManager:getCurControllerLiveTid()
    if not curControllerLiveTid then
        self.mBtnInteract:SetActive(false)
        return
    end
    self.mCurInterData = args.interactData

    self.mBtnInteract:SetActive(args.active)
end

--更新气氛跟心情显示
function updateAura(self)
    local dormitoryData = dormitory.DormitoryManager:getDormitoryData()
    if dormitoryData then
        self.mTextRecovery_2.gameObject:SetActive(dormitoryData.add_hero_stamina_speed > 0)
        self.mTextRecovery_2.text = string.format("+%s", dormitoryData.add_hero_stamina_speed)
    end

    local roomConfigData = buildBase.BuildBaseManager:getBuildBasePosDataByPos(self.m_RoomId)
    if roomConfigData then
        local levelsData = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(roomConfigData.buildType)
        local roomData = buildBase.BuildBaseManager:getBuildBaseData(self.m_RoomId)
        local roomConfigLevelData = levelsData:getLevelDataVo(roomData.lv)

        self.mTextRecovery_1.text = string.format("%s/小时", roomConfigLevelData.stamina)
    end

    local aura = 0
    local maxAura = 0

    local roomConfigData = buildBase.BuildBaseManager:getBuildBasePosDataByPos(self.m_RoomId)
    if roomConfigData then
        local levelsData = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(roomConfigData.buildType)
        local roomData = buildBase.BuildBaseManager:getBuildBaseData(self.m_RoomId)

        local maxAuraList = sysParam.SysParamManager:getValue(SysParamType.DORMITORY_MAXAURA) --最大舒适度
        local initAuraList = sysParam.SysParamManager:getValue(SysParamType.DORMITORY_INITAURA) --初始舒适度
        aura = initAuraList[roomData.lv]
        maxAura = maxAuraList[roomData.lv]
    end

    if dormitory.DormitoryManager.isEditState then
        local furnitureList = dormitory.DormitoryManager:getAllFurniture()
        for subtype, propList in pairs(furnitureList) do
            for k, propVo in pairs(propList) do
                if propVo.useing == 1 then
                    local baseData = dormitory.DormitoryManager:getDormitoryBaseVo(propVo.tid)
                    aura = aura + baseData.aura
                end
            end
        end
    else
        local use_list = dormitory.DormitoryManager:getFurnitureListByDormitory()
        if use_list then
            for i, furnitureVo in ipairs(use_list) do
                local baseData = dormitory.DormitoryManager:getDormitoryBaseVo(furnitureVo.tid)
                aura = aura + baseData.aura
            end
        end
    end

    aura = aura > maxAura and maxAura or aura

    self.mTextBaseAura.text = aura
    self.mTexeEditAura.text = aura
end

--添加摇杆
function addJoyStich(self)
    if not dormitory.DormitoryManager:getCurControllerLiveTid() then
        return
    end

    if (not self.mJoyStick) then
        if gs.Application.isEditor then
            dormitory.DormitoryJoystickView = require("game/dormitory/view/DormitoryJoystickView")
        end
        self.mJoyStick = dormitory.DormitoryJoystickView.new()
        self.mJoyStick:setParentTrans(self.UITrans)
    end
end

--移除摇杆
function deleteJoyStich(self)
    if (self.mJoyStick) then
        self.mJoyStick:destroy()
        self.mJoyStick = nil
    end
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
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
    self:addUIEvent(self.mBtnSave, self.onSave)

    self:addUIEvent(self.mBtnCancel, self.onCancel)
    self:addUIEvent(self.mBtnSure, self.onSure)
    self:addUIEvent(self.mBtnStorage, self.onStorage)
    self:addUIEvent(self.mBtnRotate, self.onRotate)
    self:addUIEvent(self.mBtnReset, self.onResetFurnish)
    self:addUIEvent(self.mBtnAllStorage, self.onAllStorage)
    self:addUIEvent(self.mBtnLiveMove, self.onLiveController)
    self:addUIEvent(self.mBtnLiveInter, self.onLiveInter)
    self:addUIEvent(self.mBtnInfo, self.onOpenInfoPanel)
    self:addUIEvent(self.mBtnSettleInfo, self.onOpenLiveInfoPanel)

    self:addUIEvent(self.mBtnEdit, self.onEdit)
    self:addUIEvent(self.mBtnShop, self.onShop)
    self:addUIEvent(self.mBtnHideUI, self.onHideUI)

    self:addUIEvent(self.mBtnInteract, self.onInteract)

    self:addUIEvent(self.mEditorSuit, self.onEditorSaveSuit)
end

--保存当前家具套装
function onEditorSaveSuit(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_EDITORSAVE_VIEW)
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, {id = LinkCode.Dormitory})
end
--交互
function onInteract(self)
    local curControllerLiveTid = dormitory.DormitoryManager:getCurControllerLiveTid()
    if not curControllerLiveTid then return end

    local liveThing = dormitory.DormitoryAIManager:getLiveTing(curControllerLiveTid)
    if not liveThing then return end

    if self.mCurInterData then
        liveThing:setInteractFurnitruePoint(self.mCurInterData)
        liveThing:startInteract()
        self.mCurInterData = nil

        self:deleteJoyStich()
    else
        if not liveThing:isCanStopInteract() then
            gs.Message.Show(_TT(49718))
        end
        liveThing:stopInteract()
    end
end

--宿舍详情界面
function onOpenInfoPanel(self)
    self.mImgInfoNor:SetActive(false)
    self.mImgInfoSelect:SetActive(true)
    GameDispatcher:dispatchEvent(EventName.OPEN_DORMITORYINFO_PANEL, self.m_RoomId)
end

--关闭宿舍详情界面
function onCloseInfoPanel(self)
    self.mImgInfoNor:SetActive(true)
    self.mImgInfoSelect:SetActive(false)
end

--站员入驻界面
function onOpenLiveInfoPanel(self)
    self.mImgSettleInfoNor:SetActive(false)
    self.mImgSettleInfoSelect:SetActive(true)

    GameDispatcher:dispatchEvent(EventName.OPEN_DORMITORYLIVE_PANEL, self.m_RoomId)
end

--关闭站员入驻界面
function onCloseLiveInfoPanel(self)
    self.mImgSettleInfoNor:SetActive(true)
    self.mImgSettleInfoSelect:SetActive(false)
end

--战员互动
function onLiveInter(self)
    self.mHideLiveTime = 0

    GameDispatcher:dispatchEvent(EventName.DORMITORY_LIVEINTER, self.mCurControllerLiveTid)
end

--控制站员
function onLiveController(self)
    if self.mGroupLiveOption.activeSelf then
        self.mGroupLiveOption:SetActive(false)
    end

    if self.Root_5.activeSelf then
        self.Root_5:SetActive(false)
    end

    --设置当前操作的战员Id
    dormitory.DormitoryManager:setCurControllerLiveTid(self.mCurControllerLiveTid)

    self:hideLiveBubble(self.mCurControllerLiveTid)
    self:addJoyStich()
    self:removeHideLiveTimer()

    GameDispatcher:dispatchEvent(EventName.DORMITORY_CONTROLLERLIVEMOVE)
end

--退出控制战员
function exitLiveController(self)
    if self.Root_5.activeSelf == false then
        self.Root_5:SetActive(true)
    end

    self:deleteJoyStich()
    self:hideLiveOptionGroup()
    self:refreshInteractBtnState()

    GameDispatcher:dispatchEvent(EventName.DORMITORY_EXITCONTROLLERLIVEMOVE)
end

function timeHideLiveOptionGroup(self)
    self.mHideLiveTime = self.mHideLiveTime + 0.5
    if self.mHideLiveTime < 2 then return end

    self:hideLiveOptionGroup()
end

--恢复站员AI 隐藏站员操作按钮
function hideLiveOptionGroup(self)
    self:removeHideLiveTimer()

    if self.mGroupLiveOption.activeSelf then
        self.mGroupLiveOption:SetActive(false)
    end
    dormitory.DormitoryManager:setCurControllerLiveTid(nil)
    self:refreshInteractBtnState()
    self.mCurControllerLiveTid = nil
    self.mHideLiveTime = 0
    GameDispatcher:dispatchEvent(EventName.DORMITORY_GOONLIVEAI)
end

function removeHideLiveTimer(self)
    if self.mHideTimer then
        self:removeTimerByIndex(self.mHideTimer)
        self.mHideTimer = nil
    end
end

--显示站员操控
function onClickLive_ShowLiveOption(self, liveTid)
    if not self.mClientClickTime then
        self.mClientClickTime = GameManager:getClientTime()
    else
        if GameManager:getClientTime() < self.mClientClickTime + 1 then
            return
        else
            self.mClientClickTime = GameManager:getClientTime()
        end
    end

    self.mTextLiveName.text = hero.HeroManager:getHeroConfigVo(liveTid).name

    if self.mGroupLiveOption.activeSelf == false then
        self.mGroupLiveOption:SetActive(true)
    end

    self.mCurControllerLiveTid = liveTid
    self.mHideTimer = self:addTimer(0.5, -1, self.timeHideLiveOptionGroup)
end

--检测红点
function onCheckBubbleHandler(self, args)
    if (args) then
        if (args.type == ReadConst.FURNITURE) then
            self:upateFurnitureListItem()
            self:updateTabRedPointState()
        end
    else
        self:upateFurnitureListItem()
        self:updateTabRedPointState()
    end
end

--设置站员气泡文本
function setBubbleText(self, args)
    local item = self:getLiveBulle(args.liveTid)
    item.setLiveBubble(args.liveTid, args.ai_state)
    item.updatePos(args.modelTran)
    if self.liveBulleFrame == nil then
        self.liveBulleFrame = LoopManager:addFrame(1, 0, self, self.updateAllLiveBulleLife)
    end
end

--更新站员气泡文本位置
function updateLiveBubblePos(self, args)
    local item = self:getLiveBulle(args.liveTid)
    item.updatePos(args.modelTran)
end

--隐藏站员气泡
function hideLiveBubble(self, liveTid)
    local item = self:getLiveBulle(liveTid)
    item.hide()
end

--更新当前所有的站员AI气泡位置
function updateAllLiveBubblePos(self)
    for k, v in pairs(self.mBubbleList) do
        v.updatePos()
    end
end

function removeUpdateBubbleLifeFrame(self)
    LoopManager:removeFrame(self, self.updateAllLiveBulleLife)
    self.liveBulleFrame = nil
end

function updateAllLiveBulleLife(self)
    if table.empty(self.mBubbleList) then
        self:removeUpdateBubbleLifeFrame()
        return
    end
    local isHaveBulleShow = false
    for _, item in pairs(self.mBubbleList) do
        if item.isShow then
            if GameManager:getClientTime() - item.lateShowTime >= sysParam.SysParamManager:getValue(SysParamType.DORMITORY_BUBBLESHOWTIME) then
                item.hide()
            else
                isHaveBulleShow = true
            end
        end
    end

    if not isHaveBulleShow then
        self:removeUpdateBubbleLifeFrame()
    end
end

function getLiveBulle(self, liveTid)
    local item = self.mBubbleList[liveTid]
    if item == nil then
        item = {}
        item.m_go = gs.GameObject.Instantiate(self.mItemBubble)
        item.m_goTran = item.m_go.transform
        item.m_goTran:SetParent(self.mGroupBubble.transform, false)
        item.m_childGos, item.m_childTrans = GoUtil.GetChildHash(item.m_go)

        item.mTextBubble = item.m_childGos["mTextBubble"]:GetComponent(ty.Text)
        item.setLiveBubble = function(_liveTid, _ai_state)
            local bubble_txt = dormitory.DormitoryManager:getLiveBubbleText(_liveTid, _ai_state)
            if bubble_txt == nil then return end
            if item.m_go.activeSelf == false then
                item.m_go:SetActive(true)
            end

            if self.mGroupBubble.activeSelf == false then
                self.mGroupBubble:SetActive(true)
            end

            item.mTextBubble.text = bubble_txt
            item.isShow = true
            item.lateShowTime = GameManager:getClientTime()
        end
        item.updatePos = function(modelTran)
            if modelTran ~= nil then
                item.m_followTans = modelTran
            end
            if item.m_followTans == nil or gs.GoUtil.IsTransNull(item.m_followTans) then return end
            if item.isShow == false then return end

            gs.CameraMgr:World2UIOffsetY(item.m_followTans, self.mGroupBubble.transform, item.m_goTran, 1)
        end

        item.hide = function()
            if item.m_go.activeSelf == true then
                item.m_go:SetActive(false)
                item.m_followTans = nil
            end
            item.isShow = false
        end
        self.mBubbleList[liveTid] = item
    end
    return item
end

function onHideUI(self)
    self.hideUI = not self.hideUI
    self.mGroupHideUI:SetActive(self.hideUI)
    self.mImgShowUI:SetActive(not self.hideUI)
    if self.base_childGos then
        if self.mGroupTop == nil then
            self.mGroupTop = self.base_childGos["mGroupTop"]
        end
        self.mGroupTop:SetActive(self.hideUI)
    end
    self.mImgHideUI:SetActive(self.hideUI)
end

function updateTab(self)
    local list, totalCount = self:getMenuList()
    self.mTxtAllCount.text = totalCount
    if not self.mArcScroll then
        self.mArcScroll = ArcScrollList:new()
        self.mArcScroll:init(self.mScroll1)
        self.mArcScroll:setRenerder(dormitory.DormitoryTabItem)
        self.mArcScroll:SetSelectEvent(function(index)
            local subType = list[index].page
            if self.mSelectSubType == subType then return end
            self:setSubPage(subType)
            self:updateCameraAngle()
        end)

        -- self.mArcScroll:SetDragSelectEvent(function (index)
        --     self:setSubPage(list[index].page)
        -- end)
    end

    self.mArcScroll:setData(list)

    if self.mSelectSubType then
        self:upateFurnitureListItem()
    end
    self:updateAura()
end

function updateCameraAngle(self)
    if self.mSelectSubType == DormitoryCost.FLOOR_SUBTYPE then
        self:cameraToAngle(1)
    elseif self.mSelectSubType == DormitoryCost.WALL_SUBTYPE or self.mSelectSubType == DormitoryCost.MURAL_SUBTYPE then
        self:cameraToAngle(2)
    elseif self.mSelectSubType == DormitoryCost.TOP_SUBTYPE then
        self:cameraToAngle(3)
    else
        self:cameraToAngle(1)
    end
end

function setSubPage(self, page)
    self:redLatePageRedPoint()
    self.mSelectSubType = page
    if self.mSelectSubType then
        self:upateFurnitureListItem(true)
    end
    self:updateQuotaCount()
end

function updateQuotaCount(self)
    if self.mSelectSubType == DormitoryCost.FLOOR_SUBTYPE
        or self.mSelectSubType == DormitoryCost.TOP_SUBTYPE
        or self.mSelectSubType == DormitoryCost.WALL_SUBTYPE then
        self.mGroupQuotalimit:SetActive(false)
        return
    end

    self.quotaCount = dormitory.DormitorySceneController:getFurnitureNum(self.mSelectSubType)
    self.mGroupQuotalimit:SetActive(true)
    local maxCount = sysParam.SysParamManager:getValue(SysParamType.DORMITORY_QUOTA)
    -- local str = string.format("%s/%s", self.quotaCount, maxCount)
    -- if self.quotaCount >= maxCount then
    --     str = string.format("<color=#f12b2bff>%s</color>", self.quotaCount)
    -- end
    self.mTextQuotalimitLabel.text = _TT(49708)
    self.mTextQuotalimit1.text = self.quotaCount
    self.mTextQuotalimit2.text = maxCount

end

function redLatePageRedPoint(self)
    if self.mTabRedPoint and self.mTabRedPoint[self.mSelectSubType] then
        local list = dormitory.DormitoryManager:getPropsList(self.mSelectSubType)
        for k, propsVo in pairs(list) do
            if read.ReadManager:isModuleRead(ReadConst.FURNITURE, propsVo.id) then
                GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = ReadConst.FURNITURE, id = propsVo.id})
            end
        end
    end
end

-- 增加长按事件
function onAddPointerEvent(self)
    local function _onPointerDownHandler()
        if self.mDormitoryCamera then
            self.mDormitoryCamera:onMouseDown(self.mTouchArea.EventData)
        end
        self:__onPointerDownHandler()
    end
    self.mTouchArea.onPointerDown:AddListener(_onPointerDownHandler)

    local function _onPointerUpHandler()
        if self.mDormitoryCamera then
            self.mDormitoryCamera:onMouseUp()
        end
    end
    self.mTouchArea.onPointerUp:AddListener(_onPointerUpHandler)

    local function _onDragHandler()
        if self.mDormitoryCamera then
            self.mDormitoryCamera:onDrag(self.mTouchArea.EventData)
        end
    end
    self.mTouchArea.onDrag:AddListener(_onDragHandler)

    local function _onEndDragHandler()
        if self.mDormitoryCamera then
            self.mDormitoryCamera:onEndDrag(self.mTouchArea.EventData)
        end
    end
    self.mTouchArea.onEndDrag:AddListener(_onEndDragHandler)
end

-- 移除长按事件
function onRemovePointerEvent(self)
    self.mTouchArea.onPointerDown:RemoveAllListeners()
    self.mTouchArea.onPointerUp:RemoveAllListeners()
    self.mTouchArea.onDrag:RemoveAllListeners()
    self.mTouchArea.onEndDrag:RemoveAllListeners()
end

-- 战员提起转圈表现
function onLiveThingBring(self, fillValue, active, tran)
    if fillValue == nil then
        self.mGroupBring:SetActive(false)
        self.mImgBring.fillAmount = 0
        return
    end

    if self.mGroupBring.activeSelf ~= active then
        gs.CameraMgr:World2UIOffsetY(tran, self.mGroupInfo.transform, self.mGroupBring.transform, 1)
        self.mGroupBring:SetActive(active)
    end

    if fillVale ~= 0 then
        self.mImgBring.fillAmount = fillValue
    else
        self.mGroupBring:SetActive(false)
    end
end

-- 背包更新
function onBagUpdateHandler(self)
    -- dormitory.DormitoryManager:clearPropsList()
    -- dormitory.DormitoryManager:clearAllFurniture()
    --暂时不要实时刷新
    -- self:updateTab()
end

-- 开始移动战员
function onMoveHeroStar(self)
    self:onRemovePointerEvent()
end

-- 结束移动战员
function onMoveHeroEnd(self)
    self:onAddPointerEvent()
end

function getMenuList(self)
    local list = {}
    local totalCount = 0
    local menuList = dormitory.DormitoryManager:getFunitureMenuList()
    for i, v in ipairs(menuList) do
        local propsList = dormitory.DormitoryManager:getSubtypeFurniture(v.type)
        local count = table.nums(propsList)
        totalCount = totalCount + count

        table.insert(list, {id = v.id, page = v.type, nomalLanId = v.langId, nomalLanEn = count, sort = v.sort, nomalIcon = string.format("arts/ui/pack/dormitory/%s.png", v.icon)})
    end

    -- 插入套装页签
    local count = dormitory.DormitoryManager:getAllSuitCount()
    table.insert(list, {id = 0, page = 999, nomalLanId = 49722, nomalLanEn = count, sort = 0, nomalIcon = "arts/ui/pack/dormitory/item_furniture_tz.png"})

    table.sort(list, function(a, b)
        return a.sort < b.sort
    end)
    return list, totalCount
end

-- 重置装修
function onResetFurnish(self)
    dormitory.DormitoryManager:resetMoveInfoList()
    dormitory.DormitoryManager:clearTileTipList()
    dormitory.DormitoryManager:clearPropsList(true)
    dormitory.DormitoryManager:clearAllFurniture()
    self:onBagUpdateHandler()

    GameDispatcher:dispatchEvent(EventName.REQ_DORMITORY_INFO)
end

-- 全部收纳
function onAllStorage(self)
    DormitoryCost.all_Storage()

    self:updateTab()
end

-- 编辑模式
function onEdit(self)
    dormitory.DormitoryManager.isEditState = true
    self.mGroupItem:SetActive(true)
    self.mGroupInfo:SetActive(false)
    GameDispatcher:dispatchEvent(EventName.ENTER_DORMITORY_EDIT)
    self:updateTab()
    self:updateTabRedPointState()
    self:updateAura()
end

-- 跳转商店
function onShop(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.ShopDormitory})
end

function onPutFurnitureReturnHandler(self, args)
    if args.result == 1 then
        self:outMenuState()
        self:updateTab()
    else
        gs.Message.Show(_TT(49711))
    end
end

function onStartDragHanlder(self)
    self.mDormitoryCamera:setCameraDragState(false)

    self.isMoveFurniture = true
    -- self.mTouchArea.gameObject:SetActive(false)
end
function onEndDragHanlder(self)
    self.mDormitoryCamera:setCameraDragState(true)

    self.isMoveFurniture = false
    -- self.mTouchArea.gameObject:SetActive(true)
end
function onSelectFurniturePutHanlder(self, args)
    self.mFurniturePos = args.pos

    self.base_childGos["mGroupTop"]:SetActive(false)
    self.mGroupItem:SetActive(false)
    self.mGroupMenu:SetActive(true)

    self:updateMenuPos()
end

-- 家具移动
function onFurnitureMoveHandler(self, args)
    self.mFurniturePos = args.pos
    self:updateMenuPos()
end

function onSave(self)
    if #dormitory.DormitoryManager:getMoveInfoList() > 0 then
        dormitory.DormitoryManager:clearAllFurniture()
        GameDispatcher:dispatchEvent(EventName.SVAE_DORMITORY_CHANGE)
    else
        self:outEdit()
        gs.Message.Show2(_TT(49712))
    end
end

-- 取消
function onCancel(self)
    self:outMenuState()
    GameDispatcher:dispatchEvent(EventName.SELECT_FURNITURE_CANCEL)
    self:updateTab()
end

-- 确定
function onSure(self)
    -- dormitory.DormitoryManager:clearAllFurniture()
    GameDispatcher:dispatchEvent(EventName.PUT_FURNITURE_SURE)
end

function onStorage(self)
    self:outMenuState()
    dormitory.DormitoryManager:clearAllFurniture()
    GameDispatcher:dispatchEvent(EventName.STORAGE_FURNITURE)
    self:updateTab()
end

function onRotate(self)
    GameDispatcher:dispatchEvent(EventName.TURN_FURNITURE)
end

function outEdit(self)
    dormitory.DormitoryManager.isEditState = false
    dormitory.DormitoryManager:clearTileTipList()
    dormitory.DormitoryManager:clearAllFurniture()
    self.mGroupItem:SetActive(false)
    self.mGroupInfo:SetActive(true)
    GameDispatcher:dispatchEvent(EventName.QUIT_DORMITORY_EDIT)
end

-- 退出菜单模式
function outMenuState(self)
    --延迟两帧，确保可以隐藏
    LoopManager:setFrameout(2, self, function()
        self.base_childGos["mGroupTop"]:SetActive(true)
        self.mGroupItem:SetActive(true)
        self.mGroupMenu:SetActive(false)
        dormitory.DormitoryManager.hasSelectFurniture = false
    end)
end

function __onPointerDownHandler(self)
    if self.isMoveFurniture then return end

    if gs.Application.isMobilePlatform then
        LoopManager:addFrame(1, 0, self, self.onFrame)
    end
end

function updateMenuPos(self)
    if dormitory.DormitoryManager.hasSelectFurniture then
        gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetToScreenSceneCamera(), gs.CameraMgr:GetUICamera(), self.mFurniturePos, self.mGroupMenu.transform, self.mFurnitureMenu)
    end
end

function cameraToAngle(self, _index)
    self.mDormitoryCamera:moveToAngle(_index)
end

function onFrame(self)
    if self.mDormitoryCamera:onCameraSlowMove() then
        LoopManager:removeFrame(self, self.onFrame)
    end
    self:updateMenuPos()
end

-- 更新家具菜单列表
function upateFurnitureListItem(self, refrePos)
    if self.mSelectSubType then
        local data = {}
        if self.mSelectSubType == 999 then --套装
            local list = dormitory.DormitoryManager:getSuitDic()
            for k, v in pairs(list) do
                table.insert(data, v)
            end

            table.sort(data, function(a, b)
                return a.id < b.id
            end)

        else
            local list = dormitory.DormitoryManager:getSubtypeFurniture(self.mSelectSubType)
            for id, propInfo in pairs(list) do
                table.insert(data, propInfo)
            end

            table.sort(data, function(a, b)
                -- if a.useing and b.useing then
                --     if a.useing == b.useing then
                --         return a.tid < b.tid
                --     else
                --         return a.useing > b.useing
                --     end
                -- elseif not a.useing and not b.useing then
                --     return a.tid < b.tid
                -- else
                --     if not a.useing then
                --         return false
                --     elseif not b.useing then
                --         return true
                --     end
                -- end

                return a.tid < b.tid
            end)
        end

        -- if (self.mScroll2LyScroll.Count <= 0) then
        if refrePos or self.mScroll2LyScroll.Count <= 0 then
            self.mScroll2LyScroll.DataProvider = data
        else
            self.mScroll2LyScroll:ReplaceAllDataProvider(data)
        end
    end
end

-- 回收战员格子项
function recoverHeroListItem(self)
    if self.mHeroItemList then
        for i, v in pairs(self.mHeroItemList) do
            v:poolRecover()
        end
    end
    self.mHeroItemList = {}
end

--更新红点状态
function updateTabRedPointState(self)
    if not self.mArcScroll then return end
    if not self.mTabRedPoint then
        self.mTabRedPoint = {}
    end
    local list, totalCount = self:getMenuList()
    for k, v in pairs(list) do
        if dormitory.DormitoryManager:getFurnitureSubTypeRedPointState(v.page) then
            self.mTabRedPoint[v.page] = true
            self.mArcScroll:UpdateRedState(k, true)
        else
            self.mTabRedPoint[v.page] = nil
            self.mArcScroll:UpdateRedState(k, false)
        end
    end
end

-- 关闭所有UI
function closeAll(self)
    if #dormitory.DormitoryManager:getMoveInfoList() > 0 then
        UIFactory:alertMessge(_TT(49710), true, function()
            dormitory.DormitoryManager.isEditState = false
            super.closeAll(self)
            GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
        end, _TT(1), nil, true, nil, _TT(2))
    else
        if dormitory.DormitoryManager.isEditState then
            self:outEdit()
            self:onResetFurnish()
        elseif dormitory.DormitoryManager:getCurControllerLiveTid() then
            self:exitLiveController()
        end
        super.closeAll(self)
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    end
end

-- 点击关闭
function onClickClose(self)
    if #dormitory.DormitoryManager:getMoveInfoList() > 0 then
        UIFactory:alertMessge(_TT(49710), true, function()
            if dormitory.DormitoryManager.isEditState then
                self:outEdit()
                self:onResetFurnish()
            end

        end, _TT(1), nil, true, nil, _TT(2))
    else
        if dormitory.DormitoryManager.isEditState then
            self:outEdit()
            self:onResetFurnish()
        elseif dormitory.DormitoryManager:getCurControllerLiveTid() then
            self:exitLiveController()
        else
            super.onClickClose(self)
            GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.BUILDBASE)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
