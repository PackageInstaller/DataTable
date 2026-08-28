

--region import
---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
--endregion

--region define
local LuaParametersType       = LuaParametersReader.Type 
local Debug = true
--endregion

--- from:  > name: CameraWidthMatcher
---@class CameraWidthMatcher
---@field Env                           	CameraWidthMatcher                      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field LuaParams                     	UnityEngine.Transform                   	@ 0    
local CameraWidthMatcher = Class('CameraWidthMatcher')

function CameraWidthMatcher:__init()
    self._desiredHalfHeight = 0 
    self._desiredHalfHeightNew = 0
end


function CameraWidthMatcher:__delete()

end


function CameraWidthMatcher:Awake()

    local luaParams = self.LuaParams
    self._sceneWidth = LuaParametersReader.Read( luaParams, "sceneWidth", LuaParametersType.Float ) 
    self._horizontalFoV = LuaParametersReader.Read( luaParams, "horizontalFoV", LuaParametersType.Float ) 
    self._sceneWidthNew = self._sceneWidth
end


-- function CameraWidthMatcher:Start()
--     -- self:Fresh()
-- end


function CameraWidthMatcher:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param Camera UnityEngine.Camera
function CameraWidthMatcher:Fresh(Camera)
    self._camera = Camera

    if Camera.usePhysicalProperties then
        return
    end

    local orthographic = Camera.orthographic

    if orthographic then
        self:FreshOrthoSize(Camera)
    else
        self:FreshFieldOfView(Camera)
    end

end

function CameraWidthMatcher:FreshOrthoSize(camera)
    local desiredHalfHeight = self:CalcOrthoSize(self._sceneWidth)
    self._desiredHalfHeight = desiredHalfHeight
    self._desiredHalfHeightNew = desiredHalfHeight
    camera.orthographicSize = desiredHalfHeight

end

function CameraWidthMatcher:CalcOrthoSize(sceneWidth)
    sceneWidth = sceneWidth or 13

    local unitsPerPixel = sceneWidth / SCREEN_WIDTH
    local desiredHalfHeight = 0.5 * unitsPerPixel * SCREEN_HEIGHT
    return desiredHalfHeight
end

function CameraWidthMatcher:FreshFieldOfView(camera)
    local horizontalFoV = self._horizontalFoV or 90

    local  halfWidth = Mathf.Tan(0.5 * horizontalFoV * Mathf.Deg2Rad)
    local  halfHeight = halfWidth * SCREEN_HEIGHT / SCREEN_WIDTH
    local  verticalFoV = 2.0 * Mathf.Atan(halfHeight) * Mathf.Rad2Deg
    camera.FieldOfView = verticalFoV

    self._verticalFoV = verticalFoV
    
end

local strict_number_equal = strict_number_equal
local Time = CS.UnityEngine.Time
function CameraWidthMatcher:Update()
    if self._desiredHalfHeight ~= self._desiredHalfHeightNew then
        self._desiredHalfHeight = Mathf.Lerp(self._desiredHalfHeight, self._desiredHalfHeightNew, self._t)
        self._t = self._t + Time.deltaTime
        if self._t > 1 then
            self._desiredHalfHeight = self._desiredHalfHeightNew
            self._isUpdate = false
            Events.Broadcast(Constants.EventNames.CameraWidthMatcherChangeOrthSizeComplete)
        end
        local camera = self._camera
        if isNotNull(camera) then
            camera.orthographicSize = self._desiredHalfHeight
        end
        
    elseif self._isUpdate then
        self._isUpdate = false
        Events.Broadcast(Constants.EventNames.CameraWidthMatcherChangeOrthSizeComplete)
    end

end

--endregion 


--region get/set 

function CameraWidthMatcher:GetDesiredHalfHeight()
    return self._desiredHalfHeight
end

function CameraWidthMatcher:SetSceneWidthNew(v)
    self._sceneWidthNew = v
    self._desiredHalfHeightNew = self:CalcOrthoSize(v)
    self._isUpdate = true
    self._t = 0
end

function CameraWidthMatcher:GetVerticalFoV()
    return self._verticalFoV
end

-- function CameraWidthMatcher:UpdateSceneWidth()
--     if Debug then
--         local sceneWidth = LuaParametersReader.Read( self.LuaParams, "sceneWidth", LuaParametersType.Float ) 
--         if sceneWidth ~= self._sceneWidth then
--             self._sceneWidth = sceneWidth
--             self:FreshOrthoSize(self._camera)
--         end
--     end
--     return self._sceneWidth
-- end

---endregion 


--region handler 


---endregion 


return CameraWidthMatcher
