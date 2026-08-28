
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------
local EventTriggerMBPath = "Game.Behaviours.EventTriggerMB"

------------ define ------------

--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalConversationOptionNode.prefab
---@class MapDecryptionConversationOptionNode
---@field Env                           	MapDecryptionConversationOptionNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field EventTriggerNode                  UnityEngine.RectTransform               
---@field SelectNode                    	UnityEngine.RectTransform               
---@field TxtOption                     	UnityEngine.UI.Text                     
---@field ImgIconBg                     	UnityEngine.RectTransform               
---@field ImgIcon                       	Engine.UI.ImageAlterable                
---@field BtnOption                     	UnityEngine.Animation                   
local MapDecryptionConversationOptionNode = Class('MapDecryptionConversationOptionNode')

function MapDecryptionConversationOptionNode:__init()

end


function MapDecryptionConversationOptionNode:__delete()

end


function MapDecryptionConversationOptionNode:Awake()
end


function MapDecryptionConversationOptionNode:Start()
    local isPCPlatform = MapDecryptionUtils.IsPCPlatform()
    KTool.SetActive(self.EventTriggerNode.gameObject, isPCPlatform)
    if isPCPlatform then
        self:InitEventTriggerMB()
    else
        SetButtonAction(self.BtnOption, Bind(self, self.OnPointerClick))
    end

end


function MapDecryptionConversationOptionNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()

end

function MapDecryptionConversationOptionNode:InitEventTriggerMB()
    
    local EventTriggerType  = CS.UnityEngine.EventSystems.EventTriggerType
    ---@type EventTriggerMB
    local env = CfUtils.GetLuaScr(self.EventTriggerNode, EventTriggerMBPath)
    if not isNull(env) then
        env:RegEventTriggerEntry(EventTriggerType.PointerEnter, Bind(self, self.OnPointerEnter))
        env:RegEventTriggerEntry(EventTriggerType.PointerExit,  Bind(self, self.OnPointerExit))
        env:RegEventTriggerEntry(EventTriggerType.PointerClick, Bind(self, self.OnPointerClick))
    end

end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function MapDecryptionConversationOptionNode:FreshUI(optionData, dialogueData)
    self._isGossip = false
    self.optionData = checkNumber(optionData)
    self._dialogueData = dialogueData

    ---@type MapDecryptionFunctionEnterVo
    local functionEnterVo = MapDecryptionConfMgr:GetFunctionEnterVoById(optionData)

    KTool.SetActive(self.ImgIcon.gameObject,  true)
    KTool.SetActive(self.ImgIconBg.gameObject, true)
    ---@type MapDecryptionComponent
    local component = MapDecryptionMgr:GetComponent()
    --- 选项卡icon
    local isShowRedPoint = component:GetOptionRedPointStateByFunctionId(functionEnterVo.id)
    local icon = isShowRedPoint and functionEnterVo.icon2 or functionEnterVo.icon1
    self.ImgIcon:LoadSprite(icon)

    --- 选项卡内容
    self.TxtOption.text = functionEnterVo.name
end

function MapDecryptionConversationOptionNode:FreshGossipUI(optionData)
    local choiceName, choiceId = SafeUnpack(optionData)
    self._isGossip      = true
    self._optionIndex   = choiceId
    KTool.SetActive(self.ImgIcon.gameObject,   false)
    KTool.SetActive(self.ImgIconBg.gameObject, false)
    self.TxtOption.text = choiceName
end


function MapDecryptionConversationOptionNode:SetSelectState(isSelect)
    local pcPlatform = MapDecryptionUtils.IsPCPlatform()
    KTool.SetActive(self.SelectNode.gameObject, pcPlatform and isSelect)
end

---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function MapDecryptionConversationOptionNode:SetCallback(callback)
    self._callback = callback
end

function MapDecryptionConversationOptionNode:SetPointerEnteCallback(callback)
    self._pointerEnterCallback = callback
end

function MapDecryptionConversationOptionNode:SetPointerExitCallback(callback)
    self._pointerExitCallback = callback
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function MapDecryptionConversationOptionNode:OnPointerClick(eventData)
    if self._callback then
        self._callback(eventData)
    end
end

function MapDecryptionConversationOptionNode:OnPointerEnter(eventData)
    if self._pointerEnterCallback then
        self._pointerEnterCallback(eventData)
    end
end


function MapDecryptionConversationOptionNode:OnPointerExit(eventData)
    if self._pointerExitCallback then
        self._pointerExitCallback(eventData)
    end
end



---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionConversationOptionNode
