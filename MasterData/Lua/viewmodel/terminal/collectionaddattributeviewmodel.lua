




require("ViewModel/Terminal/AddAttributeHeroItem")
require("ViewModel/Terminal/CollectionAddAttrGroup")
require("ViewModel/Terminal/CollectionAddAttrItem")

local this = {
    vm = nil,tableInsert = table.insert,
    characterJob = nil,labelIndex = nil,
    heroConfig = nil,isClickActive = true,
    heroScrollView = nil,addAttributeHeroItem = nil,
    attrScrollView = nil,collectionAddAttrGroup = nil,collectionAddAttrItem = nil,
    coroutine_key = nil,redList = nil,resultShowName = nil,
    beforeAttr = nil,laterAttr = nil,
}

local data = {
    labelItem = {{normal = false,choose = false,jobDi = DefaultSprite,jobIcon = DefaultSprite,
                  job_m_Icon = DefaultSprite,jobText = "",job = 0,red = false},
                 {normal = false,choose = false,jobDi = DefaultSprite,jobIcon = DefaultSprite,
                  job_m_Icon = DefaultSprite,jobText = "",job = 0,red = false},
                 {normal = false,choose = false,jobDi = DefaultSprite,jobIcon = DefaultSprite,
                  job_m_Icon = DefaultSprite,jobText = "",job = 0,red = false},
                 {normal = false,choose = false,jobDi = DefaultSprite,jobIcon = DefaultSprite,
                  job_m_Icon = DefaultSprite,jobText = "",job = 0,red = false},
                 {normal = false,choose = false,jobDi = DefaultSprite,jobIcon = DefaultSprite,
                  job_m_Icon = DefaultSprite,jobText = "",job = 0,red = false}},
    attrTip = "",attrTip1 = "",attrTip2 = "",nullText = "",nullRoot = false,scrollTip = false,
    infoJobIcon = DefaultSprite,activeNum = "",allBtn = false,allBtnText = "",infoJobTip = "",
    activePopup = false,popupTip = "",
    starPopup = false,allUpStarBtn = false,allStarBtnText = "",
    allBrilliantBtn = false,allBrilliantBtnText = "",
    oneAttrRoot = false,one_AttrIcon = DefaultSprite,one_AttrName = "",one_AttrValue = "",
    addAttrItem = {{attrIcon = DefaultSprite,attrName = "",newImg = false,laterValue = "",before = false,beforeValue = ""}},
    attrPopup = false,attrRoot = Vector2.zero,popupIcon = DefaultSprite,popupName = "",popupValue = "",
    popupNotMax = false,popupIsMax = false,popupInfinite = false,
    starImgText = false,brilliantImgText = false,
}

local command = {
    labelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.heroScrollView.scrollRect:StopMovement()
            local index = tonumber(param)
            this.vm.data.labelItem[this.labelIndex].normal = true
            this.vm.data.labelItem[this.labelIndex].choose = false
            this.labelIndex = index
            this.vm.data.labelItem[this.labelIndex].normal = false
            this.vm.data.labelItem[this.labelIndex].choose = true
            this.SetHeroView()
            this.SetJobAddAttr()
            this.SetJobDetails()
            this.isClickActive = true
        end
    },
    allActiveCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.HeroActiveAll()
        end
    },
    allUpStarCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.HeroUpStarAll()
        end
    },
    closePopupCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.vm.data.activePopup = false
            this.vm.data.starPopup = false
            this.vm.data.attrPopup = false
        end
    },
    allBrilliantCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.HeroBrilliantAll()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.addAttributeHeroItem = vm.behaviour.transform:Find("template/AddAttributeHeroItem").gameObject
        this.heroScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/_Middle/Content/HeroView").gameObject)
        this.collectionAddAttrGroup = vm.behaviour.transform:Find("template/CollectionAddAttrGroupItem").gameObject
        this.collectionAddAttrItem = vm.behaviour.transform:Find("template/CollectionAddAttrItem").gameObject
        this.attrScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/_Middle/Content/Details/Attribute/AttrListView").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
        this.vm.data.activePopup = false
        this.vm.data.starPopup = false
        this.vm.data.attrPopup = false
        this.heroConfig = nil
        this.heroScrollView:Clear(false)
        this.attrScrollView:Clear(false)
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("AddAttributeHeroItem")
        UIScrollView.ClearItem("CollectionAddAttrGroup")
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.SetLanguageText = function()
    this.vm.data.allBtnText = ConfigMgr.LangGlobal("17306")
    this.vm.data.allStarBtnText = ConfigMgr.LangGlobal("17308")
    this.vm.data.attrTip1 = ConfigMgr.LangGlobal("17303")
    this.vm.data.nullText = ConfigMgr.LangGlobal("17304")
    this.vm.data.allBrilliantBtnText = ConfigMgr.LangGlobal("17320")

end


this.InitParameter = function()
    this.isClickActive = true
    this.labelIndex = 1
    
    this.InitJobConfig()
    this.SetLabelItem()
    
    this.InitHeroConfig()
    this.SetHeroView()
    this.UpdateLabelRed()
    this.SetJobAddAttr()
    
    this.SetJobDetails()
end


this.SetLabelItem = function()
    if TableIsNull(this.characterJob) then return end
    local jobDiSprite,jobIconSprite,job_m_IconSprite = nil,nil,nil
    for i = 1, #this.characterJob do
        jobDiSprite = LuaMgr.GetSprite("JobIcon", "jobdi_"..this.characterJob[i].job)
        jobIconSprite = LuaMgr.GetSprite("JobIcon", "jodmax_"..this.characterJob[i].job)
        job_m_IconSprite = LuaMgr.GetSprite("JobIcon", "jodm_"..this.characterJob[i].job)
        this.vm.data.labelItem[i].job = this.characterJob[i].job
        this.vm.data.labelItem[i].normal = i ~= this.labelIndex
        this.vm.data.labelItem[i].choose = i == this.labelIndex
        this.vm.data.labelItem[i].jobDi = jobDiSprite
        this.vm.data.labelItem[i].jobIcon = jobIconSprite
        this.vm.data.labelItem[i].job_m_Icon = job_m_IconSprite
        this.vm.data.labelItem[i].jobText = this.characterJob[i].name
        this.vm.data.labelItem[i].red = false
    end
end

this.UpdateLabelRed = function()
    for i = 1, #this.characterJob do
        this.vm.data.labelItem[i].red = this.redList[this.characterJob[i].job] > 0
    end
end


this.SetHeroView = function()
    if TableIsNull(this.heroConfig) then return end
    local activeCount = 0
    local canActiveCount = 0
    local canStarCount = 0
    local canBrilliantCount = 0
    this.heroScrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local job = this.vm.data.labelItem[this.labelIndex].job
    for i = 1, #this.heroConfig[job] do
        if this.heroConfig[job][i].state == 4 or this.heroConfig[job][i].state == 2 or this.heroConfig[job][i].state == 3 then
            activeCount = activeCount + 1
        end
        if this.heroConfig[job][i].state == 1 then
            canActiveCount = canActiveCount + 1
        end
        if this.heroConfig[job][i].state == 2 then
            canStarCount = canStarCount + 1
        end
        if this.heroConfig[job][i].state == 3 then
            canBrilliantCount = canBrilliantCount + 1
        end
        groupData = {}
        groupData.data = this.heroConfig[job][i]
        groupData.activeFun = this.HeroActive
        groupData.starFun = this.HeroStar
        groupData.brilliantFun = this.HeroBrilliant
        groupData.animBool = i >= 7
        scrollData = UIScrollData.GetData(this.addAttributeHeroItem,"AddAttributeHeroItem",236,428,groupData)
        this.tableInsert(scrollDatas,scrollData)
    end
    local width = LuaMgr.GetScreenAddWidth() > 3 and 1305 or 1106
    this.heroScrollView:SetParams(width,510)
    this.heroScrollView:SetPadding(20,90,0,0)
    this.heroScrollView:SetData(scrollDatas, true)
    this.vm.data.nullRoot = activeCount <= 0
    this.vm.data.allBtn = canActiveCount > 0
    this.vm.data.allUpStarBtn = canActiveCount <= 0 and canStarCount > 0
    this.vm.data.allBrilliantBtn = canActiveCount <= 0 and canStarCount <= 0 and canBrilliantCount > 0
    this.vm.data.activeNum = activeCount..string.format("<size=42><color=#828282>/%s</color></size>",#this.heroConfig[job])
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.coroutine_key = coroutine_runner.start(function()
        for i = 1, #this.heroScrollView.dataList do
            this.heroScrollView.dataList[i].data.animBool = true
            if this.heroScrollView.itemMap[i] ~= nil then
                SetActive(this.heroScrollView.itemMap[i].animatorObj,true)
            end
            coroutine_runner.wait(0.05)
        end
    end)
end


this.SetJobAddAttr = function()

    local tempList = this.StatisticsAttr()
    local attrList = this.GetAttrSort(tempList)
    this.laterAttr = tempList
    tempList = nil
    local length = #attrList
    this.attrScrollView:Clear(false)
    if length == 1 then
        this.vm.data.one_AttrIcon = LuaMgr.GetSprite("AttributeIcon",attrList[1].icon)
        this.vm.data.one_AttrName = attrList[1].name
        this.vm.data.one_AttrValue = "+"..attrList[1].value..attrList[1].type
        this.vm.data.oneAttrRoot = true
    else
        this.vm.data.oneAttrRoot = false

        local scrollData,scrollDatas = {},{}
        local groupData = nil
        local index = 1
        while (index <= length) do
            groupData = {}
            groupData.item = this.collectionAddAttrItem
            groupData.callback = this.AttrItemClick
            groupData.attr = {}
            for i = 1, 2 do
                if attrList[index + i - 1] ~= nil then
                    this.tableInsert(groupData.attr,attrList[index + i - 1])
                end
            end
            scrollData = UIScrollData.GetData(this.collectionAddAttrGroup,"CollectionAddAttrGroup",668,30 + 8.5,groupData)
            this.tableInsert(scrollDatas,scrollData)
            index = index + 2
        end
        this.attrScrollView:SetParams(668,125)
        this.attrScrollView:SetPadding(0,0,-8,-8)
        this.attrScrollView:SetData(scrollDatas, true)
    end
    this.vm.data.scrollTip = length > 6
end


this.StatisticsAttr = function()
    local attrList = {}
    local job = this.vm.data.labelItem[this.labelIndex].job
    local attr = nil
    local attrName,attrValue,attrType,iconName = nil,nil,nil,nil
    local sort,index = nil,0
    local typeKey = nil
    for i = 1, #this.heroConfig[job] do
        if this.heroConfig[job][i].state == 4 or this.heroConfig[job][i].state == 2 or this.heroConfig[job][i].state == 3 then
            for j = 1, #this.heroConfig[job][i].attr do
                attr = nil
                if j == 1 then
                    attr = ConfigMgr.Config.talentBankMap[this.heroConfig[job][i].attr[j]]
                elseif j > 1 and j <= 7 then

                    if this.heroConfig[job][i].attr[j] ~= "" then
                        typeKey = this.heroConfig[job][i].id.."_star_"..j - 1
                        if DataMgr.Player.jobExtraAttr[typeKey] ~= nil then
                            attr = ConfigMgr.Config.talentBankMap[this.heroConfig[job][i].attr[j]]
                        end
                    end
                else

                    if this.heroConfig[job][i].attr[j] ~= "" then
                        typeKey = this.heroConfig[job][i].id.."_brilliant_1"
                        if DataMgr.Player.jobExtraAttr[typeKey] ~= nil then
                            attr = ConfigMgr.Config.talentBankMap[this.heroConfig[job][i].attr[j]]
                        end
                    end
                end
                if not TableIsNull(attr) and attr.type == 2 then
                    attrName,attrValue,attrType,iconName = ConfigHelper.GetAttrNameStr(attr.id)

                    if attrList[iconName] == nil then
                        sort = ConfigMgr.Config.BestiarySSortMap[iconName]
                        index = sort == nil and 0 or sort.Sort
                        attrList[iconName] = {name = attrName,value = tonumber(attrValue),type = attrType,icon = iconName,index = index}
                    else
                        attrList[iconName].value = attrList[iconName].value + tonumber(attrValue)
                    end
                end
            end
        end
    end

    for key,value in pairs(attrList) do
        sort = ConfigMgr.Config.BestiarySSortMap[key]
        if not TableIsNull(sort) then
            if sort.MaxValue > 0 and value.value > sort.MaxValue then
                value.value = sort.MaxValue
            end
        end
    end
    return attrList
end

this.AttrItemClick = function(tempData,sort,post)
    if TableIsNull(tempData) or TableIsNull(sort) then
        return
    end
    this.vm.data.popupName = tempData.name
    this.vm.data.popupValue = "+"..tempData.value..tempData.type
    this.vm.data.popupIcon = LuaMgr.GetSprite("AttributeIcon",tempData.icon)
    this.vm.data.popupInfinite = sort.MaxValue <= 0
    this.vm.data.popupNotMax = sort.MaxValue > 0 and tempData.value < sort.MaxValue
    this.vm.data.popupIsMax = sort.MaxValue > 0 and tempData.value >= sort.MaxValue
    
    local strFormat,tipStr = "",""
    if sort.MaxValue > 0 then
        strFormat = ConfigMgr.LangGlobal("17318")
        tipStr = string.format(strFormat,tempData.name,sort.MaxValue)..tempData.type
    else
        strFormat = ConfigMgr.LangGlobal("17319")
        tipStr = strFormat
    end
    this.vm.data.attrTip = tipStr
    local rect = this.vm.behaviour.transform:Find("root/_Middle/AttrPopup"):GetComponent("RectTransform")
    local localPost = LuaMgr.World2Local(post,rect)
    this.vm.data.attrRoot = Vector2(localPost.x + 164,localPost.y)
    this.vm.data.attrPopup = true
end


this.GetAttrSort = function(tempList)
    local attrList = {}
    for key,value in pairs(tempList) do
        this.tableInsert(attrList,value)
    end
    table.sort(attrList,this.AttrSort)
    return attrList
end


this.SetJobDetails = function()
    local job = this.vm.data.labelItem[this.labelIndex].job
    local iconSprite = LuaMgr.GetSprite("JobIcon", "job_"..job)
    this.vm.data.infoJobIcon = iconSprite
    this.vm.data.infoJobTip = string.format(ConfigMgr.LangGlobal("17301"),this.characterJob[job].name)
    this.vm.data.attrTip2 = string.format(ConfigMgr.LangGlobal("17302"),this.characterJob[job].name)











end


this.HeroActive = function(param)
    if this.isClickActive then
        this.isClickActive = false
        local tempData = {}
        tempData["Id"] = param.id
        tempData["Type"] = "level"
        tempData["Value"] = param.level
        this.beforeAttr = this.StatisticsAttr()
        ApiMgr.Request("jobextraattr/unlock", tempData, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.RefreshUI(true,nil)
            end
        end, nil, true)
    end
end

this.HeroStar = function(param)
    if this.isClickActive then
        this.isClickActive = false
        local tempData = {}
        tempData["Ids"] = {}
        local typeKey = nil
        for i = 1, 6 do
            if i <= param.star and param.attr[i + 1] ~= "" then
                typeKey = param.id.."_star_"..i
                if DataMgr.Player.jobExtraAttr[typeKey] == nil then
                    this.tableInsert(tempData.Ids,typeKey)
                end
            end
        end
        this.beforeAttr = this.StatisticsAttr()
        ApiMgr.Request("jobextraattr/unlock", tempData, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.RefreshUI(false,true)
            end
        end, nil, true)
    end
end

this.HeroBrilliant = function(param)
    if this.isClickActive then
        this.isClickActive = false
        local tempData = {}
        tempData["Id"] = param.id
        tempData["Type"] = "brilliant"
        tempData["Value"] = 1
        this.beforeAttr = this.StatisticsAttr()
        ApiMgr.Request("jobextraattr/unlock", tempData, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.RefreshUI(false,false)
            end
        end, nil, true)
    end
end

this.HeroActiveAll = function()
    if this.isClickActive then
        this.isClickActive = false
        this.resultShowName = {}
        local tempList = {}
        local job = this.vm.data.labelItem[this.labelIndex].job
        for i = 1, #this.heroConfig[job] do
            if this.heroConfig[job][i].state == 1 then
                this.resultShowName[this.heroConfig[job][i].name] = 1
                this.tableInsert(tempList,this.heroConfig[job][i].id.."_level_"..this.heroConfig[job][i].level)
            end
        end
        local tempData = {}
        tempData.Ids = tempList
        this.beforeAttr = this.StatisticsAttr()
        ApiMgr.Request("jobextraattr/unlock", tempData, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.RefreshUI(true,nil)
            end
        end, nil, true)
    end
end


this.HeroUpStarAll = function()
    if this.isClickActive then
        this.isClickActive = false
        this.resultShowName = {}
        local tempData = {}
        tempData["Ids"] = {}
        local typeKey = nil
        local job = this.vm.data.labelItem[this.labelIndex].job
        for i = 1, #this.heroConfig[job] do
            if this.heroConfig[job][i].state == 2 then
                for j = 1, 6 do
                    if j <= this.heroConfig[job][i].star and this.heroConfig[job][i].attr[j + 1] ~= "" then
                        typeKey = this.heroConfig[job][i].id.."_star_"..j
                        if DataMgr.Player.jobExtraAttr[typeKey] == nil then
                            if this.resultShowName[this.heroConfig[job][i].name] == nil then
                                this.resultShowName[this.heroConfig[job][i].name] = 1
                            end
                            this.tableInsert(tempData.Ids,typeKey)
                        end
                    end
                end
            end
        end
        this.beforeAttr = this.StatisticsAttr()
        ApiMgr.Request("jobextraattr/unlock", tempData, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.RefreshUI(false,true)
            end
        end, nil, true)
    end
end


this.HeroBrilliantAll = function()
    if this.isClickActive then
        this.isClickActive = false
        this.resultShowName = {}
        local tempList = {}
        local job = this.vm.data.labelItem[this.labelIndex].job
        for i = 1, #this.heroConfig[job] do
            if this.heroConfig[job][i].state == 3 then
                this.resultShowName[this.heroConfig[job][i].name] = 1
                this.tableInsert(tempList,this.heroConfig[job][i].id.."_brilliant_1")
            end
        end
        local tempData = {}
        tempData.Ids = tempList
        this.beforeAttr = this.StatisticsAttr()
        ApiMgr.Request("jobextraattr/unlock", tempData, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.RefreshUI(false,false)
            end
        end, nil, true)
    end
end



this.RefreshUI = function(type,imgType)
    if not TableIsNull(this.resultShowName) and NumTool.GetLen(this.resultShowName) > 1 then
        local strConcat = ""
        for key,value in pairs(this.resultShowName) do
            strConcat = strConcat..key..","
        end
        this.resultShowName = {}
        local nameConcat = string.sub(strConcat,1,-2)
        this.vm.data.popupTip = ConfigMgr.LangGlobal("17311")..nameConcat
    else
        this.vm.data.popupTip = ""
    end
    this.isClickActive = true
    this.InitHeroConfig()
    this.SetHeroView()
    this.UpdateLabelRed()
    this.SetJobAddAttr()
    HeroManager.UpdateCollectionAddAttr()
    this.SetNewAddAttrView()
    this.vm.data.activePopup = type
    this.vm.data.starPopup = not type
    this.vm.data.starImgText = not type and imgType
    this.vm.data.brilliantImgText = not type and not imgType
end


this.SetNewAddAttrView = function()
    this.vm.data.addAttrItem = {}
    if TableIsNull(this.beforeAttr) and TableIsNull(this.laterAttr) then
        return
    end
    local tempData,tempList = nil,{}
    for key,value in pairs(this.laterAttr) do
        if this.beforeAttr[key] == nil or this.beforeAttr[key].value ~= this.laterAttr[key].value then
            tempData = {attrIcon = LuaMgr.GetSprite("AttributeIcon",value.icon),
                        attrName = value.name,
                        newImg = TableIsNull(this.beforeAttr) or this.beforeAttr[key] == nil,
                        laterValue = value.value..value.type, before = false,beforeValue = ""}
            tempData.before = not tempData.newImg
            if not tempData.newImg then
                tempData.beforeValue = this.beforeAttr[key].value..this.beforeAttr[key].type
            end
            this.tableInsert(tempList,tempData)
        end
    end
    this.vm.data.addAttrItem = tempList
end


this.InitJobConfig = function()
    if TableIsNull(this.characterJob) then
        local tempJob = {}
        this.redList = {}
        this.characterJob = {}
        for key,value in pairs(ConfigMgr.Config.jobs) do
            tempJob = {job = tonumber(value.id),name = LuaMgr.GetLangText(value.NameLan)}
            this.redList[tempJob.job] = 0
            this.tableInsert(this.characterJob,tempJob)
        end
        table.sort(this.characterJob,this.JobSort)
    end
end



this.InitHeroConfig = function()
    this.heroConfig = {}
    local config = nil
    local tempData = {}
    local heroData = nil
    local typeKey = nil
    local starBool = nil
    local maxLevel = 0
    for i = 1, #this.characterJob do
        this.redList[this.characterJob[i].job] = 0
    end
    for key,value in pairs(ConfigMgr.Config.BestiarySupplyMap) do
        config = ConfigMgr.Config.characterTable[key]
        if not TableIsNull(config) and value.Switch == 1 then
            heroData = DataMgr.Player.characters[key]
            if this.heroConfig[config.job] == nil then
                this.heroConfig[config.job] = {}
            end
            tempData = {id = key,rare = config.rare,name = LuaMgr.GetLangText(config.namelan),needLevel = value.Level,attr = value.Provide}
            if TableIsNull(heroData) then
                tempData.state = 6
                tempData.level = 0
                tempData.star = 0
                tempData.skin = key.."001"
            else
                if heroData.level > ConfigMgr.Config.constants.BrilliantUnlockLevel then
                    maxLevel = ConfigMgr.Config.constants.BrilliantUnlockLevel
                else
                    maxLevel = heroData.level
                end
                tempData.level = maxLevel
                tempData.star = heroData.star
                typeKey = key.."_level_"..value.Level
                if DataMgr.Player.jobExtraAttr[typeKey] == nil then
                    tempData.state = heroData.level >= value.Level and 1 or 5
                    if tempData.state == 1 then
                        this.redList[config.job] = this.redList[config.job] + 1
                    end
                elseif DataMgr.Player.jobExtraAttr[typeKey] ~= nil then

                    starBool = false
                    for i = 1, 6 do
                        if i <= heroData.star and value.Provide[i + 1] ~= "" then
                            typeKey = key.."_star_"..i
                            if DataMgr.Player.jobExtraAttr[typeKey] == nil then
                                starBool = true
                                tempData.state = 2
                                this.redList[config.job] = this.redList[config.job] + 1
                                break
                            end
                        end
                    end

                    if not starBool then
                        typeKey = key.."_brilliant_1"
                        local curRare = HeroMgr.GetHeroNowRare(key)
                        if DataMgr.Player.jobExtraAttr[typeKey] == nil and curRare >= 5 then
                            tempData.state = 3
                            this.redList[config.job] = this.redList[config.job] + 1
                        else
                            tempData.state = 4
                        end
                    end
                end
                tempData.skin = heroData.curSkin
            end
            tempData.jobName = this.characterJob[config.job].name
            this.tableInsert(this.heroConfig[config.job],tempData)
        end
    end
    for i = 1, #this.heroConfig do
        table.sort(this.heroConfig[i],this.HeroSort)
    end
end

this.JobSort = function(item1,item2)
    return item1.job < item2.job
end

this.HeroSort = function(item1,item2)
    local rare1 = HeroMgr.GetHeroRareSort(item1.id)
    local rare2 = HeroMgr.GetHeroRareSort(item2.id)
    if item1.state ~= item2.state then
        return item1.state < item2.state
    elseif item1.level ~= item2.level then
        return (item1.level / item1.needLevel) > (item2.level / item2.needLevel)
    elseif rare1 ~= rare2 then
        return rare1 > rare2
    else
        return item1.id > item2.id
    end
end

this.AttrSort = function(item1,item2)
    return item1.index < item2.index
end

return vm({
    data = data,
    command = command,
    hook = hook
})