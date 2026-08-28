-------------------------------------------------------------------------------
-- 和风战牌 - 规则界面 - 规则列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-22 10:34:44
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerCradRuleNode.prefab > name: ActivityJapanesePokerCradRuleNode
---@class BattleCardGameRuleCell
---@field Env                           	BattleCardGameRuleCell                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field RuleIconIcon                  	UnityEngine.RectTransform               	@ 1    规则图标节点
---@field RuleTitleTxt                  	UnityEngine.RectTransform               	@ 2    规则标题文本
---@field RuleDescrTxt                  	UnityEngine.RectTransform               	@ 3    规则描述文本
local BattleCardGameRuleCell = Class('BattleCardGameRuleCell')


function BattleCardGameRuleCell:__init()
end


function BattleCardGameRuleCell:__delete()
end


function BattleCardGameRuleCell:Awake()
end


function BattleCardGameRuleCell:Start()
end


function BattleCardGameRuleCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameRuleCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function BattleCardGameRuleCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return BattleCardGameRuleInfoVo
function BattleCardGameRuleCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData BattleCardGameRuleInfoVo
function BattleCardGameRuleCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


-------------------------------------------------
-- private

function BattleCardGameRuleCell:UpdateCellInfo_()
    local cellData = self:GetCellData()
    CfUtils.FillText(self.RuleTitleTxt, tostring(cellData.ruleName))
    CfUtils.FillText(self.RuleDescrTxt, tostring(cellData.ruleDescr))
    CfUtils.FillImage(self.RuleIconIcon, BattleCardGameUtils.GetRuleIconPath(cellData.ruleId))
end


return BattleCardGameRuleCell
