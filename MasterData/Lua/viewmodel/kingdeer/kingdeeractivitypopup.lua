







local objs = {
    downTimeTxt = {path = "root/Middle/Group/DownTimeBG/DownTimeTxt", type = UITool.Text},
    rewardTitleTxt = {path = "root/Middle/Group/Reward/RewardTitleTxt", type = UITool.Transform},
    gotoBtn = {path = "root/Middle/Group/GotoBtn", type = UITool.Button}
}

local this = {}

this.before_awake = function()
end

this.before_active = function()
    this.rewardTitleTxt:SetSiblingIndex(2)
    local config = nil
    for key, value in pairs(ConfigMgr.Config.activityGroup) do
        if value.key == "BalatroBrand" then
            config = value
            break
        end
    end
    if config == nil then
        return
    end
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.KingDeerActivity);
    local remainTime = activityData.expireTime - LuaMgr.Timestamp()
    local d, h, m = GetTimeDHM2(remainTime)
    this.downTimeTxt.text = string.format(ConfigMgr.LangGlobal("15506"), d, h, m)
end

this.GotoMainPage = function()
    LuaMgr.ShowLuaPanel(UIName.KingDeerMainViewModel)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.gotoBtn, this.GotoMainPage)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.gotoBtn, this.GotoMainPage)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)