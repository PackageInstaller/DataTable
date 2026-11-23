require("ViewModel/TrainingDummy/TrainingDummyDamageItem")
require("ViewModel/TrainingDummy/TrainingDummyDamageHeadItem")

local this = {
    vm = nil,
    damageList = {
        {
            damageStr = "",
            characterList = {},
        }
    },
    scrollView = nil,
    coroutine_key = nil,
}

local data = {
    isEmpty = false,
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TrainingDummyDamagePopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/ScrollView").gameObject)
        this.itemTemplate = vm.behaviour.transform:Find("template/DamageItem").gameObject
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.SetData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.scrollView:Clear(false)
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("TrainingDummyDamageItem")
    end,
}

this.SetData = function()
    this.SetDamageListData()
    if TableIsNull(this.damageList) then
        this.vm.data.isEmpty = true
    else
        this.SetScrollView()
        this.vm.data.isEmpty = false
    end
end

this.SetDamageListData = function()
    this.damageList = {}
    local damageRecords = DataMgr.Player.WoodTraining.Records
    if IsNull(damageRecords) or TableIsNull(damageRecords) then
        return
    end

    local len = #damageRecords
    for i = len, 1, -1 do
        local record = damageRecords[i]
        local damageItem = {
            damageStr = LuaMgr.GetLangText("TrainingDummyDamagePopup_0") .. record.DamageTotal,
            characterDatas = {},
        }
        for k, characterId in pairs(record.members) do
            local cha = record.Characters[characterId]
            local uid = ""
            if not IsNull(record.help) and not TableIsNull(record.help) and record.help[k] ~= nil then
                uid = record.help[k]
            end 
            if cha ~= nil then
                local characterCfg = ConfigMgr.Config.characterTable[characterId]
                local damageRatio = math.floor((cha.Damage / record.DamageTotal) * 100 + 0.5) / 100
                local curRare = HeroMgr.GetHeroNowRare(characterId, uid)
                if curRare == 5 then
                    curRare = 4
                end
                local curSkinId = DataHelper.GetCharacterSkin(characterId)
                local data = {
                    id = characterId,
                    icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(characterId, curSkinId)),
                    rare = LuaMgr.GetSprite("CommonRes", "ui_home_kbn_tx" .. curRare),
                    job = LuaMgr.GetSprite("JobIcon", "job_" .. characterCfg.job),
                    ratio = damageRatio,
                }
                table.insert(damageItem.characterDatas, data)
            end
        end
        table.sort(damageItem.characterDatas, function(a, b) return a.ratio > b.ratio end)
        if #damageItem.characterDatas > 1 then
            local lastChaDamageRatio = 1
            local len = #damageItem.characterDatas - 1
            for i = 1, len do
                lastChaDamageRatio = lastChaDamageRatio - damageItem.characterDatas[i].ratio
            end
            damageItem.characterDatas[#damageItem.characterDatas].ratio = math.max(lastChaDamageRatio, 0)
        end
        table.sort(damageItem.characterDatas, function(a, b) return a.ratio > b.ratio end)
        table.insert(this.damageList, damageItem)
    end
end

this.SetScrollView = function()
    this.scrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    for i, v in ipairs(this.damageList) do
        groupData = v
        groupData.index = i
        scrollData = UIScrollData.GetData(this.itemTemplate, "TrainingDummyDamageItem", 732, 183, v)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(767, 450)
    this.scrollView:SetData(scrollDatas, true)

    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.coroutine_key = coroutine_runner.start(function()
        for i = 1, #this.scrollView.dataList do
            this.scrollView.dataList[i].data.animBool = true
            if this.scrollView.itemMap[i] ~= nil then
                SetActive(this.scrollView.itemMap[i].animatorObj, true)
            end
            coroutine_runner.wait(0.05)
        end
    end)
end

return vm(
        {
            data = data,
            command = command,
            hook = hook
        }
)