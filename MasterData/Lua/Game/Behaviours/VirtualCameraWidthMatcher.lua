---from: https://gamedev.stackexchange.com/questions/167317/scale-camera-to-fit-screen-size-unity
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
--endregion

--region define
local LuaParametersType       = LuaParametersReader.Type 
local LuaParametersExpandType = LuaParametersReader.ExpandType
--endregion

--- from: Assets/BundleResources/Scenes/GVGmap/Prefabs/VirtualCameraRoot.prefab > name: Camera
---@class VirtualCameraWidthMatcher
---@field Env                           	VirtualCameraWidthMatcher               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Camera                        	Cinemachine.CinemachineVirtualCamera    	@ 0    
---@field LuaParams                     	Engine.Modules.LuaParameters            	@ 1    
local VirtualCameraWidthMatcher = Class('VirtualCameraWidthMatcher')

function VirtualCameraWidthMatcher:__init()

end


function VirtualCameraWidthMatcher:__delete()

end


function VirtualCameraWidthMatcher:Awake()
    local luaParams = self.LuaParams
    self._sceneWidth = LuaParametersReader.Read( luaParams, "sceneWidth", LuaParametersType.Float ) 
    self._horizontalFoV = LuaParametersReader.Read( luaParams, "horizontalFoV", LuaParametersType.Float ) 

end


function VirtualCameraWidthMatcher:Start()
    self:Fresh()
end


function VirtualCameraWidthMatcher:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function VirtualCameraWidthMatcher:Fresh()
    local Camera = self.Camera
    if Camera.IsPhysicalCamera then
        return
    end

    local Orthographic = Camera.Orthographic

    if Orthographic then
        self:FreshOrthoSize(Camera)
    else
        self:FreshFieldOfView(Camera)
    end

end

function VirtualCameraWidthMatcher:FreshOrthoSize(camera)
    local sceneWidth = self._sceneWidth or 13

    local unitsPerPixel = sceneWidth / SCREEN_WIDTH
    local desiredHalfHeight = 0.5 * unitsPerPixel * SCREEN_HEIGHT
    camera.m_Lens.OrthographicSize = desiredHalfHeight

end

function VirtualCameraWidthMatcher:FreshFieldOfView(camera)
    local horizontalFoV = self._horizontalFoV or 90

    local  halfWidth = Mathf.Tan(0.5 * horizontalFoV * Mathf.Deg2Rad)
    local  halfHeight = halfWidth * SCREEN_HEIGHT / SCREEN_WIDTH
    local  verticalFoV = 2.0 * Mathf.Atan(halfHeight) * Mathf.Rad2Deg
    camera.m_Lens.FieldOfView = verticalFoV

end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return VirtualCameraWidthMatcher
