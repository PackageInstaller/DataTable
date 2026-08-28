
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
--endregion

--region define
local CELL_ANIM_NAME = {
    HIDE = 'UI_Common_List_Cell_Hide',
    IDLE = 'UI_Common_List_Cell_Idle',
    SHOW = 'UI_Common_List_Cell_Show',
    WAIT = 'UI_Common_List_Cell_Wait',
}
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupFightMessageDialog.prefab > name: Cell
---@class ClubGVGGroupFightMessageCell
---@field Env                           	ClubGVGGroupFightMessageCell            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               
---@field TextName                      	UnityEngine.UI.Text                     
---@field TextLevel                     	TMPro.TextMeshProUGUI                   
---@field BtnRecords                    	UnityEngine.RectTransform               
---@field TextNumber1                   	TMPro.TextMeshProUGUI                   
---@field TextNumber2                   	TMPro.TextMeshProUGUI                   
---@field TextNumber3                   	TMPro.TextMeshProUGUI                   
local ClubGVGGroupFightMessageCell = Class('ClubGVGGroupFightMessageCell')

function ClubGVGGroupFightMessageCell:__init()

end


function ClubGVGGroupFightMessageCell:__delete()
    self._aniCb = nil
end


-- function ClubGVGGroupFightMessageCell:Awake()
-- end


function ClubGVGGroupFightMessageCell:Start()
    SetButtonAction(self.BtnRecords, Bind(self, self.OnClickBtnRecordsAction))

    self._isStart = true
    if self._aniCb then
        self._aniCb()
        self._aniCb = nil
    end
end


function ClubGVGGroupFightMessageCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param data {playerId:number, playerName:string, level:number, avatar:string, avatarFrame:string, killPlayerNum:number, atBuildingTimes:number, point:number}
function ClubGVGGroupFightMessageCell:FreshUI(data, isInClubView)
    self._isInClubView = isInClubView
    self._data = data
    self:FreshHeadNode(data)
    self.TextName.text    = data.playerName
    self.TextLevel.text   = string.format("Lv.%s", data.level)
    self.TextNumber1.text = data.killPlayerNum
    self.TextNumber2.text = data.atBuildingTimes
    self.TextNumber3.text = data.point

end


function ClubGVGGroupFightMessageCell:FreshHeadNode(playerInfo)
    ---@type CommonPlayerHeadNode
    local headEnv    = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    if isNotNull(headEnv) then
        headEnv:FreshAvatarFrame( playerInfo.avatar, playerInfo.avatarFrame)
    end
end


function ClubGVGGroupFightMessageCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.HIDE)
end


function ClubGVGGroupFightMessageCell:PlayAnimByIdle()
    if not self._isStart then
        self._aniCb = function() 
            CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.IDLE)
        end
        return
    end
    CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.IDLE)
end


function ClubGVGGroupFightMessageCell:PlayDelayAnimByShow(delayIndex)
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


---endregion 


--region handler 

function ClubGVGGroupFightMessageCell:OnClickBtnRecordsAction()
    CfUtils.DialogOpen(Constants.UITypeIds.ClubGvgGroupFightRecordsPopup, {playerId = self._data.playerId, isInClubView = self._isInClubView})
end

---endregion 


return ClubGVGGroupFightMessageCell
