local this = {
    vm=nil,
    data = {
        FetterItemPos = {
            Vector2(66, -50),
            Vector2(175, -50),
            Vector2(284, -50),
            Vector2(122, -139),
            Vector2(231, -139),
            Vector2(340, -139),
        },
        TemplateTr = nil,
        XYGroupTemplate = nil,
        XYGroupFetterTemplate = nil,
        XYGroupListContentTr = nil,
        XYGroupItemTrList = {},
        XYGroupFetterItemTrList = {},
        
        XYGroupDataList = {},
        selectCount = 0,
    }
};

local data = {
    selectTitle = "",
    selectFetterList = {{isInfo = false, icon = DefaultSprite, fettersName = "", isLock = false, fettersBuffDesc = ""}}
}

local command = {
    closeCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           LuaMgr.HidePanel(UIName.BattlePrepareFetterViewModel);
        end
    },
    confirmCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local param = {talents = {}}
            for i, v in ipairs(this.vm.data.selectFetterList) do
                if v.fettersId ~= nil then
                    param.talents[v.fettersId] = 1
                end
            end
            ApiMgr.Request("fetter/select", param, true,function(result)
                LuaMgr.InvokeUIEventListeners(UIEventConst.BattlePrepareFetterRefresh)
                LuaMgr.HidePanel(UIName.BattlePrepareFetterViewModel);
            end, nil, true)
        end
    },
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.Init()
        this.Refresh()
    end,
    before_deactive = function(vm)
       
    end,
}

this.Init = function()
    if this.data.TemplateTr == nil then
        this.data.TemplateTr = this.vm.behaviour.transform:Find("template")
        this.data.TemplateTr.gameObject:SetActive(false)
    end
    if this.data.XYGroupTemplate == nil then
        this.data.XYGroupTemplate = this.data.TemplateTr:Find("YXGroupTemplate")
    end
    if this.data.XYGroupFetterTemplate == nil then
        this.data.XYGroupFetterTemplate = this.data.TemplateTr:Find("YXFettersTemplate")
    end
    if this.data.XYGroupListContentTr == nil then
        this.data.XYGroupListContentTr = this.vm.behaviour.transform:Find("root/Middle/Fetter/YXGroupList")
    end
end

this.Refresh=function()
    this.SetYXGroupList()
    this.RefreshSelectedFetterList()
end

this.SetYXGroupList = function()
    local groupMap = ConfigMgr.Config.PracticePeriodMaps
    local fetterMap = ConfigMgr.Config.OriginsTalentMap
    local selectFetterMap = DataMgr.Player.selectedRelicsTalent
    local teleten = ConfigMgr.Config.talentBankMap
    this.data.XYGroupDataList = {}
    this.data.selectCount = 0
    local tempXYGroupMap = {}
    for k, v in pairs(fetterMap) do
        if tempXYGroupMap[v.Map] == nil then
            local groupCfg = groupMap[v.Map]




            tempXYGroupMap[v.Map] = {
                groupName = LuaMgr.GetLangText(groupCfg.mapnamelan),
                openTime = groupCfg.openTime,
                closeTime = groupCfg.closeTime,
                fetterList = {}
            }
        end
        local isUnlock = not IsNull(DataMgr.Player.originsTalent) and DataMgr.Player.originsTalent[v.OriginsID] ~= nil
        local item = {
            fettersId = v.OriginsID,
            isSelect = isUnlock and selectFetterMap[v.OriginsID] ~= nil,
            isUnlock = isUnlock,
            order = v.OtOrder,
        }
        this.data.selectCount = this.data.selectCount + (item.isSelect and 1 or 0)
        if v.TalentId ~= nil and #v.TalentId > 0 and v.TalentId[1] ~= nil then
            local talentCfg = teleten[v.TalentId[1]]
            item.icon = LuaMgr.GetSprite("AttributeIcon",talentCfg.showTypeIcon)
        end
        table.insert(tempXYGroupMap[v.Map].fetterList, item)

    end

    for k, v in pairs(tempXYGroupMap) do
        table.sort(v.fetterList, function(a, b) return a.order < b.order end)
        table.insert(this.data.XYGroupDataList, v)
    end
    table.sort(this.data.XYGroupDataList, function(a, b) return a.openTime < b.openTime end)

    local groupIndex = 1
    local fetterIndex = 1
    for i = 1, #this.data.XYGroupDataList do
        groupIndex = i
        local groupData = this.data.XYGroupDataList[groupIndex]
        if groupIndex > #this.data.XYGroupItemTrList then
            table.insert(this.data.XYGroupItemTrList, LuaMgr.InstantiateGO(this.data.XYGroupTemplate.gameObject, this.data.TemplateTr, false).transform)
        end
        local groupTr = this.data.XYGroupItemTrList[groupIndex]
        groupTr:SetParent(this.data.XYGroupListContentTr)
        groupTr.localScale = Vector3.one
        groupTr:Find("YXTitle"):GetComponent("Text").text = LuaMgr.Replace(groupData.groupName,"\n","")
        
        local fetterListContentTr = groupTr:Find("FetterGroup")
        for j, fetterData in ipairs(groupData.fetterList) do
            fetterIndex = this.GetFetterIndex(groupIndex, j)
            if fetterIndex > #this.data.XYGroupFetterItemTrList then
                table.insert(this.data.XYGroupFetterItemTrList, LuaMgr.InstantiateGO(this.data.XYGroupFetterTemplate.gameObject, this.data.TemplateTr, false).transform)
            end
            
            local fetterTr = this.data.XYGroupFetterItemTrList[fetterIndex]
            fetterTr:SetParent(fetterListContentTr)
            fetterTr.anchoredPosition = this.data.FetterItemPos[j]
            fetterTr.localScale = Vector3.one
            
            local fetterIcon = fetterTr:Find("Icon"):GetComponent("Image")
            fetterIcon.sprite = fetterData.icon
            local fetterBtn = fetterTr:Find("Bg"):GetComponent("Button")
            fetterBtn.onClick:RemoveAllListeners()
            fetterTr:Find("Select").gameObject:SetActive(fetterData.isSelect)
            fetterTr:Find("Lock").gameObject:SetActive(not fetterData.isUnlock)
            LuaMgr.AddClick(fetterBtn, function() this.OnClickFetterItem(i, j) end)
        end
    end

    for i = groupIndex + 1, #this.data.XYGroupItemTrList do
        this.data.XYGroupItemTrList[i]:SetParent(this.data.TemplateTr)
    end
    for i = fetterIndex + 1, #this.data.XYGroupFetterItemTrList do
        this.data.XYGroupFetterItemTrList[i]:SetParent(this.data.TemplateTr)
    end
end

this.RefreshSelectedFetterList = function()
    local unlockTalentCount = 0
    if not IsNull(DataMgr.Player.originsTalent) then
        local originsTalent = DataMgr.Player.originsTalent
        for k, v in pairs(originsTalent) do
            unlockTalentCount = unlockTalentCount + 1
            if unlockTalentCount >= 6 then
                break
            end
        end
    end
    local tempList = {}
    local teleten = ConfigMgr.Config.talentBankMap
    local selectIndex = 0
    for i, v in ipairs(this.data.XYGroupDataList) do
        for j, n in ipairs(v.fetterList) do
            if n.isSelect then
                selectIndex = selectIndex + 1
                local fettersCfg = ConfigMgr.Config.OriginsTalentMap[n.fettersId]
                local tempItem = {
                    fettersId = n.fettersId,
                    isInfo = selectIndex <= unlockTalentCount,
                    fettersName = LuaMgr.GetLangText(fettersCfg.OtNameLan),
                    icon = n.icon,
                    fettersBuffDesc = LuaMgr.GetLangText(teleten[fettersCfg.TalentId[1]].DescriptionLan),
                    isLock = selectIndex > unlockTalentCount
                }
                table.insert(tempList, tempItem)
            end
        end
    end

    this.vm.data.selectTitle = string.format(LuaMgr.GetLangText("BattlePrepareFetterViewModel_0"), #tempList, 6)

    for i = #tempList + 1, 6 do
        table.insert(tempList, {
            isInfo = false,
            isLock = i > unlockTalentCount
        })
    end

    this.vm.data.selectFetterList = tempList
end

this.GetFetterIndex = function(i, j)
    return (i - 1) * 6 + j
end

this.OnClickFetterItem = function(i, j)
    local isSelected = this.data.XYGroupDataList[i].fetterList[j].isSelect
    local isUnlock = this.data.XYGroupDataList[i].fetterList[j].isUnlock
    if not isUnlock or (not isSelected and this.data.selectCount == 6) then
        return
    end
    this.data.selectCount = this.data.selectCount + (isSelected and -1 or 1)
    this.data.XYGroupDataList[i].fetterList[j].isSelect = not isSelected
    this.data.XYGroupFetterItemTrList[this.GetFetterIndex(i, j)]:Find("Select").gameObject:SetActive(not isSelected)
    
    this.RefreshSelectedFetterList()
end

return vm({
    data = data,
    command = command,
    hook = hook
})