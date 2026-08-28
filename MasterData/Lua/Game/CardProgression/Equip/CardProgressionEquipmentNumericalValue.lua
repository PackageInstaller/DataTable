
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define
local SetActive = CfUtils.SetActive
---@type CardConfMgr
local cardConfMgr        = CardConfMgr:GetInstance()
--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaSecondConfirmLadderRiseNode.prefab > name: ATKNumericalValue
---@class CardProgressionEquipmentNumericalValue
---@field Env                           	CardProgressionEquipmentNumericalValue  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Slider                        	UnityEngine.UI.Slider                   	@ 0    
---@field ImgBg                         	Game.Native.Common.UISwitchImage        	@ 1    
---@field TxtName                       	UnityEngine.UI.Text                     	@ 2    
---@field ImgBgRare                     	UnityEngine.RectTransform               	@ 3    
---@field TxtNumAfter                   	TMPro.TextMeshProUGUI                   	@ 4    
---@field AttrLockText                  	UnityEngine.UI.Text                     	@ 5    
---@field LockNode                      	UnityEngine.RectTransform               	@ 6    
---@field ImgBgGlow                     	Game.Native.Common.UISwitchImage        	@ 7    
---@field ImgBgLight                    	Game.Native.Common.UISwitchImage        	@ 8    
local CardProgressionEquipmentNumericalValue = Class('CardProgressionEquipmentNumericalValue')

function CardProgressionEquipmentNumericalValue:__init()

end


function CardProgressionEquipmentNumericalValue:__delete()

end


function CardProgressionEquipmentNumericalValue:Awake()
end


function CardProgressionEquipmentNumericalValue:Start()
end


function CardProgressionEquipmentNumericalValue:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 


---@param attr LadderRiseAttr
---@param index number
function CardProgressionEquipmentNumericalValue:RefreshUI(attr, index, equipDojo)
    self.Slider.value = attr.attrProgress

    local quality = attr.quality
    EquipUtils.SwitchSubAttrColorByQuality(self.ImgBgRare, quality)
    self.ImgBgGlow.Status = quality
    self.ImgBgLight.Status = quality

    SetActive(self.LockNode, not attr.isUnlock)
    SetActive(self.TxtNumAfter, attr.isUnlock)
    
    local attrId = attr.attrId
    local attrVo = cardConfMgr:GetBasicAttrAdditionById(attrId)
    self.TxtName.text = attrVo.attrAdditionName

    if not attr.isUnlock then
        self.AttrLockText.text = EquipUtils.GetUnlockAttrText(attr.unlockLimitId, equipDojo)
    else
        local attrNum = attr.num
        self.TxtNumAfter.text = string.format("+%s", attribute_format(attrVo.isConversion, attrNum))
    end
    
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CardProgressionEquipmentNumericalValue
