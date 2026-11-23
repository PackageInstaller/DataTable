local this = {};

local data = {
    levelGoodslistData = {{}},
    khGoodslistData = {{}},
}
local goLevelContent = nil
local goKHContent = nil
local characterData = nil

local command = {
    CancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickCancel(param)
        end
    },
    
    ConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickConfirm(param)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.Init(vm.behaviour)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        local characterId = this.vm.behaviour.Params[0];
        characterData = PlayerCharacterMgr.GetCharacter(characterId)
        this.SetData();
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function()
    end
}

this.Init = function(prefab)
    local uiLink = prefab.gameObject:GetComponent("UILink");
    goLevelContent = uiLink:Get("goLevelContent");
    goKHContent = uiLink:Get("goKHContent");

end

this.SetData = function()
    this.SetLevelReturnItems();
    this.SetKHReutrnItems();
end

this.SetLevelReturnItems = function()
    local datalist = {}
    

    local characterConfig = ConfigCharacterMgr.GetInfo(characterData.id)
    local coinCount = math.floor(characterData.exp * ConfigCharacterMgr.GetLevelUpCoinByRare(characterConfig.rare) / 100)
    local rewardItem=ConfigHelper.CreateGoodsItem("3", coinCount, 0.6, true, true)
    table.insert(datalist,rewardItem);


    local totalExp = characterData.exp
    local expItemList = ConfigItemMgr.GetItemsByType(ItemType.CharacterExp)
    for i = #expItemList, 1, -1 do
        local count = math.floor(totalExp / expItemList[i].drop)
        if count > 0 then
            totalExp = totalExp - expItemList[i].drop * count
            local rewardItem=ConfigHelper.CreateGoodsItem(expItemList[i].id, count, 0.6, true, true)
            table.insert(datalist,rewardItem);
        end
    end
    
    this.vm.data.levelGoodslistData=datalist;
end

this.SetKHReutrnItems = function()
    if characterData.talents == nil then
        return
    end
    
    local datalist = {}
    local dataMap = {}
    
    for k, v in pairs(characterData.talents) do
        if v.status == 2 then
            local tempConfig = ConfigMgr.Config.characterTalentMap[k]
            
            if not IsNull(tempConfig.requireCoin) then
                for i = 1, #tempConfig.requireCoin, 1 do
                    local tempItem = tempConfig.requireCoin[i]
                    if dataMap[tempItem.id] == nil then
                        dataMap[tempItem.id] = tempItem.count
                    else
                        dataMap[tempItem.id] = dataMap[tempItem.id] + tempItem.count
                    end
                end
            end

            if not IsNull(tempConfig.requireItems) then
                for i = 1, #tempConfig.requireItems, 1 do
                    local tempItem = tempConfig.requireItems[i]
                    if dataMap[tempItem.id] == nil then
                        dataMap[tempItem.id] = tempItem.count
                    else
                        dataMap[tempItem.id] = dataMap[tempItem.id] + tempItem.count
                    end
                end
            end
        end
    end

    for k, v in pairs(dataMap) do
        local rewardItem=ConfigHelper.CreateGoodsItem(k, v, 0.6, true, true)
        table.insert(datalist,rewardItem);
    end

    this.vm.data.khGoodslistData=datalist;
end

this.OnClickCancel = function()
    LuaMgr.HidePanel(UIName.HeroResetViewModel)
end

this.OnClickConfirm = function()
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, ConfigMgr.LangGlobal("7150"), this.OnConfirm, nil);
end

this.OnConfirm = function()
    ApiMgr.Request("reset_character",{characterId = characterData.id},true,function(result)
        LuaMgr.HidePanel(UIName.HeroResetViewModel)
        local re=json.decode(result);
        local rewared = json.encode(re.result.deltaRewards)
        LuaMgr.ShowItemRewared(rewared);
        LuaMgr.InvokeUIEventListeners(UIEventConst.HeroManagerUpdateInfo)
    end,nil,true)
end

return vm({
    data = data,
    command = command,
    hook = hook
})