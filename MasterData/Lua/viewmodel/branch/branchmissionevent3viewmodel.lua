



local this = { vm = nil }
local equipIconPath = "Assets/_BundleResources/Images/ItemIcons/itemicon_"
local bookId
local Parents = nil
local BrantEventVPropGrandSon
local BattleData = {}
local EquipmetDropTip
local BattleFuntion
local data = {
    NovelBattleEventPos = Vector3.zero,
    showTipMeesage = "",
    EventParentPos = Vector3(230.4, -22.62, 0),
    EquipMentitemNor=Vector2.one;
    EquipMentitemList = {
        {
            itemId = "",
            count = "",
            name = "",
            object = false,
            equipRare = DefaultSprite,
            equipIcon = DefaultTexture,
            already = false,
            isCount = false,
            speciaIcons = false,
            sceal = Vector3.zero,
            textBgs = false
        }
    },
    bookitemList = {
        {
            itemId = "",
            count = "",
            object = false,
            equipRare = DefaultSprite,
            equipIcon = DefaultTexture,
            already = false,
            isCount = false,
            speciaIcons = false,
            sceal = Vector3.zero,
            textBgs = false,
        }
    },

}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.BranchMissionEvent3ViewModel)
        end
    },
    ClickBattleBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if BattleFuntion ~= nil then

                BattleFuntion(BattleData.param)
            end
        end
    },
    clickGoodsItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local goodsId = this.vm.data.bookitemList[param + 1].itemId
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, goodsId, false, false,
            false)
        end
    },
    clickEquipmentItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local goodsId = this.vm.data.EquipMentitemList[param + 1].itemId
            LuaMgr.ShowPanel(UIName.WeaponTipsViewModel, goodsId);
        end
    },

}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        BrantEventVPropGrandSon = vm.behaviour.transform:Find("root/GrandSonPanelOne/GrandSonPanelOne")
        EquipmetDropTip = vm.behaviour.transform:Find("root/GrandSonPanelOne/GrandSonPanelOne/EquipmentDropPanel")
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            Parents = vm.behaviour.Params[0]
            bookId = vm.behaviour.Params[1]
            BattleFuntion = vm.behaviour.Params[2]
            EquipmetDropTip:SetParent(Parents, false)
            this.InitEquipmentDropShow()
            LuaMgr.AddUIEventListener(1001, this.OnShowPanel)
            this.vm.data.showTipMeesage = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2107"].NameLan)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            EquipmetDropTip:SetParent(BrantEventVPropGrandSon, false)
            LuaMgr.RemoveUIEventListener(1001, this.OnShowPanel)
        end

    end
}


this.OnShowPanel = function(arge)
    if arge[0] == UIName.BattlePrepareViewModel then
        LuaMgr.RemoveUIEventListener(1001, this.OnShowPanel)
        LuaMgr.HidePanel(UIName.BranchMissionEvent3ViewModel)
    end
end


this.InitEquipmentDropShow = function()
    local RewardDataValue = {}

    for cfgkey, cfgvalue in pairs(ConfigMgr.Config.branchStoryList) do
        if bookId == cfgvalue.ID then
            RewardDataValue = cfgvalue.dropShow
        end
    end
    for index, value in ipairs(ConfigMgr.Config.branchEventList) do
        if bookId == value.storyID then
            BattleData = value
        end
    end

local testEquipment = RewardDataValue[1]
local testReward = RewardDataValue[2]
    this.ItemViewData(testReward, true, 0.44)
    this.ItemViewData(testEquipment, false, 0.64, true)
end

this.ItemViewData = function(tabs, iscount, scale, specialEquip)
    specialEquip = specialEquip ~= nil and specialEquip or false
    local tempList = {}
    if specialEquip then
        local WorldItem = {
            itemId = 0,
            object = false,
            equipRare = DefaultSprite,
            already = true,
            equipIcon = DefaultTexture,
            rare = "",
            isCount = false,
            name = "",
            count = "",
            speciaIcons = specialEquip,
            sceal = Vector3(scale, scale, scale),
            textBgs = true
        }
        table.insert(tempList, WorldItem)
    end

    for key, value in ipairs(tabs) do
        local items = {
        }
        items = {
            itemId = value,
            object = true,
            equipRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. ConfigHelper.GetItemById(value).rare),
            name = LuaMgr.GetLangText(ConfigHelper.GetItemById(value).nameLan),
            already = true,
            equipIcon = LuaMgr.GetTexture(equipIconPath .. value .. ".png"),
            rare = ConfigHelper.GetItemById(value).rare,
            isCount = false,
            count = "",
            speciaIcons = specialEquip,
            sceal = Vector3(scale, scale, scale),
            textBgs = false,
        }
        table.insert(tempList, items)
    end
    table.sort(tempList,
    function(a, b)
        if a.rare ~= "" and b.rare ~= "" then
            return a.rare > b.rare end
    end)
    if iscount then
        if #tempList < 1 then
            return
        end
        if #tempList < 4 then
            local length = 4 - #tempList
            for i = 1, length, 1 do
                local blankData = table.Copy(tempList[1])
                blankData.object = false
                table.insert(tempList, blankData)
            end
        end
        this.vm.data.bookitemList = tempList
    else
        if specialEquip then
            this.vm.data.EquipMentitemList = tempList
            this.vm.data.EquipMentitemNor=Vector2.one;
        end
    end
end

return vm(
{
    data = data,
    command = command,
    hook = hook
}
)