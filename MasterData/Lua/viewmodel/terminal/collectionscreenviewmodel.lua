local this = {
    selectedJob = 0,
    selectedType = 0,
    selectedDType = 0,
    selectedWType = 0,
    selectedSType = 0,
    jobItems = {},
    typeItems = {},
    dTypeItems = {},
    wTypeItems = {},
    sTypeItems = {},
    screenMap = {},
    callback = nil,
};

local objs = {
    jobsTf = { path = "root/Middle/Content/Jobs", type = "Transform" },
    typesTf = { path = "root/Middle/Content/Types", type = "Transform" },
    damageTypesTf = { path = "root/Middle/Content/DamageTypes/ScrollView/Viewport/Content", type = "Transform" },
    weaknessTypesTf = { path = "root/Middle/Content/WeaknessTypes/ScrollView/Viewport/Content", type = "Transform" },
    specialTypesTf = { path = "root/Middle/Content/SpecialTypes/ScrollView/Viewport/Content", type = "Transform" },
    closeBtn = { path = "root/Middle/Close", type = "Button" },
    comfirmBtn = { path = "root/Middle/Comfirm", type = "Button" },
    resetBtn = { path = "root/Middle/Reset", type = "Button" },
};

this.InitBtns = function()
    local factory = function(tf, items, func)
        for i = 0, tf.childCount - 1 do
            local btn = tf:GetChild(i):GetComponent("Button");
            local selected = btn.transform:Find("ImgSelected").gameObject;
            local index = i + 1
            items[index] = {}
            items[index].btn = btn;
            items[index].selected = selected;
            items[index].index = i;
            LuaMgr.AddClick(btn, function()
                func(index)
            end);
        end
    end
    factory(this.jobsTf, this.jobItems, this.ChooseJob)
    factory(this.typesTf, this.typeItems, this.ChooseType)
    factory(this.damageTypesTf, this.dTypeItems, this.ChooseDType)
    factory(this.weaknessTypesTf, this.wTypeItems, this.ChooseWType)
    factory(this.specialTypesTf, this.sTypeItems, this.ChooseSType)
end

this.ClearBtns = function()
    local factory = function(items)
        for k, v in pairs(items) do
            v.btn.onClick:RemoveAllListeners();
        end
    end
    factory(this.jobItems)
    factory(this.typeItems)
    factory(this.dTypeItems)
    factory(this.wTypeItems)
    factory(this.sTypeItems)
end

this.CommomSelected = function(items, index)
    for k, v in pairs(items) do
        if (k == index) then
            v.selected:SetActive(true);
        else
            v.selected:SetActive(false);
        end
    end
end

this.ChooseJob = function(index)
    if (this.selectedJob == index) then
        this.selectedJob = 0
    else
        this.selectedJob = index;
    end
    this.CommomSelected(this.jobItems, this.selectedJob)
end

this.ChooseType = function(index)
    if (this.selectedType == index) then
        this.selectedType = 0
    else
        this.selectedType = index;
    end
    this.CommomSelected(this.typeItems, this.selectedType)
end

this.ChooseDType = function(index)
    if (this.selectedDType == index) then
        this.selectedDType = 0
    else
        this.selectedDType = index;
    end
    this.CommomSelected(this.dTypeItems, this.selectedDType)
end

this.ChooseWType = function(index)
    if (this.selectedWType == index) then
        this.selectedWType = 0
    else
        this.selectedWType = index;
    end
    this.CommomSelected(this.wTypeItems, this.selectedWType)
end

this.ChooseSType = function(index)
    if (this.selectedSType == index) then
        this.selectedSType = 0
    else
        this.selectedSType = index;
    end
    this.CommomSelected(this.sTypeItems, this.selectedSType)
end


this.SetData = function()
    if (this.screenMap ~= nil) then
        this.ChooseJob(this.screenMap.job)
        if(this.screenMap.type == 0)then
             this.ChooseType(0)
        else
             this.ChooseType((this.screenMap.type - 6) * -1)
        end       
        this.ChooseDType(this.screenMap.damageType)
        this.ChooseWType(this.screenMap.weaknessType)
        this.ChooseSType(this.screenMap.specialType)





    else
        this.OnClickReset()
    end
end


this.OnClickClose = function()
    this.OnClickReset()
    LuaMgr.HidePanel(UIName.CollectionScreenViewModel);
end

this.OnClickComfirm = function()
    this.screenMap = {}
    this.screenMap.job = this.selectedJob
    this.screenMap.type = this.selectedType == 0 and 0 or 6 - this.selectedType
    this.screenMap.damageType = this.selectedDType
    this.screenMap.weaknessType = this.selectedWType
    this.screenMap.specialType = this.selectedSType
    local isClear = true
    for k, v in pairs(this.screenMap) do
        if (v ~= 0) then
            isClear = false
            break
        end
    end
    if (isClear) then
        this.screenMap = nil
    end
    if (this.callback ~= nil) then
        this.callback(this.screenMap)
    end
    this.OnClickReset()
    LuaMgr.HidePanel(UIName.CollectionScreenViewModel);
end

this.OnClickReset = function(...)
    this.ChooseJob(0)
    this.ChooseType(0)
    this.ChooseWType(0)
    this.ChooseDType(0)
    this.ChooseSType(0)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
        LuaMgr.AddClick(this.comfirmBtn, this.OnClickComfirm);
        LuaMgr.AddClick(this.resetBtn, this.OnClickReset);
        this.InitBtns()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if (vm.behaviour.Params ~= nil) then
            this.screenMap = vm.behaviour.Params[0]
            this.callback = vm.behaviour.Params[1]
        end
        this.SetData();
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        LuaMgr.RemoveClick(this.comfirmBtn, this.OnClickComfirm);
        LuaMgr.RemoveClick(this.resetBtn, this.OnClickReset);
        this.ClearBtns()
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})