-------------------------------------------------------------------------------
-- 社团 - 社团申请列表弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-20 20:14:08
-------------------------------------------------------------------------------

local ApplyListCellPath = 'Game.UI.Club.UIOverseaClubApplyListCell'
local ApplyListCellName = 'Cell'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubApplyForListPopup.prefab
---@class UIOverseaClubApplyListPopup
---@field Env                           	UIOverseaClubApplyListPopup             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field rejectAllBtn                  	UnityEngine.RectTransform               @ 全部拒绝按钮
---@field agreeAllBtn                   	UnityEngine.RectTransform               @ 全部同意按钮
---@field applyEmptyNode                	UnityEngine.RectTransform               @ 申请空节点
---@field applyList                     	SuperScrollView.LoopListView2           @ 申请列表
---@field closeBtn                      	UnityEngine.RectTransform               @ 关闭按钮
---@field backBlock                     	UnityEngine.RectTransform               @ 空白区
local UIOverseaClubApplyListPopup = Class('UIOverseaClubApplyListPopup')


function UIOverseaClubApplyListPopup:__init()
end


function UIOverseaClubApplyListPopup:__delete()
end


function UIOverseaClubApplyListPopup:Awake()
    SetButtonAction(self.closeBtn, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.agreeAllBtn, Bind(self, self.OnClickAgreeAllButtonHandler_))
    SetButtonAction(self.rejectAllBtn, Bind(self, self.OnClickRejectAllButtonHandler_))
    SetListViewAction(self.applyList, Bind(self, self.OnUpdateApplyListCellHandler_), ApplyListCellName)
end


function UIOverseaClubApplyListPopup:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
    end)
end


function UIOverseaClubApplyListPopup:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function UIOverseaClubApplyListPopup:OnShow()
    return CoWaitDo(function()
        self:RequestApplyListData_()
    end)
end


-------------------------------------------------
-- get / set

---@return table[]
function UIOverseaClubApplyListPopup:GetApplyListData()
    return checkTable(self.applyListData_)
end
function UIOverseaClubApplyListPopup:SetApplyListData(listData)
    self.applyListData_ = checkTable(listData)
    self:UpdateApplyList_()
    self:UpdateRedPoint_()
end


-------------------------------------------------
-- private

function UIOverseaClubApplyListPopup:RequestApplyListData_()
    GameUtils.Request(Interfaces.OverseaClubApplyList, {}, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            self:SetApplyListData(responseData.applyList)
        end
    end)
end


function UIOverseaClubApplyListPopup:UpdateApplyList_()
    local listDataLegnth = #self:GetApplyListData()
    CfUtils.SetActive(self.applyEmptyNode, listDataLegnth <= 0)
    GameUtils.ReloadData(self.applyList, listDataLegnth)
end


function UIOverseaClubApplyListPopup:UpdateRedPoint_()
    local listDataLegnth = #self:GetApplyListData()
    ClubUtils.GetClubComp():SetApplyListRedPoint(listDataLegnth > 0)
end


-------------------------------------------------
-- handler

function UIOverseaClubApplyListPopup:OnClickCloseButtonHandler_()
    CfUtils.DialogClose(self.controller)
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function UIOverseaClubApplyListPopup:OnUpdateApplyListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(ApplyListCellName)
    local cellData = self:GetApplyListData()[luaIndex]
    ---@type UIOverseaClubApplyListCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, ApplyListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickAgreeCB(Bind(self, self.OnClickApplyListCellAgreeButtonCallback_))
        cellEnv:SetClickRejectCB(Bind(self, self.OnClickApplyListCellRejectButtonCallback_))

        if listView.DisplayItemNumber < listView.DisplayItemCount then
            cellEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            cellEnv:PlayAnimByIdle()
        end
    end
    return cellNode
end


function UIOverseaClubApplyListPopup:OnClickApplyListCellAgreeButtonCallback_(luaIndex)
    local cellData    = self:GetApplyListData()[luaIndex]
    local requestData = {applyPlayerId = cellData.playerId}
    GameUtils.Request(Interfaces.OverseaClubApplyAgree, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            -- append club member
            ClubUtils.GetClubComp():ClubMemberAppend(cellData)
            -- remove applyList data
            table.remove(self:GetApplyListData(), luaIndex)
            -- refresh applyList data
            self:SetApplyListData(self:GetApplyListData())
            GameUtils.Toast(localize('已通过【_name_】的申请', {_name_ = tostring(cellData.playerName)}))
        end
    end)
end


function UIOverseaClubApplyListPopup:OnClickApplyListCellRejectButtonCallback_(luaIndex)
    local cellData    = self:GetApplyListData()[luaIndex]
    local requestData = {applyPlayerId = cellData.playerId}
    GameUtils.Request(Interfaces.OverseaClubApplyReject, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            -- remove applyList data
            table.remove(self:GetApplyListData(), luaIndex)
            -- refresh applyList data
            self:SetApplyListData(self:GetApplyListData())
            GameUtils.Toast(localize('已拒绝【_name_】的申请', {_name_ = tostring(cellData.playerName)}))
        end
    end)
end


function UIOverseaClubApplyListPopup:OnClickAgreeAllButtonHandler_()
    GameUtils.Request(Interfaces.OverseaClubApplyAgree, {}, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            local playerIdMap = {}
            for _, playerId in ipairs(checkTable(responseData.playerIds)) do
                playerIdMap[tostring(playerId)] = true
            end

            for applyIndex = #self:GetApplyListData(), 1, -1 do
                local applyData = self:GetApplyListData()[applyIndex]
                if playerIdMap[tostring(applyData.playerId)] then
                    -- append club member
                    ClubUtils.GetClubComp():ClubMemberAppend(applyData)
                    -- remove applyList data
                    table.remove(self:GetApplyListData(), applyIndex)
                end
            end
            
            -- refresh applyList data
            self:SetApplyListData(self:GetApplyListData())
            if #self:GetApplyListData() > 0 then
                GameUtils.Toast(localize('已通过部分的申请'))
            else
                GameUtils.Toast(localize('已通过全部的申请'))
            end
        end
    end)
end


function UIOverseaClubApplyListPopup:OnClickRejectAllButtonHandler_()
    GameUtils.Request(Interfaces.OverseaClubApplyReject, {}, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            self:SetApplyListData({})
            GameUtils.Toast(localize('已拒绝全部的申请'))
        end
    end)
end


return UIOverseaClubApplyListPopup
