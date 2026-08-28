---
--- Created by zou hanjie.
--- DateTime: 2024/07/23 12:48


-- 有些变量每一帧都在变化, 用本 class 来集中管理 前一帧的信息

---@class FrameVariable
local FrameVariable = Class('FrameVariable')
-- 外部访问时使用:
-- local FrameVariable = import('Game.Activity.ParkourGame.FrameVariable')



function FrameVariable:__init( initVal_ )
    self.current = initVal_ 
    self.last = initVal_
end



function FrameVariable:__delete()
    self.current = nil 
    self.last = nil
end

-- ===========================================

function FrameVariable:SetCurrent( new_ ) 
    self.current = new_
end

function FrameVariable:IsChangeThisFrame() 
    return (self.current ~= self.last)
end


function FrameVariable:Sync() 
    self.last = self.current
end




return FrameVariable
