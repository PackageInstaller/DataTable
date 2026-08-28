
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
local cardConfMgr = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
--endregion

--region define
local SetActive = CfUtils.SetActive

--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaEquipmentLadderRiseDialog.prefab > name: SubAttrNode1
---@class CardProgressionEquipmentLadderRisePreviewAttrNode
---@field Env                           	CardProgressionEquipmentLadderRisePreviewAttrNode
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field LockNode                      	UnityEngine.RectTransform               	@ 0    
---@field AttrNumText                   	TMPro.TextMeshProUGUI                   	@ 1    
---@field AttrNameText                  	UnityEngine.UI.Text                     	@ 2    
---@field AttrLockText                  	UnityEngine.UI.Text                     	@ 3    
---@field AttrNode                      	UnityEngine.RectTransform               	@ 4    
---@field ImgLock                       	UnityEngine.RectTransform               	@ 5    
local CardProgressionEquipmentLadderRisePreviewAttrNode = Class('CardProgressionEquipmentLadderRisePreviewAttrNode')

function CardProgressionEquipmentLadderRisePreviewAttrNode:__init()

end


function CardProgressionEquipmentLadderRisePreviewAttrNode:__delete()

end


function CardProgressionEquipmentLadderRisePreviewAttrNode:Awake()
end


function CardProgressionEquipmentLadderRisePreviewAttrNode:Start()
end


function CardProgressionEquipmentLadderRisePreviewAttrNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param attr {attrId:number, lowNum:number, upNum:number}
---@param index number
function CardProgressionEquipmentLadderRisePreviewAttrNode:RefreshUI(attr, index, equipDojo)
    local isPreview = index == 1

    ---@type BasicAttrAdditionVo
    local attrAdditionVo = cardConfMgr:GetBasicAttrAdditionById(attr.attrId) or {}
    self.AttrNameText.text = attrAdditionVo.attrAdditionName

    SetActive(self.LockNode, true)
    SetActive(self.ImgLock, isPreview)
    SetActive(self.AttrLockText, true)

    self.AttrLockText.text = isPreview and string.format("%s-%s", attr.lowNum, attr.upNum) or self:GetUnlockAttrText(CardProgressionConstants.LadderRiseParams.UnlockSecondAttrReforgeTimes, equipDojo)

end
 
function CardProgressionEquipmentLadderRisePreviewAttrNode:GetUnlockAttrText(id, equipDojo)
    return EquipUtils.GetUnlockAttrText(id, equipDojo)
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CardProgressionEquipmentLadderRisePreviewAttrNode
