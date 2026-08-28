--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/ActivityCatGirlPKScreenStartsDialog.prefab > name: ActivityCatGirlPKScreenStartsDialog
---@class ActivityCatGirlPKScreenStartsDialog
---@field Env                           	ActivityCatGirlPKScreenStartsDialog     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtTime                       	UnityEngine.RectTransform               	@ 0    
---@field TxtName                       	UnityEngine.RectTransform               	@ 1    
---@field Root                          	UnityEngine.RectTransform               	@ 2    
local ActivityCatGirlPKScreenStartsDialog = Class('ActivityCatGirlPKScreenStartsDialog')
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders
local UIModule = CS.Engine.UI.UIModule
local GameObject = CS.UnityEngine.GameObject
local UIModule = CS.Engine.UI.UIModule
---@type ActivityVoteComponent
local ActivityVoteComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
function ActivityCatGirlPKScreenStartsDialog:__init()
    self.co = nil
end


function ActivityCatGirlPKScreenStartsDialog:__delete()
    self.co = nil

end


function ActivityCatGirlPKScreenStartsDialog:Awake()

end


function ActivityCatGirlPKScreenStartsDialog:Start()
    local matchTexts = {
        localize("筛选赛"),
        localize("淘汰赛"),
        localize("总决赛"),
    }
    local currentRound =  ActivityVoteComponent:GetDojo().currentRound
    CfUtils.FillText(self.TxtTime , ActivityVoteComponent:GetMatchTimeStr()) 
    CfUtils.FillText(self.TxtName , matchTexts[currentRound]) 
    self:PlayAnimation()
end


function ActivityCatGirlPKScreenStartsDialog:PlayAnimation()
    self.co = cs_coroutine.start(function()
        local animationName = "ActivityCatGirlPKScreenStartsDialog_Entry"
        local animationTime = CfUtils.GetAnimationTime(self.Root.gameObject , animationName)
        CfUtils.PlayAnimation(self.Root.gameObject, animationName)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(animationTime))
        ---@type Engine.UI.UILuaDialog
        local ActivityCatGirlPKMainPanel = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.ActivityCatGirlPKMainPanel)
        ---@type ActivityCatGirlPKMainPanel
        local ENV = ActivityCatGirlPKMainPanel.Env
        local currentRound =  ActivityVoteComponent:GetDojo().currentRound
        ENV:WriteCurrentRoundActionCache(currentRound)
        GameObject.Destroy(self.controller.gameObject)
        if ActivityVoteComponent:GetDojo().currentRound > 1 then
            UIModule.OpenDialog(
                { id = Constants.UITypeIds.ActivityCatGirlPKRoleViewPopUp},
                { 
                    { id = Constants.UITypeIds.ActivityCatGirlPKMainPanel} ,
                    { id = Constants.UITypeIds.UIActivityMainDialog } 
                }
            )
        end
    end)
end


function ActivityCatGirlPKScreenStartsDialog:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    if self.co then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
    self:Delete()
end


return ActivityCatGirlPKScreenStartsDialog
