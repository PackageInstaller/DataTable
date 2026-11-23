




local this = {
    vm = nil,
    numInput = nil,
    maxNum = 0,
    num = 0,
    costItemId = "",
    getItemId = "",
    exchangeConfig = ""
}

local data = {
    title = "",
    itemNum1 = "",
    itemName1 = "",
    itemIcon1 = DefaultTexture,
    itemNum2 = "",
    itemName2 = "",
    itemIcon2 = DefaultTexture,
}


this.SetData = function()
    local item1 = ConfigMgr.Config.itemMap[this.getItemId];
    if (item1 ~= nil) then
        local itemName = LuaMgr.GetLangText(item1.nameLan);
        this.vm.data.itemName1 = itemName;
        this.vm.data.itemIcon1 = GetItemTexture(item1.id);
        this.vm.data.title = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2492"].NameLan);
    end
    local item2 = ConfigMgr.Config.itemMap[this.costItemId];
    if (item2 ~= nil) then
        this.vm.data.itemName2 = LuaMgr.GetLangText(item2.nameLan);
        this.vm.data.itemIcon2 = GetItemTexture(item2.id);
    end
    this.SetMaxNum();
    this.SetNum(1);
end


this.SetMaxNum = function()
    local itemCount = LuaMgr.GetItemCountById(this.costItemId);
    if (itemCount > 0) then
        local convertTheBiggest = this.exchangeConfig.ExchangeLimit;
        this.maxNum = itemCount > convertTheBiggest and convertTheBiggest or itemCount;
    else
        this.maxNum = 1;
    end
end


this.SetNum = function(num)
    this.num = num;
    local numStr = tostring(num);
    this.numInput.text = numStr;
    local jadeToDiamond = math.floor(this.exchangeConfig.GetNum / this.exchangeConfig.CostNum)
    this.vm.data.itemNum1 = tostring(num * jadeToDiamond);
    this.vm.data.itemNum2 = numStr;
end


this.OnNumEndEdit = function(value)
    local num = 1;
    if (value ~= "") then
        num = tonumber(value);
        if (num == nil or num < 1) then
            num = 1;
        end
    end
    if (num > this.maxNum) then
        this.SetNum(this.maxNum);
    else
        this.SetNum(num);
    end
end


this.ExchangeResponse = function(result)
    LuaMgr.InvokeUIEventListeners(UIEventConst.PropUse,this.num)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2491"].NameLan));
    LuaMgr.HidePanel(UIName.DiamondExchangeViewModel);
end

local command = {
    OnClickClose = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.DiamondExchangeViewModel);
        end
    },
    OnClickMin = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetNum(1);
        end
    },
    OnClickSub = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetNum(this.num > 1 and this.num - 1 or 1);
        end
    },
    OnClickAdd = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetNum(this.num < this.maxNum and this.num + 1 or this.maxNum);
        end
    },
    OnClickMax = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetNum(this.maxNum);
        end
    },
    OnClickExchange = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local jadeToDiamond = this.exchangeConfig.CostNum * this.num;
            local itemCount = LuaMgr.GetItemCountById(this.costItemId);
            if (itemCount < jadeToDiamond) then
                local confirm = function()
                    LuaMgr.HidePanels();
                    SDKMgr.Singleton:ShowMainShopCharge();
                end
                local cancel = function() end
                local costName = LuaMgr.GetLangText(ConfigMgr.Config.itemMap[this.costItemId].nameLan);
                local msg = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2655"].NameLan), tostring(jadeToDiamond - itemCount), costName);
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, msg, confirm, cancel);
                return;
            end
            ApiMgr.Request("exchange_item", {CostItm = this.costItemId, GetItm = this.getItemId, ExchangeCnt = this.num}, true, this.ExchangeResponse, nil, true, true);
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.numInput = vm.behaviour.transform:Find("root/Middle/Exchange/NumInput"):GetComponent("InputField");
        this.numInput.onEndEdit:AddListener(this.OnNumEndEdit);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.costItemId = vm.behaviour.Params[0];
        this.getItemId = vm.behaviour.Params[1];
        this.exchangeConfig = ConfigItemMgr.GetItemExchangeConfig(string.format("%s_%s", this.costItemId, this.getItemId))
        if this.exchangeConfig == nil then
            LuaMgr.HidePanel(UIName.DiamondExchangeViewModel);
        end
        this.SetData();
    end,
    before_deactive = function(vm)

    end,
}

return vm({
    data = data,
    command = command,
    hook = hook,
})