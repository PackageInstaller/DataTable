---@class ActivityGachaponSkinMgr : Singleton
---@field Sever ActivityGachaponSkinServer
local ActivityGachaponSkinMgr = Class("ActivityGachaponSkinMgr", import("Frame.Singleton"))

function ActivityGachaponSkinMgr:__init()
    ActivityGachaponSkinMgr.super.__init(self)
    self.Sever = import("Game.Activity.GachaponSkin.ActivityGachaponSkinServer").New()
end

function ActivityGachaponSkinMgr:__delete()

end

-- ctrl q  重新打开UI时重置Server
function ActivityGachaponSkinMgr:Reset()
    self.Sever = import("Game.Activity.GachaponSkin.ActivityGachaponSkinServer").New()
end

return ActivityGachaponSkinMgr