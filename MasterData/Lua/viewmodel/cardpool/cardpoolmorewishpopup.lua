





local this = {
    vm = nil,cardPoolData = nil,
    isClickActive = true,isJobWish = false,
    selectList = nil,selectNums = nil,
    jobType = nil,heroIdDic = nil,callBack = nil
}

local data = {
    titleText = "",confirmText = "",
    confirmBtn = false,tipText = "",
    introText = "",
    heroHeadItem = {{headIcon = DefaultTexture,jobIcon = DefaultSprite,select = false,numSprite = DefaultSprite}}
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CardPoolMoreWishPopup)
        end
    },
    headCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            this.HeadSelect(index)
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.isClickActive then
                this.isClickActive = false
                if this.isJobWish then
                    if this.callBack ~= nil then
                        this.callBack(this.jobType,this.selectList)
                        this.isClickActive = true
                        LuaMgr.HidePanel(UIName.CardPoolMoreWishPopup)
                    end
                else
                    if not TableIsNull(this.selectList) and #this.selectList >= ConfigMgr.Config.constants.CardPoolChooseMaxNum then
                        local name_1,name_2,name_3,name_4 = this.GetCharacterName()
                        local titleStr = ConfigMgr.LangGlobal("26517")
                        local tipStr = string.format(ConfigMgr.LangGlobal("26518"),name_1,name_2,name_3,name_4)
                        LuaMgr.ShowLuaPanel
                        (
                                UIName.ConfirmTipViewModel,titleStr,tipStr,
                                function()
                                    local tempData = {}
                                    tempData["cardPool"] = this.cardPoolData.id
                                    tempData["characters"] = this.selectList
                                    ApiMgr.Request("draw_card_select", tempData,true,function(result)
                                        local re = json.decode(result)
                                        if re.code == 0 then
                                            this.isClickActive = true
                                            LuaMgr.InvokeUIEventListeners(UIEventConst.CardPoolSelectWish)
                                            LuaMgr.HidePanel(UIName.CardPoolMoreWishPopup)
                                        end
                                    end,nil,true)
                                end,
                                function()
                                    this.isClickActive = true
                                end
                        )
                    else
                        this.isClickActive = true
                    end
                end
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
        this.AddUIEvent()
        this.InitParameter()
        this.SetLanguageText()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this.vm.data.heroHeadItem = {}
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()
    
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
        return
    end
    this.isClickActive = true
    local cardId = this.vm.behaviour.Params[0]
    this.cardPoolData = ConfigMgr.Config.cardPools[cardId]
    if TableIsNull(this.cardPoolData) then
        return
    end
    this.selectList = {}
    this.selectNums = {}
    if this.vm.behaviour.Params.Length == 4 then
        this.isJobWish = true
        this.jobType = this.vm.behaviour.Params[1]
        this.heroIdDic = this.vm.behaviour.Params[2]
        this.callBack = this.vm.behaviour.Params[3]
        for key,value in pairs(this.heroIdDic) do
            this.selectList[value] = key
        end
this.selectNums = table.Copy(this.heroIdDic)
    else
        this.isJobWish = false
        this.jobType = nil
        this.heroIdDic = nil
        this.callBack = nil
    end
    this.vm.data.confirmBtn = true
    this.SetMissionData()
    this.UpdateNumText()
end

this.SetMissionData = function()
    if TableIsNull(this.cardPoolData.changeList) then
        return
    end
    local tempList,tempItem = {},nil
    local character = nil
    for i = 1, #this.cardPoolData.changeList do
        character = ConfigMgr.Config.characterTable[this.cardPoolData.changeList[i]]
        if not TableIsNull(character) then
            if this.isJobWish and this.jobType ~= character.job then
                goto continue
            end
            tempItem = {
                headIcon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(character.id,character.id.."001")),
                jobIcon = LuaMgr.GetSprite("JobIcon","job_"..character.job),
                select = false, numSprite = DefaultSprite,id = character.id}
            tempItem.select = this.selectNums[character.id] ~= nil
            tempItem.numSprite = this.selectNums[character.id] ~= nil and LuaMgr.GetSprite("NumberFont","select_"..this.selectNums[character.id]) or DefaultSprite
            table.insert(tempList,tempItem)  
        end
        ::continue::
    end
    this.vm.data.heroHeadItem = tempList
end

this.HeadSelect = function(index)
    if index == nil then return end
    local characterId = this.vm.data.heroHeadItem[index].id
    if this.selectNums[characterId] == nil then
        if this.isJobWish then
            if #this.selectList == 5 then
                return
            end
        else
            if #this.selectList == ConfigMgr.Config.constants.CardPoolChooseMaxNum then
                return
            end
        end
        table.insert(this.selectList,characterId)
        this.selectNums[characterId] = #this.selectList
    else
        for i = #this.selectList,1,-1 do
            if this.selectList[i] == characterId then
                table.remove(this.selectList,i)
                break
            end
        end
        for k,v in pairs(this.selectNums) do
            if v > this.selectNums[characterId] then
                this.selectNums[k] = v - 1
            end
        end
        this.selectNums[characterId] = nil
    end
    for i = 1, #this.vm.data.heroHeadItem do
        characterId = this.vm.data.heroHeadItem[i].id
        if this.selectNums[characterId] ~= nil then
            this.vm.data.heroHeadItem[i].numSprite = LuaMgr.GetSprite("NumberFont","select_"..this.selectNums[characterId])
        end
        this.vm.data.heroHeadItem[i].select = this.selectNums[characterId] ~= nil
    end
    this.UpdateNumText()
end

this.UpdateNumText = function()
    local count = #this.selectList
    local str = ""
    if this.isJobWish then
        str = ConfigMgr.LangGlobal("29528")
        this.vm.data.tipText = string.format(str,count,5)
        this.vm.data.confirmBtn = false
    else
        str = ConfigMgr.LangGlobal("26515")
        this.vm.data.tipText = string.format(str,count,ConfigMgr.Config.constants.CardPoolChooseMaxNum)
        this.vm.data.confirmBtn = count < ConfigMgr.Config.constants.CardPoolChooseMaxNum
    end
end


this.SetLanguageText = function()
    if this.isJobWish then
        this.vm.data.introText = ""
    else
        local str = ConfigMgr.LangGlobal("26514")
        this.vm.data.introText = string.format(str,ConfigMgr.Config.constants.CardPoolChooseMaxNum)
    end
    this.vm.data.titleText = ConfigMgr.LangGlobal("17204")
    this.vm.data.confirmText = ConfigMgr.LangGlobal("17205")
end

this.GetCharacterName = function()
    local name_1,name_2,name_3,name_4 = "","","",""
    local heroConfig = nil
    for i = 1, #this.selectList do
        heroConfig = ConfigMgr.Config.characterTable[this.selectList[i]]
        if not TableIsNull(heroConfig) then
            if i == 1 then
                name_1 = LuaMgr.GetLangText(heroConfig.namelan)
            elseif i == 2 then
                name_2 = LuaMgr.GetLangText(heroConfig.namelan)
            elseif i == 3 then
                name_3 = LuaMgr.GetLangText(heroConfig.namelan)
            elseif i == 4 then
                name_4 = LuaMgr.GetLangText(heroConfig.namelan)
            end
        end
    end
    return name_1,name_2,name_3,name_4
end


return vm({
    data = data,
    command = command,
    hook = hook
})