require("ViewModel/Hero/HeroUpLevelAttributeItem")
require("ViewModel/Hero/HeroUpLevelSelectItem")

local this = {}
local objs = {
    animator = { path = "root", type = "UIAnimator" },
    levelMin = { path = "root/Right/Level/LevelMin", type = "Text" },
    levelMinGO = { path = "root/Right/Level/LevelMin", type = "GameObject" },
    levelMax = { path = "root/Right/Level/LevelMin/LevelMax", type = "Text" },
    maxLevelGO = { path = "root/Right/Level/MaxLevel", type = "GameObject" },
    expBar2 = { path = "root/Right/Level/ExpBar/Bar2", type = "Image" },
    expBar1 = { path = "root/Right/Level/ExpBar/Bar1", type = "Image" },
    expBarEffect = { path = "root/Right/Level/ExpBar/Effect", type = "GameObject" },
    levelExp = { path = "root/Right/Level/LevelExp", type = "Text" },
    fullExp = { path = "root/Right/Level/FullExp", type = "Text" },
    maxExpGO = { path = "root/Right/Level/MaxExp", type = "GameObject" },
    addValue = { path = "root/Right/Level/AddValue", type = "Text" },
    selectCount = { path = "root/Right/Items/Select/Text", type = "Text" },
    money = { path = "root/Right/Items/Money/Text", type = "Text" },
    moneyIcon = { path = "root/Right/Items/Money/Text/Icon", type = "RawImage" },
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
    levelUpGO = { path = "root/Right/Items/LevelUpBtn", type = "GameObject" },
    levelUpBtn = { path = "root/Right/Items/LevelUpBtn", type = "Button" },
    fastGO = { path = "root/Right/Items/FastBtn", type = "GameObject" },
    fastBtn = { path = "root/Right/Items/FastBtn", type = "Button" },
    maxLevelBtnGO = { path = "root/Right/Items/MaxLevelBtn", type = "GameObject" },
    maxLevelBtn = { path = "root/Right/Items/MaxLevelBtn", type = "Button" },
    breachGO = { path = "root/Right/Items/BreachBtn", type = "GameObject" },
    breachBtn = { path = "root/Right/Items/BreachBtn", type = "Button" },
    maskGO = { path = "root/Right/Mask", type = "GameObject" },
    maskBtn = { path = "root/Right/Mask", type = "Button" },
    clearBtn = { path = "root/Right/Items/ClearBtn", type = "Button" },
    outExpGO = { path = "root/Right/Level/OutExp", type = "GameObject" },
    outExpText = { path = "root/Right/Level/OutExp/Text", type = "Text" },
}
local msgTransform = nil
local characterMsg = nil
local isAttributeName = true

local selectItemContentTr = nil
local selectDic = {}

local heroDragPage = nil
local dragPageTr = nil

local addNumber = nil
local normalV3 = Vector2(-124, 0)
local specialV3 = Vector2(-35, 0)

local leftRect = nil
local rightRect = nil
local leftPosition = nil
local rightPosition = nil
local leftCanvasGroup = nil
local rightCanvasGroup = nil

local attributeItem;
local attributeList;
local currentLevel = 0;
local selectItem;
local selectItemList;
local itemDatas;

local ItemIcon3 = "Assets/_BundleResources/Images/ItemIcons/itemicon_home_3.png"
local ITEM_ICON_FOLDER_PATH = "Assets/_BundleResources/Images/ItemIcons/"
local FullExpStr = LuaMgr.GetLangText("HeroUpLevelViewModel_5")

require("ViewModel/Hero/HeroDragPage")
require("ViewModel/Hero/HeroExpBar")

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        msgTransform = vm.behaviour.transform:Find("root/Left/Group/Msg")
        dragPageTr = vm.behaviour.transform:Find("root/Middle/DragPage")
        leftRect = vm.behaviour.transform:Find("root/Left"):GetComponent("RectTransform")
        rightRect = vm.behaviour.transform:Find("root/Right"):GetComponent("RectTransform")
        leftCanvasGroup = leftRect.transform:GetComponent("CanvasGroup")
        rightCanvasGroup = rightRect.transform:GetComponent("CanvasGroup")
        if characterMsg ~= nil then
            characterMsg:Clear()
        end
        UITool.Parse(vm.behaviour, this, objs);
        attributeItem = vm.behaviour.transform:Find("template/HeroAttributeItem").gameObject;
        attributeList = UIListView.New(vm.behaviour.transform:Find("root/Right/Attribute/List"));
        selectItem = vm.behaviour.transform:Find("template/HeroSelectItem").gameObject;
        selectItemContentTr = vm.behaviour.transform:Find("root/Right/Items/List")
        selectItemList = UIListView.New(selectItemContentTr);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end


        HeroParameter.CheckCharacterListIsNull()
        isAttributeName = true
        this.SetInfo()
        this.SetDragPage()
        this.SetItems()
        SetActive(this.expBarEffect, false);
        this.animator.AnimationName = "ani_ui_herouplevelpanel"
        LuaMgr.AddUIEventListener(UIEventConst.HeroManagerDragEnd, this.OnEndDrag);
        LuaMgr.AddClick(this.clearBtn, this.OnClickClear);
        LuaMgr.AddClick(this.levelUpBtn, this.OnClickLevelUp);
        LuaMgr.AddClick(this.fastBtn, this.OnClickFast);
        LuaMgr.AddClick(this.breachBtn, this.OnClickBreach);
        LuaMgr.AddClick(this.qzIconBtn, this.OnClickZY);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        selectDic = {}
        this.RemoveBodys()
        HeroExpBar.Clear()
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeroManagerDragEnd, this.OnEndDrag)
        if characterMsg ~= nil then
            characterMsg:Clear()
        end
        attributeList:Clear();
        currentLevel = 0;
        selectItemList:Clear();
        this.moneyIcon.texture = nil;
        this.qzIcon.sprite = nil;
        LuaMgr.RemoveClick(this.clearBtn, this.OnClickClear);
        LuaMgr.RemoveClick(this.levelUpBtn, this.OnClickLevelUp);
        LuaMgr.RemoveClick(this.fastBtn, this.OnClickFast);
        LuaMgr.RemoveClick(this.breachBtn, this.OnClickBreach);
        LuaMgr.RemoveClick(this.qzIconBtn, this.OnClickZY);
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
    end,
    before_destroy = function(vm)
        UIListView.ClearItem("HeroUpLevelAttributeItem");
        UIListView.ClearItem("HeroUpLevelSelectItem");
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
    this.InitExpBar()
    this.SetLevelExp(true)
    this.SetButtonStatus()
    this.SetTags(LuaMgr.GetLangText(characterConfig.CharacterTagLan))
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


this.SetItems = function()
    selectItemList:Clear();
    selectDic = {}
    local list = ConfigItemMgr.GetItemsByType(ItemType.CharacterExp)
    if list ~= nil then
        itemDatas = {};
        for i = 1, #list do
            local itemData = list[i]
            local item = {
                id = itemData.id,
                itemName = LuaMgr.GetLangText(itemData.nameLan),
                itemRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. itemData.rare),
                itemIcon = LuaMgr.GetTexture(ITEM_ICON_FOLDER_PATH .. "itemicon_" .. itemData.id .. ".png"),
                selectCount = "0",
                isSelect = false,
                isLight = false
            }
            local serverItem = PlayerItemMgr.GetItemById(itemData.id)
            local count = serverItem ~= nil and serverItem.count0 or 0
            item.count = count
            item.itemCount = string.format("<color=#b7b09f>%s </color>%s", LuaMgr.GetLangText("HeroSelectItem_0"), count)
            item.alpha = count > 0 and 1.0 or 0.5
            item.index = i;
            item.OnClickItem = this.OnClickItem;
            item.OnClickSubtract = this.OnClickSubtract;
            local listData = UIListData.GetData(selectItem, "HeroUpLevelSelectItem", item);
            table.insert(itemDatas, listData);
        end
        selectItemList:SetData(itemDatas);
    end
    this.SetAddNumberComponent()
    this.SetSelectCount()
end

this.SetAddNumberComponent = function()
    for i = 1, #itemDatas do
        addNumber = selectItemContentTr:GetChild(i - 1):GetComponent("UIAddNumber")
        addNumber.Data = i
        addNumber.MaxNum = itemDatas[i].data.count
        addNumber.Callback = this.OnAddNumber
    end
end

this.OnAddNumber = function(data, delta, current)
    local index = tonumber(data)
    local num=tonumber(delta)
    
    if index<=0 or delta <=0 then return end
    
    local item = itemDatas[index]
    if item == nil then return end

    for i = 1, num do
        if this.AddOneItem(index, true) == -1 then
            break
        end
    end
    this.SetLevelExp()
    this.SetSelectCount()
    selectItemList:Refresh();
end

this.LevelUpResponse = function(result)
    local resultData = json.decode(result).result
    SetActive(this.maskGO, true);
    HeroExpBar.SetExp(this.GetAddExp(), resultData.character.level)
    selectDic = {}
    this.UpdateItems()
    this.SetButtonStatus()
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Level_up_1.mp3")
end

this.AddOneItem = function(index, isCheckCoin)
    if this.IsMaxLevel() then
        return -1
    end
    local itemData = itemDatas[index]
    if itemData ~= nil then
        local itemId = itemData.data.id
        local serverItem = PlayerItemMgr.GetItemById(itemId)
        if serverItem ~= nil and serverItem.count0 > 0 then
            if isCheckCoin and not this.CheckCoin(itemId) then
                return -1
            end
            local count = selectDic[itemId] == nil and 0 or selectDic[itemId]
            count = count + 1 <= serverItem.count0 and count + 1 or serverItem.count0
            selectDic[itemId] = count
            if count > 0 then
                itemData.data.isLight = true
                itemData.data.selectCount = tostring(count)
                itemData.data.isSelect = true
            end
            return serverItem.count0 > count and 1 or 0
        else
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,itemId,true,true,true)
        end
        itemData.data.isLight = false
        itemData.data.selectCount = "0"
        itemData.data.isSelect = false
    end
    return 0
end

this.CheckCoin = function(itemId)
    local addExp = this.GetAddExp()
    local config = ConfigItemMgr.GetItemById(itemId)
    if config ~= nil then
        addExp = addExp + config.drop
    end
    local characterConfig = ConfigCharacterMgr.GetInfo(HeroParameter.characterId)
    local needCoin = addExp * ConfigCharacterMgr.GetLevelUpCoinByRare(characterConfig.rare) / 100
    local coin = PlayerItemMgr.GetItemCountById("3")
    return coin >= needCoin
end

this.FastSelect = function() 
    this.OnClickClear(nil)
    local isOk, needExpItemList, isItemEnough = PlayerCharacterMgr.GetFastLevelUpItem(PlayerCharacterMgr.GetCharacter(HeroParameter.characterId), true)
    for i = 1, #itemDatas do
        local itemData = itemDatas[i]
        local itemId = itemData.data.id
        if needExpItemList[itemId] ~= nil and needExpItemList[itemId] > 0 then
            selectDic[itemId] = needExpItemList[itemId]
            itemData.data.isLight = true
            itemData.data.selectCount = tostring(needExpItemList[itemId])
            itemData.data.isSelect = true
        else
            itemData.data.isLight = false
            itemData.data.selectCount = "0"
            itemData.data.isSelect = false
        end
    end
    
    this.SetLevelExp()
    selectItemList:Refresh();
    this.SetSelectCount()
    
    if not isOk and not isItemEnough then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroUpLevelViewModel_1"))
        return
    end
    if not isOk and isItemEnough then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroUpLevelViewModel_2"))
    end
end

this.UpdateItems = function()
    for i = 1, #itemDatas do
        local itemData = itemDatas[i]
        local serverItem = PlayerItemMgr.GetItemById(itemData.data.id)
        local count = serverItem ~= nil and serverItem.count0 or 0
        itemData.data.itemCount = string.format("<color=#b7b09f>%s </color>%s", LuaMgr.GetLangText("HeroSelectItem_0"), count)
        itemData.data.alpha = count > 0 and 1.0 or 0.5
        itemData.data.selectCount = "0"
        itemData.data.isSelect = false
        itemData.data.isLight = false
    end
    selectItemList:Refresh();
    this.SetSelectCount()
end

this.SetSelectCount = function() 
    local count = 0
    for _, item in pairs(selectDic) do
        count = count + item
    end
    this.selectCount.text = tostring(count)
end

this.OnClickHero = function()
end

this.EndDragCB = function()
    this.SetInfo()
    this.OnClickClear();
    SetActive(this.msgGO, false);
end

this.RemoveBodys = function()
    if heroDragPage ~= nil then
        heroDragPage:Clear()
    end
end


this.InitExpBar = function()  
    SetActive(this.maskGO, false);
    local character = PlayerCharacterMgr.GetCharacter(HeroParameter.characterId)
    if character == nil then
        return
    end
    local exp = this.GetLevelExp(character.level)
    local nextExp = this.GetNextLevelExp(character.level)
    HeroExpBar.Init(character.level, character.limitedLevel, character.exp - exp, nextExp, 2, this.OnExp, this.OnGetExp, this.OnFinish)
    this.outExpText.text = ConfigMgr.LangGlobal("2000");
end

this.OnExp = function(level, exp, maxExp, limitLevel, isUpLevel)
    this.levelMin.text = tostring(level)
    SetActive(this.outExpGO, false);
    if level >= limitLevel then
        this.levelExp.text = ""
        if exp > 0 then
            this.fullExp.text = string.format(FullExpStr, tostring(exp))
            SetActive(this.outExpGO, this.IsExpOutLevel(exp, limitLevel));
        else
            this.fullExp.text = ""
        end
        this.expBar1.fillAmount = 1.0
        this.expBar2.fillAmount = 0.0
        SetActive(this.maxExpGO, true);
        if level >= ConfigMgr.Config.constants.maxCharacterLevel then
            SetActive(this.maxLevelGO, true);
            SetActive(this.levelMinGO, false);
        else
            SetActive(this.maxLevelGO, false);
            SetActive(this.levelMinGO, true);
        end
    else
        this.levelExp.text = string.format("<color=#e4e0cc>%s</color><color=#b7b09f>/%s</color>", exp, maxExp)
        this.fullExp.text = ""
        if isUpLevel then
            this.expBar1.fillAmount = 0.0
        else
            local nowExp = exp - this.GetLevelExp(level)
            this.expBar1.fillAmount = nowExp / maxExp
        end
        this.expBar2.fillAmount = exp / maxExp
        SetActive(this.maxExpGO, false);
        SetActive(this.maxLevelGO, false);
        SetActive(this.levelMinGO, true);
    end
end

this.OnGetExp = function(level, exp) 
    local nextExp = this.GetNextLevelExp(level)
    this.levelExp.text = string.format("<color=#e4e0cc>%s</color><color=#b7b09f>/%s</color>", exp, nextExp)
    return nextExp
end

this.OnFinish = function(isUpLevel)
    if isUpLevel then
        SetActive(this.expBarEffect, true);
        SetActive(this.msgGO, true);
        characterMsg = LuaMgr.LoadCharacterMsgViewModel(characterMsg, msgTransform, HeroParameter.characterId, CharacterMsgType.UpLevel)
        LuaMgr.ShowLuaPanel(UIName.HeroUpLevelSuccessfulViewModel)
    end
    this.InitExpBar()
    this.SetLevelExp(true)
end


this.IsExpOutLevel = function(exp, level)
    local nextLv = level < ConfigMgr.Config.constants.maxCharacterLevel and level + 1 or level;
    local characterLevelUp = ConfigMgr.Config.characterLevelUp;
    local nextExp = characterLevelUp[tostring(nextLv)] - characterLevelUp[tostring(level)];
    return exp >= nextExp;
end


this.SetLevelExp = function(isForce)
    local addExp = this.GetAddExp()
    local characterConfig = ConfigCharacterMgr.GetInfo(HeroParameter.characterId)
    local character = PlayerCharacterMgr.GetCharacter(HeroParameter.characterId)
    if character == nil then
        return
    end
    local lv, oExp, nExp = this.CalcUpLevel(character.level, character.limitedLevel, character.exp, addExp)
    local nextExp = this.GetNextLevelExp(lv)
    local isUpLevel = lv > character.level
    this.levelMax.text = "/" .. tostring(character.limitedLevel)
    if addExp > 0 then
        this.addValue.text = "+" .. addExp
    else
        this.addValue.text = ""
    end
    local needCoin = math.ceil(addExp * ConfigCharacterMgr.GetLevelUpCoinByRare(characterConfig.rare) / 100)
    local coin = PlayerItemMgr.GetItemCountById("3")
    this.money.text = string.format("<color=%s>%s</color>", coin < needCoin and "#c31f36" or "#ffffff", needCoin)
    this.moneyIcon.texture = LuaMgr.GetTexture(ItemIcon3)
    this.levelMin.text = tostring(lv)
    SetActive(this.outExpGO, false);
    if lv >= character.limitedLevel then
        this.levelExp.text = ""
        if nExp > 0 then
            this.fullExp.text = string.format(FullExpStr, tostring(nExp))
            SetActive(this.outExpGO, this.IsExpOutLevel(nExp, character.limitedLevel));
        else
            this.fullExp.text = ""
        end
        this.expBar1.fillAmount = 1.0 
        this.expBar2.fillAmount = 0.0
        SetActive(this.maxExpGO, true);
        if lv >= ConfigMgr.Config.constants.maxCharacterLevel then
            SetActive(this.maxLevelGO, true);
            SetActive(this.levelMinGO, false);
        else
            SetActive(this.maxLevelGO, false);
            SetActive(this.levelMinGO, true);
        end
    else
        this.levelExp.text = string.format("<color=#e4e0cc>%s</color><color=#b7b09f>/%s</color>", nExp, nextExp)
        this.fullExp.text = ""
        if isUpLevel then
            this.expBar1.fillAmount = 0.0
        else
            local nowExp = character.exp - this.GetLevelExp(character.level)
            this.expBar1.fillAmount = nowExp / nextExp
        end
        this.expBar2.fillAmount = nExp / nextExp
        SetActive(this.maxExpGO, false);
        SetActive(this.maxLevelGO, false);
        SetActive(this.levelMinGO, true);
    end
    this.SetAttribute(lv, isUpLevel, isForce)
end

this.GetAddExp = function() 
    local exp = 0
    for k, item in pairs(selectDic) do
        local config = ConfigItemMgr.GetItemById(k)
        if config ~= nil then
            exp = exp + config.drop * item
        end
    end
    return exp
end

this.GetLevelExp = function(level)
    local characterLevelUp = ConfigMgr.Config.characterLevelUp
    return characterLevelUp[tostring(level)]
end

this.GetNextLevelExp = function(level)
    local characterLevelUp = ConfigMgr.Config.characterLevelUp
    local nextLv = level < ConfigMgr.Config.constants.maxCharacterLevel and level + 1 or level
    return characterLevelUp[tostring(nextLv)] - characterLevelUp[tostring(level)]
end

this.CalcUpLevel = function(level, limitLevel, oExp, addExp)
    local characterLevelUp = ConfigMgr.Config.characterLevelUp
    local cExp = characterLevelUp[tostring(level)]
    oExp = oExp - cExp
    local nExp = oExp
    if addExp > 0 then
        nExp = nExp + addExp
        local lv = level
        while nExp > 0 do
            lv = lv + 1
            if lv > limitLevel then
                break
            end
            local nextExp = characterLevelUp[tostring(lv)] - cExp
            if nExp < nextExp then
                break
            end
            
            nExp = nExp - nextExp
            level = lv
            cExp = characterLevelUp[tostring(level)]
        end
    end
    return level, oExp, nExp
end

this.IsMaxLevel = function() 
    local addExp = this.GetAddExp()
    local character = PlayerCharacterMgr.GetCharacter(HeroParameter.characterId)
    if character == nil then
        return
    end
    local lv, oExp, nExp = this.CalcUpLevel(character.level, character.limitedLevel, character.exp, addExp)
    return lv >= character.limitedLevel
end


this.SetAttribute = function(level, isUpLevel, isForce)
    if (currentLevel == level and not isForce) then return end
    
    currentLevel = level;
    local character =  PlayerCharacterMgr.GetCharacter(HeroParameter.characterId)
    if character == nil then
        return
    end
    local attrs = HeroMgr.GetMainAttrList()
    local attrTab = LuaMgr.GetCharacterPropertyCopy(character.id,"",this.GetHeroAttrKey(attrs), character.level)
    local nextAttrTab = LuaMgr.GetCharacterPropertyCopy(character.id,"",this.GetHeroAttrKey(attrs), level)
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
            attIcon = LuaMgr.GetSprite("AttributeIcon",attrId),
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

this.GetHeroAttrKey = function(data)
    local attrKey = {}
    for i = 1, #data do
        table.insert(attrKey,data[i].id)
    end
    return attrKey
end


this.SetButtonStatus = function() 
    local character = PlayerCharacterMgr.GetCharacter(HeroParameter.characterId)
    if character == nil then
        return
    end
    if character.level >= ConfigMgr.Config.constants.maxCharacterLevel then
        SetActive(this.levelUpGO, false);
        SetActive(this.fastGO, false);
        SetActive(this.maxLevelBtnGO, true);
        SetActive(this.maxLevelGO, true);
        SetActive(this.levelMinGO, false);
        SetActive(this.breachGO, false);
    else
        if character.level >= character.limitedLevel then
            SetActive(this.levelUpGO, false);
            SetActive(this.fastGO, false);
            SetActive(this.maxLevelBtnGO, false);
            SetActive(this.breachGO, true);
        else
            SetActive(this.levelUpGO, true);
            SetActive(this.fastGO, true);
            SetActive(this.maxLevelBtnGO, false);
            SetActive(this.breachGO, false);
        end
        SetActive(this.maxLevelGO, false);
        SetActive(this.levelMinGO, true);
    end
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

this.OnClickLevelUp = function()
    if this.GetAddExp() <= 0 then
        local tip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2005"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tip)
        return
    end
    
    local paramData = {
        characterId = HeroParameter.characterId,
        cost = selectDic
    }
    ApiMgr.Request("level_up", paramData, true, this.LevelUpResponse, nil, true)
end

this.OnClickFast = function()
    this.FastSelect()
end

this.OnClickItem = function(param)
    if this.IsMaxLevel() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroUpLevelViewModel_0"))
        return
    end
    local index = tonumber(param)
    this.AddOneItem(index, false)
    selectItemList:Refresh();
    this.SetLevelExp()
    this.SetSelectCount()
end

this.OnClickClear = function()
    selectDic = {}
    for i = 1, #itemDatas do
        local itemData = itemDatas[i]
        itemData.data.selectCount = "0"
        itemData.data.isSelect = false
        itemData.data.isLight = false
    end
    selectItemList:Refresh();
    this.InitExpBar()
    this.SetLevelExp()
    this.SetSelectCount()
end

this.OnClickZY = function()
    LuaMgr.ShowLuaPanel("HeroOccupationViewModel")
end

this.OnClickBreach = function()
    if FeatureManager.IsLock("1006") then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1006"))
        return
    end
    LuaMgr.ShowLuaPanel(UIName.HeroTalentViewModel, HeroParameter.characterId)
end

this.OnClickMask = function()
    this.OnFinish()
end

this.OnClickSubtract = function(param)
    local index = tonumber(param)
    local itemData = itemDatas[index]
    if itemData ~= nil then
        local itemId = itemData.data.id
        local count = selectDic[itemId]
        if count ~= nil then
            if count > 0 then
                count = count - 1
                selectDic[itemId] = count
                itemData.data.selectCount = tostring(count)
                itemData.data.isSelect = count ~= 0
                itemData.data.isLight = count ~= 0
                this.SetLevelExp()
                this.SetSelectCount()
                if addNumber ~= nil then
                    addNumber:Reset()
                end
            else
                itemData.data.selectCount = "0"
                itemData.data.isSelect = false
                itemData.data.isLight = false
            end
        end
        selectItemList:Refresh();
    end
end


return vm({
    data = data,
    command = command,
    hook = hook,
})