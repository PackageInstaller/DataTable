
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
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

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupRankingsDialog.prefab > name: Cell
---@class ClubGVGGroupRankingsNode
---@field Env                           	ClubGVGGroupRankingsNode                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgRank2                      	Game.Native.Common.UISwitchImage        	@ 0    
---@field ImgRank                       	Game.Native.Common.UISwitchImage        	@ 1    
---@field TxtRanking                    	TMPro.TextMeshProUGUI                   	@ 2    
---@field RankNode                      	UnityEngine.RectTransform               	@ 3    
---@field PlayerInfo                    	UnityEngine.RectTransform               	@ 4    
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               	@ 5    
---@field PlayerInfoTextName            	UnityEngine.UI.Text                     	@ 6    
---@field PlayerInfoTextLevel           	TMPro.TextMeshProUGUI                   	@ 7    
---@field PlayerInfoClubTextName        	UnityEngine.UI.Text                     	@ 8    
---@field TxtTotal                      	TMPro.TextMeshProUGUI                   	@ 9    
---@field ImgMySelf                     	UnityEngine.RectTransform               	@ 10   
---@field ClubInfo                      	UnityEngine.RectTransform               	@ 11   
---@field ImgHead                       	Engine.UI.ImageAlterable                	@ 12   
---@field TextName                      	UnityEngine.UI.Text                     	@ 13   
---@field President                     	UnityEngine.RectTransform               	@ 14   
---@field PresidentTextName             	UnityEngine.UI.Text                     	@ 15   
---@field TxtBuildingNum                	TMPro.TextMeshProUGUI                   	@ 16   
---@field TxtParticipateNum             	TMPro.TextMeshProUGUI                   	@ 17   
---@field ImgLine3                      	UnityEngine.RectTransform               	@ 18   
---@field ImgLine4                      	UnityEngine.RectTransform               	@ 19   
local ClubGVGGroupRankingsNode = Class('ClubGVGGroupRankingsNode')

function ClubGVGGroupRankingsNode:__init()

end


function ClubGVGGroupRankingsNode:__delete()

end


function ClubGVGGroupRankingsNode:Start()
    self._isStart = true
    if self._aniCb then
        self._aniCb()
        self._aniCb = nil
    end
end


function ClubGVGGroupRankingsNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param rankData {score:number, ranking:number, point:number, clubName:number, playerId:number, chairmanName:string, buildPoint:number, playerJoinPoint:number}
---@param labelType number 1->工会 2—>玩家
function ClubGVGGroupRankingsNode:FreshUI(rankData, labelType, playerId)
    self._rankData = rankData
    local rankingNum = checkNumber(rankData.ranking)
    local status = rankingNum > 4 and 5 or rankingNum
    self.TxtRanking.text = rankData.ranking
    self.ImgRank.Status = status
    
    if isNotNull(self.ImgRank2) then
        SetActive(self.ImgRank2, status ~= 5)
        self.ImgRank2.Status = status
    end

    local isClub   = labelType == 1
    local isPlayer = labelType == 2
    self._isPlayer = isPlayer
    self._playerId = rankData.playerId
    SetActive(self.PlayerInfo, isPlayer)
    SetActive(self.ClubInfo, isClub)

    SetActive(self.ImgLine3, isClub)
    SetActive(self.ImgLine3, isClub)
    SetActive(self.TxtBuildingNum, isClub)
    SetActive(self.TxtParticipateNum, isClub)

    if isPlayer then
        self:FreshHeadNode(rankData)
        self.PlayerInfoTextName.text = rankData.playerName
        self.PlayerInfoTextLevel.text = string.format("Lv.%s", rankData.level)
        if self.PlayerInfoClubTextName then
            self.PlayerInfoClubTextName.text = rankData.clubName
        end

        SetActive(self.ImgMySelf, playerId == checkNumber(rankData.playerId))

    elseif isClub then
        SetActive(self.ImgMySelf, false)
        local clubHeadVo = ClubUtils.GetClubHeadVo(rankData.avatar)
        if clubHeadVo ~= nil then
            self.ImgHead:LoadSprite(clubHeadVo.photoPath)
        end
        self.TextName.text = rankData.name
        self.PresidentTextName.text = rankData.chairmanName
        self.TxtBuildingNum.text    = rankData.buildPoint
        self.TxtParticipateNum.text = rankData.playerJoinPoint

    end

    self.TxtTotal.text = rankData.point or rankData.score

end

function ClubGVGGroupRankingsNode:FreshHeadNode(playerInfo)
    ---@type CommonPlayerHeadNode
    local headEnv    = self:GetHeadNodeEnv()
    if isNotNull(headEnv) then
        headEnv:FreshAvatarFrame( playerInfo.avatar, playerInfo.avatarFrame)
        headEnv:SetCallBack(Bind(self, self.OnClickHeadNodeAction))
    end
end


function ClubGVGGroupRankingsNode:FreshExtraState(rankData)
    local num = checkNumber(rankData.ranking)
    SetActive(self.RankNode, num > 0)
    SetActive(self.TxtNo, num == 0)

end

function ClubGVGGroupRankingsNode:PlayAnimByHide()
    CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.HIDE)
end


function ClubGVGGroupRankingsNode:PlayAnimByIdle()
    if not self._isStart then
        self._aniCb = function() 
            CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.IDLE)
        end
        return
    end
    CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.IDLE)
end


function ClubGVGGroupRankingsNode:PlayDelayAnimByShow(delayIndex)
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
function ClubGVGGroupRankingsNode:GetHeadNodeEnv()
    if isNull(self._headEnv) then
        ---@type CommonPlayerHeadNode
        self._headEnv    = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    end
    return self._headEnv
end

---endregion 


--region handler 
function ClubGVGGroupRankingsNode:OnClickHeadNodeAction()
    if self._isPlayer then
        Events.Broadcast(ClubGVGUtils.Constants.EventNames.SetCameraShowState, false)
        GameUtils.ShowPlayerInfo( self._playerId
        -- , 
        --     {  
        --         { id = Constants.UITypeIds.ClubGvgGroupRankingsDialog }
        --     } 
        )
    end
end

---endregion 


return ClubGVGGroupRankingsNode
