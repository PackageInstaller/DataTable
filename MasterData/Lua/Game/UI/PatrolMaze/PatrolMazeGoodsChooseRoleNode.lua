-------------------------------------------------------------------------------
-- 夜巡迷宫 - 道具选择角色弹窗 - 角色节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-21 00:44:17
-------------------------------------------------------------------------------

local MemberNodePath = 'Game.UI.FightTeam.UITeamMembersNode.UITeamMemberNode'

--- from: Assets/BundleResources/Prefabs/Patrol/PatrolChooseRolePopup130201.prefab > name: Cell
---@class PatrolMazeGoodsChooseRoleNode
---@field Env                           	PatrolMazeGoodsChooseRoleNode           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field MemberNode                    	UnityEngine.RectTransform               @ 头像节点
---@field CardPatrolRole                	UnityEngine.RectTransform               @ 助理信息节点
---@field CardDeadImg                   	UnityEngine.RectTransform               @ 卡牌死亡图片
---@field CardSelectImg                 	UnityEngine.RectTransform               @ 卡牌选择图片
---@field UIFXRootNode                  	UnityEngine.RectTransform               @ 特效根节点
---@field UIFX_BloodReturn              	UnityEngine.RectTransform               @ 特效 回血
---@field UIFX_StarLevel                	UnityEngine.RectTransform               @ 特效 升星
---@field UIFX_Resurrection             	UnityEngine.RectTransform               @ 特效 复活
---@field UIFX_AttributePromotion       	UnityEngine.RectTransform               @ 特效 属性提升
local PatrolMazeGoodsChooseRoleNode = Class('PatrolMazeGoodsChooseRoleNode')


function PatrolMazeGoodsChooseRoleNode:__init()
    ---@type UITeamMemberNode
    self.memberNode_ = nil

    ---@type number
    self.oldHpPercent_ = 0

    ---@type number
    self.newHpPercent_ = 0
end


function PatrolMazeGoodsChooseRoleNode:__delete()
    self.memberNode_   = nil
    self.oldHpPercent_ = nil
    self.newHpPercent_ = nil
end


function PatrolMazeGoodsChooseRoleNode:Awake()
    self.memberNode_ = CfUtils.GetLuaScr(self.MemberNode, MemberNodePath)
end


function PatrolMazeGoodsChooseRoleNode:Start()
end


function PatrolMazeGoodsChooseRoleNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolMazeGoodsChooseRoleNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function PatrolMazeGoodsChooseRoleNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function PatrolMazeGoodsChooseRoleNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function PatrolMazeGoodsChooseRoleNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function PatrolMazeGoodsChooseRoleNode:GetClickCellCB()
    return self.clickCellCallback_
end
---@param callback fun(luaIndex:integer):void
function PatrolMazeGoodsChooseRoleNode:SetClickCellCB(callback)
    self.clickCellCallback_ = callback
end


-------------------------------------------------
-- public

function PatrolMazeGoodsChooseRoleNode:UpdateSelectStatus(isSelect)
    CfUtils.SetActive(self.CardSelectImg, isSelect)
end


---@param recoverHp number
function PatrolMazeGoodsChooseRoleNode:ShowRecoverHp(recoverHp)
    local cellData    = self:GetCellData()
    local isReviveHp  = cellData.isReviveHp
    local isIgnorDead = cellData.isIgnorDead

    ---@type PatrolMazeCardDojo
    local mazeCardDojo  = cellData.mazeCardDojo
    local cardhpPercent = checkNumber(mazeCardDojo.hpPercent)

    -- 复活模式下：只有死亡状态才显示加血效果
    if isReviveHp then
        recoverHp = cardhpPercent > 0 and 0 or recoverHp
    end
    self.memberNode_:FillHpEnergy({
        hpPercent    = cardhpPercent,
        hpPercentAdd = recoverHp,
    })

    -- 升星模式下：不显示死亡标识
    if isIgnorDead then
        CfUtils.SetActive(self.CardDeadImg, false)
    else
        CfUtils.SetActive(self.CardDeadImg, cardhpPercent == 0)
    end
end


---@param updateProgress number
function PatrolMazeGoodsChooseRoleNode:UpdateHpProgress(oldHp, newHp, updateProgress)
    local oldHpPercent   = checkNumber(oldHp)
    local newHpPercent   = checkNumber(newHp)
    local hpOffsetNum    = newHpPercent - oldHpPercent
    local hpProgressNum  = hpOffsetNum * updateProgress

    self.memberNode_:FillHpEnergy({
        hpPercent    = oldHpPercent + hpProgressNum,
        hpPercentAdd = hpOffsetNum - hpProgressNum,
    })
    CfUtils.SetActive(self.CardDeadImg, true)
end


function PatrolMazeGoodsChooseRoleNode:PlayRecoverEffect()
    CfUtils.SetActive(self.UIFX_BloodReturn, false)
    CfUtils.SetActive(self.UIFX_BloodReturn, true)
end


function PatrolMazeGoodsChooseRoleNode:PlayUpStarEffect(starNum, cardDojo)
    CfUtils.SetActive(self.UIFX_StarLevel, false)
    CfUtils.SetActive(self.UIFX_StarLevel, true)
    local animName = string.format('PatrolChooseRolePopup130201_Star_%02d', starNum)
    self.memberNode_:FillCardBase(cardDojo, nil, nil, {showStar = true})
    CfUtils.PlayAnimation(self.UIFX_StarLevel, animName)
end


function PatrolMazeGoodsChooseRoleNode:PlayReviveEffect()
    CfUtils.SetActive(self.UIFX_Resurrection, false)
    CfUtils.SetActive(self.UIFX_Resurrection, true)
end


-------------------------------------------------
-- private

function PatrolMazeGoodsChooseRoleNode:UpdateCellInfo_()
    local cellData  = self:GetCellData()
    local recoverHp = checkNumber(cellData.recoverHp)

    ---@type PatrolMazeCardDojo
    local mazeCardDojo = cellData.mazeCardDojo

    -- update head
    self.memberNode_:FillCardBase(mazeCardDojo.cardDojo, nil, nil, {showStar = true})
    self.memberNode_:SetClickCb(Bind(self, self.OnClickHeadNodeHandler_))

    -- update type
    CfUtils.SetActive(self.CardPatrolRole, mazeCardDojo.isAssist)

    -- reset UIFX
    CfUtils.SetActive(self.UIFX_BloodReturn, false)
    CfUtils.SetActive(self.UIFX_StarLevel, false)
    CfUtils.SetActive(self.UIFX_Resurrection, false)
    CfUtils.SetActive(self.UIFX_AttributePromotion, false)
end


-------------------------------------------------
-- handler

function PatrolMazeGoodsChooseRoleNode:OnClickHeadNodeHandler_()
    if self:GetClickCellCB() then
        self:GetClickCellCB()(self:GetLuaIndex())
    end
end


return PatrolMazeGoodsChooseRoleNode
