





local teamIndex = 0
local maxSquadCount = nil
local ToString = tostring
local ToNumber = tonumber
local StrFormat = string.format
local TableInsert = table.insert
local onDragRoot = nil
local heroListRoot = nil
local dragIndex = 0
local tarIndex = 0
local downTime = 0
local dragBool = false
local coroutine_key = nil
local localPosition = nil
local spineRootTab = {}
local animator = nil

local rectTransformTab = {}
local this = {vm = nil}

local data = {
    dropHeight = Vector2.zero,dropContent = Vector2.zero,
    dropDown = false,dropOrder = Vector3.one,dropText = "",
    dropList = {{dropText = "",dropChoose = Vector3.zero}},
    heroPic = DefaultTexture,heroRare = DefaultSprite,heroLevel = "",
    heroJob = DefaultSprite,zzSprite = DefaultSprite,heroZZText = "",
    heroName = "",dragItem = false,dragItemTransform = Vector2.zero,
    scaleRoot = Vector3.zero,
    HeroList = {
        {null = Vector3.zero,info = Vector3.zero,pic = DefaultTexture,rare = DefaultSprite,level = "",heroId = "",job = DefaultSprite,
         heroZZ = DefaultSprite,zzText = "",name = "",spine = Vector3.zero,spineRare = DefaultSprite,select = Vector3.zero},
        {null = Vector3.zero,info = Vector3.zero,pic = DefaultTexture,rare = DefaultSprite,level = "",heroId = "",job = DefaultSprite,
         heroZZ = DefaultSprite,zzText = "",name = "",spine = Vector3.zero,spineRare = DefaultSprite,select = Vector3.zero},
        {null = Vector3.zero,info = Vector3.zero,pic = DefaultTexture,rare = DefaultSprite,level = "",heroId = "",job = DefaultSprite,
         heroZZ = DefaultSprite,zzText = "",name = "",spine = Vector3.zero,spineRare = DefaultSprite,select = Vector3.zero},
        {null = Vector3.zero,info = Vector3.zero,pic = DefaultTexture,rare = DefaultSprite,level = "",heroId = "",job = DefaultSprite,
         heroZZ = DefaultSprite,zzText = "",name = "",spine = Vector3.zero,spineRare = DefaultSprite,select = Vector3.zero},
        {null = Vector3.zero,info = Vector3.zero,pic = DefaultTexture,rare = DefaultSprite,level = "",heroId = "",job = DefaultSprite,
         heroZZ = DefaultSprite,zzText = "",name = "",spine = Vector3.zero,spineRare = DefaultSprite,select = Vector3.zero},
        {null = Vector3.zero,info = Vector3.zero,pic = DefaultTexture,rare = DefaultSprite,level = "",heroId = "",job = DefaultSprite,
         heroZZ = DefaultSprite,zzText = "",name = "",spine = Vector3.zero,spineRare = DefaultSprite,select = Vector3.zero}},
}

local command = {
    leftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = teamIndex
            if index > 1 then
                index = index - 1
            else
                index = maxSquadCount
            end
            this.SwitchTeam(index)
        end
    },
    rightCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = teamIndex
            if index < maxSquadCount then
                index = index + 1
            else
                index = 1
            end
            this.SwitchTeam(index)
        end
    },
    dropDownCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SwitchDropdown()
        end
    },
    downItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            this.SwitchTeam(index)
            this.SwitchDropdown()
        end
    },
    heroItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SingleHeroClick(ToNumber(param))
        end
    },
    fastCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.MoreHeroClick()
        end
    },
    emptyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            for i = 1, #this.vm.data.HeroList do
                this.vm.data.HeroList[i].heroId = ""
            end
            this.RequestSaveTeam(function()
                this.UpdateTeamInfo()
            end)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        heroListRoot = vm.behaviour.transform:Find("root/Middle/HeroList")
        onDragRoot = vm.behaviour.transform:Find("root/Middle/HeroList/OnDragRoot/DragItem"):GetComponent("RectTransform")
        animator = vm.behaviour.transform:Find("root/Middle/HeroList"):GetComponent("Animator")
        this.GetRectTransform()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.AddUIEventListener(UIEventConst.OnApplicationFocus, this.OnApplicationFun)
        HeroParameter.EmptyListParam()
        this.ViewAdaptive()
        this.InitParameter()
        this.CreateDropdown()
        this.UpdateTeamInfo()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.dragItem = false
        for i = 1, #spineRootTab do
            spineRootTab[i]:Clear()
        end
        if coroutine_key ~= nil then
            coroutine_runner.stop(coroutine_key)
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.OnApplicationFocus, this.OnApplicationFun)
        LuaMgr.CheckRefCount();
    end,
}


this.OnApplicationFun = function(args)
    local hasFocus = args[0]
    if hasFocus then
        this.vm.data.dragItem = false
        this.UpdateTeamInfo()
    end
end


this.ViewAdaptive = function()
    this.vm.data.dropOrder = Vector3(1,-1,1)
    maxSquadCount = ConfigMgr.Config.constants.maxSquadCount
    local dropHeight = 5 + 47 * maxSquadCount - 1
    local dropContent = 5 + 47 * maxSquadCount - 1
    if maxSquadCount > 6 then
        dropHeight = 305
    end
    this.vm.data.dropHeight = Vector2(147,dropHeight)
    this.vm.data.dropContent = Vector2(147,dropContent)
end


this.InitParameter = function()
    this.vm.behaviour:UpdateTopBar("", function()
        this.RequestSaveTeam(function()
            LuaMgr.Back()
        end)
    end)
    if HeroParameter.teamIndex == nil or HeroParameter.teamIndex == "" then
        teamIndex = 1
    else
        if type(HeroParameter.teamIndex) == "string" then
            teamIndex = ToNumber(HeroParameter.teamIndex) + 1
        else
            teamIndex = HeroParameter.teamIndex
        end
    end
    this.vm.data.dropText = LuaMgr.GetLangText("HeroTeamViewModel_8")..teamIndex
end

this.CreateDropdown = function()
    local tempList = {}
    local tempItem = {}
    for i = 1, maxSquadCount do
        tempItem = {dropText = LuaMgr.GetLangText("HeroTeamViewModel_9")..i,dropChoose = Vector3.zero,index = i}
        if i == teamIndex then
            tempItem.dropChoose = Vector3.one
        end
        TableInsert(tempList,tempItem)
    end
    this.vm.data.dropList = tempList
    this.vm.data.dropDown = false
end

this.UpdateTeamInfo = function()
    local index = ToString(teamIndex - 1)
    local team = DataMgr.Player.teams[index]
    local heroId = nil
    for i = 0, 5 do
        heroId = team.members[ToString(i)]
        this.UpdateHeroInfo(heroId,i + 1)
    end
end

this.UpdateHeroInfo = function(heroId,index)
    if heroId == nil then
        this.vm.data.HeroList[index].null = Vector3.one
        this.vm.data.HeroList[index].info = Vector3.zero
        this.vm.data.HeroList[index].spine = Vector3.zero
        this.vm.data.HeroList[index].heroId = ""
        spineRootTab[index]:Clear()
    else
        local heroData = DataMgr.Player.characters[heroId]
        local heroConfig = ConfigMgr.Config.characterTable[heroId]
        if heroConfig ~= nil then
            this.vm.data.HeroList[index].null = Vector3.zero
            this.vm.data.HeroList[index].pic = LuaMgr.GetTexture(HeroManager.GetCharacterCard(heroId))
            this.vm.data.HeroList[index].rare = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..heroConfig.rare)
            this.vm.data.HeroList[index].level = ToString(heroData.level)
            this.vm.data.HeroList[index].job = LuaMgr.GetSprite("JobIcon","job_"..heroConfig.job)
            local zzLevel = HeroMgr.GetCharacterZZ(heroId)
            local zzStr = zzLevel > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
            this.vm.data.HeroList[index].zzText = StrFormat(zzStr,HeroMgr.GetNumStr(math.abs(zzLevel)))
            this.vm.data.HeroList[index].heroZZ = LuaMgr.GetSprite("CommonRes",zzLevel > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")
            this.vm.data.HeroList[index].name = LuaMgr.GetLangText(heroConfig.namelan)
            this.vm.data.HeroList[index].spineRare = LuaMgr.GetSprite("CardRareMask","mask_"..heroConfig.rare)
            this.vm.data.HeroList[index].info = Vector3.one
            this.vm.data.HeroList[index].spine = Vector3.one
            this.vm.data.HeroList[index].select = Vector3.zero
            this.vm.data.HeroList[index].heroId = heroId
            local wearId = ""
            if heroData.wear ~= "" then
                local equipId = DataMgr.Player.equipments[heroData.wear].equipmentId
                wearId = ConfigMgr.Config.equipments[equipId].Mid
            end
            local curSkin = DataHelper.GetCharacterSkin(heroId)
            spineRootTab[index]:SetBattle(heroId,curSkin,wearId,heroConfig.job)
        end
    end
end

this.PointerDownItem = function(index,eventData)
    dragBool = false
    dragIndex = index
    tarIndex = 0
    this.UpdateDragItem(this.vm.data.HeroList[index].heroId)
    this.vm.data.dragItemTransform = rectTransformTab[dragIndex].anchoredPosition
    localPosition = LuaMgr.Screen2Local(eventData.position,onDragRoot)
    downTime = CS.UnityEngine.Time.realtimeSinceStartup
    if coroutine_key ~= nil then
        coroutine_runner.stop(coroutine_key)
    end
    coroutine_key = coroutine_runner.start(function()
        coroutine_runner.wait(0.12)
        dragBool = true
        this.vm.data.scaleRoot = Vector3(1.08,1.08,1)
        this.vm.data.dragItem = true
        this.vm.data.HeroList[index].info = Vector3.zero
    end)
end

this.DragItem = function(eventData)
    if coroutine_key ~= nil then
        coroutine_runner.stop(coroutine_key)
    end
    if not dragBool then return end
    local tarPos = LuaMgr.Screen2Local(eventData.position,onDragRoot)
    local dirVector = Vector2(tarPos.x - localPosition.x,this.vm.data.dragItemTransform.y)
    this.vm.data.dragItemTransform = Vector2(this.vm.data.dragItemTransform.x + dirVector.x,dirVector.y)
    local tempBool = false
    for i = 1, #rectTransformTab do
        if tempBool == false then tarIndex = 0 end
        this.vm.data.HeroList[i].select = Vector3.zero
        if i ~= dragIndex and this.Intersect(rectTransformTab[i].anchoredPosition) and this.vm.data.HeroList[i].heroId ~= "" then
            tarIndex = i
            this.vm.data.HeroList[i].select = Vector3.one
            tempBool = true
        end
    end
end

this.PointerUpItem = function(eventData)
    dragBool = false
    if coroutine_key ~= nil then
        coroutine_runner.stop(coroutine_key)
    end
    if CS.UnityEngine.Time.realtimeSinceStartup - downTime <= 0.2 then
        this.SingleHeroClick(dragIndex)
    else
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/select.mp3")
        if tarIndex ~= 0 then
            local dragHeroId = this.vm.data.HeroList[dragIndex].heroId
            local tarHeroId = this.vm.data.HeroList[tarIndex].heroId
            this.vm.data.HeroList[tarIndex].select = Vector3.zero
            this.UpdateHeroInfo(dragHeroId,tarIndex)
            this.UpdateHeroInfo(tarHeroId,dragIndex)
            tarIndex = 0
        end
    end
    this.vm.data.HeroList[dragIndex].info = Vector3.one
    this.vm.data.dragItem = false
    this.vm.data.scaleRoot = Vector3.one
    dragIndex = 0
end

this.UpdateDragItem = function(heroId)
    local heroConfig = ConfigMgr.Config.characterTable[heroId]
    local heroData = DataMgr.Player.characters[heroId]
    this.vm.data.heroPic = LuaMgr.GetTexture(HeroManager.GetCharacterCard(heroId))
    this.vm.data.heroRare = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..heroConfig.rare)
    this.vm.data.heroLevel = ToString(heroData.level)
    this.vm.data.heroJob = LuaMgr.GetSprite("JobIcon","job_"..heroConfig.job)
    local zzLevel = HeroMgr.GetCharacterZZ(heroId)
    local zzStr = zzLevel > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
    this.vm.data.heroZZText = StrFormat(zzStr,HeroMgr.GetNumStr(math.abs(zzLevel)))
    this.vm.data.zzSprite = LuaMgr.GetSprite("CommonRes",zzLevel > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")
    this.vm.data.heroName = LuaMgr.GetLangText(heroConfig.namelan)
end


this.SingleHeroClick = function(index)
    this.RequestSaveTeam(function()
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_special_1.mp3")
        local heroId = this.vm.data.HeroList[index].heroId
        HeroParameter.SaveTeamParam(teamIndex,false,heroId,this.PlayChangeHeroVoice)
        FeatureManager.GotoPanel("1004")
    end)
end

this.MoreHeroClick = function()
    this.RequestSaveTeam(function()
        HeroParameter.SaveTeamParam(teamIndex,true,"",this.PlayChangeHeroVoice)
        FeatureManager.GotoPanel("1004")
    end)
end

this.RequestSaveTeam = function(callBack)
    local data = {}
    data["TeamID"] = ToString(teamIndex - 1)
    data["Members"] = {}
    for i = 1, #this.vm.data.HeroList do
        if this.vm.data.HeroList[i].heroId ~= "" then
            data["Members"][ToString(i - 1)] = this.vm.data.HeroList[i].heroId
        end
    end
    BattlePrepareMgr.CheckAndSaveTeam(data, function(result)
        if callBack ~= nil then
            callBack()
        end
    end)
end

this.SwitchDropdown = function()
    this.vm.data.dropDown = not this.vm.data.dropDown
    if this.vm.data.dropDown then
        this.vm.data.dropOrder = Vector3.one
    else
        this.vm.data.dropOrder = Vector3(1,-1,1)
    end
end

this.SwitchTeam = function(index)
    if index == teamIndex then return end
    animator:Play("ani_HeroTeamPanel_root_1",0,0)
    this.RequestSaveTeam()
    this.vm.data.dropList[teamIndex].dropChoose = Vector3.zero
    teamIndex = index
    this.vm.data.dropList[teamIndex].dropChoose = Vector3.one
    this.vm.data.dropText = this.vm.data.dropList[index].dropText
    this.UpdateTeamInfo()
end

this.GetRectTransform = function()
    for i = 1, #this.vm.data.HeroList do

        spintRoot = heroListRoot.transform:Find(i.."/Spine/Spine/QSpin"):GetComponent("UISpineCharacter")
        TableInsert(spineRootTab,spintRoot)

        local rectTransform = heroListRoot.transform:Find(i):GetComponent("RectTransform")
        TableInsert(rectTransformTab,rectTransform)

        local dragEvent = heroListRoot.transform:Find(i.."/Info"):GetComponent("OnDragEvent")
        if dragEvent ~= nil then
            dragEvent:SetData(i,this.PointerDownItem,this.DragItem,this.PointerUpItem)
        end
    end
end


this.PlayChangeHeroVoice = function(teamMembers)
    if #teamMembers == 0 then return end
    LuaMgr.CharacterJoinTeamVoice(teamMembers)
end

this.Intersect = function(pos)

    local halfSumX = 150 * 0.4
    local halfSumY = 342 * 0.4
    local distX = math.abs(this.vm.data.dragItemTransform.x - pos.x)
    local distY = math.abs(this.vm.data.dragItemTransform.y - pos.y)
    return distX <= halfSumX and distY <= halfSumY
end

return vm({
    data = data,
    command = command,
    hook = hook
})