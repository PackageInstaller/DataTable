---@class OverseaClubCatCarMgr : Singleton
---@field Server OverseaClubCatCarServer
local OverseaClubCatCarMgr = Class("OverseaClubCatCarMgr", import("Frame.Singleton"))

function OverseaClubCatCarMgr:__init()
    OverseaClubCatCarMgr.super.__init(self)
    self:CreateServer()
end

function OverseaClubCatCarMgr:__delete()

end

function OverseaClubCatCarMgr:CreateServer()
    self.Server = import("Game.UI.Club.CatCar.OverseaClubCatCarServer").New()
end

function OverseaClubCatCarMgr:Reset()
    self:CreateServer()
end
return OverseaClubCatCarMgr