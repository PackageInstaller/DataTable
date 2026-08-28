---
--- 在 Dialog 中跟随场景中 3D 物体的 UI 上的动态显示节点
--- Author: dawanfan
--- Date: 2024-1-18 10:34:52
---

local DreamSpaceUtils = CS.DreamSpace.DreamSpaceUtils
local InteractableHintUtils = CS.InteractableHint.InteractableHintUtils
local RaycastHit = CS.UnityEngine.RaycastHit
local KTool = CS.Engine.Lib.KTool
local Vector3           = Vector3

local raycastHits = CS.System.Array.CreateInstance( typeof(RaycastHit), 16 ) -- RaycastHit[], 16 个元素, 为避免GC而存在

local farPos = Vector3(0.0, 10000.0, 0.0)


local inn_wallTags = CS.System.Array.CreateInstance( typeof(CS.System.String), 3 ) -- todo: 未来搞出参数
inn_wallTags[0] = "Wall"
inn_wallTags[1] = "CanJump"
inn_wallTags[2] = "Wall"


---@class DynamicUINode3D
---@field parentRectTransform UnityEngine.RectTransform
---@field rectTransform UnityEngine.RectTransform
local DynamicUINode = Class("DynamicUINode")

---@param parentRectTransform UnityEngine.RectTransform
---@param circleRadius number
---@param deadZoneWidth number
function DynamicUINode:InitNode(parentRectTransform, circleRadius, deadZoneWidth, maxDistance, ...)
    self.parentRectTransform = parentRectTransform
    self.circleRadius = circleRadius
    self.deadZoneWidth = deadZoneWidth
    self.maxDistance = maxDistance
    self.enableScale = false
    self.camera = self:GetCamera()
    self:DoInit(...)

    self.rectTransform.position = self:GetPosition3D()
end

---@return UnityEngine.Camera
function DynamicUINode:GetCamera()
    return CS.Game.Native.URP.URPCameraController.Instance.mainCamera
end

function DynamicUINode:DoInit(...)
    
end

function DynamicUINode:GetPosition3D()

end

function DynamicUINode:IsInScreen()
    local position = self:GetPosition3D()
    local distance = (self.camera.transform.position - position).magnitude
    local sortingOrder = checkInt(100 - distance)

    if distance > self.circleRadius then
        return false, 0
    end

    -- 若中间存在 有效遮挡, 则不显示:
    if InteractableHintUtils.IsHintBeBlocked( self.camera, position, raycastHits, inn_wallTags ) then 
        --print("koko 存在遮挡")
        return false, 0
    end


    local isDirectionsOpposite = Vector3.Dot( self.camera.transform.forward, position - self.camera.transform.position ) < 0.0
    if isDirectionsOpposite == true then 
        --print("koko 后半球")
        return false, 0
    end 

    -- Vector2
    local newAnchoredPosition = CfUtils.WorldPosition2UIPosition(position, self.parentRectTransform, nil)

    local isInScreen = InteractableHintUtils.IsInScreen(newAnchoredPosition, self.deadZoneWidth)
    if isInScreen == false then 
        --print("koko 不在屏幕内")
        return false, 0
    end

    return true, sortingOrder
end

function DynamicUINode:UpdateUIPositionAndScale()
    self.isInScreen, self.canvas.sortingOrder = self:IsInScreen()

    if self.isInScreen ~= self.isLastInScreen then 
        self.isLastInScreen = self.isInScreen

        if self.isInScreen == true then 
            -- 显示
            self:Show()
        else 
            -- 隐藏
            self:Hide()
        end
    end

    if self.isInScreen then        
        local lookAtPos = self.rectTransform.position + self.camera.transform.rotation * Vector3.unity_vector3.back
        local worldUpDir = self.camera.transform.rotation * Vector3.unity_vector3.up
        self.rectTransform:LookAt( lookAtPos, worldUpDir )
        self.rectTransform:Rotate( 0.0, 180.0, 0.0 )
    end
end

function DynamicUINode:Show()
    KTool.SetActive( self.controller.gameObject, true )
    -- self.inspectHintUI:SetInteractable( true )
    --self.inspectHintUI.ui_hintAnimation:Play( animationStr_off_2_in )
    -- self.inspectHintUI.ui_hintAnimation:Play( animationStr_showOff )
end

function DynamicUINode:Hide()
    KTool.SetActive( self.controller.gameObject, false )
    -- self.inspectHintUI:SetInteractable( false )
    -- self.inspectHintUI.ui_hintAnimation:Play( animationStr_in_2_off )
end

return DynamicUINode
