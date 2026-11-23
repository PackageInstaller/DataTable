




local TypeEnum = {
    level = 1,
    grade = 2,
    star = 3,
}
local this = {vm = nil,opType = nil,equipData = nil,beforeEquipData = nil,ToString = tostring,
              starIndex = 1,isClick = false,iconPath = "Assets/_BundleResources/Images/ItemIcons/itemicon_",
              picPath = "Assets/_BundleResources/Images/ItemIcons_pic/itemicon_pic_",
              rColor = UnityEngine.Color(33 / 225, 155 / 225, 161 / 225, 1),
              srColor = UnityEngine.Color(216 / 225, 187 / 225, 70 / 225, 1),
              ssrColor = UnityEngine.Color(236 / 225, 56 / 225, 57 / 225, 1)}

local data = {
    rootAnimName = "",
    levelRoot = false,gradeRoot = false,starRoot = false,effect = Vector3.zero,
    levelText = "",foreLimitedLevel = "",afterLimitedLevel = "",
    equipRare = DefaultSprite,equipIcon = DefaultTexture,
    painting = DefaultTexture,equipName = "",equipColor = UnityEngine.Color(0,0,0,0),
    skillName = "",skillLevel = "",skillIntro = "",urColor = false,
    basisAttr = {{attrName = "",attrValue = "",nextValue = ""},
                 {attrName = "",attrValue = "",nextValue = ""}},
    subjoinAttr = {{newAttr = Vector3.zero,attrName = "",attrValue = "",nextValue = "",next = Vector3.zero ,curr = Vector3.zero }},
    starList = {{star = false},{star = false},{star = false},{star = false},{star = false},{star = false}},
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.isClick then
                LuaMgr.Back()
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.CloseFun()
    end,
}


this.InitParameter = function()

    if this.vm.behaviour.Params.Length > 0 then
        local equipId = this.ToString(this.vm.behaviour.Params[0])
        this.equipData = DataMgr.Player.equipments[equipId]
        this.opType = this.vm.behaviour.Params[1]
        this.beforeEquipData = this.vm.behaviour.Params[2]
        if this.opType == TypeEnum.level then
            this.InitLevelUpResults()
        elseif this.opType == TypeEnum.grade then
            this.InitGradeUpResults()
        else
            this.InitStarUpResults()
        end
        this.InitRoot()
    end
end


this.InitLevelUpResults = function()
    this.vm.data.levelText = this.ToString(this.equipData.level)
    this.CreateAttr()
end


this.InitGradeUpResults = function()
    local equipConfig = ConfigMgr.Config.equipments[this.equipData.equipmentId]
    this.vm.data.equipRare = LuaMgr.GetSprite("ItemRare","itemRare"..equipConfig.rare)
    this.vm.data.equipIcon = LuaMgr.GetTexture(this.iconPath..equipConfig.id..".png")
    this.vm.data.foreLimitedLevel = string.format("%d/%d",this.beforeEquipData.level,this.beforeEquipData.limitedLevel)
    this.vm.data.afterLimitedLevel = string.format("%d/%d",this.equipData.level,this.equipData.limitedLevel)
    this.CreateAttr()
end


this.InitStarUpResults = function()
    local equipConfig = ConfigMgr.Config.equipments[this.equipData.equipmentId]
    this.vm.data.painting = LuaMgr.GetTexture(this.picPath..equipConfig.id..".png")
    this.vm.data.equipName = LuaMgr.GetLangText(equipConfig.NameLan)
    if equipConfig.rare == 2 then
        this.vm.data.equipColor = this.rColor
    elseif equipConfig.rare == 3 then
        this.vm.data.equipColor = this.srColor
    elseif equipConfig.rare == 4 then
        this.vm.data.equipColor = this.ssrColor
    end
    this.vm.data.urColor = equipConfig.rare == 5
    if #equipConfig.equipSkill > 0 then
        local skill = ConfigMgr.Config.equipmentSkills[equipConfig.equipSkill[1]][this.ToString(this.equipData.star)]
        this.vm.data.skillName = LuaMgr.GetLangText(skill.NameLan)
        this.vm.data.skillLevel = this.ToString(this.equipData.star)
        this.vm.data.skillIntro = LuaMgr.GetEquipSkillText(this.equipData.equipmentId,this.equipData.star)
    end
    this.starIndex = 1
    LuaMgr.AddTimer(TimerConst.EquipStarUpTime,function()
        this.OpStarEffect()
    end,0.1,100,true)
end

this.OpStarEffect = function()
    this.vm.data.starList[this.starIndex].star = true
    if this.starIndex < this.equipData.star then
        this.starIndex = this.starIndex + 1
    else
        LuaMgr.RemoveTimer(TimerConst.EquipStarUpTime)
    end
end




this.CreateAttr = function()
    local foreProperty = json.decode(LuaMgr.GetEquipPropertyCopy(json.encode(this.beforeEquipData)))
    local afterProperty = json.decode(LuaMgr.GetEquipPropertyCopy(json.encode(this.equipData)))
    local tempAttr = {"Atk","Hp"}
    local keyStr = ""
    for i = 1, #tempAttr do
        keyStr = tempAttr[i]
        this.vm.data.basisAttr[i].attrName = LuaMgr.GetLangText(ConfigHelper.GetAttrDes(keyStr.."_FIX").NameLan)
        this.vm.data.basisAttr[i].attrValue = this.ToString(foreProperty[keyStr])
        this.vm.data.basisAttr[i].nextValue = this.ToString(afterProperty[keyStr])

        foreProperty[keyStr] = nil
        afterProperty[keyStr] = nil
    end
    if this.opType == TypeEnum.level then
        local attrDes = {}
        local attrList = {}
        for key,value in pairs(afterProperty) do
            attrDes = ConfigHelper.GetAttrDes(key)
            local isNew = foreProperty[key] == nil
            local atkItem = {newAttr = Vector3.zero,next = Vector3.zero,
                             attrName = LuaMgr.GetLangText(attrDes.NameLan),
                             attrValue = "",
                             nextValue = "",
                             index = isNew and 3 or 2
                             
            }
            if isNew then
                if (key == "EnergyRecoveryCycle_FIX") then
                    atkItem.attrValue = LuaMgr.Division(tonumber(value), 100)..attrDes.attrDisplayType
                else
                    atkItem.attrValue = this.ToString(value)..attrDes.attrDisplayType
                end
                atkItem.newAttr = Vector3.one
                atkItem.next =Vector3.zero;
                atkItem.curr =Vector3.one;
            else
                local value1=foreProperty[key];
                local value2=afterProperty[key];
                local isChange=value1~=value2;

                atkItem.index=isChange and 2 or 1;
                if (key == "EnergyRecoveryCycle_FIX") then
                    atkItem.attrValue = LuaMgr.Division(tonumber(value1), 100)..attrDes.attrDisplayType
                    atkItem.nextValue = LuaMgr.Division(tonumber(value2), 100)..attrDes.attrDisplayType
                else
                    atkItem.attrValue = this.ToString(value1)..attrDes.attrDisplayType
                    atkItem.nextValue = this.ToString(value2)..attrDes.attrDisplayType
                end
                atkItem.next =isChange and  Vector3.one or Vector3.zero;
                atkItem.curr =isChange and  Vector3.zero or Vector3.one;
            end
            table.insert(attrList,atkItem)
        end
        table.sort(attrList,this.AttrSort)
        this.vm.data.subjoinAttr = attrList
    end
end

this.InitRoot = function()
    this.isClick = false
    this.vm.data.levelRoot = this.opType == TypeEnum.level
    this.vm.data.gradeRoot = this.opType == TypeEnum.grade
    this.vm.data.starRoot = this.opType == TypeEnum.star
    this.vm.data.effect = this.opType ~= TypeEnum.star and Vector3.one or Vector3.zero
    if this.opType == TypeEnum.level then
        this.vm.data.rootAnimName = "UI_EquipTipPopup_Level"
        AudioHelper.PlayUISFX(AudioNames.Equip_levelup);
    elseif this.opType == TypeEnum.grade then
        this.vm.data.rootAnimName = "UI_EquipTipPopup_Grade"
        AudioHelper.PlayUISFX(AudioNames.Equip_strengthen);
    elseif this.opType == TypeEnum.star then
        this.vm.data.rootAnimName = "UI_EquipTipPopup_Star"
        AudioHelper.PlayUISFX(AudioNames.Equip_starup);
    end
    LuaMgr.AddTimer(TimerConst.CGMapClickTime,function()
        this.isClick = true
    end,1.5,100,false)
end

this.AttrSort = function(attr1,attr2)
    if attr1.index ~= attr2.index then
        return attr1.index > attr2.index
    else
        return false
    end
end

this.CloseFun = function()
    for i = 1, #this.vm.data.starList do
        this.vm.data.starList[i].star = false
    end
    LuaMgr.RemoveTimer(TimerConst.EquipStarUpTime)
    LuaMgr.RemoveTimer(TimerConst.CGMapClickTime)
end

return vm({
    data = data,
    command = command,
    hook = hook
})