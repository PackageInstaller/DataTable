
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/MapDecryption/SpringFestivalMapTrackingNode.prefab
---@class MapDecryptionMapTrackingNode
---@field Env                           	MapDecryptionMapTrackingNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ChooseNode                    	UnityEngine.RectTransform               
---@field Star3                         	Game.Native.Common.UISwitchImage        
---@field Star2                         	Game.Native.Common.UISwitchImage        
---@field Star1                         	Game.Native.Common.UISwitchImage        
---@field StarNode                      	UnityEngine.RectTransform               
---@field LockNode                      	UnityEngine.RectTransform               
---@field ImgMapIcon                    	Engine.UI.RawImageAlterable             
---@field BtnTrackingMap                	UnityEngine.RectTransform               
local MapDecryptionMapTrackingNode = Class('MapDecryptionMapTrackingNode')

function MapDecryptionMapTrackingNode:__init()
    
end


function MapDecryptionMapTrackingNode:__delete()

end


function MapDecryptionMapTrackingNode:Awake()
    -- KTool.SetActive(self.StarNode.gameObject, true)
    -- self.Stars = {self.Star1, self.Star2, self.Star3}
end


function MapDecryptionMapTrackingNode:Start()
    SetButtonAction(self.BtnTrackingMap, Bind(self, self.OnClickBtnTrackingMapAction))
end


function MapDecryptionMapTrackingNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()

end


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param entity MapDecryptionTrackingDataEntity
---@param isSelect boolean
function MapDecryptionMapTrackingNode:FreshUI(entity, isSelect)
    self._entity = entity
    local isLock = entity.isUnlock == 0

    -- KTool.SetActive(self.StarNode.gameObject, not isLock)
    --- 刷新bossIcon
    if isLock then
        self.ImgMapIcon:LoadSprite(MapDecryptionConstants.DefaultImgAssets.TrackingBoss)
    else
        local questId    = entity.questId
        ---@type MapDecryptionQuestVo
        local questVo    = MapDecryptionConfMgr:GetQuestVoById(questId)
        self.ImgMapIcon:LoadSprite(questVo.picture)
        -- self:FreshStarNodes(entity.star)
    end

    self:FreshSelectState(isSelect)
    self:FreshLockNode(isLock)

end

-- function MapDecryptionMapTrackingNode:FreshStarNodes(questStar)
--     local starCount = 0
--     for i, v in pairs(questStar) do
--         if checkNumber(v) > 0 then
--             starCount = starCount + 1
--         end
--     end

--     for i, star in pairs(self.Stars) do
--         star.Status = starCount >= i and 2 or 1
--     end

-- end

function MapDecryptionMapTrackingNode:FreshSelectState(isSelect)
    KTool.SetActive(self.ChooseNode.gameObject, isSelect)

end

function MapDecryptionMapTrackingNode:FreshLockNode(isLock)
    KTool.SetActive(self.LockNode.gameObject, isLock)

end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function MapDecryptionMapTrackingNode:SetCallback(callback)
    self._callback = callback
end
function MapDecryptionMapTrackingNode:SetIndex(index)
    self._index = index
end


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function MapDecryptionMapTrackingNode:OnClickBtnTrackingMapAction()
    if self._callback then
        self._callback(self._entity, self._index, self)
    end
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionMapTrackingNode
