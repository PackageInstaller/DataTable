require("ViewModel/Activity/LineupRecommend_Item")
require("ViewModel/Activity/LineupRecommend_HeroItem")

local this = 
{
    vm          = nil,
    scrollView  = nil, 
    itemObj     = nil,
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
    }
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
        local data_list = vm.behaviour.Params[0]
        this.set_data(data_list)
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.scrollView:Clear(true)
    end,
    before_destroy = function()
        UIScrollView.ClearItem("LineupRecommend_Item")
    end
}

function this.init(vm)
    this.vm = vm
    this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Tips/Scroll View").gameObject)
    this.itemObj    = vm.behaviour.transform:Find("template/item").gameObject
end

function this.set_data(list)
    this.scrollView:Clear(true)
    local data_list = {}

    for _, v in ipairs(list) do
        local item_data = 
        {

        }

        local hero_data = {}

        for _, v2 in ipairs(v.hero_data) do
            local element = {}
            if v2.use002 then
                element.icon_texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(v2.id, v2.id .. "002"))
            else
                element.icon_texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(v2.id))
            end
            element.rare_sprite     = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..ConfigMgr.Config.characterTable[v2.id].rare)
            element.job_sprite      = LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[v2.id].job)
            element.star            = v2.star
            element.level           = tostring(v2.level)
            table.insert(hero_data, element)
        end

        item_data.hero_data = hero_data

        local data = UIScrollData.GetData(this.itemObj, "LineupRecommend_Item", 428, 100, item_data)
        table.insert(data_list, data)
    end

    this.scrollView:SetParams(439, 475);
    this.scrollView:SetData(data_list, true)
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossChallengeLineupRecommendPopupViewModel);
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)