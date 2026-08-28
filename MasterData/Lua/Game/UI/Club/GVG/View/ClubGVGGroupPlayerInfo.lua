
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupFightRecordsPopup.prefab > name: PlayInfo1
---@class ClubGVGGroupPlayerInfo
---@field Env                           	ClubGVGGroupPlayerInfo                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               
---@field TextName                      	UnityEngine.UI.Text                     
---@field TextLevel                     	TMPro.TextMeshProUGUI                   
---@field President                     	UnityEngine.RectTransform               
---@field PresidentTextName             	UnityEngine.UI.Text                     
local ClubGVGGroupPlayerInfo = Class('ClubGVGGroupPlayerInfo')

function ClubGVGGroupPlayerInfo:__init()

end


function ClubGVGGroupPlayerInfo:__delete()

end


function ClubGVGGroupPlayerInfo:Awake()
end


function ClubGVGGroupPlayerInfo:Start()
end


function ClubGVGGroupPlayerInfo:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param playerInfo table
function ClubGVGGroupPlayerInfo:FreshUI(playerInfo)
    self:FreshHeadNode(playerInfo)

    self.TextName.text = playerInfo.name

    -- local clubInfo = ClubGVGUtils.GetMgr():GetClubInfoById(playerInfo.clubId)
    if isNotNull(self.TextClub) then
        self.TextClub.text = self:GetClubName(playerInfo) ---clubInfo.name
        
    end

    self.TextLevel.text = string.format("Lv.%s", playerInfo.level)

    if self.President then
        local clubName = self:GetClubName(playerInfo)
        self.PresidentTextName.text = clubName
    end

end

function ClubGVGGroupPlayerInfo:FreshHeadNode(playerInfo)
     ---@type CommonPlayerHeadNode
     local headEnv    = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
     if isNotNull(headEnv) then
         headEnv:FreshAvatarFrame( playerInfo.avatar, playerInfo.avatarFrame)
     end
end

--endregion 


--region get/set 

function ClubGVGGroupPlayerInfo:GetClubName(playerInfo)
    if playerInfo.clubName ~= nil then
        return playerInfo.clubName
    end
    return ClubGVGUtils.GetMgr():GetClubInfoById(playerInfo.clubId).name
end

---endregion 


--region handler 


---endregion 


return ClubGVGGroupPlayerInfo
