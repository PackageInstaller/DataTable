-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主界面 - 控制面板 - 卡牌节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-17 11:52:32
-------------------------------------------------------------------------------

local MemberNodePath = 'Game.UI.FightTeam.UITeamMembersNode.UITeamMemberNode'

--- from: Assets/BundleResources/Prefabs/Patrol/PartolBtnLeftNode130201.prefab > name: Cell
---@class PatrolMazeMainControlPanelCardNode
---@field Env                           	PatrolMazeMainControlPanelCardNode      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CardDeadImg                   	UnityEngine.RectTransform               @ 卡牌死亡图片
---@field CardPatrolRole                	UnityEngine.RectTransform               @ 助理信息节点
---@field TeamMemberNode                	UnityEngine.RectTransform               @ 头像节点
local PatrolMazeMainControlPanelCardNode = Class('PatrolMazeMainControlPanelCardNode')


function PatrolMazeMainControlPanelCardNode:__init()
    ---@type UITeamMemberNode
    self.memberNode_ = nil
end


function PatrolMazeMainControlPanelCardNode:__delete()
    self.memberNode_ = nil
end


function PatrolMazeMainControlPanelCardNode:Awake()
    self.memberNode_ = CfUtils.GetLuaScr(self.TeamMemberNode, MemberNodePath)
end


function PatrolMazeMainControlPanelCardNode:Start()
end


function PatrolMazeMainControlPanelCardNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolMazeMainControlPanelCardNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function PatrolMazeMainControlPanelCardNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function PatrolMazeMainControlPanelCardNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function PatrolMazeMainControlPanelCardNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function PatrolMazeMainControlPanelCardNode:GetClickCellCB()
    return self.clickCellCallback_
end
---@param callback fun(luaIndex:integer):void
function PatrolMazeMainControlPanelCardNode:SetClickCellCB(callback)
    self.clickCellCallback_ = callback
end


-------------------------------------------------
-- private

function PatrolMazeMainControlPanelCardNode:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type PatrolMazeAreaDojo
    local mapAreaDojo = cellData.mapAreaDojo

    ---@type PatrolMazeCardDojo
    local mazeCardDojo = cellData.mazeCardDojo

    -- update head
    local monsterData = {
        id        = mazeCardDojo.id,
        idType    = Constants.IDType.QuestPatrolMaze,
        hpPercent = 1,
        energy    = 0,
    }
    self.memberNode_:FillCardPatrol(mazeCardDojo.cardDojo)
    self.memberNode_:SetClickCb(Bind(self, self.OnClickHeadNodeHandler_))

    -- update type
    CfUtils.SetActive(self.CardPatrolRole, mazeCardDojo.isAssist)
    
    -- update hp
    local cardhpPercent = checkNumber(mazeCardDojo.hpPercent)
    self.memberNode_:FillHpEnergy({hpPercent = cardhpPercent})
    CfUtils.SetActive(self.CardDeadImg, cardhpPercent == 0)
end


-------------------------------------------------
-- handler

function PatrolMazeMainControlPanelCardNode:OnClickHeadNodeHandler_()
    if self:GetClickCellCB() then
        self:GetClickCellCB()(self:GetLuaIndex())
    end
end


return PatrolMazeMainControlPanelCardNode
