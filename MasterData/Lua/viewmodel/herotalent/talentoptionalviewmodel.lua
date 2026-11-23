




local this = {
    vm = nil,
    characterData = nil,stringFormat = string.format,
    tableInsert = table.insert,toNumber = tonumber,
    countFormat = "<color=#ef8a58>%d</color>",attrConfig = nil,
    viewType = nil,viewEnum = {curShow = 1,allShow = 2},
    attrIndex_1 = nil,attrIndex_2 = nil,attrIndex_3 = nil,
    chooseConfigIndex = nil,chooseLevel = nil,chooseMaxLevel = nil,
    onPressClick = false,
    item3_Effect_Pos = {Vector2(-150,-116),Vector2(0,-116),Vector2(150,-116)},
    item2_Effect_Pos = {Vector2(-225,9),Vector2(-75,9),Vector2(75,9),Vector2(225,9)},
    item1_Effect_Pos = {Vector2(-300,130),Vector2(-150,130),Vector2(0,130),Vector2(150,130),Vector2(300,130)},
}

local data = {
    characterPic = DefaultTexture,titleText = "",allPoint = "",
    curAttrView = false,allAttrView = false,
    noActivation = false,noActivationText = "",
    allReset = false,reset = false,attrTipText = "",
    curTipText = "",curValueText = "",nextTipText = "",nextValueText = "",
    confirm = false,confirmText = "",confirmValue = "",
    attrDesRoot = false,attrDesIcon = DefaultSprite,
    attrDesName = "",attrDesText = "",
    all_Text1_Effect = false,all_Text2_Effect = false,all_Text3_Effect = false,
    item1_UpLv = false,item1_UpLv_Pos = Vector2.zero,
    item2_UpLv = false,item2_UpLv_Pos = Vector2.zero,
    item3_UpLv = false,item3_UpLv_Pos = Vector2.zero,
    item1_Choose_Pos = Vector2.zero,
    item2_Choose_Pos = Vector2.zero,
    item3_Choose_Pos = Vector2.zero,
    attrTextList = {{value = ""}},
    attrList_1 = {{choose = false,icon = DefaultSprite,normal = false,count = "",lock = false,tipText = "",sweep = false}},
    attrList_2 = {{choose = false,icon = DefaultSprite,normal = false,count = "",lock = false,tipText = "",sweep = false}},
    attrList_3 = {{choose = false,icon = DefaultSprite,normal = false,count = "",lock = false,tipText = "",sweep = false}},
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.TalentOptionalViewModel)
        end
    },
    attrItem_1Command = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_round.mp3")
            local index = this.toNumber(param + 1)
            if this.attrIndex_1 == index then
                return
            end
            this.attrItem_1Click(index)
        end
    },
    attrItem_1OnPress = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if (LuaMgr.IsGuide()) then return end
            
            local index = this.toNumber(param + 1)
            this.attrItem_1Click(index)
            this.onPressClick = true
            this.OpenAttrDetails()
        end
    },
    attrItem_2Command = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_round.mp3")
            local index = this.toNumber(param + 1)
            if this.attrIndex_2 == index then
                return
            end
            this.attrItem_2Click(index)
        end
    },
    attrItem_2OnPress = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if (LuaMgr.IsGuide()) then return end
            
            local index = this.toNumber(param + 1)
            this.attrItem_2Click(index)
            this.onPressClick = true
            this.OpenAttrDetails()
        end
    },
    attrItem_3Command = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_round.mp3")
            local index = this.toNumber(param + 1)
            if this.attrIndex_3 == index then
                return
            end
            this.attrItem_3Click(index)
        end
    },
    attrItem_3OnPress = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if (LuaMgr.IsGuide()) then return end
            
            local index = this.toNumber(param + 1)
            this.attrItem_3Click(index)
            this.onPressClick = true
            this.OpenAttrDetails()
        end
    },

    liftUpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.onPressClick then
                this.CloseAttrDetails()
            end
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.LearningTalent()
        end
    },
    resetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ResetSingleTalent()
        end
    },
    allResetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2069"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,this.ResetAllTalent,nil)
        end
    },
    cancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.viewType == this.viewEnum.curShow then
                this.CancelItemChoose()
                this.attrIndex_1 = -1
                this.attrIndex_2 = -1
                this.attrIndex_3 = -1
                this.viewType = this.viewEnum.allShow
                this.UpdateAttrView()
                this.OpenAllTextEffect()
            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
        this.SetCharacterPic()
        this.SetText()
        this.SetPointView()
        this.UpdateAttrView()
        this.InitItemEffect()
        this.InitAllTextEffect()
        if this.characterData.usedPoint == 0 then
            LuaMgr.AddTimer(TimerConst.OptionalDefaultChoose,function()
                this.attrItem_1Click(1)
                LuaMgr.RemoveTimer(TimerConst.OptionalDefaultChoose)
            end,0.7,-1,false)
        else
            this.attrIndex_1 = -1
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.InvokeUIEventListeners(UIEventConst.UpdateTalentPoint)
        this.attrConfig = nil
        LuaMgr.RemoveTimer(TimerConst.OptionalInitEffect)
        LuaMgr.RemoveTimer(TimerConst.OptionalDefaultChoose)
        this.CloseEffect()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}


this.InitParameter = function()
    this.onPressClick = false
    this.viewType = this.viewEnum.allShow
    this.attrIndex_2,this.attrIndex_3 = -1,-1
    this.characterData = DataMgr.Player.characters[this.vm.behaviour.Params[0]]
    this.attrConfig = ConfigMgr.Config.characterOptionalMap[this.characterData.id]
    this.vm.data.item1_Choose_Pos = Vector2(3000,0)
    this.vm.data.item2_Choose_Pos = Vector2(3000,0)
    this.vm.data.item3_Choose_Pos = Vector2(3000,0)
end

this.InitItemEffect = function()
    LuaMgr.AddTimer(TimerConst.OptionalInitEffect,this.OpenItemEffect,0.68,1,false)
end
this.InitAllTextEffect = function()
    LuaMgr.AddTimer(TimerConst.OptionalInitTextEffect,this.OpenAllTextEffect,0.68,1,false)
end

this.OpenItemEffect = function()
    for i = 1, #this.vm.data.attrList_1 do
        this.vm.data.attrList_1[i].sweep = true
    end
    for i = 1, #this.vm.data.attrList_2 do
        this.vm.data.attrList_2[i].sweep = true
    end
    for i = 1, #this.vm.data.attrList_3 do
        this.vm.data.attrList_3[i].sweep = true
    end
end

this.OpenAllTextEffect = function()
    this.vm.data.all_Text1_Effect = true
    this.vm.data.all_Text2_Effect = #this.vm.data.attrTextList > 3
    this.vm.data.all_Text3_Effect = #this.vm.data.attrTextList > 6
end

this.SetPointView = function()
    this.vm.data.attrList_1 = {}
    this.vm.data.attrList_2 = {}
    this.vm.data.attrList_3 = {}
    if this.attrConfig == nil or #this.attrConfig == 0 then return end
    local tempData = nil
    local tempList_1,tempList_2,tempList_3 = {},{},{}
    local iconName,level = nil,nil
    for i = 1, #this.attrConfig do
        tempData = {choose = false,icon = DefaultSprite,normal = false,count = "",lock = false,tipText = "",sweep = false}
        iconName = ConfigMgr.Config.talentBankMap[this.attrConfig[i].talentBankId[1]].showTypeIcon
        tempData.icon = LuaMgr.GetSprite("AttributeIcon",iconName)
        tempData.configIndex = i
        if this.characterData.optional == nil or type(this.characterData.optional) == "function" then
            level = 0
        else
            level = this.characterData.optional[this.attrConfig[i].id] == nil and 0 or this.characterData.optional[this.attrConfig[i].id]
        end
        tempData.curLevel = level
        tempData.totalLevel = #this.attrConfig[i].talentBankId
        tempData.count = tempData.curLevel.."/"..tempData.totalLevel
        tempData.normal = tempData.curLevel > 0
        tempData.lock = tempData.curLevel < 1
        tempData.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2372"].NameLan)
        if i <= 5 then
            this.tableInsert(tempList_1,tempData)
        elseif i > 5 and i <= 9 then
            this.tableInsert(tempList_2,tempData)
        else
            this.tableInsert(tempList_3,tempData)
        end
    end
    this.vm.data.attrList_1 = tempList_1
    this.vm.data.attrList_2 = tempList_2
    this.vm.data.attrList_3 = tempList_3
end

this.SetCharacterPic = function()
    local path = this.stringFormat("%s%s/Drawing/%s.png", Path.Character_PATH, this.characterData.id,this.characterData.id.."001")
    this.vm.data.characterPic = LuaMgr.GetTexture(path)
end

this.SetText = function()
    this.UpdateText()
    this.vm.data.noActivationText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2377"].NameLan)
    this.vm.data.attrTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2376"].NameLan)
    this.vm.data.confirmText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2379"].NameLan)
end

this.UpdateText = function()
    this.vm.data.allPoint = this.characterData.totalPoint - this.characterData.usedPoint
    local countStr = this.stringFormat(this.countFormat,this.characterData.usedPoint)
    this.vm.data.titleText = this.stringFormat(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2371"].NameLan),countStr)
end

this.SetItemChoose = function()
    if this.attrIndex_1 ~= -1 then
        this.vm.data.item1_Choose_Pos = this.item1_Effect_Pos[this.attrIndex_1]
        this.chooseLevel = this.vm.data.attrList_1[this.attrIndex_1].curLevel
        this.chooseMaxLevel = this.vm.data.attrList_1[this.attrIndex_1].totalLevel
        this.chooseConfigIndex = this.vm.data.attrList_1[this.attrIndex_1].configIndex
    end
    if this.attrIndex_2 ~= -1 then
        this.vm.data.item2_Choose_Pos = this.item2_Effect_Pos[this.attrIndex_2]
        this.chooseLevel = this.vm.data.attrList_2[this.attrIndex_2].curLevel
        this.chooseMaxLevel = this.vm.data.attrList_2[this.attrIndex_2].totalLevel
        this.chooseConfigIndex = this.vm.data.attrList_2[this.attrIndex_2].configIndex
    end
    if this.attrIndex_3 ~= -1 then
        this.vm.data.item3_Choose_Pos = this.item3_Effect_Pos[this.attrIndex_3]
        this.chooseLevel = this.vm.data.attrList_3[this.attrIndex_3].curLevel
        this.chooseMaxLevel = this.vm.data.attrList_3[this.attrIndex_3].totalLevel
        this.chooseConfigIndex = this.vm.data.attrList_3[this.attrIndex_3].configIndex
    end
end

this.CancelItemChoose = function()
    if this.attrIndex_1 ~= -1 then
        this.vm.data.item1_Choose_Pos = Vector2(3000,0)
    end
    if this.attrIndex_2 ~= -1 then
        this.vm.data.item2_Choose_Pos = Vector2(3000,0)
    end
    if this.attrIndex_3 ~= -1 then
        this.vm.data.item3_Choose_Pos = Vector2(3000,0)
    end
end

this.UpdateAttrView = function()
    if this.viewType == this.viewEnum.curShow then
        this.SetCurAttr()
        this.vm.data.all_Text1_Effect = false
        this.vm.data.all_Text2_Effect = false
        this.vm.data.all_Text3_Effect = false
    elseif this.viewType == this.viewEnum.allShow then
        this.SetAllAttr()
    end
    this.vm.data.allReset = this.viewType == this.viewEnum.allShow and this.characterData.usedPoint > 0
    this.vm.data.reset = this.viewType == this.viewEnum.curShow and this.chooseLevel > 0
    this.vm.data.confirm = this.viewType == this.viewEnum.curShow and this.chooseLevel < this.chooseMaxLevel
    this.vm.data.curAttrView = this.viewType == this.viewEnum.curShow
    this.vm.data.allAttrView = this.viewType == this.viewEnum.allShow and this.characterData.usedPoint > 0
    this.vm.data.noActivation = this.viewType == this.viewEnum.allShow and this.characterData.usedPoint == 0
end

this.SetCurAttr = function()
    local talentBack = nil
    if this.chooseLevel == 0 then
        this.vm.data.curValueText = ""
        this.vm.data.curTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2373"].NameLan)
    else
        talentBack = ConfigMgr.Config.talentBankMap[this.attrConfig[this.chooseConfigIndex].talentBankId[this.chooseLevel]]
        this.vm.data.curValueText = LuaMgr.GetLangText(talentBack.DescriptionLan)
        this.vm.data.curTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2375"].NameLan)
    end
    if this.chooseLevel + 1 <= this.chooseMaxLevel then
        talentBack = ConfigMgr.Config.talentBankMap[this.attrConfig[this.chooseConfigIndex].talentBankId[this.chooseLevel + 1]]
        local valueStr = ""
        local needCount = this.attrConfig[this.chooseConfigIndex].requireItems[this.chooseLevel + 1]
        if needCount > this.characterData.totalPoint - this.characterData.usedPoint then
            valueStr = "<color=#FF2D2D>"..needCount.."</color>"
        else
            valueStr = "<color=#FFFFFF>"..needCount.."</color>"
        end
        this.vm.data.confirmValue = valueStr
        this.vm.data.nextTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2374"].NameLan)
        this.vm.data.nextValueText = LuaMgr.GetLangText(talentBack.DescriptionLan)
    else
        this.vm.data.nextTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2378"].NameLan)
        this.vm.data.nextValueText = ""
    end
end

this.SetAllAttr = function()
    if this.characterData.usedPoint <= 0 then return end
    this.vm.data.attrTextList = {}
    local tempData,tempList = nil,{}
    local level,talentBack = 0,nil
    this.tableInsert(tempList,{value = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2381"].NameLan)})
    for i = 1, #this.attrConfig do
        if this.characterData.optional[this.attrConfig[i].id] ~= nil then
            level = this.characterData.optional[this.attrConfig[i].id]
            if level > 0 then
                talentBack = ConfigMgr.Config.talentBankMap[this.attrConfig[i].talentBankId[level]]
                tempData = {value = LuaMgr.GetLangText(talentBack.DescriptionLan)}
                this.tableInsert(tempList,tempData)
            end
        end
    end
    this.vm.data.attrTextList = tempList
end

this.LearningTalent = function()
    local tempLevel = this.chooseLevel + 1
    local needPoint = this.attrConfig[this.chooseConfigIndex].requireItems[tempLevel]
    if needPoint > this.characterData.totalPoint - this.characterData.usedPoint then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2380"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
    else
        local tempData = {}
        tempData["optionalId"] = this.attrConfig[this.chooseConfigIndex].id
        tempData["level"] = tempLevel
        ApiMgr.Request("point_optional", tempData,true,function(result)
            local re = json.decode(result)
            if re.code == 0 then
                AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/huazhao_puzzle.mp3")
                this.characterData = DataMgr.Player.characters[this.characterData.id]
                this.UpdateText()
                this.SetPointView()
                this.SetItemChoose()
                this.LearningPlayEffect()
                this.UpdateAttrView()
            end
        end,nil,true)
    end
end

this.LearningPlayEffect = function()
    if this.attrIndex_1 ~= -1 then
        this.vm.data.item1_UpLv = false
        this.vm.data.item1_UpLv_Pos = this.item1_Effect_Pos[this.attrIndex_1]
        this.vm.data.item1_UpLv = true
    end
    if this.attrIndex_2 ~= -1 then
        this.vm.data.item2_UpLv = false
        this.vm.data.item2_UpLv_Pos = this.item2_Effect_Pos[this.attrIndex_2]
        this.vm.data.item2_UpLv = true
    end
    if this.attrIndex_3 ~= -1 then
        this.vm.data.item3_UpLv = false
        this.vm.data.item3_UpLv_Pos = this.item3_Effect_Pos[this.attrIndex_3]
        this.vm.data.item3_UpLv = true
    end
end

this.ResetSingleTalent = function()
    local tempData = {}
    tempData["characterId"] = this.characterData.id
    tempData["optionalId"] = this.attrConfig[this.chooseConfigIndex].id
    ApiMgr.Request("cancel_point_optional", tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.characterData = DataMgr.Player.characters[this.characterData.id]
            this.UpdateText()
            this.SetPointView()
            this.SetItemChoose()
            this.UpdateAttrView()
        end
    end,nil,true)
end

this.ResetAllTalent = function()
    local tempData = {}
    tempData["characterId"] = this.characterData.id
    tempData["optionalId"] = "all"
    ApiMgr.Request("cancel_point_optional", tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.characterData = DataMgr.Player.characters[this.characterData.id]
            this.UpdateText()
            this.SetPointView()
            this.UpdateAttrView()
            this.OpenItemEffect()
        end
    end,nil,true)
end

this.OpenAttrDetails = function()
    local talentBack = ConfigMgr.Config.talentBankMap[this.attrConfig[this.chooseConfigIndex].talentBankId[1]]
    local iconName,nameLength = talentBack.talentParam1,NumTool.GetStringLength(talentBack.talentParam1)
    iconName = NumTool.split(LuaMgr.SubstringLen(iconName,1,nameLength - 2),',')[1]
    this.vm.data.attrDesIcon = LuaMgr.GetSprite("AttributeIcon",iconName)
    local nameStr,attDesStr = this.GetAttrDes(iconName)
    if nameStr == nil or attDesStr == nil then
        nameStr,attDesStr = "",""
    end
    this.vm.data.attrDesName = LuaMgr.GetLangText(nameStr)
    this.vm.data.attrDesText = LuaMgr.GetLangText(attDesStr)
    this.vm.data.attrDesRoot = true
end
this.GetAttrDes = function(attKey)
    local attrDes = ConfigMgr.Config.attrDesMap[attKey];
    if (attrDes ~= nil) then
        return attrDes.NameLan,attrDes.TextLan;
    end
end
this.CloseAttrDetails = function()
    this.onPressClick = false
    this.vm.data.attrDesText = ""
    this.vm.data.attrDesRoot = false
end

this.attrItem_1Click = function (index)
    this.CancelItemChoose()
    this.attrIndex_1 = index
    this.attrIndex_2 = -1
    this.attrIndex_3 = -1
    this.SetItemChoose()
    this.viewType = this.viewEnum.curShow
    this.UpdateAttrView()
end
this.attrItem_2Click = function (index)
    this.CancelItemChoose()
    this.attrIndex_1 = -1
    this.attrIndex_2 = index
    this.attrIndex_3 = -1
    this.SetItemChoose()
    this.viewType = this.viewEnum.curShow
    this.UpdateAttrView()
end
this.attrItem_3Click = function (index)
    this.CancelItemChoose()
    this.attrIndex_1 = -1
    this.attrIndex_2 = -1
    this.attrIndex_3 = index
    this.SetItemChoose()
    this.viewType = this.viewEnum.curShow
    this.UpdateAttrView()
end

this.CloseEffect = function()
    this.vm.data.all_Text1_Effect = false
    this.vm.data.all_Text2_Effect = false
    this.vm.data.all_Text3_Effect = false

    this.vm.data.item1_UpLv = false
    this.vm.data.item2_UpLv = false
    this.vm.data.item3_UpLv = false
end

return vm({
    data = data,
    command = command,
    hook = hook
})


