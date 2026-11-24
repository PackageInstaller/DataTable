




require("ViewModel/MoreTeamlineup/TeamlineupItem")

local this = {
    vm = nil,permanentList = nil,
    scrollMaxHeight = 466,
    scrollView = nil,teamlineupItem = nil,
    curIndex = nil,
}

local data = {
    infoNameText = "",
    infoTime = false,infoTimeText = "",
    updateTime = false,updateTimeText = "",rewardTipText = "",gotoBtnText = "",
    scoreRoot = false,scoreText = "",scrollSizeDeltaBg = Vector2.zero,
    coverTexture = DefaultTexture,nameTexture = DefaultTexture,texture = DefaultTexture,
    rewardList = {{itemRare = DefaultSprite,itemIcon = DefaultTexture}},
    uiAnimName = "",
}

local command = {
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            local id = this.vm.data.rewardList[index].id
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,id,false,false,false,0,0);
        end
    },
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            HeroParameter.PermanentIndex = this.curIndex
            local tempConfig = this.permanentList[this.curIndex]
            if not IsNullOrEmpty(tempConfig.InterfaceId) and tempConfig.InterfaceId == "11001" then
                if TrainingDungeonHelper.CheckOpenTime() then
                    FeatureManager.GotoViewModel("11001")
                else
                    this.permanentList = nil
                    this.InitParameter()
                end
            else
                local activityConfig = ConfigMgr.Config.activityGroup[tempConfig.Id]
                if not TableIsNull(activityConfig) and not TableIsNull(activityConfig.IconPanel) then
                    LuaMgr.ShowLuaPanel(activityConfig.IconPanel[1])
                end
















            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.teamlineupItem = vm.behaviour.transform:Find("template/TeamlineupItem").gameObject
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Left/Group/ScrollView").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.permanentList = nil
        this.scrollView:Clear(false)
        this.vm.data.rewardList = {}
        this.vm.data.uiAnimName = ""
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("TeamlineupItem")
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()
    LuaMgr.RemoveTimer(TimerConst.MoreTeamlineupUpdataInfo)
    LuaMgr.RemoveTimer(TimerConst.MoreTeamlineupUpdataName)
end


this.InitParameter = function()
    HeroParameter.CurPlotLabel = nil
    this.GetPermanentConfig()
    this.ScrollAdaptive()
    this.CreateActivityItem()
end


this.SetLanguageText = function()
    this.vm.data.rewardTipText = ConfigMgr.LangGlobal("31253")
    this.vm.data.gotoBtnText = ConfigMgr.LangGlobal("31254")
end


this.ScrollAdaptive = function()
    if TableIsNull(this.permanentList) then
        return
    end
    local itemNum = #this.permanentList + 1

    local height = ((79 + 4) * itemNum) + 5
    if height > this.scrollMaxHeight then
        height = this.scrollMaxHeight
    end
    this.scrollView.gameObject.transform.sizeDelta = Vector2(240,height)
    height = height + 18
    this.vm.data.scrollSizeDeltaBg = Vector2(240,height)
end

this.CreateActivityItem = function()
    if TableIsNull(this.permanentList) then
        return
    end
    if HeroParameter.PermanentIndex == nil then
        this.curIndex = 1
    else
        this.curIndex = HeroParameter.PermanentIndex
    end
    this.scrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #this.permanentList do
        groupData = {}
        groupData.data = this.permanentList[i]
        groupData.index = this.curIndex
        groupData.callBack = this.TeamlineupClick
        scrollData = UIScrollData.GetData(this.teamlineupItem,"TeamlineupItem",222,79 + 4,groupData)
        table.insert(scrollDatas,scrollData)
    end


    groupData = {}
    groupData.data = nil
    scrollData = UIScrollData.GetData(this.teamlineupItem,"TeamlineupItem",222,79 + 4,groupData)
    table.insert(scrollDatas,scrollData)

    local sizeDelta = this.scrollView.gameObject.transform.sizeDelta
    this.scrollView:SetParams(sizeDelta.x,sizeDelta.y)
    this.scrollView:SetPadding(0,0,-5,0)
    this.scrollView:SetData(scrollDatas, true)
    this.UpdateSelectInfo()
end

this.TeamlineupClick = function(index,param)
    if index == nil or TableIsNull(param) then
        return
    end
    if this.curIndex == index then
        return
    end
    this.curIndex = index
    local length = #this.scrollView.dataList - 1
    for i = 1, length do
        this.scrollView.dataList[i].data.index = this.curIndex
    end
    this.scrollView:Refresh()
    this.UpdateSelectInfo("playAnim")
end


this.UpdateSelectInfo = function(playAnim)
    if this.curIndex == nil or this.curIndex < 1 then
        return
    end
    local tempConfig = this.permanentList[this.curIndex]
    local tipStr = ConfigMgr.LangGlobal("31250")
    this.vm.data.infoNameText = string.format(tipStr,LuaMgr.GetLangText(tempConfig.ThemeNameLan))
    if not IsNullOrEmpty(tempConfig.InterfaceId) and tempConfig.InterfaceId == "11001" then
        this.vm.data.infoTime = false
        this.vm.data.updateTime = false
        this.vm.data.scoreRoot = false
    else

        local startTime,endTime = this.GetZSLBDDungeonTime()
        local nowTime = LuaMgr.Timestamp()
        local isShow = nowTime >= startTime and nowTime < endTime
        if isShow then
            local remainingTime = endTime - nowTime
            local day,hour,min = GetTimeDHM2(remainingTime)
            local timeStr = ConfigMgr.LangGlobal("31252")
            this.vm.data.updateTimeText = string.format(timeStr,day,hour,min)

            if remainingTime <= tempConfig.EndDays * 86400 then
                timeStr = ConfigMgr.LangGlobal("31255")
                this.vm.data.infoTimeText = string.format(timeStr,day > 0 and day or 1)
                this.vm.data.infoTime = true
            else
                this.vm.data.infoTime = false
            end
            this.vm.data.scoreText = string.format(ConfigMgr.LangGlobal("31251"),TeamRelay2Mgr.GetTeamRelay2TotalScore())
        else
            this.vm.data.infoTime = false
        end
        this.vm.data.updateTime = isShow
        this.vm.data.scoreRoot = isShow
    end
    this.SetReward(tempConfig.Rewards)
    this.vm.data.coverTexture = LuaMgr.GetTexture(Path.MoreTeamlineupBg_Path..tempConfig.Id.."_bg.png")
    if playAnim ~= nil then
        this.vm.data.uiAnimName = "ani_MoreTeamlineupPanel_CoverTexture"
        LuaMgr.AddTimer(TimerConst.MoreTeamlineupUpdataInfo,function()
            this.vm.data.nameTexture = LuaMgr.GetTexture(Path.MoreTeamlineupBg_Path..tempConfig.Id.."_name.png")
            this.vm.data.texture = LuaMgr.GetTexture(Path.MoreTeamlineupBg_Path..tempConfig.Id.."_texture.png")
            LuaMgr.RemoveTimer(TimerConst.MoreTeamlineupUpdataInfo)
        end,0.27,1,false)
        LuaMgr.AddTimer(TimerConst.MoreTeamlineupUpdataName,function()
            this.vm.data.uiAnimName = "ani_MoreTeamlineupPanel_CoverTexture2"
            LuaMgr.RemoveTimer(TimerConst.MoreTeamlineupUpdataName)
        end,0.3,1,false)
    else
        this.vm.data.nameTexture = LuaMgr.GetTexture(Path.MoreTeamlineupBg_Path..tempConfig.Id.."_name.png")
        this.vm.data.texture = LuaMgr.GetTexture(Path.MoreTeamlineupBg_Path..tempConfig.Id.."_texture.png")
    end
end


this.GetZSLBDDungeonTime = function()
    for key,value in pairs(ConfigMgr.Config.TeamRelayMap) do
        if value.ActivityGroup == TeamRelay2Mgr.activityGroupId and value.IsCommon == 0 then
            return value.StartTime,value.EndTime
        end
    end
    return 0,0
end

this.SetReward = function(rewards)
    this.vm.data.rewardList = {}
    if TableIsNull(rewards) then
        return
    end
    local tempData,tempList = nil,{}
    local tempConfig = nil
    for i = 1, #rewards do
        tempConfig = ConfigHelper.GetItemById(rewards[i])
        if not TableIsNull(tempConfig) then
            tempData = {itemRare = DefaultSprite,itemIcon = DefaultTexture}
            tempData.itemRare = ConfigHelper.GetRareSprite(tempConfig.rare)
            tempData.itemIcon =ConfigHelper.GetItemTexture(tempConfig.id)
            tempData.id = tempConfig.id
            table.insert(tempList,tempData)
        end
    end
    this.vm.data.rewardList = tempList
end

this.GetPermanentConfig = function()
    if TableIsNull(ConfigMgr.Config.PermanentGroupMap) then
        return
    end
    this.permanentList = {}
    for key,value in pairs(ConfigMgr.Config.PermanentGroupMap) do
        if not IsNullOrEmpty(value.InterfaceId) and value.InterfaceId == "11001" then

            if TrainingDungeonHelper.CheckOpenTime() then
                table.insert(this.permanentList,value)
            end
        else



            table.insert(this.permanentList,value)
        end
    end
    table.sort(this.permanentList,function(a,b)
        return a.Id > b.Id
    end)
end

return vm({
    data = data,
    command = command,
    hook = hook
})