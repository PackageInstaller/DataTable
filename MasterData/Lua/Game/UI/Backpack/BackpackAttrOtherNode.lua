
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Backpack/BackpackAttrOtherNode.prefab > name: BackpackAttrOtherNode
---@class BackpackAttrOtherNode
---@field Env                           	BackpackAttrOtherNode                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtSerialNumber               	TMPro.TextMeshProUGUI                   
---@field AttrLockedNode                	UnityEngine.RectTransform               
---@field ImgPointRare                  	Game.Native.Common.UISwitchImage        
---@field ImgBgRare                     	UnityEngine.RectTransform               
---@field Slider                        	UnityEngine.UI.Slider                   
---@field AttrNumText                   	Game.Native.Common.UISwitchTextMeshPro  
---@field AttrNameText                  	CustomText                              
---@field AttrNode                      	UnityEngine.RectTransform               
local BackpackAttrOtherNode = Class('BackpackAttrOtherNode')

function BackpackAttrOtherNode:__init()

end


function BackpackAttrOtherNode:__delete()

end


-- function BackpackAttrOtherNode:Awake()
-- end


-- function BackpackAttrOtherNode:Start()
-- end


function BackpackAttrOtherNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param equipDojo EquipDojo
---@param index number
function BackpackAttrOtherNode:FreshUI(equipDojo, index)
    local key            = string.format("attr%sId", index)
    local attrAdditionId = checkNumber(equipDojo[key])
    local isLockAttr      = checkInt(equipDojo.star) < index
    local isShow         = attrAdditionId > 0
    CfUtils.SetActive(self.AttrNode, isShow)
    CfUtils.SetActive(self.AttrLockedNode, isLockAttr)

    self.TxtSerialNumber.text = index

    if isShow then
        key = string.format("attr%sNum", index)
        local attrNum = equipDojo[key]
        key = string.format("attr%sQuality", index)
        local attrQuality = checkInt(equipDojo[key])

        ---@type BasicAttrAdditionVo
        local attrAdditionVo = cardConfMgr:GetBasicAttrAdditionById(attrAdditionId) or {}
        self.AttrNameText.text = attrAdditionVo.attrAdditionName
        self.AttrNumText.text = attribute_format(attrAdditionVo.isConversion, attrNum)
        -- self.AttrNumText.Status = attrQuality

        EquipUtils.SwitchSubAttrColorByQuality(self.ImgBgRare, attrQuality)
        local percent = EquipUtils.GetSubAttrPercent(equipDojo.equipmentId, attrAdditionId, attrNum)
        self.Slider.value = percent

        self.ImgPointRare.Status = attrQuality

    end

end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return BackpackAttrOtherNode
