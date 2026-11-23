




local this = {vm = nil,rootAnim = nil,equipIconPath = "Assets/_BundleResources/Images/ItemIcons_pic/itemicon_pic_",
              equipId = "",animator_JIAN = "UI_EquipMapPopup_jian",animator_DUN = "UI_EquipMapPopup_dun",
              animator_QIU = "UI_EquipMapPopup_qiu",animator_NU = "UI_EquipMapPopup_nu",animator_PAO = "UI_EquipMapPopup_pao"}

local data = {
    skillIcon = DefaultTexture,
    equipJob = DefaultSprite,
    equipRawImage = DefaultTexture,
    typeText = "",
    dateText = "",
    producersText = "",
    equipName = "",
    equipRare = UnityEngine.Color(0,0,0,0),
    tips1 = "",
    tips2 = "",
    tips3 = "",
    introText = "",
    maxRare = false,
}

local command = {
    clickSkill = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowPanel(UIName.SkillTipsViewModel,2,this.equipId,nil,nil,8)
        end
    },

    backCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.Back()
        end
    },
    leftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if #HeroParameter.terminalMapList == 1 then
                return
            end
            if HeroParameter.terminalMapIndex - 1 < 1 then
                HeroParameter.terminalMapIndex = #HeroParameter.terminalMapList
            else
                HeroParameter.terminalMapIndex = HeroParameter.terminalMapIndex - 1
            end
            this.equipId = HeroParameter.terminalMapList[HeroParameter.terminalMapIndex]
            this.EquipData()
        end
    },
    rightCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if #HeroParameter.terminalMapList == 1 then
                return
            end
            if HeroParameter.terminalMapIndex + 1 > #HeroParameter.terminalMapList then
                HeroParameter.terminalMapIndex = 1
            else
                HeroParameter.terminalMapIndex = HeroParameter.terminalMapIndex + 1
            end
            this.equipId = HeroParameter.terminalMapList[HeroParameter.terminalMapIndex]
            this.EquipData()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.rootAnim = vm.behaviour.transform:Find("root"):GetComponent("Animator")
        animator = vm.behaviour.transform:Find("root/Middle/LeftInfo/Conetent"):GetComponent("Animator")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.equipId = HeroParameter.terminalMapList[HeroParameter.terminalMapIndex]
        this.EquipData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.equipId = ""
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.EquipData = function()
    this.rootAnim:Play("UI_EquipMapPopup_01",0,0)
    local equipConfig = ConfigMgr.Config.equipments[this.equipId]
    local equipMap = {}
    for key,value in ipairs(ConfigMgr.Config.equipmentFiles) do
        if value.id == this.equipId then
            equipMap = value
            break
        end
    end
    if not equipMap or equipMap == nil or next(equipMap) == nil then return end
    if not equipConfig or equipConfig == nil then return end
    this.PlayAnimator(equipConfig)
    this.vm.data.equipJob = LuaMgr.GetSprite("EquipJob","job_"..equipConfig.job)
    this.vm.data.equipRawImage = LuaMgr.GetTexture(this.equipIconPath..equipConfig.id..".png")
    this.vm.data.typeText = LuaMgr.GetLangText(equipMap.classifylan);
    this.vm.data.dateText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2193"].NameLan)..equipMap.batch
    this.vm.data.producersText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2194"].NameLan)..LuaMgr.GetLangText(equipMap.makerlan)
    this.vm.data.equipName = LuaMgr.GetLangText(equipConfig.NameLan)
    this.vm.data.tips1 = LuaMgr.GetLangText(equipMap.equipDefinelan)
    this.vm.data.tips2 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2195"].NameLan)..equipMap.weight
    this.vm.data.tips3 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2196"].NameLan)..LuaMgr.GetLangText(equipMap.materiallan)
    this.vm.data.introText = LuaMgr.GetLangText(equipMap.textlan)
    if next(equipConfig.equipSkill) ~= nil then
        this.vm.data.skillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(equipConfig.equipSkill[1]))
    end
    if equipConfig.rare == 2 then
        this.vm.data.equipRare = UnityEngine.Color(33 / 225, 155 / 225, 161 / 225, 1)
    elseif equipConfig.rare == 3 then
        this.vm.data.equipRare = UnityEngine.Color(216 / 225, 187 / 225, 70 / 225, 1)
    elseif equipConfig.rare == 4 then
        this.vm.data.equipRare = UnityEngine.Color(236 / 225, 56 / 225, 57 / 225, 1)
    end
    this.vm.data.maxRare = equipConfig.rare == 5
end

this.PlayAnimator = function(equipConfig)
    if equipConfig.job == 1 then
        animator:Play(this.animator_DUN)
    elseif equipConfig.job == 2 then
        animator:Play(this.animator_JIAN)
    elseif equipConfig.job == 3 then
        animator:Play(this.animator_NU)
    elseif equipConfig.job == 4 then
        animator:Play(this.animator_QIU)
    elseif equipConfig.job == 5 then
        animator:Play(this.animator_PAO)
    end
end
return vm({
    data = data,
    command = command,
    hook = hook
})