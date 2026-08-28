
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
--endregion

--region define
local SetActive = CfUtils.SetActive
local LuaPath = "Game.CardProgression.Equip.CardProgressionEquipmentLadderRiseAttrNode"
--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaEquipDetailsNode.prefab > name: LadderRiseNode
---@class CardProgressionEquipmentLadderRiseNode
---@field Env                           	CardProgressionEquipmentLadderRiseNode  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Open                          	UnityEngine.RectTransform               	@ 0    
---@field BtnReforge                    	UnityEngine.RectTransform               	@ 1    
---@field Layout                        	UnityEngine.RectTransform               	@ 2    
---@field ATKNumericalValue             	UnityEngine.RectTransform               	@ 3    
---@field Close                         	UnityEngine.RectTransform               	@ 4    
---@field TxtState                      	CustomText                              	@ 5    
local CardProgressionEquipmentLadderRiseNode = Class('CardProgressionEquipmentLadderRiseNode')

function CardProgressionEquipmentLadderRiseNode:__init()
    

end


function CardProgressionEquipmentLadderRiseNode:__delete()

end


function CardProgressionEquipmentLadderRiseNode:Awake()
    CfUtils.SetActive(self.BtnReforge, GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id119))
end


function CardProgressionEquipmentLadderRiseNode:Start()
    SetButtonAction(self.BtnReforge, Bind(self, self.OnClickBtnReforgeAction))
end


function CardProgressionEquipmentLadderRiseNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param dojo EquipDojo
function CardProgressionEquipmentLadderRiseNode:FreshUI(dojo, params, equipType)

    self.dojo = dojo
    self.params, self.equipType = params, equipType
    local isUnlock = EquipUtils.IsUnlockLadderRiseAttr(dojo)
    SetActive(self.Open, isUnlock)
    SetActive(self.Close, not isUnlock)

    if isUnlock then
        self:FreshOpenNode(dojo)
    end
end

---@param dojo EquipDojo
function CardProgressionEquipmentLadderRiseNode:FreshOpenNode(dojo)
    local attrs = dojo:GetLadderRiseAttrs()
    GameUtils.ResizeContent(self.Layout, self.ATKNumericalValue, #attrs, function (luaIndex, childNode)
        ---@type CardProgressionEquipmentLadderRiseAttrNode
        local env = CfUtils.GetLuaScr(childNode, LuaPath)
        if isNotNull(env) then
            local attr = attrs[luaIndex]
            env:FreshUI(attr, dojo)
        end
    end)
end

--endregion 


--region get/set 


---endregion 


--region handler 

function CardProgressionEquipmentLadderRiseNode:OnClickBtnReforgeAction()
    local params, equipType = self.params, self.equipType
    Events.Broadcast(Constants.EventNames.UICultivateEquipOperateEquipOrCore, params, equipType, 4)
  
end

---endregion 


return CardProgressionEquipmentLadderRiseNode
