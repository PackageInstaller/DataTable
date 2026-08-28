
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils       = import('Game.UI.Club.GVG.ClubGVGUtils')

---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgJumpTips.prefab > name: OverseaClubGvgJumpTips
---@class OverseaClubGVGJumpTips
---@field Env                           	OverseaClubGVGJumpTips                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Tips1                         	UnityEngine.RectTransform               
---@field Tips2                         	UnityEngine.RectTransform               
---@field Tips3                         	UnityEngine.RectTransform               
---@field BtnTips                       	UnityEngine.RectTransform               
local OverseaClubGVGJumpTips = Class('OverseaClubGVGJumpTips')

function OverseaClubGVGJumpTips:__init()

end


function OverseaClubGVGJumpTips:__delete()

end


function OverseaClubGVGJumpTips:Awake()
    self.state2Parent = {
        [Constants.ActionTeamInviteNodeUIState.Close] = self.Tips1.gameObject,
        [Constants.ActionTeamInviteNodeUIState.Show] = self.Tips2.gameObject,
        [Constants.ActionTeamInviteNodeUIState.Downsize] = self.Tips3.gameObject,
    }

end


function OverseaClubGVGJumpTips:Start()
    SetButtonAction(self.BtnTips, Bind(self, self.OnClickBtnTipsAction))
    self._events = CfUtils.EventsDecorated({
        [Constants.EventNames.ActionTeamInviteNodeChangeState] = Bind(self, self.FreshPosition)
    })
end


function OverseaClubGVGJumpTips:OnDestroy()
    if self._events then
        CfUtils.EventsUndecorated(self._events)
        self._events = nil
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function OverseaClubGVGJumpTips:CheckTipsPosition()
    local go = UIModule.RootCanvas.transform:Find("ActionTeamInviteNode")
    local nodeState = Constants.ActionTeamInviteNodeUIState.Close
    if isNotNull(go) then
        ---@type ActionTeamInviteNode
        local env = CfUtils.GetLuaScr(go, "Game.UI.FightReady.UIMainChapter.ActionTeamInviteNode")
        if isNotNull(env) then
            nodeState = env:GetState()
        end
    end

    self:FreshPosition(nodeState) 
end

function OverseaClubGVGJumpTips:FreshPosition(nodeState)
    if self._nodeState == nodeState then
        return
    end
    self._nodeState = nodeState

    local parent = self.state2Parent[nodeState]
    if isNull(parent) then
        return
    end
    KTool.SetParent(self.BtnTips.gameObject, parent, false)

end

--endregion 


--region get/set 


---endregion 


--region handler 

function OverseaClubGVGJumpTips:OnClickBtnTipsAction()
    if not ClubGVGUtils.CheckIsCanEnterGVG() then
        return
    end
    ClubGVGUtils.EnterScene()
end

---endregion 


return OverseaClubGVGJumpTips
