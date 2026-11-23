




require("ViewModel/HeroSpeciality/AllGroupItemModel")
require("ViewModel/HeroSpeciality/SingleGroupItemModel")
local this = {
    vm = nil,
    uiRoot = {},styleBool = nil,
    characterConfig = nil, characterData = nil,allPointCount = nil,
attributeGroup = {},
    detailsSelect = false,
groupIndex = nil,
groupPosition = nil,
specialityIndex = nil,
allAttrData = nil,
singleAttrData = nil,
    tableInsert = table.insert,
    lockColor = UnityEngine.Color(255 / 255.0, 255 / 255.0, 255 / 255.0, 125 / 255.0),
    unLockColor = UnityEngine.Color(255 / 255.0, 255 / 255.0, 255 / 255.0, 255 / 255.0),
    talentRecommend = nil,
singleRecommendIndex = nil,
isAssisHero=false;
}

local data = {
    spacing = 0.0,
    specialityItem = {{specialityIcon = DefaultSprite,specialityName = "",select = false,nowState = false,nowText = "",recommend = false}},
    isAssisDisableBtn=false;
}

local command = {
    specialityCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            if this.specialityIndex == index then return end
            this.SelectSpeciality(index)
        end
    },
    specialityConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SpecialityConfirm()
        end 
    },
    resetSpecialityCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)

            if this.isAssisHero then return end;
            this.OpenSelectSpecialityPopup()
        end
    },
    closeSpecialityCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.CloseSelectSpecialityPopup()
        end
    },
    groupCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.styleBool or this.isAssisHero then return end
            local index = tonumber(param)
            if this.groupIndex == index then
                this.CloseSelectGroup()
            else
                this.SwitchSelectGroup(index)

            end
        end
    },
    closeSelectCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.detailsSelect then
                this.CloseSelectGroup()
            end
        end
    },
    subtractCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SubtractPoint()
        end
    },
    addCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.AddPoint()
        end
    },
    singleConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.WhetherChange() then
                local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2926"].NameLan)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
                return
            end
            this.SendCharacterStyleAddPoint(nil,true)
        end
    },
    resetPointCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ResetGroupPoint()
        end
    },
    tipCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OpenPointTip()
        end
    },
    levelCloseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.CloseLevelPopup()
        end
    },
    closePointTipCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ClosePointTip()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitGetView()
        this.SetLanguageText()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
        this.CloseTextPopup()
        this.CloseLevelPopup()
        this.CloseEmptyAttrItem()
        this.CloseSelectSpecialityPopup()
        this.ClosePointTip()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}
this.SetLanguageText = function()
    this.uiRoot.titleText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2904"].NameLan)
    this.uiRoot.resetText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2900"].NameLan)
    this.uiRoot.popupTitle.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2903"].NameLan)
    this.uiRoot.levelTipText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2927"].NameLan)
end
this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()

    this.detailsSelect = false
    this.groupIndex = 0
    this.singleRecommendIndex = nil
    local characterId = this.vm.behaviour.Params[0]
    this.characterConfig = ConfigMgr.Config.characterTable[characterId]
    this.talentRecommend = this.characterConfig.TalentRecommend
    this.isAssisHero=PlayerAssistMgr.IsCurAssistCharacter(characterId)
    if  this.isAssisHero then
        this.characterData=PlayerAssistMgr.GetCurAssist_CharacterData();
    else
        this.characterData = DataMgr.Player.characters[characterId]
    end
    this.vm.data.isAssisDisableBtn=not this.isAssisHero;
    this.styleBool = type(this.characterData.style) == "function" or TableIsNull(this.characterData.style)
    this.UpdateGroupPosition()
    this.allPointCount = ConfigHelper.GetHeroSpecialityAllPoint(this.characterData.level)

    this.SetSpacing()
    this.SetAttributeState()
    this.SetDefaultGroupChoose()
    this.UpdateRight()
end


this.InitGetView = function()
    this.GetAttributeNode()
    this.GetUIRootNode()
end


this.SetSpacing = function()
    local length = #this.characterConfig.JobStyle
    if length == 3 then
        this.vm.data.spacing = 30
    elseif length == 4 then
        this.vm.data.spacing = 20
    elseif length == 5 then
        this.vm.data.spacing = -2
    end
end


this.SetAttributeState = function()
    if this.styleBool then

        local length = 0
        for i = 1, #this.attributeGroup do
            SetActive(this.attributeGroup[i].select,false)
            SetActive(this.attributeGroup[i].lock,true)
            SetActive(this.attributeGroup[i].unLock,false)
            SetActive(this.attributeGroup[i].coreIsShow,false)
            SetActive(this.attributeGroup[i].red,false)
            SetActive(this.attributeGroup[i].recommend,false)

            length = #this.attributeGroup[i].activeNode
            for j = 1, length do
                SetActive(this.attributeGroup[i].activeNode[j],false)
                SetActive(this.attributeGroup[i].newNode[j],false)
            end
        end
    else

        local styleData = this.characterData.style
        local styleConfig = ConfigMgr.Config.jobStyleMap[tostring(styleData.id)]
        if styleConfig ~= nil then
            for i = 1, #this.attributeGroup do
                SetActive(this.attributeGroup[i].select,this.detailsSelect and this.groupIndex == i)
                SetActive(this.attributeGroup[i].lock,styleData.points[i] < 7)
                SetActive(this.attributeGroup[i].unLock,styleData.points[i] >= 7)
                SetActive(this.attributeGroup[i].coreIsShow,true)
                SetActive(this.attributeGroup[i].red,this.SetGroupPoint(i))
                
                length = #this.attributeGroup[i].activeNode
                for j = 1, length do
                    SetActive(this.attributeGroup[i].activeNode[j],styleData.points[i] == j)
                    SetActive(this.attributeGroup[i].newNode[j],false)
                end
            end

            if styleConfig.sector ~= nil and #styleConfig.sector > 0 then
                local sectorConfig = nil
                for i = 1, #styleConfig.sector do
                    sectorConfig = ConfigMgr.Config.sectorMap[styleConfig.sector[i]]
                    if this.GetCharacterUsingPoint() > 0 then
                        SetActive(this.attributeGroup[i].recommend,false)
                    else
                        local isRecommend = this.WhetherRecommend(false,nil,styleConfig.sector[i])
                        if isRecommend then
                            this.singleRecommendIndex = i
                        end
                        SetActive(this.attributeGroup[i].recommend,isRecommend)
                    end
                    this.attributeGroup[i].coreName.text = LuaMgr.GetLangText(sectorConfig.branchNameLan)
                    this.attributeGroup[i].coreIcon.sprite = LuaMgr.GetSprite("CoreIcon",sectorConfig.sectorIcon)
                    this.attributeGroup[i].coreIcon.color = styleData.points[i] >= 7 and this.unLockColor or this.lockColor
                end
            end

            this.uiRoot.nameText.text = LuaMgr.GetLangText(styleConfig.styleNameLan)
            this.uiRoot.specialityIcon.sprite = LuaMgr.GetSprite("SpecialityIcon",styleConfig.styleIcon)
        end
    end
    SetActive(this.uiRoot.specialityIsShow,not this.styleBool)
    SetActive(this.uiRoot.nameIsShow,not this.styleBool)
end


this.UpdateRight = function()
    if not this.detailsSelect and not this.styleBool then
        this.UpdateAllOverview()
        this.SetContentHeight(true)
    elseif this.detailsSelect and not this.styleBool then
        this.UpdateSingleOverview()
        this.SetContentHeight(false)

    end
    this.uiRoot.detailsAnim:Play("ani_ui_HeroSpecialityPanel_Details",0,0)
    SetActive(this.uiRoot.allOverview,not this.detailsSelect and not this.styleBool)
    SetActive(this.uiRoot.singleOverview,this.detailsSelect and not this.styleBool)
    SetActive(this.uiRoot.emptyOverview,this.styleBool)

    if this.isAssisHero then
        return;
    end
    if this.styleBool then

        this.OpenSelectSpecialityPopup()
    end
end


this.OpenSelectSpecialityPopup = function()
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/DailyDungeon_switch1.mp3")
    local tempList,tempItem = {},{}
    local styleConfig = nil
    for i = 1, #this.characterConfig.JobStyle do
        styleConfig = ConfigMgr.Config.jobStyleMap[this.characterConfig.JobStyle[i]]
        if styleConfig ~= nil then
            tempItem = {id = tostring(styleConfig.id),
                        specialityIcon = LuaMgr.GetSprite("SpecialityIcon",styleConfig.styleIcon),
                        specialityName = LuaMgr.GetLangText(styleConfig.styleNameLan),select = false,
                        nowState = (not this.styleBool) and styleConfig.id == this.characterData.style.id,
                        nowText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2910"].NameLan),
                        recommend = this.WhetherRecommend(true,styleConfig.styleTalent,nil)}
            this.tableInsert(tempList,tempItem)
        end
    end
    this.vm.data.specialityItem = tempList
    this.uiRoot.specialityText.text = ""
    SetActive(this.uiRoot.popupCloseBtn,not this.styleBool)
    SetActive(this.uiRoot.specialityPopup,true)


    this.AcquiesceNowSpeciality()
end




this.AcquiesceNowSpeciality = function()
    if not this.styleBool then
        for i = 1, #this.characterConfig.JobStyle do
            if this.characterConfig.JobStyle[i] == tostring(this.characterData.style.id) then
                this.specialityIndex = i
                break
            end
        end
    else
        for i = 1, #this.characterConfig.JobStyle do
            styleConfig = ConfigMgr.Config.jobStyleMap[this.characterConfig.JobStyle[i]]
            if this.WhetherRecommend(true,styleConfig.styleTalent,nil) then
                this.specialityIndex = i
                this.SelectSpeciality(this.specialityIndex)
                return
            end
        end
        this.specialityIndex = 1
    end
    this.SelectSpeciality(this.specialityIndex)
end

this.CloseSelectSpecialityPopup = function()

    SetActive(this.uiRoot.specialityPopup,false)
end


this.SelectSpeciality = function(index)
    if this.specialityIndex ~= nil then
        this.vm.data.specialityItem[this.specialityIndex].select = false
    end
    this.specialityIndex = index
    this.vm.data.specialityItem[this.specialityIndex].select = true
    local styleConfig = ConfigMgr.Config.jobStyleMap[this.vm.data.specialityItem[this.specialityIndex].id]
    if styleConfig == nil or styleConfig.styleTalent == nil or #styleConfig.styleTalent == 0 then return end
    

    local styleName = LuaMgr.GetLangText(styleConfig.styleNameLan)..LuaMgr.GetLangText("HeroSpecialityViewModel_0")
    local attrName,attrValue,attrType = "","",""
    local attrDesStr = ""
    for i = 1, #styleConfig.styleTalent do
        attrName,attrValue,attrType = ConfigHelper.GetAttrNameStr(styleConfig.styleTalent[i])
        attrDesStr = attrDesStr..attrName.."+"..attrValue..attrType.."   "
    end
    this.uiRoot.specialityText.text = styleName..attrDesStr
end

this.SwitchSelectGroup = function(index)
    if this.WhetherChange() then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2922"].NameLan)
        LuaMgr.ShowPanel
        (
                UIName.ConfirmSmallViewModel,tipStr,
function()
                    this.SendCharacterStyleAddPoint(function()
                        this.SelectGroup(index)
                    end,true)
                end,
function()
                    this.UpdateGroupPosition()
                    this.SetAttributeState()
                    this.SelectGroup(index)
                end
        )
    else
        this.SelectGroup(index)
    end
end





this.SetDefaultGroupChoose = function()
    if this.GetCharacterPointCount() > 0 then
        local tempIndex = 1
        local levelMax = this.GetGroupLevelMax()
        if levelMax == 0  then
            if this.singleRecommendIndex ~= nil then
                tempIndex = this.singleRecommendIndex
            end
        else
            tempIndex = levelMax
        end
        command.groupCommand.execute(nil,tempIndex)
    end
end

this.SelectGroup = function(index)
    if this.groupIndex > 0 then
        SetActive(this.attributeGroup[this.groupIndex].select,false)
    end
    this.groupIndex = index
    SetActive(this.attributeGroup[this.groupIndex].select,true)
    this.detailsSelect = true
    this.UpdateRight()
end

this.CloseSelectGroup = function()
    if this.WhetherChange() then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2922"].NameLan)
        LuaMgr.ShowPanel
        (
                UIName.ConfirmSmallViewModel,tipStr,
function()
                    this.SendCharacterStyleAddPoint(this.CloseSelectGroupFun,true)
                end,
function()
                    this.CloseSelectGroupFun()
                end
        )
    else
        this.CloseSelectGroupFun()
    end
end
this.CloseSelectGroupFun = function()
    this.UpdateGroupPosition()
    this.SetAttributeState()
    SetActive(this.attributeGroup[this.groupIndex].select,false)
    this.groupIndex = 0
    this.detailsSelect = false
    this.UpdateRight()
end


this.UpdateAllOverview = function()
    local str = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2901"].NameLan),this.GetCharacterPointCount())
    this.uiRoot.allOverviewPointCount.text = str
    local styleData = this.characterData.style
    local styleConfig = ConfigMgr.Config.jobStyleMap[tostring(styleData.id)]
    if styleConfig == nil then return end
    
    if this.allAttrData == nil then this.allAttrData = {} end
    local attrItem = nil
    local index = 1
    local titleStr = ""

    if this.allAttrData[1] == nil then
        attrItem = AllGroupItemModel.New(this.uiRoot.allOverviewContent)
        this.tableInsert(this.allAttrData,attrItem)
    end
    titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2905"].NameLan)
    this.allAttrData[1]:SetPosition(Vector3.zero)
    this.allAttrData[1]:SetData(index,titleStr,false,styleConfig.styleTalent)
    index = index + 1

    local attrIdDes = {}
    local sectorConfig = nil
    local length = 0
    local talentList = nil
    local type = nil
    local skillList = {}
    for i = 1, #styleConfig.sector do
        sectorConfig = ConfigMgr.Config.sectorMap[styleConfig.sector[i]]
        length = ConfigHelper.GetTableLength(sectorConfig.sectorTalent)
        for j = 1, length do
            if this.groupPosition[i] >= j then
                talentList = sectorConfig.sectorTalent[j]
                for k = 1, #talentList do
                    type = ConfigMgr.Config.talentBankMap[talentList[k]].type
                    if type == 2 then
                        this.tableInsert(attrIdDes,talentList[k])
                    else
                        this.tableInsert(skillList,{skillId = talentList[k],skillIcon = sectorConfig.sectorIcon})
                    end
                end
            end
        end
    end
    if this.allAttrData[2] == nil then
        attrItem = AllGroupItemModel.New(this.uiRoot.allOverviewContent)
        this.tableInsert(this.allAttrData,attrItem)
    end
    titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2906"].NameLan)
    this.allAttrData[2]:SetPosition(Vector3(0,-this.allAttrData[1].height,0))
    this.allAttrData[2]:SetData(index,titleStr,false,attrIdDes)
    index = index + 1

    if this.allAttrData[3] == nil then
        attrItem = AllGroupItemModel.New(this.uiRoot.allOverviewContent)
        this.tableInsert(this.allAttrData,attrItem)
    end
    this.allAttrData[3]:SetPosition(Vector3(0,-(this.allAttrData[1].height + this.allAttrData[2].height),0))
    local skill = nil

    skill = skillList[1]
    titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2907"].NameLan)
    this.allAttrData[3]:SetData(index,titleStr,true,skill)
end

this.UpdateSingleOverview = function()
    if this.groupIndex == 0 then return end

    local sector = ConfigMgr.Config.jobStyleMap[tostring(this.characterData.style.id)].sector

    local sectorConfig = ConfigMgr.Config.sectorMap[sector[this.groupIndex]]
    if this.singleAttrData == nil then this.singleAttrData = {} end
    
    local attrItem = nil
    local level = this.characterData.style.points[this.groupIndex]
    for i = 1, #sectorConfig.sectorTalent do
        if this.singleAttrData[i] == nil then
            attrItem = SingleGroupItemModel.New(this.uiRoot.singleOverviewContent)
            this.tableInsert(this.singleAttrData,attrItem)
        end
        this.singleAttrData[i]:SetData(i,level,sectorConfig.sectorTalent[i])
    end

    this.SetSingleAttrPosition()
    
    this.uiRoot.singleCoreIcon.sprite = LuaMgr.GetSprite("CoreIcon",sectorConfig.sectorIcon)
    this.uiRoot.singleCoreName.text = LuaMgr.GetLangText(sectorConfig.branchNameLan)
    local str = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2901"].NameLan),this.GetCharacterPointCount())
    this.uiRoot.singleOverviewPointCount.text = str
    this.uiRoot.singleUsingCount.text = this.groupPosition[this.groupIndex].."/7"
end

this.SetSingleAttrPosition = function()
    local position = nil
local tempY = 10
    for i = 1, #this.singleAttrData do
        if i > 1 then
            tempY = 10
            for j = 1, i - 1 do
tempY = tempY + this.singleAttrData[j].height + 13
            end
        end
        position = Vector3(0,-tempY,0)
        this.singleAttrData[i]:SetPosition(position)
    end
end

this.AddPoint = function()
    local tips = ""
    if this.groupPosition[this.groupIndex] + 1 > #this.singleAttrData then
        tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2924"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
        return
    end
    if this.GetCharacterPointCount() <= 0 then
        tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2923"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
        return
    end
    this.PreviewAttrChange(1)
end

this.SubtractPoint = function()
    local tips = ""
    if this.groupPosition[this.groupIndex] - 1 < 0 then
        tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2925"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
        return
    end
    this.PreviewAttrChange(-1)
end


this.PreviewAttrChange = function(param)
    local previewLevel = this.groupPosition[this.groupIndex] + param
    this.groupPosition[this.groupIndex] = previewLevel

    local isActive = nil
    if param > 0 then
        isActive = this.characterData.style.points[this.groupIndex] < this.groupPosition[this.groupIndex]
        SetActive(this.attributeGroup[this.groupIndex].newNode[previewLevel],isActive)
    else
        isActive = this.characterData.style.points[this.groupIndex] > this.groupPosition[this.groupIndex]
        SetActive(this.attributeGroup[this.groupIndex].newNode[previewLevel + 1],isActive)
    end

    if previewLevel >= 0 then
        if param > 0 then
            isActive = this.singleAttrData[previewLevel].isActive
            SetActive(this.singleAttrData[previewLevel].a_select,not isActive)
            SetActive(this.singleAttrData[previewLevel].n_select,false)
        else
            isActive = this.singleAttrData[previewLevel + 1].isActive
            SetActive(this.singleAttrData[previewLevel + 1].a_select,false)
            SetActive(this.singleAttrData[previewLevel + 1].n_select,isActive)
        end
    end
    local str = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2901"].NameLan),this.GetCharacterPointCount())
    this.uiRoot.singleOverviewPointCount.text = str
this.uiRoot.singleUsingCount.text = this.groupPosition[this.groupIndex].."/7"
end



this.SetContentHeight = function(contentType)
    local height = 0
    local sizeDelta = nil
    if contentType then
        sizeDelta = this.uiRoot.allOverviewContent.sizeDelta
        for i = 1, #this.allAttrData do
            height = height + this.allAttrData[i].height
        end
        this.uiRoot.allOverviewContent.sizeDelta = Vector2(sizeDelta.x,height)
        this.uiRoot.allOverviewContent.anchoredPosition = Vector2.zero
    else
        sizeDelta = this.uiRoot.singleOverviewContent.sizeDelta
        for i = 1, #this.singleAttrData do
            height = height + this.singleAttrData[i].height
        end

        height = height + 10 + (#this.singleAttrData * 13 - 13) + 10
        this.uiRoot.singleOverviewContent.sizeDelta = Vector2(sizeDelta.x,height)
        this.uiRoot.singleOverviewContent.anchoredPosition = Vector2(5,0)
    end
end


this.SetGroupPoint = function(index)

    if this.isAssisHero then
        return false 
    end;
    if this.GetCharacterPointCount() <= 0 then
        return false
    end
    return this.groupPosition[index] < 7
end


this.SpecialityConfirm = function()
    if this.specialityIndex == nil then
        local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2903"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
        return
    end
    if not this.styleBool then
        local id = this.vm.data.specialityItem[this.specialityIndex].id
        if id == tostring(this.characterData.style.id) then
            local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2930"].NameLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
            return
        end
    end

    if not this.styleBool then
        local isPopup = false
        for i = 1, #this.groupPosition do
            if this.groupPosition[i] > 0 then
                isPopup = true
                break
            end
        end
        if isPopup then
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2921"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,function()
                this.SendCharacterStyle()
            end,nil)
            return
        end
    end
    this.SendCharacterStyle()
end


this.SendCharacterStyle = function()
    local tempData = {}
    tempData["characterId"] = this.characterConfig.id
    tempData["styleId"] = tonumber(this.vm.data.specialityItem[this.specialityIndex].id)
    ApiMgr.Request("change_character_style", tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            if not this.styleBool then
                local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2929"].NameLan)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
            end
            this.characterData = DataMgr.Player.characters[this.characterConfig.id]
            this.styleBool = type(this.characterData.style) == "function" or TableIsNull(this.characterData.style)
            this.UpdateGroupPosition()
            this.CloseSelectSpecialityPopup()
            this.detailsSelect = false
            this.groupIndex = 0
            this.SetAttributeState()
            this.SetDefaultGroupChoose()
            this.UpdateRight()
        end
    end,nil,true)
end



this.SendCharacterStyleAddPoint = function(callBack,popupType)
    local tempData = {}
    tempData["characterId"] = this.characterConfig.id
    tempData["points"] = this.groupPosition
    ApiMgr.Request("set_character_style_points", tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            local beforeLevel = this.characterData.style.points[this.groupIndex]
            this.characterData = DataMgr.Player.characters[this.characterConfig.id]
            local afterLevel = this.characterData.style.points[this.groupIndex]
            this.styleBool = type(this.characterData.style) == "function" or TableIsNull(this.characterData.style)
            this.UpdateGroupPosition()
            this.SetAttributeState()
            this.UpdateSingleOverview()
            if popupType then
                this.OpenLevelPopup(beforeLevel,afterLevel)
            else
                this.OpenTextPopup("2928")
            end
            if callBack ~= nil then
                callBack()
            end
        end
    end,nil,true)
end


this.ResetGroupPoint = function()
    local tipStr = ""
    if this.GetCharacterUsingPoint() <= 0 then
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2931"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
        return
    end

    tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2920"].NameLan)
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,function()
        for i = 1, #this.groupPosition do
            this.groupPosition[i] = 0
        end
        this.SendCharacterStyleAddPoint(this.UpdateAllOverview,false)
    end,nil)
end


this.OpenTextPopup = function(tipStrId)
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/curtain_up.mp3")
    local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal[tipStrId].NameLan)
    this.uiRoot.textTipPopupText.text = tips
    SetActive(this.uiRoot.textTipPopup,true)
    LuaMgr.RemoveTimer(TimerConst.SpecialityClosePopup)
    LuaMgr.AddTimer(TimerConst.SpecialityClosePopup,function()
        this.CloseTextPopup()
    end,1,1,false)
end

this.CloseTextPopup = function()
    SetActive(this.uiRoot.textTipPopup,false)
    LuaMgr.RemoveTimer(TimerConst.SpecialityClosePopup)
end


this.OpenLevelPopup = function(beforeLevel,afterLevel)
    AudioHelper.PlayUISFX(AudioNames.Character_Sz)

    local sector = ConfigMgr.Config.jobStyleMap[tostring(this.characterData.style.id)].sector

    local sectorConfig = ConfigMgr.Config.sectorMap[sector[this.groupIndex]]
    if sectorConfig == nil then return end
    
    this.uiRoot.coreIcon.sprite = LuaMgr.GetSprite("CoreIcon",sectorConfig.sectorIcon)
    this.uiRoot.coreName.text = LuaMgr.GetLangText(sectorConfig.branchNameLan)
    
    this.uiRoot.beforeLevel.text = beforeLevel
    this.uiRoot.afterLevel.text = afterLevel
    SetActive(this.uiRoot.levelTipPopup,true)
end

this.CloseLevelPopup = function()
    SetActive(this.uiRoot.levelTipPopup,false)
end


this.GetCharacterPointCount = function()
    local count = this.allPointCount
    if this.groupPosition == nil then
        return count
    end
    for i = 1, #this.groupPosition do
        count = count - this.groupPosition[i]
    end
    return count
end

this.GetCharacterUsingPoint = function()
    local count = 0
    for i = 1, #this.groupPosition do
        count = count + this.groupPosition[i]
    end
    return count
end

this.GetGroupLevelMax = function()
    local index = 0
    if this.groupPosition ~= nil then
        for i = 1, #this.groupPosition do
            if this.groupPosition[i] > index and this.groupPosition[i] < 7 then
                index = i
            end
        end 
    end
    return index
end



this.WhetherChange = function()
    for i = 1, #this.groupPosition do
        if this.groupPosition[i] ~= this.characterData.style.points[i] then
            return true
        end
    end
    return false
end


this.UpdateGroupPosition = function()
    this.groupPosition = not this.styleBool and table.Copy(this.characterData.style.points) or nil
end


this.WhetherRecommend = function(type,param,id)
    if TableIsNull(this.talentRecommend) then
        return false
    end
    if type then
        if TableIsNull(this.talentRecommend[1]) then
            return false
        end
        for i = 1, #this.talentRecommend[1] do
            for j = 1, #param do
                if this.talentRecommend[1][i] == param[j] then
                    return true
                end
            end
        end
    else
        if TableIsNull(this.talentRecommend[2]) then
            return false
        end
        for i = 1, #this.talentRecommend[2] do
            if this.talentRecommend[2][i] == id then
                return true
            end
        end
    end
    return false
end

this.OpenPointTip = function()
    local tempStr_1,tempStr_2 = "",""
    tempStr_1 = ConfigMgr.LangGlobal("30300")
    this.uiRoot.pointTipTitle.text = tempStr_1
    
    tempStr_1 = ConfigMgr.LangGlobal("30301")
    tempStr_2 = ConfigMgr.LangGlobal("30302")
    this.uiRoot.pointTipIntroText.text = tempStr_1.."\n"..tempStr_2
    SetActive(this.uiRoot.pointTipPopup,true)
end

this.ClosePointTip = function()
    SetActive(this.uiRoot.pointTipPopup,false)
end


this.GetAttributeNode = function()

    local parentTran = this.vm.behaviour.transform:Find("root/Middle/Attribute"):GetComponent("Transform")
    local node = {
        select = {path = "Select",type = "GameObject"},
        lock = {path = "Lock",type = "GameObject"},
        unLock = {path = "UnLock",type = "GameObject"},
        coreIsShow = {path = "CoreIcon",type = "GameObject"},
        coreIcon = {path = "CoreIcon",type = "Image"},
        coreName = {path = "CoreIcon/CoreName",type = "Text"},
        red = {path = "Red",type = "GameObject"},
        recommend = {path = "Recommend",type = "GameObject"},
    }
    local activeRoot,newRoot,nodeTran = nil,nil,nil
    local object,objectName,tempNode = nil,"",{}
    for i = 1, parentTran.childCount - 2 do
        objectName = "Group_"..i
        object = parentTran:Find(objectName).gameObject
        tempNode = {}
        UITool.Parse(object,tempNode,node)
        this.tableInsert(this.attributeGroup,i,tempNode)


        activeRoot = object.transform:Find("Active"):GetComponent("Transform")
        newRoot = object.transform:Find("New"):GetComponent("Transform")
        this.attributeGroup[i].activeNode = {}
        this.attributeGroup[i].newNode = {}
        for j = 1, activeRoot.childCount do

            nodeTran = activeRoot.transform:Find("A_Group_"..j).gameObject
            this.tableInsert(this.attributeGroup[i].activeNode,j,nodeTran)

            nodeTran = newRoot.transform:Find("N_Group_"..j).gameObject
            this.tableInsert(this.attributeGroup[i].newNode,j,nodeTran)
        end
    end
    parentTran,node = nil,nil
    activeRoot,newRoot,nodeTran = nil,nil,nil
    object,objectName,tempNode = nil,nil,nil
end


this.GetUIRootNode = function()
    local node = {
        allOverview = {path = "root/Right/Details/AllOverview",type = "GameObject"},
        allOverviewPointCount = {path = "root/Right/Details/AllOverview/Text",type = "Text"},
        allOverviewContent = {path = "root/Right/Details/AllOverview/ScrollView/Viewport/Content",type = "RectTransform"},
        titleText = {path = "root/Right/Details/AllOverview/TitleText",type = "Text"},
        resetText = {path = "root/Right/Details/AllOverview/ResetBtn/Text",type = "Text"},
        singleOverview = {path = "root/Right/Details/SingleOverview",type = "GameObject"},
        singleOverviewContent = {path = "root/Right/Details/SingleOverview/ScrollView/Viewport/Content",type = "RectTransform"},
        singleCoreIcon = {path = "root/Right/Details/SingleOverview/CoreIcon",type = "Image"},
        singleCoreName = {path = "root/Right/Details/SingleOverview/CoreIcon/CoreName",type = "Text"},
        singleOverviewPointCount = {path = "root/Right/Details/SingleOverview/Text",type = "Text"},
        singleUsingCount = {path = "root/Right/Details/SingleOverview/Num/Text",type = "Text"},
        emptyOverview = {path = "root/Right/Details/EmptyOverview",type = "GameObject"},
        specialityPopup = {path = "root/SpecialityPopup",type = "GameObject"},
        popupTitle = {path = "root/SpecialityPopup/Group/Text",type = "Text"},
        specialityText = {path = "root/SpecialityPopup/Group/SpecialityText",type = "Text"},
        popupCloseBtn = {path = "root/SpecialityPopup/Group/Btns/CloseBtn",type = "GameObject"},
        specialityIsShow = {path = "root/Middle/Attribute/Speciality/SpecialityIcon",type = "GameObject"},
        specialityIcon = {path = "root/Middle/Attribute/Speciality/SpecialityIcon",type = "Image"},
        nameIsShow = {path = "root/Middle/Attribute/Speciality/Name",type = "GameObject"},
        nameText = {path = "root/Middle/Attribute/Speciality/Name/Text",type = "Text"},
        
        textTipPopup = {path = "root/TextTipPopup",type = "GameObject"},
        textTipPopupText = {path = "root/TextTipPopup/Text",type = "Text"},
        
        levelTipPopup = {path = "root/LevelTipPopup",type = "GameObject"},
        levelTipText = {path = "root/LevelTipPopup/Text",type = "Text"},
        coreIcon = {path = "root/LevelTipPopup/CoreIcon",type = "Image"},
        coreName = {path = "root/LevelTipPopup/CoreName",type = "Text"},
        beforeLevel = {path = "root/LevelTipPopup/BeforeLevel",type = "Text"},
        afterLevel = {path = "root/LevelTipPopup/AfterLevel",type = "Text"},
        detailsAnim = {path = "root/Right/Details",type = "Animator"},
        
        pointTipPopup = {path = "root/PointTipPopup",type = "GameObject"},
        pointTipTitle = {path = "root/PointTipPopup/Group/Text",type = "Text"},
        pointTipIntroText = {path = "root/PointTipPopup/Group/IntroText",type = "Text"},
    }
    UITool.Parse(this.vm.behaviour.transform,this.uiRoot,node)
    node = nil
end

this.CloseEmptyAttrItem = function()
    if this.allAttrData ~= nil then
        for i = 1, #this.allAttrData do
            this.allAttrData[i]:Clear()
        end
        this.allAttrData = nil
    end
    if this.singleAttrData ~= nil then
        for i = 1, #this.singleAttrData do
            this.singleAttrData[i]:Clear()
        end
        this.singleAttrData = nil
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})