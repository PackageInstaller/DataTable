module('utils.U3DSceneUtil', Class.impl())

function ctor(self)
    self:reset()
end

function reset(self)
    self.mSingleSceneName = nil
    self.mSingleScene = nil
    self.mAdditiveSceneNameList = {}
    self:resetTimeOut()
end

function resetTimeOut(self)
    if (self.mTimeSn) then
        LoopManager:clearTimeout(self.mTimeSn)
        self.mTimeSn = nil
    end
end

-- 回调函数、调用self
function loadSceneSingle(self, sceneName, loadCall, finishCall)
    RedPointManager:clearAll()
    -- 登录界面还没关闭时，不关闭登录界面和登录的音乐
    if (not login.LoginManager:getLoginViewVisible()) then
        AudioManager:stopMusic()
        gs.PopPanelManager.CloseAll(false)

        GCUtil.collectLuaGC()
        GCUtil.colllectCSharpGC()

        -- 统一清理(3v3竞技场，全部清理)
        if fight.FightManager:getLatestBattleType() == PreFightBattleType.Arena_Peak_Pvp or fight.FightManager:getLatestBattleType() == PreFightBattleType.GuildWar then
            print("===========3v3竞技场 or 联盟团战，清理全部资源")
            gs.GOPoolMgr:ClearAll()
            gs.ResMgr:ForceUnload(true, true)
            self:UnLoadAssetBundle({ "arts/fx/3d/role/prefab", "arts/fx/3d/sceneModule/maze", "arts/audio", "arts/character" })
        
        else
            -- gs.GOPoolMgr:ClearSameRes({ "arts/audio/cv", "arts/audio/sfx", "arts/audio/story", "arts/audio/UI", "arts/audio/amb",
            -- "arts/fx/3d/role/prefab/monster", "arts/fx/3d/role/prefab/boss", "arts/fx/3d/role/prefab/common", "arts/fx/ui",
            -- "arts/prefabs/ui" }) --指定清理
            gs.GOPoolMgr:ClearAll(unpack({ "arts/fx/3d/role/prefab/skill" })) --排除清理
            gs.ResMgr:ForceUnload(false, true, unpack({ "arts/fx/3d/role/prefab/skill", "arts/character/role", "arts/character/weapon", "arts/character/animat/role_fight", "arts/character/animat/weapon_fight" })) --排除清理
            self:UnLoadAssetBundle({ "arts/audio", "arts/character/monster", "arts/character/animat", "arts/fx/3d/role/prefab/monster", "arts/fx/3d/role/prefab/boss", "arts/fx/3d/role/prefab/common", "arts/fx/3d/role/prefab/hit", "arts/fx/3d/role/prefab/always" })
        end

        if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
            local systemGBSize = math.ceil(gs.SdkManager:GetMemorySize("SystemTotalMemory") / 1024)
            local usedGBSize = math.ceil(gs.SdkManager:GetMemorySize("GameUsedMemory") / 1024)
            if ((systemGBSize <= 5 and usedGBSize >= 2.4) or (5 < systemGBSize and systemGBSize <= 10 and usedGBSize >= 3.5) or (10 < systemGBSize and usedGBSize >= 4)) then
                pcall(function()
                    gs.GOPoolMgr:ClearAll()
                    gs.ResMgr:ForceUnload(true, true)

                    self:UnLoadAssetBundle({ "arts/fx/3d/role/prefab", "arts/fx/3d/sceneModule/maze", "arts/audio", "arts/character" })
                end)
            else
                if (systemGBSize < 6) then
                    pcall(function()
                        gs.GOPoolMgr:ClearAll(unpack({ "arts/fx/3d/role/prefab/skill" }))
                        gs.ResMgr:ForceUnload(false, true, unpack({ "arts/fx/3d/role/prefab/skill", "arts/character/role", "arts/character/weapon" }))
                        self:UnLoadAssetBundle({ "arts/audio", "arts/character/monster", "arts/character/animat", "arts/fx/3d/role/prefab/monster", "arts/fx/3d/role/prefab/boss", "arts/fx/3d/role/prefab/common", "arts/fx/3d/role/prefab/hit", "arts/fx/3d/role/prefab/always" })
                    end)
                end
            end
        elseif (web.WebManager.platform == web.DEVICE_TYPE.IOS) then
            local deviceModel, count = string.gsub(string.lower(CS.UnityEngine.SystemInfo.deviceModel), " ", "")
            local paramList = string.split(deviceModel, ",")
            local model = paramList[1]
            local id = 0
            if (string.find(model, "iphone") ~= nil) then
                local iphoneId, idCount = string.gsub(model, "iphone", "")
                id = tonumber(iphoneId)
                model = "iphone"
            elseif (string.find(model, "ipa") ~= nil) then
                id = 0
                model = "ipa"
            end

            if ((model == "iphone" and id >= 13) or model == "ipa") then
                -- pcall(function()
                --     gs.ResMgr:ForceUnload(false, true, unpack({ "arts/character/role", "arts/character/weapon", "arts/character/animat/role_fight", "arts/character/animat/weapon_fight" }))
                -- end)
            else
                pcall(function()
                    gs.GOPoolMgr:ClearAll(unpack({ "arts/fx/3d/role/prefab/skill" }))
                    gs.ResMgr:ForceUnload(false, true, unpack({ "arts/fx/3d/role/prefab/skill", "arts/character/role", "arts/character/weapon" }))
                    self:UnLoadAssetBundle({ "arts/audio", "arts/character/monster", "arts/character/animat", "arts/fx/3d/role/prefab/monster", "arts/fx/3d/role/prefab/boss", "arts/fx/3d/role/prefab/common", "arts/fx/3d/role/prefab/hit", "arts/fx/3d/role/prefab/always" })
                end)
            end
        end
    end
    -- if (self.mSingleSceneName ~= sceneName) then
    self.mSingleSceneName = sceneName
    self.mSingleScene = nil
    self:__loadScene(sceneName, loadCall, finishCall, gs.LoadSceneMode.Single)
    -- else
    --     self:__initScene(sceneName, gs.LoadSceneMode.Single)
    --     if loadCall ~= nil then
    --         loadCall(100)
    --     end
    --     if finishCall ~= nil then
    --         finishCall()
    --     end
    -- end
end

-- 彻底释放ab包
function UnLoadAssetBundle(self, list)
    for i = 1, #list do
        gs.ResMgr:UnLoadAssetBundle(list[i])
    end
end

-- 回调函数、调用self
function loadSceneAdditive(self, sceneName, loadCall, finishCall)
    if (table.indexof(self.mAdditiveSceneNameList, sceneName) == false) then
        table.insert(self.mAdditiveSceneNameList, sceneName)
        self:__loadScene(sceneName, loadCall, finishCall, gs.LoadSceneMode.Additive)
    else
        self:__initScene(sceneName, gs.LoadSceneMode.Additive)
        if loadCall ~= nil then
            loadCall(100)
        end
        if finishCall ~= nil then
            finishCall()
        end
    end
end

-- 恢复single场景
function recoverSceneSingle(self)
    self:loadSceneSingle(self.mSingleSceneName)
end

function __initScene(self, sceneName, loadMode)
    self:setActiveScene(sceneName)
    for i = #self.mAdditiveSceneNameList, 1, -1 do
        local _sceneName = self.mAdditiveSceneNameList[i]
        if (_sceneName ~= sceneName) then
            self:unLoadScene(table.remove(self.mAdditiveSceneNameList, i))
        end
    end

    if (not self.mSingleScene) then
        self.mSingleScene = gs.GameObject.Find(self:getSceneRootName(self.mSingleSceneName))
    end
    if (self.mSingleScene) then
        self.mSingleScene:SetActive(sceneName == self.mSingleSceneName)
    else
        Debug:log_warn("U3DSceneUtil", string.format("美术未设置%s场景根节点%s", sceneName, self:getSceneRootName(self.mSingleSceneName)))
    end
end

-- 回调函数、调用self
function __loadScene(self, sceneName, loadCall, finishCall, loadMode)
    local function _loadProcess(loadPro)
        -- Debug:log_info('U3DSceneUtil', '场景加载：' .. sceneName .. '----' .. loadPro .. '%')
        if loadPro < 100 then
            if loadCall ~= nil then
                loadCall(loadPro)
            end
        else
            self:resetTimeOut()
            -- 安卓加载并非100就切换成功，需要延迟一点才能完全释放老场景后进入新场景（重要）
            self.mTimeSn = LoopManager:setTimeout(0.25, self, function()
                self:resetTimeOut()
                self:__initScene(sceneName, loadMode)
                if loadCall ~= nil then
                    loadCall(loadPro)
                end
                if finishCall ~= nil then
                    finishCall()
                end
            end)
        end
    end
    -- UIFactory:loadingMask(1)
    sceneName = string.lower(sceneName)
    local scenePath = "arts/scene/" .. sceneName .. ".unity"
    if (GameManager:getIsExiting() == true) then
        gs.ResMgr:LoadScene(sceneName, scenePath, loadMode)
        _loadProcess(100)
    else
        gs.ResMgr:LoadSceneAsync(sceneName, scenePath, _loadProcess, loadMode)
    end
end

-- 设置激活场景
function setActiveScene(self, sceneName)
    local isOk, value = pcall(
        function() 
            gs.SceneManager.SetActiveScene(gs.SceneManager.GetSceneByName(sceneName)) 
        end
    )
    if not isOk then
        logError("激活场景" .. sceneName .. "出错：" .. value)
    end
end

function unLoadScene(self, sceneName, loadCall, finishCall)
    local function _loadProcess(loadPro)
        -- Debug:log_info('U3DSceneUtil', '场景卸载：' .. sceneName .. '----' .. loadPro .. '%')
        if loadPro < 100 then
            if loadCall ~= nil then
                loadCall(loadPro)
            end
        else
            if loadCall ~= nil then
                loadCall(loadPro)
            end
            if finishCall ~= nil then
                finishCall(loadPro)
            end
        end
    end
    sceneName = string.lower(sceneName)
    local scenePath = "arts/scene/" .. sceneName .. ".unity"
    gs.ResMgr:UnLoadSceneAsync(sceneName, scenePath, _loadProcess)
end

-- 对应场景根节点
function getSceneRootName(self, sceneName)
    return string.format("scene_root_%s", sceneName)
end

-- 取当前激活的场景
function getActiveScene(self)
    return gs.SceneManager.GetActiveScene()
end

-- 目前可能有多场景，尝试找到正确场景的相机
function getSceneCamera(self, sceneName)
    local rootObj = gs.GameObject.Find(self:getSceneRootName(sceneName))
    if (rootObj) then
        local cameraTrans = rootObj.transform:Find("OriginalCameraPos").transform:Find("[SCamera]")
        return cameraTrans:GetComponent(ty.Camera)
    else
        Debug:log_warn("MapBaseController", string.format("美术未设置%s场景根节点%s", sceneName, self:getSceneRootName(sceneName)))
    end
end

return _M