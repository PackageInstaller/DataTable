
local this = {vm = nil}
local dungeonCfg = nil
local cbFunc = nil
local lastDungeonRecords = nil
local targetDungeonRecords = nil
local targetRateIcon = nil
local isPlayCloseAnim = false

local recordsMap = {
    S = 3,
    A = 2,
    B = 1
} 

local recordsIconMap = {
    "ui_qydt_sj_pj_zhong",
    "ui_qydt_sj_pj_liang",
    "ui_qydt_sj_pj_you",
}

local data = {
    animName = "ani_ui_BattleRateRewardTipsPopup_appears",
    rateIcon = DefaultSprite,
    sliderValue = 0.0,
    rewardItem_1 = {id = "", count = "", isCount = true, rare = DefaultSprite, rareInt = 0, icon = DefaultTexture,
                    scale = Vector3.one, sizeDelta=Vector2.one, isClick = false, isGet = false, isLock = false, select = false, showEffect = false},
    rewardItem_2 = {id = "", count = "", isCount = true, rare = DefaultSprite, rareInt = 0, icon = DefaultTexture,
                    scale = Vector3.one, sizeDelta=Vector2.one, isClick = false, isGet = false, isLock = false, select = false, showEffect = false},
    rewardItem_3 = {id = "", count = "", isCount = true, rare = DefaultSprite, rareInt = 0, icon = DefaultTexture,
                    scale = Vector3.one, sizeDelta=Vector2.one, isClick = false, isGet = false, isLock = false, select = false, showEffect = false},
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if isPlayCloseAnim then
                return
            end
            isPlayCloseAnim = true
            LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
            this.vm.data.animName = "ani_ui_BattleRateRewardTipsPopup_Disappear"
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        dungeonCfg = ConfigMgr.Config.dungeonMap[vm.behaviour.Params[0]]
        if dungeonCfg == nil then
            return
        end
        
        if vm.behaviour.Params[1] ~= nil and vm.behaviour.Params[1] ~= "" then
            targetDungeonRecords = vm.behaviour.Params[1]
            targetRateIcon = recordsIconMap[vm.behaviour.Params[1]]
        else
            targetDungeonRecords = 0
            targetRateIcon = recordsIconMap["B"]
        end
        if vm.behaviour.Params[2] ~= nil and vm.behaviour.Params[2] ~= "" then
            lastDungeonRecords = recordsMap[vm.behaviour.Params[2]]
        else
            lastDungeonRecords = 0
        end
        if vm.behaviour.Params[3] ~= nil then
            cbFunc = vm.behaviour.Params[3]
        end

        this.SetReward()
        this.PlayGetRewardAnim()
    end,
    before_deactive = function(vm)
        if cbFunc ~= nil then
            cbFunc()
        end
        isPlayCloseAnim = false
    end,
}

this.SetReward = function()
    for i, item in ipairs(dungeonCfg.rateAward) do
        local index = 4 - i
        local itemRare = ConfigMgr.Config.itemMap[item.id].rare
        local isGet = lastDungeonRecords >= index
        this.vm.data["rewardItem_" .. index] = {
            id = item.id,
            count = LuaMgr.NumFormat(item.count),isCount = true,
            rare = ActivityMgr.GetRareSprite(itemRare),rareInt = itemRare,
            icon = ActivityMgr.GetItemTexture(item.id),
            scale = Vector3.one,sizeDelta=Vector2(128,128),isClick = true,
            isGet = isGet, 
            isLock = not isGet, 
            select = isGet, 
            showEffect = false
        }
    end
end

this.PlayGetRewardAnim = function()
    this.vm.data.rateIcon = LuaMgr.GetSprite("AreaMapRes", targetRateIcon)
    local targetSliderValue = 0
    if targetDungeonRecords == 1 then
        targetSliderValue = 16.5
    elseif targetDungeonRecords == 2 then
        targetSliderValue = 51.2
    elseif targetDungeonRecords == 3 then
        targetSliderValue = 100
    end
    local sliderTweener = DOTWeen.To(
            function()
                return 0;
            end,
            function(value)
                this.vm.data.sliderValue = value;
                if value > 16 and lastDungeonRecords < 1 then
                    this.SetRewardItem(1, true)
                end
                if value > 51 and lastDungeonRecords < 2 then
                    this.SetRewardItem(2, true)
                end
                if value > 86 and lastDungeonRecords < 3 then
                    this.SetRewardItem(3, true)
                end
            end,
            targetSliderValue, 2
    ):SetEase(Ease.Linear)
end

this.SetRewardItem = function(index, playSound)
    if index == 1 then

        this.vm.data.rewardItem_1.isGet = false
        this.vm.data.rewardItem_1.isLock = false
        this.vm.data.rewardItem_1.select = true
        this.vm.data.rewardItem_1.showEffect = true
        if playSound then
            AudioHelper.PlayUISFX(AudioNames.LevelrewardItem_zhong)
        end
    elseif index == 2 then

        this.vm.data.rewardItem_2.isGet = false
        this.vm.data.rewardItem_2.isLock = false
        this.vm.data.rewardItem_2.select = true
        this.vm.data.rewardItem_2.showEffect = true
        if playSound then
            AudioHelper.PlayUISFX(AudioNames.LevelrewardItem_liang)
        end
    elseif index == 3 then

        this.vm.data.rewardItem_3.isGet = false
        this.vm.data.rewardItem_3.isLock = false
        this.vm.data.rewardItem_3.select = true
        this.vm.data.rewardItem_3.showEffect = true
        if playSound then
            AudioHelper.PlayUISFX(AudioNames.LevelrewardItem_you)
        end
    end
end
this.OnAnimatorPlayFinish = function(args)
    LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
    if args[0] == "ani_ui_BattleRateRewardTipsPopup_Disappear" then
        LuaMgr.HidePanel(UIName.BattleRateRewardViewModel)
    end
    isPlayCloseAnim = false
end

return vm({
    data = data,
    command = command,
    hook = hook
})