require("RhythmGame/ViewModel/RhythmGameItemEffectEquip")
require("RhythmGame/ViewModel/RhythmGameItemEffectItem")

local this = {
    equipItemList = nil,
    itemList = nil
};

local objs = {

    equipBtn = { path = "root/Panel/Right/BtnEquip", type = "Button" },
    equipImgBtn = { path = "root/Panel/Right/BtnEquip/Equip", type = "GameObject" },
    equipImgBtnGray = { path = "root/Panel/Right/BtnEquip/EquipGray", type = "GameObject" },

    exitBtn = { path = "root/Panel/Right/BtnClose", type = "Button" },

    unequipBtn = { path = "root/Panel/Right/BtnUnequip", type = "Button" },
    unequipImgBtn = { path = "root/Panel/Right/BtnUnequip/Unequip", type = "GameObject" },
    unequipImgBtnGray = { path = "root/Panel/Right/BtnUnequip/UnequipGray", type = "GameObject" },

    equipItem1 = { path = "root/Panel/Left/EquipItems/EquipItem1", type = "GameObject" },
    equipItem2 = { path = "root/Panel/Left/EquipItems/EquipItem2", type = "GameObject" },
    equipItem3 = { path = "root/Panel/Left/EquipItems/EquipItem3", type = "GameObject" },

    itemsTF = { path = "root/Panel/Right/Items/Viewport/Content", type = "Transform" },
    item = { path = "template/Item", type = "GameObject" },

    itemInfo = { path = "root/Panel/Left/ItemInfo", type = "GameObject" },
    itemName = { path = "root/Panel/Left/ItemInfo/Name", type = "Text" },
    itemIcon = { path = "root/Panel/Left/ItemInfo/Icon", type = "RawImage" },
    itemDescription = { path = "root/Panel/Left/ItemInfo/Info", type = "Text" },
    unlockTip = { path = "root/Panel/Left/ItemInfo/LockBG/UnlockTip", type = "Text" },
    unlock = { path = "root/Panel/Left/ItemInfo/LockBG/Unlock", type = "Text" },
    ImgUnlock = { path = "root/Panel/Left/ItemInfo/LockBG/Unlock/ImgUnlock", type = "GameObject" },
    ImgLock = { path = "root/Panel/Left/ItemInfo/LockBG/Unlock/ImgLock", type = "GameObject" },
};



this.SetData = function()
    
    SetActive(this.itemInfo, false)
    this.equipItemList = {}
    for i = 1, 3, 1 do 
        local equip = RhythmGameItemEffectEquip.New(this["equipItem" .. i])
        equip:Init()
        table.insert(this.equipItemList, equip)
    end

    this.SetEquipItems()
    this.SetItems()
    this.SetEquipStatus()
    PlayerRhythmGameMgr.SetItemEffectItem(this.defaultSelect)
    this.ShowItemInfo()
    PlayerRhythmGameMgr.CheckEffectNewDot()
    RedMgr.Singleton:Refresh()
end

this.SetEquipItems = function()
    for i, v in ipairs(this.equipItemList) do
        v:Clear()
    end
    local equips = DataMgr.Player.musicEquips.Equip;

    local musicEquips = {}
    for k, v in pairs(equips) do
        local item = RhythmGameMgr.GetMusicEquip(tonumber(k))
        table.insert(musicEquips, item)
    end

    table.sort(musicEquips, function(a, b)
        return a.id < b.id
    end)

    for k, v in ipairs(musicEquips) do
        this.equipItemList[k]:SetData(v)
    end

    if 3 - #musicEquips > 0 then
        for i = #musicEquips + 1, 3, 1 do
            this.equipItemList[i]:SetData({id=-1})
        end
    end
end

this.SetItems = function()
    this.itemList:Clear();
    this.defaultSelect = nil
    local listData;
    local listDatas = {};

    local equips = DataMgr.Player.musicEquips.Equip;
    local unlocks = DataMgr.Player.musicEquips.Unlock;
    local musicEquips = ConfigMgr.Config.MusicEquips
   
    local equipItems = {}
    local unlockEquips = {}
    local musicConfigs = {}
    for k, v in pairs(musicEquips) do
        if equips[tostring(v.id)] then
            table.insert(equipItems, v)
        elseif unlocks[tostring(v.id)] then
            table.insert(unlockEquips, v)
        else 
            table.insert(musicConfigs, v)
        end
    end

    table.sort(equipItems, function(a, b)
        return a.id < b.id
    end)

    table.sort(unlockEquips, function(a, b)
        return a.id < b.id
    end)

    table.sort(musicConfigs, function(a, b)
        return a.id < b.id
    end)

    for i, v in ipairs(unlockEquips) do
        table.insert(equipItems, v)
    end

    for i, v in ipairs(musicConfigs) do
        table.insert(equipItems, v)
    end

    for k, v in ipairs(equipItems) do
        listData = UIListData.GetData(this.item, "RhythmGameItemEffectItem", v);
        table.insert(listDatas, listData);
    end
    this.defaultSelect = equipItems[1]
    this.itemList:SetData(listDatas);
end


this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.RhythmGameItemEffectSelectViewModel);
end

this.OnClickEquip = function()
    local itemEffect = PlayerRhythmGameMgr.GetItemEffectItem()
    if not itemEffect then
        return
    end

    if DataMgr.Player.musicEquips.Equip[tostring(itemEffect.id)] then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10759"));
        return
    end

    if not DataMgr.Player.musicEquips.Unlock[tostring(itemEffect.id)] then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10756"));
        return
    end
    
    if(this.numEquip >= 3)then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("2254"));
        return 
    end

    PlayerRhythmGameMgr.EquipItemEffect(itemEffect.id, 0, function(re)
        DataMgr.Player.musicEquips = re.data.musicEquips
        this.SetEquipItems()
        this.itemList:Refresh()

        this.SetEquipStatus()

        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameItemEffectChange);
    end)
end

this.OnClickUnEquip = function()
    local itemEffect = PlayerRhythmGameMgr.GetItemEffectItem()
    if not itemEffect then
        return
    end

    if not DataMgr.Player.musicEquips.Equip[tostring(itemEffect.id)] then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10760"));
        return
    end

    if not DataMgr.Player.musicEquips.Unlock[tostring(itemEffect.id)] then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10756"));
        return
    end

    PlayerRhythmGameMgr.EquipItemEffect(itemEffect.id, 1, function(re)
        DataMgr.Player.musicEquips = re.data.musicEquips
        this.SetEquipItems()
        this.itemList:Refresh()

        this.SetEquipStatus()

        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameItemEffectChange);
    end)
end

this.OnItemEffectEquip = function(args) 
    local data = args[0];
    if data.id == -1 then
        return
    end
    
    PlayerRhythmGameMgr.SetItemEffectItem(data)

    this.ShowItemInfo()

    this.SetItems()

    this.SetEquipStatus()
end

this.OnItemEffectItem = function(args)
    local data = args[0];
    PlayerRhythmGameMgr.SetItemEffectItem(data)
    this.itemList:Refresh();

    this.ShowItemInfo()

    this.SetEquipStatus()    
end

this.ShowItemInfo = function()
    local item = PlayerRhythmGameMgr.GetItemEffectItem()
    SetActive(this.itemInfo, item)
    if not item then
        return
    end

    this.itemName.text = LuaMgr.GetLangText(item.nameLan)
    this.itemDescription.text = LuaMgr.GetLangText(item.textLan)
    this.itemIcon.texture = GetRhythmEquipTexture(item.icon)

    if #item.unlock > 0 then        
        local msg = ConfigRhythmGameMgr.GetMusicUnlockTips(item.unlock)
        if msg then 
            this.unlockTip.text = msg
        end
    else
        this.unlockTip.text = ""
    end

    SetActive(this.ImgUnlock, false)
    SetActive(this.ImgLock, false)
    if not DataMgr.Player.musicEquips.Unlock[tostring(item.id)] then
        SetActive(this.ImgLock, true)
        this.unlock.text = LuaMgr.GetLangText("RhythmGameItemEffectSelectViewModel_0")
    else
        this.unlock.text = LuaMgr.GetLangText("RhythmGameItemEffectSelectViewModel_1")
        SetActive(this.ImgUnlock, true)
    end
end

this.SetEquipStatus = function()
    SetActive(this.equipImgBtn, false)
    SetActive(this.equipImgBtnGray, false)
    SetActive(this.unequipImgBtn, false)
    SetActive(this.unequipImgBtnGray, false)

    local itemEffect = PlayerRhythmGameMgr.GetItemEffectItem()
    if not itemEffect then
        SetActive(this.unequipImgBtnGray, true)
        SetActive(this.equipImgBtnGray, true)
        return
    end

    if DataMgr.Player.musicEquips.Equip[tostring(itemEffect.id)] then
        SetActive(this.equipImgBtnGray, true)
        SetActive(this.unequipImgBtn, true)
        return
    end

    if DataMgr.Player.musicEquips.Equip ~= nil then
        this.numEquip = 0       
        for k, v in pairs(DataMgr.Player.musicEquips.Equip) do
            this.numEquip = this.numEquip +1
        end
        if(this.numEquip >= 3)then
            SetActive(this.equipImgBtnGray, true)            
            SetActive(this.unequipImgBtn, true)          
        end 
    end

    if not DataMgr.Player.musicEquips.Unlock[tostring(itemEffect.id)] then
        SetActive(this.unequipImgBtnGray, true)
        SetActive(this.equipImgBtnGray, true)
        return
    else
        SetActive(this.unequipImgBtnGray, true)
        SetActive(this.equipImgBtn, true)
    end  
end


local command = {}
local data = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.exitBtn, this.OnClickBack);
        LuaMgr.AddClick(this.equipBtn, this.OnClickEquip);
        LuaMgr.AddClick(this.unequipBtn, this.OnClickUnEquip);
        RedMgr.Singleton:RegisterViewModel(UIName.RhythmGameItemEffectSelectViewModel);
        this.itemList = UIListView.New(this.itemsTF);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetData();

        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameItemEffectEquip, this.OnItemEffectEquip);
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameItemEffectItem, this.OnItemEffectItem);
    end,
    before_deactive = function(vm)
        if this.itemList then 
            this.itemList:Clear();
        end
        PlayerRhythmGameMgr.SetItemEffectItem(nil)

        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameItemEffectEquip, this.OnItemEffectEquip);
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameItemEffectItem, this.OnItemEffectItem);
    end,
    before_destroy = function(vm)
        RedMgr.Singleton:RemoveViewModel(UIName.RhythmGameItemEffectSelectViewModel);
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack);
        PlayerRhythmGameMgr.SetItemEffectItem(nil)
        UIListView.ClearItem("RhythmGameItemEffectItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})