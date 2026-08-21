--[[
     场景地图控制器基础类
]]
module('map.MapBaseController', Class.impl(Controller))

function ctor(self)
    super.ctor(self)
    map.MapLoader:regMap(self:getMapType(), self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

-- 加载地图
function loadScene(self)
    map.MapLoader:loadScene(self)
end

-- 进入地图
function enterMap(self)
    if (gs.Application.platform ~= gs.RuntimePlatform.WindowsPlayer) then
        if (self:getMapType() == MAP_TYPE.FIGHT_MAP) then
            -- 清除缓存策略
            gs.ResMgr:ClearRule()
        end
    end

    local defAudioListener = nil
    if gs.AudioManager then
        defAudioListener = gs.AudioManager.gameObject:GetComponent(ty.AudioListener)
        if gs.GoUtil.IsCompNull(defAudioListener) then
            defAudioListener = nil
        end
    end

    local scCameraGo = gs.GameObject.Find("[SCamera]")
    local globalIllum = gs.GameObject.Find("GlobalIllum")
    if scCameraGo then
        if defAudioListener then
            defAudioListener.enabled = false
        end
        local cameraCom = scCameraGo:GetComponent(ty.Camera)
        gs.CameraMgr:SetSceneCamera(cameraCom)
        PostHandler:initChromatioc()
        -- gs.CameraMgr:SetRenderCamera(cameraCom)
        gs.GlobalIllumMgr:SetGlobalIllum(globalIllum)
        if cameraCom then
            -- fight.FightManager:postGmDebugInit()
            local layerIdx = gs.LayerMask.NameToLayer("HideLayer");
            gs.CameraMgr:RemoveCullingMask(cameraCom, layerIdx)

            -- Debug 使用
            if fight.FightManager.m_gmOpenLowShader ~= null then
                if fight.FightManager.m_gmOpenLowShader == true then
                    local shader = gs.Shader.Find("LeiyanFX/Scene/UnlitDiff");
                    cameraCom:SetReplacementShader(shader, "")
                else
                    cameraCom:ResetReplacementShader()
                end
            end
            if fight.FightManager.m_gmOpenPostprocess ~= nil then
                local postProcess = scCameraGo:GetComponent(ty.PostProcessing)
                if postProcess then
                    postProcess.PostProcessToggle = fight.FightManager.m_gmOpenPostprocess or false
                end
            end
        end
    else
        gs.CameraMgr:SetSceneCamera(nil)
    end

    --生效系统设置的参数
    systemSetting.SystemSettingManager:onLoadSceneApply()

    -- 播放场景环境音效
    if self.m_mapEnvAudio then
        AudioManager:stopAudioSound(self.m_mapEnvAudio)
        self.m_mapEnvAudio = nil
    end

    self:playSceneMusic()
    -- self:checkOpenFightBeforeUI()
end

-- 播放场景音乐
function playSceneMusic(self)
    local sceneRo = fight.SceneManager:getSceneData(self:getMapID())
    if sceneRo then
        -- AudioManager:playMusicListByIds(sceneRo:getVoiceList(), sceneRo:getPlayType())
        AudioManager:playMusicById(sceneRo:getMusicId())
    end
end

-- 关闭当前地图
function clearMap(self)
    if (gs.Application.platform ~= gs.RuntimePlatform.WindowsPlayer) then
        -- 设置缓存策略
        SetCacheRule()

        -- local list = {"arts/fx/3d/role/prefab","arts/fx/3d/sceneModule/maze","arts/audio/cv","arts/audio/sfx","arts/character"}
        -- for i = 1,#list do
        --     gs.ResMgr:UnLoadAssetBundle(list[i])
        -- end
    end
    -- print(self.__cname, "clearMap", "清理")
    Perset3dHandler:reset()
    if self.m_mapEnvAudio then
        AudioManager:stopAudioSound(self.m_mapEnvAudio)
        self.m_mapEnvAudio = nil
    end
    gs.CameraMgr:DontDeseyGraphicBlitCamera()
end

-- 通知打开战斗前的功能UI
function checkOpenFightBeforeUI(self)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_SHOW_BEFORE_UI)
end

function pauseMapEnvAudio(self)
    if self.m_mapEnvAudio then
        self.m_mapEnvAudio:pauseAudioData()
    end
end

function resumeMapEnvAudio(self)
    if self.m_mapEnvAudio then
        self.m_mapEnvAudio:resumeAudioData()
    end
end

-- 离开地图(返回主城)  退出当前场景时调用
function onEnterMainCity(self)
    self:clearMap()
    -- GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, {mapType = MAP_TYPE.MAIN_CITY})
end

-- 开始加载前
function beforeLoad(self)

end

-- 地图类型
function getMapType(self)
    return 0
end

-- 地图ID
function getMapID(self)
    return nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
