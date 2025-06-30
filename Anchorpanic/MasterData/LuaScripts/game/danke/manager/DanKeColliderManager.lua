-- @FileName:   DanKeColliderManager.lua
-- @Description:   蛋壳碰撞检测管理器
-- @Author: ZDH
-- @Date:   2023-09-07 17:15:26
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.util.DanKeColliderManager', Class.impl())

--构造
function ctor(self)
    self:init()
end

--初始化
function init(self)
    self.m_colliderDic = {}
end

function addCollider(self, args, isforce)
    local hit_tag, attack_tag, hit_snId, attack_snId = args.hit_tag, args.attack_tag, args.hit_id, args.attack_id
    if not self.m_colliderDic[hit_snId] then
        self.m_colliderDic[hit_snId] = {}
    end

    if not self.m_colliderDic[hit_snId][attack_snId] or isforce then

        self.m_colliderDic[hit_snId][attack_snId] = 1

        local attack_thing = danke.DanKeSceneController:getThing(attack_tag, attack_snId)
        local hit_thing = danke.DanKeSceneController:getThing(hit_tag, hit_snId)

        if attack_thing and attack_thing.onAttack ~= nil and hit_thing then
            attack_thing:onAttack(hit_thing, args, isforce)
        end
    end
end

function removeCollider(self, args)
    local hit_id = args.hit_id
    local attack_id = args.attack_id

    if not self.m_colliderDic[hit_id] then
        return
    end

    if not self.m_colliderDic[hit_id][attack_id] then
        return
    end

    self.m_colliderDic[hit_id][attack_id] = nil
end

function clearData(self)
    self.m_colliderDic = {}
end

return _M
