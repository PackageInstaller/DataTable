
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

--endregion

--- from: Assets/BundleResources/Prefabs/Common/ComTipsFashionDetailsNode.prefab > name: ComTipsFashionDetailsNode
---@class ComTipsFashionDetailsNode
---@field Env                           	ComTipsFashionDetailsNode               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgBg                         	UnityEngine.RectTransform               
---@field TxtLvNum                      	Game.Native.Common.UISwitchTextMeshPro  
---@field TxtTitle                      	Game.Native.Common.UISwitchText         
---@field TxtNumber                     	Game.Native.Common.UISwitchTextMeshPro  
---@field TxtTitle2                     	UnityEngine.RectTransform               
local ComTipsFashionDetailsNode = Class('ComTipsFashionDetailsNode')

function ComTipsFashionDetailsNode:__init()

end


function ComTipsFashionDetailsNode:__delete()

end


function ComTipsFashionDetailsNode:Awake()
end


function ComTipsFashionDetailsNode:Start()
end


function ComTipsFashionDetailsNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param attribute SingleAttrTypeData
---@param data {skinId:number, level:number, attrV:number}
---@param index number
function ComTipsFashionDetailsNode:FreshUI(attribute, data, index)
    local skinVo = cardConfMgr:GetCardSkinBySkinId(data.skinId)
    CfUtils.SetActive(self.ImgBg, index % 2 == 1)

    local isActive = index <= CardProgressionConstants.FashionSkinAttrLimit
    local status = isActive and 1 or 2

    self.TxtLvNum.text = string.format("Lv.%s", data.level)
    self.TxtLvNum.Status = status

    self.TxtTitle.text = skinVo.name
    self.TxtTitle.Status = status

    CfUtils.SetActive(self.TxtNumber, isActive)
    CfUtils.SetActive(self.TxtTitle2, not isActive)
    if isActive then
        self.TxtNumber.text = attribute_format(attribute.isConversion, data.attrV)
        self.TxtNumber.Status = status

    end
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return ComTipsFashionDetailsNode
