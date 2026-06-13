
local FriendHelper = {}

function FriendHelper.ReplaceMaxParme(data, max, param1, param2)
    max = max or FriendHelper.FindMaxParme(param2)
    data[param1] = data[param1] or 0
    data[param1] = data[param1] < max and data[param1] or max
end

function FriendHelper.FindMaxParme(name)
    local heroDatas = IHeroDataMgr:GetHeros()
    local max = 0

    for _,v in pairs(heroDatas) do
        max = v[name](v) > max and v[name](v) or max
    end

    return max
end

function FriendHelper.GetShowGirlId(pictureId)
    local id = 110006

    if pictureId ~= 0 then
        id = IPlayerData.pictureId
        -- local pics = CS.GameX.GameHelper.GetPicture(pictureId)
        -- id = CS.GameX.GameHelper.GetMyHeroDataById(pics[0])
    end

    return id
end

--通过玩家IconId获得icon路径
function FriendHelper.GetPlayerIcon(iconId)
    if iconId == nil or iconId == 0 then 
        iconId = ConfigHelper.GetSystemParam(337)
    end
    if iconId == nil or iconId == nil then 
        return nil
    end
    local iconCfg = ConfigHelper.GetCfg("headIcon",iconId)
    if iconCfg == nil then 
        return nil
    end
    return iconCfg.icon
end

function FriendHelper.GetLogoutName(time)
    local curTime = GameUtil.GetCurTimeTick()
    local subTime = curTime - time

    if subTime < 60 then
        return ConfigHelper.GetLocalString(5655)
    elseif subTime < 3600 then
        local min = math.floor(subTime / 60) 
        local format = ConfigHelper.GetLocalString(5656)
        return string.format(format, min)
    elseif subTime <= 86400 then
        local hour = math.floor(subTime / 3600)
        local format = ConfigHelper.GetLocalString(5657)
        return string.format(format, hour)
    elseif subTime <= 2592000 then
        local day = math.floor(subTime / 86400)
        local format = ConfigHelper.GetLocalString(5658)
        return string.format(format, day)
    else
        return ConfigHelper.GetLocalString(5659)
    end
end

return FriendHelper