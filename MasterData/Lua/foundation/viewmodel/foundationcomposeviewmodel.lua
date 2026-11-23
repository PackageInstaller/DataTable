local this = {
    vm = nil,
    num = 0,
    maxNum = 0,
    interaction = nil,
    groupMap = nil,
    groupList = nil,
    formulaList = nil,
    groupIndex = 0,
    itemIndex = 0,
    formulaId = "",
    posList = {Vector3(5, 202, 0), Vector3(-162, -105, 0), Vector3(170, -105, 0), Vector3(5, 0, 0)},
    changePosList = {Vector3(71, 20, 0), Vector3(-77, 40, 0), Vector3(71, 40, 0), Vector3(0, 0, 0)},
    color1 = UnityEngine.Color(38/255.0,36/255.0,41/255.0,1),
    color2 = UnityEngine.Color(21/255.0,21/255.0,22/255.0,1),
    resultRewards = nil,
    targetGoodsTF = nil,
    targetGoods = nil,
}

local data = {
    isScroll = false,
    contentPos = Vector2.zero,
    groupName = "",
    isGroup = false,
    groupArrow = Vector3.one,
    groupList = {{group=1,groupName="",isSelect=false}},
    itemList = {{formulaId="",itemName="",desc="",color=this.color2,itemBg=DefaultSprite,isLock=false,lockTips="",goods={id="0",count="0",sizeDelta=Vector2.zero,isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3.zero,isClick=true}}},
    consumeList = {{id="",icon=DefaultTexture,isIcon=false,isAdd=false,isAdd2=false,isChange=false,count="",countPos=Vector3.zero,pos=Vector3.zero,changePos=Vector3.zero}},
    composeNum = "",
    aniName = "",
    isSynthesis = false,
    isConsumeList = false,
    isTarget = false,
    targetNum = "",
    isNumGroup = false,
    isClearBtn = false,
    isComposeLock = false,
    isTips = false,
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
        if (vmName == UIName.FoundationComposeViewModel) then
            FoundationMgr.SetComposeId(itemId);
        end
        return true;
    end
    return false;
end


this.SetItemPos = function()
    local itemId = FoundationMgr.GetComposeId();
    if (IsNullOrEmpty(itemId)) then
        itemId = PlayerItemMgr.GetTipsItem();
        if (IsNullOrEmpty(itemId)) then
            return;
        end
        local vmName = PlayerItemMgr.GetVMName();
        if (vmName ~= UIName.FoundationComposeViewModel) then
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


this.SetTarget = function()
    local itemId = PlayerItemMgr.GetTipsItem();
    if (not IsNullOrEmpty(itemId)) then
        local vmName = PlayerItemMgr.GetVMName();
        if (vmName == UIName.FoundationComposeViewModel) then
            local needCount = PlayerItemMgr.GetNeedCount();
            local itemCount = PlayerItemMgr.GetItemCountById(itemId);
            if (needCount > itemCount) then
                needCount = needCount - itemCount;
                if (this.targetGoods == nil) then
                    this.targetGoods = GoodsDataItem.New(this.targetGoodsTF);
                end
                local itemData = table.Copy(ConfigMgr.Config.itemMap[itemId]);
                itemData.count0 = needCount;
                this.targetGoods:SetData(1, itemData, 1, false, Vector3(0.3, 0.3, 1), nil, true);
                this.vm.data.targetNum = "X" .. tostring(needCount);
                this.vm.data.isTarget = true;
                return;
            end
        end
    end
    this.ClearTarget();
end


this.ClearTarget = function()
    if (this.targetGoods ~= nil) then
        this.targetGoods:Hide();
    end
    this.vm.data.isTarget = false;
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
    this.SetTarget();
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
                local obj = {formulaId=formula.Id, 
                             itemName=string.format("%s*%d", LuaMgr.GetLangText(itemConfig.nameLan), produce.count),
                             desc=LuaMgr.GetLangText(formula.DescriptionLan),
                             color=this.color2,
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


this.UpdateItemList = function()
    local items = DataMgr.Player.items;
    local len = #this.vm.data.itemList;
    for i = 1, len do
        local itemData = this.vm.data.itemList[i];
        local item = items[itemData.goods.id];
        itemData.goods.count = tostring(item ~= nil and item.count0 or 0);
    end
end


this.SelectItem = function(index)
    if (#this.vm.data.itemList > 0) then
        if (this.itemIndex > 0) then
            local itemData = this.vm.data.itemList[this.itemIndex];
            itemData.color = this.color2;
            itemData.itemBg=LuaMgr.GetSprite("Foundation", "ui_jj_frame_djd_02");
        end
        local itemData = this.vm.data.itemList[index];
        if (itemData ~= nil) then
            itemData.color = this.color1;
            itemData.itemBg=LuaMgr.GetSprite("Foundation", "ui_jj_frame_djd_01");
            this.itemIndex = index;
            PlayerFoundationMgr.SetComposeChoices(nil);
            this.SetConsume(itemData.formulaId);
        end
    end
end


this.SetConsume = function(formulaId)
    this.formulaId = formulaId;
    FoundationMgr.SetComposeFormula(formulaId);
    local list = {};
    local plen = #this.posList;
    for i = 1, plen do
        table.insert(list, {icon=nil,isIcon=false,isAdd=true,isAdd2=false,isChange=false,count="",
                            countPos=Vector3(4,-49,0),pos=this.posList[i],changePos=this.changePosList[i]});
    end
    local formula = ConfigMgr.Config.FormulaMap[formulaId];
    if (formula ~= nil and #formula.Produce > 0) then
        local itemConfig;
        local costItem;
        local itemData;
        local consumeIndex = 1;
        local items = DataMgr.Player.items;
        local itemMap = ConfigMgr.Config.itemMap;
        if (not IsNull(formula.Cost)) then
            local len = #formula.Cost;
            for i = 1, len do
                costItem = formula.Cost[i];
                itemConfig = itemMap[costItem.id];
                if (itemConfig ~= nil) then
                    itemData = list[consumeIndex];
                    consumeIndex = consumeIndex + 1;
                    itemData.id=itemConfig.id;
                    local item = items[itemConfig.id];
                    local itemCount = item ~= nil and item.count0 or 0;
                    local costCount = costItem.count * this.num;
                    local countStr = "";
                    if (itemCount >= costCount) then
                        countStr = string.format("%d/%d", itemCount, costCount);
                    else
                        countStr = string.format("<color=#ff0000>%d</color>/%d", itemCount, costCount);
                    end
                    itemData.rare=GetRareSprite(itemConfig.rare);
                    itemData.icon=GetItemTexture(itemConfig.id);
                    itemData.isIcon=true;
                    itemData.isAdd=false;
                    itemData.count=countStr;
                end
            end
        end
        if (formula.CostRequire > 0) then
            local composeChoices = PlayerFoundationMgr.GetComposeChoices();
            local len = #composeChoices;
            for i = 1, len do
                local index = PlayerFoundationMgr.GetCostSelectIndex(formula, composeChoices[i]);
                costItem = formula.CostSelect[index];
                itemConfig = itemMap[costItem.id];
                if (itemConfig ~= nil) then
                    itemData = list[consumeIndex];
                    consumeIndex = consumeIndex + 1;
                    itemData.id=itemConfig.id;
                    local item = items[itemConfig.id];
                    local itemCount = item ~= nil and item.count0 or 0;
                    local costCount = costItem.count * this.num;
                    local countStr = "";
                    if (itemCount >= costCount) then
                        countStr = string.format("%d/%d", itemCount, costCount);
                    else
                        countStr = string.format("<color=#ff0000>%d</color>/%d", itemCount, costCount);
                    end
                    itemData.rare=GetRareSprite(itemConfig.rare);
                    itemData.icon=GetItemTexture(itemConfig.id);
                    itemData.isIcon=true;
                    itemData.isAdd=false;
                    itemData.isAdd2=false;
                    itemData.isChange=true;
                    itemData.count=countStr;
                end
            end
        end
        local olen = plen - 1;
        for i = formula.CostRequire + consumeIndex, olen do
            itemData = list[i];
            itemData.isAdd = false;
            itemData.isAdd2 = true;
            itemData.isChange = false;
        end
        local produce = formula.Produce[1];
        itemConfig = itemMap[produce.id];
        if (itemConfig ~= nil) then
            itemData = list[plen];
            itemData.id=itemConfig.id;
            itemData.rare=GetRareSprite(itemConfig.rare);
            itemData.icon=GetItemTexture(itemConfig.id);
            itemData.isIcon=true;
            itemData.isAdd=false;
            itemData.isAdd2=false;
            itemData.isChange=false;
            itemData.count=string.format("<color=#ffffff>%d</color>", produce.count * this.num);
            itemData.countPos.x=4;
            itemData.countPos.y=-66;
        end
        this.maxNum = PlayerFoundationMgr.GetFormulaMaxNum(formula);
    end
    this.SetComposeNum();
    this.vm.data.consumeList = list;
    this.CheckComposeChoices();
end


this.CheckComposeChoices = function()
    local formula = ConfigMgr.Config.FormulaMap[this.formulaId];
    if (formula.CostRequire > 0) then
        local composeChoices = PlayerFoundationMgr.GetComposeChoices();
        if (formula.CostRequire == #composeChoices) then
            this.vm.data.isNumGroup = true;
            this.vm.data.isClearBtn = true;
            this.vm.data.isComposeLock = false;
            this.vm.data.isTips = false;
        else
            this.vm.data.isNumGroup = false;
            this.vm.data.isClearBtn = false;
            this.vm.data.isComposeLock = true;
            this.vm.data.isTips = true;
        end
        return;
    end
    this.vm.data.isNumGroup = true;
    this.vm.data.isClearBtn = false;
    this.vm.data.isComposeLock = false;
    this.vm.data.isTips = false;
end


this.GetComposeChoicesIndex = function()
    local formula = ConfigMgr.Config.FormulaMap[this.formulaId];
    if (formula.CostRequire > 0) then
        local composeChoices = PlayerFoundationMgr.GetComposeChoices();
        local len = #composeChoices;
        if (formula.CostRequire == len) then
            local indexs = {};
            for i = 1, len do
                local index = PlayerFoundationMgr.GetCostSelectIndex(formula, composeChoices[i]);
                indexs[i] = index - 1;
            end
            return indexs;
        end
        return nil;
    end
    return {};
end


this.UpdateMaterial = function(args)
    this.UpdateItemList();
    this.SetConsume(this.formulaId);
end


this.SetComposeNum = function()
    local formula = ConfigMgr.Config.FormulaMap[this.formulaId];
    if (formula ~= nil) then
        local itemData;
        local costItem;
        local consumeIndex = 1;
        local items = DataMgr.Player.items;
        local itemMap = ConfigMgr.Config.itemMap;
        if (not IsNull(formula.Cost)) then
            local len = #formula.Cost;
            for i = 1, len do
                itemData = this.vm.data.consumeList[consumeIndex];
                consumeIndex = consumeIndex + 1;
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
        if (formula.CostRequire > 0) then
            local composeChoices = PlayerFoundationMgr.GetComposeChoices();
            local len = #composeChoices;
            for i = 1, len do
                itemData = this.vm.data.consumeList[consumeIndex];
                consumeIndex = consumeIndex + 1;
                local index = PlayerFoundationMgr.GetCostSelectIndex(formula, composeChoices[i]);
                costItem = formula.CostSelect[index];
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
                    itemData.count=countStr;
                end
            end
        end
        local index = #this.vm.data.consumeList;
        itemData = this.vm.data.consumeList[index];
        if (itemData ~= nil) then
            local produce = formula.Produce[1];
            itemData.count = string.format("<color=#ffffff>%d</color>", produce.count * this.num);
        end
        this.vm.data.composeNum = this.num .. "/" .. this.maxNum;
    else
        this.vm.data.composeNum = "0/0";
    end
end


this.SetScroll = function()
    this.vm.data.isScroll = true;
end


this.ComposeResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            this.resultRewards = json.encode(data.result.Rewards);
        end
        LuaMgr.AddTimer(TimerConst.FoundationMakeSynthesisDelay, this.OnSynthesis, 1.5, 1, false);
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/compose_light.mp3");
        this.vm.data.isSynthesis = true;
    end
end


this.OnSynthesis = function()
    this.vm.data.isSynthesis = false;
    this.num = 1;
    this.SetItems();
    this.SetConsume(this.formulaId);
    if (this.resultRewards ~= nil) then
        LuaMgr.ShowItemRewared(this.resultRewards);
        this.resultRewards = nil;
    end
end


this.OnAnimatorPlayFinish = function(args)
    LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
    this.vm.data.isConsumeList = true;
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
                FoundationMgr.SetComposeId(nil);
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
                this.ClearTarget();
            end
        end
    },
    composeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if (not PlayerFoundationMgr.IsConsume(this.formulaId, this.num)) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationComposeViewModel_4"));
                return;
            end
            local costSelectIndex = this.GetComposeChoicesIndex();
            if (costSelectIndex == nil) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6802"].NameLan));
                return;
            end
            PlayerFoundationMgr.Compose(this.interaction.Id, this.formulaId, this.num, costSelectIndex, this.ComposeResponse);
        end
    },
    clearCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            PlayerFoundationMgr.SetComposeChoices(nil);
            this.num = 1;
            this.SetConsume(this.formulaId);
        end
    },
    minCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.num = 1;
            this.SetComposeNum();
        end
    },
    subCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.num = this.num > 1 and this.num - 1 or 1;
            this.SetComposeNum();
        end
    },
    addCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.num = this.num < this.maxNum and this.num + 1 or this.maxNum;
            this.SetComposeNum();
        end
    },
    maxCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.num = this.maxNum;
            this.SetComposeNum();
        end
    },
    OnClickConsume = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param + 1);
            local itemData = this.vm.data.consumeList[index];
            if (itemData ~= nil) then
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, itemData.id, true, false, false, 0);
            end
        end
    },
    consumeAddCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param + 1);
            local itemData = this.vm.data.consumeList[index];
            if (itemData ~= nil) then
                LuaMgr.ShowLuaPanel(UIName.FoundationComposeChoiceViewModel, this.formulaId);
            end
        end
    },
    add2Command = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.num = this.num < this.maxNum-10 and this.num + 10 or this.maxNum;
            this.SetComposeNum();
        end
    },
    sub2Command = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.num = this.num > 10 and this.num - 10 or 1;
            this.SetComposeNum();
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.targetGoodsTF = vm.behaviour.transform:Find("root/Middle/Consume/Target/Goods");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        vm.data.isScroll = false;
        vm.data.contentPos = Vector2.zero;
        PlayerFoundationMgr.SetComposeChoices(nil);
        this.IsShowItem();
        this.InitData();
        this.SetGroup();
        this.SelectGroup(1);
        this.itemIndex = 1;
        this.num = 1;
        this.SetItems();
        LuaMgr.NextFrame(this.SetScroll);
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
        LuaMgr.AddUIEventListener(UIEventConst.PropUse, this.UpdateMaterial);
        this.vm.data.aniName = "UI_FoundationComposePanel";
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/compose_ui.mp3");
        this.vm.data.isSynthesis = false;
        this.vm.data.isConsumeList = false;
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
        LuaMgr.RemoveTimer(TimerConst.FoundationMakeSynthesisDelay);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
        LuaMgr.RemoveUIEventListener(UIEventConst.PropUse, this.UpdateMaterial);
        this.groupMap = nil;
        this.groupList = nil;
        this.formulaList = nil;
        this.ClearTarget();
    end,
    before_destroy = function(vm)
        if (this.targetGoods ~= nil) then
            this.targetGoods:Clear();
            this.targetGoods = nil;
        end
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})