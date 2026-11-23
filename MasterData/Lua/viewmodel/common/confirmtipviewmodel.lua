








local this = {
    scrollView = nil,
    campSeries = nil,
    rewardDatas = nil,
};

local objs = {
    txtTitle = { path = "root/Middle/Group/txtTitle", type = "Text" },
    txtContent = { path = "root/Middle/Group/txtContent", type = "Text" },
    btnConfirm = { path = "root/Middle/Group/btnConfirm", type = "Button" },
    btnCancel = { path = "root/Middle/Group/btnCancel", type = "Button" },
};


this.BtnConfrim_Execute=function()
    if this.confrimCallBack~=nil then
        this.confrimCallBack();
    end
    LuaMgr.HidePanel(UIName.ConfirmTipViewModel);
end

this.BtnCancel_Execute=function()
    if this.cancelCallBack~=nil then
        this.cancelCallBack();
    end
    LuaMgr.HidePanel(UIName.ConfirmTipViewModel);
end


local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.btnConfirm, this.BtnConfrim_Execute);
        LuaMgr.AddClick(this.btnCancel, this.BtnCancel_Execute);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>2 then
            this.txtTitle.text=vm.behaviour.Params[0];
            this.txtContent.text=vm.behaviour.Params[1];
            this.confrimCallBack=vm.behaviour.Params[2]
        end
        if vm.behaviour.Params.Length>3 then
            this.cancelCallBack=vm.behaviour.Params[3]
        end
        this.ParseData();
    end,
    before_deactive = function(vm)
       
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.btnConfirm, this.BtnConfrim_Execute);
        LuaMgr.RemoveClick(this.btnCancel, this.BtnCancel_Execute);
    end
}

this.ParseData=function()
    
end

return vm({
    data = data,
    command = command,
    hook = hook
})