---
--- Created by XiaoHao.
--- DateTime: 2022/5/16 14:52
---

------------ import ------------
local KTool = CS.Engine.Lib.KTool
local Button = CS.UnityEngine.UI.Button
---@type FriendComponent
local FriendComponent =  GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FriendComponent)
local UIModule     = CS.Engine.UI.UIModule

---@class CatHouseVisitCell
---@field AnimRoot                      UnityEngine.RectTransform
---@field CommonPlayerHeadNode          UnityEngine.RectTransform
---@field FriendName                  	UnityEngine.RectTransform
---@field FontStyleWithIconButton       UnityEngine.RectTransform
---@field CatNumber                   	TMPro.TextMeshProUGUI
---@field PraisedNum                   	TMPro.TextMeshProUGUI
---@field PraiseBtn                   	UnityEngine.RectTransform
---@field ImgCommend                   	UnityEngine.UI.Image
---@field BtnAddFriends                 UnityEngine.RectTransform
---@field IdentityBg                   	Game.Native.Common.UISwitchImage
---@field IdentityLabel                 UnityEngine.UI.Text
local CatHouseVisitCell = Class("CatHouseVisitCell")
function CatHouseVisitCell:__init()
    self.isAction = false  -- 是否播放列表动画

end

function CatHouseVisitCell:__delete()
    self.controller = nil
    self.isAction = nil
    self.data = nil  -- 好友数据
end

function CatHouseVisitCell:PlayDelayShowAnimate()
    if not self.isAction then
        self.isAction = true
        CfUtils.PlayDelayShowAnimate(self.AnimRoot,1)
    else
        CfUtils.PlayDelayShowAnimate(self.AnimRoot,0)
    end
end
---@deprecated 刷新好友列表
---@param data table
function CatHouseVisitCell:RefreshFriendNode(data)
    ---@type CommonPlayerHeadNode
    local headNodeLua = CfUtils.GetLuaScr(self.CommonPlayerHeadNode.gameObject, "Game.Behaviours.CommonPlayerHeadNode")
    if isNull(headNodeLua) then
        return
    end
    self.data = data
    headNodeLua:FreshAvatarFrame(data.avatar, data.avatarFrame)
    self.FriendName.text = data.name
    self.PraisedNum.text = tostring(data.catHousePopularity)
    self.CatNumber.text = tostring(data.catHousePetsNum)
    --if checkInt(data.catHousePraised) == 0  then
    --    InvestigateShared:LoadSpriteAsync(self.ImgCommend,'UIAtlas/CatHouse/Common/cathouse_visit_btn_praise_1.png')
    --else
    --    InvestigateShared:LoadSpriteAsync(self.ImgCommend,'UIAtlas/CatHouse/Common/cathouse_visit_btn_praise_2.png')
    --end
    SetButtonAction(self.FontStyleWithIconButton, Bind(self, self.VisitClick))
    --SetButtonAction(self.PraiseBtn, Bind(self, self.PraiseClick))
end
---@deprecated 拜访的点击事件
function CatHouseVisitCell:VisitClick()
    xTry(function ()
        local data = self.data
        local friendId = data.playerId or data.friendId
        local requestData = friendId and {masterPlayerId = friendId} or  {}
        -----@type FriendComponent
        local friendComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.FriendComponent)
        local isUnlock =  friendComponent:GetUnlockModule(data.unlockModuleIds , Constants.SystemToggleIds.Id234)
        --local isUnlock = false
        --local moduleId = Constants.SystemToggleIds.Id234
        --local unlockModuleIds = data.unlockModuleIds or {}
        --for index, oneModuleId in pairs(unlockModuleIds) do
        --    if checkInt(oneModuleId) == moduleId  then
        --        isUnlock = true
        --    end
        --end

        if not isUnlock then
            GameUtils.Toast(localize("当前好友暂未开启猫屋"))
            return
        end
        Events.Broadcast(Constants.EventNames.CatHouseVisitEvent,requestData)
    end)

end
---@deprecated 点赞点击事件
--function CatHouseVisitCell:PraiseClick()
--    local data = self.data
--    if checkNumber(data.catHousePraised) == 1 then
--        GameUtils.Toast(localize("今日已点赞"))
--        return
--    end
--    local friendId = data.friendId or data.playerId
--    GameUtils.Request(Interfaces.CatHousePraise,{masterPlayerId = friendId}, function(request, response)
--        if checkNumber(response.errCode) ~= 0 then return end
--        local catHousePopularity = checkNumber(data.catHousePopularity)+1
--        self.PraisedNum.text = tostring(catHousePopularity)
--        data.catHousePraised = 1
--        InvestigateShared:LoadSpriteAsync(self.ImgCommend,'UIAtlas/CatHouse/Common/cathouse_visit_btn_praise_2.png')
--        GameUtils.Toast(localize("点赞成功"))
--    end)
--end
function CatHouseVisitCell:AddFriend()
    local data = self.data
    local friendId = checkNumber(data.playerId)
    local IsSendAddReq = FriendComponent:IsSendAddReq(data.playerId)
    CfUtils.SetCanvasGroupAlpha(self.BtnAddFriends.gameObject ,  0.5)
    if IsSendAddReq then
        GameUtils.Toast(localize("好友申请已发送"))
        return
    end
    local friendSendSuccess =  function ()
        -- 更新发送状态
    end
    FriendComponent:AddFriend(friendId, friendSendSuccess)
end

function CatHouseVisitCell:RefreshVisitNode(data)
    ---@type CommonPlayerHeadNode
    local headNodeLua = CfUtils.GetLuaScr(self.CommonPlayerHeadNode.gameObject, "Game.Behaviours.CommonPlayerHeadNode")
    if isNull(headNodeLua) then
        return
    end
    self.data = data
    headNodeLua:FreshAvatarFrame(data.avatar, data.avatarFrame)
    self.FriendName.text = data.name
    self.PraisedNum.text = tostring(data.catHousePopularity)
    self.CatNumber.text =  tostring(data.catHousePetsNum)
    --if checkInt(data.catHousePraised) == 0  then
    --    InvestigateShared:LoadSpriteAsync(self.ImgCommend,'UIAtlas/CatHouse/Common/cathouse_visit_btn_praise_1.png')
    --else
    --    InvestigateShared:LoadSpriteAsync(self.ImgCommend,'UIAtlas/CatHouse/Common/cathouse_visit_btn_praise_2.png')
    --end

    local text = ""
    if self:IsFriend(data.playerId) then
        text = localize("好友")
        KTool.SetActive(self.BtnAddFriends.gameObject , false)
        self.IdentityLabel.text = text
        self.IdentityBg.Status = 2
    else
        text = localize("陌生人")
        KTool.SetActive(self.BtnAddFriends.gameObject , true)
        SetButtonAction(self.BtnAddFriends, Bind(self, self.AddFriend))
        -- 判断是否已经发送好友请求 ， 如果已经发送， 显示状态更新

        self.IdentityBg.Status = 1
        self.IdentityLabel.text = text
        if FriendComponent:IsSendAddReq(data.playerId) then
            CfUtils.SetCanvasGroupAlpha(self.BtnAddFriends.gameObject ,  0.5)
        else
            CfUtils.SetCanvasGroupAlpha(self.BtnAddFriends.gameObject ,  1)
        end
    end
    SetButtonAction(self.FontStyleWithIconButton, Bind(self, self.VisitClick))
    --SetButtonAction(self.PraiseBtn, Bind(self, self.PraiseClick))
end
---@deprecated 当前是否是好友
---@return boolean 
function CatHouseVisitCell:IsFriend(friendId)
    local friendId = checkNumber(friendId)
    ---@type FriendComponent
    local component = GameUtils.GetEntityCompByType(ECSComponentType.Constants.FriendComponent)
    return component:IsFriend(friendId)
end

function CatHouseVisitCell:Awake()

end

function CatHouseVisitCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseVisitCell