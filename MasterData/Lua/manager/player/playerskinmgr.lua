PlayerSkinMgr = {}
PlayerSkinMgr.PlayerSkinData = {}
PlayerSkinMgr.CurSkinIndex = 1
PlayerSkinMgr.IsInit = false
PlayerSkinMgr.CheckTimes = 0

PlayerSkinMgr.Init = function()
    if PlayerSkinMgr.IsInit then
        return;
    end
    PlayerSkinMgr.UpdatePlayerSkinData(DataMgr.Player.backgroundData.BackgroundInfos)
    local intervel = ConfigMgr.Config.constants.CharacterIntervel
    LuaMgr.RemoveTimer(TimerConst.MainPageSkinChangeInterval)
    LuaMgr.AddTimer(TimerConst.MainPageSkinChangeInterval, function() PlayerSkinMgr.ChangeSkin(false) end, intervel, -1)
    PlayerSkinMgr.ChangeSkin(false)
    PlayerSkinMgr.IsInit = true
    PlayerSkinMgr.CheckTimes = 0
end

PlayerSkinMgr.UpdatePlayerSkinData = function(data)
    PlayerSkinMgr.PlayerSkinData = {}
    for i, v in ipairs(data) do
        local skinInfo = { CharacterID = v.CharacterID, Skin = v.Skin }
        table.insert(PlayerSkinMgr.PlayerSkinData, skinInfo)
    end
end

PlayerSkinMgr.ChangeSkin = function(random)
    local len = #PlayerSkinMgr.PlayerSkinData
    if len <= 0 then
        return
    end
    if random then
        PlayerSkinMgr.CurSkinIndex = math.random(1, len);
    else
        PlayerSkinMgr.CurSkinIndex = (PlayerSkinMgr.CurSkinIndex + 1) % len
        if (PlayerSkinMgr.CurSkinIndex == 0) then
            PlayerSkinMgr.CurSkinIndex = len
        end
    end
    if(len > 1)then
        LuaMgr.InvokeUIEventListeners(UIEventConst.OnChangeCharacterSkin)
    end
end

PlayerSkinMgr.CheckSkinData = function()
    local len = #PlayerSkinMgr.PlayerSkinData
    if len <= 0 then
        return false
    end
    if (PlayerSkinMgr.CheckTimes > len) then
        return false
    end
    PlayerSkinMgr.CheckTimes = PlayerSkinMgr.CheckTimes + 1
    if PlayerSkinMgr.PlayerSkinData[PlayerSkinMgr.CurSkinIndex] ~= nil then
        PlayerSkinMgr.CheckTimes = 0
        return true
    else
        PlayerSkinMgr.CurSkinIndex = (PlayerSkinMgr.CurSkinIndex + 1) % len
        if (PlayerSkinMgr.CurSkinIndex == 0) then
            PlayerSkinMgr.CurSkinIndex = len
        end
        return PlayerSkinMgr.CheckSkinData()
    end
end

PlayerSkinMgr.GetSkinId = function()
    if PlayerSkinMgr.CheckSkinData() then
        return PlayerSkinMgr.PlayerSkinData[PlayerSkinMgr.CurSkinIndex].Skin
    end
    return nil
end

PlayerSkinMgr.GetCharacterId = function()
    if PlayerSkinMgr.CheckSkinData() then
        return PlayerSkinMgr.PlayerSkinData[PlayerSkinMgr.CurSkinIndex].CharacterID
    end
    return nil
end

PlayerSkinMgr.Clear = function()
    PlayerSkinMgr.IsInit = false
    PlayerSkinMgr.PlayerSkinData = {}
    LuaMgr.RemoveTimer(TimerConst.MainPageSkinChangeInterval)
end