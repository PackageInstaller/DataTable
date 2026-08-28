--- from: Assets/BundleResources/Prefabs/Activity/ActivityMonopolyDialog140004.prefab > name: RewardCell1
---@class ActivityThrowDiceRewardCell
---@field Env                           	ActivityThrowDiceRewardCell             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RwardNode1                    	Engine.Modules.LuaBehaviour             	@ 0    
---@field RwardNode2                    	Engine.Modules.LuaBehaviour             	@ 1    
---@field RwardNode3                    	Engine.Modules.LuaBehaviour             	@ 2    
---@field RwardNode4                    	Engine.Modules.LuaBehaviour             	@ 3    
---@field RwardNode5                    	Engine.Modules.LuaBehaviour             	@ 4    
---@field RwardNode6                    	Engine.Modules.LuaBehaviour             	@ 5    
---@field RwardNode7                    	Engine.Modules.LuaBehaviour             	@ 6    
---@field RwardNode8                    	Engine.Modules.LuaBehaviour             	@ 7    
---@field RwardNode9                    	Engine.Modules.LuaBehaviour             	@ 8    
---@field RwardNode10                   	Engine.Modules.LuaBehaviour             	@ 9    
---@field RwardNode11                   	Engine.Modules.LuaBehaviour             	@ 10   
---@field RwardNode12                   	Engine.Modules.LuaBehaviour             	@ 11   
---@field RwardNode13                   	Engine.Modules.LuaBehaviour             	@ 12   
---@field RwardNode14                   	Engine.Modules.LuaBehaviour             	@ 13   
---@field RwardNode15                   	Engine.Modules.LuaBehaviour             	@ 14   
---@field RwardNode16                   	Engine.Modules.LuaBehaviour             	@ 15   
---@field RwardNode17                   	Engine.Modules.LuaBehaviour             	@ 16   
---@field RwardNode18                   	Engine.Modules.LuaBehaviour             	@ 17   
---@field RwardNode19                   	Engine.Modules.LuaBehaviour             	@ 18   
---@field RwardNode20                   	Engine.Modules.LuaBehaviour             	@ 19   
---@field ImgRole                       	UnityEngine.RectTransform               	@ 20   
---@field DecoRoot                      	UnityEngine.RectTransform               	@ 21   
---@field DecoRoot2                     	UnityEngine.RectTransform               	@ 22   
local ActivityThrowDiceRewardCell = Class('ActivityThrowDiceRewardCell')

local KTool = CS.Engine.Lib.KTool
function ActivityThrowDiceRewardCell:__init()
end


function ActivityThrowDiceRewardCell:__delete()
end


function ActivityThrowDiceRewardCell:Awake()
end


function ActivityThrowDiceRewardCell:Start()

end

function ActivityThrowDiceRewardCell:RefreshUI(nowCellNum  , index , vos ,buffGoodsId)
    for i = 1 , 20 do
        local currentIndex = (index - 1) * 20 + i 
        ---@type ThrowDiceRewardsVo
        local vo = vos[currentIndex] 
        ---@type Engine.Modules.LuaBehaviour
        local RwardNode = self["RwardNode" .. i]
        RwardNode.Env:RefreshUI(nowCellNum ,currentIndex , vo , buffGoodsId)
    end
    local mode = index % 2
    if mode == 0 then
        KTool.SetActive(self.DecoRoot , true)
        KTool.SetActive(self.DecoRoot2 ,false)
    else     
        KTool.SetActive(self.DecoRoot ,false)
        KTool.SetActive(self.DecoRoot2 ,true)
    end
end

function ActivityThrowDiceRewardCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end

return ActivityThrowDiceRewardCell
