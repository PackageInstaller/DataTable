
require("SeasonSLG/SeasonSLGTechItem")
local objs = {
    techPrefab = {path = "template/TechItem", type = UITool.GameObject},
    propsPrefab = {path = "template/PropsPrefab", type = UITool.GameObject},
    bgBtn = {path = "root/BG", type = UITool.Button},
    techItemParent = {path = "root/Middle/ScrollView/Viewport/TechItemParent", type = UITool.RectTransform},
    techScrollViewBtn = {path = "root/Middle/ScrollView", type = UITool.Button},
    detailInfoObj = {path = "root/DetailInfo", type = UITool.GameObject},
    detailIcon = {path = "root/DetailInfo/Icon", type = UITool.Image},
    detailNameRect = {path = "root/DetailInfo/NameGroup", type = UITool.RectTransform},
    detailName = {path = "root/DetailInfo/NameGroup/Name", type = UITool.Text},
    detailNameArrow = {path = "root/DetailInfo/NameGroup/Arrow", type = UITool.GameObject},
    detailNameAfter = {path = "root/DetailInfo/NameGroup/NameAfter", type = UITool.Text},
    detailDescBefore = {path = "root/DetailInfo/DescBG1/ScrollView/Viewport/Desc", type = UITool.Text},
    detailDescAfter = {path = "root/DetailInfo/DescBG2/ScrollView/Viewport/Desc", type = UITool.Text},
    detailDescAfterObj = {path = "root/DetailInfo/DescBG2", type = UITool.GameObject},
    itemParent = {path = "root/DetailInfo/ItemParent", type = UITool.RectTransform},
    personGroup = {path = "root/DetailInfo/PersonGroup", type = UITool.GameObject},
    personUnlockBtn = {path = "root/DetailInfo/PersonGroup/UnlockBtn", type = UITool.Button},
    personUnlockBtnText = {path = "root/DetailInfo/PersonGroup/UnlockBtn/Text", type = UITool.Text},
    unlockText = {path = "root/DetailInfo/UnlockFlag", type = UITool.Text},
    guildGroup = {path = "root/DetailInfo/GuildGroup", type = UITool.GameObject},
    guildProgressProgressObj = {path = "root/DetailInfo/Progress", type = UITool.GameObject},
    guildProgressNum = {path = "root/DetailInfo/Progress/ProgressNum", type = UITool.Text},
    guildDonateGroup = {path = "root/DetailInfo/GuildGroup/DonateGroup", type = UITool.GameObject},
    guildDonateBtn = {path = "root/DetailInfo/GuildGroup/DonateGroup/DonateBtn", type = UITool.Button},
    guildRewardProgress = {path = "root/DetailInfo/GuildGroup/DonateGroup/RewardProgress", type = UITool.Text},
    guildSlider = {path = "root/DetailInfo/GuildGroup/DonateGroup/Slider", type = UITool.Slider},
    guildSubBtn = {path = "root/DetailInfo/GuildGroup/DonateGroup/SubBtn", type = UITool.Button},
    guildAddBtn = {path = "root/DetailInfo/GuildGroup/DonateGroup/AddBtn", type = UITool.Button},
    guildDonateBtnText = {path = "root/DetailInfo/GuildGroup/DonateGroup/DonateBtn/Text", type = UITool.Text},
    subTabParent = {path = "root/Left/SubTab", type = UITool.Transform},
    subTabTemplate = {path = "root/Left/SubTab/SubTabTemplate", type = UITool.GameObject}
}

local this = {

    techItems = {},

    techItemsCache = {},

    techItemsDic = {},

    consumeItems = {},

    consumeItemsDic = {},

    consumeItemsCache = {},
    personItemParentPosY = -197,
    guildItemParentPosY = -175,
    curSubTabIndex = nil,

    curTechType = nil,
    propsScale = 0.6,
    tempDonateTimes = 0,
    tabNames = {"Personal", "Guild", "Talent"},

    tabToggleNodes = {},
    parentSizeExtra = 0,
    origenParentSizeX = 0,
    fixPersonTechParentSizeX = 3017,
    fixGuildTechParentSizeX = 3617,
    fixHeroTechParentSizeX = 1400,
    isUpTeching = false
}

this.before_awake = function()
    SetActive(this.subTabTemplate, false)
    this.origenParentSizeX = this.techItemParent.sizeDelta.x
    for i = 1, 3 do
        local name = this.tabNames[i]

        local toggleNode = CommonToggleItem.New(this[name], nil, false, i, this.ClickPageToggle, this.tabToggleGroup)
        this.tabToggleNodes[i] = toggleNode
        local data = {}
        toggleNode:SetData(data)
    end
    SeasonSLGTechMgr.InitData()
end

this.ClickPageToggle = function(techType, value)
    if this.isChangingTab then
        return
    end
    if techType == SeasonSLGConst.TechType.Guild and PlayerGuildMgr.HaveGuild() == false then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("SeasonSLGTechPanel_0"))
        this.SetMainTab(this.curTechType, true)
        return
    end
    this.isUpTeching = false
    this.curTechType = techType
    this.SetMainTab(techType, value)
    this.OnClickBgBtn()
    this.RefreshTabData()
end

this.SetMainTab = function(index, value)
    if value == false then
        return
    end
    this.isChangingTab = true
    for i = 1, #this.tabToggleNodes do
        local on = i == index
        local node = this.tabToggleNodes[i]
        if node.toggle.isOn ~= on then
            node.toggle.isOn = on
        end
        node:SetIsOn(on)
    end
    this.isChangingTab = false
end

this.ClearSubTabs = function()
    for _, node in ipairs(this.subTabNodes or {}) do
        LuaMgr.DestroyGO(node.gameObject)
    end
    this.subTabNodes = {}
end

this.InitSubTabs = function()
    this.ClearSubTabs()
    if this.curTechType == SeasonSLGConst.TechType.Talent then

        this.curSubTabIndex = 1
        return
    end
    if this.techTabDatas == nil then
        return
    end
    local group = this.subTabParent:GetComponent(UITool.ToggleGroup)
    this.subTabNodes = {}
    for i, data in ipairs(this.techTabDatas) do
        local node = CommonToggleItem.New(this.subTabTemplate, this.subTabParent, true, i, this.ClickSubTab, group)
        node:SetData({nocheckText = data.Name, checkText = data.Name})
        local lock = node.gameObject.transform:Find("Background/LockFlagObj")
        local titleImag = node.gameObject.transform:Find("Background/TitleImage1")
        SetActive(lock.gameObject, data.IsUnlock ~= true)
        SetActive(titleImag.gameObject, data.IsUnlock == true)
        table.insert(this.subTabNodes, node)
    end
    local selected = 1
    for i, data in ipairs(this.techTabDatas) do
        if data.IsUnlock == true then
            selected = i
            break
        end
    end
    this.SetSubTab(selected, false)
end

this.SetSubTab = function(index, refresh)
    if this.techTabDatas == nil or this.techTabDatas[index] == nil then
        return
    end
    this.curSubTabIndex = index
    this.isChangingSubTab = true
    for i, node in ipairs(this.subTabNodes or {}) do
        local on = i == index
        node.toggle.isOn = on
        node:SetIsOn(on)
    end
    this.isChangingSubTab = false
    if refresh ~= false then
        this.InitPageAllTech()
    end
end

this.ClickSubTab = function(index, value)
    if value ~= true or this.isChangingSubTab then
        return
    end
    local data = this.techTabDatas and this.techTabDatas[index]
    if data == nil then
        return
    end
    if data.IsUnlock ~= true then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("SeasonSLGTechPanel_1"))
        this.SetSubTab(this.curSubTabIndex or 1, false)
        return
    end
    this.OnClickBgBtn()
    this.SetSubTab(index, true)
end

this.before_active = function()
    this.isUpTeching = false
    if this.behaviourParams ~= nil then
        this.curTechType = this.behaviourParams
        this.behaviourParams = nil
    end
    if this.curTechType == nil then
        this.curTechType = SeasonSLGConst.TechType.Person
    elseif this.curTechType == SeasonSLGConst.TechType.Guild and PlayerGuildMgr.HaveGuild() == false then
        this.curTechType = SeasonSLGConst.TechType.Person
    end
    this.SetMainTab(this.curTechType)
    if this.curSelectTechItem ~= nil then
        this.curSelectTechItem:SetSelected(false)
    end
    SetActive(this.detailInfoObj, false)
    this.RefreshTabData()
    SeasonSLGTechMgr.OnGetGuildTechData(this.RefreshPageAllTech)
end

this.RefreshTabData = function()
    local techDataDic, techTabDatas = SeasonSLGTechMgr.GetSeasonDatas(this.curTechType)
    this.techDataDic = techDataDic
    this.techTabDatas = techTabDatas
    this.InitSubTabs()
    this.InitPageAllTech()
    this.RefreshPageAllTech()
end

this.InitPageAllTech = function()
    this.RecycleItems()
    if this.techDataDic == nil or this.curSubTabIndex == nil then
        return
    end
    local pageTechDatas = this.techDataDic[this.curSubTabIndex]
    if pageTechDatas == nil then
        LuaDebug.error("赛季科技树页面刷新：配置错误")
        return
    end
    local sizeX = this.fixPersonTechParentSizeX
    if this.curTechType == SeasonSLGConst.TechType.Guild then
        sizeX = this.fixGuildTechParentSizeX
    elseif this.curTechType == SeasonSLGConst.TechType.Talent then
        sizeX = this.fixHeroTechParentSizeX
    end
    local sizeY = this.techItemParent.sizeDelta.y
    this.techItemParent.sizeDelta = Vector2(sizeX, sizeY)
    this.techItemsDic = {}
    for i = 1, #pageTechDatas do
        local data = pageTechDatas[i]
        data.OnClickTechItem = this.OnClickTechItem
        local item = this.GetTechItem()
        item:SetData(data)
        item:RefreshLine(false)
        table.insert(this.techItems, item)
        this.techItemsDic[data.ID] = item
    end
    for i = 1, #pageTechDatas do
        local data = pageTechDatas[i]
        if type(data.Config.Unlock) == "table" then
            for key, unlockID in pairs(data.Config.Unlock) do
                local tempUnlockItem = this.techItemsDic[unlockID]
                if tempUnlockItem ~= nil then
                    local isUnlock = tempUnlockItem.data.Status == SeasonSLGConst.TechStatus.Activate
                    tempUnlockItem:RefreshLine(true, isUnlock)
                end
            end
        end
    end
end

this.RefreshPageAllTech = function()
    local techDataDic, techTabDatas = SeasonSLGTechMgr.GetSeasonDatas(this.curTechType)
    this.techDataDic = techDataDic
    if this.techDataDic == nil or this.curSubTabIndex == nil then
        return
    end
    local pageTechDatas = this.techDataDic[this.curSubTabIndex]
    if pageTechDatas == nil then
        LuaDebug.error("赛季科技树页面刷新：配置错误165")
        return
    end
    for i = 1, #pageTechDatas do
        local data = pageTechDatas[i]
        SeasonSLGTechMgr.RefreshTechData(data.ID)
        data.OnClickTechItem = this.OnClickTechItem
        local item = this.techItemsDic[data.ID]
        if item ~= nil then
            item:SetData(data, this.isUpgradeTechID)
            item:RefreshLine(false)
        end
    end
    this.isUpgradeFlag = nil
    for i = 1, #pageTechDatas do
        local data = pageTechDatas[i]
        if type(data.Config.Unlock) == "table" then
            for key, unlockID in pairs(data.Config.Unlock) do
                local tempUnlockItem = this.techItemsDic[unlockID]
                if tempUnlockItem ~= nil then
                    local isUnlock = tempUnlockItem.data.Status == SeasonSLGConst.TechStatus.Activate
                    tempUnlockItem:RefreshLine(true, isUnlock)
                end
            end
        end
    end
end




this.OnClickTechItem = function(item)
    if this.curSelectTechItem ~= nil then
        this.curSelectTechItem:SetSelected(false)
    end
    this.curSelectTechItem = item
    this.curSelectTechItem:SetSelected(true)
    SetActive(this.detailInfoObj, true)
    this.RefreshCurTechDetailInfo()
    local techID = this.curSelectTechItem.data.ID
    local isMaxLevel = SeasonSLGTechMgr.CheckTechIsMaxLevel(techID)
    if this.curTechType == SeasonSLGConst.TechType.Guild and isMaxLevel == false then
        local curItem = this.curSelectTechItem
        local minTimes = 1000000000
        local maxTimes = SeasonSLGTechMgr.GetMaxDonateTimes(techID)
        local consumeItems = curItem.data.ConsumeItems[curItem.data.Level + 1]
        for i = 1, #consumeItems do
            local consumeData = consumeItems[i]
            local times = math.floor(consumeData.OwnerCount / consumeData.OnceNeedCount)
            minTimes = math.min(times, minTimes)
        end
        this.guildSlider.value = 0
        this.guildSlider.maxValue = math.min(maxTimes, minTimes)
        this.OnChangeSliderValue(0)
    end
end

this.OnChangeSliderValue = function(value)
    this.tempDonateTimes = value
    this.RefreshGuildConsumeItems()
end

this.RefreshCurTechDetailInfo = function()
    local curItem = this.curSelectTechItem
    if curItem == nil or curItem.data == nil then
        LuaDebug.error("this.RefreshCurTechDetailInfo 数据错误")
        return
    end
    SetActive(this.personGroup, false)
    SetActive(this.guildGroup, false)
    this.detailIcon.sprite = LuaMgr.GetSprite(SeasonSLGConst.SeasonSLGAtlas, curItem.data.Config.Img)
    this.detailName.text = SeasonSLGTechMgr.GetTechName(curItem.data.ID)
    local level = curItem.data.Level
    if curItem.data.Status ~= SeasonSLGConst.TechStatus.Activate then
        level = 1
    end
    local curInfo, txyType = SeasonSLGTechMgr.GetTechUpgradeInfoByID(curItem.data.ID, level)
    if txyType == SeasonSLGConst.TextType.TextLang then
        this.detailDescBefore.text = LuaMgr.GetLangText(curInfo)
    else
        this.detailDescBefore.text = curInfo
    end
    local isMaxLevel = SeasonSLGTechMgr.CheckTechIsMaxLevel(curItem.data.ID)
    if isMaxLevel == true or curItem.data.Status ~= SeasonSLGConst.TechStatus.Activate then
        SetActive(this.detailDescAfterObj, false)
    else
        SetActive(this.detailDescAfterObj, true)
        local curInfoAfter, txyTypeAfter = SeasonSLGTechMgr.GetTechUpgradeInfoByID(curItem.data.ID, curItem.data.Level + 1)
        if txyTypeAfter == SeasonSLGConst.TextType.TextLang then
            this.detailDescAfter.text = LuaMgr.GetLangText(curInfoAfter)
        else
            this.detailDescAfter.text = curInfoAfter
        end
    end
    this.RecycleConsumeItem()
    this.consumeItemsDic = {}
    local isMaxLevel = SeasonSLGTechMgr.CheckTechIsMaxLevel(curItem.data.ID)
    SetActive(this.detailNameArrow, false)
    SetActive(this.detailNameAfter.gameObject, false)
    if isMaxLevel == false then
        this.InitConsumeItems(curItem)
        SetActive(this.detailNameArrow, true)
        SetActive(this.detailNameAfter.gameObject, true)
        this.detailNameAfter.text = SeasonSLGTechMgr.GetTechName(curItem.data.ID, true)
    end
    local btnTxt = this.personUnlockBtnText
    if this.curTechType == SeasonSLGConst.TechType.Guild then
        btnTxt = this.guildDonateBtnText
    end
    if curItem.data.Status ~= SeasonSLGConst.TechStatus.Activate then
        btnTxt.text = LuaMgr.GetLangText("SeasonSLGTechPanel_2")
    else
        btnTxt.text = LuaMgr.GetLangText("SeasonSLGTechPanel_3")
    end
    if curItem.data.Status == SeasonSLGConst.TechStatus.Activate and isMaxLevel == true then
        this.unlockText.text = LuaMgr.GetLangText("SeasonSLGTechPanel_4")
    else
        this.unlockText.text = LuaMgr.GetLangText("SeasonSLGTechPanel_5")
    end
    SetActive(this.guildProgressProgressObj, false)
    this.detailNameRect.anchoredPosition = Vector2(434, 115)
    if this.curTechType ~= SeasonSLGConst.TechType.Guild then
        SetActive(this.personGroup, true)
        SetActive(this.personUnlockBtn.gameObject, isMaxLevel == false)
        SetActive(this.unlockText.gameObject, isMaxLevel == true)
        SetActive(this.itemParent.gameObject, isMaxLevel == false)
    else
        local guildUpPermission = SeasonSLGTechMgr.GetGuildUpPermission()
        if guildUpPermission == SeasonSLGConst.GuildTechUpPermissionType.Leader then
            this.guildRewardProgress.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35127")
        elseif guildUpPermission == SeasonSLGConst.GuildTechUpPermissionType.AllLeader then
            this.guildRewardProgress.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35127")
        end
        SetActive(this.guildGroup, true)
        local curCostMat = SeasonSLGTechMgr.GetGuildTechProgress(curItem.data.ID)
        local totalCostMat = SeasonSLGTechMgr.GetMaxDonateMatCount(curItem.data.ID)
        SetActive(this.unlockText.gameObject, isMaxLevel == true)
        SetActive(this.guildDonateGroup, isMaxLevel == false)
        SetActive(this.itemParent.gameObject, isMaxLevel == false)
        this.guildProgressNum.text = string.format("%.0f%%", curCostMat / totalCostMat * 100)
    end
end

this.InitConsumeItems = function(curItem)
    local level = curItem.data.Level + 1
    local consumeItems = curItem.data.ConsumeItems[level]
    this.costItemEnough = true
    for i = 1, #consumeItems do
        local consumeData = consumeItems[i]
        local consumeItem = this.GetConsumeItem()
        local data = {}
        data.scale = this.propsScale
        data.id = consumeData.ID
        data.count = 0
        data.hideRare = true
        data.orginData = consumeData
        if this.curTechType == SeasonSLGConst.TechType.Guild then
            data.infoShowCount = consumeData.OwnerCount
        end
        local ownerCountStr = LuaMgr.NumFormat(consumeData.OwnerCount)
        local needCountStr = LuaMgr.NumFormat(consumeData.OnceNeedCount)
        if consumeData.IsEnough == false then
            data.countText = string.format("<color=#CF64C9>%s</color>/%s", ownerCountStr, needCountStr)
            data.status = CommonRewardItem.Status.None
            this.costItemEnough = false
        else
            data.countText = string.format("%s/%s", ownerCountStr, needCountStr)
            data.status = CommonRewardItem.Status.Got
        end
        consumeItem:SetData1(data)
        table.insert(this.consumeItems, consumeItem)
    end
end

this.RefreshGuildConsumeItems = function()
    for key, item in pairs(this.consumeItemsDic) do
        local consumeData = item.data
        local needCount = consumeData.orginData.OnceNeedCount or 0
        this.totalCount = needCount * this.tempDonateTimes
        local selectCountStr = LuaMgr.NumFormat(this.totalCount)
        consumeData.countText = string.format("%s", selectCountStr)
        item:SetData1(consumeData)
    end









end



this.OnClickBgBtn = function()
    if this.curSelectTechItem ~= nil then
        this.curSelectTechItem:SetSelected(false)
        this.curSelectTechItem = nil
    end
    SetActive(this.detailInfoObj, false)
end

this.OnClickGuildDonateBtn = function()
    if this.isUpTeching == true then
        return
    end
    if this.curSelectTechItem.data.Status == SeasonSLGConst.TechStatus.Default then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("SeasonSLGTechPanel_8"))
        return
    end
    if this.costItemEnough == false then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("SeasonSLGTechPanel_12"))
        return
    end
    local guildUpPermission = SeasonSLGTechMgr.GetGuildUpPermission()
    local jobType = PlayerGuildMgr.GetPlayerJob()
    if guildUpPermission == SeasonSLGConst.GuildTechUpPermissionType.Leader and jobType ~= PlayerGuildMgr.JobType.Leader then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35127"))
        return
    elseif guildUpPermission == SeasonSLGConst.GuildTechUpPermissionType.AllLeader and jobType ~= PlayerGuildMgr.JobType.Leader and jobType ~= PlayerGuildMgr.JobType.ViceLeader then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35127"))
        return
    end
    this.isUpTeching = true
    local callback = function()
        this.isUpgradeTechID = this.curSelectTechItem.data.ID
        SeasonSLGTechMgr.RefreshTechData(this.curSelectTechItem.data.ID)
        this.RefreshPageAllTech()
        this.RefreshGuildConsumeItems()
        this.RefreshCurTechDetailInfo()
        this.isUpTeching = false
    end
    SeasonSLGTechMgr.OnAskGuildTechUpgrade(this.curSelectTechItem.data.ID, callback)
end

this.OnClickGuildSubBtn = function()
    local tempTimes = this.tempDonateTimes - 1
    tempTimes = math.max(tempTimes, 0)
    if this.tempDonateTimes == tempTimes then
        return
    end
    this.tempDonateTimes = tempTimes
    this.guildSlider.value = tempTimes
    this.RefreshGuildConsumeItems()
end

this.OnClickGuildAddBtn = function()
    local tempTimes = this.tempDonateTimes + 1
    tempTimes = math.min(tempTimes, this.guildSlider.maxValue)
    if this.tempDonateTimes == tempTimes then
        return
    end
    this.tempDonateTimes = tempTimes
    this.guildSlider.value = tempTimes
    this.RefreshGuildConsumeItems()
end

this.OnClickTalentBtn = function()
    this.ClickPageToggle(SeasonSLGConst.TechType.Talent, true)
end

this.OnClickPersonUnlockBtn = function()
    if this.isUpTeching == true then
        return
    end
    if this.curSelectTechItem.data.Status == SeasonSLGConst.TechStatus.Default then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("SeasonSLGTechPanel_11"))
        return
    end
    local isEnough = SeasonSLGTechMgr.CheckPersonTechIsEnough(this.curSelectTechItem.data.ID)
    if isEnough == false then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("SeasonSLGTechPanel_12"))
        return
    end
    this.isUpTeching = true
    local callback = function(techID)
        this.isUpgradeTechID = techID
        SeasonSLGTechMgr.RefreshTechData(techID)
        this.RefreshPageAllTech()
        this.RefreshGuildConsumeItems()
        this.RefreshCurTechDetailInfo()
        this.isUpTeching = false
    end
    SeasonSLGTechMgr.OnAskTechActivate(this.curSelectTechItem.data.ID, callback)
end


this.GetTechItem = function()
    local item = table.remove(this.techItemsCache)
    if item == nil then
        item = SeasonSLGTechItem.New(this.techPrefab, this.techItemParent.transform)
    end
    SetActive(item.gameObject, true)
    return item
end

this.GetConsumeItem = function()
    local item = table.remove(this.consumeItemsCache)
    if item == nil then
        local flag = CommonRewardItem.ResetStatusSlibing.Got
        item = CommonRewardItem.New(this.propsPrefab, false, this.propsScale, flag, this.itemParent)
    end
    SetActive(item.gameObject, true)
    return item
end

this.RecycleItems = function()
    for key, value in pairs(this.techItems) do
        SetActive(value.gameObject, false)
        table.insert(this.techItemsCache, value)
    end
    this.techItems = {}
    this.RecycleConsumeItem()
end

this.RecycleConsumeItem = function()
    for key, value in pairs(this.consumeItems) do
        SetActive(value.gameObject, false)
        table.insert(this.consumeItemsCache, value)
    end
    this.consumeItems = {}
end

this.OnDestroy = function()
    for key, value in pairs(this.techItems) do
        value:Destroy()
    end
    for key, value in pairs(this.techItemsCache) do
        value:Destroy()
    end
    for key, value in pairs(this.consumeItems) do
        value:Destroy()
    end
    for key, value in pairs(this.consumeItemsCache) do
        value:Destroy()
    end
    this.curSelectTechItem = nil
    this.curTechType = nil
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for i = 1, 3 do
            local name = this.tabNames[i]
            local path = "root/Left/Tab/" .. name
            objs[name] = {path = path, type = UITool.GameObject}
        end
        objs.tabGroup = {path = "root/Left/Tab", type = UITool.ToggleGroup}
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.tabToggleGroup = this.tabGroup
        LuaMgr.AddClick(this.bgBtn, this.OnClickBgBtn)
        LuaMgr.AddClick(this.techScrollViewBtn, this.OnClickBgBtn)
        LuaMgr.AddClick(this.guildDonateBtn, this.OnClickGuildDonateBtn)
        LuaMgr.AddClick(this.guildSubBtn, this.OnClickGuildSubBtn)
        LuaMgr.AddClick(this.guildAddBtn, this.OnClickGuildAddBtn)
        LuaMgr.AddClick(this.personUnlockBtn, this.OnClickPersonUnlockBtn)
        this.guildSlider.onValueChanged:AddListener(this.OnChangeSliderValue)

        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params ~= nil and vm.behaviour.Params.Length > 0 then
            this.behaviourParams = vm.behaviour.Params[0]
        end
        this.before_active()
    end,
    before_deactive = function(vm)
        this.RecycleItems()
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.bgBtn, this.OnClickBgBtn)
        LuaMgr.RemoveClick(this.techScrollViewBtn, this.OnClickBgBtn)
        LuaMgr.RemoveClick(this.guildDonateBtn, this.OnClickGuildDonateBtn)
        LuaMgr.RemoveClick(this.guildSubBtn, this.OnClickGuildSubBtn)
        LuaMgr.RemoveClick(this.guildAddBtn, this.OnClickGuildAddBtn)
        LuaMgr.RemoveClick(this.personUnlockBtn, this.OnClickPersonUnlockBtn)
        this.guildSlider.onValueChanged:RemoveListener(this.OnChangeSliderValue)
        this.ClearSubTabs()
        this.OnDestroy()
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)