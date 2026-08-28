
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
local LabelType        = GVGConstants.BuildingStatusLabelType
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseTeamStatusPopup.prefab > name: StatusIdle
---@class ClubGVGGroupBaseTeamCellIdle
---@field Env                           	ClubGVGGroupBaseTeamCellIdle            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field PlayerInfo                    	UnityEngine.RectTransform               	@ 0    
---@field HeadNode                      	UnityEngine.RectTransform               	@ 1    
---@field ImgCampIcon                   	UnityEngine.UI.Image                    	@ 2    
---@field TextName                      	CustomText                              	@ 3    
---@field TextLevel                     	TMPro.TextMeshProUGUI                   	@ 4    
---@field ClubInfo                      	UnityEngine.RectTransform               	@ 5    
---@field ClubInfoTextName              	CustomText                              	@ 6    
---@field ClubInfoTextServer            	CustomText                              	@ 7    
---@field NowVitality                   	UnityEngine.RectTransform               	@ 8    
---@field NowVitalityImgGoodsIcon       	Engine.UI.ImageAlterable                	@ 9    
---@field NowVitalityTextNumber         	Game.Native.Common.UISwitchTextMeshPro  	@ 10   
---@field BtnDecline                    	UnityEngine.RectTransform               	@ 11   
---@field BtnDeclineTxtNum              	TMPro.TextMeshProUGUI                   	@ 12   
---@field Force                         	UnityEngine.RectTransform               	@ 13   
---@field ForceTextNumber               	TMPro.TextMeshProUGUI                   	@ 14   
---@field Status                        	UnityEngine.RectTransform               	@ 15   
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 16   
---@field Underway                      	UnityEngine.RectTransform               	@ 17   
local ClubGVGGroupBaseTeamCellIdle = Class('ClubGVGGroupBaseTeamCellIdle')

function ClubGVGGroupBaseTeamCellIdle:__init()

end


function ClubGVGGroupBaseTeamCellIdle:__delete()

end


-- function ClubGVGGroupBaseTeamCellIdle:Awake()
-- end


function ClubGVGGroupBaseTeamCellIdle:Start()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAttackPlayer))
    SetButtonAction(self.BtnDecline, Bind(self, self.OnClickBtnDecline))
end


function ClubGVGGroupBaseTeamCellIdle:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param data {playerInfo: table, playerStatus:ClubGVGConstants.PlayerStatus}
function ClubGVGGroupBaseTeamCellIdle:FreshUI(data, position, isInCurrentBuilding)
    local playerInfo = data.playerInfo
    self._playerInfo = playerInfo
    -- print("playerInfo", table.toString(playerInfo))
    self:FreshHeadNode(playerInfo)

    if self.ImgCampIcon then
        local color = ClubGVGUtils.GetClubColor(playerInfo.clubId)
        self.ImgCampIcon.color = color
    end

    self.TextName.text = playerInfo.name
    self.TextLevel.text = playerInfo.level

    local clubInfo = ClubGVGUtils.GetMgr():GetClubInfoById(playerInfo.clubId)
    if clubInfo then
        self.ClubInfoTextName.text = clubInfo.name
        self.ClubInfoTextServer.text = clubInfo.serviceName
    end

    if self._goodsId == nil then
        local goodsId = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.HPGoodsId)
        self._goodsId = goodsId
        ---@type GoodsVo
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        self.NowVitalityImgGoodsIcon:LoadSprite(vo.photoPath)
    end
    

    local hp = playerInfo.hp
    self.NowVitalityTextNumber.text = hp
    local reduction = ClubGVGUtils.CalcHpAttrReduction(hp)
    local isReduction = reduction < 1
    self.NowVitalityTextNumber.Status = isReduction and 2 or 1
    SetActive(self.BtnDecline, isReduction)
    if isReduction then
        self.BtnDeclineTxtNum.text = checkInt(reduction * 100)
    end
    self._reduction = reduction
   
    self.ForceTextNumber.text = ClubGVGUtils.CalcTeamPower(playerInfo.team)

    ---@type ClubGVGMgr
    local mgr        = ClubGVGUtils.GetMgr()
    local playerId   = checkNumber(playerInfo.playerId)
    local isMarching = mgr:GetMarchSecondsById(playerId) ~= nil
    SetActive(self.FontStyleButton, ClubGVGUtils.IsCanAttackPlayer(playerId) and isInCurrentBuilding)
    SetActive(self.Underway, isMarching)

end

function ClubGVGGroupBaseTeamCellIdle:FreshHeadNode(playerInfo)
    ---@type CommonPlayerHeadNode
    local headEnv    = CfUtils.GetLuaScr(self.HeadNode, Constants.UILuaTablePath.ComPlayerHead)
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

function ClubGVGGroupBaseTeamCellIdle:OnClickBtnAttackPlayer()
    ---@type ClubGVGMgr
    local mgr        = ClubGVGUtils.GetMgr()
    ---@type ClubGVGHomeDojo
    local dojo = mgr:GetHomeDojo()
    if dojo.attackCDEndTime > 0 and GameUtils.GetServerTime() < dojo.attackCDEndTime then
        GameUtils.Toast(localize("正在战斗中，请稍后"))
        return
    end

    local seconds = mgr:GetMarchSeconds()
    if seconds ~= nil then
        GameUtils.Toast(localize("正在行军中，请稍后"))
        return
    end

    mgr:RequestAt({atPlayerId = self._playerInfo.playerId})

end

function ClubGVGGroupBaseTeamCellIdle:OnClickBtnDecline()
    local reduction = self._reduction
    local customText = localize("攻防血下降至_num_%", {_num_ = checkInt(reduction * 100)})
    GameUtils.ShowCommonTipsEquipExclusive(self.BtnDecline, nil, customText, true, true)
    
end

---endregion 


return ClubGVGGroupBaseTeamCellIdle
