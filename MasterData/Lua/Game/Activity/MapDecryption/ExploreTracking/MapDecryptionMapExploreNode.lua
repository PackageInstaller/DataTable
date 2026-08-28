
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/MapDecryption/SpringFestivalMapExploreNode.prefab
---@class MapDecryptionMapExploreNode
---@field Env                           	MapDecryptionMapExploreNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field BtnExploreMap                 	UnityEngine.RectTransform               
---@field ImgTxBg                       	Game.Native.Common.UISwitchImage        
---@field TxtName                       	UnityEngine.UI.Text                     
---@field LockNode                      	UnityEngine.RectTransform               
---@field ImgMapIcon2                   	Engine.UI.RawImageAlterable             
---@field ImgMapMask2                   	UnityEngine.RectTransform               
---@field ImgMapIconBg2                 	UnityEngine.RectTransform               
---@field ImgMapIcon                    	Engine.UI.RawImageAlterable             
---@field ImgMapMask1                   	UnityEngine.RectTransform               
---@field ImgMapIconBg1                 	UnityEngine.RectTransform               
---@field ImgPointChoose                	UnityEngine.Animation                   
---@field ImgMapIconChoose2             	Engine.UI.RawImageAlterable             
---@field ImgMapIconChoose1             	Engine.UI.RawImageAlterable             
local MapDecryptionMapExploreNode = Class('MapDecryptionMapExploreNode')

function MapDecryptionMapExploreNode:__init()
    
end


function MapDecryptionMapExploreNode:__delete()
    self._callback = nil
end


function MapDecryptionMapExploreNode:Awake()
end


function MapDecryptionMapExploreNode:Start()
    SetButtonAction(self.BtnExploreMap, Bind(self, self.OnClickBtnExploreMapAction))
end


function MapDecryptionMapExploreNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param entity MapDecryptionExploreDataEntity
function MapDecryptionMapExploreNode:FreshUI(entity, isSelect)
    self._entity = entity
    local isLock = entity.isUnlock == 0
    ---@type MapDecryptionDecryptedMapsVo
    local mapVo = entity.mapConfData
    local place = mapVo.place
    self.ImgMapIcon:LoadSprite(place)
    self.ImgMapIcon2:LoadSprite(place)
    self.TxtName.text = mapVo.name

    self:FreshSelectState(isSelect, isLock)
    self:FreshLockNode(isLock)

end

function MapDecryptionMapExploreNode:FreshSelectState(isSelect, isLock)
    local isExpend = isSelect and not isLock

    KTool.SetActive(self.ImgPointChoose, isSelect)
    KTool.SetActive(self.ImgMapIconBg2,  isExpend)
    KTool.SetActive(self.ImgMapMask2,    isExpend)

    KTool.SetActive(self.ImgMapIconBg1,  not isExpend)
    KTool.SetActive(self.ImgMapMask1,    not isExpend)
    

end

function MapDecryptionMapExploreNode:FreshLockNode(isLock)
    KTool.SetActive(self.LockNode, isLock)

end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function MapDecryptionMapExploreNode:SetCallback(callback)
    self._callback = callback
end
function MapDecryptionMapExploreNode:SetIndex(index)
    self._index = index
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function MapDecryptionMapExploreNode:OnClickBtnExploreMapAction()
    if self._callback then
        self._callback(self._entity, self._index, self)
    end
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionMapExploreNode
