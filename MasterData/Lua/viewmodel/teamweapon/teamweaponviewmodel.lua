require("ViewModel/TeamWeapon/TeamWeaponItem")
require("ViewModel/TeamWeapon/TeamWeaponInfoAttrItem")
require("ViewModel/TeamWeapon/TeamWeaponUpgradeAttrItem")
require("ViewModel/TeamWeapon/TeamWeaponUpgradeCostItem")
require("ViewModel/TeamWeapon/TeamWeaponAscensionCostItem")
require("ViewModel/TeamWeapon/TeamWeaponExpBar")

local objs = {
    upgradeLevelText = { path = "root/Right/Upgrade/LevelInfo/Level", type = "Text" },
    upgradeAddLevelText = { path = "root/Right/Upgrade/LevelInfo/Level/AddLevel", type = "Text" },
    upgradeExpText = { path = "root/Right/Upgrade/LevelInfo/Exp", type = "Text" },
    upgradeExpSlider = { path = "root/Right/Upgrade/LevelInfo/Slider", type = "Slider" },
    upgradeCostCoinIcon = { path = "root/Right/Upgrade/Buttons/UpgradeBtn/Cost/Num/Image", type = "RawImage" },
    upgradeCostCoinNum = { path = "root/Right/Upgrade/Buttons/UpgradeBtn/Cost/Num", type = "Text" },
    upgradeFastBtnText = { path = "root/Right/Upgrade/Buttons/QuickFillBtn/Text", type = "Text" },
    maskGo = { path = "root/Mask", type = "GameObject" },
}
local this = {
    vm = nil,

    weaponDataList = {},
    weaponScrollView = nil,
    weaponItemTemplate = nil,
    curWeaponId = "",
    curWeaponData = nil,
    curWeaponLimitLevel = 0,
    curWeaponMaxLevel = 0,
pageStatus = 1,

    coroutine_weaponList = nil,


    infoAttrItems = {},

    upgradeAttrItemDataList = nil,
    upgradeAttrListView = nil,
    upgradeAttrItemTemplate = nil,

    upgradeCostSelectedMap = {},
    upgradeCostItemDatas = nil,
    upgradeCostListView = nil,
    upgradeCostItemTemplate = nil,
    isUpgradeCoinEnough = false,
    isReachedLimitLevel = false,

    ascensionCostItemDatas = nil,
    ascensionCostListView = nil,
    ascensionCostItemTemplate = nil,
    ascensionCostItemMap = {},
    isAscensionCostEnough = false,
    isAscensionApiBlocked = false,
}

local data = {

    weaponIcon = DefaultSprite,
    totalLevelStr = "",
    teamOn = false,
    teamName = "",

    infoActive = false,
    infoLevelStr = "",
    infoStarStr = "",
    infoSkillIcon = DefaultTexture,
    infoLevelUpBtnActive = false,
    weaponIconEffectActive_1 = false,
    weaponIconEffectActive_2 = false,
    infoMaxLevelActive = false,

    upgradeActive = false,

    ascensionActive = false,
    ascensionSkillIcon_1 = DefaultTexture,
    ascensionSkillIcon_2 = DefaultTexture,
    ascensionSkillLevel_1 = "",
    ascensionSkillLevel_2 = "",
    ascensionLevelLimit_1 = "",
    ascensionLevelLimit_2 = "",
    ascensionCostCoinNum = "",
    ascensionCostCoinIcon = DefaultTexture,
}

local command = {
    infoSkillCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local skillLevel = tonumber(this.curWeaponCfg.TeamWeaponSkillStar[this.curWeaponData.Star])
            LuaMgr.ShowPanel(UIName.SkillTipsViewModel, 5, this.curWeaponId, nil, nil, 5, nil, skillLevel)
        end
    },
    infoSkillCommand_2 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local nextStar = math.min(#this.curWeaponCfg.TeamWeaponSkillStar, this.curWeaponData.Star + 1) 
            local skillLevel = tonumber(this.curWeaponCfg.TeamWeaponSkillStar[nextStar])
            LuaMgr.ShowPanel(UIName.SkillTipsViewModel, 5, this.curWeaponId, nil, nil, 5, nil, skillLevel)
        end
    },
    levelUpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SwitchPageStatus(2)
        end
    },
    totalLevelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponTotalLevelViewModel)
        end
    },
    teamCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponPreparePopup, this.curWeaponId)
        end
    },
    infoMaskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.pageStatus ~= 1 then
                this.SwitchPageStatus(1)
            end
        end
    },
    quickFillCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if TableIsNull(this.upgradeCostSelectedMap) then
                this.OnClickFastBtn()
            else
                this.OnClickClearBtn()
            end
        end
    },
    upgradeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickLevelUp()
        end
    },
    ascensionCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickAscension()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);
        RedMgr.Singleton:RegisterViewModel(UIName.TeamWeaponViewModel)
        this.weaponScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Left/ScrollView").gameObject)
        this.weaponItemTemplate = vm.behaviour.transform:Find("template/WeaponItem").gameObject
        for i = 1, 4 do
            table.insert(this.infoAttrItems, TeamWeaponInfoAttrItem.New(vm.behaviour.transform:Find("root/Right/Info/Attr/Attr_" .. i).gameObject))
        end
        this.upgradeAttrListView = UIListView.New(vm.behaviour.transform:Find("root/Right/Upgrade/AttrList"))
        this.upgradeAttrItemTemplate = vm.behaviour.transform:Find("template/UpgradeAttrItem").gameObject
        this.upgradeCostListView = UIListView.New(vm.behaviour.transform:Find("root/Right/Upgrade/CostItemList"))
        this.upgradeCostItemTemplate = vm.behaviour.transform:Find("template/UpgradeCostItem").gameObject
        this.ascensionCostListView = UIListView.New(vm.behaviour.transform:Find("root/Right/Ascension/CostItemList"))
        this.ascensionCostItemTemplate = vm.behaviour.transform:Find("template/AscensionCostItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("FoundationOffice", this.OnBack)

        this.InitParameter()
        this.RefreshData()

        if TeamWeaponMgr.isShowPreparePopup then
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponPreparePopup, this.curWeaponId)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        for i, v in ipairs(this.infoAttrItems) do
            v:Clear()
        end
        this.weaponScrollView:Clear()
        this.upgradeAttrItemDataList = nil
        this.upgradeAttrListView:Clear()
        this.upgradeCostItemDatas = nil
        this.upgradeCostListView:Clear()
        this.ascensionCostItemDatas = nil
        this.ascensionCostListView:Clear()
        TeamWeaponExpBar.Clear()
        if this.coroutine_weaponList ~= nil then
            coroutine_runner.stop(this.coroutine_weaponList)
        end
        LuaMgr.RemoveTimer(TimerConst.TeamWeaponAscensionSuccessDelay);
        LuaMgr.RemoveUIEventListener(UIEventConst.TeamWeaponChangeWeaponTeam, this.OnChangeWeaponTeam);
    end,
    before_destroy = function(vm)
        this.infoAttrItems = {}
        this = nil
        UIScrollView.ClearItem("TeamWeaponItem")
        UIListView.ClearItem("TeamWeaponUpgradeAttrItem")
        UIListView.ClearItem("TeamWeaponUpgradeCostItem")
        UIListView.ClearItem("TeamWeaponAscensionCostItem")
    end
}

this.InitParameter = function()
    this.pageStatus = 1
    this.curWeaponId = ""
    this.curWeaponLimitLevel = 0
    this.curWeaponMaxLevel = 0
    this.InitWeaponList()
    this.curWeaponId = this.weaponDataList[1].weaponId
    this.RefreshWeaponList()
    SetActive(this.maskGo, false)
    this.vm.data.weaponIconEffectActive_1 = false
    this.vm.data.weaponIconEffectActive_2 = false
    
    LuaMgr.AddUIEventListener(UIEventConst.TeamWeaponChangeWeaponTeam, this.OnChangeWeaponTeam);
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

this.OnClickWeaponItem = function(weaponId)
    if IsNullOrEmpty(weaponId) then
        weaponId = this.weaponDataList[1].weaponId
    end
    this.curWeaponId = weaponId
    this.pageStatus = 1
    this.vm.data.infoActive = false
    this.RefreshData()
end


this.RefreshData = function()
    this.isAscensionApiBlocked = false
    this.curWeaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(this.curWeaponId)
    this.curWeaponData = TeamWeaponMgr.GetTeamWeaponData(this.curWeaponId)
    this.curWeaponLimitLevel = tonumber(this.curWeaponCfg.LevelLimite[this.curWeaponData.Star])
    this.curWeaponMaxLevel = tonumber(this.curWeaponCfg.LevelLimite[#this.curWeaponCfg.LevelLimite])
    this.SwitchPageStatus(this.pageStatus)
    this.RefreshCommonInfo()
    this.RefreshWeaponList()
    this.RefreshRed()
end

this.SwitchPageStatus = function(status)
    this.pageStatus = status
    if this.pageStatus == 1 then
        this.RefreshWeaponInfo()
    elseif this.pageStatus == 2 or this.pageStatus == 3 then
        local curLevel = this.curWeaponData.Level
        if curLevel < this.curWeaponLimitLevel then
            this.RefreshWeaponUpgrade()
            this.pageStatus = 2
        elseif curLevel < this.curWeaponMaxLevel then
            this.RefreshWeaponAscension()
            this.pageStatus = 3
        else
            this.pageStatus = 1
            this.RefreshData()
            return
        end
    end
    this.vm.data.infoActive = this.pageStatus == 1
    this.vm.data.upgradeActive = this.pageStatus == 2
    this.vm.data.ascensionActive = this.pageStatus == 3
end

this.OnChangeWeaponTeam = function()
    this.RefreshCommonInfo()
    this.RefreshWeaponList()
    this.RefreshRed()
end


this.RefreshWeaponInfo = function()
    local attrList = TeamWeaponMgr.GetTeamWeaponAttrs(this.curWeaponId, this.curWeaponData.Level)
    for i, v in ipairs(attrList) do
        this.infoAttrItems[i]:SetData(v.name, tostring(v.value))
    end
    this.vm.data.infoLevelStr = this.curWeaponData.Level
    this.vm.data.infoStarStr = GetChineseBigNumber(this.curWeaponData.Star)
    this.vm.data.infoLevelUpBtnActive = this.curWeaponData.Level < tonumber(this.curWeaponMaxLevel)
    this.vm.data.infoMaxLevelActive = this.curWeaponData.Level >= tonumber(this.curWeaponMaxLevel)
    local skillId = this.curWeaponCfg.TeamWeaponSkill[1]
    this.vm.data.infoSkillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillId, "ex", "")))
end


this.RefreshCommonInfo = function()
    local teamIndex = TeamWeaponMgr.GetTeamIndexByWeaponId(this.curWeaponId)
    this.vm.data.teamOn = teamIndex ~= -1
    if teamIndex ~= -1 then
        local teamInfo = DataMgr.Player.teams[tostring(teamIndex)]
        this.vm.data.teamName = teamInfo.name
    end
    local totalLevel = 0
    for i, v in ipairs(this.weaponDataList) do
        local weaponData = TeamWeaponMgr.GetTeamWeaponData(v.weaponId)
        totalLevel = totalLevel + weaponData.Level
    end
    this.vm.data.totalLevelStr = totalLevel
    this.vm.data.weaponIcon = LuaMgr.GetSprite("TeamWeapon", this.curWeaponCfg.IconRes)
end


this.RefreshWeaponUpgrade = function()
    this.InitExpBar()
    this.InitUpgradeAttrList()
    this.InitUpgradeCostList()
    this.RefreshUpgradeCostList()
end


this.InitExpBar = function()
    local curLevel = this.curWeaponData.Level
    local curLevelExp = TeamWeaponMgr.GetLevelExp(this.curWeaponId, curLevel)
    local nextLevel = curLevel + 1 > this.curWeaponLimitLevel and this.curWeaponLimitLevel or curLevel + 1
    local nextLevelExp = TeamWeaponMgr.GetLevelExp(this.curWeaponId, nextLevel)
    TeamWeaponExpBar.Init(curLevel, this.curWeaponLimitLevel, this.curWeaponData.Exp - curLevelExp, nextLevelExp - curLevelExp, 1, this.OnExp, this.OnGetExp, this.OnFinish)
end

this.SetUpgradeLevelExp = function()
local curLevel = this.curWeaponData.Level
local curExp = this.curWeaponData.Exp
local addExp = this.GetAddExp()
local totalExp = curExp + addExp
local targetLevel = math.min(TeamWeaponMgr.GetLevelByExp(this.curWeaponId, totalExp), this.curWeaponLimitLevel)
local targetLevelExp = TeamWeaponMgr.GetLevelExp(this.curWeaponId, targetLevel)
local targetNextLevel = math.min(targetLevel + 1, this.curWeaponMaxLevel)
local targetLevelUpExp = TeamWeaponMgr.GetLevelExp(this.curWeaponId, targetNextLevel) - targetLevelExp
local addLevel = targetLevel - curLevel
local overflowExp = totalExp - targetLevelExp
    this.upgradeLevelText.text = string.format(LuaMgr.GetLangText("TeamWeaponViewModel_0"), targetLevel, this.curWeaponLimitLevel)
    this.upgradeAddLevelText.text = addLevel > 0 and "+" .. addLevel or ""
    this.upgradeExpText.text = targetLevel == this.curWeaponMaxLevel and LuaMgr.GetLangText("TeamWeaponViewModel_1") or string.format("%s/%s", overflowExp, targetLevelUpExp)
    if targetLevelUpExp <= 0 then
        this.upgradeExpSlider.value = 1.0
    else
        this.upgradeExpSlider.value = overflowExp / targetLevelUpExp
    end
    this.RefreshUpgradeAttrList(curLevel, targetLevel)

    local coin = PlayerItemMgr.GetItemCountById("3")
    local needCoin = math.floor(addExp * TeamWeaponMgr.GetLevelUpCoinByRare(this.curWeaponCfg.Rare) / 100)
    this.isUpgradeCoinEnough = coin >= needCoin
    this.upgradeCostCoinNum.text = string.format("<color=%s>%s</color>", not this.isUpgradeCoinEnough and "#c31f36" or "#ffffff", needCoin)

    this.isReachedLimitLevel = targetLevel >= this.curWeaponLimitLevel
end

this.OnExp = function(level, exp, maxExp, limitLevel, isUpLevel)
    local addLevel = level - this.curWeaponData.Level
    this.upgradeLevelText.text = string.format(LuaMgr.GetLangText("TeamWeaponViewModel_2"), level, limitLevel)
    this.upgradeAddLevelText.text = addLevel > 0 and "+" .. addLevel or ""
    this.upgradeExpText.text = level == this.curWeaponMaxLevel and LuaMgr.GetLangText("TeamWeaponViewModel_3") or string.format("%s/%s", exp, maxExp)
    if isUpLevel then
        this.upgradeExpSlider.value = 1.0
    else
        this.upgradeExpSlider.value = exp / maxExp
    end
end

this.OnGetExp = function(level, exp)
    local curLevelExp = TeamWeaponMgr.GetLevelExp(this.curWeaponId, level)
    local nextLevel = level + 1 > this.curWeaponLimitLevel and this.curWeaponLimitLevel or level + 1
    local nextLevelExp = TeamWeaponMgr.GetLevelExp(this.curWeaponId, nextLevel)
    return nextLevelExp - curLevelExp
end

this.OnFinish = function(isUpLevel)
    local len = #this.upgradeAttrItemDataList
    for i = 1, len do
        if this.upgradeAttrItemDataList[i].isChange then
            this.upgradeAttrItemDataList[i].showEffect = not this.isReachedLimitLevel
        end
    end
    this.vm.data.weaponIconEffectActive_1 = false
    this.vm.data.weaponIconEffectActive_1 = true
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Level_up_2.mp3");
    this.RefreshData()
    SetActive(this.maskGo, false)
end

this.GetAddExp = function()
    local exp = 0
    for k, count in pairs(this.upgradeCostSelectedMap) do
        local config = ConfigItemMgr.GetItemById(k)
        if config ~= nil then
            exp = exp + config.drop * count
        end
    end
    return exp
end


this.OnClickFastBtn = function()
    this.upgradeCostSelectedMap = {}
    local isOk, needExpItemMap, isItemEnough = TeamWeaponMgr.GetFastLevelUpItem(this.curWeaponId, true)
    if not isOk and not isItemEnough then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroUpLevelViewModel_1"))
    elseif not isOk and isItemEnough then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroUpLevelViewModel_2"))
    else
        this.upgradeCostSelectedMap = needExpItemMap
    end
    this.RefreshUpgradeCostList()
end

this.OnClickClearBtn = function()
    this.upgradeCostSelectedMap = {}
    this.RefreshUpgradeCostList()
end

this.OnClickLevelUp = function()
    if this.GetAddExp() <= 0 then
        local tip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["29610"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tip)
        return
    end
    if not this.isUpgradeCoinEnough then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroUpLevelViewModel_2"))
        return
    end
    TeamWeaponMgr.LevelUpApi(this.curWeaponId, this.upgradeCostSelectedMap, this.LevelUpResponse)
end

this.LevelUpResponse = function(re)
    SetActive(this.maskGo, true)
    local weaponData = TeamWeaponMgr.GetTeamWeaponData(this.curWeaponId)
    TeamWeaponExpBar.SetExp(this.GetAddExp(), weaponData.Level)
    this.upgradeCostSelectedMap = {}
end


this.InitUpgradeAttrList = function()
    if this.upgradeAttrItemDataList ~= nil and next(this.upgradeAttrItemDataList) then
        return
    end
    this.upgradeAttrItemDataList = {}
    this.upgradeAttrListView:Clear();
    local attrList = TeamWeaponMgr.GetTeamWeaponAttrs(this.curWeaponId, this.curWeaponData.Level)
    for i = 1, #attrList do
        local attrData = attrList[i]
        local itemData = {
            attrId = attrData.attrId,
            nameStr = attrData.name,
            icon = LuaMgr.GetSprite("AttributeIcon", attrData.attrId),
            valueStr_1 = attrData.value,
            valueStr_2 = "",
            isChange = false,
            showEffect = false,
        }
        table.insert(this.upgradeAttrItemDataList, itemData)
    end

    local listData, listDatas = {}, {}
    for i, v in ipairs(this.upgradeAttrItemDataList) do
        local groupData = v
        listData = UIListData.GetData(this.upgradeAttrItemTemplate, "TeamWeaponUpgradeAttrItem", groupData);
        table.insert(listDatas, listData)
    end
    this.upgradeAttrListView:SetData(listDatas);
end

this.RefreshUpgradeAttrList = function(curLevel, targetLevel)
    local beforeAttrList = TeamWeaponMgr.GetTeamWeaponAttrs(this.curWeaponId, curLevel)
    local afterAttrList = TeamWeaponMgr.GetTeamWeaponAttrs(this.curWeaponId, targetLevel)
    local len = #this.upgradeAttrItemDataList
    for i = 1, len do
        this.upgradeAttrItemDataList[i].valueStr_1 = beforeAttrList[i].value
        this.upgradeAttrItemDataList[i].valueStr_2 = afterAttrList[i].value
        this.upgradeAttrItemDataList[i].isChange = not IsNullOrEmpty(afterAttrList[i].value) and beforeAttrList[i].value ~= afterAttrList[i].value
    end
    this.upgradeAttrListView:Refresh()
end


this.InitUpgradeCostList = function()
    if this.upgradeCostItemDatas ~= nil and next(this.upgradeCostItemDatas) then
        return
    end
    this.upgradeCostSelectedMap = {}
    this.upgradeCostItemDatas = {}
    this.upgradeCostListView:Clear();
    local list = ConfigItemMgr.GetItemsByType(ItemType.TeamWeaponExp)
    if list ~= nil then
        for i = 1, #list do
            local itemCfg = list[i]
            local itemData = {
                itemId = itemCfg.id,
                itemName = LuaMgr.GetLangText(itemCfg.nameLan),
                itemRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. itemCfg.rare),
                itemIcon = GetItemTexture(itemCfg.id),
                selectCount = 0,
            }
            itemData.itemCount = PlayerItemMgr.GetItemCountById(itemCfg.id)
            itemData.onClickAdd = this.OnClickCostItemAdd;
            itemData.onClickDel = this.OnClickCostItemDel;
            local listData = UIListData.GetData(this.upgradeCostItemTemplate, "TeamWeaponUpgradeCostItem", itemData);
            table.insert(this.upgradeCostItemDatas, listData);
        end
        this.upgradeCostListView:SetData(this.upgradeCostItemDatas);
    end
    for i, v in ipairs(this.upgradeCostListView.itemList) do
        v:SetAddNumParam()
    end
    this.upgradeCostCoinIcon.texture = GetItemHomeIcon("3")
    this.upgradeCostCoinNum.text = "0"
end

this.RefreshUpgradeCostList = function()
    for i, v in ipairs(this.upgradeCostItemDatas) do
        if this.upgradeCostSelectedMap[v.data.itemId] ~= nil then
            v.data.selectCount = this.upgradeCostSelectedMap[v.data.itemId]
            if this.upgradeCostSelectedMap[v.data.itemId] == 0 then
                this.upgradeCostSelectedMap[v.data.itemId] = nil
            end
        else
            v.data.selectCount = 0
        end
        v.data.itemCount = PlayerItemMgr.GetItemCountById(v.data.itemId)
    end
    this.upgradeCostListView:Refresh()
    this.SetUpgradeLevelExp()
    this.upgradeFastBtnText.text = TableIsNull(this.upgradeCostSelectedMap) and LuaMgr.GetLangText("TeamWeaponViewModel_4") or LuaMgr.GetLangText("TeamWeaponViewModel_5")
end

this.OnClickCostItemAdd = function(itemId)
    local serverCount = PlayerItemMgr.GetItemCountById(itemId)
    if serverCount == 0 then
        if (not LuaMgr.IsPanelOpen(UIName.GoodsTipsViewModel)) then
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, itemId, true, false, false);
        end
        return
    end
    if this.isReachedLimitLevel then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TeamWeaponViewModel_6"))
        return
    end
    if this.upgradeCostSelectedMap[itemId] == nil then
        this.upgradeCostSelectedMap[itemId] = 0
    end

    this.upgradeCostSelectedMap[itemId] = math.min(this.upgradeCostSelectedMap[itemId] + 1, serverCount)
    this.RefreshUpgradeCostList()
end

this.OnClickCostItemDel = function(itemId)
    if this.upgradeCostSelectedMap[itemId] ~= nil then
        this.upgradeCostSelectedMap[itemId] = math.max(this.upgradeCostSelectedMap[itemId] - 1, 0)
    end
    this.RefreshUpgradeCostList()
end


this.RefreshWeaponAscension = function()
    local curStar = this.curWeaponData.Star
    local nextStar = this.curWeaponData.Star + 1
    if nextStar > #this.curWeaponCfg.TeamWeaponSkillStar or nextStar > #this.curWeaponCfg.LevelLimite then
        this.SwitchPageStatus(1)
        return
    end
    this.SetAscensionChangeInfo(curStar, nextStar)
    this.RefreshAscensionCostList()
end


this.SetAscensionChangeInfo = function(curStar, nextStar)
    local skillId = this.curWeaponCfg.TeamWeaponSkill[1]
    local skillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillId, "ex", "")))
    this.vm.data.ascensionSkillLevel_1 = this.curWeaponCfg.TeamWeaponSkillStar[curStar]
    this.vm.data.ascensionSkillLevel_2 = this.curWeaponCfg.TeamWeaponSkillStar[nextStar]
    this.vm.data.ascensionSkillIcon_1 = skillIcon
    this.vm.data.ascensionSkillIcon_2 = skillIcon
    this.vm.data.ascensionLevelLimit_1 = string.format(LuaMgr.GetLangText("TeamWeaponViewModel_7"), this.curWeaponCfg.LevelLimite[curStar])
    this.vm.data.ascensionLevelLimit_2 = string.format(LuaMgr.GetLangText("TeamWeaponViewModel_8"), this.curWeaponCfg.LevelLimite[nextStar])
end


this.RefreshAscensionCostList = function()
    this.ascensionCostItemMap = {}
    this.ascensionCostItemDatas = {}
    this.isAscensionCostEnough = true
    this.ascensionCostListView:Clear();
    local starUpCfg = TeamWeaponMgr.TeamWeaponStarUpCfg(this.curWeaponId, this.curWeaponData.Star + 1)
    if starUpCfg ~= nil then
        for i, v in ipairs(starUpCfg.Res) do
            local itemCfg = ConfigItemMgr.GetItemById(v.id)
            local serverCount = PlayerItemMgr.GetItemCountById(v.id)
            local itemData = {
                itemId = itemCfg.id,
                itemRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. itemCfg.rare),
                itemIcon = GetItemTexture(itemCfg.id),
                itemCount = string.format("%d/%d", serverCount, v.count)
            }
            local listData = UIListData.GetData(this.ascensionCostItemTemplate, "TeamWeaponAscensionCostItem", itemData);
            table.insert(this.ascensionCostItemDatas, listData);
            this.ascensionCostItemMap[v.id] = v.count
            if serverCount < v.count then
                this.isAscensionCostEnough = false
            end
        end
        this.ascensionCostListView:SetData(this.ascensionCostItemDatas);
        local coin = PlayerItemMgr.GetItemCountById("3")
        local needCoin = starUpCfg.Coin
        this.vm.data.ascensionCostCoinNum = string.format("<color=%s>%s</color>", coin < needCoin and "#c31f36" or "#ffffff", needCoin)
        this.vm.data.ascensionCostCoinIcon = GetItemHomeIcon("3")
        if coin < needCoin then
            this.isAscensionCostEnough = false
        end
    end
end

this.OnClickAscension = function()
    if this.isAscensionApiBlocked then
        return
    end
    if not this.isAscensionCostEnough then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2068"))
        return
    end
    TeamWeaponMgr.AscensionApi(this.curWeaponId, this.ascensionCostItemMap, this.AscensionResponse)
end

this.AscensionResponse = function()
    this.isAscensionApiBlocked = true
    this.vm.data.weaponIconEffectActive_2 = false
    this.vm.data.weaponIconEffectActive_2 = true
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Star_up.mp3")
    LuaMgr.AddTimer(TimerConst.TeamWeaponAscensionSuccessDelay, function()
        LuaMgr.ShowLuaPanel(UIName.TeamWeaponAscensionSuccessPopup, this.curWeaponId)
        this.RefreshData()
    end, 0.3, 1, false)
end


this.RefreshRed = function()
    local cultivateRed = TeamWeaponMgr.CheckAllTeamWeaponCultivateRed()
    local totalLevelRed = TeamWeaponMgr.CheckTotalLevelRed()
RedMgr.Singleton:UpdateClientRedData("17401", cultivateRed + totalLevelRed)
RedMgr.Singleton:UpdateClientRedData("17402", totalLevelRed);
    RedMgr.Singleton:Refresh()
end

this.OnBack = function()
    LuaMgr.Back()
end

return vm({
    data = data,
    command = command,
    hook = hook
})