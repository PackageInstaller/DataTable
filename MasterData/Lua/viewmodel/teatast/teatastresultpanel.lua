





local heroIconPath = "Assets/_BundleResources/Character/"

local this = {
    vm = nil,
}

local AnmiatorRoot=nil;
local successDropList = nil
local defaultDropList = nil

local data = {
    teaTalkSuccsful = false,
    teaTalkDefault = false,
    msgQinmiduAdd = "",
    msgQinmiduAddNum = "",
    showMsgQinmiduAddNum= false,
    teaTalkRewardTips = "",
    showTeaTalkRewardTips = false,
    msgInteestedNum = "",
    msgHeroDringend = "",

    showSmallHead = DefaultTexture,
    msgHeroName = "",
    JumpToOtherPanel=false;
    
    DropItemList = {{}},
    showGoToBtn=true;
}

local command = {

    ClickJumpToOtherPanel = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local characterId = DataMgr.Player.hightea.ChoseCharacter
            local characterData = DataMgr.Player.characters[characterId]

            if characterData == nil then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TeaTastSipViewModel_4"));
                return
            else
                LuaMgr.InvokeUIEventListeners(UIEventConst.TeaViewToOtherView);
                LuaMgr.ShowLuaPanel(UIName.HeroFriendlyViewModel, characterId)
                LuaMgr.HidePanel(UIName.TeaTastResultPanel);
            end
        end
    },

    ClickResultClose = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnBack();
        end
    },
    
}

local hook = {

    before_awake = function(vm)
        this.vm = vm

        AnmiatorRoot = this.vm.behaviour.transform:Find("root"):GetComponent("Animator")
        successDropList = this.vm.behaviour.transform:Find("root/HeroProup/TalkResult/Succssful/DropItem/Scroll View/Viewport/DropList"):GetComponent("RectTransform")
        defaultDropList = this.vm.behaviour.transform:Find("root/HeroProup/TalkResult/Default/HeroLikeNum (1)/DropItem/Scroll View/Viewport/DropList"):GetComponent("RectTransform")
    end,

    before_active = function(vm)
        local params = vm.behaviour.Params;

        if (params == nil) then
            return
        end
        vm.behaviour:PopupBack(this.OnBack);
        local InterestReward = params[0];
        local characterId = DataMgr.Player.hightea.ChoseCharacter;
        local skinId=HeroManager.GetCharacterSkin(characterId);
        this.vm.data.showSmallHead = LuaMgr.GetTexture(heroIconPath .. characterId .. "/Avatar/" .. skinId..".png")
        local Max, maxTag = FoundationCharacterMgr.CheckHeroAllprestige(characterId)
        this.vm.data.msgHeroName = LuaMgr.GetLangText(ConfigMgr.Config.characterTable[characterId].namelan)
        local InterestedNum = FoundationCharacterMgr.CheckTwOrThTalk();

        this.vm.data.JumpToOtherPanel = InterestReward ~= nil;
        local totalCount = DataMgr.Player.hightea.Total == nil and 1 or DataMgr.Player.hightea.Total
        local oneAddPrestige = DataMgr.Player.hightea.Prestige
        this.vm.data.msgQinmiduAdd = Max and maxTag or "+" .. tostring(oneAddPrestige)
        this.vm.data.msgQinmiduAddNum = DataMgr.Player.hightea.Total .. LuaMgr.GetLangText("TeaTastResultPanel_1")
        this.vm.data.showMsgQinmiduAddNum = not Max and DataMgr.Player.hightea.Total > 1
        this.SuccssfunRewardList(InterestReward)
if DataMgr.Player.characters[characterId]==nil then
            this.vm.data.showGoToBtn=false;
        else
            this.vm.data.showGoToBtn=true;
        end
        this.vm.data.msgInteestedNum = string.format(LuaMgr.GetLangText("TeaTastResultPanel_0"),  InterestedNum) 
        this.vm.data.teaTalkRewardTips = string.format(LuaMgr.GetLangText("TeaTastResultPanel_2"), DataMgr.Player.hightea.Total)
        this.vm.data.showTeaTalkRewardTips = DataMgr.Player.hightea.Total > 1

        if InterestedNum >= 3 then
            this.vm.data.teaTalkDefault = false
            this.vm.data.teaTalkSuccsful = true

            AnmiatorRoot:Play("UI_TeaTastSipPanel_HeroProup_03")
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_success.mp3")

            local DrinkItem = nil;

            for key, value in pairs(ConfigMgr.Config.highteaCharacterMap) do
                if value.ID == characterId then
                    DrinkItem = value
                    break ;
                end
            end

            if DrinkItem == nil then
                return ;
            end

            local text = string.format(LuaMgr.GetLangText(DrinkItem.VictoryEnd2Lan), LuaMgr.GetLangText(ConfigMgr.Config.characterTable[characterId].namelan))

            this.vm.data.msgHeroDringend = string.gsub(text, "\\n", "\n")

        else
            this.vm.data.teaTalkDefault = true
            this.vm.data.teaTalkSuccsful = false

            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_failed.mp3")

            AnmiatorRoot:Play("UI_TeaTastSipPanel_HeroProup_04")

            FoundationCharacterMgr.SayingPlayVoice(false, nil, nil)
        end

    end,

    before_deactive = function(vm)

    end
}

this.OnBack = function()
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/curtain_up.mp3")
    LuaMgr.InvokeUIEventListeners(UIEventConst.TeaResultClose);
    LuaMgr.HidePanel(UIName.TeaTastResultPanel);
end


this.SuccssfunRewardList = function(Rewardtab)
    if Rewardtab==nil then
        return;
    end
    
    local SuccssfultempRewardLis = {}
    local Succssfultemplite = {}
    for index, value in pairs(Rewardtab) do
        local itemRare = ConfigMgr.Config.itemMap[value.id].rare
        local rewardItem = {
            id = value.id,
            count = tostring(value.count),
            isCount = true,
            rare = ActivityMgr.GetRareSprite(itemRare),
            rareInt = itemRare,
            icon = ActivityMgr.GetItemTexture(value.id),
            scale = Vector3.one,
            sizeDelta = Vector2(128, 128),
            isClick = true,
            pageItemIcon = true
        }
        table.insert(SuccssfultempRewardLis, rewardItem)
    end
    this.vm.data.DropItemList = SuccssfultempRewardLis
    if #SuccssfultempRewardLis >= 3 then
        successDropList.pivot = Vector2(0, 0.5)
        defaultDropList.pivot = Vector2(0, 0.5)
        successDropList.anchoredPosition = Vector2(0, -60)
        defaultDropList.anchoredPosition = Vector2(0, -60)
    else
        successDropList.pivot = Vector2(0.5, 0.5)
        defaultDropList.pivot = Vector2(0.5, 0.5)
        successDropList.anchoredPosition = Vector2(160, -60)
        defaultDropList.anchoredPosition = Vector2(160, -60)
    end
end


return vm(
{
    data = data,
    command = command,
    hook = hook
}
)