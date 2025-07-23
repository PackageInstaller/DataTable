-- UI模型展示
module("Perset3dHandler", Class.impl())

function ctor(self)
    -- 默认场景根节点（[3D_PRESET]）
    self.mRootGo = nil
    -- 展示类型
    self.mShowType = nil
    -- 非main类型
    self.mShowHeroType = nil

    -- 场景自带的摄像机参数记录
    self.mScameraTransParent = nil
    self.mScameraTransLPos = nil
    self.mScameraTransRotation = nil

    -- 默认的摄像机参数记录
    self.mDefSCameraTransParent = nil
    self.mDefSCameraTransLPos = nil
    self.mDefSCameraTransRotation = nil
    self.mDefSCameraFov = nil

    -- 默认相机父节点默认参数
    self.mDefSCameraParentLPos = nil
    self.mDefSCameraParentRotation = nil

    -- 展示类型用到的节点数据字典
    self.mSceneShowDataDic = {}
    -- 角色挂点原始数据
    self.mRoleNodeData = {}

    -- 特效相关
    self.mPresetExRootTrans = nil
    self.mPresetRecords = nil
    self.mPresetFxGo = nil
    self.mPresetFxs = nil

    -- 背景板资源路径
    self.mBgSRenderPath = nil

    -- tween缓存
    self.mTweenList = {}
end

-- 初始创建节点
function createRoot(self)
    local rootGo = gs.GameObject.Find("[3D_PRESET]")
    if not rootGo then
        rootGo = gs.ResMgr:LoadGO("arts/fx/3d/scene/game/[3D_PRESET].prefab")
        rootGo.name = "[3D_PRESET]"
    end
    gs.GoUtil.DontDestroyOnLoad(rootGo)
    self.mRootGo = rootGo.transform
    rootGo:SetActive(true)

    -- 根节点[3D_PRESET]
    self.mRootGo = rootGo
    gs.GoUtil.DontDestroyOnLoad(rootGo)
    local rootTrans = rootGo.transform

    -- 无UI背景墙、模型展示用节点（多个相机节点）
    local nodeOverViewTrans = rootTrans:Find("UI_OVERVIEW")
    local overViewRoleNode = nodeOverViewTrans:Find("ROLE_NODE")
    local decorateNode = nodeOverViewTrans:Find("DECORATE_NODE")
    self:setSceneShowData(MainCityConst.ROLE_MODE_OVERVIEW, nodeOverViewTrans, nodeOverViewTrans:Find("OVERVIEW_CAMERA_NODE"), overViewRoleNode, nil, decorateNode)
    self:setSceneShowData(MainCityConst.ROLE_MODE_CULTIVATE, nodeOverViewTrans, nodeOverViewTrans:Find("CULTIVATE_CAMERA_NODE"), overViewRoleNode, nil, decorateNode)
    self:setSceneShowData(MainCityConst.ROLE_MODE_INTERACTION, nodeOverViewTrans, nodeOverViewTrans:Find("INTERACTION_CAMERA_NODE"), overViewRoleNode, nil, decorateNode)
    self:setSceneShowData(MainCityConst.ROLE_MODE_CLIP, nodeOverViewTrans, nodeOverViewTrans:Find("CLIP_CAMERA_NODE"), overViewRoleNode, nil, decorateNode)
    self:setSceneShowData(MainCityConst.ROLE_MODE_MANUAL_MONSTER, nodeOverViewTrans, nodeOverViewTrans:Find("MANUAL_MONSTER_CAMERA_NODE"), overViewRoleNode, nil, decorateNode)
    self:setSceneShowData(MainCityConst.ROLE_MODE_APOSTLE_MONSTER, nodeOverViewTrans, nodeOverViewTrans:Find("APOSTLE_MONSTER_CAMERA_NODE"), overViewRoleNode, nil, decorateNode)

    -- 含UI背景墙、阵型展示用节点（单个相机节点）
    local nodeFormationTrans = rootTrans:Find("UI_FORMATION")
    local decorateNode = nodeFormationTrans:Find("DECORATE_NODE")
    self:setSceneShowData(MainCityConst.ROLE_MODE_FORMATION, nodeFormationTrans, nodeFormationTrans:Find("CAMERA_NODE"), nodeFormationTrans:Find("ROLE_NODE"), nodeFormationTrans:Find("UI_RENDERER"), decorateNode)

    -- 含UI背景墙、模型展示用节点（单个相机节点）
    local nodeNormalTrans = rootTrans:Find("UI_NORMAL")
    local decorateNode = nodeNormalTrans:Find("DECORATE_NODE")
    self:setSceneShowData(MainCityConst.ROLE_MODE_UI, nodeNormalTrans, nodeNormalTrans:Find("CAMERA_NODE"), nodeNormalTrans:Find("ROLE_NODE_FASHION"), nodeNormalTrans:Find("UI_RENDERER"), decorateNode)
    self:setSceneShowData(MainCityConst.APOSTLE_MONSTER_UI, nodeNormalTrans, nodeNormalTrans:Find("APOSTLE_CAMERA_NODE"), nodeNormalTrans:Find("ROLE_NODE"), nodeNormalTrans:Find("UI_RENDERER"), decorateNode)

    -- 含UI背景墙、模型展示用节点（单个相机节点）
    local nodeUICommonTrans = rootTrans:Find("UI_COMMON_BG")
    local decorateNode = nodeUICommonTrans:Find("DECORATE_NODE")
    self:setSceneShowData(MainCityConst.UI_COMMON_3D_BG, nodeUICommonTrans, nodeUICommonTrans:Find("CAMERA_NODE"), nodeUICommonTrans:Find("ROLE_NODE"), decorateNode:Find("[3D_UI_BG]/main/bg"), decorateNode)

    -- 特效相关
    -- self.mPresetExRootTrans = nil
    -- self.mPresetRecords = {}
    -- self.mPresetFxGo = nil
    -- local fxNode = overViewRoleNode:Find("ui_main_10/GameObject/fx_scene_main_10")
    -- if fxNode then
    --     self.mPresetFxGo = fxNode.gameObject
    --     self.mPresetExRootTrans = fxNode.parent
    --     self.mPresetFxs = self.mPresetFxGo:GetComponentsInChildren(ty.ParticleSystem)
    -- end
end

-- 设置对应展示类型用到的节点数据
function setSceneShowData(self, showType, parentNode, cameraNode, roleNode, uiNode, decorateNode)
    if (cameraNode and roleNode) then
        self.mSceneShowDataDic[showType] = { parentNodeTrans = parentNode, cameraNodeTrans = cameraNode, roleNodeTrans = roleNode, uiBgRenderer = uiNode ~= nil and uiNode:GetComponent(ty.MeshRenderer) or nil, decorateNode = decorateNode }
        if showType == MainCityConst.ROLE_MODE_CLIP then
            -- 档案偏5度
            self.mRoleNodeData[showType] = { roleNodePos = roleNode.localPosition, roleNodeRotation = roleNode.localEulerAngles + math.Vector3(0, -5, 0) }
        else
            self.mRoleNodeData[showType] = { roleNodePos = roleNode.localPosition, roleNodeRotation = roleNode.localEulerAngles }
        end
    else
        self:removeSceneShowData(showType)
    end
end

-- 移除对应展示类型用到的节点数据
function removeSceneShowData(self, showType)
    self.mSceneShowDataDic[showType] = nil
end

-- 获取对应展示类型用到的节点数据
function getSceneShowData(self, showType)
    return self.mSceneShowDataDic[showType]
end

-- 清除展示类型用到的节点数据
function clearShowData(self)
    self.mSceneShowDataDic = {}
end

-- 重置场景相机
function __resetSceneCamera(self)
    if self.mScameraTransLPos then
        local scTrans = gs.CameraMgr:GetSceneCameraTrans()
        local defSCTrans = gs.CameraMgr:GetDefSceneCameraTrans()
        if defSCTrans ~= scTrans then
            if scTrans and not gs.GoUtil.IsTransNull(scTrans) then
                scTrans:SetParent(self.mScameraTransParent)
                gs.TransQuick:LPos(scTrans, self.mScameraTransLPos)
                gs.TransQuick:SetLRotation(scTrans, self.mScameraTransRotation)

            end
        end
        self.mScameraTransParent = nil
        self.mScameraTransLPos = nil
        self.mScameraTransRotation = nil
    end
end

-- 重置默认相机
function __resetDefaultSCamera(self)
    if self.mDefSCameraTransParent then
        local scTrans = gs.CameraMgr:GetDefSceneCameraTrans()
        if scTrans and not gs.GoUtil.IsTransNull(scTrans) then
            scTrans:SetParent(self.mDefSCameraTransParent, false)
            -- gs.TransQuick:LPos(scTrans, self.mDefSCameraTransLPos)
            -- gs.TransQuick:SetLRotation(scTrans, self.mDefSCameraTransRotation)
            gs.CameraMgr:GetDefSceneCamera().fieldOfView = self.mDefSCameraFov --默认值
        end
        self.mDefSCameraTransParent = nil
        self.mDefSCameraTransLPos = nil
        self.mDefSCameraTransRotation = nil
        self.mDefSCameraFov = nil
    end
end

-- 转换面板
function setupShowData(self, showType, roleTrans, modelID, bgImgPath, tweenFinishCall)
    if (not self.mRootGo) then
        return
    end
    self.isTweenFinish = false
    -- if(self.mShowType ~= showType and self.mPresetFxGo)then
    -- 	self.mPresetFxGo:SetActive(false)
    -- end
    local showData = self.mSceneShowDataDic[showType]
    if showData then
        -- 多个展示类型的父节点可能相同，做下判断
        local _parentNodeTrans = showData.parentNodeTrans
        for _showType, _showData in pairs(self.mSceneShowDataDic) do
            if (_showType == showType) then
                if (_showData.parentNodeTrans and not gs.GoUtil.IsTransNull(_showData.parentNodeTrans)) then
                    _showData.parentNodeTrans.gameObject:SetActive(true)
                end
            else
                if (_showData.parentNodeTrans and not gs.GoUtil.IsTransNull(_showData.parentNodeTrans) and _showData.parentNodeTrans ~= _parentNodeTrans) then
                    _showData.parentNodeTrans.gameObject:SetActive(false)
                end
            end
        end

        if showType == MainCityConst.UI_COMMON_3D_BG then
            gs.CameraMgr:GetDefSceneCamera():GetComponent(ty.PostProcessing).enabled = false
        else
            gs.CameraMgr:GetDefSceneCamera():GetComponent(ty.PostProcessing).enabled = true
        end

        local scTrans = gs.CameraMgr:GetSceneCameraTrans()
        local defSCTrans = gs.CameraMgr:GetDefSceneCameraTrans()
        if showType == MainCityConst.ROLE_MODE_MAIN then	-- 场景展示
            if scTrans and not gs.GoUtil.IsTransNull(scTrans) then
                if not self.mScameraTransLPos then
                    self.mScameraTransParent = scTrans.parent
                    self.mScameraTransLPos = scTrans.localPosition
                    self.mScameraTransRotation = scTrans.localRotation
                end
                scTrans.gameObject:SetActive(true)
                defSCTrans.gameObject:SetActive(false)
            else
                scTrans = nil
            end
            -- self:clearLampstandGo()
        else
            -- if showType == MainCityConst.ROLE_MODE_FORMATION or showType == MainCityConst.ROLE_MODE_UI or showType == MainCityConst.APOSTLE_MONSTER_UI then
            --     self:clearLampstandGo()
            -- else
            --     -- self:addLampstandGo(UrlManager:get3DSceneFx("scene/fx_scene_main_10_cheng.prefab"))
            -- end

            -- 恢复角色挂点状态
            self:resetRoleNode(showType, showData, tweenFinishCall)

            if scTrans and not gs.GoUtil.IsTransNull(scTrans) then
                scTrans.gameObject:SetActive(false)
                self:__resetSceneCamera()
            end

            if not defSCTrans or gs.GoUtil.IsTransNull(defSCTrans) then
                defSCTrans = nil
            else
                if not self.mDefSCameraTransParent then
                    self.mDefSCameraTransParent = defSCTrans.parent
                    -- self.mDefSCameraTransLPos = defSCTrans.localPosition
                    -- self.mDefSCameraTransRotation = defSCTrans.localRotation.eulerAngles
                    self.mDefSCameraFov = gs.CameraMgr:GetDefSceneCamera().fieldOfView
                end

                defSCTrans.gameObject:SetActive(true)
                local defCamera = gs.CameraMgr:GetDefSceneCamera()
                defCamera.fieldOfView = self.mDefSCameraFov --默认值

                if showType == MainCityConst.ROLE_MODE_FORMATION then
                    defCamera.nearClipPlane = 10
                elseif showType == MainCityConst.ROLE_MODE_OVERVIEW or showType == MainCityConst.ROLE_MODE_CULTIVATE then
                    defCamera.nearClipPlane = 0.1

                    -- table.insert(self.mTweenList, TweenFactory:move2Lpos(defSCTrans, self.mDefSCameraTransLPos, 0.5, gs.DT.Ease.easeOutCubic))
                    -- table.insert(self.mTweenList, TweenFactory:lRotate(defSCTrans, self.mDefSCameraTransRotation, 0.5, gs.DT.Ease.easeOutCubic))
                else
                    defCamera.nearClipPlane = 0.01

                    -- self:__resetDefaultSCamera()
                end
            end
        end
        if defSCTrans and not gs.GoUtil.IsTransNull(defSCTrans) then
            if showData.cameraNodeTrans and not gs.GoUtil.IsTransNull(showData.cameraNodeTrans) then
                -- gs.CameraMgr:SetRenderCamera(defSCTrans:GetComponent(ty.Camera))
                -- systemSetting.SystemSettingManager:applySetting(systemSetting.SystemSettingDefine.pictureQuality)
                -- gs.TransQuick:SetParentOrg(defSCTrans, showData.cameraNodeTrans)
                if showType == MainCityConst.ROLE_MODE_MAIN then
                    -- 不处理
                    self:clearTween()
                elseif (showType == MainCityConst.ROLE_MODE_OVERVIEW or showType == MainCityConst.ROLE_MODE_CULTIVATE or showType == MainCityConst.ROLE_MODE_CLIP)
                and (self.mShowHeroType == MainCityConst.ROLE_MODE_OVERVIEW or self.mShowHeroType == MainCityConst.ROLE_MODE_CULTIVATE or self.mShowHeroType == MainCityConst.ROLE_MODE_CLIP) then
                    defSCTrans:SetParent(showData.cameraNodeTrans)
                    table.insert(self.mTweenList, TweenFactory:move2Lpos(defSCTrans, gs.VEC3_ZERO, 0.5, gs.DT.Ease.easeOutCubic))
                    table.insert(self.mTweenList, TweenFactory:lRotate(defSCTrans, gs.VEC3_ZERO, 0.5, gs.DT.Ease.easeOutCubic))
                else
                    self:clearTween()
                    gs.TransQuick:SetParentOrg(defSCTrans, showData.cameraNodeTrans)
                end
            end
        end
        if roleTrans and showData.roleNodeTrans and not gs.GoUtil.IsTransNull(showData.roleNodeTrans) then
            gs.TransQuick:SetParentOrg(roleTrans, showData.roleNodeTrans)
            if showType ~= MainCityConst.ROLE_MODE_FORMATION then
                local offsetVo = fight.RoleShowManager:getOffsetData(modelID, showType)
                if not table.empty(offsetVo) then
                    gs.TransQuick:LPos(roleTrans, offsetVo[1], offsetVo[2], offsetVo[3])
                end
            end
        end

        -- 重播下特效
        -- if showType ~= MainCityConst.ROLE_MODE_FORMATION and self.mShowType ~= showType and self.mPresetFxGo then
        --     local len = self.mPresetFxs.Length - 1
        --     for i = 0, len do
        --         self.mPresetFxs[i]:Stop()
        --         self.mPresetFxs[i]:Play()
        --     end
        --     -- self.mPresetFxGo:SetActive(true)
        -- end

        -- 设置背景板
        if bgImgPath and showData.uiBgRenderer and not gs.GoUtil.IsCompNull(showData.uiBgRenderer) and showData.uiBgRenderer.sharedMaterial then
            if self.mBgSRenderPath then
                gs.ResMgr:UnLoad(self.mBgSRenderPath)
                self.mBgSRenderPath = nil
            end
            local sprite = gs.ResMgr:Load(bgImgPath)
            -- 没有指定资源类型且同步加载的图片资源返回是texture2d格式
            if sprite then
                if sprite.texture then
                    showData.uiBgRenderer.sharedMaterial:SetTexture("_MainTex", sprite.texture)
                else
                    showData.uiBgRenderer.sharedMaterial:SetTexture("_MainTex", sprite)
                end
                self.mBgSRenderPath = bgImgPath
            end
        end
        self.mShowType = showType

        if showType ~= MainCityConst.ROLE_MODE_MAIN and showType ~= MainCityConst.ROLE_MODE_UI then
            self.mShowHeroType = showType
        end

        if (self.mShowType == MainCityConst.ROLE_MODE_FORMATION
        or self.mShowType == MainCityConst.ROLE_MODE_OVERVIEW
        or self.mShowType == MainCityConst.ROLE_MODE_CULTIVATE
        or self.mShowType == MainCityConst.ROLE_MODE_INTERACTION
        or self.mShowType == MainCityConst.ROLE_MODE_CLIP
        or self.mShowType == MainCityConst.ROLE_MODE_MANUAL_MONSTER
        or self.mShowType == MainCityConst.ROLE_MODE_APOSTLE_MONSTER
        ) then
            gs.GlobalIllumMgr:SetGlobalIllumVisible(false)
            self:showMazeFog(false)
        else
            gs.GlobalIllumMgr:SetGlobalIllumVisible(true)
        end
    else
        -- 没有数据时的处理
        gs.CameraMgr:GetDefSceneCameraTrans().gameObject:SetActive(false)
        local scTrans = gs.CameraMgr:GetSceneCameraTrans()
        if scTrans and not gs.GoUtil.IsTransNull(scTrans) then
            scTrans.gameObject:SetActive(true)
        end
        -- self:__resetSceneCamera()
        -- self:__resetDefaultSCamera()
        gs.GlobalIllumMgr:SetGlobalIllumVisible(true)
        self:showMazeFog(true)

        -- 多个展示类型的父节点可能相同，做下判断
        for _showType, _showData in pairs(self.mSceneShowDataDic) do
            if (_showData.parentNodeTrans and not gs.GoUtil.IsTransNull(_showData.parentNodeTrans)) then
                _showData.parentNodeTrans.gameObject:SetActive(false)
            end
        end
    end
end

--设置迷宫的战争迷雾开关
function showMazeFog(self, value)
    if map.MapLoader:getCurSceneType() ~= MAP_TYPE.MAZE then
        return
    end

    if not self.mFogComponent or gs.GoUtil.IsCompNull(self.mFogComponent) then
        local Fog_obj = gs.GameObject.Find("Fog of War Manager")
        if Fog_obj and not gs.GoUtil.IsGoNull(Fog_obj) then
            self.mFogComponent = Fog_obj:GetComponent(ty.FogOfWarManager)
        end
    end

    if self.mFogComponent and not gs.GoUtil.IsCompNull(self.mFogComponent) then
        if value then
            if self.mFogEffect then
                self.mFogComponent.FogEffect = self.mFogEffect
                self.mFogEffect = nil
            end
        else
            if not self.mFogEffect then
                self.mFogEffect = self.mFogComponent.fogEffect
            end
            self.mFogComponent.FogEffect = 3
        end
    end
end

-- 还原为默认的主场景展示模型 (有的话)
function toNormalShowData(self)
    if (not self.mRootGo) then
        return
    end
    self:setupShowData(MainCityConst.ROLE_MODE_MAIN, nil, nil, nil)
    -- local scTrans = gs.CameraMgr:GetSceneCameraTrans()
    -- if scTrans and not gs.GoUtil.IsTransNull(scTrans) then
    -- 	scTrans.gameObject:SetActive(true)
    -- end
    -- self.m_presetCameraGo:SetActive(false)
    -- if self.mBgSRenderPath then
    -- 	gs.ResMgr:UnLoad(self.mBgSRenderPath)
    -- 	self.mBgSRenderPath = nil
    -- end
end

-- 恢复角色挂点状态
function resetRoleNode(self, showType, showData, tweenFinishCall)
    local roleNodeData = self.mRoleNodeData[showType]
    if roleNodeData then
        if showType == MainCityConst.ROLE_MODE_OVERVIEW or showType == MainCityConst.ROLE_MODE_CLIP or showType == MainCityConst.ROLE_MODE_CULTIVATE then
            table.insert(self.mTweenList, TweenFactory:lRotate2(showData.roleNodeTrans, roleNodeData.roleNodeRotation, 0.5, gs.DT.Ease.easeOutCubic))
            table.insert(self.mTweenList, TweenFactory:move2Lpos(showData.roleNodeTrans, roleNodeData.roleNodePos, 0.5, gs.DT.Ease.easeOutCubic, function()
                self.isTweenFinish = true
                if tweenFinishCall then
                    tweenFinishCall()
                end
            end))
        else
            self.isTweenFinish = true
            gs.TransQuick:LPos(showData.roleNodeTrans, roleNodeData.roleNodePos)
            gs.TransQuick:SetLRotation(showData.roleNodeTrans, roleNodeData.roleNodeRotation)
        end
    end

end

-- 添加底座的特效
-- function addLampstandGo(self, prefabPath)
--     if (self.mPresetRecords[prefabPath]) then
--         return
--     end
--     local function _finishCall(eftGo)
--         if eftGo then
--             eftGo.transform:SetParent(self.mPresetExRootTrans, false)
--             eftGo:SetActive(true)
--         end
--         self.mPresetRecords[prefabPath] = eftGo
--     end
--     local sn = gs.GOPoolMgr:GetAsyc(prefabPath, _finishCall)
--     if not self.mPresetRecords[prefabPath] then
--         self.mPresetRecords[prefabPath] = sn
--     end
-- end

-- 移除底座的特效
-- function removeLampstandGo(self, prefabPath)
--     local data = self.mPresetRecords[prefabPath]
--     if data then
--         if type(data) == "number" then
--             gs.GOPoolMgr:CancelAsyc(data)
--         else
--             data:SetActive(false)
--             gs.GOPoolMgr:Recover(data, prefabPath)
--         end
--         self.mPresetRecords[prefabPath] = nil
--     end
-- end

-- 清空底座的特效
-- function clearLampstandGo(self)
--     for prefabPath, data in pairs(self.mPresetRecords) do
--         if data then
--             if type(data) == "number" then
--                 gs.GOPoolMgr:CancelAsyc(data)
--             else
--                 data:SetActive(false)
--                 gs.GOPoolMgr:Recover(data, prefabPath)
--             end
--         end
--     end
--     self.mPresetRecords = {}
-- end

function clearTween(self)
    for i, tween in ipairs(self.mTweenList) do
        if tween then
            tween:Kill()
        end
    end
    self.mTweenList = {}
end

-- 重置
function reset(self)
    gs.CameraMgr:GetDefSceneCameraTrans().gameObject:SetActive(false)
    self:clearTween()
    self:__resetSceneCamera()
    self:__resetDefaultSCamera()
    -- self:clearLampstandGo()
    gs.GlobalIllumMgr:SetGlobalIllumVisible(true)
    self.mShowHeroType = nil
    self:showMazeFog(true)

    -- local scTrans = gs.CameraMgr:GetSceneCameraTrans()
    -- local defSCTrans = gs.CameraMgr:GetDefSceneCameraTrans()
    -- print("Perset3dHandler", "重置后场景相机为"..scTrans.name.."，展示相机为"..defSCTrans.name)
end

-- 显示展示场景
function showAdditiveScene(self, showType, loadCall, finishCall, isShowLoad)
    local sceneName = nil
    if (showType == MainCityConst.ROLE_MODE_MAIN) then 			--主界面
    elseif (showType == MainCityConst.ROLE_MODE_OVERVIEW) then 	--总览
        sceneName = "ui_main_10"
    elseif (showType == MainCityConst.ROLE_MODE_CULTIVATE) then 	--养成
        sceneName = "ui_main_10"
    elseif (showType == MainCityConst.ROLE_MODE_INTERACTION) then --互动
        sceneName = "ui_main_10"
    elseif (showType == MainCityConst.ROLE_MODE_CLIP) then		--芯片
        sceneName = "ui_main_10"
    elseif (showType == MainCityConst.ROLE_MODE_FORMATION) then 	--编队
    elseif (showType == MainCityConst.ROLE_MODE_UI or showType == MainCityConst.APOSTLE_MONSTER_UI) then			--UI
        sceneName = "ui_main_10"
    end
    if (sceneName) then
        if ((isShowLoad == nil or isShowLoad == true) and not fight.SceneManager:isInFightScene() and not fight.FightManager:getIsFighting()) then
            UIFactory:startForcibly()
        end
        local function _finishCall()
            if (finishCall) then
                finishCall()
            end
            self:setupShowData(showType, nil, nil, nil)
            if ((isShowLoad == nil or isShowLoad == true) and not fight.SceneManager:isInFightScene() and not fight.FightManager:getIsFighting()) then
                UIFactory:closeForcibly()
            end
        end
        U3DSceneUtil:loadSceneAdditive(sceneName, loadCall, _finishCall)
    end
end

-- 隐藏展示场景
function hideAdditiveScene(self)
    U3DSceneUtil:recoverSceneSingle()
    self:toNormalShowData()
end

return _M


--[[ 替换语言包自动生成，请勿修改！
]]