
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type HotPointCollectionConstants
local HotPointCollectionConstants = import("Game.Activity.HotPointCollection.HotPointCollectionConstants")
---@type ActivityUtils
local activityUtils = import("Game.Activity.ActivityUtils")
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Hotpoint/HotpointNewActivityDialog.prefab > name: ItemCell
---@class HotPointCollectionNewActivityItemCell
---@field Env                           	HotPointCollectionNewActivityItemCell   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field HotPointAssociatedNode        	UnityEngine.RectTransform               
---@field NewActivityGrid               	UnityEngine.RectTransform               
local HotPointCollectionNewActivityItemCell = Class('HotPointCollectionNewActivityItemCell')

function HotPointCollectionNewActivityItemCell:__init()
    self._displayItemNumber = 0
end


function HotPointCollectionNewActivityItemCell:__delete()

end


function HotPointCollectionNewActivityItemCell:Awake()
    self._cells = {self.HotPointAssociatedNode.gameObject}
    
end


-- function HotPointCollectionNewActivityItemCell:Start()
-- end


function HotPointCollectionNewActivityItemCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function HotPointCollectionNewActivityItemCell:FreshUI(dataList, position, maxCount)
    local curTime = os.time()
    local parent = self.NewActivityGrid
    for i = 1, maxCount do
        local index = position * maxCount + i
        local data  = dataList[index]
        local cell  = self._cells[i]
        if data then
            if cell == nil then
                cell = parent.gameObject:AddChild(self._cells[1])
                self._cells[i] = cell
            end
            CfUtils.SetActive(cell, true)
            self:FreshAssociatedNode(cell, data, curTime, maxCount, i)
        elseif cell then
            CfUtils.SetActive(cell, false)
        end
    end

end

function HotPointCollectionNewActivityItemCell:FreshAssociatedNode(cell, data, curTime, maxCount, i)
    ---@type HotPointCollectionAssociatedNode
    local env = CfUtils.GetLuaScr(cell, HotPointCollectionConstants.EnvPath.HotPointCollectionAssociatedNode)
    if isNull(env) then return end
    env:FreshUI(data, curTime)

    if self._displayItemNumber < maxCount then
        self._displayItemNumber = self._displayItemNumber + 1
        local delayIndex = math.ceil(i * 0.5) 
        env:PlayDelayAnimByShow(delayIndex)
    else
        env:PlayAnimByIdle()
    end

end


--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return HotPointCollectionNewActivityItemCell
