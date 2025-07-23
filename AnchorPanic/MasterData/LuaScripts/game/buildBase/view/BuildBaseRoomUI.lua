--[[ 
-----------------------------------------------------
@filename       : BuildBaseRoomUI
@Description    : 小房间UI
@date           : 2021-07-21 17:26:02
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('buildBase.BuildBaseRoomUI', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBaseRoomUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")

    self:setGuideTrans("guide_BtnClose_BuildBaseRoomUI", self.gBtnClose.transform)
end
-- 析构  
function dtor(self)
    super.dtor(self)
end

function initData(self)
    super.initData(self)

    if gs.Application.isEditor then
        buildBase.BuildBaseRoomCamera = require("game/buildBase/manager/BuildBaseRoomCamera")
    end
    self.mCamera = buildBase.BuildBaseRoomCamera.new()

    self.mInfraFlag = false
    self.mHeroSelectFlag = false
    self.mSetUIHideDirty = false
    self.mMenuItem = {}
    -- 建筑对应等级的配置表数据
    self.mbuidlCofigHelper = {}
    self.mLinkCode = LinkCode.Covenant
    self.sn = nil
end

-- 初始化
function configUI(self)
    self.mTouchArea = self:getChildGO("mTouchArea"):GetComponent(ty.LongPressOrClickEventTrigger)

    self.mBtnHdie = self:getChildGO("mBtnHdie")
    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    self.mBtnShowInfras = self:getChildGO("mBtnShowInfras")
    self.mTxtBtn1 = self:getChildGO("mTxtShowInfras")
    self.mBtnShowOccupants = self:getChildGO("mBtnShowOccupants")
    self.mImgRoomIcon = self:getChildGO("mImgRoomIcon"):GetComponent(ty.Image)
    self.mTxtRoomName = self:getChildGO("mTxtRoomName"):GetComponent(ty.Text)
    self.mTxtRoomLevel = self:getChildGO("mTxtRoomLevel"):GetComponent(ty.Text)
    ----------------------------控制中心面板-----------------------------
    self.mControllerCenterSet = self:getChildGO("mControllerCenterSet")
    self.mImgChargeIcon = self:getChildGO("mImgChargeIcon"):GetComponent(ty.AutoRefImage)
    ----------------------------发电站面板-------------------------------
    self.mPowerPlantSet = self:getChildGO("mPowerPlantSet")
    self.mPowerPlantSet:SetActive(false)
    self.mTxtPowerProviedNum = self:getChildGO("mTxtPowerProviedNum"):GetComponent(ty.Text)
    self.mTxtChargeSpeedDNum = self:getChildGO("mTxtChargeSpeedDNum"):GetComponent(ty.Text)
    ----------------------------加工厂面板-------------------------------
    self.mProduceGroup = self:getChildGO("mProduceGroup")
    self.mProduceGroup:SetActive(false)
    self.mBtnAdd = self:getChildGO("mBtnAdd")
    self.mBtnImg = self.mBtnAdd:GetComponent(ty.AutoRefImage)
    self.mTxtAdd = self:getChildGO("mTxtAdd")
    self.mProduceDetailGroup = self:getChildGO("mProduceDetailGroup")
    self.mTxtProduceName = self:getChildGO("mTxtProduceName"):GetComponent(ty.Text)
    self.mTxtProduceRestTime = self:getChildGO("mTxtProduceRestTime"):GetComponent(ty.Text)
    self.mTxtProduceState = self:getChildGO("mTxtProduceState"):GetComponent(ty.Text)
    self.mTxtProduceContain = self:getChildGO("mTxtProduceContain"):GetComponent(ty.Text)
    self.mBtnSpUp = self:getChildGO("mBtnSpUp"):GetComponent(ty.Button)
    self.mImgState = self:getChildGO("mImgState"):GetComponent(ty.Image)
    self.mImgPropIcon = self:getChildGO("mImgPropIcon"):GetComponent(ty.AutoRefImage)
    self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)
    ----------------------------派遣坞-------------------------------
    self.mDispatchInfo = self:getChildGO("mDispatchInfo")
    self.mDispatchInfo:SetActive(false)
    self.mTxtAvailableTimes = self:getChildGO("mTxtAvailableTimes"):GetComponent(ty.Text)
    self.mTxtNextTime = self:getChildGO("mTxtNextTime"):GetComponent(ty.Text)
    self.mTxtDispatchedTeam = self:getChildGO("mTxtDispatchedTeam"):GetComponent(ty.Text)
    self.mBtnShowDispatch = self:getChildGO("mBtnShowDispatch")

    self.mBtnRec = self:getChildGO("mBtnRec")

    self:setGuideTrans("funcTips_guide_BuildBase_Produce", self:getChildTrans("mGuideProduce"))
    self:setGuideTrans("funcTips_guide_BuildBase_ShowOccupants", self.mBtnShowOccupants.transform)
    self:setGuideTrans("funcTips_guide_BuildBase_BtnSpUp", self.mBtnSpUp.transform)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- 设置文本标题
function setTxtTitle(self, title)
    super.setTxtTitle(self, title)
    self:setGuideTrans("funcTips_guide_buildBase_roomUIBtnClose", self.gBtnClose.transform)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnHdie, self.onClickHideUI)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
    self:addUIEvent(self.mBtnShowInfras, self.onClickInfraInfoShow)
    self:addUIEvent(self.mBtnShowOccupants, self.onClickOccupantsInfoShow)
    ----------------------------加工厂--------------------------------
    self:addUIEvent(self.mBtnAdd, self.onClickProduceListHandler)
    self:addUIEvent(self.mBtnSpUp, self.onOpenSpdHandler)
    self:addUIEvent(self.mBtnShowDispatch, self.onClicDispatchDockHandler)
    self:addUIEvent(self.mBtnRec, self.onClickRecProduce)
end

-- 激活
function active(self, args)
    super.active(self, args)

    if self.mCamera then
        self.mCamera:initCamera()
        if not self.isReshow then
            self.mCamera:onStartTween()
        end

        if not gs.Application.isMobilePlatform then
            LoopManager:addFrame(1, 0, self, self.onFrame)
        end
    end
    self:onAddCameraPointerEvent()

    MoneyManager:setMoneyTidList({ MoneyTid.UAV_TID, MoneyTid.POWER_TID, MoneyTid.TITANITE_TID })
    self.mRoomPosConfig = buildBase.BuildBaseManager:getBuildBasePosDataByPos(args.id)
    --订阅BuildInfo更新
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.updateData, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DORMITORYINFO_PANEL, self.onCloseInfraShow, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DORMITORYLIVE_PANEL, self.onCloseHeroShow, self)
    GameDispatcher:addEventListener(EventName.BUILDBASE_REFLASH_FAC, self.updateFacInfo, self)
    GameDispatcher:addEventListener(EventName.UPDATE_BUILDBASE_VIEW, self.updateFacInfo, self)
    buildBase.BuildBaseManager:setNowBuildId(self.mRoomPosConfig.id)
    self:updateData()
end

-- 销毁
function deActive(self)
    super.deActive(self)

    if self.mCamera and self.mCamera.destroy then
        self.mCamera:destroy()
        LoopManager:removeFrame(self, self.onFrame)
    end

    self:onRemoveCameraPointerEvent()

    --取消订阅BuildInfo更新
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.updateData, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_DORMITORYINFO_PANEL, self.onCloseInfraShow, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_DORMITORYLIVE_PANEL, self.onCloseHeroShow, self)
    GameDispatcher:removeEventListener(EventName.BUILDBASE_REFLASH_FAC, self.updateFacInfo, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BUILDBASE_VIEW, self.updateFacInfo, self)
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
    LoopManager:removeTimer(self, self.onUpdateDispatchTimerInfo)
    MoneyManager:setMoneyTidList()
    LoopManager:removeTimer(self, self.updateDispatchInfo)
    self:clearTimer()
end

--更新Info和Config数据
function updateData(self)
    self.mBuildBaseInfo = buildBase.BuildBaseManager:getBuildBaseData(self.mRoomPosConfig.id)
    self.mRoomConfig = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(self.mRoomPosConfig.buildType)
    self.mBuildHeroInfo = self.mBuildBaseInfo.heroList
    self:initCofig()
    self:onOpenUI()
end

-- 建筑对应等级的配置表数据
function initCofig(self)
    for k, v in pairs(self.mRoomConfig.datas.build_level) do
        if (v.level == self.mBuildBaseInfo.lv) then
            self.mbuidlCofigHelper = v
            break
        end
    end
end

function updateFacInfo(self)
    if (self.mRoomPosConfig.buildType == buildBase.BuildBaseType.Factory) then
        self:updateProduceInfo()
    end
end

function onOpenUI(self)
    self:setTxtTitle(_TT(self.mRoomPosConfig.name))
    self.mTxtRoomName.text = _TT(self.mRoomPosConfig.name)
    self.mTxtRoomLevel.text = self.mBuildBaseInfo.lv
    local type = self.mRoomPosConfig.buildType
    if type == buildBase.BuildBaseType.ControllerCenter then
        self:updateControlCenter()
    elseif type == buildBase.BuildBaseType.Laboratory then
        self:updateProduceInfo()
    elseif type == buildBase.BuildBaseType.Smelters then
        self:updateProduceInfo()
    elseif type == buildBase.BuildBaseType.PowerStation then
        self:updatePowerStation()
    elseif type == buildBase.BuildBaseType.Dormitory then

    elseif type == buildBase.BuildBaseType.Factory then
        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_FAC_INFO, {
            id = self.mBuildBaseInfo.id
        })
        self:updateProduceInfo()
    elseif type == buildBase.BuildBaseType.DispatchRoom then
        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_DISPATCHDOCK_INFO, { buildId = self.mBuildBaseInfo.id })
        LoopManager:addTimer(0.2, 1, self, self.updateDispatchInfo)
    end
    self:setGuideTransByType(type)
    if self.mRoomIsEmpty or buildBase.BuildBaseManager:getSumStaminaHasZeroByBuildId(self.mBuildBaseInfo.id) then
        RedPointManager:add(self.mBtnShowOccupants.transform, nil, -93, 24)
    else
        RedPointManager:remove(self.mBtnShowOccupants.transform)
    end
end

-- checkUIisDirty
function onClickHideUI(self)
    self.mSetUIHideDirty = not self.mSetUIHideDirty
    self:checkUIIsDirty()
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = self.mLinkCode })
end

function setGuideTransByType(self, type)
    if type == buildBase.BuildBaseType.ControllerCenter then-- 控制中心
        self:setGuideTrans("funcTips_guide_controllerCenter_1", self.mBtnShowOccupants.transform)
        self.mLinkCode = LinkCode.BuildBaseControllerCenter
    elseif type == buildBase.BuildBaseType.Laboratory then-- 实验室
        self:setGuideTrans("funcTips_guide_laboratory_1", self:getChildTrans("mGuideProduce"))
        self:setGuideTrans("funcTips_guide_laboratory_2", self.mBtnShowOccupants.transform)
        self.mLinkCode = LinkCode.BuildBaseLaboratory
    elseif type == buildBase.BuildBaseType.Smelters then-- 冶炼厂
        self:setGuideTrans("funcTips_guide_smelters_1", self:getChildTrans("mGuideProduce"))
        self:setGuideTrans("funcTips_guide_smelters_2", self.mBtnShowOccupants.transform)
        self.mLinkCode = LinkCode.BuildBaseSmelters
    elseif type == buildBase.BuildBaseType.PowerStation then-- 动力模块
        self:setGuideTrans("funcTips_guide_powerStation_1", self:getChildTrans("mPowerProvied"))
        self:setGuideTrans("funcTips_guide_powerStation_2", self:getChildTrans("mDetailChargeSpeed"))
        self:setGuideTrans("funcTips_guide_powerStation_3", self.mBtnShowOccupants.transform)
        self.mLinkCode = LinkCode.BuildBasePowerStation
    elseif type == buildBase.BuildBaseType.Factory then-- 加工厂
        self:setGuideTrans("funcTips_guide_factory_1", self:getChildTrans("mGuideProduce"))
        self:setGuideTrans("funcTips_guide_factory_2", self.mBtnShowOccupants.transform)
        self.mLinkCode = LinkCode.BuildBaseFactor
    elseif type == buildBase.BuildBaseType.DispatchRoom then-- 派遣室
        self:setGuideTrans("funcTips_guide_dispatchRoom_1", self:getChildTrans("mDispatchInfo"))
        self:setGuideTrans("funcTips_guide_dispatchRoom_2", self.mBtnShowOccupants.transform)
        self.mLinkCode = LinkCode.BuildBaseDispatchRoom
    end
end

function checkUIIsDirty(self)
    if self.base_childGos then
        if self.mGroupTop == nil then
            self.mGroupTop = self.base_childGos["mGroupTop"]
        end
    end
    if not self.mGroupSet then self.mGroupSet = self:getChildGO("mGroupSet") end
    if not self.mImgHideUI then self.mImgHideUI = self:getChildGO("mImgHideUI") end
    if not self.mImgShowUI then self.mImgShowUI = self:getChildGO("mImgShowUI") end
    if (self.mSetUIHideDirty) then
        self.mGroupSet:SetActive(false)
        self.mGroupTop:SetActive(false)
        self.mImgShowUI:SetActive(true)
        self.mImgHideUI:SetActive(false)
        self.mBtnFuncTips:SetActive(false)
    else
        self.mGroupSet:SetActive(true)
        self.mGroupTop:SetActive(true)
        self.mImgHideUI:SetActive(true)
        self.mImgShowUI:SetActive(false)
        self.mBtnFuncTips:SetActive(true)
    end
end

function onClickRecProduce(self)
    -- if (buildBase.BuildBaseManager:getBuildBaseData(self.mRoomPosConfig.id).produce ~= 0) then
    GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_AWARD, {
        id = self.mRoomPosConfig.id
    })
    -- end
end

function onClickProduceListHandler(self)
    if (self.mRoomPosConfig.buildType == buildBase.BuildBaseType.Factory) then
        if self.mBuildBaseInfo.produce > 0 or self.mBuildBaseInfo.itemTid ~= 0 then
            self.orderVo = buildBase.BuildBaseManager:getFacInfo(self.mRoomPosConfig.id)
            buildBase.BuildBaseManager:setOrderType(self.orderVo.orderType)
            local mFacVo = buildBase.BuildBaseManager:getFacItemsConfigData(self.orderVo.orderType):getItemVo(self.orderVo.orderId)
            GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_PRODUCE_INFO_PANEL, { produceVo = mFacVo })
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_FAC_PANEL)
        end
    elseif buildType == buildBase.BuildBaseType.Laboratory or buildType == buildBase.BuildBaseType.Smelters or
    buildType == buildBase.BuildBaseType.Factory then
        self:onClickRecProduce()
    end
end

-- 打开设备信息界面
function onClickInfraInfoShow(self)
    if not self.mImgShowInfo then
        self.mImgShowInfo = self.mBtnShowInfras:GetComponent(ty.AutoRefImage)
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_INFO)
    self.mImgShowInfo:SetImg(UrlManager:getPackPath("dormitory/buildbase_enterbg3.png"), false)
end

function onCloseInfraShow(self)
    self.mImgShowInfo:SetImg(UrlManager:getPackPath("dormitory/dormitory_btn_02.png"), false)
end
-- 打开入住人员信息
function onClickOccupantsInfoShow(self)
    if not self.mImgShowHero then
        self.mImgShowHero = self.mBtnShowOccupants:GetComponent(ty.AutoRefImage)
    end
    -- self.mImgShowHero:SetImg(UrlManager:getPackPath("dormitory/dormitory_btn_02.png"),false)
    GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_HEROSELECT)
    self.mImgShowHero:SetImg(UrlManager:getPackPath("dormitory/buildbase_enterbg3.png"), false)
end

function onCloseHeroShow(self)
    self.mImgShowHero:SetImg(UrlManager:getPackPath("dormitory/dormitory_btn_02.png"), false)
end

-- 点击关闭
function onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_SCENE, self.mBuildBaseInfo)
end

----------------------------发电站-------------------------------
-- 打开发电站
function updatePowerStation(self)
    self.mPowerPlantSet:SetActive(true)
    self.mTxtPowerProviedNum.text = self.mbuidlCofigHelper.need_power
    local mNumHelper = buildBase.BuildBaseManager:getBuildSkillInfo(self.mBuildBaseInfo.id)
    self.mOut = mNumHelper / 100
    if not self.mPlantRate then
        self.mPlantRate = 3600 / sysParam.SysParamManager:getValue(SysParamType.BUILD_BASE_PRODUCE)[2]
    end

    self.mTxtChargeSpeedDNum.text = string.format("%s/小时", math.floor(self.mPlantRate))
    if not self.mTextExtraSpeed then
        self.mTextExtraSpeed = self:getChildGO("mTextExtraSpeed"):GetComponent(ty.Text)
    end
    if self.mOut > 0 then
        self.mTextExtraSpeed.gameObject:SetActive(true)
        self.mTextExtraSpeed.text = string.format("+%d", self.mOut) .. "%"
    else
        self.mTextExtraSpeed.gameObject:SetActive(false)
    end
end

----------------------------控制中心-------------------------------
-- 打开控制中心
function updateControlCenter(self)
    self.mControllerCenterSet:SetActive(true)
    -- self.mBtnClikcZone:SetActive(true)
end
----------------------------生产详情-------------------------------
function updateProduceInfo(self)
    self.mProduceGroup:SetActive(true)

    local lvVo = self.mRoomConfig:getLevelDataVo(self.mBuildBaseInfo.lv)
    local singleStore = 1

    local buildType = self.mRoomPosConfig.buildType
    self.mTxtProduceContain.text = self.mBuildBaseInfo.produce .. "/" .. self.mBuildBaseInfo.maxNum --lvVo.toplimit
    self.mImgProgress.fillAmount = self.mBuildBaseInfo.produce / self.mBuildBaseInfo.maxNum --lvVo.toplimit
    if (buildType == buildBase.BuildBaseType.Factory) then
        self.orderVo = buildBase.BuildBaseManager:getFacInfo(self.mRoomPosConfig.id)
        if self.orderVo.orderType > 0 and self.orderVo.orderId > 0 then
            local produceConfig = buildBase.BuildBaseManager:getFacItemsConfigData(self.orderVo.orderType):getItemVo(self.orderVo.orderId)
            singleStore = produceConfig.store
        end
        self.mTxtProduceRestTime.text = "--:--:--"
        self.mTxtProduceState.text = "待加工"
        self.mImgState.color = gs.ColorUtil.GetColor("404548ff")

        local mFacMsg = buildBase.BuildBaseManager:getFacInfo(self.mRoomPosConfig.id)
        if ((self.mBuildBaseInfo.itemTid ~= 0 or self.mBuildBaseInfo.produce > 0) and mFacMsg.orderType ~= 0) then
            self.mTxtAdd:SetActive(false)
            local prop = buildBase.BuildBaseManager:getFacItemsConfigData(mFacMsg.orderType):getItemVo(mFacMsg.orderId).propProps
            local propsVo = props.PropsManager:getPropsVo2(prop)
            self:updateProduceDetailView(propsVo)
        else
            self.mTxtAdd:SetActive(true)
            self.mProduceDetailGroup:SetActive(false)
        end
        self.mTxtProduceContain.text = self.mBuildBaseInfo.produce .. "/" .. lvVo.toplimit
        self.mImgProgress.fillAmount = self.mBuildBaseInfo.produce / lvVo.toplimit
    elseif (buildType ~= buildBase.BuildBaseType.PowerStation) then
        self.mRoomIsEmpty = buildBase.BuildBaseManager:checkIsEmpty(self.mBuildBaseInfo.id)

        if (#lvVo.item >= 1) then
            local propsVo = props.PropsManager:getPropsVo2(lvVo.item)
            self.mTxtAdd:SetActive(false)
            self:updateProduceDetailView(propsVo)
        end
    else
        self.mProduceGroup:SetActive(false)
    end

    if buildType == buildBase.BuildBaseType.Laboratory or buildType == buildBase.BuildBaseType.Smelters or
    buildType == buildBase.BuildBaseType.Factory then
        self.mBtnRec:SetActive(buildBase.BuildBaseManager:getBuildBaseData(self.mRoomPosConfig.id).produce ~= 0)
    else
        self.mBtnRec:SetActive(false)
    end
end

function updateProduceDetailView(self, propsVo)
    self:clearTimer()
    local msgVo = self.mBuildBaseInfo
    local lvVo = self.mRoomConfig:getLevelDataVo(self.mBuildBaseInfo.lv)
    self.mProduceDetailGroup:SetActive(true)
    self.mImgPropIcon:SetImg(UrlManager:getIconPath(propsVo.icon), true)
    self.mTxtProduceName.text = propsVo.name
    local endTime = msgVo.fullTime - GameManager:getServerTime() - 1
    if (endTime > 0) then
        local function Timer()
            self.mTxtProduceRestTime.text = TimeUtil.getHMSByTime(endTime)
            if (endTime == 0) then
                self:clearTimer()
                return
            end
            endTime = endTime - 1
        end
        Timer()
        self.sn = LoopManager:addTimer(1, 0, self, Timer)
        self.mTxtProduceState.text = "加工中"
        self.mImgState.color = gs.ColorUtil.GetColor("0056ffff")
    else
        self.mTxtProduceRestTime.text = "--:--:--"
        self.mTxtProduceState.text = "待加工"
        self.mImgState.color = gs.ColorUtil.GetColor("404548ff")
    end
end

function clearTimer(self)
    if (self.sn) then
        LoopManager:removeTimerByIndex(self.sn)
    end
    self.sn = nil
end

function closeAll(self)
    super.closeAll(self)

    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
end
function onOpenSpdHandler(self)
    local msgHelper = buildBase.BuildBaseManager:getBuildBaseData(self.mRoomPosConfig.id)
    if msgHelper.startTime > 0 then
        TipsFactory:uavTips({ buildBaseMsg = msgHelper })
    else
        gs.Message.Show("当前无生产物品")
    end
end

------派遣坞-----
function updateDispatchInfo(self)
    self.mDispatchInfo:SetActive(true)
    if not self.mImgBarDiffuse then
        self.mImgBarDiffuse = self:getChildGO("mImgBarDiffuse"):GetComponent(ty.AutoRefImage)
    end
    if not self.mImgFuncState then
        self.mImgFuncState = self:getChildGO("mImgFuncState"):GetComponent(ty.AutoRefImage)
    end
    if not self.mImgBgState then
        self.mImgBgState = self:getChildGO("mImgBgState"):GetComponent(ty.Image)
    end
    if not self.mTxtBgState then
        self.mTxtBgState = self:getChildGO("mTxtBgState"):GetComponent(ty.Text)
    end
    local AllTimes = sysParam.SysParamManager:getValue(SysParamType.MAXDISPATCHTIMES)
    AllTimes = AllTimes[self.mBuildBaseInfo.lv]
    local mStrHelper = {
        "<color=#fa3a2b>",
        self.mBuildBaseInfo.produce,

        "</color>",
        "/",
        buildBase.DispatchDockManager:getDispatchedLen(),
    }
    self.mTxtAvailableTimes.text = table.concat(mStrHelper)
    mStrHelper = {
        "<color=#18ec68>",
        buildBase.DispatchDockManager:getDispatchedTeam(),
        "</color>",
        "/",
        AllTimes
    }

    self.mTxtDispatchedTeam.text = table.concat(mStrHelper)
    if self.mBuildBaseInfo.produce > 0 then
        self.mTxtBgState.text = "待派遣"
        self.mImgBgState.color = gs.ColorUtil.GetColor("404548ff")
        self.mImgFuncState:SetImg(UrlManager:getPackPath("buildBaseRoom/buildBaseRoom_Icon_7.png"), true)
        self.mImgBarDiffuse:SetImg(UrlManager:getPackPath("buildBaseRoom/buildBaseRoom_Square_2.png"), true)
    else
        self.mTxtBgState.text = "派遣中"
        self.mImgBgState.color = gs.ColorUtil.GetColor("0056ffff")
        self.mImgFuncState:SetImg(UrlManager:getPackPath("buildBaseRoom/buildBaseRoom_Icon_6.png"), true)
        self.mImgBarDiffuse:SetImg(UrlManager:getPackPath("buildBaseRoom/buildBaseRoom_Square_1.png"), true)
    end
    -- local dispatchedTimes = buildBase.DispatchDockManager:getDisPatchTimes()

    self.mEndTime = self.mBuildBaseInfo.time
    if self.mEndTime > 0 then
        self:onUpdateDispatchTimerInfo()
        LoopManager:removeTimer(self, self.onUpdateDispatchTimerInfo)
        LoopManager:addTimer(1, 0, self, self.onUpdateDispatchTimerInfo)
    else
        LoopManager:removeTimer(self, self.onUpdateDispatchTimerInfo)
        self.mTxtNextTime.text = "00:00:00"
    end
end

function onUpdateDispatchTimerInfo(self)
    self.remainTime = self.mEndTime - GameManager:getClientTime()
    if (self.remainTime < 0) then
    else
        self.mTxtNextTime.text = TimeUtil.getHMSByTime(self.remainTime)
    end
end

function onClicDispatchDockHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DISPATCH_DOCK)
end

-------------------------------------镜头相关----------------------
-- 增加长按事件
function onAddCameraPointerEvent(self)
    local function _onPointerDownHandler()
        if self.mCamera then
            self.mCamera:onMouseDown(self.mTouchArea.EventData)
        end
        self:__onPointerDownHandler()
    end
    self.mTouchArea.onPointerDown:AddListener(_onPointerDownHandler)

    local function _onPointerUpHandler()
        if self.mCamera then
            self.mCamera:onMouseUp()
        end
    end
    self.mTouchArea.onPointerUp:AddListener(_onPointerUpHandler)

    local function _onDragHandler()
        if self.mCamera then
            self.mCamera:onDrag(self.mTouchArea.EventData)
        end
    end
    self.mTouchArea.onDrag:AddListener(_onDragHandler)

    local function _onEndDragHandler()
        if self.mCamera then
            self.mCamera:onEndDrag(self.mTouchArea.EventData)
        end
    end
    self.mTouchArea.onEndDrag:AddListener(_onEndDragHandler)
end

-- 移除长按事件
function onRemoveCameraPointerEvent(self)
    self.mTouchArea.onPointerDown:RemoveAllListeners()
    self.mTouchArea.onPointerUp:RemoveAllListeners()
    self.mTouchArea.onDrag:RemoveAllListeners()
    self.mTouchArea.onEndDrag:RemoveAllListeners()
end

function __onPointerDownHandler(self)
    if gs.Application.isMobilePlatform then
        LoopManager:addFrame(1, 0, self, self.onFrame)
    end
end

function onFrame(self)
    if self.mCamera:onCameraSlowMove() then
        LoopManager:removeFrame(self, self.onFrame)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]