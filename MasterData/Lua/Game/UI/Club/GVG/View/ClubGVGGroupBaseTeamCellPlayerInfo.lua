
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
--endregion

--region define
local GVGConstants     = ClubGVGUtils.Constants
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseTeamStatusPopup.prefab > name: PlayerInfo1
---@class ClubGVGGroupBaseTeamCellPlayerInfo
---@field Env                           	ClubGVGGroupBaseTeamCellPlayerInfo      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               	@ 0    
---@field ImgCampIcon                   	UnityEngine.UI.Image                    	@ 1    
---@field TextName                      	CustomText                              	@ 2    
---@field TextClub                      	CustomText                              	@ 3    
---@field NowVitality                   	UnityEngine.RectTransform               	@ 4    
---@field ImgGoodsIcon                  	Engine.UI.ImageAlterable                	@ 5    
---@field TextNumber                    	TMPro.TextMeshProUGUI                   	@ 6    
---@field Force                         	UnityEngine.RectTransform               	@ 7    
---@field ImgIcon                       	UnityEngine.RectTransform               	@ 8    
---@field ForceTextNumber               	TMPro.TextMeshProUGUI                   	@ 9    
local ClubGVGGroupBaseTeamCellPlayerInfo = Class('ClubGVGGroupBaseTeamCellPlayerInfo')

function ClubGVGGroupBaseTeamCellPlayerInfo:__init()

end


function ClubGVGGroupBaseTeamCellPlayerInfo:__delete()

end


function ClubGVGGroupBaseTeamCellPlayerInfo:Awake()
end


function ClubGVGGroupBaseTeamCellPlayerInfo:Start()
end


function ClubGVGGroupBaseTeamCellPlayerInfo:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param playerInfo table
function ClubGVGGroupBaseTeamCellPlayerInfo:FreshUI(playerInfo)
    -- print("playerInfo", table.toString(playerInfo))
    self:FreshHeadNode(playerInfo)

    if self.ImgCampIcon then
        local color = ClubGVGUtils.GetClubColor(playerInfo.clubId)
        self.ImgCampIcon.color = color
    end

    self.TextName.text = playerInfo.name

    local clubInfo = ClubGVGUtils.GetMgr():GetClubInfoById(playerInfo.clubId)
    if clubInfo then
        self.TextClub.text = clubInfo.name
        
    end

    if self._goodsId == nil then
        local goodsId = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.HPGoodsId)
        self._goodsId = goodsId
        ---@type GoodsVo
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        self.ImgGoodsIcon:LoadSprite(vo.photoPath)
    end
    self.TextNumber.text = playerInfo.hp

    self.ForceTextNumber.text = ClubGVGUtils.CalcTeamPower(playerInfo.team)
    
end

function ClubGVGGroupBaseTeamCellPlayerInfo:FreshHeadNode(playerInfo)
     ---@type CommonPlayerHeadNode
     local headEnv    = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
     if isNotNull(headEnv) then
         headEnv:FreshAvatarFrame( playerInfo.avatar, playerInfo.avatarFrame)
         headEnv:SetCallBack(function() 
            CfUtils.DialogOpen(Constants.UITypeIds.ClubGvgGroupCheckTeamPopup, {playerId = playerInfo.playerId})
        end)
     end
     
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return ClubGVGGroupBaseTeamCellPlayerInfo
