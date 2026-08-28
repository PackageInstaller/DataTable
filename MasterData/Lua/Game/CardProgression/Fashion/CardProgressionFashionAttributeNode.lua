
------------ import ------------
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardConfMgr
local cardConfMgr      = CardConfMgr:GetInstance()
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------


------------ define ------------
local SetActive = CfUtils.SetActive
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaAttributeNode.prefab > name: CultivateOverseaAttributeNode
---@class CardProgressionFashionAttributeNode
---@field Env                           	CardProgressionFashionAttributeNode     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtPlusNumber                 	TMPro.TextMeshProUGUI                   	@ 0    
---@field PlusNode                      	UnityEngine.RectTransform               	@ 1    
---@field TxtNumber                     	Game.Native.Common.UISwitchTextMeshPro  	@ 2    
---@field NumberNode                    	UnityEngine.RectTransform               	@ 3    
---@field TxtName                       	Game.Native.Common.UISwitchText         	@ 4    
---@field ImgAttributeSwitch            	Game.Native.Common.UISwitchImage        	@ 5    
---@field ImgAttribute                  	Engine.UI.ImageAlterable                	@ 6    
---@field BtnIcon                       	UnityEngine.RectTransform               	@ 7    
---@field BtnIconImgBg                  	Game.Native.Common.UISwitchImage        	@ 8    
---@field ImgBg                         	UnityEngine.CanvasGroup                 	@ 9    
---@field ImgAsterisk                   	UnityEngine.RectTransform               	@ 10   
local CardProgressionFashionAttributeNode = Class('CardProgressionFashionAttributeNode')

function CardProgressionFashionAttributeNode:__init()

end


function CardProgressionFashionAttributeNode:__delete()

end


function CardProgressionFashionAttributeNode:Awake()
    GameUtils.UpdateUIShowStateByCanvasGroup(self.ImgBg, false)
end


function CardProgressionFashionAttributeNode:Start()
    SetButtonAction(self.BtnIcon, Bind(self, self.OnClickBtnIconAction))
end


function CardProgressionFashionAttributeNode:OnDestroy()
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

---@class FashionAttrInfo
---@field attrAddId number
---@field isConversion number
---@field order number
---@field icon string
---@field name string
---@field attrNum number
---@field attrStatus number
---@field plusAttrNum? number
---@field maxFlag? boolean
---@field viewType CardProgressionConstants.AttrNodeType 1: 单属性 2：双属性

--- FreshUI
---@param attributeInfo FashionAttrInfo 
function CardProgressionFashionAttributeNode:FreshUI(attributeInfo, targetNode, position)
    self._attributeInfo = attributeInfo
    self:SetTargetNode(targetNode)

    local viewType = attributeInfo.viewType
    local isSingle      = viewType == CardProgressionConstants.AttrNodeType.Single
    local isDouble      = viewType == CardProgressionConstants.AttrNodeType.Double
    SetActive(self.NumberNode, isSingle or isDouble)
    SetActive(self.PlusNode,   isDouble and not string.isEmpty(attributeInfo.plusAttrNum))

    local attrStatus = attributeInfo.attrStatus or 1
    local icon = attributeInfo.icon
    local isShowIcon = not string.isEmpty(icon)
    SetActive(self.ImgAttribute, isShowIcon)
    if isShowIcon then
        self.ImgAttribute:LoadSprite(icon)
        self.ImgAttributeSwitch.Status = attrStatus
    end
    self.BtnIconImgBg.Status = attrStatus

    self.TxtName.text       = attributeInfo.name
    self.TxtName.Status = attrStatus
    if isSingle then
        self.TxtNumber.text     = attributeInfo.attrNum
        self.TxtNumber.Status     = attrStatus

    elseif isDouble then
        self.TxtNumber.text     = attributeInfo.attrNum
        self.TxtNumber.Status     = attrStatus
        self.TxtPlusNumber.text = attributeInfo.plusAttrNum

    end

    SetActive(self.ImgAsterisk, attributeInfo.maxFlag)

    self:FreshImageBgShowState(position)
end

function CardProgressionFashionAttributeNode:FreshImageBgShowState(index)
    if index == nil then
        return
    end
    GameUtils.UpdateUIShowStateByCanvasGroup(self.ImgBg, index % 2 == 1)
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


function CardProgressionFashionAttributeNode:SetTargetNode(targetNode)
    self._targetNode = targetNode
end


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionFashionAttributeNode:OnClickBtnIconAction()
    if isNull(self._targetNode) then return end
    
    local attributeInfo = self._attributeInfo
    local viewType      = attributeInfo.viewType
    ---@type AttrDefinesVo
    local vo = self._attributeInfo.vo
    if vo then
        UICommonUtils.ShowAttributeTips(self.controller.gameObject, vo) 
    end
    
end


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionFashionAttributeNode
