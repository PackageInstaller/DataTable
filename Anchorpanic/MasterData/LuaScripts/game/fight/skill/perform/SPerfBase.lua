--[[****************************************************************************
Brief  :SPerfBase 技能特效基础表现类
Author :James Ou
Date   :2020-03-10
****************************************************************************
]]
module("SPerfBase", Class.impl())
-------------------------------
function ctor(self)
    -- 特效基础物体
    self.m_rootEntity = nil
    self.m_rootTrans = nil
    -- 基础特效资源名
    self.m_rootPrefabName = nil
    -- 结束时的爆炸特效名 (有的话，在结束时触发)
    self.m_endEftName = nil
    self.m_curPos = nil
    self.mc_sn = nil

    -- 特效层
    self.m_effectLayer = "Effect"

    self.m_cmdFuct = {}
    self.m_cmdFuct[STravelDef.PERF_START] = self.onStart
    self.m_cmdFuct[STravelDef.PERF_POS] = self.onPos
    self.m_cmdFuct[STravelDef.PERF_HIT] = self.onHit
    self.m_cmdFuct[STravelDef.PERF_END] = self.onEnd
    self.m_cmdFuct[STravelDef.PERF_ARRIVE] = self.onArrive
    self.m_cmdFuct[STravelDef.PERF_PAUSE] = self.onPause
    self.m_cmdFuct[STravelDef.PERF_RESUME] = self.onResume
    self.m_cmdFuct[STravelDef.PERF_SPEED] = self.onSpeed
    self.m_cmdFuct[STravelDef.PERF_LOOKAT] = self.onLookAt
end

function onStart(self, travel, parentTrans, curPos, angle)
    self.m_rootPrefabName = travel.m_rootPrefabName
    self.m_endEftName = travel.m_endEftName
    if fight.FightManager.m_gmOpenEft == true then return false end

    self.m_rootEntity = gs.GOPoolMgr:Get(self.m_rootPrefabName)
    -- self.m_rootEntity = gs.ResMgr:LoadGO(self.m_rootPrefabName)-- gs.ParticleMgr:Get(self.m_rootPrefabName, false)
    -- gs.GameObject.Destroy(self.m_rootEntity)
    -- self.m_rootEntity = nil
    if self.m_rootEntity == nil then
        Debug:log_warn("SPerfBase", "prefab [%s] can't create obj !!!", self.m_rootPrefabName)
        return false
    end
    -- print("onStart ===", self.m_rootPrefabName, self.m_rootEntity)
    self.m_rootTrans = self.m_rootEntity.transform
    if parentTrans and not gs.GoUtil.IsTransNull(parentTrans) then
        if not parentTrans.gameObject.activeSelf then
            -- self.m_rootTrans:SetParent(nil, false)
            gs.TransQuick:Pos(self.m_rootTrans, parentTrans)
        else
            self.m_rootTrans:SetParent(parentTrans, false)
            if curPos then
                gs.TransQuick:Pos(self.m_rootTrans, curPos)
            end

            -- 自动挂点
            self.m_charAppend = self.m_rootEntity:GetComponent(ty.CharAppendEffect)
            if not gs.GoUtil.IsCompNull(self.m_charAppend) then
                self.m_charAppend.CharSet = parentTrans.gameObject
            else
                self.m_charAppend = nil
            end
        end

        -- 特效动作
        if travel.m_param and travel.m_param.aniCtrlName then
            local animat = self.m_rootEntity:GetComponent(ty.Animator)
            if (animat) then
                animat:Play(travel.m_param.aniCtrlName);
                animat:Update(0);
            end
        end
        local live = travel:getCaster()
        if live then
            -- 一般特写场景用
            local effectForPost = self.m_rootEntity:GetComponent(ty.EffectForPost)
            if effectForPost then
                local function _effectShowCall(layerTag)
                    if travel then
                        live:setDisplayLayer(layerTag)
                    end
                end
                effectForPost:InitActionForEffectShow(_effectShowCall)
            end
            local autoRimController = self.m_rootEntity:GetComponent(ty.AutoRimController)
            if autoRimController then
                autoRimController.TargetInSence = live:getModelGO()
            end
        end

        -- local effectForModelMaterial = self.m_rootEntity:GetComponent(ty.EffectForModelMaterial)
        -- if effectForModelMaterial then
        -- 	local live = travel:getCaster()
        -- 	if live then
        -- 		effectForModelMaterial:InitSet(live)
        -- 	end
        -- end
    else
        self.m_rootTrans:SetParent(nil, false)
    end
    if angle then
        gs.TransQuick:SetRotation(self.m_rootTrans, 0, angle, 0)
    end
    self.m_rootEntity:SetActive(true)

    return true
    -- gs.TransQuick:Pos(self.m_rootTrans, lanuchPoint)
    -- local v3 = self:_getTargetVec3()
    -- gs.TransQuick:LookAt(self.m_rootTrans, v3.x, v3.y, v3.z)
end
function onPos(self, travel, vec3)
    if self.m_rootEntity and not gs.GoUtil.IsGoNull(self.m_rootEntity) then
        self.m_curPos = vec3
        gs.TransQuick:Pos(self.m_rootTrans, vec3.x, vec3.y + STravelDef.ENTITY_HEIGHT, vec3.z)
    end
end
-- 触发爆炸特效
function onHit(self, travel, ids, vec3)
    -- print("onHit", ids, vec3)
    if self.m_endEftName and self.m_endEftName ~= "" then
        -- 打空
        if table.empty(ids) and vec3 then
            local expParticle = gs.ParticleMgr:Get(self.m_endEftName)
            expParticle:SetRemoveTime(2)
            gs.TransQuick:Pos(expParticle.transform, vec3.x, vec3.y, vec3.z)
        else
            -- 打中目标
            for _, id in ipairs(ids) do
                local liveTh = fight.SceneItemManager:getLivething(id)
                if liveTh then
                    if liveTh:getTrans() then
                        local livePos = liveTh:getCurPos()
                        local expParticle = gs.ParticleMgr:Get(self.m_endEftName)
                        expParticle:SetParent(liveTh:getTrans())
                        expParticle:SetRemoveTime(2)
                        gs.TransQuick:Pos(expParticle.transform, livePos.x + math.random() * 0.3, livePos.y + STravelDef.ENTITY_HEIGHT + math.random() * 0.3, livePos.z + math.random() * 0.3)
                    end
                end
            end
        end
    end
end
-- 到达目标点 由子类扩展处理
function onArrive(self)
    -- print("onArrive")
end
-- 整个播放结束 (可能需要有延时处理, 由子类重写或扩展)
function onEnd(self, travel)
    if self.m_rootEntity and not gs.GoUtil.IsGoNull(self.m_rootEntity) then
        local fixSet = self.m_rootEntity:GetComponent(ty.EffectFixSet)
        if fixSet then
            fixSet:ClearUpObjList()
        end
        if self.m_charAppend then
            self.m_charAppend:RecoveParent()
            -- self.m_charAppend:ClearUpObjList()
        end
        -- print("onEnd===", self.m_rootPrefabName, self.m_rootEntity.name, self.m_rootEntity)
        -- if not self.m_rootEntity:GetComponent(ty.EffectRandomMananger) then
        -- gs.GoUtil.ChangeLayer(self.m_rootEntity, self.m_effectLayer) -- 战斗特效有些不能在effect层，麻烦
        gs.GOPoolMgr:Recover(self.m_rootEntity, self.m_rootPrefabName)
        self.m_rootEntity:SetActive(false)
        -- else
        -- 	gs.GameObject.Destroy(self.m_rootEntity)
        -- end		
        -- gs.GameObject.Destroy(self.m_rootEntity)
        -- self.m_rootEntity:Destroy()
        self.m_rootEntity = nil
    end
    STravelHandle:removePerf(self.mc_sn)
end
-- 暂停
function onPause(self, travel)
    -- if self.m_rootEntity then
    -- 	self.m_rootEntity:SetSpeed(0)
    -- end
end
-- 继续
function onResume(self, travel)
    -- if self.m_rootEntity then
    -- 	self.m_rootEntity:SetSpeed(travel:getBaseSpeed())
    -- end
end
-- 设置基础速度
function onSpeed(self, travel, speed)
    -- if self.m_rootEntity then
    -- 	self.m_rootEntity:SetSpeed(speed)
    -- end
end
-- 设置直接朝向
function onLookAt(self, travel, vec3)
    if self.m_rootEntity and not gs.GoUtil.IsGoNull(self.m_rootEntity) then
        gs.TransQuick:LookAt(self.m_rootTrans, vec3.x, vec3.y + STravelDef.ENTITY_HEIGHT, vec3.z)
    end
end

-- 触发命令处理
function onTravelCmd(self, cmd, travel, ...)
    local cmdFunct = self.m_cmdFuct[cmd]
    if cmdFunct then
        cmdFunct(self, travel, ...)
    else
        self:onOtherTravelCmd(cmd, travel, ...)
    end
end
-- 由其子类扩展实现
function onOtherTravelCmd(self, cmd, travel, ...)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]