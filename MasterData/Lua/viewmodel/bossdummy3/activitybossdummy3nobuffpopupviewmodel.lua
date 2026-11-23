local this =
{
    vm = nil,
}

local data = 
{

}

local command =
{
    on_click_back_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
        end
    },

    on_click_confirm_btn = 
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_confirm_btn()
        end
    },

    on_click_today_btn = 
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_today_btn()
        end
    }
}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
        this.gameObject = this.vm.behaviour.gameObject
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then 
            return 
        end
        this.on_before_active()
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then 
            return 
        end
        this.on_before_deactive()
    end, 
}

function this.on_before_active()
    local params            = this.vm.behaviour.Params
    this.selected_config    = params[0]
    this.callback           = params[1]
    this.activityKey        = params[2]
    this.is_click           = false

    this.on_click_today_btn()
end

function this.on_before_deactive()

end

function this.on_click_confirm_btn()
    if this.is_click then
        PlayerPrefs.SetInt(DataMgr.Player.uid .. "BossDummy3_NoBuffPopup_TimeStamp", LuaMgr.Timestamp())
    end
    LuaMgr.HidePanel(UIName.ActivityBossDummy3NoBuffPopupViewModel)
    ActivityBattlePrepareMgr.SetMembers(ActivityKey.BossDummy3, this.selected_config.BossDummy3Id)
    if this.activityKey == ActivityKey.BossDummy3 then
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, this.activityKey, "boss", table.Copy(this.selected_config), {})
    else
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, this.activityKey, "boss", table.Copy(this.selected_config), nil)
    end
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummy3NoBuffPopupViewModel)
    if this.callback ~= nil then
        this.callback();
    end
end

function this.on_click_today_btn()
    this.is_click = not this.is_click
    this.gameObject.transform:Find("root/Middle/today/btn_today/mark").gameObject:SetActive(this.is_click)
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)