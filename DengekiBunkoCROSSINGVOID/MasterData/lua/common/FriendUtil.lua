local WU, DB = require("Common/WindowUtil")()
local DBH = require("Manager/DataBindingHandler")
local PB = require("Common/PbHelper")
local FU = {}

function FU.BlockPlayer(playerId)
  DB:GameRequest("fci/blacklist/"):Post({targetId = playerId}, function(result)
    local blacklist = DB:GetData("fci/blacklist/")
    local i = table.find(blacklist, function(k, v)
      return v.playerId == playerId
    end)
    if i == nil then
      table.insert(blacklist, result)
      DB:SetData("fci/blacklist/", blacklist)
    end
  end)
end

function FU.UnblockPlayer(playerId)
  DB:GameRequest("fci/blacklist/" .. playerId):Delete(function(result)
    local blacklist = DB:GetData("fci/blacklist/")
    local i = table.find(blacklist, function(k, v)
      return v.playerId == playerId
    end)
    if i ~= nil then
      table.remove(blacklist, i)
      DB:SetData("fci/blacklist/", blacklist)
    end
  end)
end

function FU.IsBlock(playerId)
  local blacklist = DB:GetData("fci/blacklist/")
  local i = table.find(blacklist, function(k, v)
    return v.playerId == playerId
  end)
  if i ~= nil then
    return true
  else
    return false
  end
end

function FU.MarkNewFriend(flag)
  local gameDataCache = DB:GetData("gameDataCache")
  if gameDataCache.newFriend ~= flag then
    gameDataCache.newFriend = flag
    DB:SetData("gameDataCache", gameDataCache)
  end
end

function FU.GetGenderIcon(gender, isBig)
  local prefix = "gender_"
  if isBig then
    prefix = "gender_big_"
  end
  if type(gender) == "string" then
    if gender == "\231\148\183" then
      return prefix .. 1
    elseif gender == "\229\165\179" then
      return prefix .. 2
    else
      return prefix .. 0
    end
  elseif gender == PB.enum.PlayerSex.Unkonwn then
    return prefix .. 0
  elseif gender ~= nil then
    return prefix .. gender
  end
end

function FU.LastLogoutTime(time, fontSize)
  if time == 0 then
    return WU.GetString("Window_Online")
  else
    return WU.RenderElpasedTime(CS.GameTime.serverUtc - time)
  end
end

function FU.RemoveLatestTalkTarget(playerId)
  local targets = DB:GetData("LatestChatTargets") or {}
  local idx = table.find(targets, function(k, v)
    return v.senderId == playerId
  end)
  if idx ~= nil then
    table.remove(targets, idx)
    DB:SetData("LatestChatTargets", targets)
  end
end

function FU.RemoveFromRecommendlist(playerId)
  local list = DB:GetData("fci/recommendrelation/") or {}
  local idx = table.find(list, function(k, v)
    return v.playerId == playerId
  end)
  if idx ~= nil then
    table.remove(list, idx)
    DB:SetData("fci/recommendrelation/", list)
  end
end

function FU.IsSocialFriend(playerInfo)
  local list = DB:GetData("fci/socialfriend/") or {}
  local isSocialFriend = false
  local id = playerInfo.socialOpenId
  for i = 1, #list do
    if list[i].msdkInfo.openId == id then
      isSocialFriend = true
    end
  end
  return isSocialFriend
end

function FU.HandlerFriendInfoChanged(playerId, playerInfo)
  local friends = DB:GetData("fci/friendlist/")
  local i = table.find(friends, function(k, v)
    return v.playerId == playerId
  end)
  
  local function Change(friend, playerInfo)
    friend.lastLogoutTime = playerInfo.lastLogoutTime or friend.lastLogoutTime
    friend.name = playerInfo.name or friend.name
    friend.level = playerInfo.level or friend.level
    friend.guildId = playerInfo.guildId or friend.guildId
    friend.socialPicture = playerInfo.socialPicture or friend.socialPicture
  end
  
  if i ~= nil then
    Change(friends[i], playerInfo)
    DB:SetData("fci/friendlist/", friends)
  end
  local socialFriend = DB:GetData("fci/socialfriend/") or {}
  local i = table.find(socialFriend, function(k, v)
    return v.playerInfo.playerId == playerId
  end)
  if i then
    Change(socialFriend[i].playerInfo, playerInfo)
    DB:SetData("fci/socialfriend/", socialFriend)
  end
end

function FU.IsGameFriend(playerId)
  local friendlist = DB:GetData("fci/friendlist")
  if table.find(friendlist, function(k, v)
    return v.playerId == playerId
  end) then
    return true
  end
  return false
end

return FU
