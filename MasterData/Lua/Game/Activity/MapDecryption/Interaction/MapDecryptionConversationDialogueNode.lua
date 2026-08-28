
------------ import ------------
---@type Engine.UI.UIEventProxy
local UIEventProxy = CS.Engine.UI.UIEventProxy
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

------------ define ------------
--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalConversationDialogueNode.prefab
---@class MapDecryptionConversationDialogueNode
---@field Env                           	MapDecryptionConversationDialogueNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field OptionEffect                  	UnityEngine.RectTransform               
---@field TxtContent                    	UnityEngine.UI.Text                     
---@field ImgIcon                       	Game.Native.Common.UISwitchImage        
---@field SelectNode                    	UnityEngine.RectTransform               
---@field BtnDialogue                   	UnityEngine.Animation                   
local MapDecryptionConversationDialogueNode = Class('MapDecryptionConversationDialogueNode')

function MapDecryptionConversationDialogueNode:__init()

end


function MapDecryptionConversationDialogueNode:__delete()

end


function MapDecryptionConversationDialogueNode:Awake()
end


function MapDecryptionConversationDialogueNode:Start()
    local eventProxy = UIEventProxy.Create(self.BtnDialogue.gameObject)
    eventProxy.onPointerDown = function()
        UICommonUtils.PlayAnimation(self.BtnDialogue, "MapDecryptionConversationOptionsBtnOptionPressed")
    end
    eventProxy.onPointerClick = function()
        if self._callback then
            self._callback(self._optionData)
        end
        -- MapDecryptionUtils.PopDialogByEnterType(self.optionData)
    end
end


function MapDecryptionConversationDialogueNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------
--- FreshUI
---@param optionData table
function MapDecryptionConversationDialogueNode:FreshUI(optionData)
    self._optionData     = optionData
    ---@type MapDecryptionInteractiveLinesVo
    local vo             = optionData.vo
    -- print(table.toString(optionData))
    self.TxtContent.text = vo.name    
    self.ImgIcon.Status  = vo.sex

    -- KTool.SetActive(self.)
end

function MapDecryptionConversationDialogueNode:SetSelectState(isSelect)
    local pcPlatform = MapDecryptionUtils.IsPCPlatform()
    KTool.SetActive(self.SelectNode.gameObject, pcPlatform and isSelect)
end

---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function MapDecryptionConversationDialogueNode:SetCallback(callback)
    self._callback = callback
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionConversationDialogueNode
