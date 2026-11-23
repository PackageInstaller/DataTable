local this =
{
    vm = nil,
}

local data =
{
    rewards =
    {
        {
            id              = "1233",
            icon            = DefaultTexture,
            rare            = DefaultSprite,
            count           = "45",
            is_status_1     = false,
            is_status_2     = true,
        }
    },
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
    on_click_reward_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_reward_btn(vm, param)
        end
    },
}

local hook =
{
    before_awake = function(vm)
        this.init(vm)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        print("before_active")
        this.on_before_active()
    end,

















}

function this.init(vm)
    this.vm = vm
end

function this.on_before_active()
    local params        = this.vm.behaviour.Params
    local groupid       = params[0]
    local credit        = params[1]
    local is_status_1   = params[2]

    local config = nil
    for _, v in ipairs(ConfigMgr.Config.EventBossRewards) do
        if v.Group == groupid and  v.Credit == credit then
            config = v
            break
        end
    end
    local data_list = {}

    if config then
        for _, v in ipairs(config.Reward) do
            local data = {}

            data.id             = tostring(v.id)
            data.icon           = ConfigHelper.GetItemTexture(tostring(v.id))
            data.rare           = ConfigHelper.GetRareSprite(ConfigMgr.Config.itemMap[tostring(v.id)].rare)
            data.count          = tostring(v.count)
            data.is_status_1    = is_status_1
            data.is_status_2    = not is_status_1

            table.insert(data_list, data)
        end
    end

    this.vm.data.rewards = data_list
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummyRewardPreviewViewModel)
end

function this.on_click_reward_btn(vm, param)
    LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, this.vm.data.rewards[param + 1].id, false, false, false, 0);
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)