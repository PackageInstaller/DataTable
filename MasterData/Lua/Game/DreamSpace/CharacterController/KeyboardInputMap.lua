---
--- Author: dawanfan
--- Date: 2024-2-2 15:12:22
---


local Singleton = import('Frame.Singleton')


---@class KeyboardInputMap: Singleton
---@field GetInstance fun(self:KeyboardInputMap): KeyboardInputMap
local KeyboardInputMap = Class("KeyboardInputMap", Singleton)

function KeyboardInputMap:__init()
    self.inputMap = {}
end

function KeyboardInputMap:__delete()
    self.inputMap = {}
end

function KeyboardInputMap:RegisterInput(key, func)
    if self.inputMap[key] then
        printError(string.format("[KeyboardInputMap][RegisterInput] register func fail, key(%s) already register", key))
        return
    end

    self.inputMap[key] = func
end

function KeyboardInputMap:UnRegisterInput(key)
    self.inputMap[key] = nil
end

return KeyboardInputMap
