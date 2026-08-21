
local function Reset(node)
    if not (type(node) == "table") then
        return
    end
    if node.type == BT_Action.Action then
        node._executed = false
    end
    for _, child in ipairs(node) do
        Reset(child)
    end
end

local function Traverse(node, ...)
    local t = node.type
    if t == BT_Action.Selector then
        for i=1, #node do
            if Traverse(node[i], ...) then
                for j = 1, #node do
                    if j ~= i then
                        Reset(node[j])
                    end
                end
                return true
            end
        end
        return false
    elseif t == BT_Action.Sequence then
        for i=1, #node do
            if not Traverse(node[i], ...) then
                return false
            end
        end
        return true
    elseif t == BT_Action.Condition then
        for i=1, #node do
            if not node[i](...) then
                return false
            end
        end
        return true
    elseif t == BT_Action.Action then
        local once = node.once
        if once and node._executed then
            return true
        end
        if once then
            node._executed = true
        end 
        for i=1, #node do
            node[i](...)
        end
        return true
    end
end




---@class CoveBehaviorTree
local BT = class("CoveBehaviorTree")

function BT:ctor(root, owner)
    self.owner = owner
    self.root = root
end

function BT:Update()
    Traverse(self.root,  self.owner)
end
return BT