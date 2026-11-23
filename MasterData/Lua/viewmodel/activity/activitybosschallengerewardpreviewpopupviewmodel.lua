require("ViewModel/Activity/RewardPreviewPopup_Item")
require("ViewModel/Activity/RewardPreviewPopup_RewardItem")

local this = 
{
    vm = nil,
}

local data = 
{

}

local command = {
    on_click_back_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
        end
    },
    on_click_icon_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_icon_btn()
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

        local boss_id       = vm.behaviour.Params[0]
        local current_rank  = vm.behaviour.Params[1]
        local total         = vm.behaviour.Params[2]

        this.set_data(boss_id, current_rank, total)
    end,
    before_deactive = function(vm)
        
    end,
    before_destroy = function()
        this.scrollView:Clear(true)
        UIScrollView.ClearItem("RewardPreviewPopup_Item")
    end
}

function this.init(vm)
    this.vm = vm
    this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Tips/Scroll View").gameObject)
    this.itemObj    = vm.behaviour.transform:Find("template/item").gameObject
end

function this.set_data(boss_id, current_rank, total)
    this.scrollView:Clear(true)
    local cfg = nil

    for i, v in ipairs(ConfigMgr.Config.ChallengeBosses) do
        if v.Id == boss_id then
            cfg = v
            break
        end
    end

    local data_list = {}

    if cfg ~= nil then
        local rank_rewards_cfg = cfg.RankRewards
        local rank_segment_cfg = cfg.RankShow

        local has_get_one_reward = false

        for i, v in ipairs(rank_segment_cfg) do
            local element = {}
            element.rank        = i
            element.rank_text   = ConfigMgr.LangGlobal(tostring(v[1]))

            if has_get_one_reward == false then
                if current_rank == 0 or total == 0 then
                    element.is_current = false
                
                elseif total < 100 then

                    element.is_current = true
                    has_get_one_reward = true

                else

                    local left  = tonumber(v[2])
                    local right = tonumber(v[3])
                    local ratio = math.floor(current_rank / total * 100)
                    
                    if ratio >= left and ratio <= right then
                        element.is_current = true
                        has_get_one_reward = true
                    else
                        element.is_current = false
                    end
                end
            else
                element.is_current = false
            end

            local rewards = rank_rewards_cfg[i]
            element.reward_data = {}

            local count = math.floor(#rewards / 2)
            for i = 1, count do 
                local item_id       = rewards[2 * (i - 1) + 1]
                local item_count    = rewards[2 * i]

                local cfg_item = ConfigMgr.Config.itemMap[item_id]
                
                local e = {}
                e.id                = item_id
                e.icon_texture      = ConfigHelper.GetItemTexture(item_id)
                e.rare_sprite       = ConfigHelper.GetRareSprite(cfg_item.rare)
                e.count             = tostring(item_count)

                table.insert(element.reward_data, e)
            end
            
            local data = UIScrollData.GetData(this.itemObj, "RewardPreviewPopup_Item", 840, 94, element)
            table.insert(data_list, data)
        end
    end

    this.scrollView:SetParams(843, 409)
    this.scrollView:SetData(data_list, true)
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossChallengeRewardPreviewPopupViewModel)
end

function this.on_click_icon_btn()
    print("this.on_click_icon_btn")
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)