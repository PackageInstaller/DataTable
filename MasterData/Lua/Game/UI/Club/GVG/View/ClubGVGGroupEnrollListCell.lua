
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type FriendComponent
local friendComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.FriendComponent)
local ChatConstants = import('Game.OverseaChat.ChatConstants')
--endregion

--region define
local SetActive = CfUtils.SetActive

local CELL_ANIM_NAME = {
    HIDE = 'UI_Common_List_Cell_Hide',
    IDLE = 'UI_Common_List_Cell_Idle',
    SHOW = 'UI_Common_List_Cell_Show',
    WAIT = 'UI_Common_List_Cell_Wait',
}
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupEnrollListCell.prefab > name: OverseaClubGvgGroupEnrollListCell
---@class ClubGVGGroupEnrollListCell
---@field Env                           	ClubGVGGroupEnrollListCell              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               
---@field TextDesc                      	UnityEngine.UI.Text                     
---@field TextLevel                     	TMPro.TextMeshProUGUI                   
---@field BtnContact                    	UnityEngine.RectTransform               
---@field BtnAddFriend                  	UnityEngine.RectTransform               
local ClubGVGGroupEnrollListCell = Class('ClubGVGGroupEnrollListCell')

function ClubGVGGroupEnrollListCell:__init()

end


function ClubGVGGroupEnrollListCell:__delete()

end


function ClubGVGGroupEnrollListCell:Awake()
    self:PlayAnimByHide()
end


function ClubGVGGroupEnrollListCell:Start()
    SetButtonAction(self.BtnContact, Bind(self, self.OnClickBtnContactAction))
    SetButtonAction(self.BtnAddFriend, Bind(self, self.OnClickBtnAddFriendAction))

    self._isStart = true
    if self._aniCb then
        self._aniCb()
        self._aniCb = nil
    end
end


function ClubGVGGroupEnrollListCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param memberDojo ClubMemberDojo
---@param isEnableButton boolean
function ClubGVGGroupEnrollListCell:FreshUI(memberDojo, isEnableButton)
    self._memberDojo = memberDojo
    self._isEnableButton = isEnableButton
    local friendData = friendComp:GetFriendInfo(memberDojo.playerId)
    self._friendData = friendData
    local isSelf = checkNumber(memberDojo.playerId) == checkNumber(GameUtils.GetPlayerId())
    self._isSelf = isSelf
    self:FreshButtonShowState(isEnableButton, friendData ~= nil)

    self:FreshHeadNode(memberDojo.playerAvatar, memberDojo.playerAvatarFrame)

    self.TextDesc.text = memberDojo.playerName
    self.TextLevel.text = string.format("Lv.%s", memberDojo.playerLevel)

end


function ClubGVGGroupEnrollListCell:FreshHeadNode(avatar, avatarFrame)
    ---@type CommonPlayerHeadNode
    local headEnv    = self:GetHeadNodeEnv()
    if isNotNull(headEnv) then
        headEnv:FreshAvatarFrame( avatar, avatarFrame)
        -- headEnv:SetCallBack(Bind(self, self.OnClickHeadNodeAction))
    end
end

function ClubGVGGroupEnrollListCell:FreshButtonShowState(isEnableButton, isFriend)
    SetActive(self.BtnAddFriend, isEnableButton and not isFriend and not self._isSelf)
    SetActive(self.BtnContact, isEnableButton and isFriend and not self._isSelf)
    
end


function ClubGVGGroupEnrollListCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.HIDE)
end


function ClubGVGGroupEnrollListCell:PlayAnimByIdle()
    if not self._isStart then
        self._aniCb = function() 
            CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.IDLE)
        end
        return
    end
    CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.IDLE)
end


function ClubGVGGroupEnrollListCell:PlayDelayAnimByShow(delayIndex)
    if not self._isStart then
        self._aniCb = function ()
            CfUtils.PlayDelayShowAnimation(self.controller.gameObject, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
        end
        return
    end
    CfUtils.PlayDelayShowAnimation(self.controller.gameObject, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
end


--endregion 


--region get/set 
---@return CommonPlayerHeadNode
function ClubGVGGroupEnrollListCell:GetHeadNodeEnv()
    if isNull(self._headEnv) then
        ---@type CommonPlayerHeadNode
        self._headEnv    = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    end
    return self._headEnv
end

---endregion 


--region handler 

function ClubGVGGroupEnrollListCell:OnClickBtnContactAction()
    local friendData = self._friendData
    CfUtils.DialogOpen(Constants.UITypeIds.OverseaChatMainDialog, {type = ChatConstants.Channels.Private, data = friendData})

end


function ClubGVGGroupEnrollListCell:OnClickBtnAddFriendAction()
    local playerId = self._memberDojo.playerId
    local friendData = friendComp:GetFriendInfo(playerId)
    if friendData ~= nil then
        self._friendData = friendData
        self:FreshButtonShowState(self._isEnableButton, true)
        return
    end

    friendComp:AddFriend(self._memberDojo.playerId)

end



---endregion 


return ClubGVGGroupEnrollListCell
