
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
local cardConfMgr = CardConfMgr:GetInstance()
--endregion

--region define
local SetActive = CfUtils.SetActive
--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaEquipDetailsNode.prefab > name: ATKNumericalValue
---@class CardProgressionEquipmentLadderRiseAttrNode
---@field Env                           	CardProgressionEquipmentLadderRiseAttrNode
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgAttributeIcon              	Engine.UI.ImageAlterable                	@ 0    
---@field TxtAttr                       	UnityEngine.UI.Text                     	@ 1    
---@field TxtNumberCurrent              	TMPro.TextMeshProUGUI                   	@ 2    
---@field LockGroup                     	UnityEngine.RectTransform               	@ 3    
---@field TxtState                      	UnityEngine.UI.Text                     	@ 4    
local CardProgressionEquipmentLadderRiseAttrNode = Class('CardProgressionEquipmentLadderRiseAttrNode')

function CardProgressionEquipmentLadderRiseAttrNode:__init()

end


function CardProgressionEquipmentLadderRiseAttrNode:__delete()

end


function CardProgressionEquipmentLadderRiseAttrNode:Awake()
end


function CardProgressionEquipmentLadderRiseAttrNode:Start()
end


function CardProgressionEquipmentLadderRiseAttrNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param attr LadderRiseAttr
---@param dojo EquipDojo
function CardProgressionEquipmentLadderRiseAttrNode:FreshUI(attr, dojo)

    local isUnlock = attr.isUnlock
    SetActive(self.LockGroup, not isUnlock)
    SetActive(self.TxtNumberCurrent, isUnlock)
    
    local attrAddId = attr.attrId
    local attrAddVo = cardConfMgr:GetBasicAttrAdditionById(attrAddId)
    local attrVo = cardConfMgr:GetBasicAttr(attrAddVo.attrId)
    self.ImgAttributeIcon:LoadSprite(attrVo.icon)

    self.TxtAttr.text = attrAddVo.attrAdditionName

    if isUnlock then
        self.TxtNumberCurrent.text = attribute_format(attrAddVo.isConversion, attr.num)

    else
        self.TxtState.text = EquipUtils.GetUnlockAttrText(attr.unlockLimitId, dojo)
            
    end

end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CardProgressionEquipmentLadderRiseAttrNode
