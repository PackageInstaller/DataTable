





local heroIconPath = "Assets/_BundleResources/Character/"
local objectIconPath = "Assets/_BundleResources/Images/Archives/"

local this = {
    vm = nil,
}

local AnmiatorRoot=nil
local RewardContentGridLayout = nil

local TargetPos
local loadingAnimation
local defaultTargetPos
local soffsetx
local LoadPainding
local teaHeroIndex = 1

local rewardItemScale = {
    {scale = Vector3(0.8, 0.8, 0.8), size = Vector2(102, 102)},
    {scale = Vector3(0.65, 0.65, 0.65), size = Vector2(83, 83)},
    {scale = Vector3(0.5, 0.5, 0.5), size = Vector2(64, 64)},
    {scale = Vector3(0.35, 0.35, 0.35), size = Vector2(45, 45)},
}

local data = {
    msgLastTimeMinus10Text = "",
    msgLastTimeSecond10Text = "",
    msgLastTimeHoures10Text = "",
    msgLastTimeHouresText = "",
    msgLastTimeMinusText = "",
    msgLastTimeSecondText = "",
    timeshowHour = "",
    timeshowSecond = "",
    timeshowminus = "",
    showTeaLastTime = false,
    teaHeroSelectShow = false,
    showNetRewardlist = false,
    showNetRewardEffect = false,
    msgTeaName="";
    LoadingPanelPos = Vector3.zero,

    loadingPabel = false,

    ContentPos = Vector3.zero,
    birdsAnimationIcons = false,
    birdsButtonIcons=false;
    
    heroList = {
        {
            itemId = "",
            object = false,
            heroIcon = DefaultTexture,
            objectIcon = DefaultTexture,
            already = false,
            heroTrue = Vector3.zero,
            objectTrue = Vector3.zero,
            heroFalse = Vector3.zero,
            heroNot = Vector3.zero,
            heroName = "",
            animationName = "",
            friendlyLevel = "",
        }
    },

    HeroStateShow = {
        {
            stateicon = DefaultSprite,
            selectLight = DefaultSprite,
            currentSate = false,
            playAnimation = false,
            stateName = ""
        }
    },


    TeaGetItemList = {
        {
            aRewardLis = {}
        }
    },
    DropItemList = {
        {
            
        }
    }
}


local command = {
    ClickCloseBeforSelect = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            UnityEngine.Debug.LogError("ClickCloseBeforSelect");
            AnmiatorRoot.AnimationName = "UI_TeaTastSipPanel_BeforSelectShow_02";
            coroutine_runner.start(
                    function()
                        UnityEngine.Debug.LogError("start");
                        coroutine_runner.wait(0.3)
                        this.vm.data.showNetRewardEffect = false
                        this.vm.data.loadingPabel = false
                        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, false, nil);
                        LuaMgr.HidePanel(UIName.TeaBeforSelectPanel);
                        UnityEngine.Debug.LogError("HidePanel");
                    end
            )
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm

        AnmiatorRoot = this.vm.behaviour.transform:Find("root"):GetComponent("UIAnimator")
        TargetPos = this.vm.behaviour.transform:Find("root/Left/BridParent")
        defaultTargetPos = this.vm.behaviour.transform:Find("root/Left")
        loadingAnimation = this.vm.behaviour.transform:Find("root/BuildPosition/LodingAnimatin")
        LoadPainding = this.vm.behaviour.transform:Find("root/BuildPosition/LodingAnimatin/PageGroup"):GetComponent("RectTransform")
        RewardContentGridLayout = this.vm.behaviour.transform:Find("root/PeoplePosition/BeforSelectShow/Achieve/AchieveTags/Rewards/Viewport/Content"):GetComponent("GridLayoutGroup")
        soffsetx = LuaMgr.ScreenOffSet() / 2
    end,
    before_active = function(vm)

        local params=vm.behaviour.Params;

        if params==nil then
            return;
        end

        local item = params[0];

        this.vm.data.showTeaLastTime = false
        if item ~= nil and item.itemRealName~=nil then
            this.vm.data.msgTeaName = item.itemRealName

            this.vm.data.LoadingPanelPos = Vector3.zero
            this.vm.data.ContentPos = Vector3.zero
            LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
            AnmiatorRoot.AnimationName = "UI_TeaTastSipPanel_LodingAnimatin_01";
            this.loadingShow()

            return;
        end
        
        this.ShowTeaLastTime();
    end ,

    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.TeaLastTime)
        LuaMgr.RemoveTimer(TimerConst.DelayClose)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        this.vm.data.loadingPabel = false;
        this.vm.data.teaHeroSelectShow = false;
    end
}


this.loadingShow = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, true, nil);
    this.vm.data.loadingPabel = true
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_loading.mp3")
end

this.OnAniPlayFinish = function(args)
    if args[0] == "UI_TeaTastSipPanel_LodingAnimatin_01" then
        this.vm.data.loadingPabel = false
        this.ShowTeaLastTime()
    end
end

this.ShowTeaLastTime = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, false, true)
    LuaMgr.RemoveTimer(TimerConst.TeaLastTime)
    LuaMgr.AddTimer(TimerConst.TeaLastTime, this.TimeTextShow, 1, 72000, true)






end

this.TimeTextShow = function()
    local EndTimeStamp= DataMgr.Player.hightea.Deadline;
    local leftTime = EndTimeStamp - LuaMgr.Timestamp()
    LuaDebug.error("leftTime: " .. leftTime)
    if EndTimeStamp - LuaMgr.Timestamp() > 0 then






    else
        LuaMgr.RemoveTimer(TimerConst.TeaLastTime)
        
        local stage=DataMgr.Player.hightea.Stage
        if stage == 4 then
            this.BeforeTalkNetMessage()
        else
            LuaMgr.HidePanel(UIName.TeaBeforSelectPanel);
            print("喝完茶 为啥不给我约定的状态4去领奖 ： "..stage)
        end

        FoundationCharacterMgr.CreatQSpine(false)
    end
end


this.BeforeTalkNetMessage = function()
    local data = {}
    ApiMgr.Request(
"hightea/get_reward",
            data,
            true,
            function(result)
                local re = json.decode(result)
                local tab = re.result.Items
               this.ShowItemDropList(tab)
            end,
            function(failCode)
                print("EnterDungeonError,ErrorCode:", failCode)
            end,
            true
    )
end


this.ShowItemDropList = function(tab)
    this.vm.data.teaHeroSelectShow = true
    AnmiatorRoot.AnimationName = "UI_TeaTastSipPanel_BeforSelectShow_01";
    this.vm.data.showTeaLastTime = false
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, true, nil);
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_finish.mp3")
    this.ShowNetGetHero()
    FoundationCharacterMgr.CreatQSpine(true)
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomTeaMain, true, nil);
    coroutine_runner.start(
            function()
                coroutine_runner.wait(0.5)
                this.vm.data.showNetRewardEffect = true
                AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/SSRitem_get.mp3")
            end
    )
    local tempRewardLis = {}
    local rewardCount = ConfigHelper.GetTableLength(tab)
    rewardCount = rewardCount > 4 and 4 or rewardCount
    RewardContentGridLayout.cellSize = rewardItemScale[rewardCount].size
    for index, itemvalue in pairs(tab) do
        local itemRare = ConfigMgr.Config.itemMap[itemvalue.id].rare
        local rewardItem = {
            id = itemvalue.id,
            count = tostring(itemvalue.count),
            isCount = true,
            rare = ActivityMgr.GetRareSprite(itemRare),
            rareInt = itemRare,
            icon = ActivityMgr.GetItemTexture(itemvalue.id),
            scale = rewardItemScale[rewardCount].scale,
            sizeDelta = rewardItemScale[rewardCount].size,
            isClick = true,
            pageItemIcon = true
        }
        table.insert(tempRewardLis, rewardItem)
    end
    this.vm.data.DropItemList = tempRewardLis
end


this.ShowNetGetHero = function()
    local tempList = {}
    local characters = DataMgr.Player.hightea.Characters
    for key, value in pairs(characters) do
        local charactersData = DataMgr.Player.characters[value]
        local hero = {
            itemId = value.ID,
            object = false,
            heroIcon = LuaMgr.GetTexture(heroIconPath .. value .. "/Avatar/" .. HeroManager.GetCharacterSkin(value) .. ".png"),
            objectIcon = LuaMgr.GetTexture(objectIconPath .. "head_" .. value .. ".png"),
            already = true,
            heroTrue = Vector3.one,
            objectTrue = Vector3.zero,
            heroFalse = Vector3.zero,
            heroName = value.Name,
            heroNot = Vector3.one,
            animationName = "UI_TeaTastSipPanel_HeroMapItem",
            friendlyLevel = charactersData == nil and "1" or tostring(charactersData.prestigeLevel)
        }
        table.insert(tempList, hero)
    end
    this.vm.data.heroList = tempList
    this.vm.data.showNetRewardlist = true
    LuaMgr.AddTimer(TimerConst.DelayClose, this.OnZZItemDelay, 0.1, -1, true)
end

this.OnZZItemDelay = function()
    if (teaHeroIndex < #this.vm.data.heroList + 1) then
        this.vm.data.heroList[teaHeroIndex].object = true
        teaHeroIndex = teaHeroIndex + 1
    end
    if (teaHeroIndex >= #this.vm.data.heroList + 1) then
        LuaMgr.RemoveTimer(TimerConst.DelayClose)
        teaHeroIndex = 1
    end
end

this.TimeNumShow = function(decomds)
    local Hours10Times = ""
    local Hours1Times = ""
    local Minus1Times = ""
    local Minus10Times = ""
    local Second1Times = ""
    local Second10Times = ""
    local HoursTimes
    local MinusTimes
    local SecondTimes
    local function SubStringIndex(str)
        local Str1
        local Str2
        Str1 = string.sub(str, 1, 1)
        Str2 = string.sub(str, 2, 2)
        return Str1, Str2
    end
    local h = math.floor(decomds / 3600)
    local m = math.floor((decomds % 3600) / 60)
    local s = math.floor((decomds % 3600) % 60)
    HoursTimes = h < 10 and "0" .. tostring(h) or tostring(h)
    MinusTimes = m < 10 and "0" .. tostring(m) or tostring(m)
    SecondTimes = s < 10 and "0" .. tostring(s) or tostring(s)
    Hours10Times, Hours1Times = SubStringIndex(HoursTimes)
    Minus10Times, Minus1Times = SubStringIndex(MinusTimes)
    Second10Times, Second1Times = SubStringIndex(SecondTimes)
    return Hours10Times, Hours1Times, Minus10Times, Minus1Times, Second10Times, Second1Times
end


return vm(
{
    data = data,
    command = command,
    hook = hook
}
)