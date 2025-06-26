module('role.RoleController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 游戏账号登陆成功
    GameDispatcher:addEventListener(EventName.ACCOUNT_LOGIN_SUC, self.onAccountLoginSucHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROLE_INFO_VIEW, self.onOpenInfoViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROLE_PANEL, self.onOpenRolePanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROLE_INFO_TIPS_PANEL, self.onOpenRoleInfoTipsViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROLE_MODIFY_NAME_PANEL, self.onOpenRoleModifyNamePanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROLE_TO_NAME_PANEL, self.onOpenRoleToNamePanelHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_ROLE_MODIFY_AUTOGRAPH_PANEL, self.onOpenRoleModifyAutographPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROLE_SELECT_HERO_PANEL, self.onOpenRoleSelectHeroPanelHandler, self)
    -- 打开玩家自己的预览信息
    GameDispatcher:addEventListener(EventName.OPEN_ROLE_INFO_PREVIEW_PANEL, self.onOpenRoleInfoPreviewHandler, self)
    -- 打开玩家背景列表
    GameDispatcher:addEventListener(EventName.OPEN_SHOWROLE_BG_VIEW, self.onOpenRoleBgViewHandler, self)
    -- 请求修改玩家名
    GameDispatcher:addEventListener(EventName.REQ_MODIFY_ROLE_NAME, self.onReqModifyRoleNameHandler, self)
    -- 请求修改玩家个性签名
    GameDispatcher:addEventListener(EventName.REQ_MODIFY_ROLE_AUTOGRAPH, self.onReqModifyRoleAutographHandler, self)
    -- 请求选择玩家的展示战员
    GameDispatcher:addEventListener(EventName.REQ_ROLE_SELECT_HERO, self.onReqRoleSelectHeroHandler, self)
    -- 请求查看其它玩家预览信息
    GameDispatcher:addEventListener(EventName.SHOW_OTHER_ROLE_INFO, self.onReqOtherRoleInfoHandler, self)

    -- 请求兑换码兑换
    GameDispatcher:addEventListener(EventName.REQ_EXCHANGE_CODE, self.onReqExchangeCodeHandler, self)

    GameDispatcher:addEventListener(EventName.SHOW_SINGLE_HERO_INFO, self.onShowOtherHeroInfoHandler, self)
    GameDispatcher:addEventListener(EventName.SHOW_OTHER_MARK_INFO, self.onShowOtherMarkInfoHandler, self)
    --请求删除好友备注
    GameDispatcher:addEventListener(EventName.REQ_MASKSCLEAR, self.onReqMasksClearHandler, self)
    self.mMgr:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.onUpdatePlayerInfoHandler, self)
    --请求玩家个人信息
    -- GameDispatcher:addEventListener(EventName.FIGHT_RESULT_PANEL_ACTVIE, self.onFightOverShowLvUpHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_PLAYER_HOMEPAGE_INFO, self.onReqPlayerHomePageInfoHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_HERO_GROUP_PANEL, self.onOpenHeroGroupPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_HERO_GROUP_SELECT_VIEW, self.onOpenHeroGroupSelectViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_HERO_GROUP_FASHION_VIEW, self.onOpenHeroGroupFashionViewHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        -- --- *s2c* 返回角色列表 11003
        -- SC_ACCOUNT_PLAYER_LIST = self.onPlayerListMsgHandler,
        -- --- *s2c* 返回角色登录 11006
        -- SC_ACCOUNT_SELECT_PLAYER = self.onAccountSelectPlayerMsgHandler,

        --- *s2c* 返回角色基础数据 12001
        SC_PLAYER_BASE_DATA = self.onPlayerBaseDataMsgHandler,
        --- *s2c* 更新玩家int32属性 12002
        SC_PLAYER_UPDATE_ATTR_INT = self.onPlayerAttrDataMsgHandler,
        --- *s2c* 更新玩家int64属性 12003
        SC_PLAYER_UPDATE_ATTR_BIGINT = self.onPlayerAttrDataMsgHandler,
        --- *s2c* 更新玩家string属性 12004
        SC_PLAYER_UPDATE_ATTR_STRING = self.onPlayerAttrDataMsgHandler,

        --- *s2c* 玩家改名成功 12011
        SC_RENAME = self.onResPlayerChangeNameHandler,
        --- *s2c* 玩家修改签名 12013
        SC_SET_SIGNATURE = self.onResChangeRoleAutographHandler,
        --- *s2c* 删除好友备注返回 15033
        SC_FRIEND_REMARKS_CLEAR = self.onResMasksClearHandler,
        --- *s2c* 设置展示战员 12016
        SC_SET_SHOW_HERO = self.onResModifyRoleShowHeroListHandler,
        --- *s2c* 其它玩家预览信息 12032
        SC_OTHER_PLAYER_PRE_INFO = self.onOtherPlayerPreInfoHandler,

        --- *s2c* 玩家使用激活码返回 24031
        SC_USE_PLAYER_CODE = self.onResExchangeCodeHandler,
        --- *s2c* 获取服务器是否提审服 10071
        SC_GET_SERVER_STATE = self.onResIsInCommitingHandler,

        --- *s2c* 玩家的个人主页信息 12034
        SC_PLAYER_HOMEPAGE_INFO = self.onResPersonalInfoDataHandler,
    }
end

-- 游戏账号登陆成功
function onAccountLoginSucHandler(self)
    -- 不请求角色列表了
    -- self:requestRoleList()
    -- 直接请求进游戏
    SOCKET_SEND(Protocol.CS_ENTER_WORLD, { battle_sync_word = 0 })
    GameManager:setIsGetPlayerData(true)
end

-- -- 请求角色列表
-- function requestRoleList()
--     web.WebController:reqReportStep(web.REPORT_STEP.REQ_ROLE_DATA)
--     SOCKET_SEND(Protocol.CS_ACCOUNT_PLAYER_LIST, { dev_type = CS.UnityEngine.SystemInfo.deviceModel, dev_uuid = sdk.SdkManager:getUniqueId() })
-- end

-- -- 角色列表返回
-- function onPlayerListMsgHandler(self, msg)
--     web.WebController:reqReportStep(web.REPORT_STEP.GET_ROLE_DATA_SUC)
--     if msg and #msg.player_list > 0 then
--         login.LoginManager.gameLoginPlayerId = msg.player_list[1].player_id
--         web.WebController:reqReportStep(web.REPORT_STEP.REQ_SELECT_ROLE_LOGIN)
--         SOCKET_SEND(Protocol.CS_ACCOUNT_SELECT_PLAYER, { player_id = msg.player_list[1].player_id, dev_pf = web.WebManager.dev_os })
--     else
--         -- cb2测试的提示
--         loginLoad.LoginLoadController:closeLoading()
--         GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = false, isNeedRunUpdate = false })

--         LoopManager:addFrame(1, 1, self, function()
--             local confirmCall = function()
--                 CS.Lylibs.SDKManager.Ins:CloseApplication()
--             end
--             UIFactory:alertOK0(_TT(49), "指挥官抱歉了，本次测试资格注册时间已结束！下次测试，请留意官方最新消息。感谢您的关注！！！", confirmCall)
--         end)
--     end
-- end

-- -- 返回角色登录
-- function onAccountSelectPlayerMsgHandler(self, msg)
--     web.WebController:reqReportStep(web.REPORT_STEP.SELECT_ROLE_LOGIN_SUC)
--     login.LoginManager.gameLoginSession = msg.session
--     web.WebController:reqReportStep(web.REPORT_STEP.NOTIFY_ENTER_GAME)
--     SOCKET_SEND(Protocol.CS_ENTER_WORLD, { battle_sync_word = 0 })
--     GameManager:setIsGetPlayerData(true)
-- end

-- 角色信息返回
function onPlayerBaseDataMsgHandler(self, msg)
    GameManager:setGameState(nil)
    StorageUtil:setUniqueKey(msg.player_id)
    local roleVo = self.mMgr:getRoleVo()
    roleVo:parseMsgData(msg)

    -- 通知sdk创角成功
    sdk.SdkManager:notifyCreateRoleSuc()
    -- 通知sdk登录服务器成功
    sdk.SdkManager:notifyLoginServerSuc()

    -- 比较消耗的实时发送不给进入游戏内
    if (web.getLogCollectType() == web.DEBUG_LOG_COLLECT_TYPE.AUTO_REAL_TIME_UPLOAD) then
        web.setLogCollectType(web.DEBUG_LOG_COLLECT_TYPE.NONE)
    end

    if (roleVo.isOpenGM) then
        GameManager.IS_DEBUG = true
        GameDispatcher:dispatchEvent(EventName.CREATE_GM)
        GameDispatcher:dispatchEvent(EventName.CREATE_FPS)
        gs.GOPoolMgr:SetCheckRepeat(true)
    else
        GameManager.IS_DEBUG = false
    end
    
    -- 设置log界面是否允许弹出
    Debug:setLogAllow(GameManager.IS_DEBUG)
    gs.ApplicationUtil.SetDebugVisible(GameManager.IS_DEBUG)
    systemSetting.SystemSettingManager:setDefaultQuality()

    GameView.UINode["UID"].text = string.format("UID：%s", roleVo.showId)

    if not (web.WebManager.net_type == web.NET_TYPE.OUTER_RELEASE) then

        local sdkInfo = sdk.SdkManager:getSdkInfo()
        if sdkInfo then
            -- 新版本更新，暂时关闭
            -- if not waterMask then
            --     waterMask = require("game/common/view/WaterMark").new()
            -- end
            -- waterMask:updateWatermark(roleVo.showId, 10)
        elseif login.LoginManager.clientAuthLv < 2 then
            if not waterMask then
                waterMask = require("game/common/view/WaterMark").new()
            end
            waterMask:updateWatermark(login.LoginManager.clientAuthId, 10)
            -- waterMask:updateWatermark("test", 10)
        end
    end
end

-- 更新角色属性数据
function onPlayerAttrDataMsgHandler(self, msg)
    if (not msg) then return end
    local len = #msg.attr_list
    for i = 1, len do
        local key = msg.attr_list[i].key
        local value = msg.attr_list[i].value
        self.mMgr:updateAttrValue(key, value)
    end
    role.RoleManager.isRoleDataInit = true
end
-- 指挥官等级提升
function onUpdatePlayerInfoHandler(self, args)
    self.roleLvUpArgs = args
    -- 战斗结算引起的等级提升等结算界面出现再提示
    if not fight.FightManager:getIsFighting() then
        self:onOpenRoleLevelUpViewHandler(args)
        self.roleLvUpArgs = nil
    end
end
-- 战斗结算界面后才提示等级提升
function onFightOverShowLvUpHandler(self)
    if self.roleLvUpArgs then
        self:onOpenRoleLevelUpViewHandler(self.roleLvUpArgs)
        self.roleLvUpArgs = nil
    end
end

-- 展示等级提升
function onShowPlayerLvlUp(self, callBack)
    self.mLvlUpCallBack = callBack
    if self.roleLvUpArgs then
        self:onOpenRoleLevelUpViewHandler(self.roleLvUpArgs)
        self.roleLvUpArgs = nil
    else
        if self.mLvlUpCallBack then
            self.mLvlUpCallBack()
            self.mLvlUpCallBack = nil
        end
    end
end

--------------------------------------------------------------模块功能请求----------------------------------------------------------------------
--- *c2s* 获取服务器是否提审服 10070
function onReqIsInCommitingHandler(self, args)
    SOCKET_SEND(Protocol.CS_GET_SERVER_STATE)
end

-- 请求角色改名
function onReqModifyRoleNameHandler(self, args)
    --- *c2s* 玩家改名 12010
    SOCKET_SEND(Protocol.CS_RENAME, { name = args.name })
end

-- 请求角色修改个性签名
function onReqModifyRoleAutographHandler(self, args)
    --- *c2s* 玩家修改签名 12012
    SOCKET_SEND(Protocol.CS_SET_SIGNATURE, { signature = args.content })
end

--- 请求删除好友备注
function onReqMasksClearHandler(self, id)
    --- *c2s* 删除好友备注 15032
    SOCKET_SEND(Protocol.CS_FRIEND_REMARKS_CLEAR, { friend_id = id })
end

-- 请求选择玩家的展示战员
function onReqRoleSelectHeroHandler(self, args)
    --- *c2s* 设置展示战员 12015
    SOCKET_SEND(Protocol.CS_SET_SHOW_HERO, { hero_list = args.showHeroList })
    GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)
end

--- *c2s* 其它玩家预览信息 12030
function onReqOtherRoleInfoHandler(self, id)
    SOCKET_SEND(Protocol.CS_OTHER_PLAYER_PRE_INFO, { player_id = id }, Protocol.SC_OTHER_PLAYER_PRE_INFO)
end

--- *c2s* 玩家使用激活码 24030
function onReqExchangeCodeHandler(self, args)
    SOCKET_SEND(Protocol.CS_USE_PLAYER_CODE, { code = args.code })
end

--- *c2s* 玩家的个人主页信息 12033
function onReqPlayerHomePageInfoHandler(self)
    SOCKET_SEND(Protocol.CS_PLAYER_HOMEPAGE_INFO)
end

--------------------------------------------------------------模块功能响应----------------------------------------------------------------------
-- 角色改名结果返回
function onResPlayerChangeNameHandler(self, msg)
    if (msg.result == 1) then
        -- gs.Message.Show("修改名称成功")
        GameDispatcher:dispatchEvent(EventName.MODIFY_ROLE_NAME_SUCCESS)
        self:onCloseRoleToNamePanelHandler()
    else
        gs.Message.Show(_TT(513))--"存在敏感字或非法符号"
    end
end

-- 角色修改个性签名结果返回
function onResChangeRoleAutographHandler(self, msg)
    if (msg.result == 1) then
        gs.Message.Show("修改签名成功")
    else
        gs.Message.Show(_TT(513))--"存在敏感字或非法符号"
    end
end

-- 角色修改展示英雄结果返回
function onResModifyRoleShowHeroListHandler(self, msg)
    if (msg.result == 1) then
        local roleVo = self.mMgr:getRoleVo()
        roleVo:setShowHeroList(msg.hero_list)
        gs.Message.Show("修改成功")
    else
        gs.Message.Show("修改失败")
    end
end

--- *s2c* 其它玩家预览信息 12032
function onOtherPlayerPreInfoHandler(self, msg)
    if not msg then
        return
    end
    local vo = role.OtherRoleVo.new()
    vo:parseMsg(msg)
    role.RoleManager:setOtherInfo(vo)
    --self:onShowOtherRoleInfoHandler(vo)
end

--- *s2c* 玩家使用激活码返回 24031
function onResExchangeCodeHandler(self, msg)
    if (msg.result == 1) then
        ShowAwardPanel:showPropsAwardMsg(msg.award)
        GameDispatcher:dispatchEvent(EventName.RES_EXCHANGE_CODE)
    end
end

--- *s2c* 获取服务器是否提审服 10071
function onResIsInCommitingHandler(self, msg)
    if (msg.state == 1) then
        GameManager:setIsInCommiting(true)
    else
        GameManager:setIsInCommiting(false)
    end
end

--- *s2c* 删除好友备注返回 15033
function onResMasksClearHandler(self, msg)
    if (msg.result == 1) then
        gs.Message.Show(_TT(25182))
        msg.new_remarks = ""
        friend.FriendManager:parseFriendMarkMsg(msg)
    else
        gs.Message.Show(_TT(25158))
    end
end

--- *s2c* 玩家的个人主页信息返回 12034
function onResPersonalInfoDataHandler(self, msg)
    role.RoleManager:prasePersonalInfoData(msg)
end
--------------------------------------------------------------角色面板----------------------------------------------------------------------
-- 打开角色面板
function onOpenRolePanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME, true) == false then
        return
    end

    if not args then
        args = {}
    end

    if not args.type then
        args.type = 1
    end

    if (args.type == 1) then
        GameDispatcher:dispatchEvent(EventName.REQ_PLAYER_HOMEPAGE_INFO)
        if self.m_rolePanel == nil then
            self.m_rolePanel = role.RolePanel.new()
            self.m_rolePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRolePanelHandler, self)
        end
        args.type = 1
        self.m_rolePanel:open(args)
    else
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_SETTING, true) == false then
            return
        end
        if self.m_roleSettingPanel == nil then
            self.m_roleSettingPanel = role.RoleSettingPanel.new()
            self.m_roleSettingPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleSettingPanelHandler, self)
        end
        self.m_roleSettingPanel:open(args)
    end
end

-- ui销毁
function onDestroyRolePanelHandler(self)
    self.m_rolePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRolePanelHandler, self)
    self.m_rolePanel = nil
end

-- ui销毁
function onDestroyRoleSettingPanelHandler(self)
    self.m_roleSettingPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleSettingPanelHandler, self)
    self.m_roleSettingPanel = nil
end

--------------------------------------------------------------打开角色修改昵称面板----------------------------------------------------------------------
function onOpenRoleModifyNamePanelHandler(self, args)
    if self.m_roleModifyNamePanel == nil then
        self.m_roleModifyNamePanel = role.RoleModifyNamePanel.new()
        self.m_roleModifyNamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleModifyNamePanelHandler, self)
    end
    self.m_roleModifyNamePanel:open()
end

-- ui销毁
function onDestroyRoleModifyNamePanelHandler(self)
    self.m_roleModifyNamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleModifyNamePanelHandler, self)
    self.m_roleModifyNamePanel = nil
end

--------------------------------------------------------------打开角色取名面板----------------------------------------------------------------------
function onOpenRoleToNamePanelHandler(self, args)
    if self.m_roleToNamePanel == nil then
        self.m_roleToNamePanel = role.RoleToNamePanel.new()
        self.m_roleToNamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleToNamePanelHandler, self)
    end
    -- 剧情派发参数
    if (args) then
        self.storyArgs = args.data
    end
    self.m_roleToNamePanel:open()
end

function onCloseRoleToNamePanelHandler(self)
    if self.m_roleToNamePanel and self.m_roleToNamePanel.isPop then
        -- 剧情派发参数
        if (self.storyArgs) then
            GameDispatcher:dispatchEvent(EventName.STORY_BACK_TO_STORY, self.storyArgs)
            self.storyArgs = nil
        end
        self.m_roleToNamePanel:close()
    end
end

-- ui销毁
function onDestroyRoleToNamePanelHandler(self)
    self.m_roleToNamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleToNamePanelHandler, self)
    self.m_roleToNamePanel = nil
end

--------------------------------------------------------------打开角色修改个性签名面板----------------------------------------------------------------------
function onOpenRoleModifyAutographPanelHandler(self)
    if self.m_roleModifyAutographPanel == nil then
        self.m_roleModifyAutographPanel = role.RoleModifyAutographPanel.new()
        self.m_roleModifyAutographPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleModifyAutographPanelHandler, self)
    end
    self.m_roleModifyAutographPanel:open()
end

-- ui销毁
function onDestroyRoleModifyAutographPanelHandler(self)
    self.m_roleModifyAutographPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleModifyAutographPanelHandler, self)
    self.m_roleModifyAutographPanel = nil
end

--------------------------------------------------------------打开玩家信息预览面板----------------------------------------------------------------------
function onOpenRoleInfoPreviewHandler(self, args)
    if self.m_myRoleInfoPreView == nil then
        self.m_myRoleInfoPreView = role.MyRoleInfoPreView.new()
        self.m_myRoleInfoPreView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMyRoleInfoPreViewHandler, self)
    end
    self.m_myRoleInfoPreView:open()
end

-- ui销毁
function onDestroyMyRoleInfoPreViewHandler(self)
    self.m_myRoleInfoPreView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMyRoleInfoPreViewHandler, self)
    self.m_myRoleInfoPreView = nil
end
--------------------------------------------------------------打开背景页面面板----------------------------------------------------------------------
function onOpenRoleBgViewHandler(self)
    if self.mRoleBgView == nil then
        self.mRoleBgView = role.RoleBgView.new()
        self.mRoleBgView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleBgViewHandler, self)
    end
    self.mRoleBgView:open()
end

-- ui销毁
function onDestroyRoleBgViewHandler(self)
    self.mRoleBgView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleBgViewHandler, self)
    self.mRoleBgView = nil
end
--------------------------------------------------------------打开玩家信息面板(其他与角色玩家)----------------------------------------------------------------------
function onOpenInfoViewHandler(self, args)
    if self.mRoleInfoView == nil then
        self.mRoleInfoView = role.RoleInfoView.new()
        self.mRoleInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyInfoViewHandler, self)
    end
    self.mRoleInfoView:open(args)
end

-- ui销毁
function onDestroyInfoViewHandler(self)
    self.mRoleInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyInfoViewHandler, self)
    self.mRoleInfoView = nil
end

--------------------------------------------------------------打开玩家信息面板(其他与角色玩家)弹窗----------------------------------------------------------------------
function onOpenRoleInfoTipsViewHandler(self, args)
    GameDispatcher:dispatchEvent(EventName.SHOW_OTHER_ROLE_INFO, args.id)
    if self.RoleInfoTipsView == nil then
        self.RoleInfoTipsView = role.RoleInfoTipsView.new()
        self.RoleInfoTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleInfoTipsViewHandler, self)
    end
    self.RoleInfoTipsView:open(args)
end

-- ui销毁
function onDestroyRoleInfoTipsViewHandler(self)
    self.RoleInfoTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleInfoTipsViewHandler, self)
    self.RoleInfoTipsView = nil
end
--------------------------------------------------------------打开角色选择战员面板----------------------------------------------------------------------
function onOpenRoleSelectHeroPanelHandler(self, args)
    if self.m_roleSelectHeroPanel == nil then
        self.m_roleSelectHeroPanel = role.ChangeExhibitionPanel.new()
        self.m_roleSelectHeroPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleSelectHeroPanelHandler, self)
    end
    self.m_roleSelectHeroPanel:open(args)
end

-- ui销毁
function onDestroyRoleSelectHeroPanelHandler(self)
    self.m_roleSelectHeroPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleSelectHeroPanelHandler, self)
    self.m_roleSelectHeroPanel = nil
end
--------------------------------------------------------------玩家指挥官等级提升----------------------------------------------------------------------
function onOpenRoleLevelUpViewHandler(self, args)
    if self.mRoleLevelUpView == nil then
        self.mRoleLevelUpView = role.RoleLevelUpView.new()
        self.mRoleLevelUpView:addEventListener(View.EVENT_CLOSE, self.onCloseRoleLevelUpViewHandler, self)
        self.mRoleLevelUpView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleLevelUpViewHandler, self)
    end
    self.mRoleLevelUpView:open(args)
    -- 指挥官升级
    local roleLvl = role.RoleManager:getRoleVo():getPlayerLvl()
    guide.GuideCondition:condition08(roleLvl)
end
-- 关闭回调
function onCloseRoleLevelUpViewHandler(self)
    if self.mLvlUpCallBack then
        self.mLvlUpCallBack()
        self.mLvlUpCallBack = nil
    end
end
-- ui销毁
function onDestroyRoleLevelUpViewHandler(self)
    self.mRoleLevelUpView:removeEventListener(View.EVENT_CLOSE, self.onCloseRoleLevelUpViewHandler, self)
    self.mRoleLevelUpView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoleLevelUpViewHandler, self)
    self.mRoleLevelUpView = nil
end
--------------------------------------------------------------打开其他玩家信息面板----------------------------------------------------------------------
function onShowOtherRoleInfoHandler(self, cusVo)
    if self.mOtherRoleInfoView == nil then
        self.mOtherRoleInfoView = UI.new(role.OtherRoleInfoView)
        self.mOtherRoleInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOtherRoleInfoViewHandler, self)
    end
    self.mOtherRoleInfoView:open(cusVo)
end

-- ui销毁
function onDestroyOtherRoleInfoViewHandler(self)
    self.mOtherRoleInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOtherRoleInfoViewHandler, self)
    self.mOtherRoleInfoView = nil
end

function onShowOtherHeroInfoHandler(self, args)
    if self.mSingleHeroInfoView == nil then
        self.mSingleHeroInfoView = UI.new(role.SingleHeroInfoView)
        self.mSingleHeroInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOtherHeroInfoViewHandler, self)
    end
    self.mSingleHeroInfoView:open(args)
end

-- ui销毁
function onDestroyOtherHeroInfoViewHandler(self)
    self.mSingleHeroInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOtherHeroInfoViewHandler, self)
    self.mSingleHeroInfoView = nil
end

-- 玩家备注页面
function onShowOtherMarkInfoHandler(self, cusId)
    if self.mOtherMarkInfoView == nil then
        self.mOtherMarkInfoView = UI.new(role.OtherRoleMarkView)
        self.mOtherMarkInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOtherMarkInfoViewHandler, self)
    end
    self.mOtherMarkInfoView:open(cusId)
end

-- ui销毁
function onDestroyOtherMarkInfoViewHandler(self)
    self.mOtherMarkInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOtherMarkInfoViewHandler, self)
    self.mOtherMarkInfoView = nil
end

--------------------------------------------------------------打开看板值班战员组----------------------------------------------------------------------
function onOpenHeroGroupPanelHandler(self, args)

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_GURAD_GROUP, true) == false then
        return
    end

    if self.mRoleGuradGroupPanel == nil then
        self.mRoleGuradGroupPanel = UI.new(role.RoleGuradGroupPanel)
        self.mRoleGuradGroupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroGroupPanelHandler, self)
    end
    self.mRoleGuradGroupPanel:open(args)
end

-- ui销毁
function onDestroyHeroGroupPanelHandler(self)
    self.mRoleGuradGroupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroGroupPanelHandler, self)
    self.mRoleGuradGroupPanel = nil
end
--------------------------------------------------------------打开看板值班战员组选择页面----------------------------------------------------------------------
function onOpenHeroGroupSelectViewHandler(self, args)
    if self.mRoleGuradGroupSelectView == nil then
        self.mRoleGuradGroupSelectView = UI.new(role.RoleGuradGroupSelectView)
        self.mRoleGuradGroupSelectView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroGroupSelectViewHandler, self)
    end
    self.mRoleGuradGroupSelectView:open(args)
end

-- ui销毁
function onDestroyHeroGroupSelectViewHandler(self)
    self.mRoleGuradGroupSelectView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroGroupSelectViewHandler, self)
    self.mRoleGuradGroupSelectView = nil
end
--------------------------------------------------------------打开看板值班战员组选择换装页面----------------------------------------------------------------------
function onOpenHeroGroupFashionViewHandler(self, args)
    if self.mRoleGuradGroupFashionView == nil then
        self.mRoleGuradGroupFashionView = UI.new(role.RoleGuradGroupFashionView)
        self.mRoleGuradGroupFashionView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroGroupFashionViewHandler, self)
    end
    self.mRoleGuradGroupFashionView:open(args)
end

-- ui销毁
function onDestroyHeroGroupFashionViewHandler(self)
    self.mRoleGuradGroupFashionView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroGroupFashionViewHandler, self)
    self.mRoleGuradGroupFashionView = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(49):"系统提示"
]]