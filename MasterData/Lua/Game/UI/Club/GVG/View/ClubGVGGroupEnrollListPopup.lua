
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait

--endregion

--region define
local SetActive = CfUtils.SetActive

local CellName    = "OverseaClubGvgGroupEnrollListCell"
local CellLuaPath = "Game.UI.Club.GVG.View.ClubGVGGroupEnrollListCell"
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupEnrollListPopup.prefab > name: OverseaClubGvgGroupEnrollListPopup
---@class ClubGVGGroupEnrollListPopup
---@field Env                           	ClubGVGGroupEnrollListPopup             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Root                          	UnityEngine.RectTransform               	@ 0    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 1    
---@field ClickClose                    	UnityEngine.RectTransform               	@ 2    
---@field Empty                         	UnityEngine.RectTransform               	@ 3    
---@field ContributionLackScrollView    	SuperScrollView.LoopListView2           	@ 4    
---@field AlreadyJoinInEmpty            	UnityEngine.RectTransform               	@ 5    
---@field AlreadyJoinInScrollView       	SuperScrollView.LoopListView2           	@ 6    
---@field JoinTextNumber                	TMPro.TextMeshProUGUI                   	@ 7    
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 8    
---@field FontStyleButton2              	UnityEngine.RectTransform               	@ 9    
local ClubGVGGroupEnrollListPopup = Class('ClubGVGGroupEnrollListPopup')


function ClubGVGGroupEnrollListPopup:__init()
end


function ClubGVGGroupEnrollListPopup:__delete()
    self.controller = nil
end


-- function ClubGVGGroupEnrollListPopup:Awake()
-- end


function ClubGVGGroupEnrollListPopup:OnFocus(focus)

end


function ClubGVGGroupEnrollListPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI()
    end))
    return coWait
end


function ClubGVGGroupEnrollListPopup:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end


function ClubGVGGroupEnrollListPopup:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function ClubGVGGroupEnrollListPopup:OnInit()
    self:Request()
    self:InitData()
    self:InitAction()

end

function ClubGVGGroupEnrollListPopup:InitData()
    local homeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    local signUpPlayerIds = self._signUpPlayerIds
    local signUpPlayerId2Res = {}
    for key, signUpPlayerId in pairs(signUpPlayerIds) do
        signUpPlayerId2Res[checkNumber(signUpPlayerId)] = true
    end
    local memberList = homeDojo.memberList
    local signUpPlayerDataList   = {}
    local unSignUpPlayerDataList = {}
    for key, value in pairs(memberList) do
        local dataList = signUpPlayerId2Res[checkNumber(value.playerId)] == true and signUpPlayerDataList or unSignUpPlayerDataList
        table.insert(dataList, value)
        
    end

    ---@type ClubMemberDojo[]
    self._signUpPlayerDataList   = signUpPlayerDataList
    ---@type ClubMemberDojo[]
    self._unSignUpPlayerDataList = unSignUpPlayerDataList
    self._totalMember = #memberList
end

function ClubGVGGroupEnrollListPopup:Request()
    local res = false
    GameUtils.Request(Interfaces.overseaClubGVGSignPlayer, {}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local jsonData        = response.data
        local signUpPlayerIds = checkTable(jsonData.signUpPlayerIds)
        self._signUpPlayerIds = signUpPlayerIds
        res = true
    end)

    local CoYield = CoYield
    while not res do
        CoYield()
    end
end

function ClubGVGGroupEnrollListPopup:InitAction()
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickBtnCloseAction))
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickBtnCloseAction))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnCloseAction))
    SetButtonAction(self.FontStyleButton2, Bind(self, self.OnClickApplyBtnAction))
end

--endregion 


--region logic 

function ClubGVGGroupEnrollListPopup:FreshUI()
    self:FreshContributionLack()
    self:FreshAlreadyJoinIn()
end

function ClubGVGGroupEnrollListPopup:FreshContributionLack()
    local count = #self._unSignUpPlayerDataList
    local isEmpty = count == 0
    SetActive(self.Empty, isEmpty)
    SetActive(self.ContributionLackScrollView, not isEmpty)
    if not isEmpty then
        self:FreshContributionLackScrollView(count)
    end
end

function ClubGVGGroupEnrollListPopup:FreshContributionLackScrollView(count)
    local ScrollView = self.ContributionLackScrollView
    if not ScrollView.IsListViewInit then
        ScrollView:InitListView(count, Bind(self, self.OnGetContributionLackItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end
end

function ClubGVGGroupEnrollListPopup:OnGetContributionLackItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(CellName)
    local node = GetLuaBehaviour(cell.gameObject, CellLuaPath)
    
    ---@type ClubGVGGroupEnrollListCell
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end
    
    if nodeEnv then
        local pos = index + 1
        local data = self._unSignUpPlayerDataList[pos]
        nodeEnv:FreshUI(data, true)

        if listView.DisplayItemNumber < listView.DisplayItemCount then
            nodeEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            nodeEnv:PlayAnimByIdle()
        end
    end

    return cell
end

function ClubGVGGroupEnrollListPopup:FreshAlreadyJoinIn()
    local count = #self._signUpPlayerDataList
    self.JoinTextNumber.text = string.format("<color=#ED5CB5>%s</color>/%s", count, self._totalMember)

    local isEmpty = count == 0
    SetActive(self.AlreadyJoinInEmpty, isEmpty)
    SetActive(self.AlreadyJoinInScrollView, not isEmpty)
    if not isEmpty then
        self:FreshAlreadyJoinInScrollView(count)
    end
end


function ClubGVGGroupEnrollListPopup:FreshAlreadyJoinInScrollView(count)
    local ScrollView = self.AlreadyJoinInScrollView
    if not ScrollView.IsListViewInit then
        ScrollView:InitListView(count, Bind(self, self.OnGetAlreadyJoinInItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end
end

function ClubGVGGroupEnrollListPopup:OnGetAlreadyJoinInItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(CellName)
    local node = GetLuaBehaviour(cell.gameObject, CellLuaPath)
    
    ---@type ClubGVGGroupEnrollListCell
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end
    
    if nodeEnv then
        local pos = index + 1
        local data = self._signUpPlayerDataList[pos]
        nodeEnv:FreshUI(data, false)

        if listView.DisplayItemNumber < listView.DisplayItemCount then
            nodeEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            nodeEnv:PlayAnimByIdle()
        end

    end

    return cell
end

--endregion 


--region get/set 


---endregion 


--region handler 

function ClubGVGGroupEnrollListPopup:OnClickBtnCloseAction()
    CfUtils.DialogBack()
end

function ClubGVGGroupEnrollListPopup:OnClickApplyBtnAction()
    GameUtils.SecondConfirm(localize('是否报名参加活动？'), function()
        GameUtils.Request(Interfaces.OverseaClubGVGApply, {}, function(request, response)
            if checkInt(response.errCode) == 0 then
                local clubHomeDojo = ClubUtils:GetClubComp():GetHomeDojo()
                clubHomeDojo:SetGvgApplyState(true)
                GameUtils.Toast(localize('报名成功，请等待活动开启'))
                CfUtils.DialogBack()
            end
        end)
    end)
end

---endregion 


return ClubGVGGroupEnrollListPopup
