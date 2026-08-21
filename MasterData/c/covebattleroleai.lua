



local BT = require("CoveBehaviorTree")

---@class CoveBattleRoleAI
local RoleAI = class("CoveBattleRoleAI")

---@param owner CoveRole
function RoleAI:ctor(owner)
    self.owner = owner
    local root = {
        type = BT_Action.Selector,
        ---检测gameover
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveRole
                function(owner)
                    return owner:CanGameOver()
                end,

            },
            {
                type = BT_Action.Action,
                once = true,
                ---@param owner CoveRole
                function(owner)
                    return owner:GotoGameOver()
                end,
            }
        },

        ---退出房间
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveRole
                function(owner)
                    return owner:CanExitRoom()
                end,
            },
            {
                type = BT_Action.Action,
                once = true,
                ---@param owner CoveRole
                function(owner)
                    return owner:GotoExitRoom()
                end,
            }
        },

        ---补给
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveRole
                function(owner)
                    return owner:CanBuji()
                end,
            },
            {
                type = BT_Action.Action,
                once = true,
                ---@param owner CoveRole
                function(owner)
                    return owner:GotoBuji()
                end,
            }
        },

        --索敌 
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveRole
                function(owner)
                    return owner:CanSuodi()
                end,
            },
            {
                type = BT_Action.Action,
                ---@param owner CoveRole
                function(owner)
                    return owner:GotoSuodi()
                end,
            }
        },
        --走到攻击点
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveRole
                function(owner)
                    return owner:CanCheckAttackPoint()
                end,
            },
            {
                type = BT_Action.Action,
                once = true,
                ---@param owner CoveRole
                function(owner)
                    return owner:GotoAttackPoint()
                end,
            }
        },
        -- 攻击
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveRole
                function(owner)
                    return owner:CanAttack()
                end,
            },
            {
                type = BT_Action.Action,
                once = true,
                ---@param owner CoveRole
                function(owner)
                    return owner:GotoAttack()
                end,
            }
        },

        --分散站位
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveRole
                function(owner)
                    return owner:CanRaidSpread()
                end,
            },
            {
                type = BT_Action.Action,
                once = true,
                ---@param owner CoveRole
                function(owner)
                    return owner:GotoRaidSpreadPoint()
                end,
            }
        },
        
        --播放默认idld
        {
            type = BT_Action.Action,
            function() 
                --print("idle") 
            end,
        },
    }

    ---@type CoveBehaviorTree
    self.bt = BT:new(root, self.owner)

end

function RoleAI:Update(dt)
    self.bt:Update()
end

return RoleAI