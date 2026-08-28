---
--- Created by Eric.
--- DateTime: 2022/1/4 17:58
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIModule     = CS.Engine.UI.UIModule
local DOTween = CS.DG.Tweening.DOTween
local KTool = CS.Engine.Lib.KTool
---@class CatHouseOtherPlayersDialog
---@field FontStyleButton                UnityEngine.RectTransform
---@field PraiseNum                      TMPro.TextMeshProUGUI
---@field CatHouseNum                    TMPro.TextMeshProUGUI
---@field PraiseBtn                      Game.Native
---@field PraiseImage                    Game.Native.Common.UISwitchImage
---@field PlayerName                     UnityEngine.UI.Text
---@field BtnSwitch                      UnityEngine.RectTransform
---@field BtnAddFriends                  UnityEngine.RectTransform
---@field FontStyleButton                UnityEngine.RectTransform
---@field BtnBack                        UnityEngine.RectTransform
---@field HeatPoint                      UnityEngine.Animator
local CatHouseOtherPlayersDialog = Class("CatHouseOtherPlayersDialog")
function CatHouseOtherPlayersDialog:__init()
end

function CatHouseOtherPlayersDialog:__delete()
    --退出 ， 恢复为原来的用户
    Events.Broadcast(Constants.EventNames.CatHouseSwitchUserEvent, true)
end

function CatHouseOtherPlayersDialog:Awake()
    --好友或者默认人
    Events.Broadcast(Constants.EventNames.CatHouseSwitchUserEvent, false)
end

function CatHouseOtherPlayersDialog:OnFocus(focus)
    self:BindClick()
end
function CatHouseOtherPlayersDialog:OnShow(focus)
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        xTry(function()
            self:InitView()
        end)
    end))
    return coWait
end
function CatHouseOtherPlayersDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        xTry(function()
        end)
    end))
    return coWait
end

function CatHouseOtherPlayersDialog:InitView()
    ---@type CatHouseOtherPlayerComponent
    local catHouseOtherPlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseOtherPlayerComponent , Constants.CatHouseEntityId)
    local catHouseHomeDojo =  catHouseOtherPlayerComponent:GetCatHouseHomeDojo()
    local count = 0
    if not isNull(catHouseHomeDojo.catList)  then
        count = table.count(catHouseHomeDojo.catList)
    end
    self.CatHouseNum.text = tostring(count)
    self.PraiseNum.text = catHouseHomeDojo.catHousePopularity

    if checkInt(catHouseHomeDojo.catHousePraised) == 1 then
        CfUtils.PlayAnimator(self.HeatPoint.gameObject, "Activate")

    else
        CfUtils.PlayAnimator(self.HeatPoint.gameObject, "Dark")

    end
    -- 是否是好友
    if self:IsFriend(catHouseHomeDojo.masterPlayerId) then
        KTool.SetActive(self.BtnAddFriends.gameObject, false)
    else
        KTool.SetActive(self.BtnAddFriends.gameObject, true)
    end
    --判断当前陌生人是否发送过好友请求
    ---@type FriendComponent
    local friendComponent =  GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FriendComponent)
    local IsSendAddReq = friendComponent:IsSendAddReq(catHouseHomeDojo.masterPlayerId)
    if IsSendAddReq then
        CfUtils.SetCanvasGroupAlpha(self.BtnAddFriends.gameObject ,  0.5)
    else
        CfUtils.SetCanvasGroupAlpha(self.BtnAddFriends.gameObject ,  1)
    end
    self.PlayerName.text = catHouseHomeDojo.name
end

function CatHouseOtherPlayersDialog:BindClick()
    -- 发送好友请求
    SetButtonAction(self.BtnAddFriends, function()
        ---@type CatHouseOtherPlayerComponent
        local catHouseOtherPlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseOtherPlayerComponent , Constants.CatHouseEntityId)
        local catHouseHomeDojo =  catHouseOtherPlayerComponent:GetCatHouseHomeDojo()
        local friendId = checkNumber(catHouseHomeDojo.masterPlayerId)
        ---@type FriendComponent
        local friendComponent =  GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FriendComponent)
        local IsSendAddReq = friendComponent:IsSendAddReq(friendId)
        if IsSendAddReq then
            CfUtils.SetCanvasGroupAlpha(self.BtnAddFriends.gameObject ,  0.5)
            GameUtils.Toast(localize("好友申请已发送"))
            return
        end
        local friendSendSuccess =  function ()
            if isNull(self.BtnAddFriends.gameObject) then
                return
            end
            CfUtils.SetCanvasGroupAlpha(self.BtnAddFriends.gameObject ,  0.5)
        end
        friendComponent:AddFriend(friendId, friendSendSuccess)
    end)
    -- 点赞请求
    SetButtonAction(self.PraiseBtn, function()
        ---@type CatHouseOtherPlayerComponent
        local catHouseOtherPlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseOtherPlayerComponent , Constants.CatHouseEntityId)
        local catHouseHomeDojo =  catHouseOtherPlayerComponent:GetCatHouseHomeDojo()
        if checkNumber(catHouseHomeDojo.catHousePraised) == 1 then
            GameUtils.Toast(localize("今日已点赞"))
            return
        end
        local friendId = checkNumber(catHouseHomeDojo.masterPlayerId)
        GameUtils.Request(Interfaces.CatHousePraise,{masterPlayerId = friendId}, function(request, response)
            if checkNumber(response.errCode) ~= 0 then return end
            local catHousePopularity = checkNumber(catHouseHomeDojo.catHousePopularity)+1
            catHouseHomeDojo.catHousePraised = 1
            self.PraiseNum.text = tostring(catHousePopularity)
            GameUtils.Toast(localize("点赞成功"))
            CfUtils.PlayAnimator(self.HeatPoint.gameObject, "Like")
            ---@type FriendComponent
            local component = GameUtils.GetEntityCompByType(ECSComponentType.Constants.FriendComponent)
            local friendData =  component:GetFriendInfo(friendId)
            if isNull(friendData) then
                return
            end
            friendData.catHousePopularity = catHousePopularity
            friendData.catHousePraised = catHouseHomeDojo.catHousePraised
        end)
    end)
    -- 随便逛逛
    SetButtonAction(self.FontStyleButton, function()
        GameUtils.Request(Interfaces.CatHouseVisit,{}, function(request, response)
            --- 前往玩家猫屋界面
            if checkNumber(response.errCode) ~= 0 then return end
            --TODO 前往玩家猫屋界面
            local data =  response.data
            if isNull(data) then
                return
            end
            if checkInt(data.masterPlayerId) == 0 then
                GameUtils.Toast(localize("没有匹配到玩家"))
                return
            end
            ---@type ECSWorldMgr
            local worldMgr = ECSWorldMgr:GetInstance()
            ---@type ECSWorld
            local world = worldMgr:GetWorld(Constants.GameWorld)
            ---@type ECSEntity
            local entity = world:GetEntity(Constants.PlayerEntityId)
            -- 先删除猫屋其他信息的组建
            entity:RemoveComp(ECSComponentType.Constants.CatHouseOtherPlayerComponent)
            ---@type CatHouseOtherPlayerComponent
            local CatHouseOtherPlayerComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.CatHouseOtherPlayerComponent,Constants.CatHouseEntityId)
            CatHouseOtherPlayerComponent:InitialDojo(data)
            self:InitView()
            --好友或者默生人， 通知猫屋更新猫
            Events.Broadcast(Constants.EventNames.CatHouseSwitchUserEvent, false)
        end)
    end)
    SetButtonAction(self.BtnSwitch, function()
        Events.Broadcast(Constants.EventNames.CatHouseSwitchAngleEvent)
    end)
    --返回猫屋主界面
    SetButtonAction(self.BtnBack, function()
        UIModule.CloseDialog(self.controller)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICatHouseVisitDialog})
    end)

end

---@deprecated 当前是否是好友
---@return boolean
function CatHouseOtherPlayersDialog:IsFriend(friendId)
    local friendId = checkNumber(friendId)
    ---@type FriendComponent
    local component = GameUtils.GetEntityCompByType(ECSComponentType.Constants.FriendComponent)
    return  component:IsFriend(friendId)

end


function CatHouseOtherPlayersDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return CatHouseOtherPlayersDialog

