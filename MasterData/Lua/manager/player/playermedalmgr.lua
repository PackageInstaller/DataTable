





PlayerMedalMgr = {}
PlayerMedalMgr.MedalDisplay = nil
local Coroutine_key = nil

function PlayerMedalMgr.Init()
    PlayerMedalMgr.MedalDisplay = {}
    PlayerMedalMgr.MedalDisplay = table.Copy(DataMgr.Player.MedalDisplay)
end

function PlayerMedalMgr.AddMedal(id)
    if IsNullOrEmpty(id) then return end
    if #PlayerMedalMgr.MedalDisplay >= 9 then
        return
    end
    table.insert(PlayerMedalMgr.MedalDisplay,id)
end

function PlayerMedalMgr.RemoveMedal(id)
    if IsNullOrEmpty(id) then return end
    for i = 1, #PlayerMedalMgr.MedalDisplay do
        if PlayerMedalMgr.MedalDisplay[i] == id then
            table.remove(PlayerMedalMgr.MedalDisplay,i)
            return
        end
    end
end

function PlayerMedalMgr.Contain(id)
    if IsNullOrEmpty(id) then return end
    for i = 1, #PlayerMedalMgr.MedalDisplay do
        if PlayerMedalMgr.MedalDisplay[i] == id then
            return true
        end
    end
    return false
end

function PlayerMedalMgr.Count()
    return #PlayerMedalMgr.MedalDisplay
end

function PlayerMedalMgr.SaveMedalDisplay()
    local tempData = {}
    tempData["MedalIds"] = PlayerMedalMgr.MedalDisplay
    ApiMgr.Request("set_medal", tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            LuaMgr.Back()
        end
    end,nil,true)
end

function PlayerMedalMgr.ClearMedal()
    for i = #PlayerMedalMgr.MedalDisplay, 1, -1 do
        table.remove(PlayerMedalMgr.MedalDisplay, i)
    end
end

function PlayerMedalMgr.CheckMedalPopup(activityKey,title)
    if IsNullOrEmpty(activityKey) and IsNullOrEmpty(title) then
        return
    end
    if TableIsNull(DataMgr.Player.MedalMap) then
        return false
    end
    Coroutine_key = coroutine_runner.start(function()
        for _,value in pairs(DataMgr.Player.MedalMap) do
            if value.Activity == activityKey and value.Status == 0 then
                LuaMgr.ShowLuaPanel(UIName.MedalPopupViewModel,value)
                coroutine_runner.wait(3.8)
            end
        end
        local strKey = nil
        local title = nil
        for key,value in pairs(DataMgr.Player.titleMap) do
            strKey = DataMgr.Player.uid..key
            if not UnityEngine.PlayerPrefs.HasKey(strKey) then
                title = ConfigHelper.GetTitleConfig(key)
                UnityEngine.PlayerPrefs.SetString(strKey)
                LuaMgr.ShowLuaPanel(UIName.MedalPopupViewModel,"",title)
                coroutine_runner.wait(3.8)
            end
        end
        Coroutine_key = nil
    end)
end


function PlayerMedalMgr.Clear()
    if Coroutine_key ~= nil then
        coroutine_runner.stop(Coroutine_key)
    end
    Coroutine_key = nil
    LuaMgr.RemoveTimer(TimerConst.MedalPopupClose)
    LuaMgr.HidePanel(UIName.MedalPopupViewModel)
    PlayerMedalMgr.MedalDisplay = nil
end