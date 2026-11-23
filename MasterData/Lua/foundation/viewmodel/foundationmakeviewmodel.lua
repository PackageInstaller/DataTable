local this = {
    vm = nil,
    num = 0,
    maxNum = 0,
    interaction = nil,
    heroCount = 0,
    groupMap = nil,
    groupList = nil,
    formulaList = nil,
    groupIndex = 0,
    itemIndex = 0,
    formulaId = "",
    color1 = UnityEngine.Color(38/255.0,36/255.0,41/255.0,1),
    color2 = UnityEngine.Color(21/255.0,21/255.0,22/255.0,1),
    timeColor1 = UnityEngine.Color(215/255.0,209/255.0,195/255.0,1),
    timeColor2 = UnityEngine.Color(178/255.0,171/255.0,158/255.0,1),
}

local data = {
    isScroll = false,
    contentPos = Vector2.zero,
    groupName = "",
    isGroup = false,
    groupArrow = Vector3.one,
    groupList = {{group=1,groupName="",isSelect=false}},
    itemList = {{formulaId="",itemName="",desc="",time="",color=this.color2,timeColor=this.timeColor2,itemBg=DefaultSprite,timeBg=DefaultSprite,isLock=false,lockTips="",goods={id="0",count="0",sizeDelta=Vector2.zero,isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3.zero,isClick=true}}},
    consumeList = {{id="",icon=DefaultTexture,count="",isAdd=false,isArrow=false}},
    heroList = {{heroId="",heroIcon=DefaultTexture,isIcon=false,isAdd=false}},
    makeNum = "",
    consumeHour = "",
    consumeMinute = "",
    consumeSecond = "",
    isMakeItem = false,
    makeItem = {id="0",count="0",sizeDelta=Vector2.zero,isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3.zero,isClick=true};
    makeTime = "",
    isStopWork = false,
    isAuto = false,
    aniName = "",
    warning = false,
    warningPos = Vector3.zero,
}


this.InitData = function()
    this.groupMap = {};
    this.formulaList = {};
    local id = this.vm.behaviour.Params[0];
    this.interaction = ConfigFoundationMgr.GetInteractionById(id);
    if (this.interaction == nil) then
        this.interaction = PlayerFoundationMgr.GetBuildingConfigByGroup(id);
    end
    if (this.interaction == nil) then return end
    
    local yieldsItem = this.interaction.YieldsItem;
    local formulaMap = ConfigMgr.Config.FormulaMap;
    for _, v in pairs(formulaMap) do
        if (v.RecipeGroup == yieldsItem) then
            local obj = this.groupMap[v.Group];
            if (obj == nil) then
                obj = {group = v.Group, name = LuaMgr.GetLangText(v.GroupNameLan)};
                this.groupMap[v.Group] = obj;
            end
            table.insert(this.formulaList, v);
        end
    end
    table.sort(this.formulaList, this.FormulaSort);
end


this.FormulaSort = function(a, b)
    return a.Order < b.Order;
end


this.IsShowItem = function()
    local itemId = PlayerItemMgr.GetTipsItem();
    if (not IsNullOrEmpty(itemId)) then
        local vmName = PlayerItemMgr.GetVMName();
        if (vmName == UIName.FoundationMakeViewModel) then
            FoundationMgr.SetMakeId(itemId);
        end
        return true;
    end
    return false;
end


this.SetItemPos = function()
    local itemId = FoundationMgr.GetMakeId();
    if (IsNullOrEmpty(itemId)) then
        itemId = PlayerItemMgr.GetTipsItem();
        if (IsNullOrEmpty(itemId)) then
            return;
        end
        local vmName = PlayerItemMgr.GetVMName();
        if (vmName ~= UIName.FoundationMakeViewModel) then 
            return;
        end
    end
    PlayerItemMgr.SetTipsItem("");
    local formula;
    local group;
    local groupObj;
    local len = #this.formulaList;
    for i = 1, len do
        formula = this.formulaList[i];
        if (formula.Produce[1].id == itemId) then
            table.remove(this.formulaList, i);
            table.insert(this.formulaList, 1, formula);
            group = formula.Group;
            break;
        end
    end
    len = #this.groupList;
    for i = 1, len do
        groupObj = this.groupList[i];
        if (groupObj.group == group) then
            this.SelectGroup(i);
            break;
        end
    end
end


this.SetGroup = function()
    this.groupList = {};
    for _, v in pairs(this.groupMap) do
        local obj = {group = v.group, groupName = v.name, isSelect = false};
        table.insert(this.groupList, obj);
    end
    this.vm.data.groupList = this.groupList;
    this.groupIndex = 0;
end


this.SelectGroup = function(index)
    if (#this.vm.data.groupList > 0) then
        if (this.groupIndex > 0) then
            this.vm.data.groupList[this.groupIndex].isSelect = false;
        end
        this.vm.data.groupList[index].isSelect = true;
        this.vm.data.groupName = this.vm.data.groupList[index].groupName;
        this.groupIndex = index;
    end
    this.vm.data.isGroup = false;
    this.vm.data.groupArrow = Vector3.one;
end


this.SetItems = function()
    local formula;
    local list = {};
    local items = DataMgr.Player.items;
    local itemMap = ConfigMgr.Config.itemMap;
    this.SetItemPos();
    local group = "";
    local groupData = this.vm.data.groupList[this.groupIndex];
    if (groupData ~= nil) then
        group = groupData.group;
    end
    local len = #this.formulaList;
    for i = 1, len do
        formula = this.formulaList[i];
        if (formula.Group == group) then
            local produce = formula.Produce[1];
            local itemConfig = itemMap[produce.id];
            if (itemConfig ~= nil) then
                local item = items[itemConfig.id];
                local time = PlayerFoundationMgr.CalcTime(this.interaction, this.heroCount, formula.Workload);
                local h, m, s = GetTimeHMS(time);
                local timeStr = string.format("%s:%s:%s", h, m, s);
                local obj = {formulaId=formula.Id, 
                             itemName=string.format("%s*%d", LuaMgr.GetLangText(itemConfig.nameLan), produce.count),
                             desc=LuaMgr.GetLangText(formula.DescriptionLan),
                             color=this.color2,
                             timeColor=this.timeColor2,
                             timeBg=LuaMgr.GetSprite("Foundation", "ui_jj_pic_sjd_02"),
                             time=timeStr,
                             itemBg=LuaMgr.GetSprite("Foundation", "ui_jj_frame_djd_02"),
                             isLock=not formula.Unlock,
                             lockTips=LuaMgr.GetLangText(formula.TipsLan),
                             goods={id=itemConfig.id,
                                    count=tostring(item ~= nil and item.count0 or 0),
                                    sizeDelta=Vector2(100,100),scale=Vector3(0.78,0.78,1),isCount=true,
                                    rare=GetRareSprite(itemConfig.rare),
                                    icon=GetItemTexture(itemConfig.id),
                                    isClick=true}};
                table.insert(list, obj);
            end
        end
    end
    this.vm.data.itemList = list;
    this.SelectItem(this.itemIndex);
end


this.SelectItem = function(index)
    if (#this.vm.data.itemList > 0) then
        if (this.itemIndex > 0) then
            local itemData = this.vm.data.itemList[this.itemIndex];
            itemData.color=this.color2;
            itemData.timeColor=this.timeColor2;
            itemData.itemBg=LuaMgr.GetSprite("Foundation", "ui_jj_frame_djd_02");
            itemData.timeBg=LuaMgr.GetSprite("Foundation", "ui_jj_pic_sjd_02");
        end
        local itemData = this.vm.data.itemList[index];
        if (itemData ~= nil) then
            itemData.color=this.color1;
            itemData.timeColor=this.timeColor1;
            itemData.itemBg=LuaMgr.GetSprite("Foundation", "ui_jj_frame_djd_01");
            itemData.timeBg=LuaMgr.GetSprite("Foundation", "ui_jj_pic_sjd_01");
            this.itemIndex = index;
            this.SetConsume(itemData.formulaId);
        end
    end
end


this.SetConsume = function(formulaId)
    this.formulaId = formulaId;
    local list = {};
    local formula = ConfigMgr.Config.FormulaMap[formulaId];
    if (formula ~= nil and #formula.Produce > 0) then
        local itemConfig;
        local items = DataMgr.Player.items;
        local itemMap = ConfigMgr.Config.itemMap;
        if (not IsNull(formula.Cost)) then
            local costItem;
            local len = #formula.Cost;
            for i = 1, len do
                costItem = formula.Cost[i];
                itemConfig = itemMap[costItem.id];
                if (itemConfig ~= nil) then
                    local item = items[itemConfig.id];
                    local itemCount = item ~= nil and item.count0 or 0;
                    local costCount = costItem.count * this.num;
                    local countStr = "";
                    if (itemCount > costCount) then
                        countStr = string.format("%d/%d", itemCount, costCount);
                    else
                        countStr = string.format("<color=#ff0000>%d</color>/%d", itemCount, costCount);
                    end
                    local obj = {id=itemConfig.id,
                                 icon=GetItemTexture(itemConfig.id),
                                 count=countStr,
                                 isAdd=i < len,
                                 isArrow=false};
                    table.insert(list, obj);
                end
            end
        end
        local produce = formula.Produce[1];
        itemConfig = itemMap[produce.id];
        if (itemConfig ~= nil) then
            local obj = {id=itemConfig.id,
                         icon=GetItemTexture(itemConfig.id),
                         count=tostring(produce.count * this.num),
                         isAdd=false,
                         isArrow=#list > 0};
            table.insert(list, obj);
        end
        this.maxNum = PlayerFoundationMgr.GetFormulaMaxNum(formula);
        this.SetMakeNum();
    end
    this.vm.data.consumeList = list;
end


this.SetMakeNum = function()
    local formula = ConfigMgr.Config.FormulaMap[this.formulaId];
    if (formula ~= nil) then
        local itemData;
        if (not IsNull(formula.Cost)) then
            local costItem;
            local items = DataMgr.Player.items;
            local itemMap = ConfigMgr.Config.itemMap;
            local len = #formula.Cost;
            for i = 1, len do
                itemData = this.vm.data.consumeList[i];
                costItem = formula.Cost[i];
                itemConfig = itemMap[costItem.id];
                if (itemData ~= nil and itemConfig ~= nil) then
                    local item = items[itemConfig.id];
                    local itemCount = item ~= nil and item.count0 or 0;
                    local costCount = costItem.count * this.num;
                    local countStr = "";
                    if (itemCount >= costCount) then
                        countStr = string.format("%d/%d", itemCount, costCount);
                    else
                        countStr = string.format("<color=#ff0000>%d</color>/%d", itemCount, costCount);
                    end
                    itemData.count = countStr;
                end
            end
        end
        local index = #this.vm.data.consumeList;
        itemData = this.vm.data.consumeList[index];
        if (itemData ~= nil) then
            local produce = formula.Produce[1];
            itemData.count = tostring(produce.count * this.num);
        end
        this.vm.data.makeNum = this.num .. "/" .. this.maxNum;
        if (this.heroCount > 0) then
            local time = PlayerFoundationMgr.CalcTime(this.interaction, this.heroCount, formula.Workload * this.num);
            local h, m, s = GetTimeHMS(time);
            this.vm.data.consumeHour = h;
            this.vm.data.consumeMinute = m;
            this.vm.data.consumeSecond = s;
        else
            local str = ConfigMgr.LangGlobal("6962");
            this.vm.data.consumeHour = str;
            this.vm.data.consumeMinute = str;
            this.vm.data.consumeSecond = str;
        end
    end
end


this.SetHeros = function()
    this.heroCount = 0;
    local list = {};
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        local data = interactions[this.interaction.Id];
        if (data ~= nil) then
            local characters = data.Characters;
            if (IsNull(data.Characters)) then
                characters = {};
            else
                this.heroCount = #characters;
            end
            for i = 1, this.interaction.Cap do
                local obj = {};
                if (i <= this.heroCount) then
                    obj.heroId = characters[i];
                    obj.heroIcon = GetCharacterTexture(obj.heroId, obj.heroId .. "001");
                    obj.isIcon = true;
                    obj.isAdd = false;
                else
                    obj.heroId = "";
                    obj.heroIcon = nil;
                    obj.isIcon = false;
                    obj.isAdd = true;
                end
                table.insert(list, obj);
            end
            this.vm.data.warning = this.heroCount < this.interaction.Cap;
            this.vm.data.warningPos = Vector3(-96 + this.heroCount * 96, 0, 0);
        end
    end
    this.vm.data.heroList = list;
end


this.SetMakeItem = function()
    this.vm.data.isMakeItem = false;
    this.vm.data.isStopWork = false;
    this.vm.data.isAuto = false;
    LuaMgr.RemoveTimer(TimerConst.FoundationMakeItemTime);
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        local data = interactions[this.interaction.Id];
        if (data ~= nil and data.Formula ~= "" and data.Count > 0) then
            local formula = ConfigMgr.Config.FormulaMap[data.Formula];
            if (formula ~= nil) then
                local hasCharacter = PlayerFoundationMgr.IsWorkCharacter(this.interaction.Id);
                if (hasCharacter) then
                    local time = PlayerFoundationMgr.GetMakeItemTime(this.interaction, data);
                    if (time > 0) then
                        LuaMgr.AddTimer(TimerConst.FoundationMakeItemTime, this.MakeItemTimer, 1, -1, true);
                    else
                        this.vm.data.makeTime = LuaMgr.GetLangText("FoundationMakeViewModel_20");
                    end
                else
                    this.vm.data.makeTime = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6900"].NameLan);
                    this.vm.data.isStopWork = true;
                end
                local produce = formula.Produce[1];
                local itemConfig = ConfigMgr.Config.itemMap[produce.id];
                if (itemConfig ~= nil) then
                    this.vm.data.makeItem = {id=itemConfig.id,
                                     count=tostring(data.Count),
                                     sizeDelta=Vector2(100,100),scale=Vector3(0.78,0.78,1),isCount=true,
                                     rare=GetRareSprite(itemConfig.rare),
                                     icon=GetItemTexture(itemConfig.id),
                                     isClick=true};
                end
                this.vm.data.isMakeItem = true;
            end
            this.vm.data.isAuto = data.Formula == data.AutoAppendFormula;
        end
    end
end


this.MakeItemTimer = function()
    local interactions = DataMgr.Player.interactions;
    if (interactions ~= nil) then
        local data = interactions[this.interaction.Id];
        if (data ~= nil) then
            local time = PlayerFoundationMgr.GetMakeItemTime(this.interaction, data);
            if (time > 0) then
                local h, m, s = GetTimeHMS(time);
                local timeStr = string.format("%s:%s:%s", h, m, s);
                this.vm.data.makeTime = timeStr;
            else
                this.vm.data.makeTime = LuaMgr.GetLangText("FoundationMakeViewModel_21");
                LuaMgr.RemoveTimer(TimerConst.FoundationMakeItemTime);
            end
        end
    end
end


this.SetScroll = function()
    this.vm.data.isScroll = true;
end


this.OnHeroChoice = function()
    this.SetHeros();
    this.SetItems();
    this.SetMakeItem();
end


this.OnMadeStart = function(isAuto)
    PlayerFoundationMgr.MadeStart(this.interaction.Id, this.formulaId, this.num, isAuto, this.MadeStartResponse);
end


this.MadeStartResponse = function(result)
    this.SetMakeItem();
    this.num = 1;
    this.SetConsume(this.formulaId);
    FoundationBuildingMgr.RefreshBuildingInfo(this.interaction.Id);
end

local command = {
    clickCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if (this.vm.data.isGroup) then
                this.vm.data.isGroup = false;
                this.vm.data.groupArrow = Vector3.one;
            end
        end
    },
    groupCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local isGroup = this.vm.data.isGroup;
            this.vm.data.isGroup = not isGroup;
            if (isGroup) then
                this.vm.data.groupArrow = Vector3.one;
            else
                this.vm.data.groupArrow = Vector3(1, -1, 1);
            end
        end
    },
    groupItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param + 1);
            if (this.groupIndex ~= index) then
                PlayerItemMgr.SetTipsItem("");
                FoundationMgr.SetMakeId(nil);
                this.SelectGroup(index);
                this.itemIndex = 1;
                this.num = 1;
                this.SetItems();
            end
        end
    },
    itemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param + 1);
            if (this.itemIndex ~= index) then
                local itemData = this.vm.data.itemList[index];
                local formula = ConfigMgr.Config.FormulaMap[itemData.formulaId];
                if (formula ~= nil and not formula.Unlock) then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText(formula.TipsLan));
                    return;
                end
                this.num = 1;
                this.SelectItem(index);
            end
        end
    },
    makeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if (not PlayerFoundationMgr.IsWorkCharacter(this.interaction.Id)) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationMakeViewModel_22"));
                return;
            end
            if (not PlayerFoundationMgr.IsConsume(this.formulaId, this.num)) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationMakeViewModel_23"));
                return;
            end
            local isMake = PlayerFoundationMgr.IsMake(this.interaction.Id);
            LuaMgr.ShowLuaPanel(UIName.FoundationMakeConfirmViewModel, this.formulaId, isMake, this.OnMadeStart);
        end
    },
    minCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.num = 1;
            this.SetMakeNum();
        end
    },
    subCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.num = this.num > 1 and this.num - 1 or 1;
            this.SetMakeNum();
        end
    },
    addCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.num = this.num < this.maxNum and this.num + 1 or this.maxNum;
            this.SetMakeNum();
        end
    },
    maxCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.num = this.maxNum;
            this.SetMakeNum();
        end
    },
    addHeroCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local interactions = DataMgr.Player.interactions;
            if (interactions ~= nil) then
                local data = interactions[this.interaction.Id];
                if (data ~= nil) then
                    LuaMgr.ShowLuaPanel(UIName.FoundationHeroChoiceViewModel, this.interaction.Id, data.Characters, this.interaction.Cap);
                end
            end
        end
    },
    consumeItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param + 1);
            local itemData = this.vm.data.consumeList[index];
            if (itemData ~= nil) then
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, itemData.id, true, false, false, 0);
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        vm.data.isScroll = false;
        vm.data.contentPos = Vector2.zero;
        LuaMgr.AddUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
        this.IsShowItem();
        this.InitData();
        this.SetHeros();
        this.SetGroup();
        this.SelectGroup(1);
        this.itemIndex = 1;
        this.num = 1;
        this.SetItems();
        this.SetMakeItem();
        LuaMgr.NextFrame(this.SetScroll);
        this.vm.data.aniName = "UI_FoundationMakePanel";
    end,
    refresh = function(vm)
        if (this.IsShowItem()) then
            vm.data.isScroll = false;
            vm.data.contentPos = Vector2.zero;
            this.itemIndex = 1;
            this.num = 1;
            this.SetItems();
            LuaMgr.NextFrame(this.SetScroll);
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.FoundationMakeItemTime);
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
        this.groupMap = nil;
        this.groupList = nil;
        this.formulaList = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})