local Config = {
    [1] = {
        text = localize("全服社团排名"),
        type = ClubUtils.BossRankType.AllServerClub,
        interface = Interfaces.OverseaClubCatCarRank
    },
    [2] = {
        text = localize("社团内成员排名"),
        type = ClubUtils.BossRankType.ClubMember,
        interface = Interfaces.OverseaClubPlayerCatCarRank
    },
    [3] = {
        text = localize("全服个人排名"),
        type = ClubUtils.BossRankType.Personnel,
        interface = Interfaces.OverseaClubCatCarPlayerRank
    },
}

local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local KTool = CS.Engine.Lib.KTool

---@class OverseaClubCatCarRankDialog : OverseaClubBossRankDialog
---@field Env                            OverseaClubCatCarRankDialog
---@field controller                        Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
local OverseaClubCatCarRankDialog = Class("OverseaClubCatCarRankDialog",import("Game.UI.Club.Boss.OverseaClubBossRankDialog"))


function OverseaClubCatCarRankDialog:Awake()
    
end

function OverseaClubCatCarRankDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local parameters = checkTable(self.controller.Argument.parameters)
        self.curType = parameters.type or ClubUtils.BossRankType.AllServerClub
        local clubHomeDojo  = ClubUtils.GetClubComp():GetHomeDojo()
        if checkNumber(clubHomeDojo.carScheduleId) < 2 then
            Config[1].hideLastBtn = true
            Config[2].hideLastBtn = true
            Config[3].hideLastBtn = true
        end
        xTry(function()
            self:InitToggleData()
            self:InitNodeEnv()
            KTool.SetActive(self.Root.gameObject,false)
            self:TopTabOnClickHandler(self.curType)
        end)
    end))
    return coWait
end

function OverseaClubCatCarRankDialog:GetClubRankLuaPath()
    return "Game.UI.Club.CatCar.Rank.OverseaClubCatCarRankClubNode"
end

function OverseaClubCatCarRankDialog:GetConfig()
    return Config
end

return OverseaClubCatCarRankDialog