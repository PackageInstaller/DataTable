---@class OverseaClubFeedCatMgr : Singleton
---@field Server OverseaClubFeedCatServer
local OverseaClubFeedCatMgr = Class("OverseaClubFeedCatMgr", import("Frame.Singleton"))

function OverseaClubFeedCatMgr:__init()
    OverseaClubFeedCatMgr.super.__init(self)
    self:CreateServer()
end

function OverseaClubFeedCatMgr:__delete()

end

function OverseaClubFeedCatMgr:CreateServer()
    self.Server = import("Game.UI.Club.FeedCat.OverseaClubFeedCatServer").New()
end

function OverseaClubFeedCatMgr:Reset()
    self:CreateServer()
end

function OverseaClubFeedCatMgr:IsLikeFood(id)
    return table.isContain(self.Server.dojo.petsLikeFood,id)
end

function OverseaClubFeedCatMgr:IsUnlockSkinPart(part)
    if part == 1 then
        return self.Server.dojo.petsPhase > 1
    --else
    --    return false
    elseif part == 2 then
        return self.Server.dojo.petsPhase > 3
    elseif part == 3 then
        return self.Server.dojo.petsPhase > 3
    end
end

function OverseaClubFeedCatMgr:LoadCat(root)
    if self.cat == nil then
        local OverseaClubFeedCatAvatar = import("Game.UI.Club.FeedCat.OverseaClubFeedCatAvatar")
        ---@type OverseaClubFeedCatAvatar
        self.cat = OverseaClubFeedCatAvatar.New()
        self.cat:Init(root,self.Server.dojo.petsPhase,self.Server.dojo.petsFacade)
    end
end

---清理神兽换装加载的资源
function OverseaClubFeedCatMgr:ReleaseCat()
    if self.cat then
        self.cat:Delete()
        self.cat = nil
    end
end

return OverseaClubFeedCatMgr