module("hero.HeroIssueShowPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroIssueShowPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
destroyTime = -1 -- 自动销毁时间-1默认
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isShowCloseAll = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("")
    self:setBg("", false)
    self:setUICode(LinkCode.Hero)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mIssueType = nil
    self.IssueTypeEnum = {}
    self.IssueTypeEnum.Hero = 1
    self.IssueTypeEnum.MainExplore = 2
    self.mFashionIndex = 1

    -- 英雄培养模块
    self.mCurHeroTid = nil
    self.mAngle = nil
    self.mRotateSpeed = 1
    self.mScaleRatio = 1
    self.mPos = math.Vector3(0, 0, 0)
    self.mPosOffset = math.Vector3(0, 0, 0)
    self.mRotateDir = 0
    self.mIsRotate = false
    self.mRoleLayer = "Ground"
    self.mActionShowType = MainCityConst.ROLE_MODE_MAIN
    self.mShowBgUrl = nil
    self.mShowBgUrlList = { UrlManager:getIconPath("issue/issue_show_blue.png"), UrlManager:getIconPath("issue/issue_show_green.png") }
    self.mShowNodeType = nil
    self.mShowNodeTypeList = { MainCityConst.ROLE_MODE_MAIN, MainCityConst.ROLE_MODE_OVERVIEW, MainCityConst.ROLE_MODE_UI }

    -- 锚点模块
    self.mIsShowUiEvent = true
end

function configUI(self)
    super.configUI(self)

    -- 录制
    self.mBtnRecord = self:getChildGO("mBtnForRecord")
    self.mBtnEnabelClear = self:getChildGO("mBtnEnabelClear")
    self.mBtnEnableHero = self:getChildGO("mBtnEnableHero")
    self.mBtnEnableMainExplore = self:getChildGO("mBtnEnableMainExplore")

    self.mHeroGroupBtn = self:getChildGO("mHeroGroupBtn")
    -- 改变节点
    self.mBtnChangeNode = self:getChildGO("mBtnChangeNode")
    -- 改变背景
    self.mBtnChangeBg = self:getChildGO("mBtnChangeBg")
    -- 改变皮肤
    self.mBtnFashion = self:getChildGO("mBtnFashion")
    -- 播放动作
    self.mBtnPlayAction = self:getChildGO("mBtnPlayAction")
    -- 改变武器
    self.mBtnPlayActionWithWeapon = self:getChildGO("mBtnPlayActionWithWeapon")
    -- 改变阴影
    self.mBtnShadow = self:getChildGO("mBtnShadow")

    -- 宿舍
    self.mBtnDormitory = self:getChildGO("mBtnDormitory")

    -- 旋转
    self.mRotateSpeedInput = self:getChildGO("mRotateSpeedInput"):GetComponent(ty.InputField)
    self:setInputChangeFun(self.mRotateSpeedInput, self.onSpeedChangedHandler)

    self.mBtnRotateLeft = self:getChildGO("mBtnRotateLeft")
    self.mBtnRotateState = self:getChildGO("mBtnRotateState")
    self.mBtnRotateRight = self:getChildGO("mBtnRotateRight")

    -- 缩放
    self.mScaleInput = self:getChildGO("mScaleInput"):GetComponent(ty.InputField)
    self:setInputChangeFun(self.mScaleInput, self.onScaleChangedHandler)

    -- 坐标偏移
    self.mPosOffsetX = self:getChildGO("mPosOffsetX"):GetComponent(ty.InputField)
    self:setInputChangeFun(self.mPosOffsetX,
    function(self, content)
        self.mPosOffset.x = tonumber(content) or 0
        self:onOffsetChangedHandler(self.mPosOffset)
    end)
    self.mPosOffsetY = self:getChildGO("mPosOffsetY"):GetComponent(ty.InputField)
    self:setInputChangeFun(self.mPosOffsetY,
    function(self, content)
        self.mPosOffset.y = tonumber(content) or 0
        self:onOffsetChangedHandler(self.mPosOffset)
    end)
    self.mPosOffsetZ = self:getChildGO("mPosOffsetZ"):GetComponent(ty.InputField)
    self:setInputChangeFun(self.mPosOffsetZ,
    function(self, content)
        self.mPosOffset.z = tonumber(content) or 0
        self:onOffsetChangedHandler(self.mPosOffset)
    end)

    self.mGroupContent = self:getChildGO("mGroupContent")
    self.mContent = self:getChildTrans("Content")
    self.mIssueHeadItem = self:getChildGO("mHeroHeadItem")

    -- 锚点空间
    self.mMainExploreGroupBtn = self:getChildGO("mMainExploreGroupBtn")
    self.mBtnMainExploreUI = self:getChildGO("mBtnMainExploreUI")
    self.mBtnMainExplorePlayer = self:getChildGO("mBtnMainExplorePlayer")

    self.mBtnClose = self:getChildGO("mBtnClose")
end

function setInputChangeFun(self, inputField, inputChangeFun)
    local function inputChange(content)
        inputChangeFun(self, content)
    end
    inputField.onEndEdit:AddListener(inputChange)
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

-- 玩家点击关闭
function onClickClose(self)
    self:__playerClose()
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:__playerClose()
    super.onCloseAllCall(self)
end

function __playerClose(self)
    self:initData()
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()

    GameView.scene.gameObject:SetActive(false)
    GameView.msg.gameObject:SetActive(false)
    GameView.gm.gameObject:SetActive(false)
    GameView.touchEffect.gameObject:SetActive(false)

    self.gBtnClose:SetActive(false)
    self.gBtnCloseAll:SetActive(false)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()

    GameView.scene.gameObject:SetActive(true)
    GameView.msg.gameObject:SetActive(true)
    GameView.gm.gameObject:SetActive(true)
    GameView.touchEffect.gameObject:SetActive(true)
end

function setAble(self, issueType)
    self:setUnAble(self.mIssueType)
    self.mIssueType = issueType
    if (issueType == self.IssueTypeEnum.Hero) then
        self.mHeroGroupBtn:SetActive(true)
        self:setDecorateNodeVisible(false)
        if (not self.mFrameSn) then
            self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onFrameHandler)
        end
        self.mRotateSpeedInput.text = self.mRotateSpeed
        self.mScaleInput.text = self.mScaleRatio
        self.mPosOffsetX.text = self.mPosOffset.x
        self.mPosOffsetY.text = self.mPosOffset.y
        self.mPosOffsetZ.text = self.mPosOffset.z

        self:updateHeroList()
        self:updateModelView()
        self:updateBtnRotateState()
    elseif (issueType == self.IssueTypeEnum.MainExplore) then
        self.mMainExploreGroupBtn:SetActive(true)
    end
end

function setUnAble(self, issueType)
    if (issueType == self.IssueTypeEnum.Hero) then
        self.mHeroGroupBtn:SetActive(false)
        self:setDecorateNodeVisible(true)
        if (self.mFrameSn) then
            LoopManager:removeFrameByIndex(self.mFrameSn)
            self.mFrameSn = nil
        end
        self:recoveryHeroItemList()
        self:recoverModel(true)
    elseif (issueType == self.IssueTypeEnum.MainExplore) then
        self.mMainExploreGroupBtn:SetActive(false)
    end
end

function initViewText(self)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRecord, self.onClickRecordHandler)
    self:addUIEvent(self.mBtnEnabelClear, self.onClickEnableClearHandler)
    self:addUIEvent(self.mBtnEnableHero, self.onClickEnableHeroHandler)
    self:addUIEvent(self.mBtnEnableMainExplore, self.onClickEnableMainExploreHandler)

    self:addUIEvent(self.mBtnChangeNode, self.onClickChangeNodeHandler)
    self:addUIEvent(self.mBtnChangeBg, self.onClickChangeBgHandler)
    self:addUIEvent(self.mBtnPlayAction, self.onClickPlayerActionHandler)
    self:addUIEvent(self.mBtnPlayActionWithWeapon, self.onClickPlayActionWithWeaponHandler)
    self:addUIEvent(self.mBtnShadow, self.onClickShadowHandler)
    self:addUIEvent(self.mBtnDormitory, self.onClickDormitoryHandler)
    self:addUIEvent(self.mBtnRotateLeft, self.onClickRotateLeftHandler)
    self:addUIEvent(self.mBtnRotateState, self.onClickRotateStateHandler)
    self:addUIEvent(self.mBtnRotateRight, self.onClickRotateRightHandler)

    self:addUIEvent(self.mBtnMainExploreUI, self.onClickMainExploreUIHandler)
    self:addUIEvent(self.mBtnMainExplorePlayer, self.onClickMainExplorePlayerHandler)
    self:addUIEvent(self.mBtnFashion, self.onClickChangeFashionHander)

    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

function getShowBgUrl(self, isChange)
    if (not self.mShowBgUrl) then
        self.mShowBgUrl = self.mShowBgUrlList[1]
        return self.mShowBgUrl
    else
        if (isChange) then
            local searchIndex = 1
            for i = 1, #self.mShowBgUrlList do
                if (self.mShowBgUrl == self.mShowBgUrlList[i]) then
                    searchIndex = i
                end
            end
            searchIndex = searchIndex >= #self.mShowBgUrlList and 1 or searchIndex + 1
            self.mShowBgUrl = self.mShowBgUrlList[searchIndex]
        end
        return self.mShowBgUrl
    end
end

function getShowNodeType(self, isChange)
    if (not self.mShowNodeType) then
        self.mShowNodeType = self.mShowNodeTypeList[1]
        return self.mShowNodeType
    else
        if (isChange) then
            local searchIndex = 1
            for i = 1, #self.mShowNodeTypeList do
                if (self.mShowNodeType == self.mShowNodeTypeList[i]) then
                    searchIndex = i
                end
            end
            searchIndex = searchIndex >= #self.mShowNodeTypeList and 1 or searchIndex + 1
            self.mShowNodeType = self.mShowNodeTypeList[searchIndex]
        end
        return self.mShowNodeType
    end
end

function setDecorateNodeVisible(self, visible)
    local decorate = Perset3dHandler:getSceneShowData(self:getShowNodeType(false)).decorateNode
    if (decorate and not gs.GoUtil.IsTransNull(decorate)) then
        decorate.gameObject:SetActive(visible)
    end
end

-- 设置背景特效
function updateBgEff(self)
end

function onClickRecordHandler(self)
    if (self.mIsRecord == nil or self.mIsRecord == false) then
        self.mIsRecord = true
    else
        self.mIsRecord = false
    end
    self.gBtnClose:SetActive(not self.mIsRecord)
    self.gBtnCloseAll:SetActive(not self.mIsRecord)
    self.mGroupContent:GetComponent(ty.CanvasGroup).alpha = self.mIsRecord and 0 or 1
    gm.GmManager:dispatchEvent(gm.GmManager.EVENT_VISIBLE_CHANGE, not self.mIsRecord)
    debugFrames.FPS:dispatchEvent(debugFrames.FPS.EVENT_VISIBLE_CHANGE, not self.mIsRecord)
end

function onClickEnableClearHandler(self)
    self:setUnAble(self.mIssueType)
    self.mIssueType = nil
end

function onClickEnableHeroHandler(self)
    self:setAble(self.IssueTypeEnum.Hero)
end

function onClickEnableMainExploreHandler(self)
    self:setAble(self.IssueTypeEnum.MainExplore)
end

function onClickChangeNodeHandler(self)
    self:setDecorateNodeVisible(true)
    Perset3dHandler:setupShowData(self:getShowNodeType(true), nil, nil, self:getShowBgUrl(false))
    if (self:getShowNodeType(false) == MainCityConst.ROLE_MODE_OVERVIEW) then

        fight.FightCamera:setVideoQuality() --设置4k画质

        self:setDecorateNodeVisible(true)
    else
        self:setDecorateNodeVisible(false)
    end
    self:updateModelView()
end

function onClickChangeBgHandler(self)
    Perset3dHandler:setupShowData(self:getShowNodeType(false), nil, nil, self:getShowBgUrl(true))
end

function onClickPlayerActionHandler(self)
    if self.mModelView then
        local function finishCall(result)
            print("动作播放结束", result)
        end
        local result, baseData = self.mModelView:playClickAction(finishCall)
    end
end

function onClickPlayActionWithWeaponHandler(self)
    self.mActionShowType = self.mActionShowType == MainCityConst.ROLE_MODE_MAIN and MainCityConst.ROLE_MODE_OVERVIEW or MainCityConst.ROLE_MODE_MAIN
    self:updateModelView()
end

function onClickShadowHandler(self)
    if self.mModelView then
        self.mRoleLayer = self.mRoleLayer == "Ground" and "Default" or "Ground"
        self.mModelView:setDisplayLayer(self.mRoleLayer)
    end
end

function onClickDormitoryHandler(self)
    -- local data = Perset3dHandler:getSceneShowData(MainCityConst.ROLE_MODE_UI)
    -- local uiBgRenderer = data.uiBgRenderer
    -- local uiBgGo = uiBgRenderer.gameObject
    -- local cloneUiBgGo = gs.GameObject.Instantiate(uiBgGo)
    -- local scTrans = gs.CameraMgr:GetSceneCameraTrans()
    -- cloneUiBgGo.transform:SetParent(scTrans, true)
end

function onScaleChangedHandler(self, content)
    local scale = tonumber(content)
    if (scale) then
        self.mScaleRatio = scale
    else
        self.mScaleInput.text = self.mScaleRatio
    end
    self:updateModelView()
end

function onSpeedChangedHandler(self, content)
    local speed = tonumber(content)
    if (speed) then
        self.mRotateSpeed = speed
    else
        self.mRotateSpeedInput.text = self.mRotateSpeed
    end
end

function onOffsetChangedHandler(self, offsetVector)
    self.mPosOffset = offsetVector
    self.mPosOffsetX.text = self.mPosOffset.x
    self.mPosOffsetY.text = self.mPosOffset.y
    self.mPosOffsetZ.text = self.mPosOffset.z
    self:updateModelView()
end

function onClickRotateLeftHandler(self)
    self.mRotateDir = -1
    self.mIsRotate = true
    self:updateBtnRotateState()
end

function onClickRotateStateHandler(self)
    self.mIsRotate = not self.mIsRotate
    self:updateBtnRotateState()
end

function onClickRotateRightHandler(self)
    self.mRotateDir = 1
    self.mIsRotate = true
    self:updateBtnRotateState()
end

function onFrameHandler(self)
    if (self.mIsRotate) then
        if (self.mModelView and self.mModelView:getTrans() and self.mAngle) then
            self.mAngle.y = self.mAngle.y + self.mRotateSpeed * self.mRotateDir
            gs.TransQuick:SetLRotation(self.mModelView:getTrans(), self.mAngle)
        end
        if self.mAngle.y == 360 then
            self.mAngle.y = 0
            self.mIsRotate = false
        end
    end
end

function updateBtnRotateState(self)
    self:setBtnLabel(self.mBtnRotateState, nil, self.mIsRotate and "停止旋转" or "开始旋转")
end

function onClickChangeFashionHander(self)
    local heroFashionDic = fashion.FashionManager:getHeroFashionConfigDic(fashion.Type.CLOTHES, self.mCurHeroTid)
    local list = table.keys(heroFashionDic)
    if self.mFashionIndex >= #list then
        self.mFashionIndex = 1
    end
    local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mCurHeroTid)

    self:recoverModel(false)
    self.mModelView = fight.LiveView.new()
    self.mModelView:setModeType(self.mActionShowType)
    self.mModelView:setDisplayLayer(self.mRoleLayer)
    self.mModelView:setModelID(0, heroConfigVo:getUIModel(list[self.mFashionIndex + 1]), nil, nil,
    function()
        Perset3dHandler:setupShowData(self:getShowNodeType(false), self.mModelView:getTrans(), self.mModelView:getModelId(), self:getShowBgUrl(false))
        self.mAngle = math.Vector3(0, 0, 0)
        if (self:getShowNodeType(false) == MainCityConst.ROLE_MODE_UI) then
            gs.TransQuick:LPos(self.mModelView:getTrans(), self.mPos.x + self.mPosOffset.x - 0.24, self.mPos.y + self.mPosOffset.y, self.mPos.z + self.mPosOffset.z)
        else
            self.mPos.x = self.mModelView:getTrans().localPosition.x
            self.mPos.y = self.mModelView:getTrans().localPosition.y
            self.mPos.z = self.mModelView:getTrans().localPosition.z
            gs.TransQuick:LPosOffset(self.mModelView:getTrans(), self.mPos.x + self.mPosOffset.x, self.mPos.y + self.mPosOffset.y, self.mPos.z + self.mPosOffset.z)
        end
        gs.TransQuick:SetLRotation(self.mModelView:getTrans(), self.mAngle)
        gs.TransQuick:Scale(self.mModelView:getTrans(), self.mScaleRatio, self.mScaleRatio, self.mScaleRatio)
    end)


    self.mFashionIndex = self.mFashionIndex + 1
end

-- 更新模型
function updateModelView(self)
    self:recoverModel(false)
    self.mModelView = fight.LiveView.new()
    self.mModelView:setModeType(self.mActionShowType)
    self.mModelView:setDisplayLayer(self.mRoleLayer)
    self.mModelView:setTID(self.mCurHeroTid, 0, false, nil,
    function()
        Perset3dHandler:setupShowData(self:getShowNodeType(false), self.mModelView:getTrans(), self.mModelView:getModelId(), self:getShowBgUrl(false))
        self.mAngle = math.Vector3(0, 0, 0)
        if (self:getShowNodeType(false) == MainCityConst.ROLE_MODE_UI) then
            gs.TransQuick:LPos(self.mModelView:getTrans(), self.mPos.x + self.mPosOffset.x - 0.24, self.mPos.y + self.mPosOffset.y, self.mPos.z + self.mPosOffset.z)
        else
            self.mPos.x = self.mModelView:getTrans().localPosition.x
            self.mPos.y = self.mModelView:getTrans().localPosition.y
            self.mPos.z = self.mModelView:getTrans().localPosition.z
            gs.TransQuick:LPosOffset(self.mModelView:getTrans(), self.mPos.x + self.mPosOffset.x, self.mPos.y + self.mPosOffset.y, self.mPos.z + self.mPosOffset.z)
        end
        gs.TransQuick:SetLRotation(self.mModelView:getTrans(), self.mAngle)
        gs.TransQuick:Scale(self.mModelView:getTrans(), self.mScaleRatio, self.mScaleRatio, self.mScaleRatio)
    end)
end

function updateHeroList(self)
    self:recoveryHeroItemList()
    local heroConfigDic = hero.HeroManager:getHeroConfigDic()
    for heroTid, heroConfigVo in pairs(heroConfigDic) do
        self.mCurHeroTid = self.mCurHeroTid or heroTid
        local item = SimpleInsItem:create(self.mIssueHeadItem, self.mContent, self.__cname .. "_self.mIssueHeadItem")
        local mImgHead = item:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage)
        mImgHead:SetImg(UrlManager:getHeroHeadUrl(heroTid), false)
        local function _clickFun()
            self.mCurHeroTid = heroTid
            self:updateModelView()
        end
        item:addUIEvent("mImgClick", _clickFun)
        table.insert(self.mHeroItemList, item)
    end
end

function recoverModel(self, isResetMaincity)
    if self.mModelView then
        self.mModelView:destroy()
        self.mModelView = nil
    end
    if (isResetMaincity) then
        Perset3dHandler:toNormalShowData()
    end
end

function recoveryHeroItemList(self)
    if (self.mHeroItemList) then
        for i = 1, #self.mHeroItemList do
            self.mHeroItemList[i]:poolRecover()
        end
    end
    self.mHeroItemList = {}
end

-- 隐藏锚点空间ui
function onClickMainExploreUIHandler(self)
    self.mIsShowUiEvent = not self.mIsShowUiEvent
    local thingDic = mainExplore.MainExploreSceneThingManager:getThingDic()
    if (thingDic) then
        for eventType, thingList in pairs(thingDic) do
            for i = 1, #thingList do
                local thing = thingList[i]
                if (thing) then
                    thing.m_trans.gameObject:SetActive(self.mIsShowUiEvent)
                end
            end
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_MAIN_EXPORE_UI_VISIBLE, self.mIsShowUiEvent)
end

-- 隐藏锚点空间玩家模型
function onClickMainExplorePlayerHandler(self)
    local playerThing = mainExplore.MainExplorePlayerProxy:getThing()
    if (playerThing) then
        playerThing.m_modelTrans.gameObject:SetActive(not playerThing.m_modelTrans.gameObject.activeSelf)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1338):	"- 当前暂无战员 -"
]]