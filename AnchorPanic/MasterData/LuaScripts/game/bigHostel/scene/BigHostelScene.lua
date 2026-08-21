-- @FileName:   BigHostelScene.lua
-- @Description: BigHostel scene
-- @Author: ZDH
-- @Date:   2025-04-21 17:35:49
-- @Copyright:   (LY) 2025

module('game.bigHostel.scene.BigHostelScene', Class.impl())

function ctor(self)

end

function setup(self, finishCall)
    if self.m_model ~= nil then
        return
    end

    local isHar = RefMgr:getSpecialConfig() and sdk.ChannelData:getIsChannelHarmonious()

    -- local function isLuaFileExist(classPath)
    -- local luaFile = "LuaScripts/" .. classPath .. ".lua"
    -- return gs.File.Exists(gs.PathUtil.GetPersistentAssetsWPath(luaFile)) or gs.File.Exists(gs.PathUtil.GetStreamingAssetsPath(luaFile))
    -- end

    local model_data = bigHostel.BigHostelManager:getHostelHero()

    local function createModel(classPath, prefabGo)
        self.m_model = require(classPath):new()
        bigHostel.BigHostelManager:setSceneModel(self.m_model)

        self.m_model:setPrefab(model_data, prefabGo, function ()
            if model_data.main_type == BigHostelConst.SceneUI_Type.MIANUI then
                GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI, {isShowTween = true, isFirstCV = true})
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENEUI, {main_type = model_data.main_type})
            end

            local data = fashion.FashionManager:getModelHarData(model_data.model_id)
            if isHar and data then
                self.mHarFrameSn = LoopManager:addFrame(1, 1, self, function()
                    self.m_model:setMaterial(data.pos, data.materials, {})
                end)
            end

            if finishCall then
                finishCall()
            end
        end)
    end

    local normalClassPath = UrlManager:getBigHostelModelClassPath(model_data.model_id)
    local harClassPath = UrlManager:getBigHostelModelClassPath(model_data.model_id, true)
    local normalPrefabPath = UrlManager:getBigHostelPrefabPath(model_data.model_id)

    if model_data.model_id == "4530_2_h" then
        self.m_loadSn = gs.ResMgr:LoadGOAysn(normalPrefabPath, function(go)
            self.m_loadSn = nil

            if go then
                local isHarGo = go.transform:Find("Root_node/is_har")
                if gs.GoUtil.IsTransNull(isHarGo) then
                    createModel(normalClassPath, go)
                else
                    createModel(harClassPath, go)
                end
            else
                logError(normalPrefabPath .. "加载失败")
                if finishCall then
                    finishCall(false)
                end
            end
        end)
    else
        local harPrefabPath = UrlManager:getBigHostelPrefabPath(model_data.model_id, true)
        local function loadPrefab(loadData)
            self.m_loadSn = gs.ResMgr:LoadGOAysn(loadData.prefabPath, function(go)
                self.m_loadSn = nil

                if go then
                    createModel(loadData.classPath, go)
                else
                    logError(loadData.prefabPath .. "加载失败")
                    if finishCall then
                        finishCall(false)
                    end
                end
            end)
        end

        local loadNormal = function ()
            if model_data.model_id == "1503_5_h" or model_data.model_id == "4535_2_h" then
                local lymdenClassPath = string.format("game/bigHostel/manager/model/BigHostel_Model_%s_lymden", model_data.model_id)
                local lymdenPrefabPath = string.format("arts/character/scene_module_3Dhostel/%s_lymden/model%s_lymden.prefab", model_data.model_id, model_data.model_id)

                loadPrefab({prefabPath = lymdenPrefabPath, classPath = lymdenClassPath})
            else
                loadPrefab({prefabPath = normalPrefabPath, classPath = normalClassPath})
            end
        end

        if isHar then
            -- if isLuaFileExist(harClassPath) then
            if model_data.model_id == "1503_5_h" or model_data.model_id == "4535_2_h" then
                loadPrefab({prefabPath = harPrefabPath, classPath = harClassPath})
            else
                loadNormal()
            end
        else
            loadNormal()
        end
    end
end

function reset(self)
    if self.m_loadSn and self.m_loadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_loadSn)
        self.m_loadSn = nil
    end

    if self.m_model then
        self.m_model:destroy()
        self.m_model = nil
    end

    bigHostel.BigHostelManager:setSceneModel(nil)
end

return _M
