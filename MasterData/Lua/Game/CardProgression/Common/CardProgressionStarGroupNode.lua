
------------ import ------------
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaStarup.prefab > name: StarLevelNode
---@class CardProgressionStarGroupNode
---@field Env                           	CardProgressionStarGroupNode            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field MaxStarEffect                 	UnityEngine.RectTransform               
local CardProgressionStarGroupNode = Class('CardProgressionStarGroupNode')

function CardProgressionStarGroupNode:__init()
    self._starNodes = {}
end


function CardProgressionStarGroupNode:__delete()

end


function CardProgressionStarGroupNode:Awake()
    
end


function CardProgressionStarGroupNode:Start()
end


function CardProgressionStarGroupNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionStarGroupNode:FreshUI(curStar, previewStar, maxStar, isOpenLockIcon, isUpStar, customNextStar)
    if maxStar == nil then
        maxStar = self.controller.transform.childCount
    end

    curStar     = checkNumber(curStar)
    previewStar = checkNumber(previewStar)
    for i = 1, maxStar, 1 do
        local node = self._starNodes[i]
        if isNull(node) then
            if self._childName then
                node = self.controller.transform:Find(string.format(self._childName, i))
            else
                node = self.controller.transform:GetChild(i - 1)
            end
            table.insert(self._starNodes, node)
        end

        ---@type CardProgressionStarNode
        local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionStarNode)
        if not isNull(env) then
            -- 1:Lock 2:Lock Icon 3:Unlock 4:Select 5:升星效果
            local status = isOpenLockIcon and 2 or 1
            if i == previewStar and curStar ~= previewStar then
                status = isUpStar and 5 or 4
            elseif curStar >= i then
                status = 3
            end
            env:FreshUI(status, self._callback, i)
            env:FreshSelectStatus(customNextStar ~= nil and customNextStar >= previewStar and customNextStar == i)
        end

    end

    if self.MaxStarEffect then
        
        KTool.SetActive(self.MaxStarEffect.gameObject, curStar == maxStar)
    end

    
end


---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionStarGroupNode:SetCallback(callback)
    self._callback = callback
end

function CardProgressionStarGroupNode:SetChildName(childName)
    self._childName = childName
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionStarGroupNode
