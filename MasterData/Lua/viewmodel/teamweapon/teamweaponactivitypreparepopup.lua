require("ViewModel/TeamWeapon/TeamWeaponItem")
require("ViewModel/TeamWeapon/TeamWeaponInfoAttrItem")

local this = {
    vm = nil,
    activityDungeonId = "",
    callback = nil,

    weaponDataList = {},
    weaponScrollView = nil,
    weaponItemTemplate = nil,
    
    curWeaponId = "",
    curEnableWeaponId = "",
    curWeaponData = nil,
    coroutine_weaponList = nil,
    infoAttrItems = {},
}

local data = {
    weaponIcon = DefaultSprite,
    totalLevelStr = "",
    infoLevelStr = "",
    infoStarStr = "",
    infoSkillIcon = DefaultTexture,
    enableBtnActive = false,
    disableBtnActive = false,
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamWeaponActivityPreparePopup)
        end
    },
    infoSkillCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local skillLevel = tonumber(this.curWeaponCfg.TeamWeaponSkillStar[this.curWeaponData.Star])
            LuaMgr.ShowPanel(UIName.SkillTipsViewModel, 5, this.curWeaponId, nil, nil, 5, nil, skillLevel)
        end
    },
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamWeaponActivityPreparePopup)
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponViewModel)
        end
    },
    disableCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            ActivityBattlePrepareMgr.SetTeamWeaponId(this.activityDungeonId, "")
            if this.callback ~= nil then
                this.callback("")
            end
            this.curEnableWeaponId = ActivityBattlePrepareMgr.GetTeamWeaponId(this.activityDungeonId)
            this.RefreshData()
        end
    },
    enableCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            ActivityBattlePrepareMgr.SetTeamWeaponId(this.activityDungeonId, this.curWeaponId)
            if this.callback ~= nil then
                this.callback(this.curWeaponId)
            end
            this.curEnableWeaponId = ActivityBattlePrepareMgr.GetTeamWeaponId(this.activityDungeonId)
            this.RefreshData()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.weaponScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/Info/WeaponList/ScrollView").gameObject)
        this.weaponItemTemplate = vm.behaviour.transform:Find("template/WeaponItem").gameObject
        for i = 1, 4 do
            table.insert(this.infoAttrItems, TeamWeaponInfoAttrItem.New(vm.behaviour.transform:Find("root/Middle/Group/Info/BaseInfo/Attr/Attr_" .. i).gameObject))
        end
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.activityDungeonId = vm.behaviour.Params[0]
        this.callback = vm.behaviour.Params[1]
        this.InitData()
        this.RefreshData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.InitData = function()
    this.curWeaponId = ActivityBattlePrepareMgr.GetTeamWeaponId(this.activityDungeonId)
    this.curEnableWeaponId = this.curWeaponId
    this.InitWeaponList()
end

this.InitWeaponList = function()
    local weaponCfgMap = ConfigMgr.Config.TeamWeaponMap
    this.weaponDataList = {}
    for k, v in pairs(weaponCfgMap) do
        local weaponItem = {
            weaponId = v.Id,
            nameStr = LuaMgr.GetLangText(v.NameLan),
            level = 1,
            redCount = TeamWeaponMgr.CheckTeamWeaponCultivateRed(v.Id),
            isLocked = false,
            isSelected = false,
            animBool = false,
            onClick = this.OnClickWeaponItem,
        }
        table.insert(this.weaponDataList, weaponItem)
    end
    table.sort(this.weaponDataList, function(a, b)
        return a.weaponId < b.weaponId
    end)

    if IsNullOrEmpty(this.curWeaponId) then
        this.curWeaponId = this.weaponDataList[1].weaponId
    end

    local scrollData, scrollDatas = {}, {}
    for i, v in ipairs(this.weaponDataList) do
        local groupData = v
        scrollData = UIScrollData.GetData(this.weaponItemTemplate, "TeamWeaponItem", 260, 112, groupData)
        table.insert(scrollDatas, scrollData)
    end

    this.weaponScrollView:Clear(false)
    this.weaponScrollView:SetParams(260, 613)
    this.weaponScrollView:SetPadding(0, 0, 0, 0)
    this.weaponScrollView:SetData(scrollDatas, true)
    this.PlayWeaponListAnim()
end

this.PlayWeaponListAnim = function()
    if this.coroutine_weaponList ~= nil then
        coroutine_runner.stop(this.coroutine_weaponList)
    end
    this.coroutine_weaponList = coroutine_runner.start(function()
        for i = 1, #this.weaponScrollView.dataList do
            this.weaponScrollView.dataList[i].data.animBool = true
            if this.weaponScrollView.itemMap[i] ~= nil then
                SetActive(this.weaponScrollView.itemMap[i].animatorObj, true)
            end
            coroutine_runner.wait(0.3)
        end
    end)
end

this.RefreshData = function()
    this.curWeaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(this.curWeaponId)
    this.curWeaponData = TeamWeaponMgr.GetTeamWeaponData(this.curWeaponId)
    this.RefreshWeaponList()
    this.RefreshCommonInfo()
    this.RefreshWeaponInfo()
    this.vm.data.enableBtnActive = this.curWeaponId == this.curEnableWeaponId
    this.vm.data.disableBtnActive = this.curWeaponId ~= this.curEnableWeaponId
end

this.RefreshWeaponList = function()
    for i, v in ipairs(this.weaponDataList) do
        local weaponData = TeamWeaponMgr.GetTeamWeaponData(v.weaponId)
        v.level = weaponData.Level
        v.redCount = TeamWeaponMgr.CheckTeamWeaponCultivateRed(v.weaponId)
        v.isSelected = v.weaponId == this.curWeaponId
        v.isLocked = TeamWeaponMgr.CheckWeaponIsLocked(v.weaponId)
    end
    this.weaponScrollView:Refresh()
end

this.RefreshCommonInfo = function()
    local totalLevel = 0
    for i, v in ipairs(this.weaponDataList) do
        local weaponData = TeamWeaponMgr.GetTeamWeaponData(v.weaponId)
        totalLevel = totalLevel + weaponData.Level
    end
    this.vm.data.totalLevelStr = totalLevel
    this.vm.data.weaponIcon = LuaMgr.GetSprite("TeamWeapon", this.curWeaponCfg.IconRes)
end

this.RefreshWeaponInfo = function()
    local attrList = TeamWeaponMgr.GetTeamWeaponAttrs(this.curWeaponId, this.curWeaponData.Level)
    for i, v in ipairs(attrList) do
        this.infoAttrItems[i]:SetData(v.name, tostring(v.value))
    end
    this.vm.data.infoLevelStr = this.curWeaponData.Level
    this.vm.data.infoStarStr = GetChineseBigNumber(this.curWeaponData.Star)
    local skillId = this.curWeaponCfg.TeamWeaponSkill[1]
    this.vm.data.infoSkillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillId, "ex", "")))
end

this.OnClickWeaponItem = function(weaponId)
    if IsNullOrEmpty(weaponId) then
        weaponId = this.weaponDataList[1].weaponId
    end
    this.curWeaponId = weaponId
    this.RefreshData()
end

return vm(
        {
            data = data,
            command = command,
            hook = hook
        }
)