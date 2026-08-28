-------------------------------------------------------------------------------
-- Pass卡 - 奖励界面 - 奖励列表宝箱节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 16:59:47
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.PassCard.PassCardUtils')
local passCardComp  = PassCardUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/BattlePass/BattlePassContractManual.prefab > name: Cell2
---@class UIBattlePassContractManualFinalNode                    
---@field Env                           	UIBattlePassContractManualFinalNode     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RedPoint                      	UnityEngine.RectTransform               @ 红点节点
---@field DrawUIFX                      	UnityEngine.RectTransform               @ 领取特效
---@field CheckIcon                     	UnityEngine.RectTransform               @ 查看图标
---@field DrwaBtn                       	UnityEngine.RectTransform               @ 领取按钮
---@field IconBtn                       	UnityEngine.RectTransform               @ 图标按钮
---@field TimesTxt                      	UnityEngine.RectTransform               @ 次数文本
---@field DescrTxt                      	UnityEngine.RectTransform               @ 描述文本
---@field TitleTxt                      	UnityEngine.RectTransform               @ 标题文本
---@field AnimRoot                      	UnityEngine.RectTransform               @
local UIBattlePassContractManualFinalNode = Class('UIBattlePassContractManualFinalNode')


function UIBattlePassContractManualFinalNode:__init()
end


function UIBattlePassContractManualFinalNode:__delete()
end


function UIBattlePassContractManualFinalNode:Awake()
end


function UIBattlePassContractManualFinalNode:AddListener()
    if self.eventsDecorated_ then return end
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [PassCardUtils.EventName.PASS_CARD_LOOP_TIMES] = Bind(self, self.OnPassLoopTimesEventHandler_),
    })
end


function UIBattlePassContractManualFinalNode:Start()
    SetButtonAction(self.IconBtn, Bind(self, self.OnClickRewardsTipsIconHandler_))
    SetButtonAction(self.DrwaBtn, Bind(self, self.OnClickDrawRewardsButtonHandler_))
end


function UIBattlePassContractManualFinalNode:OnDestroy()
    CfUtils.EventsUndecorated(self.eventsDecorated_)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIBattlePassContractManualFinalNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIBattlePassContractManualFinalNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UIBattlePassContractManualFinalNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function UIBattlePassContractManualFinalNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
    self:AddListener()
end


---@return fun(luaIndex:integer):void
function UIBattlePassContractManualFinalNode:GetClickDrawCB()
    return self.clickDrawCallback_
end
---@param callback fun(luaIndex:integer):void
function UIBattlePassContractManualFinalNode:SetClickDrawCB(callback)
    self.clickDrawCallback_ = callback
end


-------------------------------------------------
-- private

function UIBattlePassContractManualFinalNode:UpdateCellInfo_()
    local cellData = self:GetCellData()

    -- update descr
    local loopChestDescr = PassCardUtils.GetParamDescr(PassCardUtils.ParamsId.LOOP_CHEST_DESCR)
    CfUtils.FillText(self.DescrTxt, string.fmt(loopChestDescr, {_target_num_ = passCardComp:GetLoopChestEachExp()}))

    -- update times
    local canDrawCount = passCardComp:GetHomeDojo().canDrawCircleTimes
    CfUtils.FillText(self.TimesTxt, localize('<size=50>x</size>_num_', {_num_ = canDrawCount}))

    -- update state
    CfUtils.SetActive(self.RedPoint, canDrawCount > 0)
    CfUtils.SetActive(self.DrawUIFX, canDrawCount > 0)
end


-------------------------------------------------
-- handler

function UIBattlePassContractManualFinalNode:OnPassLoopTimesEventHandler_()
    self:UpdateCellInfo_()
end


function UIBattlePassContractManualFinalNode:OnClickRewardsTipsIconHandler_()
    local rewardsData = passCardComp:GetLoopChestData().rewards
    GameUtils.ShowCommonTipsBattlePass(self.CheckIcon, rewardsData)
end


function UIBattlePassContractManualFinalNode:OnClickDrawRewardsButtonHandler_()
    if self:GetClickDrawCB() then
        self:GetClickDrawCB()(self:GetLuaIndex())
    end
end


return UIBattlePassContractManualFinalNode
