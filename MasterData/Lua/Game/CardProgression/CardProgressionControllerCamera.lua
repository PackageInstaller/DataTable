------------ import ------------
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
local URPCameraController      = CS.Game.Native.URP.URPCameraController
local DOTween                  = CS.DG.Tweening.DOTween
---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
---@type Engine.Lib.KCookie
local KCookie                  = CS.Engine.Lib.KCookie
local sceneManagement          = SceneManagement:GetInstance()
local UINavigationBarRoot      = CS.UINavigationBarRoot
local cardConfMgr              = CardConfMgr:GetInstance()
local Ease = CS.DG.Tweening.Ease
------------ import ------------

------------ define ------------
local isNull     = isNull
local Quaternion = Quaternion
local Duration3  = 0.3
local Duration4  = 0.4
local Duration5  = 0.5
local VectorZero = Vector3.zero
local VectorOne = Vector3.one

local LightIntensityId = CS.UnityEngine.Shader.PropertyToID("_LightIntersity")

local CameraState = CardProgressionConstants.CameraState
local function DTSequence(transform, pos, rot, duration, isWorldSpace)
    duration = duration or Duration5
    local sequence = DOTween.Sequence()
    sequence:Append(isWorldSpace and transform:DOMove(pos, duration) or transform:DOLocalMove(pos, duration))
    if rot then
        sequence:Insert(0, isWorldSpace and transform:DORotateQuaternion(Quaternion.Euler(rot.x, rot.y, rot.z), duration) or transform:DOLocalRotateQuaternion(Quaternion.Euler(rot.x, rot.y, rot.z), duration))
    end
    return sequence
end

local function SetLocalPositionAndRotation(trans, pos, rot)
    trans.localPosition = pos
    trans.localRotation = rot
end
------------ define ------------

---@class CardProgressionControllerCamera
local CardProgressionControllerCamera = Class('CardProgressionControllerCamera')


function CardProgressionControllerCamera:__init()
    self._cameraState = nil
    self._catAwakeEffects = {}
    self._roleOrCatTransGo = {}
end


function CardProgressionControllerCamera:__delete()
    self._roleOrCatTransGo = nil
    self._catAwakeEffects = nil
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

--- Init
---@param homeCameraTrans UnityEngine.Transform
---@param cultivateCameraTrans UnityEngine.Transform
function CardProgressionControllerCamera:Init(homeCameraTrans, cultivateCameraTrans, roleRoot, catRoot, exclusiveWeaponTarget, homeLocation)
    self._mainCamera              = URPCameraController.Instance.mainCamera
    --- 原始homeForward
    self._homeCameraForward       = homeCameraTrans.forward
    self._cultivateCameraForward  = cultivateCameraTrans.forward
        
    ---@type UnityEngine.Transform
    local roleRootTrans           = roleRoot.transform
    local catRootTrans               = catRoot.transform
    local exclusiveWeaponTargetTrans = exclusiveWeaponTarget.transform
    self._catRootTrans = catRootTrans
    self._roleRootTrans = roleRootTrans
    self._cultivateCameraTrans = cultivateCameraTrans
    self._homeCameraTrans      = homeCameraTrans
    
    local sceneId          = KCookie.Get(Constants.UICacheDataKeys.MainSceneID)
    ---@type SceneInstance
    local sceneInstance    = sceneManagement:GetSceneInstance(sceneId)
    ---@type UnityEngine.Transform
    local cameraPositions = sceneInstance:GetCacheObjectByName(CardProgressionConstants.SceneDefine.CameraPositions)
    local cameraPositionsTrans
    if isNull(cameraPositions) then
        local ResourceModule = CS.Engine.Modules.ResourceModule
        ResourceModule.LoadGameObjectAsync(CardProgressionConstants.PrefabPath.CameraPositions, function(go)
            go.name = CardProgressionConstants.SceneDefine.CameraPositions
            cameraPositionsTrans = go.transform
            sceneInstance:AddCacheObject(go)
        end, true)
    else
        cameraPositionsTrans = cameraPositions.transform
    end

    ---@type UnityEngine.GameObject
    local MainScene = sceneInstance:GetCacheObjectByName(CardProgressionConstants.SceneDefine.Main_Scene)
    local LightGo
    if not isNull(MainScene) then
        local LightTrans = MainScene.transform:Find("Scene/Light")
        if isNotNull(LightTrans) then
            LightGo = LightTrans.gameObject
        end
        
    end
    self._lightGo = LightGo
    
    ---@type UnityEngine.GameObject
    --local SceneGo      = sceneInstance:GetCacheObjectByName("Scene")
    --local tv           = SceneGo.transform:Find("Scene02/bg_vending08/Object001")
    -----@type UnityEngine.MeshRenderer
    --local meshRenderer = tv.gameObject:GetComponent(typeof(CS.UnityEngine.MeshRenderer))
    -----@type UnityEngine.Material
    --local material = meshRenderer.material 
    --self._tvMaterial = material
    --material:SetFloat(LightIntensityId, 0)
    
    local Covert = Vector3.Covert
    

    local t = {
        [CameraState.HomeFull] = 
            ---@param positionVo CardPositionVo 
            ---@param oldCameraState CardProgressionConstants.CameraState
            function (positionVo, oldCameraState)
                local tween
                local position = positionVo.mainRoleStance
                local rotation = positionVo.mainRoleDirection
                
                if oldCameraState == CameraState.CultivateRoleLeftFull then
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                    tween = DTSequence(homeCameraTrans, position, rotation, Duration3)
                elseif oldCameraState == CameraState.SignboardRoleFull then
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                    tween = DTSequence(homeCameraTrans, position, rotation, Duration4)
                elseif oldCameraState == CameraState.HomeRoleToCat then
                    tween = self:PlayMorphAni(catRootTrans, homeCameraTrans, position, rotation, Duration3, false, homeLocation)
                else
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                    SetLocalPositionAndRotation(homeCameraTrans, position, Quaternion.Euler(rotation.x, rotation.y, rotation.z))
                end
                
                return tween
            end
        ,

        [CameraState.HomeRoleToCat] =
            ---@param positionVo CardPositionVo
            ---@param oldCameraState CardProgressionConstants.CameraState
            function (positionVo, oldCameraState, awakeningLevel, isImmediate)
                if positionVo == nil then
                    return
                end
                local tween
                local position = positionVo.mainCatStance
                local rotation = positionVo.mainCatDirection
                if isImmediate then
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)
                    SetLocalPositionAndRotation(homeCameraTrans, position, Quaternion.Euler(rotation.x, rotation.y, rotation.z))
                elseif oldCameraState == CameraState.CultivateRoleLeftFull then
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)
                    tween = DTSequence(homeCameraTrans, position, rotation, Duration3)
                elseif oldCameraState == CardProgressionConstants.CameraState.HomeFull then
                    tween = self:PlayMorphAni(roleRootTrans, homeCameraTrans, position, rotation, Duration3, true, homeLocation)
                else
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)
                    tween = DTSequence(homeCameraTrans, position, rotation, Duration4)
                end

                return tween
            end
        ,

        [CameraState.SignboardRoleFull] = 
            ---@param positionVo CardPositionVo 
            ---@param oldCameraState CardProgressionConstants.CameraState
            function (positionVo, oldCameraState, isImmediate)
                local tween
                local position = positionVo.mainKanbanRoleStance
                local rotation = positionVo.mainKanbanRoleDirection
                if isImmediate then
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false, true)
                    SetLocalPositionAndRotation(homeCameraTrans, position, Quaternion.Euler(rotation.x, rotation.y, rotation.z))
                    
                elseif oldCameraState == CameraState.SignboardRoleToCat then
                    tween = self:PlayMorphAni(catRootTrans, homeCameraTrans, position, rotation, Duration3, false, homeLocation)
                    
                else
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false, true)
                    tween = DTSequence(homeCameraTrans, position, rotation, Duration4)
                    
                end
                
                return tween
            end
        ,
        
        [CameraState.SignboardRoleToCat] =
            ---@param positionVo CardPositionVo
            ---@param oldCameraState CardProgressionConstants.CameraState
            function (positionVo, oldCameraState, isImmediate)
                local tween
                local position = positionVo.mainChangeCatStance
                local rotation = positionVo.mainChangeCatDirection
                if isImmediate then
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true, true)
                    SetLocalPositionAndRotation(homeCameraTrans, position, Quaternion.Euler(rotation.x, rotation.y, rotation.z))
                elseif oldCameraState == CameraState.SignboardRoleFull then
                    tween = self:PlayMorphAni(roleRootTrans, homeCameraTrans, position, rotation, Duration3, true, homeLocation)
                else
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true, true)
                    tween = DTSequence(homeCameraTrans, position, rotation, Duration4)

                end
                
                return tween
            end
        ,
        
        [CameraState.CultivateRoleLeftFull] = 
            ---@param positionVo CardPositionVo 
            ---@param oldCameraState CardProgressionConstants.CameraState
            function (positionVo, oldCameraState, isInit, isImmediate)
                local position   = positionVo.startRoleStance
                local rotation   = positionVo.startRoleDirection
                --if isInit then
                --    SetLocalPositionAndRotation(cultivateCameraTrans, position, Quaternion.Euler(rotation.x, rotation.y, rotation.z))
                
                local tween
                if isImmediate or oldCameraState == CameraState.CultivateCatAwakenFull or oldCameraState == CameraState.CultivateCatAwakenSuccess then
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                    --CfUtils.ShowSwitchAnimation()
                    SetLocalPositionAndRotation(cultivateCameraTrans, position, Quaternion.Euler(rotation.x, rotation.y, rotation.z))
                    
                elseif oldCameraState == CameraState.CultivateCatFull or oldCameraState == CameraState.HomeRoleToCat then
                    tween = self:PlayMorphAni(catRootTrans, homeCameraTrans, position, rotation, Duration3, false, homeLocation)
                
                elseif oldCameraState == CameraState.CultivateRoleAndCatHide then
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                    tween = DTSequence(cultivateCameraTrans, position, rotation)
                else
                    tween = DTSequence(cultivateCameraTrans, position, rotation):OnComplete(function()
                                Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                            end):OnKill(function()
                                Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                    
                            end)
                end
                
                return tween
            end
        ,
        [CameraState.CultivateRoleFull] = 
            ---@param positionVo CardPositionVo 
            ---@param oldCameraState CardProgressionConstants.CameraState
            function (positionVo, oldCameraState, isImmediate)
                local tween
                local position   = positionVo.position
                local rotation   = positionVo.rotation
                
                if isImmediate or oldCameraState == CameraState.CultivateCatAwakenFull or oldCameraState == CameraState.CultivateCatAwakenSuccess or oldCameraState == CameraState.CultivateRoleAndCatHide then
                    --CfUtils.ShowSwitchAnimation()
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                    SetLocalPositionAndRotation(cultivateCameraTrans, position, Quaternion.Euler(rotation.x, rotation.y, rotation.z))
                else
                    if oldCameraState == CameraState.CultivateCatFull then
                        tween = self:PlayMorphAni(catRootTrans, homeCameraTrans, position, rotation, Duration3, false, homeLocation)
                    else
                        tween = DTSequence(cultivateCameraTrans, position, rotation):OnComplete(function()
                            Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                        end):OnKill(function()
                            Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)

                        end)
                    end
                end
                return tween
            end
        ,

        [CameraState.CultivateRoleHalf] = 
            ---@param positionVo CardPositionVo 
            ---@param oldCameraState CardProgressionConstants.CameraState
            function (positionVo, oldCameraState, isImmediate)
                local tween
                local position   = positionVo.halfRoleStance
                local rotation   = positionVo.rotation
                
                if isImmediate  or oldCameraState == CameraState.CultivateCatAwakenFull or oldCameraState == CameraState.CultivateCatAwakenSuccess  or oldCameraState == CameraState.CultivateRoleAndCatHide then
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                    --CfUtils.ShowSwitchAnimation()
                    SetLocalPositionAndRotation(cultivateCameraTrans, position, Quaternion.Euler(rotation.x, rotation.y, rotation.z))
                    
                else
                    if oldCameraState == CameraState.CultivateCatFull then
                        tween = self:PlayMorphAni(catRootTrans, homeCameraTrans, position, rotation, Duration3, false, homeLocation)
                    else
                        tween = DTSequence(cultivateCameraTrans, position, rotation):OnComplete(function()
                            Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                        end):OnKill(function()
                            Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)

                        end)
                    end
                end
                
                return tween
            end
        ,

        [CameraState.CultivateCatFull] = 
            ---@param positionVo CardPositionVo 
            ---@param oldCameraState CardProgressionConstants.CameraState
            function (positionVo, oldCameraState, isImmediate)
                if isNull(cameraPositionsTrans) then
                    return
                end
                local tween

                ---@type UnityEngine.Transform
                local positionTrans      = cameraPositionsTrans:Find("CameraParamsCatFull")
                local position, eulerAngles = positionVo:GetCatCamPositionAndRotation()
                if position == nil then
                    position = positionTrans.position
                end
                if eulerAngles == nil then
                    eulerAngles = positionTrans.eulerAngles
                end
                
                local rotation = Quaternion.Euler(eulerAngles.x, eulerAngles.y, eulerAngles.z)

                if isImmediate or oldCameraState == CameraState.CultivateCatAwakenFull or oldCameraState == CameraState.CultivateCatAwakenSuccess or oldCameraState == CameraState.ExclusiveWeapon or oldCameraState == CameraState.CultivateRoleAndCatHide then
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)
                    cultivateCameraTrans:SetPositionAndRotation(position, rotation)
                    
                else
                    --local completeCallback = function()
                    --    local sequence = DOTween.Sequence()
                    --    sequence:Insert(0, cultivateCameraTrans:DOMove(position, Duration3))
                    --    sequence:Insert(0, cultivateCameraTrans:DORotateQuaternion(rotation, Duration3))
                    --    --DTSequence(cultivateCameraTrans, position, rotation):PlayForward()
                    --    return sequence
                    --end
                    if oldCameraState == CameraState.CultivateRoleFull or oldCameraState == CameraState.CultivateRoleHalf then
                        tween = self:PlayMorphAni(roleRootTrans, homeCameraTrans, position, eulerAngles, Duration3, true, homeLocation, true)
                    else
                        tween = DTSequence(cultivateCameraTrans, position, eulerAngles, Duration4):OnComplete(function()
                            Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)
                        end):OnKill(function()
                            Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)

                        end)
                    end
                    
                end

                return tween
            end
        ,

        -- [CameraState.CultivateCatAwakenFull] = 
        --     ---@param positionVo CardPositionVo 
        --     ---@param oldCameraState CardProgressionConstants.CameraState
        --     function (positionVo, oldCameraState, awakenLevel, isImmediate)
        --         local tween
                
        --         local GetCameraAndCatTrans = function()
        --             if isNull(cameraPositionsTrans) then return end

        --             ---@type UnityEngine.Transform
        --             local positionTrans = cameraPositionsTrans:Find(string.format("AwakenPosition%s", checkNumber(awakenLevel) - 1))
        --             if isNull(positionTrans) then return end

        --             ---@type CardAwakeCameraVo
        --             local awakeCameraVo = cardConfMgr:GetCardAwakeCameraVoById(checkNumber(awakenLevel))
        --             local cameraPosition, cameraRotation = awakeCameraVo.cameraPos, awakeCameraVo.cameraRotation
        --             local catPosition = positionTrans.position
        --             local catRotation = awakeCameraVo.catRotation
        --             return cameraPosition, cameraRotation, catPosition, catRotation
        --         end

        --         -- if isNotNull(LightGo) then
        --         --     KTool.SetActive(LightGo, true)
        --         -- end

        --         local cameraPosition, cameraRotation, catPosition, catRotation = GetCameraAndCatTrans()
        --         if cameraPosition == nil then return end
        --         --if isImmediate then
        --             Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)
        --             SetLocalPositionAndRotation(cultivateCameraTrans, cameraPosition, Quaternion.Euler(cameraRotation.x, cameraRotation.y, cameraRotation.z))
        --             catRootTrans.position = catPosition
        --             catRootTrans.localRotation = Quaternion.Euler(catRotation.x, catRotation.y, catRotation.z)
        --         --else
        --         --    tween = DTSequence(cultivateCameraTrans, cameraPosition, cameraRotation, Duration4)
        --         --    tween:OnComplete(function()
        --         --        Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)
        --         --        catRootTrans.position = catPosition
        --         --        catRootTrans.localRotation = Quaternion.Euler(catRotation.x, catRotation.y, catRotation.z)
        --         --    end)

        --         --end
                
        --         return tween
        --     end
        -- ,

        -- [CameraState.CultivateCatAwakenSuccess] = 
        --     ---@param positionVo CardPositionVo 
        --     ---@param oldCameraState CardProgressionConstants.CameraState
        --     function (positionVo, oldCameraState, awakenLevel, effectPath)
        --         local cat = self._cat
        --         if isNull(cameraPositionsTrans) or isNull(cat) then
        --             return
        --         end
                
        --         local oldAwakenLevel = awakenLevel - 1
        --         ---@type UnityEngine.Transform
        --         local oldPositionTrans = cameraPositionsTrans:Find(string.format("AwakenPosition%s", checkNumber(oldAwakenLevel) - 1))
        --         ---@type UnityEngine.Transform
        --         local newPositionTrans = cameraPositionsTrans:Find(string.format("AwakenPosition%s", checkNumber(awakenLevel) - 1))
        --         if isNull(newPositionTrans) or isNull(oldPositionTrans) then
        --             return
        --         end

        --         -- if isNotNull(LightGo) then
        --         --     KTool.SetActive(LightGo, true)
        --         -- end
        --         local tween
                
        --         Events.Broadcast(CardProgressionConstants.EventNames.SetCultivateMainShowState, false)
        --         UINavigationBarRoot.Instance:SetActive(false)
                
        --         if isNull(self._catAwakeEffects[effectPath]) then
        --             local ResourceModule = CS.Engine.Modules.ResourceModule
        --             ResourceModule.LoadGameObjectAsync(effectPath, function(go)
        --                 --local particleSystems = go:GetComponentsInChildren(CardProgressionConstants.CompType.ParticleSystemType)
        --                 --CardProgressionUtils.EnabledParticleSystemsEmission(particleSystems, false)
        --                 KTool.SetActive(go, false)
        --                 self._catAwakeEffects[effectPath] = go
        --             end, true, catRootTrans)
        --         end
                
        --         --- 1. 计算镜头拉远后的位置
        --         local oldPosition   = Covert(oldPositionTrans.position)
        --         local newPosition   = Covert(newPositionTrans.position)
        --         local cameraUp      = Covert(cultivateCameraTrans.up)
        --         local cameraForward = Covert(cultivateCameraTrans.forward)
        --         local midPosition   = (oldPosition + newPosition) * 0.5
        --         local cameraPos     = midPosition - cameraForward * 3 + cameraUp * 0.2

        --         --- 2. 计算猫转身角度 
        --         local catForward    = Covert(catRootTrans.forward)
        --         local eulerAngles   = catRootTrans.localEulerAngles
        --         local direction     = newPosition - oldPosition
        --         -- 顺时针为 1, 逆时针为 -1
        --         local clockwise = 1
        --         if Vector3.Cross(catForward, direction).y < 0 then
        --             clockwise = -1
        --         end
        --         local angle     = Vector3.Angle(catForward, direction) * clockwise

        --         --- 3. 计算相机最终位置
        --         ---@type CardAwakeCameraVo
        --         local awakeCameraVo = cardConfMgr:GetCardAwakeCameraVoById(checkNumber(awakenLevel))
        --         --local cameraPositionFinal, cameraRotationFinal = CalcCameraPosAndRotByTrans(newPositionTrans)
        --         local cameraRotation = awakeCameraVo.cameraRotation
        --         local cameraPositionFinal, cameraRotationFinal = awakeCameraVo.cameraPos, Quaternion.Euler(cameraRotation.x, cameraRotation.y, cameraRotation.z)

        --         --local duration         = Duration3
        --         --- 4. 计算猫最终位置
        --         --local catRotationFinal = newPositionTrans.rotation
        --         local catRotation = awakeCameraVo.catRotation
        --         local catRotationFinal = Quaternion.Euler(catRotation.x, catRotation.y, catRotation.z)

        --         ---@type UnityEngine.Animator
        --         local animator    = KTool.GetComponent(cat.gameObject, CardProgressionConstants.CompType.AnimatorType)
        --         --if not isNull(animator) then
        --             --animator:Rebind()
        --             --animator:Play(CardProgressionConstants.AnimatorHash.SitHash)
        --         --end
                
        --         --- 5. 播放动画
        --         local sequence         = DOTween.Sequence()
        --         sequence:SetEase(Ease.InOutSine)
        --         --- 添加 相机拉远 动画
        --         sequence:Append(cultivateCameraTrans:DOMove(cameraPos, 0.25))
        --         sequence:AppendCallback(function()
        --             animator:Play(CardProgressionConstants.AnimatorHash.SitHash)
        --             animator:Update(0)
        --         end)
        --         sequence:AppendInterval(0.01)
        --         --- 添加 猫转身 动画 动画层
        --         sequence:AppendCallback(function()
        --             animator:SetInteger(CardProgressionConstants.AnimatorHash.AnimHash, 1)
        --         end)
        --         --sequence:AppendInterval(0.19)
        --         --- 添加 猫转身 动画 代码层
        --         sequence:Append(catRootTrans:DOLocalRotateQuaternion(Quaternion.Euler(eulerAngles.x, eulerAngles.y + angle, eulerAngles.z), 0.379))
        --         --sequence:AppendInterval(0.367)
        --         --- 添加 猫跳箱子 动画
        --         sequence:Append(catRootTrans:DOMove(newPosition, 0.75))
        --         --sequence:Append(catRootTrans:DOJump(newPosition, 0.5, 1, duration))
        --         --- 添加 猫特效回调 动画
        --         sequence:AppendCallback(function ()
        --             animator:SetInteger(CardProgressionConstants.AnimatorHash.AnimHash, 0)
        --         end)
        --         sequence:AppendInterval(0.4)
        --         local sequenceFinal = DOTween.Sequence()
        --         --- 添加 猫最终位置 相关动画
        --         sequenceFinal:Append(catRootTrans:DOLocalRotateQuaternion(catRotationFinal, Duration5))
        --         --- 添加 相机最终位置 相关动画
        --         sequenceFinal:Insert(0, cultivateCameraTrans:DOLocalMove(cameraPositionFinal, Duration5))
        --         sequenceFinal:Insert(0, cultivateCameraTrans:DOLocalRotateQuaternion(cameraRotationFinal, Duration5))
        --         sequence:Append(sequenceFinal)
        --         sequence:AppendCallback(function()
        --             local go = self._catAwakeEffects[effectPath]
        --             if not isNull(go) then
        --                 KTool.SetActive(go, true)
        --             end
        --             --CardProgressionUtils.EnabledParticleSystemsEmission(particleSystems, true)
        --         end)
        --         sequence:AppendInterval(1)
        --         sequence:OnComplete(function ()
        --             --local particleSystems = self._catAwakeEffects[effectPath]
        --             --CardProgressionUtils.EnabledParticleSystemsEmission(particleSystems, false)
        --             --Events.Broadcast(CardProgressionConstants.EventNames.SetCultivateMainShowState, true)
        --             -- if isNotNull(LightGo) then
        --             --     KTool.SetActive(LightGo, false)
        --             -- end
        --             local go = self._catAwakeEffects[effectPath]
        --             if not isNull(go) then
        --                 KTool.SetActive(go, false)
        --             end
        --             UINavigationBarRoot.Instance:SetActive(true)
        --         end):OnKill(function()
        --             -- if isNotNull(LightGo) then
        --             --     KTool.SetActive(LightGo, false)
        --             -- end
        --             local go = self._catAwakeEffects[effectPath]
        --             if not isNull(go) then
        --                 KTool.SetActive(go, false)
        --             end
        --             UINavigationBarRoot.Instance:SetActive(true)
        --         end)
        --         --sequence:Play()
        --         tween = sequence
                
        --         return tween
        --     end
        -- ,
        
        [CameraState.CultivateLookAtFace] =
            ---@param positionVo CardPositionVo
            ---@param oldCameraState CardProgressionConstants.CameraState
            function (positionVo, oldCameraState, isCat, customDistance, upDistance)
                local tween
                local node = isCat and self._cat or self._role
                local targetPos, cameraTargetDistance, targetNode

                if isCat then
                    local path = "Unity_Export_Grp/Geometry/face"
                    local eye = node.transform:Find(path)
                    if isNotNull(eye) then
                        ---@type UnityEngine.SkinnedMeshRenderer
                        local render = eye.gameObject:GetComponent(typeof(CS.UnityEngine.SkinnedMeshRenderer))
                        targetNode = render.rootBone
                    else
                        targetNode = node.transform:Find("Unity_Export_Grp/Geometry")
                    end
                    targetPos = targetNode.position
                    cameraTargetDistance = customDistance or CardProgressionConstants.CatLookAtHeadDistance

                else
                    targetPos = positionVo:GetCamLockPosition()
                    if targetPos == nil then
                        ---@type FaceForward
                        local faceForward = UICommonUtils.GetFaceForward(node)
                        targetNode = faceForward.TargetTransform
                        targetPos = targetNode.position
                    end
                    
                    cameraTargetDistance = customDistance or CardProgressionConstants.RoleLookAtHeadDistance
                end

                upDistance          = checkNumber(upDistance)
                local position      = node.transform.position
                position.y          = targetPos.y
                local worldPosition = position - cultivateCameraTrans.forward * cameraTargetDistance + cultivateCameraTrans.up * upDistance
                tween = cultivateCameraTrans:DOMove(worldPosition, 0.3)
                return tween
            end
        ,

        [CameraState.CultivateRoleAndCatHide] = function (positionVo, oldCameraState, isImmediate)
            local position   = positionVo.position
            local rotation   = positionVo.rotation
            SetLocalPositionAndRotation(cultivateCameraTrans, position, Quaternion.Euler(rotation.x, rotation.y, rotation.z))
            Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, false, false, true, self._skinId)

        end
        ,
        
        [CameraState.ExclusiveWeapon] =
            ---@param positionVo CardPositionVo
            ---@param oldCameraState CardProgressionConstants.CameraState
            function (positionVo, oldCameraState)
                local cameraExclusiveWeapon = positionVo.cameraExclusiveWeapon
                if string.isEmpty(cameraExclusiveWeapon) then
                    self._newCameraState = CameraState.CultivateRoleFull
                    return 
                end
                
                local blockerName = "Load.ExclusiveWeapon"
                CardProgressionUtils.BlockerAndStartCo(blockerName, function()
                    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
                    local prefabPath = string.format(CardProgressionConstants.PrefabPath.CameraExclusiveWeapon, cameraExclusiveWeapon)
                    local go         = GameUtils.LoadBundleAsync(prefabPath, roleRoot)
                    CfUtils.ConditionRemove(blockerName)
                    self._blend = UICommonUtils.GetBrainSettingByGo(URPCameraController.Instance.mainCamera)
                    CfUtils.ChangeMainCamDefalultBlend(0)
                    self._exclusiveWeaponGo = go
                    ---@type Cinemachine.CinemachineVirtualCamera
                    local vCameraComp = KTool.GetComponent(go, CardProgressionConstants.CompType.CinemachineVirtualCameraType)
                    vCameraComp.Follow = exclusiveWeaponTargetTrans
                    vCameraComp.LookAt = exclusiveWeaponTargetTrans
                    
                end, true)
                
            end
        ,
        [CameraState.ShowRoleOnUI] =
        ---@param positionVo CardPositionVo
        ---@param params table position和rotation 信息
        function (positionVo, oldCameraState, position, rotation, isShowRole, ignoreAnimate)
            if isNull(rotation) then
                return
            end
            if isShowRole == nil then
                isShowRole = true
            end
            ignoreAnimate = checkBool(ignoreAnimate)
            local tween
            Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, isShowRole, false)
            local position = not isNull(position) and position or positionVo.mainRoleStance
            if ignoreAnimate then
                SetLocalPositionAndRotation(homeCameraTrans, position, rotation)
                return
            end
            tween = DTSequence(homeCameraTrans, position, rotation, Duration3)
            return tween
        end
    ,
    }
    self._states = t
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshState
---@param cameraState CardProgressionConstants.CameraState
function CardProgressionControllerCamera:FreshCameraState(cameraState, oldCameraState, roleFaceForward, ...)
    --- 卡牌坐标表优先通过皮肤id找
    ---@type CardPositionVo
    local positionVo = cardConfMgr:GetCardPosByCardId(self._cardId, self._skinId)
    if positionVo == nil then
        return
    end
    if not isNull(self._blend) then
        CfUtils.ChangeMainCamDefalultBlend(self._blend.m_Time)
        self._blend = nil
    end
    local state = self._states[cameraState]
    if state then
        if not isNull(self._exclusiveWeaponGo) then
            KTool.SafeDelete(self._exclusiveWeaponGo)
            self._exclusiveWeaponGo = nil
        end
        self:KillTween()
        --SetLocalPositionAndRotation(self._catRootTrans, Vector3.zero, Quaternion.identity)
        
        self:SetLightShowState(cameraState)
        self._tween = state(positionVo, oldCameraState, ...)
        local newCameraState = self._newCameraState
        if newCameraState then
            self._newCameraState = nil
            return newCameraState
        end
    end
    return nil
end

function CardProgressionControllerCamera:KillTween()
    if isNull(self._tween) then
        return
    end
    local onComplete = self._tween.onComplete
    if not isNull(onComplete) and not self._tween:IsComplete() then
        onComplete()
    end
    self._tween:Kill(true)
    self._tween = nil
end

---PlayMorphAni
---@param modelNodeTrans UnityEngine.Transform  模型根节点
---@param cameraTrans UnityEngine.Transform  相机节点
---@param position Vector3 相机最终位置
---@param rotation Vector3 相机最终旋转
---@param duration number 动画播放时间
---@param isRole2Cat boolean 是否是人物变猫
---@param homeLocation UnityEngine.Transform
---@param isWorldSpace boolean 是否是世界空间
function CardProgressionControllerCamera:PlayMorphAni(modelNodeTrans, cameraTrans, position, rotation, duration, isRole2Cat, homeLocation, isWorldSpace)
    local effectPath = isRole2Cat and CardProgressionConstants.PrefabPath.TransToCat_down or CardProgressionConstants.PrefabPath.TransToCat_up
    local tween = self:CreateMorphAni(modelNodeTrans, cameraTrans, position, rotation, duration, isRole2Cat, effectPath, isWorldSpace)
    local blockerName = "ControllerCamera.PlayMorphAni"
    CardProgressionUtils.BlockerAndStartCo( blockerName,function()
        local go = self._roleOrCatTransGo[effectPath]
        if isNull(go) then
            go = GameUtils.LoadBundleAsync(effectPath, homeLocation.gameObject)
            self._roleOrCatTransGo[effectPath] = go
        else
            KTool.SetActive(go, true)
        end
        tween:Play()
        CfUtils.ConditionRemove(blockerName)

    end, true)
    
    return tween
end


---CreateMorphAni
---@param rootNodeTrans UnityEngine.Transform
---@param cameraTrans UnityEngine.Transform
---@param position Vector3
---@param rotation Vector3
---@param duration number
---@param isRole2Cat boolean
---@param effectPath string
---@param isWorldSpace boolean
function CardProgressionControllerCamera:CreateMorphAni(rootNodeTrans, cameraTrans, position, rotation, duration, isRole2Cat, effectPath, isWorldSpace)
    local quaternion = Quaternion.Euler(rotation.x, rotation.y, rotation.z)
    local tween = DOTween.Sequence()
    isWorldSpace = checkBool(isWorldSpace)
    tween:Append(rootNodeTrans:DOScale(VectorZero, duration))
    tween:Insert(0, isWorldSpace and cameraTrans:DOMove(position, duration) or cameraTrans:DOLocalMove(position, duration))
    tween:Insert(0, isWorldSpace and cameraTrans:DORotateQuaternion(quaternion, duration) or cameraTrans:DOLocalRotateQuaternion(quaternion, duration))
    tween:InsertCallback(duration * 0.5, function()
        Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, not isRole2Cat, isRole2Cat)
    end)
    tween:OnComplete(function()
        rootNodeTrans.localScale = VectorOne
        
        local go = self._roleOrCatTransGo[effectPath]
        if not isNull(go) then
            KTool.SetActive(go, false)
        end
    end)
    tween:OnKill(function()
        rootNodeTrans.localScale = VectorOne

    end)
    tween:Pause()
    return tween
end



function CardProgressionControllerCamera:FreshTvShowState(isLight)
    self._tvMaterial:SetFloat(LightIntensityId, isLight and 0.19 or 0.25)
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


function CardProgressionControllerCamera:SetCardId(cardId)
    self._cardId = cardId
end

function CardProgressionControllerCamera:SetSkinId(skinId)
    self._skinId = skinId
end

function CardProgressionControllerCamera:SetRoleAndCat(role, cat)
    self._role = role
    self._cat  = cat
end

function CardProgressionControllerCamera:GetCatAwakeEffect(effectPath)
    return self._catAwakeEffects[effectPath]
end

function CardProgressionControllerCamera:SetLightShowState(cameraState)
    local isShow = cameraState == CardProgressionConstants.CameraState.CultivateCatAwakenFull or cameraState == CardProgressionConstants.CameraState.CultivateCatAwakenSuccess
    if self._isShowLight == isShow then return end
    if isNull(self._lightGo) then return end
    self._isShowLight = isShow
    KTool.SetActive(self._lightGo, isShow)
end



---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------

return CardProgressionControllerCamera
