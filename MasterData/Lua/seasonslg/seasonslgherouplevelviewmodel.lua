require("ViewModel/Hero/HeroUpLevelAttributeItem")

local this = {}
local objs = {
    tag1GO = { path = "root/Left/Group/QZ/Tags/Tag1/Tag", type = "GameObject" },
    tag1Text = { path = "root/Left/Group/QZ/Tags/Tag1/Tag/Text", type = "Text" },
    tag2GO = { path = "root/Left/Group/QZ/Tags/Tag2/Tag", type = "GameObject" },
    tag2Text = { path = "root/Left/Group/QZ/Tags/Tag2/Tag/Text", type = "Text" },
    tag3GO = { path = "root/Left/Group/QZ/Tags/Tag3/Tag", type = "GameObject" },
    tag3Text = { path = "root/Left/Group/QZ/Tags/Tag3/Tag/Text", type = "Text" },
    tag4GO = { path = "root/Left/Group/QZ/Tags/Tag4/Tag", type = "GameObject" },
    tag4Text = { path = "root/Left/Group/QZ/Tags/Tag4/Tag/Text", type = "Text" },
    qzName = { path = "root/Left/Group/QZ/Name/Name", type = "Text" },
    fullName = { path = "root/Left/Group/QZ/FullName/FullName", type = "Text" },
    qzIcon = { path = "root/Left/Group/QZ/QZIcon", type = "Image" },
    qzIconBtn = { path = "root/Left/Group/QZ/QZIcon", type = "Button" },
    LimitIcon_1001 = { path = "root/Left/Group/QZ/LimitIcons/1001", type = "GameObject" },
    msgGO = { path = "root/Left/Group/Msg", type = "GameObject" },
    maskGO = { path = "root/Right/Mask", type = "GameObject" },
    skillObj = { path = "root/Right/Skill", type = "GameObject" },
    skillIcon = { path = "root/Right/Skill/Image/skillIcon", type = "Image" },
    skillName = { path = "root/Right/Skill/skillName", type = "Text" },
    skillDesc = { path = "root/Right/Skill/skillDesc", type = "Text" },
    levelUpBtn = { path = "root/Right/Cost/LevelUpBtn", type = "Button" },
    levelUpObj = { path = "root/Right/Cost", type = "GameObject" },

    autoLevelUpBtn = { path = "root/Right/Auto/AutoLevelUpBtn", type = "Button" },
    autoLevelUpObj = { path = "root/Right/Auto", type = "GameObject" },

    maxLevelTipObj = { path = "root/Right/MaxLevelTip", type = "GameObject" },
    maxLevelTip = { path = "root/Right/MaxLevelTip/MaxText", type = "Text" },

    btnAttribute = { path = "root/Right/BtnAttribute", type = "Button" },
}

local isAttributeName = true
local heroDragPage = nil
local dragPageTr = nil
local normalV3 = Vector2(-83, 0)
local specialV3 = Vector2(-23.6, 0)
local leftRect = nil
local rightRect = nil
local leftCanvasGroup = nil
local rightCanvasGroup = nil
local attributeItem = nil
local attributeList = nil
local seasonLevelImg1 = nil
local seasonLevelImg2 = nil
local seasonLevelMax = nil

require("ViewModel/Hero/HeroDragPage")

local data =
{
    costList = {{icon = DefaultTexture,cost = ""}}
}
local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        dragPageTr = vm.behaviour.transform:Find("root/Middle/DragPage")
        leftRect = vm.behaviour.transform:Find("root/Left"):GetComponent("RectTransform")
        rightRect = vm.behaviour.transform:Find("root/Right"):GetComponent("RectTransform")
        leftCanvasGroup = leftRect.transform:GetComponent("CanvasGroup")
        rightCanvasGroup = rightRect.transform:GetComponent("CanvasGroup")
        UITool.Parse(vm.behaviour, this, objs);
        attributeItem = vm.behaviour.transform:Find("template/HeroAttributeItem").gameObject;
        attributeList = UIListView.New(vm.behaviour.transform:Find("root/Right/Attribute/List"));
        seasonLevelImg1 = vm.behaviour.transform:Find("root/Right/Level/levelspt1"):GetComponent("Image");
        seasonLevelImg2 = vm.behaviour.transform:Find("root/Right/Level/levelspt2"):GetComponent("Image");
        seasonLevelMax = vm.behaviour.transform:Find("root/Right/Level/level"):GetComponent("Text");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroParameter.CheckCharacterListIsNull()
        isAttributeName = true
        this.SetInfo()
        this.SetDragPage()
        SetActive(this.maskGO, false);
        LuaMgr.AddClick(this.qzIconBtn, this.OnClickZY);
        LuaMgr.AddClick(this.levelUpBtn, this.OnClickLevelUp);

        LuaMgr.AddClick(this.autoLevelUpBtn, this.OnClickAutoLevelUp);
        LuaMgr.AddClick(this.btnAttribute,this.OnBtnAttribute)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.RemoveBodys()
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
        attributeList:Clear();
        this.qzIcon.sprite = nil;
        LuaMgr.RemoveClick(this.qzIconBtn, this.OnClickZY);
        LuaMgr.RemoveClick(this.levelUpBtn, this.OnClickLevelUp);

        LuaMgr.RemoveClick(this.autoLevelUpBtn, this.OnClickAutoLevelUp);
        LuaMgr.RemoveClick(this.btnAttribute,this.OnBtnAttribute)
    end,
    before_destroy = function(vm)
        UIListView.ClearItem("HeroUpLevelAttributeItem");
    end
}


this.SetInfo = function()
    local characterConfig = ConfigCharacterMgr.GetInfo(HeroParameter.characterId)
    this.qzName.text = LuaMgr.GetLangText(characterConfig.namelan)
    this.fullName.text = LuaMgr.GetLangText(characterConfig.FullnameLan)
    this.qzIcon.sprite = HeroMgr.GetHeroJobRareIcon(characterConfig)
    if IsNullOrEmpty(characterConfig.Linkage) then
        SetActive(this.LimitIcon_1001, false)
    else
        SetActive(this.LimitIcon_1001, characterConfig.Linkage == "1001")
    end

    local character = PlayerCharacterMgr.GetCharacter(HeroParameter.characterId)
    if character ~= nil then
        this.SetAttribute()
    end
    this.SetTags(LuaMgr.GetLangText(characterConfig.CharacterTagLan))
    local seasonLevel = ConfigCharacterMgr.GetSeasonalHeroLevel(character.id)

    this.SetSkill(HeroParameter.characterId)
    local maxLevel = ConfigMgr.Config.SeasonalConstants.SeasonalHeroLevelMax
    seasonLevelMax.text = "/" .. tostring(maxLevel)


    SetActive(this.maxLevelTipObj,false)
    if seasonLevel >= maxLevel then
        SetActive(this.levelUpObj,false)
        SetActive(this.autoLevelUpObj,false)
        SetActive(this.maxLevelTipObj,true)
    else
        SetActive(this.levelUpObj,true)
        SetActive(this.autoLevelUpObj,true)
        this.SetUpLevelCost(HeroParameter.characterId,seasonLevel + 1)
    end

    this.SetSeasonLevel(seasonLevel)
end

this.SetSeasonLevel = function(seasonLevel)
    if seasonLevel > 9 then
        SetActive(seasonLevelImg1.gameObject,true)
        local first =  math.floor(seasonLevel / 10);
        seasonLevelImg1.sprite = LuaMgr.GetSprite("SeasonSLGHeroLevelAtlas","sjz-zlfy-qzjm-sjqh-sz" .. tostring(first))
    else
        SetActive(seasonLevelImg1.gameObject,false)
    end
    local second = seasonLevel % 10
    seasonLevelImg2.sprite = LuaMgr.GetSprite("SeasonSLGHeroLevelAtlas","sjz-zlfy-qzjm-sjqh-sz" .. tostring(second))
end

this.OnClickAutoLevelUp = function()
    local character = PlayerCharacterMgr.GetCharacter(HeroParameter.characterId)
    if character == nil then
        return
    end
    local seasonLevel = ConfigCharacterMgr.GetSeasonalHeroLevel(character.id)
    local maxLevel = ConfigMgr.Config.SeasonalConstants.SeasonalHeroLevelMax
    if seasonLevel >= maxLevel then
        return
    end

    if this.CheckConsume(HeroParameter.characterId, seasonLevel + 1) then
        local data = {}
        data.clickCallbacks = {[ConfirmCommonPanel.BtnType.Confirm]=function()
            local id = ConfigCharacterMgr.GetSeasonalHeroConfig(HeroParameter.characterId).Id
            ApiMgr.Request("seasonal/character/levelup", {SeasonalCharacterId = id, Batch=true}, true, this.LevelUpResponse, nil, true,false)
        end}
        data.btnTextStrs = {}
        data.contentStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34171")

        data.btnTextStrs[ConfirmCommonPanel.BtnType.Confirm] = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34172")
        data.btnTextStrs[ConfirmCommonPanel.BtnType.Cancel] = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34173")
        LuaMgr.ShowLuaPanel(UIName.ConfirmCommonPanel, ConfirmCommonPanel.MsgBoxType.TextButton, data)
    else
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGHeroUpLevelViewModel_0"))
    end
end

this.OnClickLevelUp = function()
    local seasonLevel = ConfigCharacterMgr.GetSeasonalHeroLevel(HeroParameter.characterId)
    local maxLevel = ConfigMgr.Config.SeasonalConstants.SeasonalHeroLevelMax
    if seasonLevel >= maxLevel then
        return
    end

    if this.CheckConsume(HeroParameter.characterId, seasonLevel + 1) then
        local id = ConfigCharacterMgr.GetSeasonalHeroConfig(HeroParameter.characterId).Id
        ApiMgr.Request("seasonal/character/levelup", {SeasonalCharacterId = id, Batch=false}, true, this.LevelUpResponse, nil, true,false)
    else
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGHeroUpLevelViewModel_0"))
    end

end

this.LevelUpResponse = function(result)
    local resultData = json.decode(result).result

    this.SetInfo()
    this.PlayAttributeEffect()

end


this.PlayAttributeEffect = function()
    if attributeList == nil then
        return
    end
    for _, item in ipairs(attributeList.itemList or {}) do
        if item ~= nil and item.PlayEffect ~= nil then
            item:PlayEffect()
        end
    end
end



this.SetDragPage = function()
    if heroDragPage == nil then
        heroDragPage = HeroDragPage.New(dragPageTr)
    end
    local dragData = {
        rectSize = 1500,
        dragDist = 200,
        onClick = this.OnClickHero,
        onEnd = this.EndDragCB,
        ani = true,
        leftRect = leftRect,
        rightRect = rightRect,
        leftCanvasGroup = leftCanvasGroup,
        rightCanvasGroup = rightCanvasGroup,
        canDrag = false
    }
    heroDragPage:SetData(dragData)
    LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
end

this.OnClickHero = function()
end

this.EndDragCB = function()
    this.SetInfo()
    SetActive(this.msgGO, false);
end

this.RemoveBodys = function()
    if heroDragPage ~= nil then
        heroDragPage:Clear()
    end
end

this.SetSkill = function(heroId)
    SetActive(this.skillObj,false)


















end

this.SetUpLevelCost = function(heroId,seasonLevel)
    local tempList = {}
    local config = ConfigCharacterMgr.GetSeasonalHeroLevelConfig(heroId,seasonLevel)
    if config ~= nil then
        for i = 1, #config.Consume do
            local itemTexture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png", config.Consume[i].id))
            local count = DataHelper.GetItemCountById(config.Consume[i].id)
            local itemCount = LuaMgr.NumFormat(count);
            local nCount = LuaMgr.NumFormat(config.Consume[i].count);
            local itemData =
            {
                icon = itemTexture,
                cost = string.format("<color=%s>%s</color>/%s", config.Consume[i].count > count and "#c31f36" or "#E7E1AD", itemCount,nCount)

            }
            table.insert(tempList,itemData)
        end
    else
        SetActive(this.levelUpObj,false)
        SetActive(this.autoLevelUpObj,false)
    end
    this.vm.data.costList = tempList
end

this.CheckConsume = function(heroId,seasonLevel)
    local config = ConfigCharacterMgr.GetSeasonalHeroLevelConfig(heroId,seasonLevel)
    for i = 1, #config.Consume do
        local count = DataHelper.GetItemCountById(config.Consume[i].id)
        if config.Consume[i].count > count then
            return false
        end
    end
    return true
end


this.SetAttribute = function()
    local character = PlayerCharacterMgr.GetCharacter(HeroParameter.characterId)
    if character == nil then
        return
    end
    local attrs = HeroMgr.GetMainAttrList()
    local seasonLevel = ConfigCharacterMgr.GetSeasonalHeroLevel(character.id);
    local curLevelConfig = ConfigCharacterMgr.GetSeasonalHeroLevelConfig(character.id,seasonLevel)
    local nextLevel = seasonLevel + 1
    if nextLevel > ConfigMgr.Config.SeasonalConstants.SeasonalHeroLevelMax then
        nextLevel = seasonLevel
    end
    local nextLevelConfig = ConfigCharacterMgr.GetSeasonalHeroLevelConfig(character.id,nextLevel)
    local curAddTalents=curLevelConfig and  table.CopyNoMeta(curLevelConfig.TalentBankID) or {};
    local nextAddTalents=nextLevelConfig and table.CopyNoMeta(nextLevelConfig.TalentBankID) or {};
    local addSpecialTalent=SeasonSLGTechMgr.GetSpecialHeroTalent(HeroParameter.characterId)
    if #addSpecialTalent>0 then
        for i,v in ipairs(addSpecialTalent) do
            table.insert(curAddTalents,v);
            table.insert(nextAddTalents,v);
        end
    end
    local attrTab = LuaMgr.GetCharacterPropertyCopy(character.id, "", this.GetHeroAttrKey(attrs), character.level,0,#curAddTalents>0 and curAddTalents or nil,nil)
    local nextAttrTab = LuaMgr.GetCharacterPropertyCopy(character.id, "", this.GetHeroAttrKey(attrs), character.level,0,#nextAddTalents>0 and nextAddTalents or nil,nil)
    attrTab = json.decode(attrTab)
    nextAttrTab = json.decode(nextAttrTab)
    attributeList:Clear();
    local listDatas = {};
    local len = #attrs;
    for i = 1, len do
        local attrId = NumTool.split(attrs[i].id, '_')[1]
        local attrValue = attrTab[attrId] ~= nil and attrTab[attrId] or 0
        attrValue = tostring(LuaMgr.GetShowAttrValue(attrs[i].PanelScopeControl, attrId, attrValue))
        local nextAttrValue = nextAttrTab[attrId] ~= nil and nextAttrTab[attrId] or 0
        nextAttrValue = tostring(LuaMgr.GetShowAttrValue(attrs[i].PanelScopeControl, attrId, nextAttrValue))
        local itemData = {
            attIcon = LuaMgr.GetSprite("AttributeIcon", attrId),
            attName = LuaMgr.GetLangText(attrs[i].NameLan),
            isName = isAttributeName,
            isArrow = attrValue ~= nextAttrValue,
            value1 = attrValue,
            valuePosition = attrValue ~= nextAttrValue and normalV3 or specialV3,
            value2 = string.format("<color=%s>%s</color>", attrValue ~= nextAttrValue and "#32D9CF" or "#FFFFFF", nextAttrValue)
        }
        local listData = UIListData.GetData(attributeItem, "HeroUpLevelAttributeItem", itemData);
        table.insert(listDatas, listData);
    end
    attributeList:SetData(listDatas);
end

this.SetOriAttribute = function()
    local character = PlayerCharacterMgr.GetCharacter(HeroParameter.characterId)
    if character == nil then
        return
    end
    local attrs = HeroMgr.GetMainAttrList()
    local seasonLevel = 0;
    local curLevelConfig = ConfigCharacterMgr.GetSeasonalHeroLevelConfig(character.id,seasonLevel)
    local nextLevel = seasonLevel + 1
    if nextLevel > ConfigMgr.Config.SeasonalConstants.SeasonalHeroLevelMax then
        nextLevel = seasonLevel
    end
    local nextLevelConfig = ConfigCharacterMgr.GetSeasonalHeroLevelConfig(character.id,nextLevel)
    local curAddTalents=curLevelConfig and table.CopyNoMeta(curLevelConfig.TalentBankID) or {};
    local nextAddTalents=nextLevelConfig and table.CopyNoMeta(nextLevelConfig.TalentBankID) or {};
    local addSpecialTalent=SeasonSLGTechMgr.GetSpecialHeroTalent(HeroParameter.characterId)
    if #addSpecialTalent>0 then
        for i,v in ipairs(addSpecialTalent) do
            table.insert(curAddTalents,v);
            table.insert(nextAddTalents,v);
        end
    end
    local attrTab = LuaMgr.GetCharacterPropertyCopy(character.id, "", this.GetHeroAttrKey(attrs), character.level,0,#curAddTalents>0 and curAddTalents or nil,nil)
    local nextAttrTab = LuaMgr.GetCharacterPropertyCopy(character.id, "", this.GetHeroAttrKey(attrs), character.level,0,#nextAddTalents>0 and nextAddTalents or nil,nil)
    attrTab = json.decode(attrTab)
    nextAttrTab = json.decode(nextAttrTab)
    attributeList:Clear();
    local listDatas = {};
    local len = #attrs;
    for i = 1, len do
        local attrId = NumTool.split(attrs[i].id, '_')[1]
        local attrValue = attrTab[attrId] ~= nil and attrTab[attrId] or 0
        attrValue = tostring(LuaMgr.GetShowAttrValue(attrs[i].PanelScopeControl, attrId, attrValue))
        local nextAttrValue = nextAttrTab[attrId] ~= nil and nextAttrTab[attrId] or 0
        nextAttrValue = tostring(LuaMgr.GetShowAttrValue(attrs[i].PanelScopeControl, attrId, nextAttrValue))
        local itemData = {
            attIcon = LuaMgr.GetSprite("AttributeIcon", attrId),
            attName = LuaMgr.GetLangText(attrs[i].NameLan),
            isName = isAttributeName,
            isArrow = false,
            value1 = attrValue,
            valuePosition = specialV3,
            value2 = string.format("<color=%s>%s</color>", attrValue ~= nextAttrValue and "#32D9CF" or "#FFFFFF", nextAttrValue)
        }
        local listData = UIListData.GetData(attributeItem, "HeroUpLevelAttributeItem", itemData);
        table.insert(listDatas, listData);
    end
    attributeList:SetData(listDatas);
end

this.AddSpecialHeroTalent=function(talents)

end

this.GetHeroAttrKey = function(data)
    local attrKey = {}
    for i = 1, #data do
        table.insert(attrKey, data[i].id)
    end
    return attrKey
end


this.SetTags = function(tag)
    local tags = NumTool.split(tag, ';')
    local len = #tags
    for i = 1, 4 do
        local str = i <= len and tags[i] or ""
        if i == 1 then
            SetActive(this.tag1GO, not IsNullOrEmpty(str));
            this.tag1Text.text = str
        elseif i == 2 then
            SetActive(this.tag2GO, not IsNullOrEmpty(str));
            this.tag2Text.text = str
        elseif i == 3 then
            SetActive(this.tag3GO, not IsNullOrEmpty(str));
            this.tag3Text.text = str
        elseif i == 4 then
            SetActive(this.tag4GO, not IsNullOrEmpty(str));
            this.tag4Text.text = str
        end
    end
end

this.OnAnimatorPlayFinish = function(args)
    if args[0] == "ani_ui_herouplevelpanel" then
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
        heroDragPage:SetCanDrag(true)
    end
end

this.OnClickZY = function()
    LuaMgr.ShowLuaPanel("HeroOccupationViewModel")
end

this.ShowHeroManager = function(args)
    local tempList = {HeroParameter.characterId}
    HeroParameter.SaveListParam(nil,nil,nil,0,1,tempList)
    LuaMgr.ShowLuaPanel(UIName.SeasonSLGHeroManagerViewModel)
end

this.OnBtnAttribute = function()
    this.ShowHeroManager()
end

return vm({
    data = data,
    command = command,
    hook = hook,
})