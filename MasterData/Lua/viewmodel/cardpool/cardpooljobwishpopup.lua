





local this = {
    vm = nil,
    cardPoolData = nil,heroJobList = nil,
    selectCharacterIds = nil,
}

local data = {
    titleText = "", confirmBtn = false,
    confirmText = "",tipText = "",
    
    jobItemList = 
    {{
            jobImg = DefaultSprite,
            jobText = "",
            headItemList = {
                {
                    heroIcon = DefaultTexture,
                    jobIcon = DefaultSprite,
                    headShow = false,
                    addShow = false
                }
            }
    }}
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CardPoolJobWishPopup)
        end
    },
    jobCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            local heroIdDic = {}
            for i = 1, #this.vm.data.jobItemList[index].headItemList do
                if not IsNullOrEmpty(this.vm.data.jobItemList[index].headItemList[i].heroId) then
                    heroIdDic[this.vm.data.jobItemList[index].headItemList[i].heroId] = i
                end
            end
            LuaMgr.ShowLuaPanel(UIName.CardPoolMoreWishPopup,this.cardPoolData.id,index,heroIdDic,this.UpdateHeadCallBack)
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if TableIsNull(this.selectCharacterIds) or #this.selectCharacterIds < 25 then
                return
            end
            local tempData = {}
            tempData["cardPool"] = this.cardPoolData.id
            tempData["characters"] = this.selectCharacterIds
            ApiMgr.Request("draw_card_select", tempData,true,function(result)
                local re = json.decode(result)
                if re.code == 0 then
                    LuaMgr.InvokeUIEventListeners(UIEventConst.CardPoolSelectWish)
                    LuaMgr.HidePanel(UIName.CardPoolJobWishPopup)
                end
            end,nil,true)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.SetLanguageText = function()
    this.vm.data.titleText = ConfigMgr.LangGlobal("17204")
    this.vm.data.tipText = ConfigMgr.LangGlobal("29527")
    this.vm.data.confirmText = ConfigMgr.LangGlobal("17205")
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
        return
    end
    local cardId = this.vm.behaviour.Params[0]
    this.cardPoolData = ConfigMgr.Config.cardPools[cardId]
    if TableIsNull(this.cardPoolData) then
        return
    end
    this.GetHeroJob()
    this.SetJobWish()
    this.UpdateConfirmState()
end

this.SetJobWish = function()
    local jobTempData,jobTempList = nil,{}
    local heroId,jobIcon = nil,nil
    local headTempData,headTempList = nil,{}
    for i = 1, #this.heroJobList do
        jobTempData = {
            jobImg = LuaMgr.GetSprite("JobIcon", "jobWish_"..i),
            jobText = this.GetFilterName(i),
            headItemList = {},
        }
        headTempList = {}
        for j = 1, 5 do
            jobIcon = LuaMgr.GetSprite("JobIcon","job_"..i)
            heroId = #this.heroJobList[i] < j and "" or this.heroJobList[i][j]
            headTempData = {jobIcon = jobIcon, heroIcon = DefaultTexture,headShow = false,addShow = false,heroId = heroId}
            if not IsNullOrEmpty(heroId) then
                headTempData.heroIcon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(heroId,heroId.."001"))
                headTempData.headShow = true
                headTempData.addShow = false
            else
                headTempData.addShow = true
            end
            table.insert(headTempList,headTempData)
        end
        jobTempData.headItemList = headTempList
        table.insert(jobTempList,jobTempData)
    end
    this.vm.data.jobItemList = jobTempList
end

this.UpdateHeadCallBack = function(index,heroList)
    if index == nil or heroList == nil then
        return
    end
    local length = #heroList
    for i = 1, #this.vm.data.jobItemList[index].headItemList do
        if length < i then
            this.vm.data.jobItemList[index].headItemList[i].heroId = ""
            this.vm.data.jobItemList[index].headItemList[i].addShow = true
            this.vm.data.jobItemList[index].headItemList[i].headShow = false
        else
            local heroId = heroList[i]
            this.vm.data.jobItemList[index].headItemList[i].heroId = heroId
            this.vm.data.jobItemList[index].headItemList[i].addShow = false
            this.vm.data.jobItemList[index].headItemList[i].heroIcon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(heroId,heroId.."001"))
            this.vm.data.jobItemList[index].headItemList[i].headShow = true
        end
    end
    this.UpdateConfirmState()
end

this.UpdateConfirmState = function()
    this.selectCharacterIds = {}
    for i = 1, #this.vm.data.jobItemList do
        for j = 1, #this.vm.data.jobItemList[i].headItemList do
            if not IsNullOrEmpty(this.vm.data.jobItemList[i].headItemList[j].heroId) then
                table.insert(this.selectCharacterIds,this.vm.data.jobItemList[i].headItemList[j].heroId)
            end
        end
    end
    this.vm.data.confirmBtn = #this.selectCharacterIds < 25
end

this.GetHeroJob = function()
    this.heroJobList = {}
    for key,value in pairs(CharacterJob) do
        if value ~= 0 then
            this.heroJobList[value] = {}
        end
    end

    local drawCharacterSelect = {}
    if not TableIsNull(DataMgr.Player.drawCard) and not TableIsNull(DataMgr.Player.drawCard.drawCharacterSelect) then
        if DataMgr.Player.drawCard.drawCharacterSelect[this.cardPoolData.id]~=nil then
            drawCharacterSelect = DataMgr.Player.drawCard.drawCharacterSelect[this.cardPoolData.id]
        end
    end
    local character = nil
    for i = 1, #drawCharacterSelect do
        character = ConfigMgr.Config.characterTable[drawCharacterSelect[i]]
        if not TableIsNull(character) then
            table.insert(this.heroJobList[character.job],character.id)
        end
    end
end

this.GetFilterName = function(job)
    local name = ""
    if job == CharacterJob.Tank then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2401"].NameLan) end
    if job == CharacterJob.RangeAttack then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2402"].NameLan) end
    if job == CharacterJob.MeleeAttack then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2403"].NameLan) end
    if job == CharacterJob.Magic then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2404"].NameLan) end
    if job == CharacterJob.Assistant then name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2405"].NameLan) end
    return name
end

return vm({
    data = data,
    command = command,
    hook = hook
})