local this = {
    vm = nil,
    previewAvatarId = "",
    previewAvatarFrameId = "",
    previewBgId = "",
    previewPlayerInfoSkinId = "",
}

local data = {
    rewardPreviewIcon = DefaultSprite,
    rewardPreviewName = "",
    rewardPreviewDesc = "",
    rewardPreviewCount = "",
    taskRewardPreviewGotoBtn = false,
}

local command = {
    MaskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.GiftCharacterRewardPreviewPopup);
        end
    },
    TaskRewardPreviewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetTaskRewardPreview(false)
            if not IsNullOrEmpty(this.previewAvatarId) then
                LuaMgr.ShowLuaPanel(UIName.SettingAvatarFramedViewModel, 1, this.previewAvatarId);
            elseif not IsNullOrEmpty(this.previewAvatarFrameId) then
                LuaMgr.ShowLuaPanel(UIName.SettingAvatarFramedViewModel, 2, this.previewAvatarFrameId);
            elseif not IsNullOrEmpty(this.previewBgId) then
                LuaMgr.ShowLuaPanel(UIName.SelectCharacterViewModel, this.previewBgId);
                HeroParameter.SaveActivityKey(ActivityKey.LimitCharacterOne)
            elseif not IsNullOrEmpty(this.previewPlayerInfoSkinId) then
                FriendChatMgr.FriendPersonalHome(DataMgr.Player.uid,function(data)
                    LuaMgr.ShowLuaPanel(UIName.FriendPlayerInfoViewModel, data, nil, this.previewPlayerInfoSkinId)
                end)
            end
        end
    },
    GotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.ShowCardPoolPanel(this.curCardPoolId);
        end
    },
}
local hook = {
    before_awake = function(vm)
        this.vm=vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.taskData = vm.behaviour.Params[0]
        this.vm.data.rewardPreviewIcon = LuaMgr.GetSprite("ActivityLimitCharacter", "ui_hd_dptq_mgkj_lb_1_0" .. this.taskData.target)
        local rewardItemId = this.taskData.showReward.id
        local rewardItemCfg = ConfigHelper.GetItemById(rewardItemId)
        if rewardItemCfg ~= nil then
            this.vm.data.rewardPreviewName = LuaMgr.GetLangText(rewardItemCfg.nameLan)
            this.vm.data.rewardPreviewDesc = LuaMgr.GetLangText(rewardItemCfg.DescriptionLan)
            this.vm.data.rewardPreviewCount = string.format(LuaMgr.GetLangText("ActivityLimitCharacterOneViewModel_2"), DataHelper.GetItemCountById(rewardItemId))
        end
        this.vm.data.taskRewardPreviewGotoBtn = this.GetPreviewTypeAndId(rewardItemId)
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
    end
}

this.GetPreviewTypeAndId = function(itemId)
    this.previewAvatarId = ""
    this.previewAvatarFrameId = ""
    this.previewBgId = ""
    this.previewPlayerInfoSkinId = ""
    local rewardItemCfg = ConfigHelper.GetItemById(itemId)
if rewardItemCfg.type ~= 13 then
        return false
    end

    local bgSwitchMap = ConfigMgr.Config.BGSwitchMap;
    for k, v in pairs(bgSwitchMap) do
        if not IsNull(v.UnlockItem1) and #v.UnlockItem1 > 1 and v.UnlockItem1[1] == itemId then
            this.previewBgId = v.Id
            return true
        end
    end
    return false
end

return vm({
    data = data,
    command = command,
    hook = hook
})