module("buildBase.BuildBaseMainPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBaseMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0
isShowMoneyBar = 1
isShowBlackBg = 0 -- 是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52018))
    self:setUICode(LinkCode.Covenant)
    self:setBg("", false)
end

function dtor(self)

end

function initData(self)
    self.mPosLevelDataDic = {}
    self.selectPos = 0
    self.canSelectPos = 0

    self.isEditor = false

    self.ONE_KEY_CD_TIME = 5
    self.currCdTime = 0
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnAll = self:getChildGO("mBtnAll")
    self.mBtnWork = self:getChildGO("mBtnWork")
    self.mBtnEditor = self:getChildGO("mBtnEditor")
    self.mBtnAllPre = self:getChildGO("mBtnAllPre")
    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    self.mBindParent = self:getChildTrans("mBindParent")
    self.mCustomBindBtn = self:getChildGO("mCustomBindBtn")
    self.mBtnEditorImg = self.mBtnEditor:GetComponent(ty.AutoRefImage)
    self.mTxtEditor = self:getChildGO("mTxtEditor"):GetComponent(ty.Text)
    self.mClickTouch = self:getChildGO("mClickTouch"):GetComponent(ty.LongPressOrClickEventTrigger)
    local function _onPointerUpHandler()
        CustomCamera:setEnable(false)
    end
    self.mClickTouch.onPointerUp:AddListener(_onPointerUpHandler)

    local function _onPointerDownHandler()
        CustomCamera:setEnable(true)
    end
    self.mClickTouch.onPointerDown:AddListener(_onPointerDownHandler)

    local function _onScrollHandler()
        CustomCamera:setOnScroll()
    end
    self.mClickTouch.onScroll:AddListener(_onScrollHandler)

    self.mMaskImg = self:getChildGO("mMaskImg")
    self:setGuideTrans("funcTips_guide_mainUIBtn_editor", self.mBtnEditor.transform)
    self:setGuideTrans("funcTips_guide_buildBase_1", self:getChildTrans("mBtnAllPreGroup"))
    self:setGuideTrans("funcTips_guide_buildBase_2", self:getChildTrans("mBtnEditorGroup"))
    self:setGuideTrans("funcTips_guide_buildBase_3", self:getChildTrans("mGuide_money_1"))
    self:setGuideTrans("funcTips_guide_buildBase_4", self:getChildTrans("mGuide_money_2"))
    self:setGuideTrans("funcTips_guide_buildBase_5", self:getChildTrans("mGuide_money_3"))
    self:setGuideTrans("funcTips_guide_buildBase_6", self:getChildTrans("mBtnAll"))
end

-- 激活
function active(self)
    super.active(self)
    -- self.isEditor = false
    self.selectPos = 0
    self.mMaskImg:SetActive(false)
    MoneyManager:setMoneyTidList({ MoneyTid.UAV_TID, MoneyTid.POWER_TID, MoneyTid.TITANITE_TID })
    buildBase.BuildBaseManager:addEventListener(buildBase.BuildBaseManager.SHOW_POWER_TIPS, self.onOpenPowerTips, self)
    GameDispatcher:addEventListener(EventName.UPDATE_BUILDBASE_PANEL_LEVEL_UP, self.onBuildBaseLevelUpHandler, self)

    GameDispatcher:addEventListener(EventName.ONLY_UPDATE_BUILDBASE_PANEL, self.onOnlyUpdateHandler, self)
    CustomCamera:setClickEvent(function()
        self:clickEvent(self)
    end)

    CustomCamera:setLoopEndEvent(nil, function()
        self:updateUI(self)
    end)

    CustomCamera:setTweenLoopEvent(function()
        self:updateUI(self)
    end)

    self:createRoomData()
    self:bindRoomUI()
    self:updateUI()
    self:updateEditorUI()
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.bindRoomUI, self)
    -- bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.bindRoomUI, self)

    self.mCamAni = gs.GameObject.Find("RotateTrans"):GetComponent(ty.Animator)

    local centerLv = buildBase.BuildBaseManager:getShipLv(buildBase.BuildBaseType.ControllerCenter)
    local limitLv = sysParam.SysParamManager:getValue(SysParamType.OPEN_ONE_KEY_WORK) --开放一键入驻等级
    self.mBtnWork:SetActive(centerLv >= limitLv)
    self.currCdTime = 0
end

-- 设置货币栏
function setMoneyBar(self)
    super.setMoneyBar(self)
    for i = 1, #self.m_moneyBar.m_itemList do
        self:setGuideTrans("funcTips_guide_mainUIBtn_money_" .. 1, self.m_moneyBar.m_itemList[i]:getAdaptaTrans())
    end
end

-- 点击事件
function clickEvent(self)
    local hitObj = CustomCamera:raycastObject("Building", 500)
    if hitObj then
        local s, e = string.find(hitObj.name, "_")
        local num = string.sub(hitObj.name, s + 1)
        local clickNum = tonumber(num)
        self:onClickPos(clickNum)
    end
end

-- 点击了某一个建筑地基 位置id
function onClickPos(self, pos)
    print("打开了建筑位置==========" .. pos)

    if self.isEditor then
        self.selectPos = pos
        GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_LEVELUP, {
            pos = pos
        })
    else
        if self.mPosLevelDataDic[pos].level > 0 then
            -- 有资源的情况下都先收资源
            local buildType = self.mPosLevelDataDic[pos].data.buildType
            if (buildType == buildBase.BuildBaseType.Laboratory or buildType == buildBase.BuildBaseType.Smelters or
            buildType == buildBase.BuildBaseType.Factory) and
            buildBase.BuildBaseManager:getBuildBaseData(pos).produce > 0 then
                self:onClickGetHandler(pos)
                -- GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_AWARD, {
                --     id = pos
                -- })
                return

            end

            GameDispatcher:dispatchEvent(EventName.ENTER_BUILDBASE_ROOMSCENE, {
                id = pos
            })
        end
    end
    self:updateEditorUI()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:clearEff()
    MoneyManager:setMoneyTidList()
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
    GameDispatcher:removeEventListener(EventName.UPDATE_BUILDBASE_PANEL_LEVEL_UP, self.onBuildBaseLevelUpHandler, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.bindRoomUI, self)
    GameDispatcher:removeEventListener(EventName.ONLY_UPDATE_BUILDBASE_PANEL, self.onOnlyUpdateHandler, self)
    buildBase.BuildBaseManager:removeEventListener(buildBase.BuildBaseManager.SHOW_POWER_TIPS, self.onOpenPowerTips,
    self)
    -- bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.bindRoomUI, self)
    if self.timeoutSn then
        self:clearTimeout(self.timeoutSn)
    end

    if self.aniSn then
        LoopManager:removeFrameByIndex(self.aniSn)
        self.aniSn = nil
    end
end

-- 创建房间
function createRoomData(self)

    self:claerPosLevelData()
    -- 位置数据
    local buildBasePosData = buildBase.BuildBaseManager:getBuildBasePosData()

    for k, v in pairs(buildBasePosData) do
        -- 大于1级就表示已经有建筑了
        local buildInfo = buildBase.BuildBaseManager:getBuildBaseData(v.id)
        local lv = buildInfo == nil and 0 or buildInfo.lv
        local obj, floorTrans, create, select = self:createSingleRoom(k, v, lv)
        -- 统一存一份备用
        self.mPosLevelDataDic[k] = {
            data = v,
            level = lv,
            obj = obj,
            isActive = lv > 0,
            uiObj = nil,
            floorTrans = floorTrans,
            create = create,
            select = select
        }

        for i = 1, 5 do
            self.mPosLevelDataDic[k].obj.transform:Find("lv" .. i).gameObject:SetActive(i == lv)
        end

        self.mPosLevelDataDic[k].obj:SetActive(lv > 0)
    end
end

-- 创建单个房间 位置id 对应数据 当前等级
function createSingleRoom(self, pos, data, level)
    local posTrans = gs.GameObject.Find("Environment/block/floor_" .. pos).transform

    local create = posTrans:Find("createTips").gameObject
    local select = posTrans:Find("selectTips").gameObject
    create:SetActive(false)
    select:SetActive(false)
    local roomObj = gs.GameObject.Find("Environment/createObj/buildbase_" .. data.buildType)
    local insObj = gs.GameObject.Instantiate(roomObj, posTrans)
    gs.TransQuick:LPos(insObj.transform, gs.VEC3_ZERO)
    gs.TransQuick:Scale0(insObj.transform, 1)
    return insObj, posTrans, create, select
end

-- 更新房间数据
function updateRoomData(self)
    -- 位置数据
    local buildBasePosData = buildBase.BuildBaseManager:getBuildBasePosData()

    for k, v in pairs(buildBasePosData) do
        local buildInfo = buildBase.BuildBaseManager:getBuildBaseData(v.id)
        local lv = buildInfo == nil and 0 or buildInfo.lv
        self.mPosLevelDataDic[k] = {
            data = v,
            level = lv,
            obj = self.mPosLevelDataDic[k].obj,
            uiObj = self.mPosLevelDataDic[k].uiObj,
            isActive = lv > 0,
            floorTrans = self.mPosLevelDataDic[k].floorTrans,
            create = self.mPosLevelDataDic[k].create,
            select = self.mPosLevelDataDic[k].select
        }
        self.mPosLevelDataDic[k].obj:SetActive(lv > 0)

        for i = 1, 5 do
            self.mPosLevelDataDic[k].obj.transform:Find("lv" .. i).gameObject:SetActive(i == lv)
        end
    end
end

-- 绑定对应UI
function bindRoomUI(self)

    for pos, datas in pairs(self.mPosLevelDataDic) do
        -- 新手引导需要拿这个来做节点
        -- if datas.isActive then
        if datas.uiObj then
            datas.uiObj:poolRecover()
            datas.uiObj = nil
        end
        local hasGet = false
        local hasNotice = false
        local item = SimpleInsItem:create(self.mCustomBindBtn, self.mBindParent, "BuildBaseMainPanelbindUI")
        local buildType = datas.data.buildType
        item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(76008)
        item:getChildGO("mTxtLvValue"):GetComponent(ty.Text).text = datas.level
        item:getChildGO("mTxtFunc"):GetComponent(ty.Text).text = buildBase.BuildBaseTypeName[buildType]
        self:setGuideTrans("funcTips_guide_mainUIBtn_build_point_" .. pos, item:getChildTrans("mGuide_point1"))
        self:setGuideTrans("funcTips_guide_mainUIBtn_nobuild_point_" .. pos, item:getChildTrans("mGuide_point2"))
        item:getChildGO("mGuide_point1"):SetActive(self.isEditor)
        item:getChildGO("mGuide_point2"):SetActive(not self.isEditor)

        if datas.isActive then
            -- 存在可领取的状态
            if buildType == buildBase.BuildBaseType.Laboratory or buildType == buildBase.BuildBaseType.Smelters or
            buildType == buildBase.BuildBaseType.Factory then
                if (buildBase.BuildBaseManager:getBuildBaseData(pos).produce ~= 0) then
                    local image = item:getChildGO("mGetValue"):GetComponent(ty.Image)

                    item:getChildGO("mImgEff"):SetActive(buildBase.BuildBaseManager:getBuildBaseData(pos).produce ==
                    buildBase.BuildBaseManager:getBuildBaseData(pos).maxNum)

                    image.fillAmount = buildBase.BuildBaseManager:getBuildBaseData(pos).produce /
                    buildBase.BuildBaseManager:getBuildBaseData(pos).maxNum
                    image.color = buildBase.BuildBaseManager:getBuildBaseData(pos).produce ==
                    buildBase.BuildBaseManager:getBuildBaseData(pos).maxNum and
                    gs.ColorUtil.GetColor("FFB644ff") or gs.ColorUtil.GetColor("29F074ff")
                    item:getChildGO("mGetBtn"):SetActive(true)
                    hasGet = true
                else
                    hasGet = false
                end
                -- self:addUIEvent(item:getChildGO("mGetBtn"), self.onClickGetHandler, nil, pos)
            else
                hasGet = false
            end
        end

        self:addUIEvent(item:getChildGO("mGuide_point1"), function()
            self:onClickPos(pos)
        end)
        self:addUIEvent(item:getChildGO("mGuide_point2"), function()
            self:onClickPos(pos)
        end)

        self:addUIEvent(item:getChildGO("mGetBtn"), self.onClickGetHandler, nil, pos)
        if buildType ~= buildBase.BuildBaseType.Dormitory then
            local hasZero = buildBase.BuildBaseManager:getSumStaminaHasZeroByBuildId(datas.data.id)
            hasNotice = hasZero
        end

        -- if buildType == buildBase.BuildBaseType.Laboratory or buildType == buildBase.BuildBaseType.Smelters then
        --     local heroLength = buildBase.BuildBaseManager:getSumStaminaHeroNum(datas.data.id)
        --     hasNotice = heroLength == 0 or hasNotice
        -- end

        if buildType == buildBase.BuildBaseType.DispatchRoom then
            local red = buildBase.DispatchDockManager:updateRedPoint()
            -- RedPointManager
            if red then
                RedPointManager:add(item:getChildTrans("mBg"), nil, 75, 13.5)
            else
                RedPointManager:remove(item:getChildTrans("mBg"))
            end
        end

        if hasGet == true then
            item:getChildGO("mGetBtn"):SetActive(true)
            item:getChildGO("mImgNotice"):SetActive(false)
        else
            item:getChildGO("mGetBtn"):SetActive(false)
            if hasNotice then
                item:getChildGO("mImgNotice"):SetActive(true)
            else
                item:getChildGO("mImgNotice"):SetActive(false)
            end
        end

        datas.uiObj = item
        datas.uiObj:getChildGO("mGroup"):SetActive(datas.isActive)
        -- end
    end

    self.mEndTime = buildBase.BuildBaseManager:getPlantTime()
end

-- 点击了领取
function onClickGetHandler(self, pos)
    self.mPosLevelDataDic[pos].uiObj:getChildGO("boxEffect"):SetActive(true)

    self.timeoutSn = self:setTimeout(0.65, function()
        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_AWARD, {
            id = pos
        })
        self.mPosLevelDataDic[pos].uiObj:getChildGO("boxEffect"):SetActive(false)
    end)
    --
    --
end

-- 刷新绑定的UI位置
function updateUI(self)
    for pos, datas in pairs(self.mPosLevelDataDic) do
        if datas.uiObj then

            local canUpdate = buildBase.BuildBaseManager:canBuildBaseLvUpdate(pos)

            local pos = gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetToScreenSceneCamera(), gs.CameraMgr:GetUICamera(),
            datas.obj.transform.position, self.mBindParent, nil)
            gs.TransQuick:SizeDelta01(datas.uiObj:getChildGO("mBg"):GetComponent(ty.RectTransform),
            (self.isEditor and canUpdate) and 170 or 150)
            datas.uiObj:getChildGO("mAdd"):SetActive(self.isEditor and canUpdate)

            -- gs.TransQuick:SizeDelta01(datas.uiObj:getChildGO("mBg"):getComponent(ty.RectTransform), 150)

            gs.TransQuick:UIPos(datas.uiObj.m_trans, pos.x - 9, pos.y + (self.isEditor and -100 or 100))

        end
    end

    if buildBase.BuildBaseManager:checkAllBuildingsHeroStamina() then
        RedPointManager:add(self.mBtnAllPre.transform, nil, 76, 13.4)
    else
        RedPointManager:remove(self.mBtnAllPre.transform)
    end
end

function clearEff(self)
    gs.GOPoolMgr:CancelAsyc(self.effectSn)
    if self.effectGo then
        if (not gs.GoUtil.IsGoNull(self.effectGo)) then
            gs.GOPoolMgr:Recover(self.effectGo,
            UrlManager:getUIEfxPath(string.format("%s.prefab", "fx_buildbase_levelup")))
        end
    end
    self.effectGo = nil
end

function onOnlyUpdateHandler(self)
    self.selectPos = 0

    self:updateRoomData()
    self:bindRoomUI()
    self:updateUI()

    self:updateEditorUI()
end
-- 有升级建筑完成
function onBuildBaseLevelUpHandler(self)
    local lastLvUpId = buildBase.BuildBaseManager:getLvUpPosId(self.openPos)
    if lastLvUpId then
        local trans = self.mPosLevelDataDic[lastLvUpId].floorTrans
        self:clearEff()

        local function addEff()
            local function _loadAysnCall(effectGo)
                self.effectGo = effectGo
                gs.TransQuick:SetParentOrg(effectGo.transform, trans)
            end
            self.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIEfxPath(string.format("%s.prefab",
            "fx_buildbase_levelup")), _loadAysnCall)
        end

        local function removeEff()
            self:clearEff()
        end

        LoopManager:setTimeout(0, nil, addEff)
        LoopManager:setTimeout(3, nil, removeEff)
    end
    buildBase.BuildBaseManager:setLvUpPosId(nil)
    self:onOnlyUpdateHandler()
end

-- 关闭所有UI
function onCloseAllCall(self)
    super.onCloseAllCall(self)

    self:playerClose(false)
end

function closeAll(self)
    super.closeAll(self)

    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
end

-- 玩家点击关闭
function onClickClose(self)
    if self.isEditor then
        self:onBtnEditorClick()
    else
        super.onClickClose(self)
        self:playerClose(true)

        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    end
end

function playerClose(self)
    -- cusLog("2333333")
    self:claerPosLevelData()
    -- for k, v in pairs(self.mPosLevelDataDic) do
    --     if v.uiObj then
    --         v.uiObj:poolRecover()
    --         v.uiObj = nil
    --     end

    --     if v.obj then
    --         gs.GameObject.Destroy(v.obj)
    --         v.obj = nil
    --     end
    -- end
end

function claerPosLevelData(self)
    for k, v in pairs(self.mPosLevelDataDic) do
        if v.uiObj then
            v.uiObj:poolRecover()
            v.uiObj = nil
        end

        if v.obj then
            gs.GameObject.Destroy(v.obj)
            v.obj = nil
        end
    end
    self.mPosLevelDataDic = {}
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnWork, 76209, "一键入驻")
end


-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAllPre, self.onBtnAllPreClick)
    self:addUIEvent(self.mBtnEditor, self.onBtnEditorClick)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
    self:addUIEvent(self.m_childGos["mBtnHideTipsPower"], function()
        self.m_childGos["mTipsPower"]:SetActive(false)
    end)
    self:addUIEvent(self.mBtnAll, self.onBtnAllClick)
    self:addUIEvent(self.mBtnWork, self.onKeyWork)
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.Covenant })
end

function onBtnAllClick(self)
    local hasGet = false

    if buildBase.BuildBaseManager:getAllProduceNum() > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_ALL_AWARD)
    else
        gs.Message.Show("无可领取的奖励")
    end

end

-- 战员进驻总览
function onBtnAllPreClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_OVERVIEW)
end

function updateEditorUI(self)
    local hasGet = buildBase.BuildBaseManager:getAllProduceNum() > 0

    self.mBtnAll:SetActive(not self.isEditor and hasGet)

    self.mBtnEditorImg:SetImg(self.isEditor and UrlManager:getPackPath("buildBase/buildbase_enterbg2.png") or
    UrlManager:getPackPath("buildBase/buildbase_enterbg1.png"), false)

    -- 编辑模式下
    if self.isEditor then
        self.mTxtEditor.text = _TT(76009)
        for pos, datas in pairs(self.mPosLevelDataDic) do
            local canUpdate = buildBase.BuildBaseManager:canBuildBaseCreate(pos)
            if datas.uiObj then
                datas.uiObj:getChildGO("mSelectImg"):GetComponent(ty.Image).color = pos == self.selectPos and
                gs.ColorUtil
                .GetColor("ffb644ff") or
                gs.ColorUtil
                .GetColor("0056ffff")

                datas.uiObj:getChildGO("mTxtLv"):GetComponent(ty.Text).color = pos == self.selectPos and
                gs.ColorUtil.GetColor("000000ff") or
                gs.ColorUtil.GetColor("ffffffff")
                datas.uiObj:getChildGO("mTxtLvValue"):GetComponent(ty.Text).color = pos == self.selectPos and
                gs.ColorUtil
                .GetColor("000000ff") or
                gs.ColorUtil
                .GetColor("ffffffff")
                datas.uiObj:getChildGO("mDefInfo"):SetActive(false)

                -- if datas.level > 0 then
                --     datas.uiObj:getChildGO("mCanLvUp"):SetActive(canUpdate and self.isEditor)
                -- end
            end
            datas.create:SetActive(canUpdate and datas.level == 0)
            datas.select:SetActive(pos == self.selectPos)
        end

    else
        self.mTxtEditor.text = _TT(76010)
        for pos, datas in pairs(self.mPosLevelDataDic) do
            if datas.uiObj then
                datas.uiObj:getChildGO("mSelectImg"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("0056ffff")
                datas.uiObj:getChildGO("mTxtLv"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("ffffffff")
                datas.uiObj:getChildGO("mTxtLvValue"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("ffffffff")

                datas.uiObj:getChildGO("mDefInfo"):SetActive(true)
                datas.uiObj:getChildGO("mCanLvUp"):SetActive(false)
            end
            datas.create:SetActive(false)
            datas.select:SetActive(false)
        end
    end
end

-- 编辑模式
function onBtnEditorClick(self)
    self.isEditor = not self.isEditor
    self.selectPos = 0

    self.mBindParent.gameObject:SetActive(false)
    self:updateEditorUI()

    self.mBtnAllPre:SetActive(not self.isEditor)
    self.mBtnFuncTips:SetActive(not self.isEditor)
    local aniStr
    if self.isEditor then

        aniStr = "camera_up"
    else
        aniStr = "camera_down"
    end
    self.mCamAni:Play(aniStr)
    self.aniTime = AnimatorUtil.getAnimatorClipTime(self.mCamAni, aniStr) + 0.2
    self.curTime = 0

    if self.aniSn then
        LoopManager:removeFrameByIndex(self.aniSn)
        self.aniSn = nil
    end
    self.mMaskImg:SetActive(true)
    self.aniSn = LoopManager:addFrame(0, 0, self, self.playAni)

    for pos, datas in pairs(self.mPosLevelDataDic) do
        if datas.uiObj then
            datas.uiObj:getChildGO("mGuide_point1"):SetActive(self.isEditor)
            datas.uiObj:getChildGO("mGuide_point2"):SetActive(not self.isEditor)
        end
    end
end

function playAni(self)
    self.curTime = self.curTime + gs.Time.deltaTime
    if self.curTime < self.aniTime then
        self:updateUI()
    else

        self:updateUI()
        self.mBindParent.gameObject:SetActive(true)
        self.mMaskImg:SetActive(false)
        LoopManager:removeFrameByIndex(self.aniSn)
        self.aniSn = nil
    end
end

function onOpenPowerTips(self)
    self.m_childGos["mTipsPower"]:SetActive(true)
    if self.mDesPower == nil then
        self.mDesPower = self.m_childGos["mDesPower"]:GetComponent(ty.Text)
    end
    self.mDesPower.text = _TT(76187)
    if self.mTitlePower == nil then
        self.mTitlePower = self.m_childGos["mTitlePower"]:GetComponent(ty.Text)
    end
    self.mTitlePower.text = _TT(76186)
end

-- 一键排班
function onKeyWork(self)
    if self.currCdTime > 0 and os.time() - self.currCdTime < self.ONE_KEY_CD_TIME then
        gs.Message.Show(string.format("%s秒后再试", self.ONE_KEY_CD_TIME - (os.time() - self.currCdTime)))
        return
    end
    self.currCdTime = os.time()
    local tempWorkList = {}
    local workSendList = {}
    buildBase.BuildBaseHeroManager:clearAllSettleHero()
    local staminaMax = sysParam.SysParamManager:getValue(5001)
    local dataList = buildBase.BuildBaseManager:getAllBuildBaseDataList()
    for k, baseVo in pairs(dataList) do
        local list = {}
        local tempList = {}
        local buildId = baseVo.id
        local buildType = buildBase.BuildBaseManager:getBuildType(buildId)
        if buildType ~= buildBase.BuildBaseType.Dormitory then

            buildBase.BuildBaseHeroManager:setSortBuildType(buildType)
            local heroList = showBoard.ShowBoardManager:getHeroScrollList()
            table.sort(heroList, buildBase.BuildBaseHeroManager.sortRelateSkillFunc)
            -- heroList = buildBase.BuildBaseHeroManager:getSorHeroScrollList(heroList)
            for _, heroSelectVo in ipairs(heroList) do
                if table.indexof(tempWorkList, heroSelectVo:getDataVo().tid) == false then

                    local buildBaseHeroMsgVo = buildBase.BuildBaseHeroManager:getBuildHeroInfo(heroSelectVo:getDataVo().tid)
                    for _, warshipSkillVo in pairs(buildBaseHeroMsgVo.skillList) do
                        local orderVo = buildBase.BuildBaseManager:getFacInfo(buildId)
                        local orderType = (orderVo and orderVo.orderType > 0) and orderVo.orderType or nil
                        local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(warshipSkillVo.skill_id)
                        if skillVo.produceType == orderType and buildBaseHeroMsgVo.stamina > 0 then
                            table.insert(tempList, heroSelectVo)
                            break
                        end
                        if skillVo.produceType ~= orderType and buildBaseHeroMsgVo.stamina > 0 then
                            table.insert(list, heroSelectVo)
                            break
                        end
                    end
                end
            end

            if not table.empty(tempList) then
                for i = #tempList, 1 do
                    table.insert(list, 1, tempList[i])
                end
            end

            local curLvBuildVo = buildBase.BuildBaseManager:getCurLvBuildConfigd(buildId)
            local upLimit = curLvBuildVo.num

            local sendList = {}
            local len = math.min(upLimit, #list)
            for i = 1, len do
                table.insert(sendList, { hero_tid = list[i]:getDataVo().tid, pos = i })
                table.insert(tempWorkList, list[i]:getDataVo().tid)
            end

            table.insert(workSendList, { build_id = buildId, hero_list = sendList })
            -- GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_HEROLIST, { build_id = buildId, hero_list = sendList })
        end
    end

    -- 宿舍最后跑一遍
    for k, baseVo in pairs(dataList) do
        local list = {}
        local buildId = baseVo.id
        local buildType = buildBase.BuildBaseManager:getBuildType(buildId)
        local heroList = showBoard.ShowBoardManager:getHeroScrollList(nil, showBoard.panelSortType.STAMINA, false)

        if buildType == buildBase.BuildBaseType.Dormitory then
            for _, heroSelectVo in ipairs(heroList) do
                if table.indexof(tempWorkList, heroSelectVo:getDataVo().tid) == false then
                    table.insert(list, heroSelectVo)
                end
            end

            local curLvBuildVo = buildBase.BuildBaseManager:getCurLvBuildConfigd(buildId)
            local upLimit = curLvBuildVo.num

            local sendList = {}
            local len = math.min(upLimit, #list)
            for i = 1, len do
                table.insert(sendList, { hero_tid = list[i]:getDataVo().tid, pos = i })
                table.insert(tempWorkList, list[i]:getDataVo().tid)
            end
            table.insert(workSendList, { build_id = buildId, hero_list = sendList })
            -- GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_HEROLIST, { build_id = buildId, hero_list = sendList })
        end
    end
    buildBase.BuildBaseHeroManager:onOneKeyWorkSend(workSendList)
    -- gs.Message.Show("一键入驻完成")
    gs.Message.Show(_TT(76210))
end

return _M