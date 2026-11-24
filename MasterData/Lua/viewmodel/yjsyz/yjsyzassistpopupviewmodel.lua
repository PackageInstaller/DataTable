local this =
{
    vm = nil,
    group_go = nil,
    hero_item_list = {},
}

local data =
{

}

local command =
{
    on_click_confirm_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_confirm_btn()
        end
    },
}

local objs =
{
    group_go = { path = "root/Middle/group", type = "GameObject" },
}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(this.vm.behaviour.gameObject, this, objs)
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
    before_destroy = function(vm)

    end
}

function this.on_before_active()
    this.init_hero_items()
    this.set_hero_list()

end

function this.on_before_deactive()

end

function this.init_hero_items()
    this.hero_item_list = {}
    for i = 1, 6 do
        local hero_tr = this.group_go.transform:Find("hero_item_" .. i)
        if hero_tr ~= nil then
            local item = {
                gameObject = hero_tr.gameObject,
                icon = hero_tr:Find("icon"):GetComponent("RawImage"),
                rare = hero_tr:Find("icon/rare"):GetComponent("Image"),
                job = hero_tr:Find("zz"):GetComponent("Image"),
            }
            table.insert(this.hero_item_list, item)
        end
    end
end

function this.set_hero_list()
    local hero_id_list = YJSYZHelper.get_assist_hero_id_list() or {}
    for i = 1, 6 do
        local item = this.hero_item_list[i]

        if item ~= nil and item.gameObject ~= nil then
            if i > #hero_id_list then
                item.gameObject:SetActive(false)
            else
                local hero_id = hero_id_list[i]
                if hero_id == nil or hero_id == "" then
                    item.gameObject:SetActive(false)
                else
                    local hero_cfg = ConfigMgr.Config.characterTable[hero_id]
                    if hero_cfg == nil then
                        item.gameObject:SetActive(false)
                    else
                        item.gameObject:SetActive(true)
                        item.icon.texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(hero_id))
                        item.rare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_" .. tostring(hero_cfg.rare))
                        item.job.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. tostring(hero_cfg.job))
                    end
                end
            end
        end
    end
end

function this.on_click_confirm_btn()
    LuaMgr.HidePanel(UIName.YJSYZAssistPopupViewModel)
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)