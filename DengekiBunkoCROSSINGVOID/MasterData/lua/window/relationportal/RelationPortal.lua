local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local GU = require("Common/GuildUtil")

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonFriend, function()
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.Friend, PB.enum.UnlockWindow.Friend) then
      WU.AcquireWindowAsync("Friend", function(window)
        local friendlist = this:GetData("fci/friendlist/") or {}
        _ENV["$"](window)["$$SetTab"](#friendlist == 0)
      end)
    end
  end)
  WU.BindButtonEvent(REF.ButtonGuild, function()
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.Guild, PB.enum.UnlockWindow.Guild) then
      local guildPlayer = this:GetData("fci/guild-player")
      if guildPlayer then
        if guildPlayer.guildId ~= 0 then
          WU.AcquireWindowAsync("Guild")
        else
          this:GameRequest("fci/guild-recommend/"):Post(nil, function(guildRecommend)
            if guildRecommend then
              this:SetData("fci/guild-recommend/", guildRecommend)
              WU.AcquireWindowAsync("GuildPortal")
            end
          end)
        end
      end
    end
  end)
end

function InitWindow()
  RU.BindRedMark(this, "Relation/Friend", function(flag)
    local isLocked, unlockLevel = WU.WindowIsLocked(PB.enum.UnlockWindow.Friend)
    REF.SpriteFriendBadge.gameObject:SetActive(not isLocked and flag)
  end)
  RU.BindRedMark(this, "Relation/Guild", function(flag)
    local isLocked, unlockLevel = WU.WindowIsLocked(PB.enum.UnlockWindow.Guild)
    REF.SpriteGuildBadge.gameObject:SetActive(not isLocked and flag)
  end, {
    "Relation/Guild/Message"
  })
end

function Focus(on)
  WU.RecordWindowFocus(100107, on)
end
