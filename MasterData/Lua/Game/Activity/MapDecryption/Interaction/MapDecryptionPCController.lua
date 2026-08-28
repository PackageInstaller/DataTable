------------ import ------------
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
------------ import ------------

------------ define ------------
local abs = math.abs

local EventNames
------------ define ------------

---@class MapDecryptionPCController
local MapDecryptionPCController = Class('MapDecryptionPCController')


function MapDecryptionPCController:__init()
    EventNames = MapDecryptionConstants.EventNames
    self._isEnable       = false
    self._IsOpenInteract = false
end

function MapDecryptionPCController:__delete()
    -- self._playerInput = nil
end

function MapDecryptionPCController:Init()
    -- self._playerInput = playerInput

end

function MapDecryptionPCController:Update()
    if not self._isEnable then
        return
    end 

    if self._IsOpenInteract then
        if Input.GetKeyDown(KeyCode.F) then
            Events.Broadcast(EventNames.PCControllerF)

        else
            local deltaY = Input.mouseScrollDelta.y
            if math.abs(deltaY) > 0.1 then
                Events.Broadcast(EventNames.PCControllerSwitchOption, deltaY)
            end
            
        end
        -- print("Input.mousePosition", Input.mousePosition)
    end

    -- Input.

end

function MapDecryptionPCController:SetEnabled(isEnable)
    self._isEnable = isEnable
end

--- SetIsOpenInteract
---@param isOpenInteract boolean 是否开启交互
function MapDecryptionPCController:SetIsOpenInteract(isOpenInteract)
    self._IsOpenInteract = isOpenInteract
end

return MapDecryptionPCController
