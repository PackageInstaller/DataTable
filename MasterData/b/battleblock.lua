
require "class"
local MapBlock = require "MapBlock"
---@class BattleBlock:MapBlock
local BattleBlock = class("BattleBlock", MapBlock)
local BattleCore = require "BattleCore"

--战斗地块
---@param blockData MapBlockData
function BattleBlock:ctor(blockData)
    ---@type MapBlock
    local MapBlock = self.super
    MapBlock.ctor(self, blockData)
    ---@type boolean
    self._blockTorpedo = blockData.blockTorpedo
    ---@type integer 当前地格所属角色id
    self.roleId = nil
    ---@type table<integer, integer[]> Effect表id列表，地格上待触发的效果
    self._effectGroup = {}
    ---@type integer 地格上临时占领的角色id，取地格上角色时不要使用self.roleId，而是使用self:getTmpRoleId()
    self._tmpRoleId = nil
end

function BattleBlock:setRoleId(roleId)
    self.roleId = roleId
end

---设置地格上的效果组
---@param idList integer[]? Effect表id列表
---@param roleId integer
function BattleBlock:setEffectGroup(idList, roleId)
    local role = self:tryGetRole()
    if role then
        role:removeBlockEffect()
    end
    if idList then
        for _, effectid in ipairs(idList) do
            if not self._effectGroup[effectid] then
                self._effectGroup[effectid] = {}
            end
            local effectData = self._effectGroup[effectid]
            effectData[#effectData + 1] = roleId
        end
    end

	if role then
		role:checkBlockEffect()
	end
end

---移除地格上的效果组
---@param idList integer[] Effect表id列表
---@param roleId integer
---@param expectRole boolean? 是否排除当前角色
function BattleBlock:removeEffectGroup(idList, roleId, expectRole)
    local role = self:tryGetRole()
    if role then
        role:removeBlockEffect()
    end
    if idList then
        for _, effectid in ipairs(idList) do
            local effectData = self._effectGroup[effectid]
            if effectData then
                local count = #effectData
                for i = count, 1, -1 do
                    local id = effectData[i]
                    if id == roleId then
                        table.remove(effectData, i)
                        count = count - 1
                    end
                end
                if count == 0 then
                    self._effectGroup[effectid] = nil
                end
            end
        end
    end

    ---刷新地格上角色的地格效果
    if role then
        local needExcept = expectRole == true and roleId == role.id
        if not needExcept then
            role:checkBlockEffect()
        end
    end
end

---获取地格上的效果组
function BattleBlock:getEffectGroup()
    return self._effectGroup
end

---设置地格上的角色id(还未真正改变地格上的角色id)
function BattleBlock:setTmpRoleId(roleId)
    self._tmpRoleId = roleId
end
---获取地格上的角色id(包括临时角色)
function BattleBlock:getTmpRoleId()
    if self._tmpRoleId then
        if self._tmpRoleId == -1 then
            return nil
        else
            return self._tmpRoleId
        end
    else
        return self.roleId
    end
end

---获取当前地格的角色
---@param needFindDefeat boolean?
---@return BattleRole?
function BattleBlock:tryGetRole(needFindDefeat)
    local role = nil
    local roleId = self:getTmpRoleId()
    if roleId then
        local roleMgr = BattleCore:getBattleRoleMgr()
        role = roleMgr:getRole(roleId, needFindDefeat)
    end
    return role
end

---获取当前地格是否可以阻挡鱼雷类技能
function BattleBlock:GetBlockCanBlockTorpedo()
    return self._blockTorpedo
end

return BattleBlock
