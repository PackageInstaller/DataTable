local this = {
    group = nil,
};

local objs = {
    closeBtn = { path = "root/Middle/Group/Close", type = "Button" },
    name = { path = "root/Middle/Group/Name/Text", type = "Text" },
    pic = { path = "root/Middle/Group/Pic", type = "Image" },
    msg = { path = "root/Middle/Group/Msg", type = "Text" },
};


this.SetData = function()
    local questConfig = ConfigGuoBaoMgr.GetSimulatedShopQuestEvent("GuoBaostamp" .. this.group);
    if (questConfig == nil) then return end
    
    this.name.text = LuaMgr.GetLangText(questConfig.namelan);
    this.pic.sprite = LuaMgr.GetSprite("GuoBaoScene", string.format("ui_hd_gb_jy_ss_hj_%s_1", this.group));
    this.msg.text = LuaMgr.GetLangText(questConfig.remarksLan);
end


this.OnClickClose = function()
    LuaMgr.NextFrame(this.CloseDetails);
end


this.CloseDetails = function()
    LuaMgr.HidePanel(UIName.GuoBaoCollectDetailsViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.group = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        this.pic.sprite = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})