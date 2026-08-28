--
-- Author:luqucheng
-- Date: 2019-12-02 16:02:24
--
local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils


local NativeFXMgr = nil
local FXMgr = {}

function FXMgr:Init(  )
    NativeFXMgr = CS.Game.Native.ParticleManager.Instance
    NativeFXMgr.ParticleSettingPath = AutoIds.IdSetting566
end

function FXMgr:PreLoadFX( fxIds )
    return NativeFXMgr:LoadParticles(fxIds)
end

--@return [Game.Setting.Vo.FXResVo#FXResVo]
function FXMgr:GetFxVo(fxId)
    if Tools.isNullKey(fxId) then
        return nil
    end

    local setting = settingMgr:GetSetting(AutoIds.IdSetting566, "FXResVo")
    --@RefType [Game.Setting.Vo.FXResVo#FXResVo]
    local FXResVo = setting:Get(fxId)
    
    return FXResVo
end

function FXMgr:PlayFXOnScene(fxId, isLoop, offset, scale)
    local FXResVo = self:GetFxVo(fxId)
    if isNull(FXResVo) then
        return -1, 0
    end
    offset = offset or Vector3.zero
    scale = scale or Vector3.one
    local loopTimes = isLoop and 10000000 or 1
    local fxNode = self:GetFXNode()

    return NativeFXMgr:PlayParticle(fxId, fxNode, loopTimes, offset, scale), FXResVo.fxTime
end

--@target: [Game.BattleView.Entity.RoleView#RoleView]
function FXMgr:PlayFXOnRole(fxId, target, isLoop, offset)
    local FXResVo = self:GetFxVo(fxId)
    if isNull(FXResVo) or isNull(target) or isNull(target.transform) then
        return -1, 0
    end
    local fxNode = isLoop and target.loopFXNode.gameObject or target.fxNode.gameObject

    offset = offset or Vector3.zero
    offset = Vector3.New(offset.x / target.transform.localScale.x,
                        offset.y / target.transform.localScale.y, 
                        offset.z / target.transform.localScale.z)

    local loopTimes = isLoop and 10000000 or 1
    local scale = Vector3.one
    if FXResVo.ifScale == 1 and target.modelVo.size <= Constants.RoleSize.Big and target.colliderMaxEdge then
        --根据目标体型
        scale:Mul( math.max(target.colliderMaxEdge / 1.91, 0.8) )
    end
    if FXResVo.ifTransform == 1 and target.modelVo.transHabitus > 0 then
        print("[特效] 手动微调", FXResVo.ifTransform, target.modelVo.transHabitus, fxId)
        -- 手动微调的缩放
        local refId = string.format("%d_%d", target.modelVo.transHabitus, fxId)
        local setting = settingMgr:GetSetting(AutoIds.IdSetting579, "FXTransformVo")
        local FXTransVo = setting:Get(refId)
        if isNotNull(FXTransVo) then
            scale = FXTransVo.scaleTrans
            offset = FXTransVo.positionTrans
        end
    end

    local ids = {}
    if FXResVo.fxType == Constants.FXType.Bone then
        --所有绑定的骨骼都创建特效
        for i,v in ipairs(FXResVo.bonesName) do
            local bone = target.gameObject:FindGameObjectByName(v)
            if bone then
                if FXResVo.ifFollow == 0 then
                    offset = offset + bone.transform.position
                    bone = BattleViewMgr.fxNode
                end
                local id = NativeFXMgr:PlayParticle(fxId, bone, loopTimes, offset, scale)
                table.insert(ids, id)
            end
        end
    elseif FXResVo.fxType == Constants.FXType.Ground then
        if FXResVo.ifFollow == 0 then
            offset = offset + fxNode.transform.position
            fxNode = BattleViewMgr.fxNode
        end
        offset.y = 0
        local id = NativeFXMgr:PlayParticle(fxId, fxNode, loopTimes, offset, scale)
        table.insert(ids, id)
    elseif FXResVo.fxType == Constants.FXType.HeadTop then
        if FXResVo.ifFollow == 0 then
            offset = offset + fxNode.transform.position
            fxNode = BattleViewMgr.fxNode
        end
        offset.y = target.centerY * target.transform.localScale.y * 2 + 0.7
        local id = NativeFXMgr:PlayParticle(fxId, fxNode, loopTimes, offset, scale)
        table.insert(ids, id)
    else
        if FXResVo.ifFollow == 0 then
            offset = offset + fxNode.transform.position
            fxNode = BattleViewMgr.fxNode
        end
        local id = NativeFXMgr:PlayParticle(fxId, fxNode, loopTimes, offset, scale)
        table.insert(ids, id)
    end
    
    -- 特效附带的角色材质球动画
    if not string.isEmpty(FXResVo.materialAnimState)
    and isNotNull(target.animatorGeometry) then
        print("[材质特效]", FXResVo.materialAnimState)
        target.animatorGeometry:Play(FXResVo.materialAnimState, 0)
    end

    return SafeUnpack(ids), FXResVo.fxTime
end

function FXMgr:PlayFX( fxId, gameObject, loopTimes, offset, scale )
    -- print('PlayFX BuffView', fxId)
    --不输入就默认场景中心
    local FXResVo = self:GetFxVo(fxId)
    if isNull(FXResVo) then
        return -1, 0
    end
    gameObject = gameObject or self:GetFXNode()
    offset = offset or Vector3.zero
    offset = Vector3.New(offset.x / gameObject.transform.localScale.x,
                        offset.y / gameObject.transform.localScale.y, 
                        offset.z / gameObject.transform.localScale.z)

    scale = scale or Vector3.one
    -- print(table.toString(offset, 'PlayParticle offset'), loopTimes)
  
    if FXResVo.fxType == Constants.FXType.Bone then
        --所有绑定的骨骼都创建特效
        local ids = {}
        for i,v in ipairs(FXResVo.bonesName) do
            local bone = gameObject:FindGameObjectByName(v)
            if bone then
                local id = NativeFXMgr:PlayParticle(fxId, bone, loopTimes or 1, offset or Vector3.zero, scale)
                table.insert(ids, id)
            end
        end
        return SafeUnpack(ids), FXResVo.fxTime
    elseif FXResVo.fxType == Constants.FXType.Ground then
        local of = offset and Vector3.New(Vector3.Get(offset)) or Vector3.zero
        of.y = 0
        return NativeFXMgr:PlayParticle(fxId, gameObject, loopTimes or 1, of, scale), FXResVo.fxTime
    else
        return NativeFXMgr:PlayParticle(fxId, gameObject, loopTimes or 1, offset or Vector3.zero, scale), FXResVo.fxTime
    end
end

function FXMgr:GetFXNode(  )
    local bvm = BattleViewMgr
    -- if not bvm.fxNode then
    --     local fxNode = CS.UnityEngine.GameObject("fxNode")
    --     fxNode.transform:SetParent(BattleViewMgr.rootNode.transform)
    --     CS.Engine.Lib.KTool.ResetTransform(fxNode.transform)
    --     bvm.fxNode = fxNode
    -- end
    return bvm.fxNode
end

function FXMgr:FindFX( uid )
    return NativeFXMgr:GetParticle( uid )
end

function FXMgr:RemoveFX( uid )
    NativeFXMgr:SafeDeleteParticle(uid)
end

function FXMgr:Clear(  )
    -- if BattleViewMgr.fxNode then
    --     CS.UnityEngine.GameObject.Destroy(BattleViewMgr.fxNode)
    -- end
    -- BattleViewMgr.fxNode = nil
    NativeFXMgr:TearDown()
    NativeFXMgr = nil
end

return  FXMgr