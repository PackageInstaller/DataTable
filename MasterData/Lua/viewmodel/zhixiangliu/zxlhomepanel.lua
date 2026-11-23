local objs = {
    downTimeTxt = {path = "root/Middle/Title/DownTimeBG/DownTimeTxt", type = UITool.Text},
    passBtn = {path = "root/Middle/PassBtn", type = UITool.Button},
    shopBtn = {path = "root/Middle/ShopBtn", type = UITool.Button},
    taskBtn = {path = "root/Middle/TaskBtn", type = UITool.Button},
    playMothedBtn = {path = "root/Middle/PlayMothedBtn", type = UITool.Button}
}

local this = {}

this.before_awake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.ZXLHomePanel)
end

this.before_active = function()
    ZXLData.CheckRed()
end


this.OnClickPassBtn = function()
    if ZXLData.CheckActivityRunning() then
        local data = {}
        data.medalActivityID = "4180"
        data.medalColor = "#3d6053"
        data.medalImgKey = "ui_hd_ty_dtyl_bt_zxl"
        data.bgmPath = "Assets/_BundleResources/Audio/Bgm/zhixiangliu.mp3"
        LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data)
    end
end
this.OnClickShopBtn = function()
    if ZXLData.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.ZXLShopPanel)
    end
end
this.OnClickTaskBtn = function()
    if ZXLData.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.ZXLTaskPopup)
    end
end
this.OnClickPlayMothedBtn = function()
    if ZXLData.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.ZXLGlassCombinePanel)
    end
end


this.Refresh = function()
    this.OnUpdateMedalCollect()
end

this.OnRefreshTime = function()
    this.downTimeTxt.text = ZXLData.GetRemainTimeStr()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.AddClick(this.shopBtn, this.OnClickShopBtn)
        LuaMgr.AddClick(this.taskBtn, this.OnClickTaskBtn)
        LuaMgr.AddClick(this.playMothedBtn, this.OnClickPlayMothedBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.vmBehaviour = vm.behaviour
        LuaMgr.AddTimer(TimerConst.ManagementDownTimer, this.OnRefreshTime, 60, -1, true)
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.ManagementDownTimer)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShopBtn)
        LuaMgr.RemoveClick(this.taskBtn, this.OnClickTaskBtn)
        LuaMgr.RemoveClick(this.playMothedBtn, this.OnClickPlayMothedBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)