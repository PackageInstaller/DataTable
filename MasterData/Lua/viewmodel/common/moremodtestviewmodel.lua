local this = {
    vm = nil,
    data = {
        dungeonGroupList = {},
        dungeonGroupCfg = {},
        dungeonId = "",
        selectLawList = {},
    },
}
local data = {
    lawList = { {
                    lawIcon = DefaultTexture,
                    isFixLaw = false,
                    isExpendLaw = false,
                    lawInfo = "",
                    lawName= "",
                    isTypeA = false;
                    isTypeB = false;
                    isTypeC = false;
                    isOn = false;
                    lawId = "";
                    textAnchorPos=Vector2(0,0);
                    selectScale = Vector3.one;
                },
    },
    pop_isActive=false;
    pop_Icon=DefaultTexture;
    pop_isFix=false;
    pop_isExpend=false;
    pop_name="";
    pop_des="";
    pop_contentPos=Vector2(0,0);
    contentPos=Vector2(0,0);
}

local command = {
    enterBattleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local extraList={};
            table.insert(extraList,"moremod");
            table.insert(extraList,this.data.dungeonGroupCfg.Id);
            for i,v in ipairs(this.data.selectLawList) do
                table.insert(extraList, v);
            end

            local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
            enterDungeonParams.eventId = this.data.dungeonId
            enterDungeonParams.dungeonId = this.data.dungeonId
            enterDungeonParams.extraParams = extraList
            enterDungeonParams.battleType = "moreMod"
            enterDungeonParams.isleveling=this.data.dungeonGroupCfg.DevelopSwitch~=0;
            BattlePrepareMgr.isLeveling_teaching= false
            BattlePrepareMgr.isLeveling_test = true
            BattlePrepareMgr.BattlePrepare(enterDungeonParams, {"AreaSqualEntryViewModel"})
            LuaMgr.HidePanel(UIName.MoreModTestViewModel)
        end
    },
    onDungeonGroupValueChanged = {
        type = XLuaCommandType.Int,
        execute = function(vm, value, param)
            local dungeonGroupCfg = this.cfgmoreModMap[this.data.dungeonGroupList[value + 1]]
            this.data.dungeonGroupCfg = dungeonGroupCfg
            this.UpdateDungeonDropDownList(dungeonGroupCfg.DungeonIDs)
        end
    },
    onDungeonValueChanged = {
        type = XLuaCommandType.Int,
        execute = function(vm, value, param)
            this.data.dungeonId = this.data.dungeonGroupCfg.DungeonIDs[value + 1]
        end
    },
    expendBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            local law=this.vm.data.lawList[index];
            if not law.isOn then
                this.vm.data.lawList[index].isOn=true;
                table.insert(this.data.selectLawList, law.lawId)
            else
                this.vm.data.lawList[index].isOn=false;
                for i = #this.data.selectLawList, 1 do
                    if this.data.selectLawList[i] == law.lawId then
                        table.remove(this.data.selectLawList, i)
                    end
                end
            end
        end
    },
    detailsFixBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local law=this.vm.data.lawList[index];
            this.vm.data.pop_contentPos=Vector2(0,0);
            this.vm.data.pop_isActive=true;
            this.vm.data.pop_Icon=law.lawIcon;
            this.vm.data.pop_isFix=law.isFixLaw;
            this.vm.data.pop_isExpend=law.isExpendLaw;
            this.vm.data.pop_name=law.lawName;
            this.vm.data.pop_des=law.lawInfo;
        end
    },
    closePopBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.pop_isActive=false;
        end
    },
    CloseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, value, param)
            LuaMgr.HidePanel(UIName.MoreModTestViewModel)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.cfgmoreModLawMap=ConfigMgr.Config.moreModLawMap;
        this.cfgmoreModMap=ConfigMgr.Config.moreModMap;
        
        this.Init()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.Init = function()
    local uiLink = this.vm.behaviour.gameObject:GetComponent("UILink");
    this.dropDownDungeonGroupList= uiLink:Get("dropDownDungeonGroup"):GetComponent("Dropdown");
    this.dropDownDungeonList= uiLink:Get("dropDownDungeon"):GetComponent("Dropdown");
    this.InitDropDownDungeonGroupList()
    this.InitLawList()
end

this.InitDropDownDungeonGroupList = function()
    this.dropDownDungeonGroupList:ClearOptions();
    this.dropDownDungeonGroupList.value=0;
    this.data.dungeonGroupList = {}
    local list={};
    local moremodList = {}
    for key, value in pairs(this.cfgmoreModMap) do
        table.insert(moremodList, value)
    end
    table.sort(moremodList, function(a, b) return a.Id < b.Id end)
    for i, v in ipairs(moremodList) do
        if v.DungeonIDs ~= nil and #v.DungeonIDs > 0 then
            table.insert(this.data.dungeonGroupList, v.Id)
            table.insert(list, string.format("%s | %s", LuaMgr.GetLangText(v.NameTextLan), LuaMgr.GetLangText(v.NameSuffixLan)))
        end
    end
    LuaMgr.AddOptionalOnDropDown(this.dropDownDungeonGroupList, list);
    this.data.dungeonGroupCfg = this.cfgmoreModMap[this.data.dungeonGroupList[1]]
    this.UpdateDungeonDropDownList(this.data.dungeonGroupCfg.DungeonIDs)
end

this.InitLawList = function()
    this.vm.data.lawList = {}
    this.data.selectLawList = {}
    local list={};
    local lawSortList = {}
    for i, v in pairs(this.cfgmoreModLawMap) do
        table.insert(lawSortList, v)
    end
    table.sort(lawSortList, function(a, b) return a.Id < b.Id end)
    for i, cfglaw in ipairs(lawSortList) do
        local lawInfo= {
            lawIcon = LuaMgr.GetTexture("Assets/_BundleResources/Images/MoreModIcon/" .. cfglaw.LawICON .. ".png"),
            isFixLaw = false,
            isExpendLaw = false,
            lawInfo = LuaMgr.GetLangText(cfglaw.TextLan),
            lawName=LuaMgr.GetLangText(cfglaw.LawNameLan),
            isTypeA = false;
            isTypeB = false;
            isTypeC = false;
            isOn = false;
            lawId = cfglaw.Id;
            textAnchorPos = Vector2(0,0);
            selectScale = Vector3.one;
        }
        table.insert(list,lawInfo);
    end
    this.vm.data.lawList = list
end

this.UpdateDungeonDropDownList = function(dungeonIds)
    this.dropDownDungeonList:ClearOptions();
    this.dropDownDungeonList.value=0;
    this.data.dungeonId = this.data.dungeonGroupCfg.DungeonIDs[1]
    LuaMgr.AddOptionalOnDropDown(this.dropDownDungeonList, dungeonIds);
end

return vm({
    data = data,
    command = command,
    hook = hook
})