local UIModule = CS.Engine.UI.UIModule
--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Activity/ActivityNewReleaseGetAnimation.prefab > name: ActivityNewReleaseGetAnimation
---@class ActivityFashionPreheatingGetRewards
---@field Env                           	ActivityFashionPreheatingGetRewards     
---@field controller                    	Engine.UI.UILuaDialog                   
---@field GoodNode1                     	UnityEngine.RectTransform               	@ 0    
---@field GoodNode2                     	UnityEngine.RectTransform               	@ 1    
---@field Root                          	UnityEngine.RectTransform               	@ 2    
local ActivityFashionPreheatingGetRewards = Class('ActivityFashionPreheatingGetRewards')
---@type ActivityFashionPreheatingUtils
local ActivityFashionPreheatingUtils = import("Game.Activity.FashionPreheating.ActivityFashionPreheatingUtils")

function ActivityFashionPreheatingGetRewards:__init()
    self.activityContentId = nil
    self.cb =  nil
    self.rewardId = nil
end


function ActivityFashionPreheatingGetRewards:__delete()
    self.activityContentId = nil
    self.cb =  nil
    self.rewardId = nil
end


function ActivityFashionPreheatingGetRewards:Awake()

end


function ActivityFashionPreheatingGetRewards:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.activityContentId = initParams.activityContentId
        self.cb = initParams.cb 
        self.rewardId = initParams.rewardId
        local isBig = ActivityFashionPreheatingUtils.IsBigReards(self.activityContentId , self.rewardId)
        local animationName = isBig and  "ActivityNewReleaseGetAnimation_BigRewards" or  "ActivityNewReleaseGetAnimation_Rewards"
        CfUtils.WaitPlayAnimationTo(self.Root , animationName ,function()
            UIModule.CloseDialog(self.controller)
            self.cb()
        end)

        local GoodNodes = {self.GoodNode1 , self.GoodNode2}
        ----@type FashionPreheatingPoolVo[]
        local bigVos =  ActivityFashionPreheatingUtils.GetBigReardsVo(self.activityContentId)
        for i = 1 , #GoodNodes do
            ---@type GoodNodeMB
            local ENV = CfUtils.GetLuaScr(GoodNodes[i],"Game.Behaviours.GoodNodeMB")
            if bigVos[i] then
                ENV:Reload({
                    goodsId =  bigVos[i].rewardId,
                    num  =  bigVos[i].rewardNum,
                    isShowNo  =  true
                })
            else 
                CfUtils.SetActive(GoodNodes[i] , false)    
            end
        end
        
    end)
end




function ActivityFashionPreheatingGetRewards:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return ActivityFashionPreheatingGetRewards
