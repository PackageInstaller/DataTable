require("Tools/UITool")

local objs = {
    titleGo_1 = { path = "root/Middle/Group/TitleImg_1", type = UITool.GameObject },
    titleGo_2 = { path = "root/Middle/Group/TitleImg_2", type = UITool.GameObject },
    titleGo_3 = { path = "root/Middle/Group/TitleImg_3", type = UITool.GameObject },
    contentText = { path = "root/Middle/Group/Content/Text", type = UITool.Text },
}


local globalLanKeys = {
    29650, 29651, 29652
}

local this = {
    vm = nil,
};

local data = {}

local command = {
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamRelay2TipsPopup)
        end
    },
    cancelBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.cancelCallBack ~= nil then
                this.cancelCallBack()
            end
            LuaMgr.HidePanel(UIName.TeamRelay2TipsPopup)
        end
    },
    confirmBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.confirmCallBack ~= nil then
                this.confirmCallBack()
            end
            LuaMgr.HidePanel(UIName.TeamRelay2TipsPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        UITool.Parse(vm.behaviour, this, objs);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitParameter()
        this.RefreshData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.InitParameter = function()
    this.type = this.vm.behaviour.Params[0]
    local len = this.vm.behaviour.Params.Length
    if len > 1 then
        this.confirmCallBack = this.vm.behaviour.Params[1]
    end
    if len > 2 then
        this.cancelCallBack = this.vm.behaviour.Params[2]
    end
end

this.RefreshData = function()
    SetActive(this.titleGo_1, this.type == 1)
    SetActive(this.titleGo_2, this.type == 2)
    SetActive(this.titleGo_3, this.type == 3)
    this.contentText.text = ConfigMgr.LangGlobal(tostring(globalLanKeys[this.type]))
end

return vm({
    data = data,
    command = command,
    hook = hook
})