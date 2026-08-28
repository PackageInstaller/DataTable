
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
--endregion

--region define
local GVGConstants = ClubGVGUtils.Constants
local SetActive    = CfUtils.SetActive
--endregion


--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupFightRecordsPopup.prefab > name: Cell
---@class ClubGVGGroupFightRecordsCell
---@field Env                           	ClubGVGGroupFightRecordsCell            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnCheck                      	UnityEngine.RectTransform               
---@field PlayInfo1                     	UnityEngine.RectTransform               
---@field PlayInfo2                     	UnityEngine.RectTransform               
---@field ImgResult                     	Game.Native.Common.UISwitchImage        
---@field TextName                      	CustomText                              
---@field TextTime                      	CustomText                              
local ClubGVGGroupFightRecordsCell = Class('ClubGVGGroupFightRecordsCell')

function ClubGVGGroupFightRecordsCell:__init()

end


function ClubGVGGroupFightRecordsCell:__delete()

end


-- function ClubGVGGroupFightRecordsCell:Awake()
-- end


function ClubGVGGroupFightRecordsCell:Start()
    SetButtonAction(self.BtnCheck, function() 
        local data = self._data
        CfUtils.DialogOpen(Constants.UITypeIds.ClubGvgGroupFightRecordDetailsPopup, {
            recordId      = data.id,
            playerName    = data.playerName,
            atPlayerName  = data.atPlayerName, 
            playerId      = data.playerId or self._playerId,
            atPlayerId    = data.atPlayerId,
            isInClubView = self._isInClubView ,
        })
    end)
end


function ClubGVGGroupFightRecordsCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param data {id:int, playerId:int, atPlayerId:int, isWin:int, playerName:string, atPlayerName:string, level:int, atPlayerLevel:int, avatar:int, atPlayerAvatar:int, avatarFrame:int, atPlayerAvatarFrame:int, buildingId:int}
function ClubGVGGroupFightRecordsCell:FreshUI(data, isInClubView, playerId)
    self._isInClubView = isInClubView
    self._playerId = playerId
    self._data = data
    local mgr = ClubGVGUtils.GetMgr()
    -- local buildInfo = mgr:GetBuildInfo(data.buildingId)
    local buildingId = data.buildingId
    local buildType = checkInt(buildingId / 10000)
    ---@type ClubGVGBuildingVo
    local vo = ClubGVGUtils.GetBuildingVoById(buildType)

    local env = self:GetLeftPlayerInfoEnv()
    if isNotNull(env) then
        env:FreshUI({
            playerId    = data.playerId,
            name  = data.playerName, 
            level       = data.level, 
            avatar      = data.avatar, 
            avatarFrame = data.avatarFrame, 
            clubId      = data.clubId,
            clubName      = data.clubName or "",
        })
    end

    local env = self:GetRightPlayerInfoEnv()
    if isNotNull(env) then
        env:FreshUI({
            playerId    = data.atPlayerId,
            name  = data.atPlayerName, 
            level       = data.atPlayerLevel, 
            avatar      = data.atPlayerAvatar, 
            avatarFrame = data.atPlayerAvatarFrame, 
            clubId           = data.atClubId,
            clubName      = data.atClubName or "",
        })
    end

    self.ImgResult.Status = data.isWin

    self.TextName.text = ClubGVGUtils.GetBuildingName(vo, buildingId)
    ---todo 时间
    self.TextTime.text = os.date("%m/%d  %H:%M", data.createTime)

end


--endregion 


--region get/set 

---@return ClubGVGGroupPlayerInfo
function ClubGVGGroupFightRecordsCell:GetLeftPlayerInfoEnv()
    if isNull(self._leftPlayerInfoEnv) then
        self._leftPlayerInfoEnv = CfUtils.GetLuaScr(self.PlayInfo1, GVGConstants.LuaPath.ClubGVGGroupPlayerInfo)
    end
    return self._leftPlayerInfoEnv
end

---@return ClubGVGGroupPlayerInfo
function ClubGVGGroupFightRecordsCell:GetRightPlayerInfoEnv()
    if isNull(self._rightPlayerInfoEnv) then
        self._rightPlayerInfoEnv = CfUtils.GetLuaScr(self.PlayInfo2, GVGConstants.LuaPath.ClubGVGGroupPlayerInfo)
    end
    return self._rightPlayerInfoEnv
end

---endregion 


--region handler 


---endregion 


return ClubGVGGroupFightRecordsCell
