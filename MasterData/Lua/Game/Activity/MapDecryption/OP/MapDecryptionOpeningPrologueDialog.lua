
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/SpringFestival/MapDecryptionOpeningPrologueDialog.prefab
---@class MapDecryptionOpeningPrologueDialog
---@field Env                           	MapDecryptionOpeningPrologueDialog                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field BtnSkipIcon                   	UnityEngine.RectTransform               
---@field BtnNode                       	UnityEngine.RectTransform               
local MapDecryptionOpeningPrologueDialog = Class('MapDecryptionOpeningPrologueDialog')

function MapDecryptionOpeningPrologueDialog:__init()

end


function MapDecryptionOpeningPrologueDialog:__delete()

end


function MapDecryptionOpeningPrologueDialog:Awake()
    KTool.SetActive(self.BtnSkipIcon.gameObject, false)
end


function MapDecryptionOpeningPrologueDialog:Start()
    -- SetButtonAction(self.BtnSkipIcon, Bind(self, self.OnClickSkipBtnAction))
    SetButtonAction(self.BtnNode, Bind(self, self.OnClickSkipBtnAction))

end


function MapDecryptionOpeningPrologueDialog:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------


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

function MapDecryptionOpeningPrologueDialog:OnClickSkipBtnAction()
    Events.Broadcast("MapDecryptionStopLoopEvent")
    KTool.SetActive(self.controller.gameObject, false)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionOpeningPrologueDialog
