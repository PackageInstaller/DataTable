




require("ViewModel/Home/BackpackItemGroup")
local this = {vm = nil,labelIndex = 1,ToString = tostring,ToNumber = tonumber,TableInsert = table.insert,
isSplitStatus = false,
rChooseStatus = false,
srChooseStatus = false,
ssrChooseStatus = false,
urChooseStatus = false,
needSplitEquip = {},
screenTotalWidth = 0,
labelType = 0,
              rootAnim = nil,contentAnim = nil,viewReset = true,
              scrollView = nil,itemGroup = nil,itemTemplate = nil,
              spaceX = 0,columnCount = 0,canSplitList = nil,isLock = false,
              ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_"}
local data = {
    splitBtn = false,
    splitStatus = false,
    rBtnChoose = false,
    srBtnChoose = false,
    ssrBtnChoose = false,
    urBtnChoose = false,
    
    gridCount = "",
    addBtn = Vector3.zero,
    labelView = Vector3.zero,
    notChoose = false,
    equipInfo = false,
    equipRare = DefaultSprite,
    equipIcon = DefaultTexture,
    equipName = "",
    equipBar = 0.0,
    equipBarText = "",
    skillName = "",
    skillLevel = "",
    skillIntro = "",
    chooseSplitCount = "",
    attrViewSize = Vector2.zero,
    isSiftBtn = false,
    isSiftState = false,
    isLockState = false,
    
    zText = "",bText = "",fText = "",jText = "",sText = "",xText = "",
    labelList = {{labelChoose = Vector3.zero,labelText = "",labelIcon = DefaultSprite,redId=""}},
    equipLabelList = {{equipLabel = ""}},
    attDesList = {{attIcon = DefaultSprite,attName = "",attValue = ""}}
}

local command = {

    labelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SwitchLabel(param + 1)
        end
    },

    splitCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OpenSplit()
        end
    },

    closeSplitCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.CloseSplit()
        end
    },

    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ConfirmSplitEquip()
        end
    },

    rareCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local rare = this.ToNumber(param)
            if rare == ConfigBackPackMgr.RareType.R then
                this.rChooseStatus = not this.rChooseStatus
                this.ChooseRareEqualEquip(rare,this.rChooseStatus)
                this.vm.data.rBtnChoose = this.rChooseStatus
            elseif rare == ConfigBackPackMgr.RareType.SR then
                this.srChooseStatus = not this.srChooseStatus
                this.ChooseRareEqualEquip(rare,this.srChooseStatus)
                this.vm.data.srBtnChoose = this.srChooseStatus
            elseif rare == ConfigBackPackMgr.RareType.SSR then
                this.ssrChooseStatus = not this.ssrChooseStatus
                this.ChooseRareEqualEquip(rare,this.ssrChooseStatus)
                this.vm.data.ssrBtnChoose = this.ssrChooseStatus
            elseif rare == ConfigBackPackMgr.RareType.UR then
                this.urChooseStatus = not this.urChooseStatus
                this.ChooseRareEqualEquip(rare,this.urChooseStatus)
                this.vm.data.urBtnChoose = this.urChooseStatus
            end
        end
    },

    gridAddCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.AddGridCount()
        end
    },

    siftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.EquipSiftPopup)
        end
    },

    lockCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.isLock = not this.isLock
            this.vm.data.isLockState = this.isLock
            this.InitItemView()
        end
    }
}
local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.rootAnim = vm.behaviour.transform:Find("root"):GetComponent("Animator")
        this.contentAnim = vm.behaviour.transform:Find("root/Middle/Content"):GetComponent("Animator")
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Content/ItemsView").gameObject)
        this.itemGroup = vm.behaviour.transform:Find("template/ItemGroup").gameObject
        this.itemTemplate = vm.behaviour.transform:Find("template/GoodsDataItem").gameObject
        RedMgr.Singleton:RegisterViewModel(UIName.BackpackViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetLanguage()
        this.AddUIEveneListener()
        vm.behaviour:UpdateTopBar("", this.OnBack)
        if FeatureManager.backPackLableIndex ~= nil then
            this.labelIndex = FeatureManager.backPackLableIndex
        end
        PlayerBackpackMgr.Init()
        this.isSplitStatus = false
        this.ScreenSize()
        this.isLock = false
        this.viewReset = true
        this.vm.data.isLockState = this.isLock
        this.InitLabelView()
        this.InitItemView()
        this.BackpackGridCount()
        this.rootAnim:Play("ani_ui_BackpackPanel_001",0,0)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEventListener()
        this.scrollView:Clear(false)
        PlayerBackpackMgr.Clear()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("BackpackItemGroup")
        this.vm.behaviour = nil;
        this.rootAnim =nil;
        this.contentAnim =nil;
        data = nil;
        command=nil;
        this = nil
    end,
}
this.SetLanguage = function()
    this.vm.data.zText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7034"].NameLan)
    this.vm.data.bText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7035"].NameLan)
    this.vm.data.fText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7036"].NameLan)
    this.vm.data.jText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7037"].NameLan)
    this.vm.data.sText = ConfigMgr.LangGlobal("16143")
    this.vm.data.xText = ConfigMgr.LangGlobal("16144")
end
this.AddUIEveneListener = function()
LuaMgr.AddUIEventListener(UIEventConst.WeaponLocking,this.EquipStatusEvent)
LuaMgr.AddUIEventListener(UIEventConst.EquipTipsSplit,this.EquipTipsSplitEvent)
LuaMgr.AddUIEventListener(UIEventConst.PropUse,this.UpdatePropUse)
LuaMgr.AddUIEventListener(UIEventConst.backpackSplitEvent,this.ChooseEquip)
LuaMgr.AddUIEventListener(UIEventConst.EquipSiftConfirmClick,this.UpdateEquipSift)
end

this.RemoveUIEventListener = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.WeaponLocking,this.EquipStatusEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.EquipTipsSplit,this.EquipTipsSplitEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.PropUse,this.UpdatePropUse)
    LuaMgr.RemoveUIEventListener(UIEventConst.backpackSplitEvent,this.ChooseEquip)
    LuaMgr.RemoveUIEventListener(UIEventConst.EquipSiftConfirmClick,this.UpdateEquipSift)
end

this.OnBack = function()
    HeroRedDataHelper.ClearBackPackGiftRed()
    this.labelIndex = 1
    FeatureManager.backPackLableIndex = this.labelIndex
    LuaMgr.Back()
end

this.ScreenSize = function()
    local width = LuaMgr.GetScreenAddWidth()
    this.screenTotalWidth = 900 + width
    this.columnCount = math.floor(this.screenTotalWidth / 135)
    this.spaceX = math.floor((this.screenTotalWidth - (this.columnCount * 128)) / this.columnCount)
end

this.InitLabelView = function()
    local tempList,tempLabel,typeKey,labelStr = {},nil,"",""
    for i = 1, #ConfigMgr.Config.constants.BackPackTab do
        typeKey = ConfigMgr.Config.constants.BackPackTab[i]
        if typeKey == "1001" then labelStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2350"].NameLan) end
        if typeKey == "1002" then labelStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2351"].NameLan) end
        if typeKey == "1003" then labelStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2352"].NameLan) end
        if typeKey == "1004" then labelStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2353"].NameLan) end
        if typeKey == "1005" then labelStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2354"].NameLan) end
        tempLabel = {labelChoose = Vector3.zero,labelText = labelStr,redId="1094_"..typeKey,
                     labelIcon = LuaMgr.GetSprite("Backpack","bb_label_"..typeKey),labelKey = typeKey}
        this.TableInsert(tempList,tempLabel)
    end
    this.vm.data.labelList = tempList
    this.vm.data.labelList[this.labelIndex].labelChoose = Vector3.one
    this.vm.data.labelView = Vector3.one
    this.vm.data.notChoose = false
    this.vm.data.equipInfo = false
    local isShow = this.vm.data.labelList[this.labelIndex].labelKey == "1004"
    this.vm.data.isSiftBtn = isShow
    this.vm.data.splitBtn = isShow
    this.vm.data.splitStatus = false
end

this.InitItemView = function()
    this.scrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local index = 1
    local tempList = nil
if this.vm.data.labelList[this.labelIndex].labelKey == "1004" then
        this.labelType = 2
        if this.isSplitStatus then
            this.HiddenEquip()
            tempList = this.GetEquipList(this.canSplitList)
        else
            tempList = this.GetEquipList(PlayerBackpackMgr.equipData)
        end
        local isShow = TableIsNull(PlayerBackpackMgr.rareOptions) and TableIsNull(PlayerBackpackMgr.seriesOptions) and TableIsNull(PlayerBackpackMgr.attrOptions)
        this.vm.data.isSiftState = not isShow and not this.isSplitStatus
else
        this.viewReset = true
        this.labelType = 1
        local key = this.vm.data.labelList[this.labelIndex].labelKey
        tempList = PlayerBackpackMgr.itemData[key]
        RedMgr.Singleton:Refresh()
        this.vm.data.isSiftState = false
    end

    local rowIndex = 0
    while (index <= #tempList) do
        groupData = {}
        groupData.object = this.itemTemplate
        groupData.spaceX = this.spaceX
        groupData.labelType = this.labelType
        groupData.isSplitStatus = this.isSplitStatus
        groupData.item = {}
        for i = 1, this.columnCount do
            if tempList[index + i - 1] ~= nil then
                this.TableInsert(groupData.item,tempList[index + i - 1])
                if tempList[index + i - 1].id == PlayerBackpackMgr.equipPositioningId then
                    rowIndex = math.ceil((index + i - 1) / this.columnCount)
                end
            end
        end
        scrollData = UIScrollData.GetData(this.itemGroup,"BackpackItemGroup",this.screenTotalWidth,128,groupData)
        this.TableInsert(scrollDatas,scrollData)
        index = index + this.columnCount
    end
    this.scrollView:SetParams(this.screenTotalWidth,580)
    if this.isSplitStatus then
        this.scrollView:SetPadding(0,0,-10,-90)
    else
        this.scrollView:SetPadding(0,0,-10,-10)
    end
    this.scrollView:SetData(scrollDatas,this.viewReset)
    this.viewReset = false
    if PlayerBackpackMgr.equipPositioningId ~= nil and this.labelType == 2 then
        this.EquipPositioning(rowIndex)
    end
    this.contentAnim:Play("ani_ui_BackpackPanel_item_001",0,0)
end

this.EquipPositioning = function(rowIndex)
    if rowIndex == nil then
        return
    end
    this.scrollView:MoveToIndex(rowIndex)
end


this.ChooseRareEqualEquip = function(rare,status)
local tagBool = true
    local tempItem = nil
    for i = 1, #this.canSplitList do
        tempItem = this.canSplitList[i]
        if tempItem.rare == rare then
            if status and not tempItem.choose then
                if #this.needSplitEquip < ConfigMgr.Config.constants.SplitMaxCount then
                    tempItem.choose = status
                    this.TableInsert(this.needSplitEquip,tempItem.id)
                    if tagBool then
                        tagBool = not tagBool
                        this.UpdateLeftEquipInfo(tempItem.id)
                    end
                else
                    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2041"].NameLan)
                    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
                    break
                end
            elseif not status and tempItem.choose then
                tempItem.choose = status
                local tabIndex = this.WhetherIsChoose(tempItem.id)
                if tabIndex ~= -1 then
                    table.remove(this.needSplitEquip,tabIndex)
                end
            end
        end
    end
    this.scrollView:Refresh()
    this.vm.data.chooseSplitCount = #this.needSplitEquip.."/".."<color=#AEAEAE><size=18>"..ConfigMgr.Config.constants.SplitMaxCount.."</size></color>"
end

this.ChooseEquip = function(args)
    if args.Length == 0 then return end
    local paramData = args[0]
    this.UpdateLeftEquipInfo(paramData.data.id)
    if not paramData.data.choose and not paramData.choose.activeSelf then
        if #this.needSplitEquip < ConfigMgr.Config.constants.SplitMaxCount then
            this.TableInsert(this.needSplitEquip,paramData.data.id)
        else
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2041"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        end
    else
        local tabIndex = this.WhetherIsChoose(paramData.data.id)
        if tabIndex ~= -1 then
            table.remove(this.needSplitEquip,tabIndex)
        end
    end
    SetActive(paramData.choose,not paramData.data.choose)
    paramData.data.choose = not paramData.data.choose
    this.vm.data.chooseSplitCount = #this.needSplitEquip.."/".."<color=#AEAEAE><size=18>"..ConfigMgr.Config.constants.SplitMaxCount.."</size></color>"
end

this.UpdateLeftEquipInfo = function(equipId)
    this.vm.data.notChoose = false
    local equipData = DataMgr.Player.equipments[equipId]
    local equipConfig = ConfigMgr.Config.equipments[equipData.equipmentId]
    this.vm.data.equipRare = LuaMgr.GetSprite("ItemRare","itemRare"..equipConfig.rare)
    this.vm.data.equipIcon = LuaMgr.GetTexture(this.ITEM_ICON_PATH..equipConfig.id..".png")
    this.vm.data.equipName = LuaMgr.GetLangText(equipConfig.NameLan)
    this.CreateTagItem(equipConfig)
local nowLevelAllExp
local nowLevelExp
local needLevelExp
    local maxLevel = ConfigHelper.GetTableLength(ConfigMgr.Config.equipmentLevelUp[this.ToString(equipConfig.rare)])
    if equipData.level < maxLevel then
        nowLevelAllExp = ConfigMgr.Config.equipmentLevelUp[this.ToString(equipConfig.rare)][this.ToString(equipData.level)]
        if maxLevel == equipData.level then
            needLevelExp = ConfigMgr.Config.equipmentLevelUp[this.ToString(equipConfig.rare)][this.ToString(equipData.level)] - nowLevelAllExp
        else
            needLevelExp = ConfigMgr.Config.equipmentLevelUp[this.ToString(equipConfig.rare)][this.ToString(equipData.level + 1)] - nowLevelAllExp
        end
        nowLevelExp = equipData.exp - nowLevelAllExp
        local expFloat = (nowLevelExp / needLevelExp) - ((nowLevelExp / needLevelExp) % 0.01)
        this.vm.data.equipBar = expFloat
        this.vm.data.equipBarText = math.floor(expFloat * 100).."%"
    else
        this.vm.data.equipBar = 1
        this.vm.data.equipBarText = "100%"
    end
    local attrCount
    if not equipData.additionalAttrs or #equipData.additionalAttrs == 0 then
        attrCount = 2
    else
        attrCount = 2 + #equipData.additionalAttrs
    end
    this.vm.data.attrViewSize = Vector2(246, (26 * attrCount) + (10 * (attrCount - 1)))
    this.CreateAttrItem(equipData)
    if #equipConfig.equipSkill > 0 then
        this.vm.data.skillLevel = "LV.".."<color=#F95304>"..equipData.star.."</color>"
        this.vm.data.skillName = LuaMgr.GetLangText(ConfigMgr.Config.equipmentSkills[equipConfig.equipSkill[1]]["1"].NameLan)
    end
    this.vm.data.skillIntro = LuaMgr.GetEquipSkillText(equipData.equipmentId,equipData.star)
    this.vm.data.equipInfo = true
end

this.CreateAttrItem = function(equipData)
    local dataJson = json.encode(equipData)
    dataJson = LuaMgr.GetEquipPropertyCopy(dataJson)
    local attrData = json.decode(dataJson)
    local attrList = {}
    this.TableInsert(attrList,{attIcon = LuaMgr.GetSprite("AttributeIcon","Atk"),attName = LuaMgr.GetLangText(ConfigHelper.GetAttrDes("Atk_FIX").NameLan),
                           attValue = this.ToString(attrData["Atk"]),attKey = "Atk"})
    this.TableInsert(attrList,{attIcon = LuaMgr.GetSprite("AttributeIcon","Hp"),attName = LuaMgr.GetLangText(ConfigHelper.GetAttrDes("Hp_FIX").NameLan),
                           attValue = this.ToString(attrData["Hp"]),attKey = "Hp"})
    attrData["Atk"] = nil
    attrData["Hp"] = nil
    local tempList = {}
    local attrDes
    for key,value in pairs(attrData) do
        attrDes = ConfigHelper.GetAttrDes(key)
        local tempAttr = {attIcon = LuaMgr.GetSprite("AttributeIcon",key),attName = LuaMgr.GetLangText(attrDes.NameLan),
                          attValue = this.ToString(value)..attrDes.attrDisplayType,attKey = key}
        this.TableInsert(tempList,tempAttr)
    end
    table.sort(tempList,this.AttrListSort)
    for i = 1, #tempList do
        this.TableInsert(attrList,tempList[i])
    end
    tempList = {}
    this.vm.data.attDesList = attrList
end

this.CreateTagItem = function(equipConfig)
    local tempList = {}
    local tagLan = LuaMgr.GetLangText(equipConfig.TagLan)
    local tagData = NumTool.split(tagLan,";")
    for i = 1, #tagData do
        local tempTag = {equipLabel = tagData[i]}
        this.TableInsert(tempList,tempTag)
    end
    this.vm.data.equipLabelList = tempList
end

this.AddGridCount = function()
    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2043"].NameLan)
    local goods = {}
    local item = {}
    item["ID"] = ConfigMgr.Config.constants.VolPrice.id;
    item["Count"] = ConfigMgr.Config.constants.VolPrice.count;
    this.TableInsert(goods,item)
    local itemList = json.encode(goods)
    LuaMgr.ShowConfirmConsumeViewModel(tipStr,itemList,this.SendAddGridCount,function()
        goods = {}
        item = {}
    end)
end


this.ConfirmSplitEquip = function()
    ConfigBackPackMgr.ConfirmSplitEquip(this.needSplitEquip, this.SendSplitEquip)
end


this.OpenSplit = function()
    this.isLock = false
    this.vm.data.isLockState = this.isLock
    this.scrollView.scrollRect:StopMovement()
    this.isSplitStatus = true
    this.vm.data.isSiftBtn = false
    this.needSplitEquip = {}
    this.rChooseStatus = false
    this.srChooseStatus = false
    this.ssrChooseStatus = false
    this.urChooseStatus = false
    this.vm.data.splitStatus = true
    this.vm.data.notChoose = true
    this.vm.data.labelView = Vector3.zero
    this.vm.data.equipInfo = false
    this.InitItemView()
    ConfigHelper.ExpGoodsDes()
    this.OpenFastChoose()
    this.rootAnim:Play("ani_ui_BackpackPanel_002",0,0)
end

this.CloseSplit = function()
    this.scrollView.scrollRect:StopMovement()
    this.isSplitStatus = false
    this.vm.data.isSiftBtn = true
    this.needSplitEquip = {}
    this.vm.data.splitStatus = false
    this.vm.data.notChoose = false
    this.vm.data.labelView = Vector3.one
    this.vm.data.equipInfo = false
    PlayerBackpackMgr.RestoreEquip()
    this.InitItemView()
end

this.HiddenEquip = function()
    this.canSplitList = {}
    local tempItem = nil
    for i = 1, #PlayerBackpackMgr.equipData do
        tempItem = PlayerBackpackMgr.equipData[i]
        if not tempItem.wearBool and not tempItem.locking then
            this.TableInsert(this.canSplitList,tempItem)
        end
    end
    tempItem = nil
    table.sort(this.canSplitList,PlayerBackpackMgr.EquipDataLitreSort)
end

this.UpdateEquipSift = function()
    if PlayerBackpackMgr.equipJob == CharacterJob.All and TableIsNull(PlayerBackpackMgr.rareOptions) and TableIsNull(PlayerBackpackMgr.seriesOptions) and TableIsNull(PlayerBackpackMgr.attrOptions) then
        PlayerBackpackMgr.equipData = {}
        PlayerBackpackMgr.UpdateEquip()
    else
        PlayerBackpackMgr.UpdateSiftEquip(true)
    end
    this.InitItemView()
end


this.OpenFastChoose = function()
    this.vm.data.rBtnChoose = this.rChooseStatus
    this.vm.data.srBtnChoose = this.srChooseStatus
    this.vm.data.ssrBtnChoose = this.ssrChooseStatus
    this.vm.data.urBtnChoose = this.urChooseStatus
end

this.SwitchLabel = function(index)
    this.vm.data.labelList[this.labelIndex].labelChoose = Vector3.zero
    this.labelIndex = index
    FeatureManager.backPackLableIndex = index
    this.vm.data.labelList[this.labelIndex].labelChoose = Vector3.one
    this.InitItemView()
    local isShow = this.vm.data.labelList[this.labelIndex].labelKey == "1004"
    this.vm.data.isSiftBtn = isShow
    this.vm.data.splitBtn = isShow
    this.vm.data.splitStatus = false
end

this.BackpackGridCount = function()
    local configCount = ConfigMgr.Config.constants.InitVol + DataMgr.Player.bagExtraCap
    this.vm.data.gridCount = PlayerBackpackMgr.GetTotalCount().."/".."<color=#AEAEAE><size=18>"..configCount.."</size></color>"
    this.vm.data.addBtn = configCount < ConfigMgr.Config.constants.MaxVol and Vector3.one or Vector3.zero
end

this.GetEquipList = function(param)
    local tempList = {}
    if TableIsNull(param) then
        return tempList
    end
    if this.isLock then
        for i = 1, #param do
            if param[i].locking then
                this.TableInsert(tempList,param[i])
            end
        end
    else
        tempList = param
    end
    return tempList
end

this.SendAddGridCount = function()
    ApiMgr.Request("expand_bag_cap",nil,true,function(result)
        this.BackpackGridCount()
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2044"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
    end,nil,true)
end

this.SendSplitEquip = function()
    ApiMgr.Request("decompose_equipment",this.needSplitEquip,true,function(result)
        local re = json.decode(result)
        local resultData = json.encode(re.result)
        LuaMgr.ShowItemRewared(resultData)
        PlayerBackpackMgr.Clear()
        PlayerBackpackMgr.Init()
        this.BackpackGridCount()
        this.OpenSplit()
    end,nil,true)
end

this.EquipStatusEvent = function(args)
    local len = args.Length
    if len == 0 then return end
    local id = args[0]
    for i = 1, #PlayerBackpackMgr.equipData do
        if PlayerBackpackMgr.equipData[i].id == id then
            PlayerBackpackMgr.equipData[i].locking = args[1]
            break
        end
    end
    for key,value in pairs(this.scrollView.itemMap) do
        for i = 1, #value.data.item do
            if value.data.item[i].id == id then
                SetActive(value.itemList[i].lockState,args[1])
                return
            end
        end
    end
end

this.EquipTipsSplitEvent = function(args)
    PlayerBackpackMgr.Clear()
    PlayerBackpackMgr.Init()
    this.BackpackGridCount()
    this.InitItemView()
end

this.UpdatePropUse = function(args)
    local len = args.Length
    if len == 0 then return end
    PlayerBackpackMgr.Clear()
    PlayerBackpackMgr.Init()
    this.BackpackGridCount()
    this.InitItemView()
end

this.WhetherIsChoose = function(equipId)
    for i = 1, #this.needSplitEquip do
        if this.needSplitEquip[i] == equipId then
            return i
        end
    end
    return -1
end

this.AttrListSort = function(item1,item2)

    return item1.attKey < item2.attKey
end

return vm({
    data = data,
    command = command,
    hook = hook
})