-------------------------------------------------------------------------------
-- 周年庆 - 庆典小铺（大转盘） - 兑换奖励列表项
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-24 14:35:48
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/Anniversary/AnniversaryTurntableRankRewardPopup122501.prefab
---@class ActivityRotaryTableExchangeCell
---@field Env                           	ActivityRotaryTableExchangeCell      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Finish                        	UnityEngine.RectTransform               
---@field FontStyleButton               	UnityEngine.RectTransform               
---@field TxtNo                         	UnityEngine.RectTransform               
---@field Imgbg                         	UnityEngine.RectTransform               
---@field BtnGroup                      	UnityEngine.RectTransform               
---@field CommonGoodsList               	UnityEngine.RectTransform               @ 道具节点
---@field TxtRanking                    	UnityEngine.RectTransform               @ 名次文本框
---@field Item                          	UnityEngine.RectTransform               
local ActivityRotaryTableExchangeCell = Class('ActivityRotaryTableExchangeCell')


function ActivityRotaryTableExchangeCell:__init()
    ---@type CommonGoodsList
    self.goodsListEnv_ = nil
end


function ActivityRotaryTableExchangeCell:__delete()
    self.goodsListEnv_ = nil
end


function ActivityRotaryTableExchangeCell:Awake()
    self.goodsListEnv_ = CfUtils.GetLuaScr(self.CommonGoodsList, 'Game.Behaviours.CommonGoodsList')
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickDrawButtonHandler_))
end


function ActivityRotaryTableExchangeCell:Start()
end


function ActivityRotaryTableExchangeCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

function ActivityRotaryTableExchangeCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
function ActivityRotaryTableExchangeCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return ActivityRotaryTableExchangeDojo
function ActivityRotaryTableExchangeCell:GetCellData()
    return checkTable(self.cellData_)
end
function ActivityRotaryTableExchangeCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:RefreshData_()
end


---@return fun(sender:ActivityRotaryTableExchangeCell):void
function ActivityRotaryTableExchangeCell:GetDrawCb()
    return self.drawCb_
end
function ActivityRotaryTableExchangeCell:SetDrawCb(callback)
    self.drawCb_ = callback
end


-------------------------------------------------
-- private

function ActivityRotaryTableExchangeCell:OnClickDrawButtonHandler_()
    if self:GetDrawCb() then
        self:GetDrawCb()(self)
    end
end


function ActivityRotaryTableExchangeCell:RefreshData_()
    ---@type ActivityRotaryTableExchangeDojo
    local cellData = self:GetCellData()

    -- update rank
    CfUtils.FillText(self.TxtRanking, tostring(cellData.name))
    
    -- update rewards
    local rewardList = checkTable(cellData.rewards)
    if not isNull(self.goodsListEnv_) and #rewardList > 0 then
        self.goodsListEnv_:FreshBaseUI(rewardList)
    end

    -- update status
    local dataStatus = checkInt(cellData.status)
    local isUnfinish = dataStatus == 0
    local isFinished = dataStatus == 1
    local isReceived = dataStatus == 2
    CfUtils.SetActive(self.TxtNo, isUnfinish)
    CfUtils.SetActive(self.FontStyleButton, isFinished)
    CfUtils.SetActive(self.Finish, isReceived)
end


return ActivityRotaryTableExchangeCell
