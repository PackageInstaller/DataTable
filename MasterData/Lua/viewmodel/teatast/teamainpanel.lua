





local heroIconPath = "Assets/_BundleResources/Character/"
local objectIconPath = "Assets/_BundleResources/Images/Archives/"
local ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_"

local this = {
    vm = nil,
}

local tweener = nil
local CurrentTea_LuaIndex = nil
local SelectTea = nil
local Heroshow
local TeaselectParet
local makingTea = false;
local leftDrinkTeaTimes = 0;

local data = {
    showTeaMessage = false,
    TeaUppos = Vector3.zero,
    NorPos=Vector2.one,
    teaList = {
        {
            itemId = "",
            itemNum = "",
            itemName = "",
            itemNameWeight = Vector2.zero,
            object = false,
            selsect = false,
            unselsect = true,
            already = false,
            itemindex = "",
            teaNumBgAlpha = 1,
            TeaUppos = Vector3.zero,
            TeaDownpos = Vector3.zero,
            stateicon = DefaultSprite,
            teaIcon = DefaultTexture,
            teaFlower = DefaultSprite,
            TeaLastTime = "",
            TeaDescription = "",
            dropIcon = DefaultTexture,
            dropCount = "",
            rewardList = {},
            putCount = "",
        }
    },
    heroList = {
        {
            itemId = "",
            object = false,
            heroIcon = DefaultTexture,
            objectIcon = DefaultTexture,
            already = false,
            heroTrue = Vector3.zero,
            objectTrue = Vector3.zero,
            heroFalse = Vector3.zero,
            heroNot = Vector3.zero,
            heroName = "",
            animationName = "",
            friendlyLevel = "",
        }
    },
}


local command = {
    ClickInitMain = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.vm.data.showTeaMessage then
                LuaMgr.HidePanel(UIName.TeaMainPanel);

                if SelectTea ~= nil then
                    if this.vm.data.TeaUppos.y > 70 then
                        this.MoveSelectTeaPos(0)
                    end

                    SelectTea.selsect = false
                    SelectTea.unselsect = true
                    CurrentTea_LuaIndex = nil
                end
                
            end

            if this.vm.data.showTeaMessage then
                if this.vm.data.TeaUppos.y > 70 then
                    this.MoveSelectTeaPos(0)
                end
                this.vm.data.showTeaMessage = false
            end
        end
    },

    ClickTeaLeavesCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            local lua_Index = param + 1;

            this.vm.data.showTeaMessage = true
            if CurrentTea_LuaIndex ~= nil then
                if CurrentTea_LuaIndex == lua_Index then
                    if this.vm.data.TeaUppos.y > 70 then
                        this.MoveSelectTeaPos(0)
                    else
                        this.MoveSelectTeaPos(1)
                    end
                end
                this.vm.data.teaList[CurrentTea_LuaIndex].selsect = false
                this.vm.data.teaList[CurrentTea_LuaIndex].unselsect = true
                if CurrentTea_LuaIndex ~= lua_Index then
                    this.MoveSelectTeaPos(1)
                    this.changeShowHero(lua_Index)
                end
                this.vm.data.teaList[lua_Index].selsect = true
                this.vm.data.teaList[lua_Index].unselsect = false

                if CurrentTea_LuaIndex ~= lua_Index then
                    CurrentTea_LuaIndex = lua_Index
                end
                SelectTea = this.vm.data.teaList[lua_Index]
                this.HeroViewData()
            else
                if this.vm.data.TeaUppos.y > 70 then
                    this.MoveSelectTeaPos(0)
                else
                    this.MoveSelectTeaPos(1)
                end
                this.vm.data.teaList[lua_Index].selsect = true
                this.vm.data.teaList[lua_Index].unselsect = false
                SelectTea = this.vm.data.teaList[lua_Index]
                CurrentTea_LuaIndex = lua_Index
                this.changeShowHero(lua_Index)
                this.HeroViewData()
            end
        end
    },
    ClickMakeSureTea = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if CurrentTea_LuaIndex == nil and DataMgr.Player.hightea.Deadline == 0 then
                return
            end

            if SelectTea.itemCount <= 0 then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2120"].NameLan))
                return
            end
            
            this.SelectTeaNet()
        end
    },
    onEndEdit = {
        type = XLuaCommandType.String,
        execute = function(vm, value, param)
            local num = 0;
            if value == "" or value == "-" then
                num = 1
            else
                num = tonumber(value);
                local maxNum = this.GetMaxPutTeaCount();
                if num > maxNum then
                    num = maxNum;
                elseif num < 1 then
                    num = 1;
                end
            end
            SelectTea.putCount = num
        end
    },
    minBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            SelectTea.putCount = 1
        end
    },
    maxBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local putCount = this.GetMaxPutTeaCount()
            SelectTea.putCount = putCount > 0 and putCount or 1
        end
    },
    addBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local putCount = tonumber(SelectTea.putCount)
            if putCount < this.GetMaxPutTeaCount() then
                putCount = putCount + 1;
                SelectTea.putCount = putCount
            end
        end
    },
    subtractBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local putCount = tonumber(SelectTea.putCount)
            if putCount > 1 then
                putCount = putCount - 1;
                SelectTea.putCount = putCount
            end
        end
    },
}

this.SelectTeaNet = function()
    local data = {}
    data.Tea = SelectTea.itemId
    data.Total = tonumber(SelectTea.putCount)

    ApiMgr.Request("hightea/put_tea", data, true, function(result)
        local re = json.decode(result)
        SelectTea.selsect = false
        SelectTea.unselsect = true
        local num = this.vm.data.teaList[CurrentTea_LuaIndex].itemCount
        num = num - 1
        this.vm.data.teaList[CurrentTea_LuaIndex].itemCount = num
        local Zero = num > 0
        local Alpha = Zero and 1 or 0.5
        local Color = Zero and "<color=#f6efe1>" or "<color=#c1c0c0>"
        this.vm.data.teaList[CurrentTea_LuaIndex].itemNum =        Color .. (Zero and "x" .. LuaMgr.NumFormat(num) or "x" .. "0") .. "</color>"
        this.vm.data.teaList[CurrentTea_LuaIndex].teaNumBgAlpha = Alpha
        this.MoveSelectTeaPos(0)
        makingTea = true;
        LuaMgr.HidePanel(UIName.TeaMainPanel);
        LuaMgr.InvokeUIEventListeners(UIEventConst.TeaSelectTeaResult,this.vm.data.teaList[CurrentTea_LuaIndex]);
    end,
            nil,
            true
    )
end


this.changeShowHero = function(index)
    local parent = TeaselectParet:Find(tostring(index) .. "/HeroshowPos")
    Heroshow:SetParent(parent, false)
end

this.HeroViewData = function()
    local tempList = {}
    local sysTime = LuaMgr.Timestamp();
    for key, value in pairs(ConfigMgr.Config.highteaCharacterMap) do
        if (ConfigCharacterMgr.IsShow2(key, sysTime)) then
            local hero = {
                itemId = value.ID,
                object = true,
                heroIcon = DefaultTexture,
                objectIcon = DefaultTexture,
                already = false,
                heroTrue = Vector3.zero,
                objectTrue = Vector3.zero,
                heroFalse = Vector3.one,
                heroName = "",
                heroNot = Vector3.zero,
                friendlyLevel = "1",
            }
            local charactersData = DataMgr.Player.characters[value.ID]
            for item, itemvalue in pairs(value.UPTea) do
                if SelectTea.itemId == itemvalue then
                    hero = {
                        itemId = value.ID,
                        object = true,
heroIcon = LuaMgr.GetTexture(heroIconPath .. value.ID .. "/Avatar/" ..value.ID .. "001.png"),
                        objectIcon = LuaMgr.GetTexture(objectIconPath .. "head_" .. value.ID .. ".png"),
                        already = true,
                        heroTrue = Vector3.one,
                        objectTrue = Vector3.zero,
                        heroFalse = Vector3.zero,
                        heroName = value.Name,
                        heroNot = Vector3.one,
                        animationName = "UI_TeaTastSipPanel_HeroMapItem",
                        friendlyLevel = charactersData == nil and "1" or tostring(charactersData.prestigeLevel)
                    }
                    table.insert(tempList, hero)
                end
            end
        end
    end

    table.sort(tempList, function(a, b) return a.itemId < b.itemId end)

    this.vm.data.heroList = tempList
end


this.MoveSelectTeaPos = function(select)
    local pos1 = Vector3(0, 26, 0)
    local pos3 = Vector3(0, 266, 0)
    this.vm.data.NorPos=Vector2.one;
    local StarPos = this.vm.data.TeaUppos ~= nil and this.vm.data.TeaUppos or pos1
    if (tweener ~= nil) then
        tweener:Kill()
    end
    if select == 1 then
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_teachoose.mp3")
        tweener =        DOTWeen.To(
                function()
                    return pos1
                end,
                function(vector)
                    this.vm.data.TeaUppos = vector
                end,
                pos3,
                0.4
        )
        tweener:SetEase(Ease.OutCubic)
    else
        tweener =        DOTWeen.To(
                function()
                    return pos3
                end,
                function(vector)
                    this.vm.data.TeaUppos = vector
                end,
                pos1,
                0.4
        )
        tweener:SetEase(Ease.InQuart)
    end
end



local hook = {
    before_awake = function(vm)
        this.vm = vm
        TeaselectParet = vm.behaviour.transform:Find("root/TeaMainPanel2/BottomPanel/Masks/TeaSelectView/Viewport/Content")
        Heroshow = vm.behaviour.transform:Find("root/TeaMainPanel2/EmptyPoint/SelectTeaHero")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        leftDrinkTeaTimes = vm.behaviour.Params[0];
        
        makingTea = false;
        this.vm.data.showTeaMessage = false
        LuaMgr.InvokeUIEventListeners(UIEventConst.TeaMainPanelState, true, nil);

        this.teaLevelViewData()
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_open.mp3")
        this.ChangeRedPoint()

        if this.vm.data.TeaUppos.y > 70 then
            this.MoveSelectTeaPos(0)
        end
        
    end,
    before_deactive = function(vm)
        
        this.vm.data.showTeaMessage = false
        LuaMgr.InvokeUIEventListeners(UIEventConst.TeaMainPanelState, false, nil);

        if (not makingTea) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, false, nil);
        end
        
        if (tweener ~= nil) then
            tweener:Kill()
        end

        makingTea = false;
    end
}

this.teaLevelViewData = function()
    local teaRoomLevel = PlayerFoundationMgr.GetTeaBuildingLevel()
    local tempList = {}
    local Sortindex = 0
    for key, value in pairs(ConfigMgr.Config.highteaMain) do
        local Teas = {
            itemId = "",
            itemName = "",
            object = true,
            already = false,
            selsect = false,
            unselsect = true,
            TeaUppos = Vector3.zero,
            TeaDownpos = Vector3.one,
            rare = 0
        }
        local Have, num = this.CheckPlayerBackpack(value.ID)
        local Alpha = Have and 1 or 0.5
        local Color = Have and "<color=#f6efe1>" or "<color=#c1c0c0>"
        local Sprite = Have and "ui_pm_tbd_szd" or "ui_pm_tbd_szd2"
        local Name = LuaMgr.GetLangText(ConfigMgr.Config.itemMap[value.ID].nameLan)
        local NameLength = this.getStringLength(Name)
        local nameWeight = NameLength > 3 and Vector2(80, 145) or Vector2(50, 145)
        local ShowName = NameLength > 3 and this.StringToTable(Name, 2, 3) or Name
        Teas = {
            itemId = value.ID,
            itemindex = "",
            itemName = ShowName,
            itemRealName = Name,
            itemNameWeight = nameWeight,
            itemNum = Color .. (Have and "x" .. LuaMgr.NumFormat(num) or "x" .. "0") .. "</color>",
            teaNumBgAlpha = Alpha,
            itemCount = Have and num or 0,
            stateicon = LuaMgr.GetSprite("TeaTastSip", Sprite),
            Order = value.Order,
            object = true,
            already = true,
            selsect = false,
            unselsect = true,
            TeaUppos = Vector3.one,
            TeaDownpos = Vector3.zero,
            teaIcon = LuaMgr.GetTexture(ITEM_ICON_PATH .. key .. ".png"),
            teaFlower = LuaMgr.GetSprite("TeaTastSip", "ui_pm_tea_" .. value.ID),
            TeaLastTime = "",
            TeaDescription = "",
            putCount = "1",
        }

        local Time, Desc = this.ShowTeaMessage(Teas, teaRoomLevel)
        Teas.TeaLastTime = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2123"].NameLan) .. LuaMgr.GetLangText("TeaTastSipViewModel_3") .. Time
        Teas.TeaDescription = string.format("<color=#FFFFFF00>%s</color>", LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2115"].NameLan)) .. Desc

        local NetResultTea=  DataMgr.Player.hightea.Tea;
        if NetResultTea ~= nil and DataMgr.Player.hightea.Stage ~= 0 then
            if value.ID == NetResultTea then
                SelectTea = Teas
                CurrentTea_LuaIndex = nil
            end
        end
        table.insert(tempList, Teas)
    end


    table.sort(tempList,
            function(a, b)
                if a.itemCount == b.itemCount then
                    return a.Order > b.Order
                else
                    return a.itemCount > b.itemCount
                end
            end
    )
    
    for index, value in ipairs(tempList) do
        Sortindex = Sortindex + 1
        value.itemindex = tostring(Sortindex)
    end


    this.vm.data.teaList = tempList
end

this.ChangeRedPoint = function()
    local ClickTeaTimesamp = UnityEngine.PlayerPrefs.GetString(DataMgr.Player.uid .. "teaLevelHave")
    RedMgr.Singleton:UpdateClientRedData("1077", 0)
    RedMgr.Singleton:Refresh()
    local uid = DataMgr.Player.uid
    local morning, night = FoundationCharacterMgr.MorningAndNight()
    local Tomorrow = morning + 24 * 3600
    if ClickTeaTimesamp == "" or tonumber(ClickTeaTimesamp) <= LuaMgr.Timestamp() then
        UnityEngine.PlayerPrefs.SetString(uid .. "teaLevelHave", tostring(Tomorrow))
    else
        return
    end
end

this.CheckPlayerBackpack = function(itemID)
    local have = false
    local num = 0
    if DataMgr.Player.items[itemID] ~= nil then
        have = true
        num = DataMgr.Player.items[itemID].count0
    else
        have = false
    end
    return have, num
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


this.StringToTable = function(str, index, needindex)
    local tb = {}
    local resultStr = ""
    for utfChar in string.gmatch(str, "[%z-\127\194-\244][\128-\191]*") do
        table.insert(tb, utfChar)
    end
    for index, value in ipairs(tb) do
        resultStr = resultStr .. value
        if index == 2 then
            resultStr = resultStr .. "\n"
        end

    end
    return resultStr
end

this.ShowTeaMessage = function(tabs, level)
    local Description = LuaMgr.GetLangText(ConfigMgr.Config.itemMap[tabs.itemId].DescriptionLan)
    local Time = ConfigMgr.Config.highteaMain[tabs.itemId].SpendTimes[level]
    local TimeShow = ""
    local line = math.modf(Time / 60)
    local mod = math.fmod(Time, 60)
    TimeShow =    (line < 10 and "0" .. tostring(line) or tostring(line)) ..
            LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2121"].NameLan) ..
            (mod < 10 and "0" .. tostring(mod) or tostring(mod)) ..
            LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2122"].NameLan)

    return TimeShow, Description
end


this.morningAndNight = function()
    local os_time = os.time
    local str = os.date("%Y-%m-%d", LuaMgr.Timestamp())
    local early_morning = { hour = 0, min = 0, sec = 0 }
    local midnight = { hour = 23, min = 59, sec = 59 }
    string.gsub(
            str,
            "(%d+)-(%d+)-(%d+)",
            function(year, month, day)
                midnight["year"] = year
                early_morning["year"] = year
                midnight["month"] = month
                early_morning["month"] = month
                midnight["day"] = day
                early_morning["day"] = day
            end
    )
    return os_time(early_morning), os_time(midnight)
end

this.GetMaxPutTeaCount = function()
    return leftDrinkTeaTimes
end

return vm(
{
    data = data,
    command = command,
    hook = hook
}
)