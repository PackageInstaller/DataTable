require("ViewModel/Draw/GiftCharacterCommonPopupItem")

local this = {
    vm = nil,
    data = {},
    rootRectTransform = nil,
    giftCharacterItem = nil,
    giftCharacterItemData = {},
}

local data = {
}

local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.rootRectTransform = vm.behaviour.transform:Find("root/Middle"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.giftCharacterItemData = {
            curCardPoolId = vm.behaviour.Params[0],


            redId = vm.behaviour.Params[2],
            tipsType = vm.behaviour.Params[3],
        }
        
        this.LoadGiftCharacterItem()
        this.RefreshGiftCharacterItem()
    end,
    before_deactive = function(vm)
        if this.giftCharacterItem ~= nil then
            this.giftCharacterItem:Clear()
            this.giftCharacterItem:Destroy()
        end
        LuaMgr.RemoveTimer(TimerConst.LimitCharacterTaskShowTimer)
    end,
    before_destroy = function(vm)
    end
}

this.LoadGiftCharacterItem = function()
    local activity = ActivityMgr.CheckGiftCharacterIsOpenByCardId(this.giftCharacterItemData.curCardPoolId)
    this.giftCharacterItemData["id"] = activity.id
    this.giftCharacterItemData["panelName"] = activity.key.."Popup"
    local path = "Assets/_BundleResources/UI/TakeCard/" .. activity.key .."Popup" .. ".prefab"
    local prefab = LuaMgr.GetPrefab(path);
    LuaMgr.AddPrefabRefCount(path);
    if (prefab ~= nil) then
        local objTF = prefab.transform;
        objTF:SetParent(this.rootRectTransform, false);
        objTF.localScale = Vector3.one;
        objTF.localPosition = Vector3.zero;
        local item = GiftCharacterCommonPopupItem.New();
        item.path = path;
        item.gameObject = prefab;
        item.transform = objTF;
        item:Init();
        this.giftCharacterItem = item
    end
end

this.RefreshGiftCharacterItem = function()
    this.giftCharacterItem:SetData(this.giftCharacterItemData)
end

return vm({
    data = data,
    command = command,
    hook = hook
})