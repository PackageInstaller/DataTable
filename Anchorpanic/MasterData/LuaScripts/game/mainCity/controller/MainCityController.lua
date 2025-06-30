--[[****************************************************************************
Brief  :主城控制器
Author :lizhenghui
****************************************************************************
]]
module('map.MainCityController', Class.impl(map.MapBaseController))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
    self:__init()
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:clearMap()
end

function __init(self)
    self.m_scene = nil
end

--游戏开始的回调
function gameStartCallBack(self)
    self:loadScene()
end

--模块间事件监听
function listNotification(self)
    super.listNotification(self)
    GameDispatcher:addEventListener(EventName.EVENT_UI_OPEN, self.onUIOpen, self)
    GameDispatcher:addEventListener(EventName.EVENT_UI_CLOSE, self.onUIClose, self)
    GameDispatcher:addEventListener(EventName.REFRESH_MIAN_UI_MODEL, self.refreshModel, self)
    GameDispatcher:addEventListener(EventName.PLAY_MAIN_MODEL_ACT, self.onPlayModelAct, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.INIT_SHOW_BOARD_HERO, self.onShowBoardHeroInitHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_SHOW_BOARD_HERO, self.onShowBoardHeroChangeHandler, self)

    GameDispatcher:addEventListener(EventName.CLOSE_CHAT_PANEL, self.onCloseChatPanel, self)
    GameDispatcher:addEventListener(EventName.MOVE_SHOWBOARD_MODEL, self.onMoveShowBoard, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

function loadScene(self)
    super.loadScene(self)
    local sceneRo = fight.SceneManager:getSceneData(self:getMapID())
    if sceneRo then
        StorageUtil:saveString0('pre_scene_name', UrlManager:getScenePath(sceneRo:getScene()))
    end
end

function preloadCall(self, callFun)
    if not mainui.MainUIManager.isShowBigHostel then
        callFun()
    else
        local isActivie = bigHostel.BigHostelSceneController:checkSceneActive()
        if not isActivie then
            local showId = role.RoleManager:getRoleVo():getShowBoardHeroId()
            local heroVo = hero.HeroManager:getHeroVo(showId)
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroVo.tid)

            GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENE, {model_id = heroVo:getHostelModel(), heroConfigVo = heroConfigVo, main_type = BigHostelConst.SceneUI_Type.MIANUI})
        end
    end
end

-- 进入地图
function enterMap(self)
    super.enterMap(self)

    local sceneCamera = gs.CameraMgr:GetSceneCamera()
    if sceneCamera and not gs.GoUtil.IsCompNull(sceneCamera) then
        -- 目前可能有多场景，尝试找到正确场景的正确节点
        local roleNode = gs.GameObject.Find("Role_node")
        local cameraNode = nil
        local sceneRo = fight.SceneManager:getSceneData(self:getMapID())
        if sceneRo then
            local rootObj = gs.GameObject.Find(U3DSceneUtil:getSceneRootName(sceneRo:getScene()))
            if (rootObj) then
                cameraNode = rootObj.transform:Find("OriginalCameraPos")
                cameraNode = cameraNode and cameraNode.gameObject or nil
            else
                cameraNode = gs.GameObject.Find("OriginalCameraPos")
                Debug:log_warn("MapBaseController", string.format("美术未设置%s场景根节点%s", sceneRo:getScene(), U3DSceneUtil:getSceneRootName(sceneRo:getScene())))
            end
        else
            cameraNode = gs.GameObject.Find("OriginalCameraPos")
        end
        -- print(self.__cname, "enterMap", cameraNode, roleNode)
        Perset3dHandler:setSceneShowData(MainCityConst.ROLE_MODE_MAIN, nil, cameraNode and cameraNode.transform or nil, roleNode and roleNode.transform or nil)
    else
        -- print(self.__cname, "enterMap", "设置场景相机为空")
        Perset3dHandler:setSceneShowData(MainCityConst.ROLE_MODE_MAIN, nil, nil, nil)
    end

    if self.m_scene == nil then
        self.m_scene = mainCity.MainCityScene.new()
    end

    self.m_scene:active()
    local isGuide = guide.GuideManager:checkResetGuide()

    if isGuide then
        mainui.MainUIManager:cancelFirstCV()
    end

    if isGuide ~= true then
        self:refreshModel()
    end

    --self:refreshModel()
    -- gs.LightMgr:SetOpenUIGlobalModelLigth(true)

    -- 修改为模型加载完成才通知主UI显示
    -- GameDispatcher:dispatchEvent(EventName.MAIN_CITY_RT_UPDATE, true)
    -- GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI, { isShowTween = true,isFirstCV = true })
    mainCity.MainCityManager.isLoadCompleted = true

    -- 等待主场景加载完成后需要打开的uicode
    local waitOpenUIcode = mainui.MainUIManager:getWaitOpenUIcode()
    if waitOpenUIcode > 0 then
        UIFactory:closeForcibly()
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = waitOpenUIcode})
        mainui.MainUIManager:setWaitOpenUIcode(0)
    end

    -- local videoPanel = gs.GameObject.Find("UI_VIDEO_PANEL")
    -- if videoPanel then
    --     videoPanel:SetActive(false)
    --     self.videoPlayer = videoPanel:GetComponent(ty.VideoPlayer)
    --     if self.videoPlayer then
    --         self.videoPlayer.url = gs.PathUtil.GetExistFullPath("extra/video/ui/mainui_cg.mp4")
    --         self.videoPlayer:Play()
    --         self:updateVideoAudio()
    --     end
    -- end

    -- 通知打开战斗前的功能UI
    -- GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_SHOW_BEFORE_UI)

    -- 检查下新手引导
    if battleMap.MainMapManager.isDataInit then
        if isGuide then
            guide.GuideManager:startTodoEvent()
            if (loginLoad.LoginLoadController:isLoginLoading()) then
                loginLoad.LoginLoadController:destroyLoading()
            end
        end
    end
end

-- 关闭当前地图
function clearMap(self)
    -- gs.LightMgr:SetOpenUIGlobalModelLigth(false)
    if self.m_scene ~= nil then
        self.m_scene:deActive()
        self.m_scene = nil
    end
    GameDispatcher:dispatchEvent(EventName.MAIN_CITY_RT_UPDATE, false)
    Perset3dHandler:removeSceneShowData(MainCityConst.ROLE_MODE_MAIN)
    GameDispatcher:dispatchEvent(EventName.HIDE_MAIN_UI)
    super.clearMap(self)

    mainCity.MainCityManager.isLoadCompleted = false

    -- if self.videoPlayer then
    --     self.videoPlayer:Stop()
    --     self.videoPlayer = nil
    -- end
end
-- function playSceneMusic(self)
--     -- 主场景音乐自己管理
-- end

-- 播放场景音乐,
function playMainCityMusic(self)
    local sceneRo = fight.SceneManager:getSceneData(self:getMapID())
    if sceneRo then
        -- 场景音乐
        -- AudioManager:playMusicListByIds(sceneRo:getVoiceList(), sceneRo:getPlayType())
        AudioManager:playMusicById(sceneRo:getMusicId())
    end
end

-- 通知打开战斗前的功能UI
function checkOpenFightBeforeUI(self)
    -- 置空
end

--视频音效
function updateVideoAudio(self)
    if systemSetting.SystemSettingManager:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.totalVolumeSwitch) and systemSetting.SystemSettingManager:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.musicVolumeSwitch) then
        self.videoPlayer:SetDirectAudioVolume(0, systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.musicVolume) / 100)
    else
        self.videoPlayer:SetDirectAudioVolume(0, 0)
    end
end

function onUIOpen(self, args)
    LoopManager:removeFrameByIndex(self.showMainuiFrameSn)

    -- if args.panelName == 'game.mail.view.MailView' then
    --     self.m_scene:modelMoveAction(1)
    --     return
    -- end
    if args.panelName == 'chat.ChatPanel' then
        if self.m_scene then
            -- GameDispatcher:dispatchEvent(EventName.HIDE_MAIN_UI)
            -- self.m_scene:moveCamera(2)
        end
        return
    end
    if args.panelName == 'showBoard.ShowBoardHeroPanel2' then
        GameDispatcher:dispatchEvent(EventName.HIDE_MAIN_UI)
        return
    end

    if args.panelType == 1 then
        LoopManager:removeFrameByIndex(self.closeTimeSn)
        self:hideMainScene()
        GameDispatcher:dispatchEvent(EventName.HIDE_MAIN_UI)
    end
end

function onUIClose(self, args)
    local isAllClose = gs.PopPanelManager.AllPanelIsClose()
    if (not isAllClose) then
        return
    end
    if storyTalk.StoryTalkManager:getNotAllowdPlay() then
        -- 剧情中
        return
    end

    if args.panelName == "guide.GuidePanel" then
        return
    end

    self.closeTimeSn = LoopManager:addFrame(5, 1, self, function()
        if mainui.MainUIManager.isShowBigHostel and bigHostel.BigHostelSceneController:checkSceneActive() then
            GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI, {isShowTween = true, isFirstCV = false})
            return
        end
        if ((args.panelType == 1 or args.panelType == 3) and args.panelName ~= "login.DebugLoginView" and args.panelName ~= "login.LoginView") or args.panelName == "guide.GuidePanel"
            then
            self:showMainScene()
        end
    end)

    -- LoopManager:removeFrameByIndex(self.showMainuiFrameSn)
    -- self.showMainuiFrameSn = LoopManager:addFrame(1, 1, self, function()
    --     --有引导点击的内容
    --     if args.panelType == 1 or args.panelName == "guide.GuidePanel" then
    --         if self.m_scene then
    --             self.m_scene:setSceneActive(true)
    --             GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI)
    --         end
    --     end
    -- end)
end

function showMainScene(self, isChange)
    if mainui.MainUIManager.isShowBigHostel then
        
        return
    end
    if self.m_scene then
        self.m_scene:setSceneActive(true, isChange)
    end
end

function hideMainScene(self)
    if self.m_scene then
        self.m_scene:setSceneActive(false)
    end
end

function onCloseChatPanel(self)
    if self.m_scene then
        -- self.m_scene:moveCamera(1)
        -- GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI, { isShowScreenSaver = false })
    end
end

-- 看板娘初始
function onShowBoardHeroInitHandler(self, isChange)
    -- 登录界面还没关闭时，不关闭登录界面和登录的音乐
    if (not login.LoginManager:getLoginViewVisible()) then
        -- AudioManager:stopMusic()
        gs.PopPanelManager.CloseAll()
    end
    self:refreshModel(isChange)
end

-- 移动看板娘
function onMoveShowBoard(self, args)
    if self.m_scene then
        if args.open == true then
            self.m_scene:setMoveModel(true)
            --GameDispatcher:dispatchEvent(EventName.SET_MAIN_SCENE_GYRO,false)
        end

        local roleNode = gs.GameObject.Find("Role_node").transform
        local moveX = args.moveX
        local time = args.time
        local newPos = roleNode.position + gs.Vector3(moveX, 0, 0)
        TweenFactory:move2pos(roleNode, newPos, time, nil, function()
            if args.open == false then
                self.m_scene:setMoveModel(false)
                --GameDispatcher:dispatchEvent(EventName.SET_MAIN_SCENE_GYRO,true)
            end
        end)
    end
end

-- 看板娘变化
function onShowBoardHeroChangeHandler(self)
    local isAllClose = gs.PopPanelManager.AllPanelIsClose()
    if (not isAllClose) then
        return
    end
    local bool = not mainui.MainUIManager.isDragSpine
    self:onShowBoardHeroInitHandler(bool)
end

-- 刷新主场景模型
function refreshModel(self, isChange)
    mainui.MainUIManager.isDragSpine = nil
    if isChange then
        mainui.MainUIManager:setIsShowDynamic(0)-- 切换模型，默认显示模型
    end
    if self.m_scene then
        self.m_scene:updateModel(isChange)
    end
end

-- 主界面模型移动动画
-- function setModelMove(self, cusX, cusRotateY)
--     if self.m_scene then
--         self.m_scene:modelMoveAction(cusX, cusRotateY)
--     end
-- end

-- 英雄互动播放动画
function onPlayModelAct(self, args)
    if self.m_scene then
        local ret, baseData = self.m_scene:playAction()
        if ret == true then
            GameDispatcher:dispatchEvent(EventName.MODEL_PLAYED, baseData)
        end
        self.m_scene:playSpineAnim()
    end
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.MAIN_CITY
end

-- 地图资源名
function getMapID(self)
    return 1
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
