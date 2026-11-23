local this = {
    vm = nil,
}

local data = {
    icon = DefaultTexture,
    rare = DefaultSprite,
    job = DefaultSprite,
    name = "",
    attrList = {
        {
            attrName = "",
            attrValue = "",
        },
    },
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.CrisisContract3ChaAdditionPreviewPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.SetData()
    end,
}

this.SetData = function()
    local params = this.vm.behaviour.Params
    local heroid = params[0]
    local config = params[1]

    local characterConfig = ConfigMgr.Config.characterTable[heroid]
    this.vm.data.name = LuaMgr.GetLangText(characterConfig.namelan)
    this.vm.data.icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(heroid))
    this.vm.data.rare = LuaMgr.GetSprite("CommonRes", "ui_home_kbn_tx" .. ConfigMgr.Config.characterTable[heroid].rare)
    this.vm.data.job = LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[heroid].job)

    local ls = {}
    for _, v in ipairs(config.Condition3desc) do
        if v[1] == heroid then
            table.insert(ls, v)
        end
    end
    local tempList = {}
    for i, v in ipairs(ls) do
        local attrDesCfg = ConfigMgr.Config.attrDesMap[v[2]]
        local attrItem = {
            attrName = LuaMgr.GetLangText(attrDesCfg.NameLan),
        }
        local str = ""
        if tonumber(v[3]) > 0 then
            str = "+"
        end
        attrItem.attrValue = str .. v[3] .. attrDesCfg.attrDisplayType
        table.insert(tempList, attrItem)
    end
    this.vm.data.attrList = tempList
end

return vm(
        {
            data = data,
            command = command,
            hook = hook
        }
)