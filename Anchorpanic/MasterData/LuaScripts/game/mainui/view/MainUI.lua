--[[     主UI界面
]]
module("mainui.MainUI", Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("mainui/MainUI.prefab")
isAdapta = 1

function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.MainUI)
    self.m_isOpen = false

    self.m_playedHelloVoice = false
end

function initData(self)
    -- 左侧系统按钮列表
    self.mSysList = {}
    -- 右下功能按钮列表
    self.mFuncList = {}
    -- 右侧玩法按钮列表
    self.mDetailList = {}
    -- 左侧活动按钮列表
    self.mActivityList = {}
    -- 限时活动列表
    self.mTimeActList = {}
end

-- 适应全面屏，刘海缩进
function setAdapta(self)
    local notchHeight = systemSetting.SystemSettingManager:getNotchH()
    if notchHeight ~= nil and self:getAdaptaTrans() then
        local minV = self:getAdaptaTrans().offsetMin
        minV.x = math.max(notchHeight + 6, 0) -- 空多6个像素给红点
        self:getAdaptaTrans().offsetMin = minV

        local maxV = self:getAdaptaTrans().offsetMax
        maxV.x = -math.max(notchHeight, 0)
        self:getAdaptaTrans().offsetMax = maxV
    end
end

-- 刘海适配缩放节点
function getAdaptaTrans(self)
    return self:getChildTrans("mGroupAdapt")
end

function onLoadAssetComplete(self)
    -- 实例化是一个克隆对象，并不是加载的那个prefab，需要重新取
    self.UIObject = AssetLoader.GetGO(self.UIRes, self)
    self.UITrans = self.UIObject.transform
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)

    self:configUI()
end

-- 初始化
function configUI(self)

    -- 隐藏ui
    self.mBtnHideUI = self:getChildGO("mBtnHideUI")
    self.mImgHideUI = self:getChildGO("mImgHideUI"):GetComponent(ty.AutoRefImage)
    self.mBtnShowUI = self:getChildGO("mBtnShowUI")
    self.mBtnShowUI2 = self:getChildGO("mBtnShowUI2")
    -- 模型交互热区
    self.mModeHitBox = self:getChildGO("mModeHitBox")
    -- 模型交互热区
    self.mDragHitBox = self:getChildGO("mDragHitBox")
    self.mEventTrigger = self.mDragHitBox:GetComponent(ty.LongPressOrClickEventTrigger)
    self.mEventTrigger:SetIsPassEvent(true)
    self.UIGroup = self:getChildGO("UI")

    -- spine动画节点
    self.mGroupSpine = self:getChildTrans("mGroupSpine")

    ------------------- mGroupMoney 货币栏----------------------
    self.m_moneyBarTrans = self:getChildTrans("MoneyBar")

    ------------------- mGroupHud 玩家信息hud----------------------
    self.mGroupHud = self:getChildGO("mGroupHud")
    self.mGroupHead = self:getChildGO("mGroupHead")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_TOP_HEAD, self.mGroupHead, funcopen.FuncOpenConst.FUNC_ID_HOME, LinkCode.HomePage)

    self.mImgPower = self:getChildTrans("mImgPower")
    self.mImgWifi = self:getChildGO("mImgWifi"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtId = self:getChildGO("mTxtId"):GetComponent(ty.Text)
    self.mTxtClock = self:getChildGO("mTxtClock"):GetComponent(ty.Text)
    self.mImgProBar = self:getChildGO("mImgProBar"):GetComponent(ty.Image)

    ------------------- mGroupMutual 互动区-----------------------
    -- 看板娘互动模块
    self.mGroupMutual = self:getChildGO("mGroupMutual")
    -- 互动对话背景
    self.mImgTalkBg = self:getChildGO("mImgTalkBg")
    -- 互动对话信息
    self.mTxtTalk = self:getChildGO("mTxtTalk"):GetComponent(ty.Text)
    -- 菜单开关
    -- self.mBtnOpenMenu = self:getChildGO("mBtnOpenMenu")
    -- 送礼
    self.mBtnGift = self:getChildGO("mBtnGift")
    -- 切换角色
    self.mBtnChange = self:getChildGO("mBtnChange")
    -- 切换动态立绘
    self.mBtnDynamic = self:getChildGO("mBtnDynamic")
    self.mBtnDynamic:SetActive(false)
    ---3D宿舍
    self.mBtnBigHostel = self:getChildGO("mBtnBigHostel")

    self.mTxtDynamic = self:getChildGO("mTxtDynamic"):GetComponent(ty.Text)

    ------------------------------商店标签------------------------------
    self.mImgShopAdvertising = self:getChildGO("mImgShopAdvertising")
    self.mTxtShopAdvertising = self:getChildGO("mTxtShopAdvertising"):GetComponent(ty.Text)
    ------------------- mGroupSys 系统区----------------------------
    self.mGroupFunc = self:getChildGO("mGroupFunc")
    -- 公告
    self.mBtnNotice = self:getChildGO("mBtnNotice")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnNotice, funcopen.FuncOpenConst.FUNC_ID_BULLETIN, LinkCode.Bulletin)
    -- 邮件
    self.mBtnMail = self:getChildGO("mBtnMail")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnMail, funcopen.FuncOpenConst.FUNC_ID_MAIL, LinkCode.Mail)
    -- 好友
    self.mBtnFriend = self:getChildGO("mBtnFriend")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnFriend, funcopen.FuncOpenConst.FUNC_ID_FRIEND, LinkCode.Friend)
    -- 图鉴
    self.mBtnManual = self:getChildGO("mBtnManual")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnManual, funcopen.FuncOpenConst.FUNC_ID_MANUAL, LinkCode.Manual, nil, true)
    -- 设置
    -- self.mBtnSetting = self:getChildGO("mBtnSetting")
    -- self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnSetting, funcopen.FuncOpenConst.FUNC_ID_SETTING, LinkCode.Setting)
    -- 手环通讯
    self.mBtnCommunicate = self:getChildGO("mBtnCommunicate")
    self.mImgCommunicate = self:getChildGO("mImgCommunicate"):GetComponent(ty.Image)
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnCommunicate, funcopen.FuncOpenConst.FUNC_ID_COMMUNICATION, LinkCode.Communication, self.mImgCommunicate, nil, true)
    -- 聊天
    self.mChatItem = self:getChildGO("mChatItem")
    self.mTextChatContent = self:getChildGO("mChatContent"):GetComponent(ty.Text)
    self.ChatRedPoint = self:getChildGO("ChatRedPoint")

    self.mBtnBigHostelSwitch = self:getChildGO("mBtnBigHostelSwitch")
    self.mBtnBigHostelExit = self:getChildGO("mBtnBigHostelExit")

    ------------------- mGroupFunc 功能区------------------------------
    self.mGroupSys = self:getChildGO("mGroupSys")
    -- 背包
    self.mBtnBag = self:getChildGO("mBtnBag")
    self.mImgBag = self:getChildGO("mImgBag"):GetComponent(ty.Image)
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DOWN_FUNC, self.mBtnBag, funcopen.FuncOpenConst.FUNC_ID_BAG, LinkCode.Bag, self.mImgBag)
    -- 日常
    self.mBtnDaily = self:getChildGO("mBtnDaily")
    self.mImgDaily = self:getChildGO("mImgDaily"):GetComponent(ty.Image)
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DOWN_FUNC, self.mBtnDaily, funcopen.FuncOpenConst.FUNC_ID_TASK, LinkCode.Task, self.mImgDaily)
    -- 成就
    self.mBtnAchievement = self:getChildGO("mBtnAchievement")
    self.mImgAchievement = self:getChildGO("mImgAchievement"):GetComponent(ty.Image)
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DOWN_FUNC, self.mBtnAchievement, funcopen.FuncOpenConst.FUNC_ID_HOME_ACHIEVEMENT, LinkCode.HomeAchievement, self.mImgAchievement)
    -- 福利
    -- self.mBtnWelfare = self:getChildGO("mBtnWelfare")
    -- self.mImgWelfare = self:getChildGO("mImgWelfare"):GetComponent(ty.Image)
    -- self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DOWN_FUNC, self.mBtnWelfare, funcopen.FuncOpenConst.FUNC_ID_HOME_WELFARE, LinkCode.HomeWelfare, self.mImgWelfare)

    self.mBtnFormation = self:getChildGO("mBtnFormation")
    self.mImgFormation = self:getChildGO("mImgFormation"):GetComponent(ty.Image)
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DOWN_FUNC, self.mBtnFormation, funcopen.FuncOpenConst.FUNC_ID_HERO_TEAM, LinkCode.HeroTeam, self.mImgFormation)

    -- 商店
    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mImgShop = self:getChildGO("mImgShop"):GetComponent(ty.Image)
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DOWN_FUNC, self.mBtnShop, funcopen.FuncOpenConst.FUNC_ID_SHOPPING, LinkCode.Shopping, self.mImgShop)
    -------------------- mGroupDetail 玩法区----------------------------
    self.mGroupDetail = self:getChildGO("mGroupDetail")
    -- 战员资料
    self.mBtnHero = self:getChildGO("mBtnHero")
    self.mBtnHero:GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DETAIL, self.mBtnHero, funcopen.FuncOpenConst.FUNC_ID_HERO, LinkCode.Hero)
    self.mTxtHeroPro = self:getChildGO("mTxtHeroPro"):GetComponent(ty.Text)
    self.mImgHeroProBar = self:getChildGO("mImgHeroProBar"):GetComponent(ty.Image)

    -- 招募
    self.mBtnRecruit = self:getChildGO("mBtnRecruit")
    self.mBtnRecruit:GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DETAIL, self.mBtnRecruit, funcopen.FuncOpenConst.FUNC_ID_RECRUIT, LinkCode.Recruit)

    -- 竞技场
    self.mBtnArena = self:getChildGO("mBtnArena")
    self.mBtnArena:GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DETAIL, self.mBtnArena, funcopen.FuncOpenConst.FUNC_ID_PVP, LinkCode.Pvp)

    -- 联盟
    self.mBtnGuild = self:getChildGO("mBtnGuild")
    self.mBtnGuild:GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DETAIL, self.mBtnGuild, funcopen.FuncOpenConst.FUNC_ID_GUILD, LinkCode.Guild)
    self:setGuideTrans("funcTips_guide_mainUIBtn_Guild", self.mBtnGuild.transform)

    -- 基建
    self.mBtnCovenant = self:getChildGO("mBtnCovenant")
    self.mBtnCovenant:GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DETAIL, self.mBtnCovenant, funcopen.FuncOpenConst.FUNC_ID_WARSHIP, LinkCode.Covenant)
    self:setGuideTrans("funcTips_guide_mainUIBtn_Covenant", self.mBtnCovenant.transform)

    -- 作战
    self.mBtnAdventure = self:getChildGO("mBtnAdventure")
    self.mBtnAdventure:GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DETAIL, self.mBtnAdventure, funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, LinkCode.Adventure)
    -- self.mTxtNow = self:getChildGO("mTxtNow"):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO("mTxtStageName"):GetComponent(ty.Text)
    self.mTxtChapterName = self:getChildGO("mTxtChapterName"):GetComponent(ty.Text)

    self.mBtnDisaster = self:getChildGO("mBtnDisaster")
    self.mBtnDisaster:GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DETAIL, self.mBtnDisaster, funcopen.FuncOpenConst.FUNC_ID_DISASTER, LinkCode.Disaster)
    self:registerActivity(self.mBtnDisaster, funcopen.FuncOpenConst.FUNC_ID_DISASTER, disaster.DisasterManager)

    -- 是否初次引导
    self.mCanFistShow = self:getChildGO("mCanFistShow")
    self.mCanFistShow:SetActive(false)

    ---------------------- mGroupActivity 活动区-----------------------------
    -- 常驻活动（放在FUNC里就好）
    self.mBtnPayAct = self:getChildGO("mBtnPayAct")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnPayAct, funcopen.FuncOpenConst.FUNC_ID_ACTIVITY, LinkCode.Activity)

    self.mBtnWelfare = self:getChildGO("mBtnWelfare")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnWelfare, funcopen.FuncOpenConst.FUNC_ID_HOME_WELFARE, LinkCode.HomeWelfare)
    -- 累计活动
    self.mBtnNovice = self:getChildGO("mBtnNovice")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnNovice, funcopen.FuncOpenConst.FUNC_ID_NOVICE_ACTIVITY, LinkCode.NoviceActivity)

    -- 回归活动
    self.mBtnReturned = self:getChildGO("mBtnReturned")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnReturned, funcopen.FuncOpenConst.FUNC_ID_RETURNED, LinkCode.Returned)

    -- 特供
    self.mBtnSpecialSupply = self:getChildGO("mBtnSpecialSupply")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnSpecialSupply, funcopen.FuncOpenConst.FUNC_ID_SPECIALSUPPLY, LinkCode.SpecialSupply)
    self:registerActivity(self.mBtnSpecialSupply, funcopen.FuncOpenConst.FUNC_ID_SPECIALSUPPLY, activity.ActitvityExtraManager)

    -- 周年庆典活动
    self.mBtnCelebration = self:getChildGO("mBtnCelebration")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnCelebration, funcopen.FuncOpenConst.FUNC_ID_CELEBRATION, LinkCode.Celebration)
    self:registerActivity(self.mBtnCelebration, funcopen.FuncOpenConst.FUNC_ID_CELEBRATION_TASK, mainActivity.MainActivityManager)

    --阿尔戈特供
    self.mBtnSupercial = self:getChildGO("mBtnSupercial")
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_FUNC, self.mBtnSupercial, funcopen.FuncOpenConst.FUNC_ID_SUPECIAL, LinkCode.Supercial)
    self:registerActivity(self.mBtnSupercial, funcopen.FuncOpenConst.FUNC_ID_SUPECIAL, supercial.SupercialManager)
    self.mTxtSupercialTime = self:getChildGO("mTxtSupercialTime"):GetComponent(ty.Text)

    -- 商店限时礼包
    self.mBtnShopLimitGift = self:getChildGO("mBtnShopLimitGift")
    self.mShopTime = self:getChildGO("mShopTime"):GetComponent(ty.Text)

    --首充------------------------------------------
    self.mBtnFirstCharge = self:getChildGO("mBtnFirstCharge")
    self.mBtnFirstCharge:GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5
    self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_ACTIVTY, self.mBtnFirstCharge, funcopen.FuncOpenConst.FUNC_ID_FIRSTCHARGE, LinkCode.FirstCharge)
    -- 运营活动
    --self.mBtnActivity = self:getChildGO("mBtnActivity")
    -- self.mImgActivity = self:getChildGO("mImgActivity"):GetComponent(ty.Image)
    -- self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_ACTIVTY, self.mBtnActivity, funcopen.FuncOpenConst.FUNC_ID_ACTIVITY, LinkCode.Activity, self.mImgActivity)

    --时装通行证------------------------------------------
    -- self.mBtnFashionPermit = self:getChildGO("mBtnFashionPermit")
    -- self:registerIcon(MAIN_UI_FUNC_TYPE.LEFT_ACTIVTY, self.mBtnFashionPermit, funcopen.FuncOpenConst.FUNC_ID_FASHIONPERMIT, LinkCode.FashionPermit)
    -- self:registerActivity(self.mBtnFashionPermit, funcopen.FuncOpenConst.FUNC_ID_FASHIONPERMIT, fashion.FashionManager)

    -- 限时活动 -------------------------------------------------------------
    self.mBtnTimeAct = self:getChildGO("mBtnTimeAct")
    self.mBtnTimeAct:GetComponent(ty.Image).alphaHitTestMinimumThreshold = 0.5
    self:registerIcon(MAIN_UI_FUNC_TYPE.RIGHT_DETAIL, self.mBtnTimeAct, funcopen.FuncOpenConst.FUNC_ID_MAIN_ACTIVITY, LinkCode.MainActivity)
    self:registerActivity(self.mBtnTimeAct, funcopen.FuncOpenConst.FUNC_ID_MAIN_ACTIVITY, mainActivity.MainActivityManager)

    self.mBtnTimeActImg = self.mBtnTimeAct:GetComponent(ty.AutoRefImage)
    if (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) then
        self.mBtnTimeActImg:SetImg(UrlManager:getBgPath("billboard/billboard_bg_3018_har.png"))
    else
        self.mBtnTimeActImg:SetImg(UrlManager:getBgPath("billboard/billboard_bg_3018.png"))
    end

    self.mActivityView = mainui.MainUIActivityView.new()
    self.mActivityView:setUIGo(self:getChildGO("MainUIActivity"))

    self.mFashionPermitView = mainui.MainUIPermitView.new()
    self.mFashionPermitView:setUIGo(self:getChildGO("mFashionPermit"))

    self.mBtnGame = self:getChildGO("mBtnGame")
    self.mNoteView = note.NoteView.new()

    -- 下载中心 -------------------------------------------------------------
    self.mGroupDownLoad = self:getChildGO("mGroupDownLoad")
    self.mBtnDownLoad = self:getChildGO("mBtnDownLoad")
    self:updateSubDownLoadVisible()
end

-- 激活
function active(self, args)
    self:setMoneyBar()
    self:addEvent()
    self:updateRTHandler(true)
    self:updateView()
    if self.mActivityView then
        self.mActivityView:active()
    end
    if self.mFashionPermitView then
        self.mFashionPermitView:active()
    end
    if self.mNoteView then
        self.mNoteView:show(self:getChildTrans("mGroupAdapt"))
        self.mNoteView:active()
    end
    self:resFirstShow()
    if (not LoopManager:hasTimer(self.mTimerSn)) then
        self.needTime = sysParam.SysParamManager:getValue(1900)
        self.needSmallerStage = sysParam.SysParamManager:getValue(1901)
        self.mTimerSn = LoopManager:addTimer(1, 0, self, self.onTimer)
        self:onTimer()
    end

    self.mEventTrigger.onBeginDrag:AddListener(function()
        -- self:onBeginDragHandler()
        self.mIsDraging = true
        GameDispatcher:dispatchEvent(EventName.MAINUI_SPINE_DRAG_START)

    end)
    self.mEventTrigger.onEndDrag:AddListener(function()
        -- self:onEndDragHandler()
        self.mIsDraging = false
        GameDispatcher:dispatchEvent(EventName.MAINUI_SPINE_DRAG_END)
    end)

    -- if(not LoopManager:hasTimer(self.mFirstGuide)) and true then
    --     local roleVo = role.RoleManager:getRoleVo()
    -- end
    dailyCheckIn.DailyCheckInManager:setisOnMainUI(true)
    self:updateUIBtn()
    self:updateRedFlag(true)
    self:updateHarImg()
    --主界面左上角活动红点刷新
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    -- self.mTxtNow.text = _TT(72101)
    self:setBtnLabel(self.mBtnChange, 1196, "切换助理")
    self:setBtnLabel(self.mBtnShopLimitGift, 80, "限时")
    self:setBtnLabel(self.mBtnNovice, 90037, "新人")
    self:setBtnLabel(self.mBtnCelebration, 121006, "庆典")
    self:setBtnLabel(self.mBtnSpecialSupply, 72115, "特供")
    self.mGroupMutual:SetActive(false)
    mainui.MainUIManager:StopCvMutual()
    self:updateSpineHitBox()
    self.mBtnBigHostelSwitch:SetActive(mainui.MainUIManager.isShowBigHostel)
    self.mBtnBigHostelExit:SetActive(mainui.MainUIManager.isShowBigHostel)

end

function resFirstShow(self)
    self.isAddTime = 0
    self.isShowFirst = false
    self.mCanFistShow:SetActive(false)
end

-- 非激活
function deActive(self)
    self:resFirstShow()

    self:resetMoneyBar()
    self:clearSpine()
    self:removeEvent()
    self:updateRTHandler(false)
    if self.mActivityView then
        self.mActivityView:deActive()
    end
    if self.mFashionPermitView then
        self.mFashionPermitView:deActive()
    end
    if self.mNoteView then
        self.mNoteView:deActive()
    end
    if self.mAlphaTween then
        self.mAlphaTween:Kill()
    end
    dailyCheckIn.DailyCheckInManager:setisOnMainUI(false)

    self.mEventTrigger.onBeginDrag:RemoveAllListeners()
    self.mEventTrigger.onEndDrag:RemoveAllListeners()
end

function updateRTHandler(self, isShowRT)
end

-- 打开
function open(self, args)

    if self.m_isOpen then
        return
    end
    self.m_isOpen = true

    if self.UIObject then
        self:addOnParent()
    end
    if self.animFrameSn then
        LoopManager:removeFrameByIndex(self.animFrameSn)
        self.animFrameSn = nil
    end
    self.animFrameSn = LoopManager:addFrame(1, 1, self, function()
        if args and args.isShowTween == true then
            local anim = self.UIObject:GetComponent(ty.Animator)
            if not gs.GoUtil.IsCompNull(anim) then
                anim:SetTrigger("show")
            end
        end
    end)

    if args and args.isShowScreenSaver == false then
        return
    end

    mainui.MainUIManager:setMainUIOpen(true)
    mainui.MainUIManager:playFirstCV()

    -- 进入战斗的加载界面时，这里不派发
    if not fight.SceneManager:isInFightScene() then
        if (not loginLoad.LoginLoadController:isLoginLoading()) then
            UIFactory:closeScreenSaver()
        end
    end
end

-- 关闭
function close(self)
    if not self.m_isOpen then
        return
    end
    if self.animFrameSn then
        LoopManager:removeFrameByIndex(self.animFrameSn)
        self.animFrameSn = nil
    end
    if self.mTimerSn then
        LoopManager:removeTimerByIndex(self.mTimerSn)
        self.mTimerSn = nil
    end
    mainui.MainUIManager:setMainUIOpen(false)
    self.m_isOpen = false
    if self.UITrans then
        self.UITrans:SetParent(GameView.UICache, false)
    end
    self:__deActive()
end

function addEvent(self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_NAME, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_EXP, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MAXEXP, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR_FRAME, self.onUpdatePlayerInfoHandler, self)
    battleMap.MainMapManager:addEventListener(battleMap.MainMapManager.EVENT_DUP_UPDATE, self.onMainMapUpdateHandler, self)

    GameDispatcher:addEventListener(EventName.HERO_LIST_INIT, self.onHeroListInitHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_LIST_UPDATE, self.onHeroListUpdateHandler, self)
    -- GameDispatcher:addEventListener(EventName.CHAT_MSG_UPDATE, self.onUpdateChatMsgHandler, self)
    GameDispatcher:addEventListener(EventName.FUNC_OPEN_DATA_INIT, self.onFuncOpenUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.FUNC_OPEN_UPDATE, self.onFuncOpenUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.SHOW_HERO_INTERACT, self.onShowHeroInTeractHandler, self)
    GameDispatcher:addEventListener(EventName.SHOW_HERO_INTERACT_TEXT_ONLY, self.onShowHeroInTeractTextOnlyHandler, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.onActivityOpenHandler, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.onActivityCloseHandler, self)
    GameDispatcher:addEventListener(EventName.MODEL_PLAYED, self.__modelPlayed, self)
    GameDispatcher:addEventListener(EventName.MAIN_CITY_RT_UPDATE, self.updateRTHandler, self)

    GameDispatcher:addEventListener(EventName.ACTIVITY_CLICK_BROADCAST, self.clickActivityHandler, self)
    GameDispatcher:addEventListener(EventName.MAINUI_LIVEVIEW_CVCALLFINISH, self.closeMutual, self)

    GameDispatcher:addEventListener(EventName.ACTIVITY_NOVICE_UPDATE, self.onNoviceActivityUpdate, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FIRSTCHARGE_PANEL, self.onFirstChargeUpdate, self)
    GameDispatcher:addEventListener(EventName.RETURNED_STATE_CHANGE, self.onRerturnedActivityUpdate, self)

    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_RESULT_SUCCESS, self.onSubDownLoadSuccessUpdateHandler, self)
    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_RESULT_FAIL, self.onSubDownLoadFailUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.RES_SUB_DOWNLOAD_GIFT_RESULT, self.updateSubDownLoadVisible, self)

    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.refreshChatBubbleRedState, self)
    GameDispatcher:addEventListener(EventName.REFRESH_CHATBUBBLE_REDSTATE, self.refreshChatBubbleRedState, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_SHOW_BOARD_HERO, self.onShowBoardHeroChangeHandler, self)

    -- 每次打开请求服务器面板对应频道数据
    GameDispatcher:dispatchEvent(EventName.REQ_CHAT_PANEL_DATA, { channel = chat.ChannelType.WORLD })

    -- self:addOnClick(self.mGroupHead, self.onClickHeadHandler)
    self:addOnClick(self.mBtnHideUI, self.onHideUIHandler)
    self:addOnClick(self.mBtnShowUI, self.onShowUIHandler)
    self:addOnClick(self.mBtnShowUI2, self.onShowUIHandler)
    self:addOnClick(self.mChatItem, self.onOpenChatHandler)
    self:addOnClick(self.mModeHitBox, self.onClickModelHandler)
    self:addOnClick(self.mBtnChange, self.onOpenShowBoardModelHandler)
    self:addOnClick(self.mBtnGift, self.onOpenGiftHandler)
    self:addOnClick(self.mBtnGame, self.onOpenGameHandler)
    self:addOnClick(self.mBtnDynamic, self.onChangeDynamicPicHandler)
    self:addOnClick(self.mBtnBigHostel, self.onOpenBigHostelHandler)
    self:addOnClick(self.mBtnBigHostelSwitch, self.onOpenBigHostelSwitchHandler)
    self:addOnClick(self.mBtnBigHostelExit, self.onOpenBigHostelExitHandler)

    self:addOnClick(self.mBtnDownLoad, self.onOpenSubDownLoadHandler)
    self:addOnClick(self.mBtnShopLimitGift, self.onOpenLimitShopHandler)
    -- test
    -- self:addOnClick(self.mBtnRogueLike,function()
    --     GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_MAIN_PANEL)
    -- end)

end

function removeEvent(self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_NAME, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_EXP, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MAXEXP, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR_FRAME, self.onUpdatePlayerInfoHandler, self)
    battleMap.MainMapManager:removeEventListener(battleMap.MainMapManager.EVENT_DUP_UPDATE, self.onMainMapUpdateHandler, self)

    GameDispatcher:removeEventListener(EventName.HERO_LIST_INIT, self.onHeroListInitHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_LIST_UPDATE, self.onHeroListUpdateHandler, self)
    -- GameDispatcher:removeEventListener(EventName.CHAT_MSG_UPDATE, self.onUpdateChatMsgHandler, self)
    GameDispatcher:removeEventListener(EventName.FUNC_OPEN_DATA_INIT, self.onFuncOpenUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.FUNC_OPEN_UPDATE, self.onFuncOpenUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.SHOW_HERO_INTERACT, self.onShowHeroInTeractHandler, self)
    GameDispatcher:removeEventListener(EventName.SHOW_HERO_INTERACT_TEXT_ONLY, self.onShowHeroInTeractTextOnlyHandler, self)
    GameDispatcher:removeEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.onActivityOpenHandler, self)
    GameDispatcher:removeEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.onActivityCloseHandler, self)

    GameDispatcher:removeEventListener(EventName.MODEL_PLAYED, self.__modelPlayed, self)
    GameDispatcher:removeEventListener(EventName.MAIN_CITY_RT_UPDATE, self.updateRTHandler, self)

    GameDispatcher:removeEventListener(EventName.ACTIVITY_CLICK_BROADCAST, self.clickActivityHandler, self)
    GameDispatcher:removeEventListener(EventName.MAINUI_LIVEVIEW_CVCALLFINISH, self.closeMutual, self)

    GameDispatcher:removeEventListener(EventName.ACTIVITY_NOVICE_UPDATE, self.onNoviceActivityUpdate, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FIRSTCHARGE_PANEL, self.onFirstChargeUpdate, self)
    GameDispatcher:removeEventListener(EventName.RETURNED_STATE_CHANGE, self.onRerturnedActivityUpdate, self)

    download.ResDownLoadManager:removeEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_RESULT_SUCCESS, self.onSubDownLoadSuccessUpdateHandler, self)
    download.ResDownLoadManager:removeEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_RESULT_FAIL, self.onSubDownLoadFailUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.RES_SUB_DOWNLOAD_GIFT_RESULT, self.updateSubDownLoadVisible, self)

    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.refreshChatBubbleRedState, self)
    GameDispatcher:removeEventListener(EventName.REFRESH_CHATBUBBLE_REDSTATE, self.refreshChatBubbleRedState, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_SHOW_BOARD_HERO, self.onShowBoardHeroChangeHandler, self)

    -- self:removeOnClick(self.mGroupHead, self.onClickHeadHandler)
    self:removeOnClick(self.mBtnHideUI)

    self:removeOnClick(self.mBtnShowUI)
    self:removeOnClick(self.mBtnShowUI2)
    self:removeOnClick(self.mChatItem)
    self:removeOnClick(self.mModeHitBox)
    -- self:removeOnClick(self.mBtnOpenMenu)
    self:removeOnClick(self.mBtnChange)
    self:removeOnClick(self.mBtnGift)
    self:removeOnClick(self.mBtnGame)
    self:removeOnClick(self.mBtnDynamic)
    self:removeOnClick(self.mBtnBigHostel)
    self:removeOnClick(self.mBtnBigHostelSwitch)
    self:removeOnClick(self.mBtnBigHostelExit)

    self:removeOnClick(self.mBtnShopLimitGift)
    self:removeOnClick(self.mBtnDownLoad, self.onOpenSubDownLoadHandler)

end

-- 需要处理图片
function updateHarImg(self)
    if (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) then
        local timeActImg = self.mBtnTimeAct:GetComponent(ty.AutoRefImage)
        --timeActImg:SetImg(UrlManager:getPackPath("mainui/mainui_timeAct_3_har.png"))
        timeActImg:SetImg(UrlManager:getBgPath("billboard/billboard_bg_3018_har.png"))
    end
end

function clickActivityHandler(self)
    self:resFirstShow()
end

-- 打开限时商店礼包界面
function onOpenLimitShopHandler(self, args)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.ShopLimitGift })
end

-- 打开玩家信息面板
function onClickHeadHandler(self, args)
    self:resFirstShow()
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_PANEL)
end

-- 聊天面板
function onOpenChatHandler(self)
    self:resFirstShow()
    GameDispatcher:dispatchEvent(EventName.OPEN_CHAT_PANEL, self.mCurrChatChannel)
end

-- 打开看板娘送礼
function onOpenGiftHandler(self)
    self:showUIEffect(funcopen.FuncOpenConst.FUNC_ID_FAVORABLE, function()
        self:resFirstShow()
        local showId = role.RoleManager:getRoleVo():getShowBoardHeroId()
        local oldVo = hero.HeroManager:getHeroVo(showId)
        if (oldVo:checkIsPreData()) then
            oldVo = hero.HeroManager:getHeroVo(showId)
        end
        favorable.FavorableManager:setOldHeroVo(oldVo)
        hero.HeroManager:setPanelShowHeroId(showId)
        GameDispatcher:dispatchEvent(EventName.OPEN_FAVORABLE_PANEL)
    end)
end

function onShowBoardHeroChangeHandler(self)
    self:updateSpineHitBox()
end

-- 进入大宿舍
function onOpenBigHostelHandler(self)
    local showId = role.RoleManager:getRoleVo():getShowBoardHeroId()
    local heroVo = hero.HeroManager:getHeroVo(showId)
    local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroVo.tid)

    GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENE, { model_id = heroVo:getHostelModel(), heroConfigVo = heroConfigVo, main_type = BigHostelConst.SceneUI_Type.MIANUI })

    self:onShowBoardHeroChangeHandler()
end

-- 大宿舍切换动作
function onOpenBigHostelSwitchHandler(self)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.Switch)
end

-- 大宿舍退出
function onOpenBigHostelExitHandler(self)
    mainui.MainUIManager.isShowBigHostel = false

    GameDispatcher:dispatchEvent(EventName.HIDE_MAIN_UI)
    GameDispatcher:dispatchEvent(EventName.CLOSE_BIGHOSTEL_SCENEUI)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
end

-- 切换动态立绘和模型
function onChangeDynamicPicHandler(self)
    GameDispatcher:dispatchEvent(EventName.MAINUI_SPINE_MODEL_CHANGE)
    self:updateSpineHitBox()
end

function updateSpineHitBox(self)
    local state = hero.HeroInteractManager:getShowBoardUnique()
    if (mainui.MainUIManager:getIsShowDynamic() == 1 and state) or mainui.MainUIManager.isShowBigHostel == true then
        self.mModeHitBox:SetActive(false)
    else
        self.mModeHitBox:SetActive(true)
    end
end

-- -- 测试：剧情
function onOpenGameHandler(self)
    self:resFirstShow()
    GameDispatcher:dispatchEvent(EventName.OPEN_STORY_GAME_PANEL)
end
-- 切换角色
function onOpenShowBoardModelHandler(self)
    self:resFirstShow()
    if mainui.MainUIManager:getIsShowDynamic() == 1 then
        self:onChangeDynamicPicHandler()
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_SHOW_BOARD_HERO_PANEL)
end

-- 设置父容器
function getParentTrans(self)
    return GameView.mainUI
end

-- 计时器
function onTimer(self)
    self:updateDeviceInfo()
    self:updateRedFlag()
    self:updateChatInfo()
    self:updateLimitShopInfo()
    self:updateSupecialTimeInfo()
    self:updateSpecialSupply()
    if self.isShowFirst == false and self.needTime ~= 999 and battleMap.MainMapManager:isStagePass(self.needSmallerStage) == nil and storyTalk.StoryTalkManager:getCurHasStory() == false and guide.GuideManager:getCurHasGuide() == false then
        if gs.PopPanelManager.HasSubPopActive() then
            self:resFirstShow()
        else
            self.isAddTime = self.isAddTime + 1
            if self.isAddTime >= self.needTime then
                self.isShowFirst = true
                self.mCanFistShow:SetActive(true)
            end
        end
    end
end

function updateLimitShopInfo(self)
    self.mBtnShopLimitGift:SetActive(activity.ActitvityExtraManager:getFirstShopLimitEndTime() > 0)
    if activity.ActitvityExtraManager:getFirstShopLimitEndTime() > 0 then
        local deltaTime = activity.ActitvityExtraManager:getFirstShopLimitEndTime()
        self.mShopTime.text = TimeUtil.getHMSByTime(deltaTime)
    end
end

function updateSpecialSupply(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.SpecialSupply) then
        local isOpen = activity.ActivityManager:getActivityVoById(activity.ActivityId.SpecialSupply):isOpen()
        local openNum = 0
        if isOpen then
            for i, v in ipairs(activity.ActivitySpecialSupplyConst:getTabList()) do
                openNum = openNum + 1
            end
        end
        self.mBtnSpecialSupply:SetActive(openNum >= 1)
        return
    end
    if self.mBtnSpecialSupply.activeSelf then
        self.mBtnSpecialSupply:SetActive(false)
    end
end

function updateSupecialTimeInfo(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Supercial) ~= nil then
        self.mTxtSupercialTime.gameObject:SetActive(true)
        self.mBtnSupercial:SetActive(activity.ActivityManager:getActivityVoById(activity.ActivityId.Supercial):isOpen())
        local clientTime = GameManager:getClientTime()
        local remTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Supercial):getEndTime() - clientTime

        local needTime = sysParam.SysParamManager:getValue(SysParamType.SUPERCIAL_NEED_TIME)
        if remTime < needTime then
            self.mTxtSupercialTime.text = TimeUtil.getFormatTimeBySeconds_10(remTime)

        else
            self.mTxtSupercialTime.text = ""
        end
    else
        self.mBtnSupercial:SetActive(false)
    end
end

-- 更新主线信息
function onMainMapUpdateHandler(self)
    self:updateMainMapInfo()
end

-- 战员信息初始化
function onHeroListInitHandler(self)
    self:updateHeroInfo()
    if mainui.MainUIManager:getIsShowDynamic() == 1 then
        self:updateShowSpine()
    end
end

-- 更新战员信息
function onHeroListUpdateHandler(self)
    self:updateHeroInfo()
end

-- 更新信息
function updateView(self)
    self:onUpdatePlayerInfoHandler()
    -- self:onUpdateChatMsgHandler()
    self:updateChatInfo()
    self:updateMainMapInfo()
    self:updateActivityShow()
    self:updateHeroInfo()
    self:updateShowBoard()
    self:onFirstChargeUpdate()
    self:refreshChatBubbleRedState()
    if mainui.MainUIManager:getIsShowDynamic() == 1 then
        self:updateShowSpine()
    end
end

function updateShowBoard(self)
    self.mBtnGift:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FAVORABLE, false))
end

-- 通行证模块显示控制
function updateFashionPermit(self)
    self:getChildGO("mFashionPermit"):SetActive(false)
    local list = activity.ActivityManager:getPermitBillboardList()
    for i, billboardVo in ipairs(list) do
        if billboardVo:isOpenTime() then
            self:getChildGO("mFashionPermit"):SetActive(true)
            if self.mFashionPermitView then
                self.mFashionPermitView:onActivityUpdate()
            end
            break
        end
    end
end

-- 更新个人Hud信息
function onUpdatePlayerInfoHandler(self)
    local roleVo = role.RoleManager:getRoleVo()
    if (roleVo and roleVo:getPlayerName() and roleVo:getPlayerLvl() and roleVo:getPlayerExp() and roleVo:getPlayerMaxExp() and roleVo:getAvatarId()) then
        -- 玩家名
        self.mTxtName.text = roleVo:getPlayerName()
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtName.transform) -- 立即刷新
        self.mTxtLv.text = roleVo:getPlayerLvl()
        self.mTxtId.text = "" .. roleVo.showId
        -- 经验条
        self.mImgProBar.fillAmount = roleVo:getPlayerExp() / roleVo:getPlayerMaxExp()
    end
end

-- 更新聊天信息
function onUpdateChatMsgHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CHAT, false) == false then
        return
    end
    local time = web.__getTime()
    if (not self.mChatTickTime) then
        self.mChatTickTime = time
        self:updateChatInfo()
    else
        local deltaTime = time - self.mChatTickTime
        if (deltaTime > 1) then
            self.mChatTickTime = nil
            self:updateChatInfo()
        end
    end
end

function updateChatInfo(self)
    local chatVo = chat.ChatManager:getNewMsg()
    if (chatVo) then
        if self.mLastChatVo == chatVo then
            return
        end
        self.mLastChatVo = chatVo
        self.mCurrChatChannel = chatVo.channel -- 记录当前聊天显示的聊天频道
        local playerName = chatVo:getSendName()
        if (chatVo.sendId == role.RoleManager:getRoleVo().playerId) then
            playerName = _TT(72102)
        end
        local color = "FFFFFF"
        if chatVo.channel == chat.ChannelType.GUILD then
            color = "28EF37"
        end
        if (chatVo.contentType == chat.ContentType.JUST_TEXT) then
            self.mTextChatContent.text = HtmlUtil:color(playerName .. "：" .. chatVo.content, color)
        else
            self.mTextChatContent.text = HtmlUtil:color(_TT(72103, playerName), color)
        end
    else
        self.mTextChatContent.text = ""
    end
end

-- 更新设备信息（时间、电量、wifi）
function updateDeviceInfo(self)
    self.mTxtClock.text = gs.DeviceInfoMgr:GetDateTime()
    local battery = gs.DeviceInfoMgr:GetBatteryLevel() == -1 and 1 or gs.DeviceInfoMgr:GetBatteryLevel()
    gs.TransQuick:ScaleX(self.mImgPower, battery)
    if gs.DeviceInfoMgr:GetIsWifi() == 1 then
        self.mImgWifi:SetImg(UrlManager:getPackPath("mainui/mainui_3.png"), true)
    else
        self.mImgWifi:SetImg(UrlManager:getPackPath("mainui/mainui_28.png"), true)
    end
end

-- 更新主线进度
function updateMainMapInfo(self)
    local curStageId = battleMap.MainMapManager:getMainMapShowStage()
    local stageVo = battleMap.MainMapManager:getStageVo(curStageId)
    if (stageVo) then
        self.mTxtStageName.text = stageVo.indexName -- .. " | "
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtStageName.transform) -- 立即刷新
    end
    local chapterVo = battleMap.MainMapManager:getChapterVoByStageId(curStageId)
    if (chapterVo) then
        self.mTxtChapterName.text = chapterVo:getName()
    end
end

-- 更新战员收集率
function updateHeroInfo(self)
    local allCount = hero.HeroManager:getHeroListNum()
    local heroCount = 0
    if role.RoleManager:getPersonalInfoList() then
        heroCount = #hero.HeroManager:getHeroList(false)
    end
    self.mTxtHeroPro.text = math.ceil(heroCount / allCount * 100) .. "%"
    self.mImgHeroProBar.fillAmount = heroCount / allCount
end

function refreshChatBubbleRedState(self)
    self.ChatRedPoint:SetActive(decorate.DecorateManager:getChatBubbleRedState())
end

-- 更新主UI红点信息
function updateRedFlag(self, isActive)
    if not mainui.MainUIManager.isRedFlagUdpate and not isActive then
        return
    end
    mainui.MainUIManager.isRedFlagUdpate = false

    for funcId, state in pairs(mainui.MainUIManager:getRedFlag()) do
        local iconDic = mainui.MainUIManager:getFuncIcon(funcId)
        if not iconDic then
            logWarn("funcId " .. funcId .. " 未注册主界面按钮，仅提醒是否出错")
        else

            local icon = iconDic.icon
            local type = iconDic.type
            local ignore = iconDic.ignore
            if state then
                local _x = icon.transform.rect.size.x / 8
                local _y = icon.transform.rect.size.y / 8
                if type == MAIN_UI_FUNC_TYPE.LEFT_FUNC then
                    --if funcId == funcopen.FuncOpenConst.FUNC_ID_ACTIVITY or funcId == funcopen.FuncOpenConst.FUNC_ID_NOVICE_ACTIVITY or funcId == funcopen.FuncOpenConst.FUNC_ID_HOME_WELFARE then
                    _x = 18
                    _y = 13
                    -- else
                    --     _x = 16
                    --     _y = 10
                    -- end
                elseif type == MAIN_UI_FUNC_TYPE.RIGHT_DOWN_FUNC then
                    if funcId == funcopen.FuncOpenConst.FUNC_ID_SHOPPING then
                        _x = 56
                        _y = 3.5
                    else
                        _x = (icon.transform.rect.size.x / 2) + 2
                        _y = icon.transform.rect.size.y / 8
                    end
                elseif type == MAIN_UI_FUNC_TYPE.RIGHT_DETAIL then
                    _x = (icon.transform.rect.size.x / 5) - 3
                    if (funcId == funcopen.FuncOpenConst.FUNC_ID_RECRUIT) then
                        _y = icon.transform.rect.size.y / 5
                    elseif funcId == funcopen.FuncOpenConst.FUNC_ID_WARSHIP then
                        _y = 21
                    elseif funcId == funcopen.FuncOpenConst.FUNC_ID_MAIN_ACTIVITY then
                        _x = -55.6
                        _y = 0
                        -- elseif funcId == funcopen.FuncOpenConst.FUNC_ID_HERO then
                    else
                        _x = 6
                        _y = icon.transform.rect.size.y / 5 - 3
                    end
                elseif type == MAIN_UI_FUNC_TYPE.LEFT_TOP_HEAD then
                    _x = -58
                    _y = 25
                elseif type == MAIN_UI_FUNC_TYPE.LEFT_ACTIVTY then
                    --cusLog("=====================")
                    _x = icon.transform.rect.size.x / 2 - 6
                    _y = icon.transform.rect.size.y / 2 - 6
                end
                if not ignore then
                    RedPointManager:add(icon.transform, nil, _x, _y)
                end

                local redAnim = icon:GetComponent(ty.Animator)
                if redAnim and not gs.GoUtil.IsCompNull(redAnim) then
                    redAnim:SetTrigger("show")
                end
            else
                RedPointManager:remove(icon.transform)

                local redAnim = icon:GetComponent(ty.Animator)
                if redAnim and not gs.GoUtil.IsCompNull(redAnim) then
                    redAnim:SetTrigger("exit")
                end
            end
        end

        -- 策划需求，轮播不显示红点
        -- if self.mActivityView then
        --     self.mActivityView:updateBubble(funcId, state)
        -- end
        if self.mFashionPermitView then
            self.mFashionPermitView:updateBubble(funcId, state)
        end
    end
end

-- 注册icon
function registerIcon(self, type, obj, funcOpenId, uicode, showImg, showEnterEff, ignore)
    if type == MAIN_UI_FUNC_TYPE.LEFT_FUNC then
        -- 左侧系统按钮
        table.insert(self.mSysList, { icon = obj, funcOpenId = funcOpenId, uicode = uicode })
    end
    if type == MAIN_UI_FUNC_TYPE.RIGHT_DOWN_FUNC then
        -- 右下功能按钮
        table.insert(self.mFuncList, { icon = obj, funcOpenId = funcOpenId, uicode = uicode, showImg = showImg })
    end
    if type == MAIN_UI_FUNC_TYPE.RIGHT_DETAIL then
        -- 右侧玩法按钮
        table.insert(self.mDetailList, { icon = obj, funcOpenId = funcOpenId, uicode = uicode })
    end
    if type == MAIN_UI_FUNC_TYPE.LEFT_ACTIVTY then
        -- 右侧玩法按钮
        table.insert(self.mActivityList, { icon = obj, funcOpenId = funcOpenId, uicode = uicode })
    end
    -- 注册点击事件（登记uicode）
    self:addOnClick(obj, function()
        self:resFirstShow()

        local function showView()
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = uicode })
        end

        if showEnterEff then
            self:showUIEffect(funcOpenId, showView)
        else
            showView()
        end
    end)

    -- 注册按钮缓存，给外部使用
    mainui.MainUIManager:registerIcon(funcOpenId, type, obj, ignore)

    -- 注册引导
    self:setGuideTrans("guide_main_ui_" .. funcOpenId, obj.transform)
end

-- 注册限时活动
function registerActivity(self, obj, funcOpenId, mgr)
    table.insert(self.mTimeActList, { icon = obj, funcOpenId = funcOpenId, mgr = mgr })
    -- if not mgr.registerActivity then
    --     logError(string.format("功能开放%s的限时活动无registerActivity方法", funcOpenId))
    --     return
    -- end
    -- mgr:registerActivity(self.updateActivityShow, self)
end
-- 更新限时活动状态
function updateActivityShow(self, funcOpenId)
    for i, v in ipairs(self.mTimeActList) do
        if not funcOpenId or v.funcOpenId == funcOpenId then
            local isOpen = activity.ActivityManager:checkIsOpenByFuncId(v.funcOpenId)
            v.icon:SetActive(isOpen)
            -- if isOpen then
            --     self:updateDetailIconFunc(v.icon, v.funcOpenId)
            -- end
        end
    end
    self:updatePayActivityIcon()

end

-- 活动开启通知
function onActivityOpenHandler(self, args)
    for i, v in ipairs(args.openList) do
        self:updateActivityShow(v.funcId)
    end
    self:updateFashionPermit()
end

-- 活动关闭更新（关闭活动由本方法实现，因模块内关闭服务器不会再做消息更新）
function onActivityCloseHandler(self, args)
    for i, v in ipairs(args.closeList) do
        local vo = activity.ActivityManager:getCloseActivity(v)
        if vo then
            self:updateActivityShow(vo.funcId)
        end
    end
    self:updateFashionPermit()
end

-- 新手活动更新状态
function onNoviceActivityUpdate(self)
    local isOpen = activity.ActivityManager:getNoviceActivityIsOpen()
    isOpen = isOpen or activity.ActivityManager:getNoviceActivitySsrIsOpen()
    isOpen = isOpen or activity.ActivityManager:getNoviceActivityRechargeIsOpen()
    self.mBtnNovice:SetActive(isOpen)
end

-- 回归活动状态
function onRerturnedActivityUpdate(self)
    local isOpen = returned.ReturnedManager:checkIsOpen()
    self.mBtnReturned:SetActive(isOpen)
end

-- 首充更新状态
function onFirstChargeUpdate(self)
    local isOpen = (not firstCharge.FirstChargeManager:getIsReciveOver()) and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FIRSTCHARGE, false)
    self.mBtnFirstCharge:SetActive(isOpen)
end

-- 功能开放
function onFuncOpenUpdateHandler(self)
    self:updateUIBtn()
end

-- 更新按钮状态
function updateUIBtn(self)
    for i, v in ipairs(self.mSysList) do
        local icon = v.icon
        local funcOpenId = v.funcOpenId
        local uicode = v.uicode

        local isOpen = funcopen.FuncOpenManager:isOpen(funcOpenId)
        if isOpen then
            -- icon:GetComponent(ty.CanvasGroup).alpha = 1
            icon.gameObject:SetActive(true)
        else
            -- icon:GetComponent(ty.CanvasGroup).alpha = 0.7
            icon.gameObject:SetActive(false)
        end
    end

    local openNum = 0
    for i, v in ipairs(self.mFuncList) do
        local icon = v.icon
        local showImg = v.showImg
        local funcOpenId = v.funcOpenId
        local uicode = v.uicode

        if not funcopen.FuncOpenManager:isOpen(funcOpenId) then
            showImg:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("9b9b9bff")
        else
            showImg:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("ffffffff")
        end
        local imgLock = icon.transform:Find("mImgLock")
        if imgLock then
            imgLock.gameObject:SetActive(funcopen.FuncOpenManager:isOpen(funcOpenId) == false)
        end

        self:updateFuncIcon(icon, funcOpenId)

        if funcopen.FuncOpenManager:isOpen(funcOpenId) and funcOpenId ~= funcopen.FuncOpenConst.FUNC_ID_SHOPPING then
            openNum = openNum + 1
        end
    end

    gs.TransQuick:SizeDelta01(self:getChildTrans("mImgFunBg"), 415 + 112.5 * openNum)

    for i, v in ipairs(self.mDetailList) do
        local icon = v.icon
        local funcOpenId = v.funcOpenId
        local uicode = v.uicode

        self:updateDetailIconFunc(icon, funcOpenId)
        -- local imgLock = icon.transform:Find("mImgLock")
        -- if imgLock then
        --     imgLock.gameObject:SetActive(funcopen.FuncOpenManager:isOpen(funcOpenId) == false)
        -- end
    end

    self:updateActivityShow()
    self:updateShopAdvertisingInfo()
    self:onNoviceActivityUpdate()
    self:onRerturnedActivityUpdate()
    self:updateFashionPermit()
    self:updateSpecialSupply()
end
--商店直购礼包广告标签
function updateShopAdvertisingInfo(self)
    local isShow = purchase.DirectBuyManager:getIsShowOneAdvertising()
    self.mImgShopAdvertising:SetActive(isShow)
    if self.mTxtShopAdvertising.text ~= _TT(72114) then
        self.mTxtShopAdvertising.text = _TT(72114)
    end
end

-- 付费活动入口管理
function updatePayActivityIcon(self)
    local isShowOne = false --显示最前面的一个
    for i, data in ipairs(mainui.MainUIManager.activityFuncList) do
        local funcOpenId = data.funcId
        local mgr = data.mgr
        if not mgr or not mgr.checkShowState then
            logError("====================运营活动未正确注册，功能id：" .. funcOpenId)
            return
        end
        local iconData = mainui.MainUIManager:getFuncIcon(funcOpenId)
        if iconData then
            if mgr.checkShowState and mgr:checkShowState() and not isShowOne then
                iconData.icon.gameObject:SetActive(true)
                isShowOne = true
            else
                iconData.icon.gameObject:SetActive(false)
            end
        end
    end
end

-- 更新玩法按钮的功能开放状态
function updateDetailIconFunc(self, icon, funcOpenId)
    local isOpen, lv = funcopen.FuncOpenManager:isOpen(funcOpenId)
    -- if not isOpen and lv >= 999 then
    if not isOpen then
        icon:SetActive(false)
    else
        icon:SetActive(true)
    end
    local imgLock = icon.transform:Find("mImgLock")
    if imgLock then
        imgLock.gameObject:SetActive(isOpen == false)
    end
end

-- 更新功能按钮开放状态
function updateFuncIcon(self, icon, funcOpenId)
    local isOpen, lv = funcopen.FuncOpenManager:isOpen(funcOpenId)

    if funcOpenId ~= funcopen.FuncOpenConst.FUNC_ID_SHOPPING then
        if not isOpen then
            icon:SetActive(false)
        else
            icon:SetActive(true)
        end
    end
end

-- 主界面交互cv文本(目前只有首次进入主界面才会出现)
function onShowHeroInTeractTextOnlyHandler(self, textContent)
    if textContent and textContent ~= "" then
        if not self.isShowMutual then
            self.isShowMutual = true
            self:updateDynamicLable()
            self.mGroupMutual:SetActive(true)

            local state = hero.HeroInteractManager:getShowBoardHeroDynamic()
            self.mBtnDynamic:SetActive(state)

            self:updateBigHostelBtn()

            self.mTxtTalk.text = textContent

            if self.closeMutualTween then
                self.closeMutualTween:Kill()
                self.closeMutualTween = nil
            end
            self.openMutualTween = TweenFactory:canvasGroupAlphaTo(self.mGroupMutual:GetComponent(ty.CanvasGroup), 0, 1, 0.3)
        end
    end
end

function onShowHeroInTeractHandler(self, args)
    self:onClickModelHandler()
end

-- 点击模型热区
function onClickModelHandler(self)
    self:resFirstShow()
    if not mainui.MainUIManager:isInteractOver() then
        self.isShowMutual = true
        self:showInteractInfo()
    end
end

function showInteractInfo(self, cusInteractId)
    GameDispatcher:dispatchEvent(EventName.PLAY_MAIN_MODEL_ACT)
end

function __modelPlayed(self, interactData)
    if interactData then
        local cvData = AudioManager:getCVData(interactData.cv_id)
        if cvData and cvData.lines ~= "" then
            self.mTxtTalk.text = cvData.lines
            self.mImgTalkBg:SetActive(true)
            self.isShowMutual = true
        else
            self.mTxtTalk.text = ""
            self.mImgTalkBg:SetActive(false)
        end
    else
        self.mTxtTalk.text = ""
        self.mImgTalkBg:SetActive(false)
    end
    self:updateDynamicLable()
    self.mGroupMutual:SetActive(true)

    local state = hero.HeroInteractManager:getShowBoardHeroDynamic()
    self.mBtnDynamic:SetActive(state)

    self:updateBigHostelBtn()

    if self.closeMutualTween then
        self.closeMutualTween:Kill()
        self.closeMutualTween = nil
    end
    self.openMutualTween = TweenFactory:canvasGroupAlphaTo(self.mGroupMutual:GetComponent(ty.CanvasGroup), 0, 1, 0.3)
end

-- 更新切换立绘按钮文本
function updateDynamicLable(self)
    local state = mainui.MainUIManager:getIsShowDynamic()
    if state == 0 then
        self:setBtnLabel(self.mBtnDynamic, nil, "立绘")
    else
        self:setBtnLabel(self.mBtnDynamic, nil, "模型")
    end
end

-- 更新大宿舍按钮文本
function updateBigHostelBtn(self)
    self:setBtnLabel(self.mBtnBigHostel, 84514, "互动")

    local showId = role.RoleManager:getRoleVo():getShowBoardHeroId()
    local heroVo = hero.HeroManager:getHeroVo(showId)

    local sceneData = purchase.FashionShopManager:getFashionSceneDataByModelId(heroVo.tid, heroVo:getHostelModel())
    self.mBtnBigHostel:SetActive(sceneData ~= nil)
end

-- 关闭cv内容
function closeMutual(self)
    if self.isShowMutual then

        if self.openMutualTween then
            self.openMutualTween:Kill()
            self.openMutualTween = nil
        end
        self.closeMutualTween = TweenFactory:canvasGroupAlphaTo(self.mGroupMutual:GetComponent(ty.CanvasGroup), 1, 0, 0.3, nil, function()
            self.isShowMutual = false
            self.mGroupMutual:SetActive(false)
        end)
    end
end

-- 设置货币栏
function setMoneyBar(self)
    if (not self.m_moneyBar) then
        self.m_moneyBar = MoneyBar.new()
    end
    if (self.m_moneyBar) then
        self.m_moneyBar:setData(self.m_moneyBarTrans)
        self.m_moneyBar:active()
    end
end

-- 重置货币栏
function resetMoneyBar(self)
    if (self.m_moneyBar) then
        self.m_moneyBar:resetData()
        self.m_moneyBar:deActive()
    end
end

-- 关闭ui
function onHideUIHandler(self)
    self:resFirstShow()


    local visible = not self.UIGroup.activeSelf
    if GameManager.IS_DEBUG then
        GameManager.HIDE_DEBUG_INFO = true
        gm.GmManager:dispatchEvent(gm.GmManager.EVENT_VISIBLE_CHANGE, visible)
        debugFrames.FPS:dispatchEvent(debugFrames.FPS.EVENT_VISIBLE_CHANGE, visible)
    end

    if mainui.MainUIManager.isShowBigHostel then
        GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENEUI, { main_type = BigHostelConst.SceneUI_Type.MIANUI })
        return
    end
    if mainui.MainUIManager:getIsShowDynamic() == 1 then
        -- local imgUrl = visible and UrlManager:getPackPath("mainui/mainui_6.png") or UrlManager:getPackPath("mainui/mainui_7.png")
        -- self.mImgHideUI:SetImg(imgUrl, true)
        self.UIGroup:SetActive(false)
        self.mBtnShowUI:SetActive(false)
        self.mBtnShowUI2:SetActive(true)

        if self.mAlphaTween then
            self.mAlphaTween:Kill()
        end
        self.mAlphaTween = TweenFactory:canvasGroupAlphaTo(self.mBtnShowUI2:GetComponent(ty.CanvasGroup), 1, 0, 3)

    else
        -- local imgUrl = visible and UrlManager:getPackPath("mainui/mainui_6.png") or UrlManager:getPackPath("mainui/mainui_7.png")
        -- self.mImgHideUI:SetImg(imgUrl, true)
        self.UIGroup:SetActive(false)
        self.mBtnShowUI:SetActive(true)
        self.mBtnShowUI2:SetActive(false)
    end

end

-- 打开UI
function onShowUIHandler(self)
    if self.mAlphaTween then
        self.mAlphaTween:Kill()
    end
    self:resFirstShow()
    -- local visible = not self.UIGroup.activeSelf
    self.UIGroup:SetActive(true)
    self.mBtnShowUI:SetActive(false)
    self.mBtnShowUI2:SetActive(false)
end

-- 更新显示模型或spine
function updateShowSpine(self)
    -- self:clearSpine()
    -- local modelId = hero.HeroInteractManager:getShowBoardHeroModelId()
    -- if not modelId then
    --     return
    -- end
    -- self.mSpineGo = gs.ResMgr:LoadGO(string.format("arts/fx/spine/%s/spine_%s.prefab", modelId, modelId))
    -- gs.TransQuick:SetParentOrg(self.mSpineGo.transform, self.mGroupSpine)
end

function clearSpine(self)
    if self.mSpineGo then
        gs.GameObject.Destroy(self.mSpineGo)
        self.mSpineGo = nil
    end
end

function destroy(self)
    super.destroy(self)
    self:removeAllBubble()
    if self.mActivityView then
        self.mActivityView:destroy()
        self.mActivityView = nil
    end
    if self.mFashionPermitView then
        self.mFashionPermitView:destroy()
        self.mFashionPermitView = nil
    end
    if self.mNoteView then
        self.mNoteView:destroy()
        self.mNoteView = nil
    end
end

function removeAllBubble(self)
    for funcId, state in pairs(mainui.MainUIManager:getRedFlag()) do
        local iconDic = mainui.MainUIManager:getFuncIcon(funcId)
        if iconDic then
            local icon = iconDic.icon
            RedPointManager:remove(icon.transform)
        end
    end
end

-- UI打开动效
function showUIEffect(self, funcOpenId, callBack)
    local function removeEff()
        gs.GOPoolMgr:CancelAsyc(self.effectSn)
        if self.effectGo then
            if (not gs.GoUtil.IsGoNull(self.effectGo)) then
                gs.GOPoolMgr:Recover(self.effectGo, UrlManager:getUIPrefabPath("transition/TransitionPanel.prefab"))
            end
            self.effectGo = nil
        end
        self.enterEffSn1 = nil
        self.enterEffSn2 = nil
    end

    local function loadAysnCall(effectGo)
        self.effectGo = effectGo
        gs.TransQuick:SetParentOrg(effectGo.transform, GameView.subPop)
    end

    LoopManager:clearTimeout(self.enterEffSn1)
    LoopManager:clearTimeout(self.enterEffSn2)
    removeEff()

    -- if not showEnterEff and StorageUtil:getString0('login_show_ui_effect') ~= "1" and funcopen.FuncOpenManager:isOpen(funcOpenId, false) == true then
    if funcopen.FuncOpenManager:isOpen(funcOpenId, false) == true then
        self.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIPrefabPath("transition/TransitionPanel.prefab"), loadAysnCall)

        self.enterEffSn1 = LoopManager:setTimeout(0.9, nil, callBack)
        self.enterEffSn2 = LoopManager:setTimeout(1.3, nil, removeEff)
    else
        callBack()
    end
end

function onSubDownLoadSuccessUpdateHandler(self)
    self:updateSubDownLoadVisible()
end

function onSubDownLoadFailUpdateHandler(self)
    self:updateSubDownLoadVisible()
end

function updateSubDownLoadVisible(self)
    if (web.WebManager:isOfficialApp()) then
        self.mGroupDownLoad:SetActive(false)
    else
        if (subPack.SubDownLoadController:isExistNeedUpdate()) then
            self.mGroupDownLoad:SetActive(true)
        else
            if (subPack.SubDownLoadManager:isDownGiftHadRec()) then
                self.mGroupDownLoad:SetActive(false)
            else
                self.mGroupDownLoad:SetActive(true)
            end
        end
    end
end

function onOpenSubDownLoadHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SUB_DOWNLOAD_PANEL)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(72102):"我"
语言包: _TT(72101):"当前"
]]