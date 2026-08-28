
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define
local CELL_ANIM_NAME = {
    HIDE = 'UI_Common_List_Cell_Hide',
    IDLE = 'UI_Common_List_Cell_Idle',
    SHOW = 'UI_Common_List_Cell_Show',
    WAIT = 'UI_Common_List_Cell_Wait',
}
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupRankingsRewardPopup.prefab > name: Cell
---@class ClubGVGGroupRankingsRewardNode
---@field Env                           	ClubGVGGroupRankingsRewardNode          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextRank                      	UnityEngine.UI.Text                     
---@field CommonGoodsListLight          	UnityEngine.RectTransform               
---@field Normal                        	UnityEngine.CanvasGroup                 
local ClubGVGGroupRankingsRewardNode = Class('ClubGVGGroupRankingsRewardNode')

function ClubGVGGroupRankingsRewardNode:__init()

end


function ClubGVGGroupRankingsRewardNode:__delete()

end


-- function ClubGVGGroupRankingsRewardNode:Awake()
-- end


function ClubGVGGroupRankingsRewardNode:Start()
    self._isStart = true
    if self._aniCb then
        self._aniCb()
        self._aniCb = nil
    end
end


function ClubGVGGroupRankingsRewardNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param data ClubGVGClubRankRewardVo | ClubGVGPlayerRankRewardVo
function ClubGVGGroupRankingsRewardNode:FreshUI(data)
    self.TextRank.text = data == nil and localize("暂无排名") or  data.name

    if data then
        local rewards = data:GetRewards()
        UICommonUtils.FillCommonGoodsListLight(self.CommonGoodsListLight, rewards, false, false, true, false, false) 
        
    end

end

function ClubGVGGroupRankingsRewardNode:FreshTextDesc(labelType)
    self.TextDesc.Status = labelType
end

function ClubGVGGroupRankingsRewardNode:PlayAnimByHide()
    CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.HIDE)
end


function ClubGVGGroupRankingsRewardNode:PlayAnimByIdle()
    if not self._isStart then
        self._aniCb = function() 
            CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.IDLE)
        end
        return
    end
    CfUtils.PlayAnimation(self.controller.gameObject, CELL_ANIM_NAME.IDLE)
end


function ClubGVGGroupRankingsRewardNode:PlayDelayAnimByShow(delayIndex)
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


---endregion 


return ClubGVGGroupRankingsRewardNode
