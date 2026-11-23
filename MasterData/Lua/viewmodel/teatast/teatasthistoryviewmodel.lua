



local this = { vm = nil }
local heroIconPath = "Assets/_BundleResources/Character/"
local teaHistorySort = true
local HistroyRotaSelect
local CurrentHistorySelect

local SortParentTable
local closeFunction
local data = {
    HistoryTotol = "",
    HistoryInverted = "",
    HistoryLevel = "",
    TimeSort = true,
    LevelSort = false,
    UnTimeSort = false,
    UnLevelSort = true,
    rowUp = true,
    rowDown = false,
    HistroryList = {
        {
            itemId = "",
            sliderValue = 0.0,
            goodOpinionLevel = "",
            heroIcon = DefaultTexture,
            LevelBg = DefaultSprite,
            prestigeTag = "",
            heroName = "",
            levelNum = "",
            haveHero = false,
            notHaveTip = ""
        }
    }
}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeaTastHistoryViewModel)
        end
    },
    TimeListSort = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.selectItemRank(param)
        end
    },
    LevelListSort = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.selectItemRank(param)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            closeFunction = vm.behaviour.Params[0]
            HistroyRotaSelect = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. "HistorySort")
            CurrentHistorySelect = tostring(HistroyRotaSelect)
            this.DrinkHistoryViewData()
            this.vm.data.HistoryTotol = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2272"].NameLan) .. tostring(#this.vm.data.HistroryList)
            this.vm.data.HistoryInverted = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2273"].NameLan)
            this.vm.data.HistoryLevel = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2274"].NameLan)

        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            closeFunction()
        end
    end
}
this.selectItemRank = function(param)
    if CurrentHistorySelect == nil then
        CurrentHistorySelect = param
    else
        if CurrentHistorySelect == param then
            if HistroyRotaSelect == 0 then
                CurrentHistorySelect = "1"
            elseif HistroyRotaSelect == 1 then
                CurrentHistorySelect = "0"
            elseif HistroyRotaSelect == 2 then
                CurrentHistorySelect = "3"
            elseif HistroyRotaSelect == 3 then
                CurrentHistorySelect = "2"
            end
        else
            CurrentHistorySelect = param
        end
    end
    HistroyRotaSelect = tonumber(CurrentHistorySelect)
    if SortParentTable ~= nil then
        this.vm.data.HistroryList = {}
        local sortTable = this.teaListHistorySort(SortParentTable)
        this.vm.data.HistroryList = sortTable
        this.showStateFunction()
    end
    UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. "HistorySort", HistroyRotaSelect)
end

this.showStateFunction = function()
    if HistroyRotaSelect <= 1 then
        this.vm.data.TimeSort = true
        this.vm.data.UnTimeSort = false
        this.vm.data.LevelSort = false
        this.vm.data.UnLevelSort = true
    else
        this.vm.data.LevelSort = true
        this.vm.data.UnLevelSort = false
        this.vm.data.TimeSort = false
        this.vm.data.UnTimeSort = true
    end
end

this.DrinkHistoryViewData = function()
    this.showStateFunction()
    local tempList = {}
    local highteaChars = DataMgr.Player.highteaChars
    local TeaHeroMessage = {}
    for key, value in pairs(highteaChars) do
        local HeroMessage = {
            Herokey = key,
            prestige = nil,
            times = value,
            prestigeLevel = nil,
            nextLeveSlider = 0,
            underprestige = 0,
            nextprestige = 0,
            nextLevelNeed = 0,
            haveHero = false,
            levelNum = 0,
            tag = "",
            maxLevel = false
        }
        local CharacterMessage = DataMgr.Player.characters[key]
        if CharacterMessage ~= nil then
            HeroMessage.prestige = CharacterMessage.prestige
            HeroMessage.prestigeLevel = CharacterMessage.prestigeLevel
            HeroMessage.haveHero = true
        else
            HeroMessage.prestige = DataMgr.Player.prestigeStore[key]
            HeroMessage.haveHero = false
        end

        table.insert(TeaHeroMessage, HeroMessage)
    end
    local friendShipNeed = {}
    for key, value in pairs(ConfigMgr.Config.friendshipLevelUp) do
        local NeedCall = {keys = key, needvale = value, tag = ""}
        table.insert(friendShipNeed, NeedCall)
    end
    for index, value in pairs(friendShipNeed) do
        local Tags = LuaMgr.GetLangText(ConfigMgr.Config.friendshipDescription[value.keys].descriptionLan)
        value.tag = Tags
    end
    table.sort(
            friendShipNeed,
            function(a, b)
                return tonumber(a.needvale) > tonumber(b.needvale)
            end
    )
    SortParentTable = {}
    for key, value in pairs(TeaHeroMessage) do
        local prestigeurrent = tonumber(value.prestige)
        local LevelNum
        local ChangeTage
        for index, friendshipvalue in ipairs(friendShipNeed) do
            local friendshipvalueNeed = tonumber(friendshipvalue.needvale)
            if prestigeurrent >= friendshipvalueNeed then
                LevelNum = friendshipvalueNeed >= value.underprestige and friendshipvalue.keys or LevelNum
                value.tag = friendshipvalueNeed >= value.underprestige and friendshipvalue.tag or value.tag
                value.underprestige =
                friendshipvalueNeed > value.underprestige and friendshipvalueNeed or value.underprestige
                value.prestigeLevel = value.prestigeLevel == nil and friendshipvalue.keys or value.prestigeLevel
                if value.prestigeLevel == #friendShipNeed then
                    value.nextprestige = value.underprestige
                end
            end
            if prestigeurrent < friendshipvalueNeed then
                value.nextprestige = friendshipvalue.needvale
            end
            value.nextLevelNeed = value.nextprestige - prestigeurrent
        end

        if value.haveHero then
            LevelNum=tostring(value.prestigeLevel);
            ChangeTage= ConfigCharacterMgr.GetFriendlyText(value.prestigeLevel)
            if value.prestigeLevel>=10 then
                value.nextLeveSlider = 1.0
                value.maxLevel = true
            else

                local levelExp = ConfigMgr.Config.friendshipLevelUp[tostring(value.prestigeLevel+1)]

                local beforeLevelExp = this.GetBeforeAllExp(value.prestigeLevel)
                local barvalue= (value.prestige - beforeLevelExp) / levelExp
                value.nextLeveSlider = barvalue
            end
        else
            ChangeTage = this.InsertBlankInStr(value.tag)
            if value.nextprestige == value.underprestige then
                value.nextLeveSlider = 1.0
                value.maxLevel = true
            else
                value.nextLeveSlider =
                (value.nextprestige - prestigeurrent <= 0 or prestigeurrent <= 0) and 0.0 or
                        1 - (value.nextprestige - prestigeurrent) / (value.nextprestige - value.underprestige)
            end
        end

        local hero = {
            itemId = value.Herokey,
            heroName = LuaMgr.GetLangText(ConfigMgr.Config.characterTable[value.Herokey].namelan),
            prestigeTag = ChangeTage,
            sliderValue = value.nextLeveSlider,
            goodOpinionLevel = LuaMgr.GetLangText("TeaTastSipViewModel_0"),
            nextLevelNeed = value.nextLevelNeed,
            times = value.times,
            levelNum = LevelNum,
            haveHero = not value.haveHero,
            notHaveTip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2275"].NameLan),
            LevelBg = LuaMgr.GetSprite("TeaTastSip", value.maxLevel and "ui_pm_lvmax" or "ui_pm_lv"),
            heroIcon = LuaMgr.GetTexture(heroIconPath .. value.Herokey .. "/Avatar/" ..HeroManager.GetCharacterSkin(value.Herokey)  .. ".png")
        }

        table.insert(SortParentTable, hero)
        table.insert(tempList, hero)
    end
    tempList = this.teaListHistorySort(tempList)
    this.vm.data.HistroryList = tempList
end


this.GetBeforeAllExp = function(level)
    local exp = 0
    for i = 1, level do
        exp = exp + ConfigMgr.Config.friendshipLevelUp[tostring(i)]
    end
    return exp
end

this.InsertBlankInStr = function(str)
    local length = this.getStringLength(str)
    if length <= 2 then
        local Str1 = LuaMgr.Substring(str, 1)
        local _, Length2 = string.gsub(str, Str1, Str1 .. "  ")
        return _
    else
        return str
    end

end

this.getStringLength = function(inputstr)
    if not inputstr or type(inputstr) ~= "string" or #inputstr <= 0 then
        return nil
    end
    local length = 0 
    local i = 1
    while true do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1
        if curByte > 239 then
            byteCount = 4 
        elseif curByte > 223 then
            byteCount = 3 
        elseif curByte > 128 then
            byteCount = 2 
        else
            byteCount = 1 
        end
        i = i + byteCount
        length = length + 1
        if i > #inputstr then
            break
        end
    end
    return length
end

this.teaListHistorySort = function(tempList)
    if HistroyRotaSelect > 1 then
        this.vm.data.rowDown = HistroyRotaSelect == 2
        this.vm.data.rowUp = HistroyRotaSelect == 3
    else
        this.vm.data.rowDown = HistroyRotaSelect == 0
        this.vm.data.rowUp = HistroyRotaSelect == 1
    end
    table.sort(
        tempList,
        function(a, b)
            if HistroyRotaSelect > 1 then
                if tonumber(a.levelNum) == tonumber(b.levelNum) then
                    if a.sliderValue == b.sliderValue then
                        return a.times > b.times
                    else
                        if HistroyRotaSelect == 2 then
                            return a.sliderValue > b.sliderValue
                        elseif HistroyRotaSelect == 3 then
                            return a.sliderValue < b.sliderValue
                        end
                    end
                else
                    if HistroyRotaSelect == 2 then
                        return tonumber(a.levelNum) > tonumber(b.levelNum)
                    elseif HistroyRotaSelect == 3 then
                        return tonumber(a.levelNum) < tonumber(b.levelNum)
                    end
                end
            else
                if HistroyRotaSelect == 0 then
                    return a.times > b.times
                elseif HistroyRotaSelect == 1 then
                    return a.times < b.times
                end
            end
        end
    )
    return tempList
end
return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)