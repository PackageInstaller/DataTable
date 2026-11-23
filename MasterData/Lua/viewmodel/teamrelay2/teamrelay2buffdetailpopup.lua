require("Tools/UITool")

local objs = {
    nameTxt = { path = "root/Middle/Group/Name/Text", type = UITool.Text },
    descTxt = { path = "root/Middle/Group/Desc/Viewport/Content/Text", type = UITool.Text },
    buffIcon = { path = "root/Middle/Group/BuffIcon/Image", type = UITool.Image },
}

local this = {
    vm = nil,
};

local data = {}

local command = {
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamRelay2BuffDetailPopup)
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
    this.buffDescId = this.vm.behaviour.Params[0]
    this.buffDescCfg = TeamRelay2Mgr.GetBuffDescCfg(this.buffDescId)
end

this.RefreshData = function()
    this.nameTxt.text = LuaMgr.GetLangText(this.buffDescCfg.BuffNameLan)
    this.descTxt.text = LuaMgr.GetLangText(this.buffDescCfg.BuffDesLan)
    this.buffIcon.sprite = LuaMgr.GetSprite("BuffIcon", this.buffDescCfg.BuffIcon)
end

return vm({
    data = data,
    command = command,
    hook = hook
})