import("Frame.functions")

re = import('Frame.lpeg.re')

---@type Mathf
Mathf = import("Frame.UnityEngine.Mathf")

---@type Vector2
Vector2 = import("Frame.UnityEngine.Vector2")

---@type Vector3
Vector3 = import("Frame.UnityEngine.Vector3")

---@type Vector4
Vector4 = import("Frame.UnityEngine.Vector4")

---@type Quaternion
Quaternion = import("Frame.UnityEngine.Quaternion")

---@type Color
Color = import("Frame.UnityEngine.Color")

---@type Ray
Ray = import("Frame.UnityEngine.Ray")

---@type Bounds
Bounds = import("Frame.UnityEngine.Bounds")

---@type RaycastHit
RaycastHit = import("Frame.UnityEngine.RaycastHit")

Object = import("Frame.UnityEngine.Object")

---@type Event
Events = require("Frame.events")

import('Frame.Class')

local screen = CS.UnityEngine.Screen
SCREEN_WIDTH = screen.width
SCREEN_HEIGHT = screen.height

local sys_print = print

function print(...)
    if Config and (type(Config.DEBUG) ~= "boolean" or Config.DEBUG == false) then
        return
    end
    local args = {...}
    local where = tostring(string.split(debug.traceback("", 2), '\n')[3])
    table.insert(args, '\n' .. where)
    sys_print(table.unpack(args))
end