require("ViewModel/SpringCamp/SpringCampTechItem")

local this = {
    curSeriesId = "",
    curChooseTechId = "",
    techItems = {},
    techItemTemplate = nil,
    techItemContentTr = nil,
}

local data = {
    consumeItemIcon = DefaultTexture,
    leftItemCount = "",
    showSingleTechInfo = false,
    showAllTechInfo = false,
    curTechIcon = DefaultSprite,
    curTechName = "",
    curTechDesc = "",
curTechStatus_1 = false,
curTechStatus_2 = false,
curTechStatus_3 = false,
    consumeItemCount = "",
    unlockEffectGo = false,

    allTechInfoList = {
        { desc = "" }
    },
}

local command = {
    maskBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickTechNode("")
        end
    },
    resetBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            TrainingCampMgr.ResetTech(function()
                this.SetData()
                this.OnClickTechNode("")
            end)
        end
    },
    unlockBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if TrainingCampMgr.CheckTechIsUnlock(this.curChooseTechId) then
                return
            end

            TrainingCampMgr.UnlockTech(this.curChooseTechId, function()
                local chooseId = this.curChooseTechId
                this.curChooseTechId = ""
                this.SetData()
                this.OnClickTechNode(chooseId)
                for i, v in ipairs(this.techItems) do
                    if v.data.TechId == chooseId then
                        v:ShowUnlockEffect()
                    end
                end
                this.vm.data.unlockEffectGo = true
            end)
        end
    },
    confirmBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnBack()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.techItemTemplate = vm.behaviour.transform:Find("template/TechItem").gameObject
        this.techItemContentTr = vm.behaviour.transform:Find("root/Middle/Group/Content"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.SetData()
        this.OnClickTechNode("")
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
    end,
}

this.SetData = function()
    this.curSeriesId = TrainingCampMgr.GetCurWheelSeriesID();
    if this.curSeriesId == nil then
        print("lose config for curSeries")
        return
    end
    local consumeItemId, consumeItemCount = TrainingCampMgr.GetTechPointItemIdAndCount()
    local configData = ConfigMgr.Config.itemMap[consumeItemId]
    this.vm.data.consumeItemIcon = GetItemHomeIcon(consumeItemId)
    this.vm.data.leftItemCount = string.format(LuaMgr.GetLangText("SpringCampTechViewModel_0"), LuaMgr.GetLangText(configData.nameLan), consumeItemCount)
    this.SetTechTree()
end

this.SetTechTree = function()
    local techCfgs = TrainingCampMgr.GetTechCfgs(this.curSeriesId)
    for i, v in ipairs(techCfgs) do
        if i > #this.techItems then
            local obj = LuaMgr.InstantiateGO(this.techItemTemplate, this.techItemContentTr, false).transform
            local item = SpringCampTechItem.New()
            item.gameObject = obj.gameObject
            item.transform = obj
            item:Init()
            table.insert(this.techItems, item)
        end
        local techItem = this.techItems[i]
        techItem:SetData(v, this.OnClickTechNode)
    end
end

this.OnClickTechNode = function(techId)
    if this.curChooseTechId == techId and techId ~= "" then
        return
    end

    this.curChooseTechId = techId
    if techId == "" then
        local tempList = {}
        local techCfgs = TrainingCampMgr.GetTechCfgs(this.curSeriesId)
        for i, v in ipairs(techCfgs) do
            if TrainingCampMgr.CheckTechIsInEffect(v.TechId) then
                table.insert(tempList, {
                    desc = LuaMgr.GetLangText(v.DescLan)
                })
            end
        end
        this.vm.data.allTechInfoList = tempList
        this.vm.data.showAllTechInfo = true
        this.vm.data.showSingleTechInfo = false
    else
        local curTechCfg = ConfigMgr.Config.CampTechMap[techId]
        local isUnlock = TrainingCampMgr.CheckTechIsUnlock(techId)
        local isCanUnlock = TrainingCampMgr.CheckTechIsCanUnlock(techId)
        local isConsumeEnough = TrainingCampMgr.CheckTechUnlockConsumeEnough(techId)
        local isInEffect = TrainingCampMgr.CheckTechIsInEffect(techId)
        this.vm.data.curTechIcon = LuaMgr.GetSprite("BuffIcon", curTechCfg.Icon)
        this.vm.data.curTechName = LuaMgr.GetLangText(curTechCfg.NameLan)
        this.vm.data.curTechDesc = LuaMgr.GetLangText(curTechCfg.DescLan)
        this.vm.data.curTechStatus_1 = not isUnlock and isCanUnlock
        this.vm.data.curTechStatus_2 = isUnlock and isInEffect
        this.vm.data.curTechStatus_3 = not isUnlock and not isCanUnlock and isConsumeEnough
        if this.vm.data.curTechStatus_1 == true and not TableIsNull(curTechCfg.Consume) then
            this.vm.data.consumeItemCount = string.format(LuaMgr.GetLangText("SpringCampTechViewModel_1"), curTechCfg.Consume[1].count)
        end
        this.vm.data.showSingleTechInfo = true
        this.vm.data.showAllTechInfo = false
    end
    for i, v in ipairs(this.techItems) do
        v:CheckIsSelect(techId)
    end
    this.vm.data.unlockEffectGo = false
end

this.OnBack = function()
    LuaMgr.Back()
end

return vm({
    data = data,
    command = command,
    hook = hook
})