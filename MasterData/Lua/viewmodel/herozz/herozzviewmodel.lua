



local LaiguConfig = CS.Laigu.Manager.ConfigManager
local HeroManager = CS.Laigu.ViewModel.Hero.HeroManager
local skinPicPath = "Assets/_BundleResources/Character/%s/Drawing/%s.png"
local this = { vm = nil,coroutine_key = nil}
local msgTransform
local characterId
local maxStar
local zzIndex = 0
local zzStar
local outline1 = UnityEngine.Color(0, 60 / 255, 60 / 255, 1)
local outline2 = UnityEngine.Color(38 / 255, 36 / 255, 41 / 255, 1)
local starNotGet = UnityEngine.Color(84 / 255, 80 / 255, 72 / 255, 1)
local starAlready = UnityEngine.Color(50 / 255, 130 / 255, 127 / 255, 1)
local RoleAttr = {}
local zzListTransform
local animationClosePlay = false
local characterMsg
local zzHS = {}

local heroDragPage = nil
local dragPageTr = nil

local isDraging = false
local isAssisHero=false;

require("ViewModel/Hero/HeroDragPage")

local data = {
    bodyEnabled = false,
    bodyPath = "",
    num1 = DefaultSprite,
    num1Star = DefaultSprite,
    num2 = DefaultSprite,
    num2Star = DefaultSprite,
    num3 = DefaultSprite,
    num3Star = DefaultSprite,
    num1StarColor = UnityEngine.Color(1, 1, 1, 1),
    num2StarColor = UnityEngine.Color(1, 1, 1, 1),
    num3StarColor = UnityEngine.Color(1, 1, 1, 1),
    isNum1 = false,
    isNum2 = false,
    isNum2OutLine = false,
    isNum3 = false,
    isZZ = false,
    isMaxZZ = false,
    isNumEffect = false,
    ShowEffect1 = false,
    RigtPanelShow = true,
    BodyPanelShow = false,
    StarNumshow = false,
    AnimationStringData = "",
    zzDatas = {
        {
            bg = DefaultSprite,
            num = "",
            content = "",
            Line1add1 = false,
            Line1add1have = false,
            Line1add2have = false,
            Line2add2have = false,
            content2 = "",
            outline = UnityEngine.Color(1, 1, 1, 1),
            isShow = false,
            isLight = false,
            isLevelUp = false,
            isNotGetItem = false,
            isGetItem = false,
            LineParent = false,
            zzsameName = false,
            zzshow2Message = false,
            showNum1 = "",
            showNum2 = "",
            Name = "",
            firstDot = false,
            notSkillshow = false,
            addTage = "",
            numBgs = DefaultSprite
        }
    }
}
local command = {
    zzCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not animationClosePlay and not isDraging then
                characterMsg:Clear()
                local closefun = function ()
                     animationClosePlay = false
                end

                LuaMgr.ShowLuaPanel(UIName.HeroZZSelectViewModel, characterId,closefun)
                animationClosePlay = true
            end
        end
    }
}
local hook = {
    before_awake = function(vm)
        this.vm = vm
        zzListTransform = this.vm.behaviour.transform:Find("root/Right/ZZListMask/ZZList")
        msgTransform = this.vm.behaviour.transform:Find("root/Middle/Msg")
        dragPageTr = vm.behaviour.transform:Find("root/Middle/DragPage/DragPage")


        characterMsg = LuaMgr.LoadCharacterMsgViewModel(nil, msgTransform, characterId, 8, nil)

    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            characterId = vm.behaviour.Params[0]
            HeroParameter.CheckCharacterListIsNull()
            LuaMgr.AddUIEventListener(UIEventConst.HeroZZSelectClosePanel, this.DoubleClicSelect)
            LuaMgr.AddUIEventListener(UIEventConst.CharacterUpStar, this.OnCharacterUpStar)
            LuaMgr.AddUIEventListener(UIEventConst.HeroManagerDragEnd, this.OnEndDrag);
            maxStar = ConfigMgr.Config.constants.maxStar
            this.vm.data.BodyPanelShow = false
            this.vm.data.RigtPanelShow = true
            this.vm.data.StarNumshow = true
            this.vm.data.AnimationStringData = ""
            animationClosePlay = false
            RedMgr.Singleton:RegisterViewModel(UIName.HeroZZViewModel)
            this.SetInfo(true)
            this.SetDragPage()
        end
    end,
    before_deactive = function(vm)
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.HeroZZSelectClosePanel, this.DoubleClicSelect)
        LuaMgr.RemoveUIEventListener(UIEventConst.CharacterUpStar, this.OnCharacterUpStar)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeroManagerDragEnd, this.OnEndDrag)
        LuaMgr.RemoveTimer(TimerConst.HeroZZUpStarDelay)
        LuaMgr.RemoveTimer(TimerConst.HeroZZAnimationClose)
        LuaMgr.RemoveTimer(TimerConst.HeroZZUpStarNumDelay)
        characterMsg:Clear()
        this.vm.data.ShowEffect1 = false
        this.vm.data.AnimationStringData = ""
        animationClosePlay = false
        this.RemoveNumAni()
        if heroDragPage ~= nil then
            heroDragPage:Clear()
        end
    end
}


this.SetDragPage = function()
    if heroDragPage == nil then
        heroDragPage = HeroDragPage.New(dragPageTr)
    end
    local dragData = {
        rectSize = 1500,
        dragDist = 200,
        onClick = this.OnClickHeroMsg,
        onEnd = this.OnDragPage,
        ani = true,
        canDrag = true,
        isAssistHero=isAssisHero
    }
    heroDragPage:SetData(dragData)
end


this.OnDragPage = function()
    LuaMgr.HidePanel(UIName.HeroAttributeDetailsViewModel)
    LuaMgr.HidePanel(UIName.HeroOccupationViewModel)
    LuaMgr.HidePanel(UIName.SkillTipsViewModel)
    LuaMgr.HidePanel(UIName.WeaponTipsViewModel)
    
    characterId = HeroParameter.characterId;
    this.SetInfo(false)
    if characterMsg ~= nil then
        characterMsg:Clear()
    end
    this.OnClickHeroMsg()
    isDraging = false
end

this.OnEndDrag = function(args)
    local status = args[0]
    isDraging = status ~= 0
end

this.OnClickHeroMsg = function(param)
    AudioMgr.Singleton:StopVoice(true)
    LuaMgr.RemoveTimer(TimerConst.HeroViewShowMsg)
    characterMsg = LuaMgr.LoadCharacterMsgViewModel(characterMsg, msgTransform, HeroParameter.characterId, CharacterMsgType.ClickCharacter)
end


this.DoubleClicSelect = function()
    animationClosePlay = false
end


this.ContainsSkin = function(skinId)
    if skinId == characterId .. "001" then return true end
    if DataMgr.Player.characterSkins[characterId] == nil then return false end
    for i = 1, #DataMgr.Player.characterSkins[characterId] do
        if DataMgr.Player.characterSkins[characterId][i] == skinId then
            return true
        end
    end
    return false
end

this.SetInfo = function(isAni)
    local character=nil;
    isAssisHero=PlayerAssistMgr.IsCurAssistCharacter(characterId);
    if isAssisHero then
        character=PlayerAssistMgr.GetCurAssist_CharacterData();
    else
        character = DataMgr.Player.characters[characterId]
    end
    if character == nil then
        return
    end
    local skinID = HeroManager.GetCharacterSkin(characterId)
    zzStar = character.star
    this.SetNum(zzStar)
    this.SetZZ(zzStar, isAni)

    if isAssisHero then
        this.vm.data.isZZ = false
        this.vm.data.isMaxZZ = false
        return;
    end
    if (zzStar >= maxStar) then
        this.vm.data.isZZ = false
        this.vm.data.isMaxZZ = true
    else
        this.vm.data.isZZ = true
        this.vm.data.isMaxZZ = false
    end
    this.SetRed()
end

this.SetNum = function(star)
    if (star <= 1) then
        this.vm.data.isNum1 = false
        this.vm.data.isNum2 = true
        this.vm.data.isNum3 = true
        this.vm.data.isNum2OutLine = (zzStar == 1)
        this.vm.data.num3 = LuaMgr.GetSprite("HeroZZ", "ui_zz_quan_01")
        this.vm.data.num2 = LuaMgr.GetSprite("HeroZZ", zzStar == 0 and "ui_zz_quan_01" or "ui_zz_quan_02")
        if (zzStar == 0) then
            this.vm.data.num2Star = LuaMgr.GetSprite("HeroZZ", "ui_zz_txt_01b")
            this.vm.data.num2StarColor = (starNotGet)
        else
            this.vm.data.num2Star = LuaMgr.GetSprite("HeroZZ", "ui_zz_txt_01")
            this.vm.data.num2StarColor = UnityEngine.Color(1, 1, 1, 1)
        end
        this.vm.data.num3Star = LuaMgr.GetSprite("HeroZZ", "ui_zz_txt_02b")
        this.vm.data.num3StarColor = starNotGet
    else
        this.vm.data.num2StarColor = UnityEngine.Color(1, 1, 1, 1)
        if (maxStar == star) then
            this.vm.data.isNum1 = true
            this.vm.data.isNum2 = true
            this.vm.data.isNum3 = false
            this.vm.data.num1 = LuaMgr.GetSprite("HeroZZ", "ui_zz_quan_03")
            this.vm.data.num2 = LuaMgr.GetSprite("HeroZZ", "ui_zz_quan_02")
            this.vm.data.num1Star = LuaMgr.GetSprite("HeroZZ", string.format("ui_zz_txt_0%sb", star - 1))
            this.vm.data.num2Star = LuaMgr.GetSprite("HeroZZ", string.format("ui_zz_txt_0%s", star))
            this.vm.data.num1StarColor = starAlready
        else
            this.vm.data.isNum1 = true
            this.vm.data.isNum2 = true
            this.vm.data.isNum3 = true
            this.vm.data.num1 = LuaMgr.GetSprite("HeroZZ", "ui_zz_quan_03")
            this.vm.data.num2 = LuaMgr.GetSprite("HeroZZ", "ui_zz_quan_02")
            this.vm.data.num3 = LuaMgr.GetSprite("HeroZZ", "ui_zz_quan_01")
            this.vm.data.num1Star = (LuaMgr.GetSprite("HeroZZ", string.format("ui_zz_txt_0%sb", tostring(star - 1))))
            this.vm.data.num2Star = (LuaMgr.GetSprite("HeroZZ", string.format("ui_zz_txt_0%s", tostring(star))))
            this.vm.data.num3Star = (LuaMgr.GetSprite("HeroZZ", string.format("ui_zz_txt_0%sb", tostring(star + 1))))
            this.vm.data.num1StarColor = starAlready
            this.vm.data.num3StarColor = starNotGet
        end
    end
end
this.OnCharacterUpStar = function(args)
    local character = DataMgr.Player.characters[characterId]
    if (character == nil) then
        return
    end
    this.SetInfo(false)
    this.PlayNumAni()
    this.OnUpStar()
end

this.RemoveNumAni = function()
    this.vm.data.isNumEffect = false
end

this.PlayNumAni = function()
    LuaMgr.OpenCloseTopBar(false)
    this.vm.data.ShowEffect1 = true
    this.vm.data.RigtPanelShow = false
    this.vm.data.StarNumshow = false
    this.vm.data.AnimationStringData = "ani_UI_HeroZZPanel_001"
end

this.OnUpStar = function()
    LuaMgr.AddTimer(TimerConst.HeroZZUpStarDelay, this.ShowEffectPanel, 2, 7200, false)
    LuaMgr.AddTimer(TimerConst.HeroZZAnimationClose, this.StartUpAnimationClose, 3.83, 7200, false)
    LuaMgr.AddTimer(TimerConst.HeroZZUpStarNumDelay, this.OnUpStarNum, 1.58, 7200, false)
    this.vm.data.isNumEffect = true
    HeroManager.isHeroZZ = true
    local index = zzStar
    if (index >= 0 and index < maxStar) then
        this.vm.data.zzDatas[index].isLight = true
    end
    this.SetNum(zzStar)
end

this.OnUpStarNum = function()
    LuaMgr.RemoveTimer(TimerConst.HeroZZUpStarNumDelay)
    this.vm.data.StarNumshow = true
    HeroManager.isHeroZZ = false
end

this.ShowEffectPanel = function()
    LuaMgr.OpenCloseTopBar(true)
    this.vm.data.RigtPanelShow = true
    characterMsg:Clear()
    LuaMgr.LoadCharacterMsgViewModel(characterMsg, msgTransform, characterId, 8, tonumber(zzStar))

    LuaMgr.RemoveTimer(TimerConst.HeroZZUpStarDelay)
end

this.SetRed = function()
    RedMgr.Singleton:UpdateClientRedData("1025",PlayerCharacterMgr.RedZZ(characterId) and 1 or 0);
    RedMgr.Singleton:Refresh();
end


this.SetZZRedData = function()
    zzHS = {}
    local function DealHeroZZ(value)
        local characterConfig = ConfigMgr.Config.characterTable[value.id]
        if (characterConfig == nil) then
            return
        end

        local nextStar = value.star + 1
        if (nextStar > maxStar) then
            return
        end

        local rankUp = ConfigCharacterMgr.GetCharacterRankUp(tostring(nextStar), tostring(characterConfig.rare))
        if (rankUp == nil) then
            return
        end

        local coin = DataHelper.GetItemCountById("3")
        if (coin < rankUp.coin) then
            return
        end

        local itemCount = DataHelper.GetItemCountById(characterConfig.crystalItemId)
        if (itemCount >= rankUp.count) then
            table.insert(zzHS, value.id)
            return
        end









    end
    for index, value in pairs(DataMgr.Player.characters) do
        DealHeroZZ(value)
    end
end
this.StartUpAnimationClose = function()
    this.vm.data.AnimationStringData = ""
    animationClosePlay = false
    this.vm.data.ShowEffect1 = false
    LuaMgr.RemoveTimer(TimerConst.HeroZZAnimationClose)
end

this.SetZZ = function(star, isAni)
    local list = ConfigCharacterMgr.GetRoleAttr(characterId)
    if list == nil then

    end
    local tempList = {}
    local numStr = ""
    local bgStr = ""
    local content = ""
    local content2 = ""
    local sameName = false
    local show2Message = false
    local notshowSkill = false
    local Line1add1 = false
    local Line1Add1Have = false
    local Line1Add2Have = false
    local Line2Add2Have = false

    local showNumone = ""
    local showNumtwo = ""
    local index = 0

    for i = 2, #list, 1 do
        local AttarList = {}
        index = index + 1
        local IsGet = false
        local outline
        if list[i].starUpAttr ~= nil and list[i].starUpAttr ~= "" then
            local attar = list[i].starUpAttr
            local attar2 = list[i].starUpAttr2
            local GetStr = string.sub(attar, 2, #list[i].starUpAttr - 1)
            local strs = NumTool.split(GetStr, ",")
            local attr = strs[1]
            local attarSplite
            local attar2Splite
            local GetStr2
            local strs2
            local attr2

            if attr == "SkillUP" then
                notshowSkill = false
                sameName = false
                show2Message = false
                local skillUpStr = ""
                local skillId = strs[2]
local skillLevel = PlayerCharacterMgr.GetCharacterSkillLevel(characterId, skillId,isAssisHero)
                local skillName = HeroManager.GetCharacterSkillName(skillId, skillLevel)
                if skillName ~= nil and skillName ~= "" then
                    local colord =                    star >= index and LuaMgr.GetLangText("HeroZZViewModel_0") or
                    LuaMgr.GetLangText("HeroZZViewModel_1")
                    skillUpStr = colord .. "<a href=" .. skillId .. LuaMgr.GetLangText("HeroZZViewModel_11") .. skillName .. "】</a></color>"
                end
                skillName = HeroManager.GetCharacterSkillName(skillId .. "ex", skillLevel)
                if skillName ~= nil and skillName ~= "" then
                    local colord =                    star >= index and LuaMgr.GetLangText("HeroZZViewModel_2") or
                    LuaMgr.GetLangText("HeroZZViewModel_3")
                    skillUpStr = skillUpStr .. LuaMgr.GetLangText("HeroZZViewModel_4")
                    skillUpStr = skillUpStr .. colord .. "<a href=" .. skillId .. LuaMgr.GetLangText("HeroZZViewModel_12") .. skillName .. "】</a></color>"
                end
                if star >= index then
                    numStr = "<color=#e7dacd>%s</color>"
                    bgStr = "ui_zz_di01"
                    IsGet = true
                    content = string.format("<color=%s>%s</color>", "#59554d", skillUpStr)

                    outline = outline1
                else
                    numStr = "<color=#c9cbc3>%s</color>"
                    bgStr = "ui_zz_di00"
                    content = string.format("<color=%s>%s</color>", "#d2d2d2", skillUpStr)
                    outline = outline2
                end
            else
                notshowSkill = true
                local function GetOutLines(attr, strs, persent)
                    local attrDes = this.GetAttrDes(attr)
                    local attrValue = strs[2];
                    if (attrValue ~= nil) then
                        if (attr == "EnergyRecoveryCycle_FIX") then
                            attrValue = LuaMgr.Division(tonumber(attrValue), 100);
                        end
                    else
                        attrValue = "";
                    end
                    if attrDes ~= nil then
                        if (star >= index) then
                            IsGet = true
                            return "<color=#e7dacd>%s</color>", string.format(
                            "<color=%s>%s</color>",
                            "#59554d",
                            attrDes.Name ~= nil and LuaMgr.GetLangText(attrDes.Name) or ""
                            ), string.format(
                            "<color=%s>%s%s</color>",
                            "#1d7572",
                            attrValue,
                            attrDes.AttrDisplayType ~= nil and attrDes.AttrDisplayType or ""
                            ), outline1, "ui_zz_di01"
                        else
                            return "<color=#c9cbc3>%s</color>", string.format(
                            "<color=%s>%s</color>",
                            "#d2d2d2",
                            attrDes.Name ~= nil and LuaMgr.GetLangText(attrDes.Name) or ""
                            ), string.format(
                            "<color=%s>%s%s</color>",
                            "#88adac", 
                            attrValue,
                            attrDes.AttrDisplayType ~= nil and attrDes.AttrDisplayType or ""
                            ), outline2, "ui_zz_di00"
                        end
                    end
                end
                attarSplite = NumTool.split(attr, "_")
                numStr, content, showNumone, outline, bgStr = GetOutLines(attr, strs, attarSplite[2] == "PERCENT")

                if list[i].starUpAttr2 ~= nil and list[i].starUpAttr2 ~= "" then
                    GetStr2 = string.sub(attar2, 2, #list[i].starUpAttr2 - 1)
                    strs2 = NumTool.split(GetStr2, ",")
                    attr2 = strs2[1]
                    local numStr2
                    attar2Splite = NumTool.split(attr2, "_")
                    numStr2, content2, showNumtwo = GetOutLines(attr2, strs2, attar2Splite[2] == "PERCENT")

                    print(numStr2 .. "数字" .. "背景和内容" .. content2 .. "下划线")
                end
                attarSplite = attarSplite == nil and {} or attarSplite
                attar2Splite = attar2Splite == nil and {} or attar2Splite
                local Num2 = (strs2 ~= nil and strs2[2] ~= nil) and strs2[2] or ""
                sameName = (Num2 ~= "" and Num2 ~= "0")
                if attarSplite[1] == attar2Splite[1] then
                    show2Message = false

                    Line1Add1Have = (strs ~= nil and strs[2] ~= nil and strs[2] ~= "")
                    Line1Add2Have = (strs2 ~= nil and strs2[2] ~= nil and strs2[2] ~= "")
                    Line1add1 = false
                    Line2Add2Have = false
                else
                    Line1add1 = true
                    Line1Add1Have = (strs ~= nil and strs[2] ~= nil and strs[2] ~= "")
                    Line1Add2Have = false
                    Line2Add2Have = (strs2 ~= nil and strs2[2] ~= nil and strs2[2] ~= "")
                    show2Message = sameName and true
                end
            end
        end
        if numStr == nil or numStr == "" then
            numStr = "<color=#c9cbc3>%s</color>"
        end
        local Dotfirst
        local DotOther

        DotOther = not IsGet
        AttarList = {
            bg = LuaMgr.GetSprite("HeroRes", bgStr == "" and "ui_zz_di02" or bgStr),
            num = string.format(numStr, HeroManager.GetNumStr(index)),
            content = content,
            content2 = content2,
            Line1add1 = Line1add1,
            Line1add1have = Line1Add1Have,
            Line1add2have = Line1Add2Have,
            Line2add2have = Line2Add2Have,
            zzsameName = sameName,
            zzshow2Message = show2Message,
            showNum1 = showNumone,
            showNum2 = showNumtwo,
            outline = outline,
            isShow = not isAni,
            isLight = false,
            isLevelUp = false,
            isNotGetItem = not IsGet,
            notSkillshow = notshowSkill,
            isGetItem = IsGet,
            firstDot = false,
            LineParent = DotOther,
            Name = tostring(index),
            addTage = string.format("<color=%s>%s</color>", IsGet and "#1d7572" or "#d2d2d2", "+"),
            numBgs = LuaMgr.GetSprite("HeroRes", IsGet and "ui_zz_szk1" or "ui_zz_szk2")
        }

        table.insert(tempList, AttarList)
    end
    this.vm.data.zzDatas = tempList
    if (isAni and #this.vm.data.zzDatas > 0) then
        zzIndex = 1
        LuaMgr.AddTimer(TimerConst.DelayClose, this.OnZZItemDelay, 0.1, -1, true)
    else
    end



    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.coroutine_key = coroutine_runner.start(function()

        coroutine_runner.wait(1)
        if this ~= nil then
            this.OnZZItemLink()
        end
    end)
end

this.OnZZItemDelay = function()
    if (zzIndex < #this.vm.data.zzDatas + 1) then
        this.vm.data.zzDatas[zzIndex].isShow = true
        zzIndex = zzIndex + 1
    end
    if (zzIndex >= #this.vm.data.zzDatas + 1) then
        LuaMgr.RemoveTimer(TimerConst.DelayClose)

    end

end


this.AttarClickRefush = function()
end
this.OnZZItemLink = function()

    if zzListTransform == nil or zzListTransform.childCount < 6 then
        return
    end
    if TableIsNull(this.vm.data.zzDatas) or #this.vm.data.zzDatas < 6 then
        return
    end
    for index, value in ipairs(this.vm.data.zzDatas) do
        local hyper =        zzListTransform:Find(tostring(index) .. "/Group/ConstantGroup/Desc1"):GetComponent("HyperlinkText")
        if hyper ~= nil then
            hyper.onHrefClick:RemoveListener(this.OnClickLink)
            hyper.onHrefClick:AddListener(this.OnClickLink)
        end
    end




end

this.OnClickLink = function(info)
    local character=nil;
    if isAssisHero then
        character=PlayerAssistMgr.GetCurAssist_CharacterData();
    else
        character = DataMgr.Player.characters[characterId]
    end
    if (character == nil) then
        return
    end
    local skilexp = NumTool.split(info, "e")
    local normalid = nil
    local specialId = nil
    local specialdata = nil
    local normalData = nil
    local skilLevel = 0
    local isNormal = false
    if #skilexp == 1 then
        normalid = info
        isNormal = true
    else
        normalid = skilexp[1]
        specialId = info
        isNormal = false
    end
    for _, value in pairs(character.skills) do
        if (value.groupId == normalid .. "ex") then
            specialdata = value
        end
        if value.groupId == normalid then
            normalData = value
        end
    end
    if (specialdata == nil and not isNormal) or (specialdata ~= nil and specialdata.locking) or (normalData ~= nil and normalData.locking) then
        skilLevel = normalData ~= nil and normalData.level or specialdata ~= nil and specialdata.level or 1
        LuaMgr.ShowPanel("Laigu.ViewModel.Common.SkillTipsViewModel", 0, characterId, info, nil, 1, true, skilLevel, false, true,isAssisHero)
    else
        LuaMgr.ShowPanel("Laigu.ViewModel.Common.SkillTipsViewModel", 0, characterId, info, nil, 1, false, skilLevel,false,false,isAssisHero);
    end
end


this.GetAttrDes = function(attr)
    local attarlist = { Name = "", AttrDisplayType = "" }
    local attrDes = ConfigMgr.Config.attrDesMap[attr];
    if (attrDes ~= nil) then
        attarlist.Name = attrDes.NameLan;
        attarlist.AttrDisplayType = attrDes.attrDisplayType;
    end
    return attarlist
end
return vm(
{
    data = data,
    command = command,
    hook = hook
}
)