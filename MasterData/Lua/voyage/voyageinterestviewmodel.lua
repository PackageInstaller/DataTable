local this = {
    
};

local objs = {
    moneyText = { path = "root/Middle/Interest/Money/Text", type = "Text" },
    confirmBtn = { path = "root/Middle/Interest/Group/Confirm", type = "Button" },
    detailBtn = { path = "root/Middle/Interest/Tips/Detail", type = "Button" },
};


this.SetData = function()
    this.moneyText.text = tostring(DataMgr.Player.SailingPropertyInterest);
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/foundation_VMdrop.mp3");
end


this.OnClickConfirm = function()
    PlayerVoyageMgr.ReceiveSailingPropertyInterest();
end


this.OnClickDetail = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageTradeHelpViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.AddClick(this.detailBtn, this.OnClickDetail);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.SetData();
    end,
    before_deactive = function(vm)
        
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.RemoveClick(this.detailBtn, this.OnClickDetail);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})