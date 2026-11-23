require("Foundation/ViewModel/FoundationComposeChoiceItem")

local this = {
    itemList = {},
    formula = nil,
    composeChoices = nil,
}

local objs = {
    choiceItem = { path = "template/ChoiceItem", type = "GameObject" },
    choiceContent = { path = "root/Middle/Choice/ScrollView/Viewport/Content", type = "RectTransform" },
    cancelBtn = { path = "root/Middle/Choice/Cancel", type = "Button" },
    confirmGO = { path = "root/Middle/Choice/Confirm", type = "GameObject" },
    confirmBtn = { path = "root/Middle/Choice/Confirm", type = "Button" },
    confirmLock = { path = "root/Middle/Choice/ConfirmLock", type = "GameObject" },
    confirmLockBtn = { path = "root/Middle/Choice/ConfirmLock", type = "Button" },
    count = { path = "root/Middle/Choice/Count", type = "Text" },
}


this.InitComposeChoices = function()
    this.composeChoices = {};
    local originComposeChoices = PlayerFoundationMgr.GetComposeChoices();
    local len = #originComposeChoices;
    for i = 1, len do
        this.composeChoices[i] = originComposeChoices[i];
    end
end


this.SetChoiceItem = function(formulaId)
    this.formula = ConfigMgr.Config.FormulaMap[formulaId];
    if (this.formula == nil) then return end
    
    local item;
    local costSelect = this.CostSelectSort(this.formula.CostSelect);
    local len = #costSelect;
    for i = 1, len do
        item = this.itemList[i];
        if (item == nil) then
            item = FoundationComposeChoiceItem.New(this.choiceItem, this.choiceContent);
            this.itemList[i] = item;
        end
        item:SetData(costSelect[i]);
    end
    local len2 = #this.itemList;
    for i = len + 1, len2 do
        item = this.itemList[i];
        if (item ~= nil) then
            item:Clear();
        end
    end
end


this.CostSelectSort = function(costSelect)
    local list = {};
    if (not IsNull(costSelect)) then
        local costItem;
        local list2 = {};
        local len = #costSelect;
        for i = 1, len do
            costItem = costSelect[i];
            if (PlayerItemMgr.GetItemCountById(costItem.id) >= costItem.count) then
                table.insert(list, costItem);
            else
                table.insert(list2, costItem);
            end
        end
        len = #list2;
        for i = 1, len do
            table.insert(list, list2[i]);
        end
    end
    return list;
end


this.DestroyChoiceItem = function()
    local len = #this.itemList;
    for i = 1, len do
        this.itemList[i]:Destroy();
    end
    this.itemList = {};
end


this.SetChoiceCount = function()
    local count = #this.composeChoices;
    this.count.text = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6804"].NameLan), count, this.formula.CostRequire);
    if (count == this.formula.CostRequire) then
        SetActive(this.confirmGO, true);
        SetActive(this.confirmLock, false);
    else
        SetActive(this.confirmGO, false);
        SetActive(this.confirmLock, true);
    end
end


this.OnClickCancel = function()
    LuaMgr.HidePanel(UIName.FoundationComposeChoiceViewModel);
end


this.OnClickConfirm = function()
    local count = #this.composeChoices;
    if (count ~= this.formula.CostRequire) then return end

    PlayerFoundationMgr.SetComposeChoices(this.composeChoices);
    LuaMgr.InvokeUIEventListeners(UIEventConst.PropUse);
    LuaMgr.HidePanel(UIName.FoundationComposeChoiceViewModel);
end


this.OnClickConfirmLock = function()
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6803"].NameLan));
end


this.ComposeChoice = function(id, status)
    if (status) then
        local len = #this.composeChoices;
        for i = 1, len do
            if (this.composeChoices[i] == id) then return end
        end
        table.insert(this.composeChoices, id);
    else
        local len = #this.composeChoices;
        for i = 1, len do
            if (this.composeChoices[i] == id) then
                table.remove(this.composeChoices, i);
                break;
            end
        end
    end
end


this.IsComposeChoice = function(id)
    local len = #this.composeChoices;
    for i = 1, len do
        if (this.composeChoices[i] == id) then
            return true;
        end
    end
    return false;
end


this.UpdateStatus = function()
    local len = #this.itemList;
    for i = 1, len do
        this.itemList[i]:Choice(this.IsComposeChoice);
    end
end


this.OnChoice = function(args)
    local id = args[0];
    local status = args[1];
    if (status) then
        if (this.IsComposeChoice(id)) then return end
        
        local count = #this.composeChoices;
        if (count >= this.formula.CostRequire) then return end
        
    end
    this.ComposeChoice(id, status);
    this.SetChoiceCount();
    this.UpdateStatus();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancel);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.AddClick(this.confirmLockBtn, this.OnClickConfirmLock);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.FoundationComposeChoice, this.OnChoice);
        local formulaId = vm.behaviour.Params[0];
        this.InitComposeChoices();
        this.SetChoiceItem(formulaId);
        this.SetChoiceCount();
        this.UpdateStatus();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationComposeChoice, this.OnChoice);
    end,
    before_destroy = function(vm)
        this.DestroyChoiceItem();
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancel);
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.RemoveClick(this.confirmLockBtn, this.OnClickConfirmLock);
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})