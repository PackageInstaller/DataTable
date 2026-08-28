--使用此类需要在GameObject上添加GoPoolBeHaviour组件  并将其赋值给poolBehaviour(通过luaOutlat)

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarScrapeRewardNode.prefab > name: RewardList
---@class CommonPoolList:CommonList
---@field Env                           	CommonPoolList                          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field poolBehaviour                 	Engine.Lib.GOPoolBehaviour              	@ 0    
local CommonPoolList = Class("CommonPoolList",import("Game.Behaviours.CommonList"))

---@private
function CommonPoolList:CreateItem()
    local go = self.poolBehaviour:GetPoolObject("PoolGo", self.controller.gameObject)
    return go
end

return CommonPoolList