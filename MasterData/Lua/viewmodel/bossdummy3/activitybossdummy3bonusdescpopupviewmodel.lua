local this =
{
    vm          = nil,
    gameObject  = nil,
    attr_1_go   = nil,
    attr_2_go   = nil,
    attr_3_go   = nil,
}

local data = 
{
    text_hero_name  = "aaa",
    icon            = DefaultTexture,
    rare            = DefaultSprite,
    job             = DefaultSprite,
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
}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
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
    this.gameObject = this.vm.behaviour.gameObject
    local params    = this.vm.behaviour.Params
    local config    = params[0]
    local index     = params[1]

    local heroid            = config.ReCommend[index]
    local characterConfig   = ConfigMgr.Config.characterTable[heroid] 

    this.vm.data.text_hero_name = LuaMgr.GetLangText(characterConfig.namelan)
    this.vm.data.icon   = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(heroid))
    this.vm.data.rare   = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..ConfigMgr.Config.characterTable[heroid].rare)
    this.vm.data.job    = LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[heroid].job)

    this.attr_1_go = this.gameObject.transform:Find("root/Middle/attr_1").gameObject
    this.attr_2_go = this.gameObject.transform:Find("root/Middle/attr_2").gameObject
    this.attr_3_go = this.gameObject.transform:Find("root/Middle/attr_3").gameObject
    this.attr_1_go:SetActive(false)
    this.attr_2_go:SetActive(false)
    this.attr_3_go:SetActive(false)

    for i = 1, 3, 1 do
        local go = this["attr_" .. i .. "_go"]
        if i * 2 <= #config.RecommendBuffIcon[index] then
            go:SetActive(true)
            go.transform:Find("Image"):GetComponent("Image").sprite = LuaMgr.GetSprite("AttributeIcon", config.RecommendBuffIcon[index][i * 2 - 1])
            go.transform:Find("Text"):GetComponent("Text").text     = ConfigMgr.LangGlobal(config.RecommendBuffIcon[index][i * 2])
        else
            go:SetActive(false)
        end
    end
end

function this.on_before_deactive()

end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummy3BonusDescPopupViewModel)
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)