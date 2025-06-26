--[[****************************************************************************
Brief  :正式登录界面
Author :zzz
****************************************************************************
]]
module('login.LoginView', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('login/LoginView.prefab')
-- 是否异步
IsAsyn = true
destroyTime = 0 -- 自动销毁时间-1默认
escapeClose = 0 -- 是否能通过esc关闭窗口

--构造函数
function ctor(self)
    gs.LifeCyclelManager.Instance:AddRegister("LoginView", self.onCSharpLifeCycleHandler, self)

    self.panelName = self.__cname
    self.m_sn = SnMgr:getSn()
    self:initData()
    self:loadAsset()
    self:setUICode(LinkCode.Login)
end

function onCSharpLifeCycleHandler(self, lifeCycleName)
    if (lifeCycleName == "Start") then
        web.WebController:reqReportStep(web.REPORT_STEP.LOAD_LOGIN_VIEW_SUC)
        gs.LifeCyclelManager.Instance:RemoveRegister("LoginView")

        local function callFun()
            CS.Lylibs.Splash.Instance:CloseVisible()

            self:__updateBgPlayState(StorageUtil:getBool0('IsUpdateResImgBg'))
            self:__updateBgAudioState(StorageUtil:getBool0('IsUpdateResAudioMute'))
            if (updateRes) then
                -- 关闭更新模块的加载界面
                updateRes.UpdateResManager:dispatchEvent(updateRes.UpdateResManager.CLOSE_LOADING_VIEW, {})
            end
            -- 黑屏过渡
            if self.panelType == 1 and self.isScreensave == 1 then
                UIFactory:closeScreenSaver()
            end

            web.WebController:reqReportStep(web.REPORT_STEP.SHOW_LOGIN_VIEW_SUC)
            self:setStartFinish(true)
        end

        if (BoardShower:getBoardState() == BoardShower.BoardState.None) then
            BoardShower:showBoard(BoardShower:getBoardImgSource(), BoardShower:getBoardImgAudioSource(), BoardShower:getBoardVideoSource(), false, nil,
            function()
                callFun()
            end)
        else
            callFun()
        end
    end
end

function setStartFinish(self, isFinish)
    self.mIsStartFinish = isFinish
    self:checkCallFun()
end

function setCallFun(self, callFun)
    self.mCallFun = callFun
    self:checkCallFun()
end

function checkCallFun(self)
    if (self.mCallFun and self.mIsStartFinish) then
        self.mCallFun()
    end
end

-- 初始化数据
function initData(self)
    self.mIsImgBg = false
    self.mIsAudioMute = false
    self.mIsAllowPolicy = false
    self.mHasOpenBulletin = false
    self.mIsSdkLoginInterrupt = false
end

-- 适应全面屏，刘海缩进
function setAdapta(self)
    local notchHeight = ScreenUtil:getNotchHeight()
    if notchHeight ~= nil then
        local minV = self:getAdaptaTrans().offsetMin;
        minV.x = notchHeight;
        self:getAdaptaTrans().offsetMin = minV;

        local maxV = self:getAdaptaTrans().offsetMax;
        maxV.x = -notchHeight;
        self:getAdaptaTrans().offsetMax = maxV;
    end
end

-- 刘海适配缩放节点
function getAdaptaTrans(self)
    return self.mGroupAdapt
end

--初始化UI
function configUI(self)
    self.mGroupAdapt = self:getChildTrans('GroupAdapt')
    self:getChildGO('mImgBg'):SetActive(false)

    self.m_imgRoll = self:getChildGO('ImgRoll'):GetComponent(ty.RectTransform)
    self.m_groupContent = self:getChildGO('GroupContent')
    self.m_btnLogin = self:getChildGO('BtnLogin')
    self.mBtnSwitch = self:getChildGO('BtnSwitch')
    self.mBtnSwitch:SetActive(not BoardShower:isForceBoardImg())
    self.mImgSwitch = self:getChildGO('mImgIconSwitch'):GetComponent(ty.AutoRefImage)
    self.mBtnAudio = self:getChildGO('BtnAudio')
    self.mImgAudio = self:getChildGO('mImgIconAudio'):GetComponent(ty.AutoRefImage)
    self.m_btnCleanAssets = self:getChildGO('BtnCleanAssets')
    self.m_btnCleanStorage = self:getChildGO('BtnCleanStorage')
    self.m_btnNotice = self:getChildGO('BtnNotice')
    self.m_textNotice = self:getChildGO('TextNotice'):GetComponent(ty.Text)
    self.m_textCleanAssets = self:getChildGO('TextCleanAssets'):GetComponent(ty.Text)
    self.m_textCleanStorage = self:getChildGO('TextCleanStorage'):GetComponent(ty.Text)
    self.m_textAccountName = self:getChildGO('TextAccountName'):GetComponent(ty.Text)

    self.m_btnDestroyAccount = self:getChildGO('mBtnDestroyAccount')
    self.m_btnQuit = self:getChildGO('mBtnQuit')
    self.m_btnAgeTip = self:getChildGO('BtnAgeTip')

    -- 隐私协议政策相关
    self.mGroupPolicyAgreement = self:getChildGO('GroupPolicyAgreement')
    self.mRectGroupPolicyAgreement = self:getChildGO('GroupPolicyAgreement'):GetComponent(ty.RectTransform)
    self.mBtnPolicyAgreement = self:getChildGO('mBtnPolicyAgreement')
    self.mGoPolicySelect = self:getChildGO('mImgPolicySelect')
    self.mTextPolicyAgreement = self:getChildGO("mTextPolicyAgreement"):GetComponent(ty.TMP_Text)
    self.mTextPolicyAgreementLink = self:getChildGO("mTextPolicyAgreement"):GetComponent(ty.TextMeshProLink)
    self.mTextPolicyAgreementLink:SetEventCall(self.commonUrlLinkData)
    self.mTxtTip = self:getChildGO('TextTip'):GetComponent(ty.Text)

    -- 不显示用户名
    self.m_textAccountName.text = ""

    -- local notchHeight = gs.DeviceInfoMgr.GetNotchHeigt()
    -- local noticeRect = self.m_btnNotice:GetComponent(ty.RectTransform)
    -- noticeRect.offsetMin = gs.Vector2(-62 - notchHeight, -63)
    -- gs.TransQuick:SizeDelta(noticeRect, 43, 43)

    -- local cleanRect = self.m_btnCleanAssets:GetComponent(ty.RectTransform)
    -- cleanRect.offsetMin = gs.Vector2(-62 - notchHeight, -150)
    -- gs.TransQuick:SizeDelta(cleanRect, 43, 43)

    self.m_btnGetUniqueId = self:getChildGO('BtnGetUniqueId')
    self:getChildGO('TextUniqueId'):GetComponent(ty.Text).text = sdk.SdkManager:getUniqueId()
    self.m_btnGetUniqueId:SetActive(web.WebManager:isShowUniqueId())
    
    -- self.mBtnAudio:SetActive(false)
    self.m_btnDestroyAccount:SetActive(sdk.SdkManager:getIsChannelDouYin())
    self.m_btnQuit:SetActive(gs.Application.platform == gs.RuntimePlatform.WindowsPlayer)

    self.mTxtClientVersion = self:getChildGO('TextClientVersion'):GetComponent(ty.Text)
    self.mTxtServerVersion = self:getChildGO('TextServerVersion'):GetComponent(ty.Text)
end

function initViewText(self)
    self:setBtnLabel(self.m_btnNotice, 52010, "公告")
    self:setBtnLabel(self.mBtnAudio, 62060, "音乐")
    self:setBtnLabel(self.m_btnCleanAssets, 71, "修复")
    self:setBtnLabel(self.mBtnSwitch, 1196, "切换")

    self:setBtnLabel(self.m_btnDestroyAccount, 0, "销号")
    self:setBtnLabel(self.m_btnQuit, 44219, "退出")
    -- self.m_textNotice.text = _TT(52010)
    -- self.m_textCleanAssets.text = '清除资源'
    -- self.m_textCleanStorage.text = '清除服务器记录'
    
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if(channelId == sdk.AndroidChannelId.QIANYOU)then
        self.mTextPolicyAgreement.text = _TT(284)
        gs.TransQuick:UIPosX(self.mRectGroupPolicyAgreement, 120)
        self.mTxtTip.text = _TT(345)
    elseif(channelId == sdk.AndroidChannelId.DANDANYOU)then
        self.mTextPolicyAgreement.text = _TT(342)
        gs.TransQuick:UIPosX(self.mRectGroupPolicyAgreement, 120)
        self.mTxtTip.text = _TT(344)
    elseif(channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2)then
        self.mTextPolicyAgreement.text = _TT(343)
        gs.TransQuick:UIPosX(self.mRectGroupPolicyAgreement, 120)
        self.mTxtTip.text = _TT(344)
    elseif(channelId == sdk.AndroidChannelId.QUICK3)then
        self.mTextPolicyAgreement.text = _TT(285)
        gs.TransQuick:UIPosX(self.mRectGroupPolicyAgreement, 120)
        self.mTxtTip.text = _TT(344)
    else
        self.mTextPolicyAgreement.text = _TT(283)
        gs.TransQuick:UIPosX(self.mRectGroupPolicyAgreement, 0)
        self.mTxtTip.text = _TT(268)
    end    
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.m_btnNotice, self.__onClickNoticeHandler)
    self:addUIEvent(self.m_btnLogin, self.__onClickLoginHandler, UrlManager:getUIBaseSoundPath("ui_basic_load.prefab"))
    self:addUIEvent(self.m_btnDestroyAccount, self.__onClickDestroyAccountHandler)
    self:addUIEvent(self.m_btnQuit, self.__onClickQuitHandler)
    self:addUIEvent(self.m_btnAgeTip, self.__onClickAgeTipHandler)
    self:addUIEvent(self.mBtnSwitch, self.__onClickSwitchHandler)
    self:addUIEvent(self.mBtnAudio, self.__onClickBgAudioHandler)
    self:addUIEvent(self.m_btnCleanAssets, self.__onClickCleanAssetsHandler)
    self:addUIEvent(self.m_btnCleanStorage, self.__onClickCleanStorageHandler)
    self:addUIEvent(self.m_btnGetUniqueId, self.__onClickGetUniqueIdHandler)
    self:addUIEvent(self.mBtnPolicyAgreement, self.__onClickPolicyAgreementHandler)
end

-- 读取页面对应的音乐id
function getMusicId(self)
    return 0
end

--激活
function active(self, args)
    super.active(self, args)
    self:updateClientVersion()
    self:updateServerVersion()
    
    login.LoginManager:setLoginViewVisible(true)
    web.WebManager:addEventListener(web.WebManager.SDK_ACCOUNT_LOGIN_INTERRUPT, self.__onSdkLoginInterruptHandler, self)
    web.WebManager:addEventListener(web.WebManager.GAIN_ALL_DATA_FINISH, self.__onGainAllDataFinishHandler, self)
    -- 新动效只留新做的denglu2
    -- self:addEffect("fx_ui_common_denglu1", self.m_groupContent.transform, 0, -125, nil)
    -- self:addEffect("fx_ui_common_denglu2", self.m_groupContent.transform, 0, 120, nil)
    -- self:addEffect("fx_ui_common_denglu3", self.m_groupContent.transform, 0, 180, nil)
    -- self:__updateView()
    self.m_groupContent:SetActive(false)
    self:__showRoll()
end

--非激活
function deActive(self)
    super.deActive(self)
    login.LoginManager:setLoginViewVisible(false)
    web.WebManager:removeEventListener(web.WebManager.SDK_ACCOUNT_LOGIN_INTERRUPT, self.__onSdkLoginInterruptHandler, self)
    web.WebManager:removeEventListener(web.WebManager.GAIN_ALL_DATA_FINISH, self.__onGainAllDataFinishHandler, self)

    self:removeTimeOutCheck()
    self:__hideRoll()
    BoardShower:hideBoard()
end

function __onClickSwitchHandler(self)
    self:__updateBgPlayState(not self.mIsImgBg)
    self:__updateBgAudioState(self.mIsAudioMute)
end

function __updateBgPlayState(self, isImgVideo)
    self.mIsImgBg = isImgVideo
    if (self.mIsImgBg) then
        self.mImgSwitch:SetImg(UrlManager:getPackPath("updateRes/update_res_7.png"), true)
    else
        self.mImgSwitch:SetImg(UrlManager:getPackPath("updateRes/update_res_6.png"), true)
    end
    StorageUtil:saveBool0('IsUpdateResImgBg', isImgVideo)
    if(self.mIsImgBg ~= (BoardShower:getBoardState() == BoardShower.BoardState.ImgBg))then
        BoardShower:onClickSwitchModeHandler()
    end
end

-- 声音控制
function __onClickBgAudioHandler(self)
    self:__updateBgAudioState(not self.mIsAudioMute)
end

function __updateBgAudioState(self, isMute)
    self.mIsAudioMute = isMute
    if (self.mIsAudioMute) then
        -- 获取游戏内设置的音量（此处繁说此处独立与游戏内分开）
        -- local volume = AudioManager:getMusicVolume() * AudioManager:getTotalVolume()
        -- local totalVolumeSwitch = systemSetting.SystemSettingManager:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.totalVolumeSwitch)
        -- local musicVolumeSwitch = systemSetting.SystemSettingManager:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.musicVolumeSwitch)
        -- if not totalVolumeSwitch or not musicVolumeSwitch then
        --     volume = 0
        -- end
        self.mImgAudio:SetImg(UrlManager:getPackPath("login/login_icon_07.png"), true)
    else
        self.mImgAudio:SetImg(UrlManager:getPackPath("login/login_icon_08.png"), true)
    end
    StorageUtil:saveBool0('IsUpdateResAudioMute', isMute)
    BoardShower:updateBoard(isMute, nil, nil)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
end

-- 销毁
function destroyPanel(self)
    if(web.WebManager:hasEventListener(web.WebManager.GAIN_ALL_DATA_FINISH, self.__onGainAllDataFinishHandler, self))then
        self:deActive(self) 
    end
    super.destroyPanel(self)
end

function __onSdkLoginInterruptHandler(self)
    local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.FULL_ACTIVE_LOGIN_VIEW, "SDK中断显示完整登录界面")
    WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)

    self.mIsSdkLoginInterrupt = true
    self:__updateView()
end

function __onGainAllDataFinishHandler(self)
    self:__updateView()
    -- 自动弹公告
    if (not self.mHasCheckBulletin) then
        self.mHasCheckBulletin = true
        if (web.WebManager:getIsWeiHu()) then
            self:__onClickNoticeHandler()
        end

        local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.FULL_ACTIVE_LOGIN_VIEW, "数据完毕显示完整登录界面")
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
        self:addTimeOutCheck(4)
    end
end

function addTimeOutCheck(self, timeOutSeconds)
    self:removeTimeOutCheck()
    self.mTimeOutCheckFrameSn = LoopManager:addTimer(timeOutSeconds, 1, self, function()
        local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.FULL_ACTIVE_LOGIN_VIEW_STAY_TIME_OUT, tostring(timeOutSeconds) .. "s")
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
    end)
end

function removeTimeOutCheck(self)
    if (self.mTimeOutCheckFrameSn) then
        LoopManager:removeTimerByIndex(self.mTimeOutCheckFrameSn)
        self.mTimeOutCheckFrameSn = nil
    end
end

function __updateView(self)
    if (download.ResDownLoadManager:getIsNeedLoginSdk() and not self.mIsSdkLoginInterrupt) then
        self.m_groupContent:SetActive(false)
        self:__showRoll()
    else
        -- 播一下登录按钮出现的音效
        AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_gain.prefab"))
        self.m_groupContent:SetActive(true)
        self:__hideRoll()
    end
    self:updatePolicyAgreementTip(StorageUtil:getBool0(gstor.APP_POLICY_AGREEMENT))
end

function updatePolicyAgreementTip(self, isAllowPolicy)
    self.mIsAllowPolicy = isAllowPolicy
    self.mGoPolicySelect:SetActive(self.mIsAllowPolicy)
    StorageUtil:saveBool0(gstor.APP_POLICY_AGREEMENT, self.mIsAllowPolicy)
end

function __showRoll(self)
    if (not self.mActionFrameSn) then
        self.mActionFrameSn = LoopManager:addFrame(1, 0, self, self.__onRollActionFrameHandler)
    end
    self.m_imgRoll.gameObject:SetActive(true)
end

function __onRollActionFrameHandler(self)
    if (not self.mRotation) then
        self.mRotation = 360
    else
        if (self.mRotation <= 0) then
            self.mRotation = 360 - 2
        else
            self.mRotation = self.mRotation - 4
        end
    end
    gs.TransQuick:SetRotation(self.m_imgRoll, 0, 0, self.mRotation)
end

function __hideRoll(self)
    if (self.mActionFrameSn) then
        LoopManager:removeFrameByIndex(self.mActionFrameSn)
        self.mActionFrameSn = nil
    end
    self.m_imgRoll.gameObject:SetActive(false)
end

-- 打开公告
function __onClickNoticeHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LOGIN_BULLETIN_VIEW)
end

function __onClickLoginHandler(self)
    if (self.mIsSdkLoginInterrupt) then
        self:removeTimeOutCheck()
        local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.CLICK_LOGIN_3, "方式3")
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
        
        self.mIsSdkLoginInterrupt = false
        self:__updateView()
        web.WebManager:dispatchEvent(web.WebManager.REQ_SDK_ACCOUNT_LOGIN, {})
    elseif (download.ResDownLoadManager:getIsNeedLoginSdk()) then
        self:removeTimeOutCheck()
        local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.CLICK_LOGIN_2, "方式2")
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
        
        self.mIsSdkLoginInterrupt = true
        -- 此处预防情况如下：游戏内退出到登录界面设置不需要手动登录sdk，则会先自动登录sdk，然后可能登录token失效或者其他，此时需要重新登录sdk，登录按钮此处不给进
        self:__updateView()
        web.WebManager:dispatchEvent(web.WebManager.REQ_SDK_ACCOUNT_LOGIN, {})
    else
        self:removeTimeOutCheck()
        local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.CLICK_LOGIN_1, "方式1")
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
        
        if(self.mIsAllowPolicy)then
            self:dispatchEvent(login.LoginManager.EVENT_LOGIN, {})
        else
            local languageId = 0
            local channelId, channelName = sdk.SdkManager:getChannelData()
            if(channelId == sdk.AndroidChannelId.QIANYOU)then
                languageId = 88
            elseif(channelId == sdk.AndroidChannelId.DANDANYOU)then
                languageId = 88
            elseif(channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3)then
                languageId = 88
            else
                languageId = 70
            end
            -- "请先阅读并同意平台用户协议条款、隐私政策和儿童隐私保护指引"
            UIFactory:alertMessge(_TT(languageId), true, function()
                self:updatePolicyAgreementTip(true)
            end, _TT(1), nil, true, function()
            end, _TT(2), _TT(5), nil, nil)
        end
    end
end

function __onClickDestroyAccountHandler(self)
    sdk.SdkManager:destroyAccount()
end

function __onClickQuitHandler(self)
    UIFactory:alertMessge(_TT(74), true, function()
        CS.Lylibs.SDKManager.Ins:CloseApplication()
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end

function __onClickAgeTipHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LOGIN_AGE_TIP_VIEW)
end

-- 清理资源
function __onClickCleanAssetsHandler(self)
    UIFactory:alertMessge(_TT(52), --"将清除所有资源并重新下载"
    true, function() GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = true, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = true }) end, _TT(1), --"确定"
    nil, true, function() end, _TT(2), --"取消"
    _TT(55), --"清除缓存提示"
    nil, nil)
end

-- 清理服务器数据
function __onClickCleanStorageHandler(self)
    UIFactory:alertMessge(_TT(56), --"将清除服务器缓存数据"
    true, function() GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = true, isNeedLoginSdk = false, isNeedRunUpdate = false }) end, _TT(1), --"确定"
    nil, true, function() end, _TT(2), --"取消"
    _TT(5), --"提示"
    nil, nil)
end

-- 复制设备码
function __onClickGetUniqueIdHandler(self)
    gs.SdkManager:Copy(sdk.SdkManager:getUniqueId())
    local pasteResult = gs.SdkManager:Paste()
    if (pasteResult == "") then
        gs.Message.Show(_TT(25104))--"复制失败"
    else
        gs.Message.Show(string.format(_TT(25105), pasteResult)) -- "复制成功：%s"
    end
end

-- 设置隐私政策协议
function __onClickPolicyAgreementHandler(self)
    self:updatePolicyAgreementTip(not self.mIsAllowPolicy)
end

function commonUrlLinkData(position, localPosition, linkIdStr, linkTextStr)
    if linkIdStr and linkTextStr then
		linkIdStr = string.gsub(linkIdStr, "\'", "")
        sdk.SdkManager:openSDKUIBrowser(linkIdStr)
    end
end

-- 更新显示客户端版本号
function updateClientVersion(self)
    local version = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.VersionKey)
    local versionStr = download.ResDownLoadManager:getVersionStr(version)
    local prefixVersion = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.PrefixVersionKey)
    local proVersion = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.ProVersionKey)
    local artVersion = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.ArtVersionKey)
    if (version ~= "" and proVersion ~= "" and artVersion ~= "") then
        self.mTxtClientVersion.text = web.getFormatVersion(prefixVersion, versionStr, proVersion, artVersion)
        self.mTxtClientVersion.gameObject:SetActive(true)
    else
        self.mTxtClientVersion.text = "";
        self.mTxtClientVersion.gameObject:SetActive(false)
    end
end

-- 更新显示服务端版本号
function updateServerVersion(self)
    local serverVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.VersionKey)
    local serverVersionStr = download.ResDownLoadManager:getVersionStr(serverVersion)
    local prefixVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)
    local serverProVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.ProVersionKey)
    local serverArtVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.ArtVersionKey)
    if (serverVersion ~= "" and serverProVersion ~= "" and serverArtVersion ~= "") then
        self.mTxtServerVersion.text = web.getFormatVersion(prefixVersion, serverVersionStr, serverProVersion, serverArtVersion)
        self.mTxtServerVersion.gameObject:SetActive(true)
    else
        self.mTxtServerVersion.text = ""
        self.mTxtServerVersion.gameObject:SetActive(false)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(56):	"将清除服务器缓存数据"
	语言包: _TT(52):	"将清除所有资源并重新下载"
	语言包: _TT(55):	"清除缓存提示"
]]