
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

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaAttributeNode.prefab > name: CultivateOverseaAttributeNode
---@class CardProgressionAttributeNode
---@field Env                           	CardProgressionAttributeNode            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgRace                       	Engine.UI.RawImageAlterable             	@ 0    
---@field BtnRace                       	UnityEngine.RectTransform               	@ 1    
---@field CardAttributeImgIcon          	Game.Native.Common.UISwitchImage        	@ 2    
---@field BtnCardAttributeIcon          	UnityEngine.RectTransform               	@ 3    
---@field TextCardAttribute             	UnityEngine.UI.Text                     	@ 4    
---@field TextCardAttribute2            	UnityEngine.UI.Text                     	@ 5    
---@field CardAttributeNode             	UnityEngine.RectTransform               	@ 6    
---@field TxtPlusNumber                 	TMPro.TextMeshProUGUI                   	@ 7    
---@field PlusNode                      	UnityEngine.RectTransform               	@ 8    
---@field TxtNumber                     	TMPro.TextMeshProUGUI                   	@ 9    
---@field NumberNode                    	UnityEngine.RectTransform               	@ 10   
---@field TxtName                       	UnityEngine.UI.Text                     	@ 11   
---@field ImgAttribute                  	Engine.UI.RawImageAlterable             	@ 12   
---@field BtnIcon                       	UnityEngine.RectTransform               	@ 13   
---@field ImgBg                         	UnityEngine.CanvasGroup                 	@ 14   
local CardProgressionAttributeNode = Class('CardProgressionAttributeNode')

function CardProgressionAttributeNode:__init()

end


function CardProgressionAttributeNode:__delete()

end


function CardProgressionAttributeNode:Awake()
    GameUtils.UpdateUIShowStateByCanvasGroup(self.ImgBg, false)
end


function CardProgressionAttributeNode:Start()
    SetButtonAction(self.BtnIcon.gameObject, Bind(self, self.OnClickBtnIconAction))
    SetButtonAction(self.BtnCardAttributeIcon.gameObject, Bind(self, self.OnClickBtnCardAttributeIconAction))
    SetButtonAction(self.BtnRace.gameObject, Bind(self, self.OnClickBtnRaceAction))
end


function CardProgressionAttributeNode:OnDestroy()
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
--- FreshUI
---@param attributeInfo table {
---    viewType: 必填 CardProgressionConstants.AttrNodeType 1: 单属性 2：双属性 3：卡牌属性 4：卡牌种族
---    icon: 必填
---    name: 必填
---    attrNum:  CardProgressionConstants.AttrNodeType.Single 与 CardProgressionConstants.AttrNodeType.Double 类型 必填
---    plusAttrNum:  CardProgressionConstants.AttrNodeType.Double 类型 必填
---    cardAttrId:  CardProgressionConstants.AttrNodeType.CardAttr 类型 必填
---    raceId:  CardProgressionConstants.AttrNodeType.Race 类型 必填
---}
---
function CardProgressionAttributeNode:FreshUI(attributeInfo, targetNode, position)
    self._attributeInfo = attributeInfo
    self:SetTargetNode(targetNode)

    local viewType = attributeInfo.viewType
    local isSingle      = viewType == CardProgressionConstants.AttrNodeType.Single
    local isDouble      = viewType == CardProgressionConstants.AttrNodeType.Double
    local isCardAttr    = viewType == CardProgressionConstants.AttrNodeType.CardAttr
    local isRace        = viewType == CardProgressionConstants.AttrNodeType.Race
    local isCatType     = viewType == CardProgressionConstants.AttrNodeType.CatType
    KTool.SetActive(self.NumberNode.gameObject, isSingle or isDouble)
    KTool.SetActive(self.PlusNode.gameObject,   isDouble and not string.isEmpty(attributeInfo.plusAttrNum))
    KTool.SetActive(self.CardAttributeNode.gameObject, isCardAttr or isRace or isCatType)
    CfUtils.SetActive(self.TextCardAttribute, not isCatType)
    CfUtils.SetActive(self.TextCardAttribute2, isCatType)
    KTool.SetActive(self.BtnCardAttributeIcon.gameObject, isCardAttr)
    KTool.SetActive(self.BtnRace.gameObject, isRace)

    local icon = attributeInfo.icon
    local isShowIcon = not string.isEmpty(icon)
    KTool.SetActive(self.ImgAttribute.gameObject, isShowIcon)
    if isShowIcon then
        self.ImgAttribute:LoadSprite(attributeInfo.icon)
    end
    self.TxtName.text       = attributeInfo.name
    if isSingle then
        self.TxtNumber.text     = attributeInfo.attrNum
        -- self.TxtName.text       = attributeInfo.name

    elseif isDouble then
        self.TxtNumber.text     = attributeInfo.attrNum
        self.TxtPlusNumber.text = attributeInfo.plusAttrNum

    elseif isCardAttr then
        local cardAttrId = attributeInfo.cardAttrId
        ---@type RoleAttributeColorVo
        local vo = cardConfMgr:GetRoleAttributeColorVo(cardAttrId)
        if vo then
            self.TextCardAttribute.text = vo.name
        end
        self.CardAttributeImgIcon.Status = cardAttrId

    elseif isRace then
        local raceId = attributeInfo.raceId       
        ---@type RoleRaceVo
        local vo = cardConfMgr:GetRoleRaceVoById(raceId)
        if vo then
            self.ImgRace:LoadSprite(vo.icon)
            self.TextCardAttribute.text = vo.name
        end

    elseif isCatType then
        self.TextCardAttribute2.text = attributeInfo.desc

    end

    self:FreshImageBgShowState(position)
end

function CardProgressionAttributeNode:FreshImageBgShowState(index)
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


function CardProgressionAttributeNode:SetTargetNode(targetNode)
    self._targetNode = targetNode
end


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionAttributeNode:OnClickBtnIconAction()
    if isNull(self._targetNode) then return end
    
    local attributeInfo = self._attributeInfo
    local viewType      = attributeInfo.viewType
    ---@type AttrDefinesVo
    local vo = self._attributeInfo.vo
    if viewType == CardProgressionConstants.AttrNodeType.CardAttr then
        self:OnClickBtnCardAttributeIconAction()
    elseif viewType == CardProgressionConstants.AttrNodeType.Race then
        self:OnClickBtnRaceAction()
    elseif vo then
        UICommonUtils.ShowAttributeTips(self.controller.gameObject, vo)
    end
    
end

function CardProgressionAttributeNode:OnClickBtnCardAttributeIconAction()
    if isNull(self._targetNode) then return end
    
    CardProgressionUtils.ShowCardCareerDescTips(self.controller.transform)
    
end

function CardProgressionAttributeNode:OnClickBtnRaceAction()
    if isNull(self._targetNode) then return end
    
    local attributeInfo = self._attributeInfo
    local raceId        = attributeInfo.raceId       
    -- CardProgressionUtils.ShowRaceTips(raceId, self.controller.transform)
    
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionAttributeNode
