-- @FileName:   DanKeDropThing.lua
-- @Description:  沙盒实体基类
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.danke.thing.DanKeDropThing', Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function recover(self)
    LuaPoolMgr:poolRecover(self)
end

function create(self, data)
    local item = self:poolGet()

    item.m_snId = SnMgr:getSn()
    item.m_data = data

    item:resetData()
    item:setupModel()

    return item
end

function resetData(self)
end

--重构函数
function setupModel(self)
    local prefabPath = self.m_data.config:getIcon()
    if string.NullOrEmpty(prefabPath) then
        return
    end

    self.m_rootGo = gs.GameObject()
    self.m_trans = self.m_rootGo.transform
    self.m_rootGo.name = "drop_" .. self.m_data.config.tid

    local scale = self.m_data.config:getScale()
    self.m_trans.localScale = gs.Vector3(scale, scale, 1)

    self.m_spriteRenderer = self.m_rootGo:AddComponent(ty.SpriteRenderer)
    self.m_spriteRenderer.sortingOrder = self.m_sortIndex

    self.m_spriteRenderer.sprite = gs.ResMgr:LoadSprite(prefabPath)

    self.m_colliderCall = self.m_rootGo:GetComponent(ty.ColliderCall)
    if not self.m_colliderCall or gs.GoUtil.IsCompNull(self.m_colliderCall) then
        self.m_colliderCall = self.m_rootGo:AddComponent(ty.ColliderCall)

        self.m_colliderCall:InitCapsuleCollider(0.2, 0.2)
        self.m_colliderCall.SelfColliderTag = DanKeConst.ColliderTag.Drop
        self.m_colliderCall:AddColliderTags({DanKeConst.ColliderTag.Player})
        self.m_colliderCall:OpenColliderCheck()
        self.m_colliderCall.IsTrigger = true
    end

    self.m_colliderCall.ColliderTagID = self.m_snId

    self.m_colliderCall.onTriggerEnterCall = function (tag, colliderTagID)
        local data = {attack_id = self.m_snId, hit_id = colliderTagID, attack_tag = DanKeConst.ColliderTag.Drop, hit_tag = tag}
        GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_ENTER, data)
    end

    self.m_colliderCall.onTriggerExitCall = function (tag, colliderTagID)
        local data = {attack_id = self.m_snId, hit_id = colliderTagID, attack_tag = DanKeConst.ColliderTag.Drop, hit_tag = tag}
        GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_EIXT, data)
    end

    self:setParent(self.m_data.parent)
    self:setPosition(self.m_data.bron_pos)

    self.m_deltaTimeSn = LoopManager:setTimeout(self.m_data.config.die_time, self, self.poolRecover)
end

function setSortIndex(self, sortIndex)
    self.m_sortIndex = sortIndex

    if self.m_spriteRenderer and not gs.GoUtil.IsCompNull(self.m_spriteRenderer) then
        self.m_spriteRenderer.sortingOrder = self.m_sortIndex
    end
end

--攻击
function onAttack(self, playerThing)
    self.m_playerThing = playerThing

    local drop_param = self.m_data.config.param
    if self.m_data.config.type == DanKeConst.Drop_type.Add_Hp then
        self.m_playerThing:addHp(drop_param[1])
    elseif self.m_data.config.type == DanKeConst.Drop_type.Kill_Normal then
        local range = drop_param[1] --秒杀范围
        local monster_type = drop_param[2]--怪物类型

        local layer = DanKeConst.ColliderTag.Elite_Monster --怪物类型存在的层级
        if monster_type == DanKeConst.MonsterType.Normal then
            layer = DanKeConst.ColliderTag.Normal_Monster
        end

        local monsterThingDic = danke.DanKeSceneController:getLayerThingDic(layer)
        if monsterThingDic and not table.empty(monsterThingDic) then
            local playThing_pos = self.m_playerThing:getPosition()
            for snId, monsterThing in pairs(monsterThingDic) do
                local monster_pos = monsterThing:getPosition()
                local pos_distance = gs.Vector3.Distance(gs.Vector3(monster_pos.x, monster_pos.y, 0), gs.Vector3(playThing_pos.x, playThing_pos.y, 0))
                if math.abs(pos_distance) <= range then
                    monsterThing:onHit(9999999)
                end
            end
        end

    elseif self.m_data.config.type == DanKeConst.Drop_type.Get_AllDrop then
        local range = drop_param[1] --拾取范围
        local drop_type = drop_param[2]--掉落物类型
        local layer = DanKeConst.ColliderTag.Drop --层级

        local dropThingDic = danke.DanKeSceneController:getLayerThingDic(layer)
        if dropThingDic and not table.empty(dropThingDic) then
            local playThing_pos = self.m_playerThing:getPosition()
            for snId, dropThing in pairs(dropThingDic) do
                --判断是不是可以拾取的类型
                for _, dropType in pairs(drop_type) do
                    if dropThing.m_data.config.type == dropType then
                        local drop_pos = dropThing:getPosition()
                        local pos_distance = gs.Vector3.Distance(gs.Vector3(drop_pos.x, drop_pos.y, 0), gs.Vector3(playThing_pos.x, playThing_pos.y, 0))
                        --判断是不是在拾取范围内
                        if math.abs(pos_distance) <= range then
                            dropThing:doFlyTween(function ()
                                dropThing:onAttack(self.m_playerThing)
                            end)
                        end
                        break
                    end
                end
            end
        end
    elseif self.m_data.config.type == DanKeConst.Drop_type.Treasure_Box then
        GameDispatcher:dispatchEvent(EventName.DANKE_RANDOM_PLAYERSKILL)
    elseif self.m_data.config.type == DanKeConst.Drop_type.Exp then

        local exp = drop_param[1]
        self.m_playerThing:addExp(exp)
    end

    self:poolRecover()
end

function doFlyTween(self, finishCall)
    if not self.m_playerThing then
        self.m_playerThing = danke.DanKeSceneController:getPlayerThing()
    end

    self:killTweener()
    self.m_tweenFrameSn = LoopManager:addFrame(1, 0, self, self.onFlyTween)
    self.m_scaleTweener = TweenFactory:scaleTo(self.m_trans, self.m_trans.localScale, {x = 0, y = 0, z = 1}, 0.8, gs.DT.Ease.EaseInElastic, finishCall)
end

function onFlyTween(self)
    local playThing_pos = self.m_playerThing:getPosition()
    gs.TransQuick:Pos_Lerp(self.m_trans, playThing_pos.x, playThing_pos.y, 0, gs.Time.deltaTime * 5)
    if math.abs(gs.Vector3.Distance(player_pos, gs.Vector3(self.m_trans.position.x, self.m_trans.position.y, 0))) <= 0.05 then
        self:killTweener()
    end
end

function killTweener(self)
    if self.m_tweenFrameSn then
        LoopManager:removeFrameByIndex(self.m_tweenFrameSn)
        self.m_tweenFrameSn = nil
    end

    if self.m_scaleTweener then
        self.m_scaleTweener:Kill()
        self.m_scaleTweener = nil
    end
end

function setParent(self, parent)
    self.m_trans:SetParent(parent, true)
end

function setAngle(self, angle)
    gs.TransQuick:SetRotation(self.m_trans, 0, angle, 0)
end

function getAngle(self)
    return self.m_trans.localEulerAngles.y
end

function getTrans(self)
    return self.m_trans
end

function getPosition(self)
    if self.m_trans and not gs.GoUtil.IsTransNull(self.m_trans) then
        return self.m_trans.position
    end
end

function setPosition(self, lpos)
    if not lpos then return end

    if self.m_trans and lpos then
        gs.TransQuick:LPos(self.m_trans, lpos.x, lpos.y, lpos.z)
    end
end

--内部调用回收
function poolRecover(self)
    danke.DanKeSceneController:recoverThing(DanKeConst.ColliderTag.Drop, self.m_snId)
end

function onRecover(self)
    self:killTweener()

    if self.m_rootGo then
        gs.GameObject.Destroy(self.m_rootGo)
        self.m_rootGo = nil
        self.m_trans = nil
    end

    self.m_colliderCall.onTriggerEnterCall = nil
    self.m_colliderCall.onTriggerExitCall = nil

    if self.m_deltaTimeSn then
        LoopManager:clearTimeout(self.m_deltaTimeSn)
        self.m_deltaTimeSn = nil
    end
end

return _M
