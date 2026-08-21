

local acMgr = AutoChessManager.instance()
local ConditionChecker = require("ConditionChecker")

---@class AutoChessBuff
local AutoChessBuff = class("AutoChessBuff")

---@param owner AutoChessEntity
---@param data AutoChessBuffInfo
function AutoChessBuff:ctor(owner, data)
	self.owner = owner
	self.data = data

	---@type AutoChessBuffTable
	self.buffCfg = Config.GetAutoChessBuffTable(data.id, data.lv)
	---@type boolean 是否被移除
	self.isRemoved = false


    ---@type number buff时长
    self.duration = self.buffCfg.duration
	---@type int 当前层数
	self.curStack = 1


	---装饰器
	---@type ModifierBase[]
	self.modifiers = {}

	


end



function AutoChessBuff:InitModifiers()
    -- 假设 data.modifierIds 是配表里读取的数组
	local cfg = self.buffCfg
	if cfg == nil then
		return
	end
    for i = 1, #cfg.modifierIds do
        local modId = cfg.modifierIds[i]
        local modCfg = Config.GetAutoChessModifierTable(modId)
        if modCfg then
            ---@type ModifierBase
            local inst = require(modCfg.script):new()
            inst:Init(modId, self)
            
            table.insert(self.modifiers, inst)
        end
    end
end




---@param dt number
function AutoChessBuff:OnUpdate(dt)

	if self.isRemoved then
		return
	end

    self:UpdateBuffTime(dt)

    self:UpdateModifiers(dt)      ----更新所有装饰器

end


function AutoChessBuff:UpdateBuffTime(dt)
    local cfg = self.buffCfg
    if cfg == nil then
        return
    end
    if cfg.duration <= 0 then   ---表示buff不会过期
        return
    end
    self.duration = self.duration - dt

    if self.duration <= 0 then
        local isStackDecay = cfg.isStackDecay
        if isStackDecay and self.curStack > 1 then
            self.curStack = self.curStack - 1
            self.duration = cfg.duration        ---TODO 可能会有点误差
            -- 通知所有 Modifier 层数变了，去重新计算数值！
            self:TakeEvent(GE.AutoChessCombatEvent.OnStackChanged, self.curStack)
        else
            self:OnRemove()
        end
    end
end


---更新所有装饰器
function AutoChessBuff:UpdateModifiers(dt)
    for i = 1, #self.modifiers do
        local modData = self.modifiers[i]
        modData:OnUpdate(dt)
    end
end



---@param condition table 条件参数
---@param eventArgs table? 额外参数
---@return boolean  是否满足条件
function AutoChessBuff:CheckCondition(condition, eventArgs)
    local caster = acMgr:GetEntity(self.data.owner) -- 这里的 data.owner 其实是施法者 UID
	if caster == nil then
		return false
	end
    return ConditionChecker.Check(condition, self.owner, caster, eventArgs)
end


function AutoChessBuff:OnAdd()
	self:ApplyFlags()
end


function AutoChessBuff:OnRefresh()
	-- 更新层数
	local maxStack = self.buffCfg.maxStack
	self.curStack = self.curStack + 1
	self.curStack = math.min(self.curStack, maxStack)
  
    for i = 1, #self.modifiers do
        local modData = self.modifiers[i]
        if self:CheckCondition(modData.condition) and modData.inst.OnRefresh then
            modData.inst:OnRefresh()
        end
    end
end


function AutoChessBuff:OnRemove()
	self.isRemoved = true
    self:RemoveFlags()
    for i = 1, #self.modifiers do
        local modData = self.modifiers[i]
        if modData.inst.OnRemove then
            modData.inst:OnRemove()
        end
    end
end





---@type table<AutoChessCombatEvent, string> kv
local EventMethodMap = {}
for k, v in pairs(GE.AutoChessCombatEvent) do
    EventMethodMap[v] = tostring(k) 
end





function AutoChessBuff:ApplyFlags()
	self.owner:AddFlag(self.buffCfg.flags)
end

function AutoChessBuff:RemoveFlags()
	self.owner:RemoveFlag(self.buffCfg.flags)
end




---@param eventType AutoChessCombatEvent 
---@param ... any 
function AutoChessBuff:TakeEvent(eventType, ...)


    local funName = EventMethodMap[eventType]
    if not funName then 
        return
    end
    for i = 1, #self.modifiers do
        local modData = self.modifiers[i]
        local method = modData[funName]
        if method == nil then
            goto continue
        end
        modData:CheckConditions(eventType, ...)
        method(modData, ...)
        ::continue::
    end
end


return AutoChessBuff
