
--region global define
local attribute_format = attribute_format
--endregion

--region import
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballAttributeNode.prefab
---@class SimpleAttributeNode
---@field Env                           	SimpleAttributeNode                     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtPlusNumber                 	TMPro.TextMeshProUGUI                   
---@field PlusNode                      	UnityEngine.RectTransform               
---@field TxtNumber                     	TMPro.TextMeshProUGUI                   
---@field TxtName                       	UnityEngine.UI.Text                     
---@field ImgAttribute                  	Engine.UI.RawImageAlterable                
---@field BtnIcon                       	UnityEngine.RectTransform               
---@field ImgBg                         	UnityEngine.CanvasGroup                 
local SimpleAttributeNode = Class('SimpleAttributeNode')

function SimpleAttributeNode:__init()

end


function SimpleAttributeNode:__delete()

end


function SimpleAttributeNode:Awake()
end


function SimpleAttributeNode:Start()
end


function SimpleAttributeNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function SimpleAttributeNode:FreshUI(attrData, index)
    local addAttrId  = attrData.addAttrId
    local addAttrNum = attrData.addAttrNum
    local plusAttrNum = attrData.plusAttrNum

    ---@type AttrDefinesVo
    local vo = cardConfMgr:GetBasicAttrByBasicAttrAdditionId(addAttrId)

    self:FreshUIByAttrDefineInfo(vo, addAttrNum, plusAttrNum, index)
    
end

---FreshUIByAttrDefineInfo
---@param vo AttrDefinesVo
---@param addAttrNum number
function SimpleAttributeNode:FreshUIByAttrDefineInfo(vo, addAttrNum, nextAttrNum, index)
    --- 更新属性图标
    self.ImgAttribute:LoadSprite(vo.icon)
    --- 更新属性名称
    self.TxtName.text   = vo.name
    --- 更新属性数值
    self.TxtNumber.text = attribute_format(vo.isConversion, addAttrNum)
    
    --- 更新属性增量数值
    if isNotNull(self.PlusNode) then
        local isShow = nextAttrNum ~= nil
        KTool.SetActive(self.PlusNode.gameObject, nextAttrNum ~= nil)
        if isShow then
            self.TxtPlusNumber.text = attribute_format(vo.isConversion, nextAttrNum)
        end
    end

    if isNotNull(self.ImgBg) then
        self.ImgBg.alpha = (index ~= nil and index % 2 == 1) and 1 or 0
    end
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return SimpleAttributeNode
