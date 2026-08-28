---
--- Created by zou hanjie.
--- DateTime: 2022/12/08 12:48

---@class ParkourGameDebug
local ParkourGameDebug = Class('ParkourGameDebug')
-- 外部访问时使用:
-- local ParkourGameDebug = import('Game.Activity.ParkourGame.ParkourGameDebug')



--- lua:
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程
local KTool = CS.Engine.Lib.KTool


---:
local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Mathf = CS.UnityEngine.Mathf
local Canvas = CS.UnityEngine.Canvas
local Transform = CS.UnityEngine.Transform
local Button = CS.UnityEngine.UI.Button
local RectTransform = CS.UnityEngine.RectTransform
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local Quaternion = CS.UnityEngine.Quaternion
local Color = CS.UnityEngine.Color
local Time = CS.UnityEngine.Time
local Text = CS.UnityEngine.UI.Text
local Image = CS.UnityEngine.UI.Image
local RawImage = CS.UnityEngine.UI.RawImage
local LayerMask = CS.UnityEngine.LayerMask
local Physics = CS.UnityEngine.Physics
local RaycastHit = CS.UnityEngine.RaycastHit
local Application = CS.UnityEngine.Application
local RuntimePlatform = CS.UnityEngine.RuntimePlatform
local Animation = CS.UnityEngine.Animation
local PrimitiveType = CS.UnityEngine.PrimitiveType
local Collider = CS.UnityEngine.Collider

-- ======================================================== 

-- 跳跃检测线 粗细
local jumpLineRadius = 0.01

-- 跳跃落点 半径
local jumpPointRadius = 0.15
local jumpPointLocalScale = Vector3( jumpPointRadius, jumpPointRadius, jumpPointRadius )

local infinityFarPos = Vector3( 2000, 0, 0 )



local ShowType = 
{
    Cube = 1,
    Sphere = 2,
    Capsule = 3
}


-- ======================================================== 

function ParkourGameDebug:__init()


end


function ParkourGameDebug:__delete()

end



-- 设置一个 cube 杆子的 形状;
function ParkourGameDebug.DrawCubePole( cubeTF_, fromPos_, toPos_, radius_ )
    local midPos = (fromPos_ + toPos_) * 0.5 
    cubeTF_.position = midPos;
    cubeTF_:LookAt( toPos_, Vector3.up );
    cubeTF_.localScale = Vector3( radius_,radius_, (toPos_ - fromPos_).magnitude );   
end





function ParkourGameDebug.SetGameObjectColor(gameobj, color)
    local renderer = gameobj:GetComponent("Renderer")
    if renderer and renderer.material then -- 因为是 debug 工具. 无需考虑这个 material 的释放问题
        renderer.material:SetColor("_BaseColor", color)
    end
end



-- 新建个 杆子
function ParkourGameDebug.CreateNewPrimitive( name_, parent_, color_ )
 
    local newgo = GameObject.CreatePrimitive(PrimitiveType.Cube)
    local newTF = newgo.transform

    if parent_ then 
        newTF:SetParent( parent_ )
    end     

    newgo.name = name_
    ParkourGameDebug.SetGameObjectColor(newgo, color_)

    local collider = KTool.GetComponent(newgo, typeof(Collider))
    Object.Destroy( collider )

    newTF.localScale = Vector3( 0.2, 0.2, 0.2 )
    newTF.position = infinityFarPos
    return newTF
end




return ParkourGameDebug
