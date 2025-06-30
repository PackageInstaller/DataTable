--[[****************************************************************************
Brief  :debug登录界面
Author :zzz
****************************************************************************
]]
module('login.DebugLoginView', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('login/DebugLoginView.prefab')
-- 是否异步
IsAsyn = true
destroyTime = 0 -- 自动销毁时间-1默认
escapeClose = 0 -- 是否能通过esc关闭窗口

--构造函数
function ctor(self)
    gs.LifeCyclelManager.Instance:AddRegister("DebugLoginView", self.onCSharpLifeCycleHandler, self)

    self.panelName = self.__cname
    self.m_sn = SnMgr:getSn()
    self:initData()
    self:loadAsset()
    self:setUICode(LinkCode.Login)
end

function onCSharpLifeCycleHandler(self, lifeCycleName)
    if (lifeCycleName == "Start") then
        gs.LifeCyclelManager.Instance:RemoveRegister("DebugLoginView")

        local function callFun()
            web.setSplashTipProcess(100)
            CS.Lylibs.Splash.Instance:CloseVisible()
            web.setSplashTipProcess(nil)

            self:__updateBgPlayState(StorageUtil:getBool0('IsUpdateResImgBg'))
            self:__updateBgAudioState(StorageUtil:getBool0('IsUpdateResAudioMute'))
            -- 不运行更新逻辑，则DebugLoginView界面做为第一个显示界面，则需要派发通知
            if (not web.WebManager.run_update_code) then
                web.WebManager:dispatchEvent(web.WebManager.FIRST_VIEW_INIT_FINISH, {})
            end
            if (updateRes) then
                -- 关闭更新模块的加载界面
                updateRes.UpdateResManager:dispatchEvent(updateRes.UpdateResManager.CLOSE_LOADING_VIEW, {})
            end
            -- 黑屏过渡
            if self.panelType == 1 and self.isScreensave == 1 then
                UIFactory:closeScreenSaver()
            end

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
    self.m_inputIp = nil
    self.m_inputPort = nil
    self.m_inputName = nil
    self.m_btnLogin = nil
    self.m_scroller = nil
    self.svr_id = 300309998
end

--初始化UI
function configUI(self)
    self:getChildGO('mImgBg'):SetActive(false)

    Debug:setLogAllow(true)
    -- self.m_imgBgRet = self:getChildGO("ImgBg"):GetComponent(ty.RectTransform)
    -- local scale = ScreenUtil:getScale()
    -- gs.TransQuick:Scale(self.m_imgBgRet, scale, scale, 1)
    self.m_groupContent = self:getChildGO('GroupContent')
    self.m_btnNotice = self:getChildGO('BtnNotice')
    self.m_btnLogin = self:getChildGO('m_btnLogin')

    self.m_btnQuit = self:getChildGO('mBtnQuit')

    self.m_inputIp = self:getChildGO('m_inputIp'):GetComponent(ty.InputField)
    self.m_inputPort = self:getChildGO('m_inputPort'):GetComponent(ty.InputField)
    self.m_inputName = self:getChildGO('m_inputName'):GetComponent(ty.InputField)
    local name = StorageUtil:getString0(gs.Application.dataPath .. 'login')
    self.m_inputName.text = name or ''
    self.m_inputIp.text = StorageUtil:getString0(gs.Application.dataPath .. 'login_serv_ip') == "" and web.WebManager.ip or StorageUtil:getString0(gs.Application.dataPath .. 'login_serv_ip')
    self.m_inputPort.text = StorageUtil:getString0(gs.Application.dataPath .. 'login_serv_port') == "" and web.WebManager.port or StorageUtil:getString0(gs.Application.dataPath .. 'login_serv_port')

    self.mBtnSwitch = self:getChildGO('BtnSwitch')
    self.mImgSwitch = self:getChildGO('mImgIconSwitch'):GetComponent(ty.AutoRefImage)
    self.mBtnSwitch:SetActive(not BoardShower:isForceBoardImg())

    self.mBtnAudio = self:getChildGO('BtnAudio')
    self.mImgAudio = self:getChildGO('mImgIconAudio'):GetComponent(ty.AutoRefImage)
    self.m_btnCleanAssets = self:getChildGO('BtnCleanAssets')
    self.m_btnGetUniqueId = self:getChildGO('BtnGetUniqueId')
    self:getChildGO('TextUniqueId'):GetComponent(ty.Text).text = sdk.SdkManager:getUniqueId()

    self.m_scroller = self:getChildGO("m_scroller"):GetComponent(ty.LyScroller)
    self.m_scroller:SetItemRender(login.DebugLoginScrollerItem)
    self.m_scroller.DataProvider = login.IpList
    self.m_scroller2 = self:getChildGO("m_scroller2"):GetComponent(ty.LyScroller)
    self.m_scroller2:SetItemRender(login.DebugLoginScrollerItem)
    self.m_scroller2.DataProvider = login.IpList2
    -- StorageUtil:deleteAll()
    self.mToggleGuide = self:getChildGO("mToggleGuide"):GetComponent(ty.Toggle)
    self.mToggleGuide.isOn = StorageUtil:getString0('login_guide') == "1"
    self.mToggleCloseShowAni = self:getChildGO("mToggleCloseShowAni"):GetComponent(ty.Toggle)
    self.mToggleCloseShowAni.isOn = StorageUtil:getString0('login_show_model_anim') == "1"
    self:getChildGO("mToggleCloseShowAni"):SetActive(gs.Application.isEditor)

    self.mToggleCloseVideoAudio = self:getChildGO("mToggleCloseVideoAudio"):GetComponent(ty.Toggle)
    self.mToggleCloseVideoAudio.isOn = StorageUtil:getNumber0('login_playVideoAudio') == 1
    self.mToggleCloseVideoAudio.onValueChanged:AddListener(function(val)
        self:updateVideoAudio()
    end)

    self.mToggleCloseUIEff = self:getChildGO("mToggleCloseUIEff"):GetComponent(ty.Toggle)
    self.mToggleCloseUIEff.isOn = StorageUtil:getString0('login_show_ui_effect') == "1"

    self.mTxtClientVersion = self:getChildGO('TextClientVersion'):GetComponent(ty.Text)
    self.mTxtServerVersion = self:getChildGO('TextServerVersion'):GetComponent(ty.Text)

    self.m_inputClientAuthId = self:getChildGO('m_inputClientAuthId'):GetComponent(ty.InputField)
    self.m_inputClientAuthPwd = self:getChildGO('m_inputClientAuthPwd'):GetComponent(ty.InputField)

    self.m_inputClientAuthId.text = login.LoginManager.clientAuthId
    self.m_inputClientAuthPwd.text = login.LoginManager.clientAuthPwd ~= "" and "********" or ""
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.m_btnNotice, 52010, "公告")
    self:setBtnLabel(self.m_btnCleanAssets, 71, "修复")
    self:setBtnLabel(self.mBtnAudio, 62060, "声音")
    self:setBtnLabel(self.mBtnSwitch, 1196, "切换")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSwitch, self.__onClickSwitchHandler)
    self:addUIEvent(self.mBtnAudio, self.__onClickBgAudioHandler)
    self:addUIEvent(self.m_btnCleanAssets, self.__onClickCleanAssetsHandler)
    self:addUIEvent(self.m_btnGetUniqueId, self.__onClickGetUniqueIdHandler)
    self:addUIEvent(self.m_btnNotice, self.__onClickNoticeHandler)
    self:addUIEvent(self.m_btnLogin, self.__onClickLoginHandler, UrlManager:getUIBaseSoundPath("ui_basic_load.prefab"))
    self:addUIEvent(self.m_btnQuit, self.__onClickQuitHandler)

    self:addUIEvent(self:getChildGO('OpenSkillEditor'), self._openSkillEditor)

    local function _openStory()
        --gs.CameraMgr:SetSceneCamera(nil)
        GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_EDITOR_PANEL)
        -- local storyGo = AssetLoader.GetGO(UrlManager:getPrefabPath('story/StoryEnterUI.prefab'))
        -- storyGo.transform:SetParent(GameView.mainUI.transform, false)
        -- local storyUI = CS.SkillEditor.SkillEditorCtrl.Instance:Require("Story/StoryUI.lua")
        -- -- local StoryUICls = require '../LuaTools/Story/StoryUI'
        -- storyUI:setup(storyGo)
    end
    self:addUIEvent(self:getChildGO('OpenStoryUI'), _openStory)

    -- if self.m_popGO then
    --     local function _storyClose()
    --         self.m_popGO:SetActive(true)
    --     end
    --     GameDispatcher:addEventListener(EventName.CLOSE_STORY_TALK_PANEL, _storyClose, self)
    -- end
end

function _openSkillEditor(self)
    self:removeUIEvent(self:getChildGO('OpenSkillEditor'))
    self.m_skillEditorUI = AssetLoader.GetGO(UrlManager:getPrefabPath('tools/SkillEditorUI.prefab'))
    self.m_skillEditorUI.transform:SetParent(GameView.mainUI.transform, false)
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
    web.WebManager:addEventListener(web.WebManager.GAIN_ALL_DATA_FINISH, self.__onGainAllDataFinishHandler, self)
    GameDispatcher:addEventListener(EventName.DEBUG_LOGIN_SELECT_SERVICE, self.onSelServiceHandler, self)
    -- 非编辑器下，自动弹公告
    local isEditor = CS.Lylibs.ApplicationUtil.IsEditorRun
    if (not isEditor) then
        self:__onClickNoticeHandler()
    end
    AudioManager:stopMusic()

    -- 新动效只留新做的denglu2
    -- self:addEffect("fx_ui_common_denglu1", self.m_groupContent.transform, 0, -125, nil)
    -- self:addEffect("fx_ui_common_denglu2", self.m_groupContent.transform, 0, 180, nil)
    -- self:addEffect("fx_ui_common_denglu3", self.m_groupContent.transform, 0, 180, nil)
end

--非激活
function deActive(self)
    super.deActive(self)
    login.LoginManager:setLoginViewVisible(false)
    web.WebManager:removeEventListener(web.WebManager.GAIN_ALL_DATA_FINISH, self.__onGainAllDataFinishHandler, self)
    GameDispatcher:removeEventListener(EventName.DEBUG_LOGIN_SELECT_SERVICE, self.onSelServiceHandler, self)
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
    if (self.mIsImgBg ~= (BoardShower:getBoardState() == BoardShower.BoardState.ImgBg)) then
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
    if (web.WebManager:hasEventListener(web.WebManager.GAIN_ALL_DATA_FINISH, self.__onGainAllDataFinishHandler, self)) then
        self:deActive(self)
    end
    super.destroyPanel(self)
end

function __onGainAllDataFinishHandler(self)
    self.m_groupContent:SetActive(true)
end

-- 清理资源
function __onClickCleanAssetsHandler(self)
    UIFactory:alertMessge(_TT(52), --"将清除所有资源并重新下载"
    true,
    function()
        if (web.WebManager.run_update_code) then
            GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = true, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = true })
        else
            GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = true, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = false })
        end
    end, _TT(1), --"确定"
    nil, true, function() end, _TT(2), --"取消"
    _TT(55), --"清除缓存提示"
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

-- 打开公告
function __onClickNoticeHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LOGIN_BULLETIN_VIEW)
end

-- 点击登录
function __onClickLoginHandler(self)
    -- storyTalk.StoryTalkCondition:condition10(nil, 1, 1, 101)
    -- gs.ResMgr:LoadGO(UrlManager:getRolePath01(3101))
    local loginFun = function()
        local data = {}
        data.ip = self.m_inputIp.text
        data.port = self.m_inputPort.text
        data.accname = self.m_inputName.text
        data.svr_id = self.svr_id
        if data.accname == nil or data.accname == '' then
            gs.Message.Show("输入你的大名")
            return
        end
        if (FilterWordUtil:hasIllegalWord(data.accname)) then
            gs.Message.Show("别输入标点特殊符号")
            return
        end
        StorageUtil:saveString0(gs.Application.dataPath .. 'login', data.accname)
        StorageUtil:saveString0(gs.Application.dataPath .. 'login_serv_ip', data.ip)
        StorageUtil:saveString0(gs.Application.dataPath .. 'login_serv_port', data.port)

        StorageUtil:saveString0('login_guide', (self.mToggleGuide.isOn and 1 or 0))
        StorageUtil:saveString0('login_show_model_anim', (self.mToggleCloseShowAni.isOn and 1 or 0))
        StorageUtil:saveString0('login_playVideoAudio', (self.mToggleCloseVideoAudio.isOn and 1 or 0))
        StorageUtil:saveString0('login_show_ui_effect', (self.mToggleCloseUIEff.isOn and 1 or 0))

        StorageUtil:saveString0('login_client_auth_id', login.LoginManager.clientAuthId)
        StorageUtil:saveString0('login_client_auth_pwd', login.LoginManager.clientAuthPwd)

        self:dispatchEvent(login.LoginManager.EVENT_LOGIN, data)
    end

    login.LoginManager.clientAuthId = self.m_inputClientAuthId.text
    login.LoginManager.clientAuthPwd = self.m_inputClientAuthPwd.text == "********" and login.LoginManager.clientAuthPwd or self.m_inputClientAuthPwd.text

    if login.LoginManager.clientAuthId == nil or login.LoginManager.clientAuthId == '' or login.LoginManager.clientAuthPwd == nil or login.LoginManager.clientAuthPwd == '' then
        gs.Message.Show("请输入客户端登录权限账号密码")
        return
    end

    web.WebController:reqClientAuthLogin(loginFun)
end

-- 点击选服
function onSelServiceHandler(self, data)
    self.m_inputIp.text = data[1]
    self.m_inputPort.text = data[2]

    StorageUtil:saveString0(gs.Application.dataPath .. 'login_serv_ip', data[1])
    StorageUtil:saveString0(gs.Application.dataPath .. 'login_serv_port', data[2])

    self.svr_id = data[4] or self.svr_id

    self:__onClickLoginHandler()
end

function __onClickQuitHandler(self)
    UIFactory:alertMessge(_TT(74), true, function()
        CS.Lylibs.SDKManager.Ins:CloseApplication()
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
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
	语言包: _TT(52):	"将清除所有资源并重新下载"
]]