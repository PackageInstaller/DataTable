




require("ViewModel/Branch/BranchHeroItemModel")
require("ViewModel/Branch/AnecdoteItemModel")
require("ViewModel/Branch/AnecdoteDungeonItem")
local this = {vm = nil,panelType = nil,branchNovelBg = nil,leftBg = nil,
              PageIconPath = "Assets/_BundleResources/Images/Branch/",
              equipIconPath = "Assets/_BundleResources/Images/ItemIcons/itemicon_",
              CurrentPages = nil,CurrenPageIndex = nil,StageGroup = {},SelectBranch = nil,
              SelectBattleGroup = {},onDragBehaviour = nil,onDragParent = nil,offDistance = 0,
              distance = 80,startDragX = 0,DragePos = 0,CurrentNovel = {},SeleNovel = nil,
              PlayerBranchData = nil,CurrentNovelGroup = {},TextColor2 = "<color=#37544b>%s</color>",
              TextColor5 = "<color=#ede3d2>%s</color>",CompleteTween = 0,BookLayout = nil,BattleLayOut = nil,
              CunrrenshowBook = nil,RedDataTab = {},RedShowData = nil,SelectPageListIndex = nil,
battlBackToBranch = nil, novelLock = true,
              heroScrollView = nil,heroTemplate = nil,
              anecdoteScrollView = nil,anecdoteTemplate = nil,
              anecdoteDungeonView = nil,dungeonTemplate = nil,
              anecdoteList = {},dungeonStateList = {},anecdoteIndex = nil,
              anecdotePath = "Assets/_BundleResources/Images/BranchAnecdote/",
              panelEnum = {branchArea = "branchArea",branchprop = "branchprop",branchAnecdote = "branchAnecdote"}
}
local BranchRunPos = {
    Vector3(-1040, 26, 0), Vector3(-520, 26, 0), Vector3(0, 26, 0),
    Vector3(520, 26, 0), Vector3(1040, 26, 0)
}
local Branchstandard = {
    Vector3(-1283, 26, 0), Vector3(-763, 26, 0), Vector3(-243, 26, 0),
    Vector3(773, 26, 0), Vector3(1293, 26, 0)
}
local currentItem = {
    {
        itemName = "branchListChild1",
        tweener = nil,
        pos = BranchRunPos[1],
        nextpos = Vector3.zero,
        index = 1,
        dataid = 0
    },
    {
        itemName = "branchListChild2",
        tweener = nil,
        pos = BranchRunPos[2],
        nextpos = Vector3.zero,
        index = 2,
        dataid = 0
    },
    {
        itemName = "branchListChild3",
        tweener = nil,
        pos = BranchRunPos[3],
        nextpos = Vector3.zero,
        index = 3,
        dataid = 0
    },
    {
        itemName = "branchListChild4",
        tweener = nil,
        pos = BranchRunPos[4],
        nextpos = Vector3.zero,
        index = 4,
        dataid = 0
    },
    {
        itemName = "branchListChild5",
        tweener = nil,
        pos = BranchRunPos[5],
        nextpos = Vector3.zero,
        index = 5,
        dataid = 0
    }
}
local CurrrentSelectPageChild = {}
local CurrrentSelectBattledata = {}
local BeforBattleId
local NovelBattleId
local OptionGropu = true
local OptionGropuTips = ""
local CurrentNovelSelect = nil
local PageIndex = nil
local backtocortuine = nil

local GrandSonPanelShow = nil

local BranchTransformGroup = {}

local PlayeBookEffect = false

local PlayeBookEffectIndex = nil

local PlayeBookPropEffect = nil

local PlayeNovelEffect = nil

local PlayeBattlelEffect = false

local PlayeNovelBeforeEffect = false

local GrandSondAnimation

local GrandSondTransForm

local CurrentSelectNovel = nil

local BeforBattleClear

local BeforBattleComplete
local BackToBranch

local Currentbranch


local BookRewardList = nil
local selectBranchRewardIndex = nil
local data = {
    branchPos1 = Vector3.zero,
    branchPos2 = Vector3.zero,
    branchPos3 = Vector3.zero,
    branchPos4 = Vector3.zero,
    branchPos5 = Vector3.zero,
    BranchPageShow = true,
    BranchePropShow = false,
    BranchBattleEventShow = false,
    BranchNovelEventshow = false,
    BranchMainShow = false,
    BrancNovelTextShow = "",
    BranchNovelbattleLock = false,
    BranchNovelbattleUnLock = true,
    novelEnpty = false,
    novelNotEnpty = false,
    NovelBattleEventPos = Vector3.zero,
    BattleScrollBar = 0,
    contentPagePos = Vector2(0, 0),

    contentBattlevertical = false,
    contentBookHiroscroll = false,
    closeDoubleClicks = false,
    bookMainPosLeftBotttom = Vector2(0, 0),
    bookMainPosRightTop = Vector2(0, 0),
    showBeforeBattleLock = true,
    showBeforeBattleUnlock = false,
    alreadySeeNovel = false,
    firstSeeNovel = false,
    BranchRewardGroups = true,
    BranchHeroObject = false,
    BranchAnecdoteObject = false,
    animatorName = "",
    anecdoteAnimName = "",
    rewardEffect = false,
    rewardAlready = false,
    RewardListGroups = false,
    RewardListGroupsBgScale = Vector3(-1, 1, 1),

    RewardListSliderValue = 0.1,
    CompleteBookTag = "",
    branchBookRewardTitle = "",
    branchList = {{itemId = "",itemStateNum = "",itemName = "",itempages = "",
                   Lock = false,LockShowPage = false,HeroIconShow = false,findIndex = "",
                   stateshow = false,Showeffect = false,titleshow = false,UnLock = false,
selsect = false,unselsect = true,
                   ItemIcon = DefaultTexture,stateIcon = DefaultSprite,LocksIcon = DefaultTexture,
                   ItemCircleIcon = DefaultTexture,slidervalue = 0,circleLocalPos = Vector3.zero,
                   TitlePos = Vector2.zero,uidislove = 0,uiEffectShow = false,showAnimation = false,
                   redPoint = ""}
    },
    branchListChild1 = {
        {
            itemId = "",
            itemStateNum = "",
            itemName = "",
            itempages = "",
            Lock = false,
            UnLock = false,
            selsect = false,
            unselsect = true,
            ItemIcon = DefaultTexture,
            stateIcon = DefaultSprite,
            LocksIcon = DefaultTexture,
            showChildMisson = false,
            LockShowPage = false,
            HeroIconShow = false,
            Showeffect = false,
            Itemactive = false,
            stateshow = false,

            ItemCircleIcon = DefaultTexture,
            slidervalue = 0,
            circleLocalPos = Vector3.zero,
            uidislove = 0,
            uiEffectShow = false,
            AnimationName = ""
        }
    },
    branchListChild2 = {
        {
            itemId = "",
            itemStateNum = "",
            itemName = "",
            itempages = "",
            Lock = false,
            UnLock = false,
            selsect = false,
            unselsect = true,
            ItemIcon = DefaultTexture,
            stateIcon = DefaultSprite,
            LocksIcon = DefaultTexture,
            showChildMisson = false,
            Itemactive = false,
            stateshow = false,
            LockShowPage = false,
            Showeffect = false,
            HeroIconShow = false,

            ItemCircleIcon = DefaultTexture,
            slidervalue = 0,
            circleLocalPos = Vector3.zero,
            uidislove = 0,
            uiEffectShow = false,
            AnimationName = ""
        }
    },
    branchListChild3 = {
        {
            itemId = "",
            itemStateNum = "",
            itemName = "",
            itempages = "",
            Lock = false,
            UnLock = false,
            selsect = false,
            unselsect = true,
            LockShowPage = false,
            Showeffect = false,
            HeroIconShow = false,
            ItemIcon = DefaultTexture,
            stateIcon = DefaultSprite,
            LocksIcon = DefaultTexture,
            showChildMisson = false,
            Itemactive = false,
            stateshow = false,


            slidervalue = 0,

            uidislove = 0,
            uiEffectShow = false,
            AnimationName = ""
        }
    },
    branchListChild4 = {
        {
            itemId = "",
            itemStateNum = "",
            itemName = "",
            itempages = "",
            Lock = false,
            UnLock = false,
            selsect = false,
            unselsect = true,
            ItemIcon = DefaultTexture,
            stateIcon = DefaultSprite,
            LocksIcon = DefaultTexture,
            showChildMisson = false,
            Itemactive = false,
            stateshow = false,
            LockShowPage = false,
            HeroIconShow = false,
            Showeffect = false,

            ItemCircleIcon = DefaultTexture,
            slidervalue = 0,

            uidislove = 0,
            uiEffectShow = false,
            AnimationName = ""
        }
    },
    branchListChild5 = {
        {
            itemId = "",
            itemStateNum = "",
            itemName = "",
            itempages = "",
            Lock = false,
            UnLock = false,
            selsect = false,
            LockShowPage = false,
            HeroIconShow = false,
            Showeffect = false,
            unselsect = true,
            ItemIcon = DefaultTexture,
            stateIcon = DefaultSprite,
            LocksIcon = DefaultTexture,
            showChildMisson = false,
            Itemactive = false,
            stateshow = false,


            slidervalue = 0,

            uidislove = 0,
            uiEffectShow = false,
            AnimationName = ""
        }
    },
    selectMission = {
        {
            itemId = "",
            itemStateNum = "",
            itemName = "",
            itempages = "",
            Lock = false,
            UnLock = false,
            selsect = false,
            unselsect = true,
            BattleGoto = false,
            perfect = false,
            clear = false,
            states = false,
            unlockEffect = false,
            unlockshow = false,
            ItemIcon = DefaultSprite,
            stateIcon = DefaultSprite,
            Bgtexture = DefaultSprite,
            effectBgIcon = DefaultSprite,
            effecAnimationName = "",
            redId = "",
        }
    },
    novelEvent = {
        {
            itemId = "",
            itemStateNum = "",
            itemName = "",
            itempages = "",
            redIds = "",
            Lock = false,
            State = false,
            descLight = false,
            descDark = false,
            battleLock = false,
            battleUnLock = false,
            LockAnimation = false,
            LockAnimationBg = DefaultSprite,
            ItemIcon = DefaultSprite,
            stateIcon = DefaultSprite,
            showRedPoint=true;
        }
    },
    itemList = {
        {
            itemId = "",
            count = "",
            object = false,
            equipRare = DefaultSprite,
            equipIcon = DefaultTexture,
            already = false,
            isCount = false,
            equipTrue = Vector3.zero,
            equipFalse = Vector3.zero
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
            equipTrue = Vector3.zero,
            equipFalse = Vector3.zero
        }
    },
    PageList = {
        {
            itemId = "",
            itemName = "",
            itemNameShow = "",

            PageState = false,
            select = false,
            UnSelect = false,
            Lock = false,
            itemIndex = "",
            PageSprite = DefaultSprite,
            StateText = "",
            LocalPos = Vector3.zero,
            completeShow = false,
            LockShow = false,
            clearShow = false,
            showUnlockEffect = false,
            Pagered = "",
            LockAnimation = false
        }
    },
    OpinionList = {
        { description = "", object = false, achieve = false, unAchieve = false }
    },
    BranchRewardList = {
        {
            RewardIcon = DefaultSprite,
            lockicon = DefaultTexture,
            showEffect = false,
            Name = "",
            cangetState = DefaultTexture,
            alradyGetState = DefaultTexture,
            alreadyget = false,
            notget = false,
            currentget = false,
            redId = "",
            countText = "",
            bgScale = Vector3.zero,
        }
    },
    dungeonList = {{pass = false,perfect = false,lock = false,effect = false,number = "",color = UnityEngine.Color(1,1,1,1),icon = DefaultTexture},
                   {pass = false,perfect = false,lock = false,effect = false,number = "",color = UnityEngine.Color(1,1,1,1),icon = DefaultTexture}},
    rewardList = {{itemIcon = DefaultTexture,itemId = "",already = false,bar = false}},
    anecdoteIcon = DefaultTexture,
    anecdotePost = Vector2.zero,
    anecdoteText = DefaultTexture,
    rewardBar = 0.0,
    rewardBarColor = UnityEngine.Color(1,1,1,1),
    rewardIcon = DefaultTexture,
    rewardPost = Vector2.zero,
    rewardCount = "",
    rewardPopup = false,

    rewardPopupBarText = "",
    branchNovel = false,
    branchHero = false,
    branchAnecdote = false,
}

local command = {
    ClickMissionItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if PageIndex ~= nil and PageIndex == param + 1 then
                return
            end
            this.CloseBookRewardGroup()
            local Click = true
            this.SelectPageItems(param + 1, Click)
            ComData.branchData.pageIds = nil
            ComData.branchData.pageindex = nil
        end
    },
    Backs = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            ComData.branchData.novelParam = nil
            CurrentNovelSelect = nil
            if not this.vm.data.BranchPageShow then
                this.vm.data.BranchPageShow = true
                this.vm.data.BranchePropShow = false
                this.branchNovelBg.anchoredPosition = Vector2(904,0)
                this.leftBg.anchoredPosition = Vector2(42,0)
                this.vm.data.BranchBattleEventShow = false
                this.vm.data.BranchNovelEventshow = false
                this.vm.data.BranchMainShow = true
            else
                ComData.branchData.bookindex = nil
                ComData.branchData.pageindex = nil
                ComData.branchData.pageIds = nil
                LuaMgr.Back()
            end
        end
    },
    ClickStoryItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SelectBranch = param + 1
            this.ClickPageStateShow(this.SelectBranch, 0)
        end
    },
    ClickStoryPropItemLeft = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            ComData.branchData.NorvelGoto = nil
            ComData.branchData.BattleGoto = nil
            ComData.branchData.novelIndex = nil
            this.clicksBooksToLeft()
        end
    },
    ClickStoryPropItemRight = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            ComData.branchData.NorvelGoto = nil
            ComData.branchData.BattleGoto = nil
            ComData.branchData.novelIndex = nil
            this.clicksBooksToRight()
        end
    },
    ClickBranchAwardItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.BranchRewardItemClicks(param + 1)
        end
    },
    ClickBattleStar = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local tabs = this.vm.data.selectMission[param + 1]
            if tabs.Lock then
                this.BattleStartShow(tabs)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",
                OptionGropuTips)
            else
                this.IntoBattlePanel(tabs.param)
            end
        end
    },
    ClickNovelChange = {
        type = XLuaCommandType.Void,
        execute = function(vm, param) this.changeNovelSelect(param) end
    },
    ClickBattleommitMent = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.BranchNovelEventshow then
                local Id = this.vm.data.BranchNovelbattleLock and BeforBattleId or
                NovelBattleId
                if this.vm.data.BranchNovelbattleLock then
                    LuaMgr.SetAreaBattleType(BattleType.Branch)
                    local types = ConfigMgr.Config.dungeonMap[BeforBattleId]
                    .type
                    BattlePrepareMgr.EnterBattlePrepare(BeforBattleId, BeforBattleId,
                    types)
                    ComData.branchData.beforbattleId = BeforBattleId
                    ComData.branchData.beforbattle = true
                    ComData.branchData.novelIndex = CurrentNovelSelect
                    ComData.branchData.NorvelGoto = true
                    ComData.branchData.BattleGoto = nil
                    ComData.branchData.pageindex = this.CurrenPageIndex
                    ComData.branchData.pageIds = this.CurrentPages
                    ComData.branchData.bookindex = this.SelectBranch
                    this.vm.OpenProp = nil
                    return
                end
                if this.novelLock then
                    LuaMgr.PlayNovel(Id, function()
                        LuaMgr.ShowLuaPanel("BranchMissionViewModel")
                    end)
                    ComData.branchData.novelIndex = CurrentNovelSelect
                    ComData.branchData.NorvelGoto = true
                    ComData.branchData.BattleGoto = nil
                    ComData.branchData.pageindex = this.CurrenPageIndex
                    ComData.branchData.pageIds = this.CurrentPages
                    ComData.branchData.bookindex = this.SelectBranch
                    table.insert(ComData.branchData.oldPlayerData,
                    this.PlayerBranchData)
                    this.vm.OpenProp = nil
                else
                    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",
                    OptionGropuTips)
                end
            end
        end
    },
    ClickBattlHistory = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.BranchNovelEventshow then
                if OptionGropu then
                    if BeforBattleId == nil then return end
                    local types = DataMgr.Player.dungeonRecords[BeforBattleId]
                    .type
                    LuaMgr.SetAreaBattleType(BattleType.Branch)
                    BattlePrepareMgr.EnterBattlePrepare(BeforBattleId, BeforBattleId,
                    types)
                    ComData.branchData.novelIndex = CurrentNovelSelect
                    ComData.branchData.NorvelGoto = true
                    ComData.branchData.BattleGoto = nil
                    ComData.branchData.pageindex = this.CurrenPageIndex
                    ComData.branchData.pageIds = this.CurrentPages
                    ComData.branchData.bookindex = this.SelectBranch
                    this.vm.OpenProp = nil
                else
                    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",
                    OptionGropuTips)
                end
            end
        end
    },
    ClickItemShow = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            local goodsId
            if this.vm.data.RewardListGroups then
                goodsId = this.vm.data.bookitemList[param + 1].itemId
            else
                goodsId = this.vm.data.itemList[param + 1].itemId
            end
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, goodsId, false, false,
            false)
        end
    },
    ClicksBlink = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.onDragBehaviour:SetParent(this.onDragParent, false)
        end
    },
    ClicksCloseRewardTips = {
        type = XLuaCommandType.Void,
        execute = function(vm, param) this.CloseBookRewardGroup() end
    },
    branchTypeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.panelType == this.panelEnum.branchArea then return end
            this.panelType = this.panelEnum.branchArea
            HeroParameter.SavePanelType(this.panelType)
            this.InitPageType()
        end
    },
    branchHeroTypeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.panelType == this.panelEnum.branchprop then return end
            this.panelType = this.panelEnum.branchprop
            HeroParameter.SavePanelType(this.panelType)
            this.InitPageType()
        end
    },
    branchAnecdoteTypeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.panelType == this.panelEnum.branchAnecdote then return end
            this.panelType = this.panelEnum.branchAnecdote
            HeroParameter.SavePanelType(this.panelType)
            this.InitPageType()
        end
    },
    dungeonCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local config = this.anecdoteList[this.anecdoteIndex]
            local index = tonumber(param)
            if index < 0 then
                index = #this.dungeonStateList[config.ID]
            elseif index == 0 then
                index = #this.dungeonStateList[config.ID] - 1
            end
            local dungeon = this.dungeonStateList[config.ID][index]
            local unlocked = DataMgr.Player.branch.children["Reg2001"].children[config.ID].children[dungeon.id].unlocked
            if unlocked then
                HeroParameter.anecdoteIndex = this.anecdoteIndex
                if dungeon.type == "1" then
                    LuaMgr.PlayNovel(dungeon.param,function()
                        LuaMgr.ShowLuaPanel("BranchMissionViewModel")
                    end)
                else
                    LuaMgr.SetAreaBattleType(BattleType.Branch)
                    BattlePrepareMgr.EnterBattlePrepare(dungeon.param, dungeon.param, 3)
                end
            else
                local beforeId = nil
                local beforeType = nil
                for i = 1, #this.dungeonStateList[config.ID] do
                    if this.dungeonStateList[config.ID][i].id == dungeon.before then
                        beforeType = this.dungeonStateList[config.ID][i].type
                        beforeId = this.dungeonStateList[config.ID][i].param
                        break
                    end
                end
                local tipName = nil
                local tipStr = nil
                if beforeType == "1" then
                    tipName = LuaMgr.GetLangText(ConfigMgr.Config.narrativeMap[beforeId].nameLan)
                    tipStr = string.format(ConfigMgr.LangGlobal("15006"),tipName)
                else
                    tipName = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[beforeId].NameLan)
                    tipStr = string.format(ConfigMgr.LangGlobal("10001"),tipName)
                end
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            end
        end
    },
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local config = this.anecdoteList[this.anecdoteIndex]
            local tempData = DataMgr.Player.branch.children["Reg2001"].children[config.ID].children
            local canGetCount = 0
            local alreadyCount = 0
            for key,value in pairs(tempData) do
                if value.completed and not value.received then
                    canGetCount = canGetCount + 1
                end
                if value.received then
                    alreadyCount = alreadyCount + 1
                end
            end
            if canGetCount <= 0 then
                this.OpenRewardPopup(alreadyCount)
            else
                local reward = {config.ID}
                local fun = function()
                    this.anecdoteScrollView.dataList[this.anecdoteIndex].data.red = false
                    this.SetItemChoose(this.anecdoteIndex)
                end
                this.NetBranchBookReward(reward,fun)
            end
        end
    },
    rewardItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1
            local id = this.vm.data.rewardList[index].itemId
            if IsNullOrEmpty(id) then return end
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,id,false,false,false,0,0);
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        print("before_awake")
        this.onDragBehaviour = vm.behaviour.transform:Find("root/BranchNovel/DragBefor/MiddleDrage"):GetComponent("OnDragBehaviour")
        this.BookLayout = vm.behaviour.transform:Find("root/BranchNovel/BrancheGroupView/TeaSelectView")
        this.BattleLayOut = vm.behaviour.transform:Find("root/BranchNovel/GrandSonPanelOne/GrandSonPanelOne/SelectMissionListView/BattleSelectView")
        GrandSondTransForm = vm.behaviour.transform:Find("root/BranchNovel/GrandSonPanelOne/GrandSonPanelOne")
        GrandSondAnimation = GrandSondTransForm:GetComponent("Animator")
        BranchGropParent = vm.behaviour.transform:Find("root/BranchNovel/BrancheGroupPropGroup")
        this.onDragBehaviour.onDrag = this.OnDrag
        this.onDragBehaviour.onPointerDown = this.PointerDown
        this.onDragBehaviour.onPointerUp = this.OnPointerUp
        this.onDragBehaviour.onEndDrag = this.OnEndDrag
        BackToBranch = (ComData.branchData.BattleGoto ~= nil or
        ComData.branchData.NorvelGoto ~= nil)
        GrandSonPanelShow = this.vm.behaviour.transform:Find("root/BranchNovel/GrandSonPanelOne")
        BookRewardList = this.vm.behaviour.transform:Find("root/BranchNovel/RewardListGroups")
        this.branchNovelBg = this.vm.behaviour.transform:Find("root/BranchNovel/Bg")
        this.leftBg = this.vm.behaviour.transform:Find("root/Left_/Bgs")
        this.heroScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/BranchHero/ScrollView").gameObject)
        this.heroTemplate = vm.behaviour.transform:Find("template/HeroItem").gameObject
        this.anecdoteScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/BranchAnecdote/ScrollView").gameObject)
        this.anecdoteDungeonView = UIScrollView.New(vm.behaviour.transform:Find("root/BranchAnecdote/DungeonList").gameObject)
        this.anecdoteTemplate = vm.behaviour.transform:Find("template/AnecdoteItem").gameObject
        this.dungeonTemplate = vm.behaviour.transform:Find("template/DungeonItem").gameObject
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.BranchHeroObject = this.GetBranchSwitch("Reg1001")
        this.vm.data.BranchAnecdoteObject = this.GetBranchSwitch("Reg2001")
        this.ViewAdaptive()
        if this.vm.behaviour.Params.Length > 0 then
            local param = this.vm.behaviour.Params[0]
            if param == this.panelEnum.branchprop then
                HeroParameter.activityGotoPanel = true
            elseif param == this.panelEnum.branchAnecdote then

                HeroParameter.SavePanelType(param)
            end
        end
        this.InitPageType()
        LuaMgr.AddUIEventListener(UIEventConst.AnecdoteItemChoose, this.ItemClickEvent)
        LuaMgr.AddUIEventListener(UIEventConst.AnecdoteDungeonClick, this.DungeonClickEvent)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.panelType = nil
        this.heroScrollView:Clear(false)
        this.anecdoteScrollView:Clear(false)
        this.anecdoteDungeonView:Clear(false)
        local root = this.vm.behaviour.transform:Find("root")
        if GrandSonPanelShow ~= nil then
            GrandSonPanelShow:SetParent(root, false)
            this.InitBranchPropPosition()
            LuaMgr.HidePanel(UIName.BranchMissionEvent3ViewModel)
        end
        this.CloseBookRewardGroup()
        LuaMgr.RemoveUIEventListener(UIEventConst.TopBarHome, this.BackToHome)
        LuaMgr.RemoveUIEventListener(UIEventConst.NovelCompleteReward,
        this.LowNetRefushData)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnecdoteItemChoose, this.ItemClickEvent)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnecdoteDungeonClick, this.DungeonClickEvent)
        this.InitEffectState()
        this.vm.data.BranchePropShow = false
        if backtocortuine ~= nil then
            coroutine_runner.stop(backtocortuine)
            backtocortuine = nil
            this.ClearData()
        end
        CurrentSelectNovel = nil
        if ComData.branchData.BattleGoto ~= nil or ComData.branchData.NorvelGoto ~=
        nil then
        else
            this.ClearData()
        end
        this.anecdoteList = {}
        this.dungeonStateList = {}
        this.vm.data.rewardList = {}
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("BranchHeroItemModel")
        UIScrollView.ClearItem("AnecdoteItemModel")
        UIScrollView.ClearItem("AnecdoteDungeonItem")
        local root = this.vm.behaviour.transform:Find("root")
        if GrandSonPanelShow ~= nil then
            GrandSonPanelShow:SetParent(root, false)
            this.InitBranchPropPosition()
            GrandSonPanelShow = nil
        end
        this = nil
    end,
}

this.InitPageType = function()
    if HeroParameter.panelType ~= nil then
        this.panelType = HeroParameter.panelType
    else
        if this.vm.behaviour.Params.Length ~= 0 then
            local param = this.vm.behaviour.Params[0]
            this.panelType = param
        end
    end
    if this.panelType == nil then
        this.panelType = this.panelEnum.branchArea
    end
    this.vm.data.BranchPageShow = this.panelType == this.panelEnum.branchArea
    if this.panelType == this.panelEnum.branchArea then
        RedMgr.Singleton:RegisterViewModel(UIName.BranchMissionViewModel)
        BackToBranch = (ComData.branchData.BattleGoto ~= nil or ComData.branchData.NorvelGoto ~= nil)
        this.vm.data.NovelBattleEventPos = Vector3(-500, 11, 0)

        this.UpdateDataView()
    else
        this.vm.behaviour:UpdateTopBar(this.panelType, this.ClosePanel)
        if this.panelType == this.panelEnum.branchprop then
            this.HeroBranchViewData()
        elseif this.panelType == this.panelEnum.branchAnecdote then
            this.vm.data.animatorName = "ani_ui_BranchMissionPanel_root"
            if HeroParameter.anecdoteIndex == nil then
                this.anecdoteIndex = 1
            else
                this.anecdoteIndex = HeroParameter.anecdoteIndex
                HeroParameter.anecdoteIndex = nil
            end
            this.AnecdoteViewData()
            this.SetItemChoose(this.anecdoteIndex)
        end
    end
    this.vm.data.rewardPopup = false
end

this.ViewAdaptive = function()
    local width = LuaMgr.GetScreenAddWidth()
    if width > 0 then
        this.vm.data.anecdotePost = Vector2(-200,100)
        this.vm.data.rewardPost = Vector2(-300,-191)
    else
        this.vm.data.anecdotePost = Vector2(-105,100)
        this.vm.data.rewardPost = Vector2(-212.5,-191)
    end
end

this.initSaveDataForRed = function()
    local Data
    local RedTable = UnityEngine.PlayerPrefs.GetString(
    DataMgr.Player.uid .. "BranchRedTab")
    if RedTable ~= nil and RedTable ~= "" then Data = json.decode(RedTable) end
    return Data
end


this.SetBranchRedShow = function(id)
    if this.RedDataTab[id] == nil then
        this.RedDataTab[id] = 0
    else
        return
    end
    this.BranchOpenOrCloseRed(1, 1)
    local Str = json.encode(this.RedDataTab)
    UnityEngine.PlayerPrefs.SetString(DataMgr.Player.uid .. "BranchRedTab", Str)
end


this.IntoBattlePanel = function(param)
    LuaMgr.SetAreaBattleType(BattleType.Branch)

    BattlePrepareMgr.EnterBattlePrepare(param, param, 3)
    ComData.branchData.pageindex = this.CurrenPageIndex
    ComData.branchData.pageIds = this.CurrentPages
    ComData.branchData.BattleGoto = true
    ComData.branchData.NorvelGoto = nil
    ComData.branchData.bookindex = this.SelectBranch
    this.vm.OpenProp = nil
end


this.UpdateDataView = function()
    this.vm.data.branchNovel = true
    this.vm.data.branchHero = false
    this.vm.data.branchAnecdote = false
    this.PlayerBranchData = DataMgr.Player.branch
    this.vm.data.closeDoubleClicks = false
    LuaMgr.RemoveUIEventListener(UIEventConst.NovelCompleteReward, this.LowNetRefushData)
    LuaMgr.AddUIEventListener(UIEventConst.NovelCompleteReward, this.LowNetRefushData)
    LuaMgr.RemoveUIEventListener(UIEventConst.TopBarHome, this.BackToHome)
    LuaMgr.AddUIEventListener(UIEventConst.TopBarHome, this.BackToHome)
    if NovelBattleId == nil then NovelBattleId = "" end
    if ComData.branchData.BattleGoto == nil and ComData.branchData.NorvelGoto == nil then
        this.vm.behaviour:UpdateTopBar(this.panelType, this.ClosePanel)
    else
        BranchMissionHelper.BranchRedDataTabInit("str")
    end
    this.RedShowData = ComData.branchData.NetredDataTab
    this.initPageState()
    this.initBranchBinding()
    if not BackToBranch then
        this.BranchOpenOrCloseRed(1, 1)
    end

    if ComData.branchData.BattleGoto ~= nil then
        this.AfteBattleNovel(false)
    end
    if ComData.branchData.NorvelGoto ~= nil then
        this.AfteBattleNovel(true)
    end
end

this.LowNetRefushData = function()
    this.PlayerBranchData = DataMgr.Player.branch
    this.initPageState()
    this.initBranchBinding()
    this.AfteBattleNovel(true)
end
this.ClosePanel = function()
    if this~=nil then
        this.ClearData()
    end
    if HeroParameter.activityGotoPanel ~= nil then
        LuaMgr.Back("Story1");
    else
        LuaMgr.Back()
    end
    HeroParameter.EmptyPanelType()
end


this.BackToHome = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.TopBarHome, this.BackToHome)
    this.ClearData()
end


this.clicksBooksToLeft = function() this.ClickPageStateShow(this.SelectBranch, -1) end

this.clicksBooksToRight = function() this.ClickPageStateShow(this.SelectBranch, 1) end


this.changeNovelSelect = function(param)
    OptionGropu = true
    if this.CurrentNovelGroup[param + 1].Lock then
        this.NovelSelectStateShow(this.CurrentNovelGroup[param + 1], param, false)
        return
    end

    if CurrentNovelSelect == param + 1 then
        
        return;
    end
    
    if ComData.branchData.novelIndex ~= nil then
        this.SeleNovel = this.vm.data.novelEvent[ComData.branchData.novelIndex]
        CurrentNovelSelect = ComData.branchData.novelIndex
        ComData.branchData.novelIndex = nil
    end
    CurrentNovelSelect = param + 1
    this.SeleNovel.ItemIcon = LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab02")
    this.SeleNovel.itemName = string.format("<color=#887a65>" .. this.SeleNovel.itemcfigName .. "</color>")
    this.SeleNovel = this.vm.data.novelEvent[param + 1]
    this.SeleNovel.ItemIcon = LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab01")
    this.SeleNovel.itemName = string.format("<color=#fff9ea>" .. this.SeleNovel.itemcfigName .. "</color>")
    this.CurrentNovel = this.CurrentNovelGroup[param + 1]
    this.NovelSelectStateShow(this.CurrentNovel, param, true)

    this.changeDataState(this.CurrentNovel)
    this.playChageStateAnimation(this.CurrentNovel)

end


this.initBranchBinding = function()
    for i = 1, #currentItem, 1 do
        this.vm.data["branchPos" .. tostring(i)] = BranchRunPos[i]
        local transform = this.vm.behaviour.transform:Find(
        "root/BranchNovel/BrancheGroupPropGroup/ChildProps" ..
        tostring(i) .. "/GrandSonPos")
        local Parent = {
            key = "branchListChild" .. tostring(i),
            transform = transform
        }
        table.insert(BranchTransformGroup, Parent)
    end
end

this.RefushBranchPosition = function(state, completeFuns)
    this.CompleteTween = 0
    local DontnotMoveIndex = state > 0 and #currentItem or 1
    for index, value in ipairs(currentItem) do
        local CurrentPos = index ~= DontnotMoveIndex and value.pos or
        Vector3(value.nextpos.x + (state * 520),
        value.nextpos.y, 0)
        local NextPos = value.nextpos
        value.tweener = function()
            local tweener = DOTWeen.To(function() return CurrentPos end,
            function(vector)
                this.vm.data["branchPos" .. tostring(value.index)] = vector
            end, NextPos, 0.5)
            tweener.onComplete = function()
                value.pos = NextPos
                this.CompleteTween = this.CompleteTween + 1
                if this.CompleteTween == #currentItem then
                    completeFuns()
                    this.CompleteTween = 0
                end
            end
        end
        value.tweener()
    end
end
this.PointerDown = function(eventData) this.startDragX = eventData.position.x end

this.OnPointerUp = function(eventData)


end
this.OnEndDrag = function(eventData)
    if this.offDistance >= this.distance then
        if this.DragePos > 0 then
            this.ClickPageStateShow(this.SelectBranch, -1)
        else
            this.ClickPageStateShow(this.SelectBranch, 1)
        end
    else
    end
end
this.OnDrag = function(eventData)
    this.DragePos = eventData.delta.x
    this.offDistance = math.abs(eventData.position.x - this.startDragX)

end
this.DragMove = function(deltaX)
    local cindex = 0
    if deltaX > 0 then
    elseif deltaX < 0 then
    end
end


this.PageScroll = function(index, count)




end

this.BookScroll = function(index, count)
    local Needindex = index - 1 <= 0 and 0 or index - 1
    local View = this.BookLayout:Find("Viewport"):GetComponent("RectTransform")
    this.HorizontalScrollToIndexPort(Needindex, count, this.BookLayout, View, 1)
end

this.BattleScroll = function(index, count)
    local Needindex = index - 1 <= 0 and 0 or index - 1
    local ConstanTranform = this.BattleLayOut:Find("Viewport/Content")
    local View = this.BattleLayOut:Find("Viewport"):GetComponent("RectTransform")
    this.VerticalScrollToIndexPort(Needindex, count, ConstanTranform, View, 2)
end


this.VerticalScrollToIndexPort = function(index, couns, constantTransform, view, states)
    local content = constantTransform:GetComponent("RectTransform")
    local GridLayoutGroup = constantTransform:GetComponent("GridLayoutGroup")
    local length = index *
    (GridLayoutGroup.cellSize.y + GridLayoutGroup.spacing.y)
    if index ~= 0 and index ~= couns then
        length = length - 0.5 *
        (GridLayoutGroup.cellSize.y + GridLayoutGroup.spacing.y)
    end
    local ViewProtH = couns *
    (GridLayoutGroup.cellSize.y +
    GridLayoutGroup.spacing.y) - view.sizeDelta.y
    if length > ViewProtH then length = ViewProtH end
    content.offsetMax = Vector2(0, length)
    content.offsetMin = Vector2(0, 0)
    coroutine_runner.start(function()
        coroutine_runner.wait(0.4)
        if states == 0 then

        elseif states == 2 then
            if this ~= nil then
                this.vm.data.contentBattlevertical = true
            end
        end
    end)
end


this.HorizontalScrollToIndexPort = function(index, couns, constantTransform, view, states)
    this.vm.data.contentBookHiroscroll = false
    local content = constantTransform:Find("Viewport/Content"):GetComponent("RectTransform")
    local ViewPort = constantTransform:Find("Viewport"):GetComponent("RectTransform")
    local GridLayoutGroup = constantTransform:Find("Viewport/Content"):GetComponent("GridLayoutGroup")
    local length = index * (GridLayoutGroup.cellSize.x + GridLayoutGroup.spacing.x)
    if index ~= 0 and index ~= couns then
        length = length - 0.5 * (GridLayoutGroup.cellSize.x + GridLayoutGroup.spacing.x)
    end
    local ViewProtH = couns * (GridLayoutGroup.cellSize.x + GridLayoutGroup.spacing.x) - (view.sizeDelta.x) - GridLayoutGroup.spacing.x
    local Realneed = ViewProtH - (LuaMgr.ScreenWidth() - 296)
    if length > Realneed then length = Realneed end
    content.offsetMax = Vector2(0, 0)
    content.offsetMin = Vector2(-length, 0)
    coroutine_runner.start(function()
        coroutine_runner.wait(0.2)
        if this ~= nil then
            this.vm.data.contentBookHiroscroll = true
        end
    end)
end

this.changeGropPointion = function(open, initPosgroup, changePosGroup,
completeFun, init)
    local function Comlpetefun()
        for index, value in ipairs(currentItem) do
            this.vm.data["branchPos" .. tostring(value.index)] = changePosGroup[index]
        end
    end
    if init and not PlayeBookEffect then
        this.vm.data.closeDoubleClicks = false
        Comlpetefun()
        return
    end
    this.CompleteTween = 0
    if not open then this.vm.data.closeDoubleClicks = true end
    for index, value in ipairs(currentItem) do
        value.tweener = function()
            local tweener = DOTWeen.To(
            function()
                return initPosgroup[index]
            end,
            function(vector)
                this.vm.data["branchPos" .. tostring(value.index)] = vector
            end,
            changePosGroup[index],
            0.35)
            if open then
                tweener:SetEase(Ease.InSine)
            else
                tweener:SetEase(Ease.OutSine)
            end
            tweener.onComplete = function()
                value.tweener = nil
                this.CompleteTween = this.CompleteTween + 1
                if this.CompleteTween == #currentItem then
                    this.CompleteTween = 0
                    completeFun()
                    if open then end
                end
            end
        end
        value.tweener()
    end
end


this.CloseAndOpenPage = function(open, funs, init)
    local OpenPose = Vector3(-500, 0, 0)
    local ClosePose = Vector3(0, 0, 0)
    local PosStar = open and OpenPose or ClosePose
    local PosEnd = open and ClosePose or OpenPose
    local battleBack = ComData.branchData.BattleGoto ~= nil or
    ComData.branchData.NorvelGoto ~= nil
    if battleBack then
        if not PlayeBookEffect then
            this.vm.data.closeDoubleClicks = false
        end
        this.vm.data.NovelBattleEventPos = PosEnd
        ComData.branchData.BattleGoto = nil
        ComData.branchData.NorvelGoto = nil
        return
    end
    local tweener = DOTWeen.To(function() return PosStar end, function(vector)
        this.vm.data.NovelBattleEventPos = vector
    end, PosEnd, 0.35)
    if open then
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/branch_close.mp3")
        tweener:SetEase(Ease.InSine)
    else
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/branch_next.mp3")
        tweener:SetEase(Ease.OutSine)
    end
    tweener.onComplete = function()
        if funs ~= nil then
            funs()
        end
    end
end




this.clockToLeftOrRight = function(state, needindex, amxIndx)
    local Thetotle
    local ItemNames
    local Soldnum = needindex - 3
    if state < 0 then
        local n = #currentItem
        local last = currentItem[n]
        for i = n, 2, -1 do currentItem[i] = currentItem[i - 1] end
        currentItem[1] = last
    else
        local n = #currentItem
        local first = currentItem[1]
        for i = 1, n, 1 do currentItem[i] = currentItem[i + 1] end
        currentItem[n] = first
    end
    for index, value in ipairs(currentItem) do
        value.nextpos = BranchRunPos[index]
        value.dataid = (index + Soldnum >= 0 and index + Soldnum <= amxIndx) and
        index + Soldnum or 0
    end
    if state > 0 then
        Thetotle =        (5 + Soldnum >= 0 and 5 + Soldnum <= amxIndx) and 5 + Soldnum or 0
        currentItem[5].dataid = Thetotle
        ItemNames = currentItem[5].itemName
    else
        Thetotle =        (1 + Soldnum >= 0 and 1 + Soldnum <= amxIndx) and 1 + Soldnum or 0
        currentItem[1].dataid = Thetotle
        ItemNames = currentItem[1].itemName
    end
    return ItemNames, Thetotle
end


this.InitBranchPropPosition = function()
    table.sort(currentItem,
    function(a, b) return tonumber(a.index) < tonumber(b.index) end)
    for index, value in ipairs(currentItem) do
        value.pos = BranchRunPos[index]
        this.vm.data["branchPos" .. tostring(index)] = BranchRunPos[index]
    end
end

this.ClearData = function()
    if backtocortuine ~= nil then
        coroutine_runner.stop(backtocortuine);
        backtocortuine = nil
    end
    this.vm.OpenProp = nil
    this.vm.data.BranchRewardGroups = true
    this.vm.data.BranchHeroObject = this.GetBranchSwitch("Reg1001")
    this.vm.data.BranchAnecdoteObject = this.GetBranchSwitch("Reg2001")
    this.vm.data.BranchePropShow = false
    this.branchNovelBg.anchoredPosition = Vector2(904,0)
    this.leftBg.anchoredPosition = Vector2(42,0)
    this.vm.data.BranchPageShow = true
    ComData.branchData.novelIndex = nil
    ComData.branchData.NorvelGoto = nil
    ComData.branchData.BattleGoto = nil
    ComData.branchData.novelParam = nil
    CurrentNovelSelect = nil
    ComData.branchData.bookindex = nil
    ComData.branchData.pageindex = nil
    ComData.branchData.pageIds = nil
    ComData.branchData.novelEvent = nil
    this.SelectPageListIndex = nil
end

this.GotoAreaEvent = function()
    this.ClearData()
    LuaMgr.Back()
end

this.CloseProps = function()
    if ComData.branchData.BattleGoto == nil and ComData.branchData.NorvelGoto == nil then
        this.vm.behaviour:UpdateTopBar("branchArea", this.ClosePanel)
    else
        this.vm.behaviour:UpdateTopBar("", this.GotoAreaEvent)
    end
    if this.showOtherPropEvent then
        LuaMgr.NextFrame(function()
            LuaMgr.HidePanel(UIName.BranchMissionEvent3ViewModel)
        end)
    end
    AudioMgr.Singleton:StopVoice()
    PlayeBookEffect = false
    PlayeBookEffectIndex = nil
    this.CloseBookRewardGroup()
    this.InitBranchPropPosition()
    this.ClickPageStateShow(this.SelectBranch, 0)
    if not this.vm.data.BranchPageShow then end
    BackToBranch = false
    this.initPageState()
    this.BranchViewData()
    this.vm.data.BranchRewardGroups = true
    this.vm.data.BranchHeroObject = this.GetBranchSwitch("Reg1001")
    this.vm.data.BranchAnecdoteObject = this.GetBranchSwitch("Reg2001")
    CurrentNovelSelect = nil
    this.SelectBranch = nil
    CurrentSelectNovel = nil
    this.vm.data.BranchPageShow = true
    this.vm.data.BranchBattleEventShow = false
    this.vm.data.BranchNovelEventshow = false
    this.vm.OpenProp = nil
    this.vm.data.BranchePropShow = false
    this.branchNovelBg.anchoredPosition = Vector2(904,0)
    this.leftBg.anchoredPosition = Vector2(42,0)
    this.vm.data.BranchMainShow = true
    if backtocortuine ~= nil then
        coroutine_runner.stop(backtocortuine);
        backtocortuine = nil
    end
    coroutine_runner.start(function()
        coroutine_runner.waitForEndOfFrame()
        if this ~= nil then
            this.PlayBookAnimation()
        end
    end)
    if this.battlBackToBranch ~= nil then
        coroutine_runner.stop(this.battlBackToBranch)
        this.battlBackToBranch = nil
    end
    ComData.branchData.novelIndex = nil
    ComData.branchData.NorvelGoto = nil
    ComData.branchData.BattleGoto = nil
    ComData.branchData.novelParam = nil
end

this.AfteBattleNovel = function(state)
    this.CurrentPages = ComData.branchData.pageIds
    this.vm.data.BranchPageShow = false
    this.vm.data.BranchMainShow = false
    this.SelectBranch = ComData.branchData.bookindex

    if PlayeBookEffect then
        if backtocortuine ~= nil then
            coroutine_runner.stop(backtocortuine)
        end
        backtocortuine = coroutine_runner.start(function()
            PlayeBookPropEffect = true
            this.vm.data.closeDoubleClicks = true
            this.ClickPageStateShow(this.SelectBranch, 0)
            this.BranchEffectNet(this.vm.data.branchListChild4[1].itemId)
            coroutine_runner.wait(1.5)
            backtocortuine = nil
            if this.vm.data.BranchePropShow then
                ComData.branchData.NorvelGoto = nil
                ComData.branchData.BattleGoto = nil
                this.clicksBooksToRight()
            end
        end)
    else
        this.ClickPageStateShow(this.SelectBranch, 0)
    end
    if state then this.getNovelSeeReward() end
end

this.SelectPageItems = function(index, Click)
    if this.vm.data.PageList[index].LockPage then
        local tabLocak = {}
        local tab = this.vm.data.PageList[index].Locktype
        local tabID = this.vm.data.PageList[index].lockId
        tabLocak.type = tab
        tabLocak.ID = tabID
        local before = this.vm.data.PageList[index].before
        this.CheckAllLockState(tabLocak, ConfigMgr.Config.branchChapterList, before)
        return
    else
        local SelectId = this.vm.data.PageList[index].itemId



        for datakey, datavalue in pairs(this.PlayerBranchData.children) do
            if SelectId == datakey then
                CurrrentSelectPageChild = datavalue.children
            end
        end
        this.vm.data.PageList[PageIndex].UnSelect = true
        this.vm.data.PageList[PageIndex].select = false

this.vm.data.PageList[PageIndex].itemNameShow = this.vm.data.PageList[PageIndex].itemName
        this.CurrentPages = this.vm.data.PageList[index].itemId
        this.CurrenPageIndex = index
        this.SelectPageListIndex = index
        if Click == nil then
            if ComData.branchData.pageIds ~= nil and ComData.branchData.pageindex ~= nil then
                this.CurrenPageIndex = ComData.branchData.pageindex
                this.CurrentPages = ComData.branchData.pageIds
            end
        end
        PageIndex = index
        this.vm.data.PageList[PageIndex].UnSelect = false
        this.vm.data.PageList[PageIndex].select = true

this.vm.data.PageList[PageIndex].itemNameShow = this.vm.data.PageList[PageIndex].itemName
        this.BranchViewData()
        RedMgr.Singleton:Refresh()
    end

    this.vm.data.BranchMainShow = true
    coroutine_runner.start(function()
        coroutine_runner.waitForEndOfFrame()
        if this ~= nil then
            this.PlayBookAnimation()
        end
    end)
end

this.AfterBattleRefush = function()
    this.CurrentPages = ComData.branchData.pageindex
    this.BranchViewData()
end


this.BranchEffectNet = function(ids, fun)
    local netID = tostring(ids)
    if this.requestId ~= nil and this.requestId == ids then
        return
    end
    this.requestId = ids
    local data = {}
    data.ID = netID
    ApiMgr.Request("save_animation_record", data, true, function(result)
        local re = json.decode(result)
        if fun ~= nil then fun() end
    end, nil, true)
end

this.getNovelSeeReward = function()
    this.InitNovelListShow()
end


this.BranchRewardItemClicks = function(UseNum)
    selectBranchRewardIndex = {}
    local Lengths = #this.vm.data.BranchRewardList
    local BookItemlist = this.vm.data.BranchRewardList
    local function Achieves()
        for i = 1, #selectBranchRewardIndex do
            BookItemlist[selectBranchRewardIndex[i]].currentget = false
            BookItemlist[selectBranchRewardIndex[i]].alreadyget = true
            BookItemlist[selectBranchRewardIndex[i]].bgScale = Vector3(0.85,0.85,0.85)









        end

        selectBranchRewardIndex = {}
    end
    if BookItemlist[UseNum].currentget then
        local idList = {}
        for i = 1, #BookItemlist do
            if BookItemlist[i].currentget then
                table.insert(idList,BookItemlist[i].itemId)
                table.insert(selectBranchRewardIndex,i)
            end
        end

        this.NetBranchBookReward(idList, Achieves)
    else
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,this.vm.data.BranchRewardList[UseNum].rewardId,false,false,false)







    end

end

this.NetBranchBookReward = function(storyIDList, fun)
    local tempData = {}

    tempData.Stories = storyIDList
    ApiMgr.Request("branch/get_rewards", tempData, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            if this.panelType == this.panelEnum.branchArea then
                this.PlayerBranchData = DataMgr.Player.branch
                this.BranchRewardRedShow()
            end
            local resultData = json.encode(re.result)
            LuaMgr.ShowItemRewared(resultData)
            fun()
        end
    end, nil, true)
end


this.BranchRewardRedShow = function()
    local tabis = nil
    for i = 1, #selectBranchRewardIndex do
        tabis = this.vm.data.BranchRewardList[selectBranchRewardIndex[i]].itemId .. "_reward"
        this.SetBranchRedShow(tabis)
    end
end


this.ShowBookRewardGroup = function(index, rewardtab, leng)
    this.vm.data.RewardListGroupsBgScale =    (index >= leng) and Vector3(-1, 1, 1) or Vector3(1, 1, 1)
    local parentsPot = (index >= leng) and "RewardParent" or "LastRewardParent"
    local PropParen = this.vm.data.BranchePropShow and "BrancheGroupPropGroup/BranchRewardGroups" or "BranchRewardGroups"
    local ParendShow = this.vm.behaviour.transform:Find(
    "root/BranchNovel/" .. PropParen .. "/BranchRewardScroll/Viewport/Constant/" ..
    tostring(index) .. "/BranchStateGroup/" ..
    parentsPot)
    BookRewardList:SetParent(ParendShow, false)
    this.vm.data.RewardListGroups = true
    this.ItemViewData(json.decode(rewardtab), true)
    BookRewardList.gameObject:SetActive(true)
end

this.CloseBookRewardGroup = function()
    local ParendShow = this.vm.behaviour.transform:Find("root")
    this.vm.data.RewardListGroups = false
    this.vm.data.RewardListGroupsBgScale = Vector3(-1, 1, 1)
    BookRewardList:SetParent(ParendShow, false)
    BookRewardList.gameObject:SetActive(false)
end

this.ClickPageStateShow = function(index, other)
    if index + other <= 0 or index <= 0 or index + other >
    (#this.vm.data.branchList) then return end

    local UseNum = index + other

    if this.vm.data.branchList[UseNum].Lock then
        local tabLocak = {}
        local tab = this.vm.data.branchList[UseNum].lockType
        local tabID = this.vm.data.branchList[UseNum].localId
        tabLocak.type = tab
        tabLocak.ID = tabID
        local before = this.vm.data.branchList[UseNum].before
        local Beforestate, messageBefore, locks, locksmsg = this.CheckAllLockState(tabLocak, ConfigMgr.Config.branchStoryList, before, true)
        messageBefore = messageBefore ~= nil and messageBefore or ""
        locksmsg = locksmsg ~= nil and locksmsg or ""
        local ShowTiptab = {}
        if Beforestate ~= nil then
            local tab1 = { state = Beforestate, value = messageBefore, jumpid = nil }
            table.insert(ShowTiptab, tab1)
        end
        if locksmsg ~= nil and locksmsg ~= "" then
            local tab2 = { state = locks, value = locksmsg, jumpid = tabID }
            table.insert(ShowTiptab, tab2)
        end
        ComData.branchData.BooKLockCondition = ShowTiptab
        LuaMgr.ShowLuaPanel(UIName.BranchMissionTipViewModel)
        return
    else

        this.SelectBranch = UseNum
        CurrentNovelSelect = nil
        if this.vm.data.branchList[UseNum].itemType == BranchEventType.Battle or this.vm.data.branchList[UseNum].itemType == BranchEventType.Weapon then
            local redshowBranchId = this.vm.data.branchList[UseNum].itemId
            this.SetBranchRedShow(redshowBranchId)
        end
        this.vm.data.BranchRewardGroups = false
        this.vm.data.BranchHeroObject = false
        this.vm.data.BranchAnecdoteObject = false
        this.ClickBranchItems(UseNum, other)
    end
end

this.BattleStartShow = function(tab)
    local battle = {}
    if tab.OpiniontId1 ~= nil and tab.OpiniontId1 ~= "" then
        local storyItem1 = {}
        storyItem1.type = tab.Opiniontype1
        storyItem1.ID = tab.OpiniontId1
        table.insert(battle, storyItem1)
    end
    if tab.OpiniontId2 ~= nil and tab.OpiniontId2 ~= "" then
        local storyItem2 = {}
        storyItem2.type = tab.Opiniontype2
        storyItem2.ID = tab.OpiniontId2
        table.insert(battle, storyItem2)
    end
    if #battle == 0 then
        OptionGropu = false
        local BeforBattleId = ""
        for cfgkey, cfgvalue in pairs(ConfigMgr.Config.branchEventList) do
            if tab.before == cfgvalue.ID then
                BeforBattleId = cfgvalue.param
            end
        end
        OptionGropuTips = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2104"].NameLan), LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[BeforBattleId].NameLan))
    else
        for key, value in pairs(battle) do
            local a, b = this.checkUnlock(value)
            if not a then
                OptionGropu = false
                OptionGropuTips = b
            end
        end
    end
end

this.NovelSelectStateShow = function(tab, index, state)
    if tab.Lock and index >= 1 then
        if not this.CurrentNovelGroup[index].completed then
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",
            string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2104"].NameLan),
            LuaMgr.GetLangText(ConfigMgr.Config.narrativeMap[this.CurrentNovelGroup[index].param].nameLan)))
        end
        return
    end
    local story = {}
    if tab.novOpiniontId1 ~= nil and tab.novOpiniontId1 ~= "" then
        local storyItem1 = {}
        storyItem1.type = tab.novOpiniontype1
        storyItem1.ID = tab.novOpiniontId1
        table.insert(story, storyItem1)
    end
    if tab.novOpiniontId2 ~= nil and tab.novOpiniontId2 ~= "" then
        local storyItem2 = {}
        storyItem2.type = tab.novOpiniontype2
        storyItem2.ID = tab.novOpiniontId2
        table.insert(story, storyItem2)
    end
    local Groups = this.LockStoryStateShow(story, state)
    if state then
        this.novelLock = true
        for index, value in ipairs(Groups) do
            if not value then this.novelLock = false end
        end
    end
end

this.CheckAllLockState = function(optiontab, datatab, selectId, needshowmessage)
    local function funcmanth(datatab)
        for key, value in pairs(datatab) do
            if value.ID == selectId then
                local Message = value.namelan == nil and value.nameLan or value.namelan
                local res = string.gsub(LuaMgr.GetLangText(Message), "\n", "")
                if needshowmessage == nil then
                    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", LuaMgr.GetLangText("BranchMissionViewModel_0") .. res)
                else
                    local beforestate = CurrrentSelectPageChild[selectId] ~= nil and CurrrentSelectPageChild[selectId].completed or false
                    return beforestate, res
                end
            end
        end
    end
    if optiontab.ID == "" or optiontab == nil then
        local state, msg = funcmanth(datatab)
        if needshowmessage then return state, msg, nil, nil end
    else
        local a, b = this.checkUnlock(optiontab, needshowmessage)




        if needshowmessage then
            local state, msg = funcmanth(datatab)
            return state, msg, a, b
        end
        if a then funcmanth(datatab) end

    end
end

this.checkGrandChilddata = function(tab)
    local parame = {}
    for key, value in ipairs(tab) do
        for cfgkey, cfgvalue in pairs(ConfigMgr.Config.branchEventList) do
            if value == cfgvalue.ID then
                local battle = { id = cfgvalue.param, type = cfgvalue.type }
                table.insert(parame, battle)
            end
        end
    end
    local Clear = true
    local Complete = true
    for key, value in ipairs(parame) do
        local a, b, c = BranchMissionHelper.BattleResultShow(value.id, value.type)
        if not a then
            Clear = false
            Complete = false
        elseif not b then
            Complete = false
        end
    end
    return Clear, Complete
end

this.checkChildSondata = function(tab)
    local parame = {}
    for key, value in ipairs(tab) do
        for cfgkey, cfgvalue in pairs(ConfigMgr.Config.branchEventList) do
            if value == cfgvalue.ID then
                local battle = { id = cfgvalue.param, type = cfgvalue.type }
                table.insert(parame, battle)
            end
        end
    end
    local Clear = true
    local Complete = true
    for key, value in ipairs(parame) do
        local a, b, c = BranchMissionHelper.BattleResultShow(value.id, value.type)
        if not a then
            Clear = false
            Complete = false
        elseif not b then
            Complete = false
        end
    end
    return Clear, Complete
end

this.initPageState = function()
    local tempList = {}
    local CompletedPage = 0
    local SavesPageIndex = 0
    local effectIdsindes = nil
    for key, value in ipairs(ConfigMgr.Config.branchChapterList) do

        if value.uiType ~= 0 then
            goto continue
        end
        local isBanned = FeatureManager.UnifyVerControls("branchChapter",value.ID)
        if not isBanned then
            goto continue
        end
        local LocalState = true
        local ShowStates = true
        local netCompleted = false
        local ChildData = {}
        local GrandChildData = {}
        for datakey, datavalue in pairs(this.PlayerBranchData.children) do
            if datakey == value.ID then
                LocalState = not datavalue.unlocked
                ChildData = datavalue.children
                netCompleted = datavalue.completed
                if datavalue.unlocked and not netCompleted then
                    if DataMgr.Player.animationRecords[value.ID] == nil then
                        effectIdsindes = key > 1 and value.ID or nil
                    end
                end
                if not LocalState then
                    for childkey, childvalue in pairs(ChildData) do
                        if not childvalue.unlocked then
                            ShowStates = false
                            break
                        end
                        for gridechildren, gridechildrenvalue in pairs(childvalue.children) do
                            if not gridechildrenvalue.unlocked then
                                ShowStates = false
                                break
                            end
                            table.insert(GrandChildData, gridechildrenvalue.id)
                        end
                    end
                end
            end
        end
        local Pagestates = false
        local Textture = ""
        local Completeed = false
        local Cleared = false
        if ShowStates then
            local Clear, ComPlete = this.checkGrandChilddata(GrandChildData)
            Completeed = ComPlete
            Cleared = Clear
            if not Clear and not ComPlete then
                Pagestates = false
            elseif not ComPlete and Clear then
                Pagestates = true
            elseif ComPlete and Clear then
                Pagestates = true
            end
        end
        local Sunstring = string.sub(value.ID, -1)
        local Branchs = {}
        local Unlock = {}
        local Type = value.UnlockConditions[1].UnlockType
        local ElementID = value.UnlockConditions[1].ElementID
        table.insert(Unlock, { type = Type, ID = ElementID })
        local Color = LocalState and this.TextColor5 or this.TextColor2
        if ComData.branchData.pageIds ~= nil then
            if ComData.branchData.pageIds == value.ID then
                SavesPageIndex = key
            end
        end
        Branchs = {
            itemId = value.ID,
            select = false,
            UnSelect = not LocalState,
            Lock = LocalState,
            showUnlockEffect = (effectIdsindes == value.ID and key > 1),
            LockShow = (effectIdsindes == value.ID and key > 1) or LocalState,
            completeShow = not LocalState and Completeed,
            clearShow = not LocalState and not Completeed and Cleared,
            itemIndex = "0" .. tostring(key),

            itemName = LuaMgr.GetLangText(value.nameLan),
itemNameShow = LuaMgr.GetLangText(value.nameLan),
            PageState = LocalState or Pagestates,
            LockPage = LocalState,
            PageSprite = LocalState and
            LuaMgr.GetSprite("BranchMission", "ui_zx_icon02") or
            LuaMgr.GetSprite("BranchMission", "ui_zx_icon01"),
            StateText = Textture,
            Locktype = Type,
            lockId = ElementID,
            before = value.before,
            PlayerChildData = ChildData,
            LockAnimation = not (LocalState or Pagestates),
            Pagered = "1081" .. "_" .. value.ID
        }
        table.insert(tempList, Branchs)
        ::continue::
    end
    this.vm.data.PageList = tempList
    local canComplete = nil
    for index, value in ipairs(tempList) do
        if effectIdsindes ~= nil then
            if value.itemId == effectIdsindes and index <= 1 then
                CompletedPage = index - 1
                canComplete = index
            else
                CompletedPage = 0
                canComplete = 1
            end
        else
            if not (value.Lock) and (value.completeShow or value.clearShow) then
                CompletedPage = CompletedPage + 1
            elseif not (value.Lock) and (not value.completeShow or not value.clearShow) then
                canComplete = index
            end







        end
    end

    if ComData.branchData.pageIds == nil then
        CompletedPage = canComplete ~= nil and canComplete or (CompletedPage == 0 and 1 or CompletedPage)
        local realNeedIndex = 0
        if this.SelectPageListIndex ~= nil then
            local Complete = this.PlayerBranchData.children[tempList[this.SelectPageListIndex].itemId].completed
            PageIndex = Complete and this.SelectPageListIndex or CompletedPage
        else
            PageIndex = CompletedPage
        end
        this.SelectPageItems(PageIndex)
        this.PageScroll(PageIndex, #tempList)
    else
        PageIndex = SavesPageIndex
        this.SelectPageItems(SavesPageIndex)
        this.PageScroll(SavesPageIndex, #tempList)
    end
    if effectIdsindes ~= nil and not BackToBranch then
        this.BranchEffectNet(effectIdsindes)
    end
end

this.CliskEnterMain = function(index)
    for key, value in pairs(ConfigMgr.Config.branchChapterList) do
        local Sunstring = LuaMgr.Substring(value.ID, 6)
    end
end

this.BranchViewData = function()
    local tempList = {}
    local RewardTemplist = {}
    local Index = 0
    local locksatet = true
    local EffectIds = 0

    this.CunrrenshowBook = 1
    local CompletedBooks = 0
    this.StageGroup = {}
    for key, value in pairs(ConfigMgr.Config.branchStoryList) do
        local ChildDta = {}
        local totolNumnum = 0
        local Completenum = 0
        local ShowState = true

        for eventkey, Eventvalue in pairs(ConfigMgr.Config.branchEventList) do
            if value.ID == Eventvalue.storyID then
                totolNumnum = totolNumnum + 1
            end
        end
        for playerkey, Playervalue in pairs(CurrrentSelectPageChild) do
            if playerkey == value.ID then
                locksatet = not Playervalue.unlocked
                if not locksatet then
                    for childKey, childvalue in pairs(Playervalue.children) do
                        if not childvalue.unlocked then
                            ShowState = false
                        end
                        table.insert(ChildDta, childvalue.id)
                        if childvalue.completed then
                            Completenum = Completenum + 1
                        end
                    end
                end
            end
        end
        local Clear = nil
        local Complete = nil
        local Pagestates = false
        local Textture = ""
        if ShowState then
            if #ChildDta ~= 0 then
                Clear, Complete = BranchMissionHelper.checkChildSondata(ChildDta)
            end
            if not Clear and not Complete then
                Pagestates = false
            elseif not Complete and Clear then
                Pagestates = true
                Textture = "ui_zx_bq_tg"
            elseif Complete and Clear then
                Pagestates = true
                Textture = "ui_zx_bq_wm"
            end
        end
        if value.chapterID == this.CurrentPages then
            Index = Index + 1
            local Branchs = {}
            local BranchsBookReward = {}
            local Type = value.UnlockConditions[1].UnlockType
            local ElementID = value.UnlockConditions[1].ElementID
            local itemNames = LuaMgr.GetLangText(value.namelan)
            local findeindex = tostring(Index)
            local UILockshow

            local LockPageShow
            if not locksatet then
                if DataMgr.Player.animationRecords[value.ID] == nil and Index > 1 then
                    LockPageShow = true
                    PlayeBookEffect = true
                    PlayeBookEffectIndex = Index
                    EffectIds = value.ID
                end
            else
                LockPageShow = locksatet
            end
            local Effectshow = false
            if PlayeBookEffectIndex ~= nil and Index == PlayeBookEffectIndex and
            not BackToBranch then
                Effectshow = Index > 1
                UILockshow = false
            else
                Effectshow = false
                UILockshow = locksatet
            end
            if (Index == 1) then LockPageShow = false end

            if BackToBranch then LockPageShow = locksatet end

            local TltlePos = (LockPageShow and LockPageShow) and
            Vector3(40.9, -197) or Vector3(-24.4, -197)
            Branchs = {
                itemId = value.ID,
                completed = CurrrentSelectPageChild[value.ID] ~= nil and
                CurrrentSelectPageChild[value.ID].completed or false,
                itemStateNum = "",
                findIndex = findeindex,
                itemName = itemNames,
                itemType = value.type,
                itempages = LuaMgr.GetLangText(value.subtitleLan),
                Lock = locksatet,
                chapterID = value.chapterID,
                LockShowPage = UILockshow,
                HeroIconShow = not LockPageShow,

                slidervalue = Completenum / totolNumnum,
                needCompletenums = Completenum,
                needtotolenums = totolNumnum,
                UnLock = not LockPageShow,
                selsect = false,
                Showeffect = LockPageShow,
                titleshow = not locksatet,
                unselsect = true,
                uiEffectShow = Effectshow,
                pages = this.PageIconPath .. value.page .. ".png",
                ItemIcon = LuaMgr.GetTexture(
                this.PageIconPath .. value.page .. ".png"),
                ItemCircleIcon = LuaMgr.GetTexture(
                this.PageIconPath .. value.page .. "_p.png"),
                LocksIcon = LuaMgr.GetTexture(this.PageIconPath ..
                "branch_Bok1000.png"),
                stateIcon = LuaMgr.GetSprite("BranchMission", Textture),
                Rareindex = Index,
                Itemactive = false,
                stateshow = not locksatet and Pagestates,
                lockType = Type,
                before = value.before,
                localId = ElementID,
                circleLocalPos = Vector3(134.3, 0, 0),
                uidislove = 0,
                TitlePos = TltlePos,
                showAnimation = true,
                AnimationName = BackToBranch and
                "ani_ui_BrancheNewSelectItem_004" or
                "ani_ui_BrancheNewSelectItem_002",
                redPoint = "1082" .. "_" .. value.ID
            }
            local NetDatavalue = CurrrentSelectPageChild[value.ID] ~= nil and
            CurrrentSelectPageChild[value.ID].received or false
local Iconlock = ConfigHelper.GetItemTexture(value.reward[1].id)
            BranchsBookReward = {
                itemId = value.ID,
                completed = Branchs.completed,
                Lock = Branchs.locksatet,
                condition = value.condition,
                bookname = Branchs.itemName,
                alreadyget = NetDatavalue,
                notget = not Branchs.completed,
                Name = findeindex,
                rewards = json.encode(value.reward),
                rewardId = value.reward[1].id,
                rewardType = value.type,
                currentget = (Branchs.completed and not NetDatavalue) and (value.condition == 1 and Clear or Complete),
                lockicon = Iconlock,
cangetState = Iconlock,
alradyGetState = Iconlock,
                redId = "1083" .. "_" .. value.ID,
                countText = tostring(value.reward[1].count),
                bgScale = NetDatavalue and Vector3(0.85,0.85,0.85) or Vector3.one
            }
            table.insert(RewardTemplist, BranchsBookReward)
            table.insert(this.StageGroup, Branchs)
            table.insert(tempList, Branchs)
        end
    end

    this.vm.data.branchList = tempList
    this.vm.data.BranchRewardList = RewardTemplist
    local CompleteBookNum = 0
    local bookRewardSlider = 0
    local showTotolnums = 0
    local showCompletenums = 0
    for index, value in ipairs(tempList) do
        showTotolnums = showTotolnums + value.needtotolenums
        showCompletenums = showCompletenums + value.needCompletenums
        CompleteBookNum = CompleteBookNum + (value.completed and 1 or 0)
        bookRewardSlider = bookRewardSlider + (tonumber(value.slidervalue) / #tempList)
        this.vm.data.RewardListSliderValue = bookRewardSlider

        if not value.Lock and not value.completed then
            this.CunrrenshowBook = index
            Currentbranch = PlayeBookEffect and nil or index
        elseif not value.Lock and value.completed then
            CompletedBooks = CompletedBooks + 1
        end
    end
    this.vm.data.CompleteBookTag = tostring(showCompletenums).."/"..tostring(showTotolnums)




    this.CunrrenshowBook = CompletedBooks == #tempList and CompletedBooks or this.CunrrenshowBook
    Currentbranch = CompletedBooks == #tempList and CompletedBooks or this.CunrrenshowBook
    this.BookScroll(this.CunrrenshowBook, #tempList)

    if PlayeBookEffect and not BackToBranch then
        if PlayeBookEffectIndex == 1 then
            return
        end
        this.showBooksEffect(PlayeBookEffectIndex, EffectIds)
    elseif not BackToBranch then
        local completes = this.PlayerBranchData.children[tempList[this.CunrrenshowBook].chapterID].completed
        this.PlayCircleAnimation(this.CunrrenshowBook, completes)
    end
end


this.HeroBranchViewData = function()
    this.vm.data.branchNovel = false
    this.vm.data.branchHero = true
    this.vm.data.branchAnecdote = false

    this.heroScrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil

    local timestamp = LuaMgr.Timestamp()
    local tempData,time,timeBool = nil,nil,nil
    for i = 1, #ConfigMgr.Config.branchStoryList do
        if ConfigMgr.Config.branchStoryList[i].chapterID == "Reg1001" then
            tempData = ConfigMgr.Config.branchStoryList[i]
            time = tempData.UnlockConditions[1].ElementID == "" and 0 or tonumber(tempData.UnlockConditions[1].ElementID)
            timeBool = time <= timestamp
            if (tempData.UnlockConditions[1].UnlockType == 4 or
                    tempData.UnlockConditions[1].UnlockType == 0) and timeBool then
                groupData = {}
                groupData.index = i
                groupData.data = ConfigMgr.Config.branchStoryList[i]
                scrollData = UIScrollData.GetData(this.heroTemplate,"BranchHeroItemModel",310 + 25,475,groupData)
                table.insert(scrollDatas,scrollData)
            end
        end
    end
    local width = 1125 + LuaMgr.GetScreenAddWidth() + LuaMgr.ScreenOffSet()
    this.heroScrollView:SetParams(width,720)
    this.heroScrollView:SetPadding(10,73,0,0)
    this.heroScrollView:SetData(scrollDatas, HeroParameter.branchHeroItemClick == nil)
end

this.AnecdoteViewData = function()
    this.vm.data.branchNovel = false
    this.vm.data.branchHero = false
    this.vm.data.branchAnecdote = true

    this.anecdoteScrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    
    local timestamp = LuaMgr.Timestamp()
    local tempData,time,timeBool = nil,nil,nil
    local index = 1
    local playerData = nil
    this.anecdoteList = {}
    for i = 1, #ConfigMgr.Config.branchStoryList do
        if ConfigMgr.Config.branchStoryList[i].chapterID == "Reg2001" then
            tempData = ConfigMgr.Config.branchStoryList[i]
            time = tempData.UnlockConditions[1].ElementID == "" and 0 or tonumber(tempData.UnlockConditions[1].ElementID)
            timeBool = time <= timestamp
            if (tempData.UnlockConditions[1].UnlockType == 4 or 
                    tempData.UnlockConditions[1].UnlockType == 0 or 
                    tempData.UnlockConditions[1].UnlockType == 1) and timeBool then
                playerData = DataMgr.Player.branch.children["Reg2001"].children[tempData.ID]
                groupData = {}
                table.insert(this.anecdoteList,tempData)
                groupData.index = index
                groupData.unlocked = playerData.unlocked
                groupData.dungeonstate = this.GetDungeonStatus(tempData.ID)
                groupData.data = tempData
                groupData.select = false
                groupData.red = false
                for key,value in pairs(playerData.children) do
                    if value.completed and not value.received then
                        groupData.red = true
                        break
                    end
                end
                scrollData = UIScrollData.GetData(this.anecdoteTemplate,"AnecdoteItemModel",214,122 + 1,groupData)
                table.insert(scrollDatas,scrollData)
                index = index + 1
            end
        end
    end
    this.anecdoteScrollView:SetParams(237,720)
    this.anecdoteScrollView:SetPadding(0,0,-97,0)
    this.anecdoteScrollView:SetData(scrollDatas, HeroParameter.branchHeroItemClick == nil)
end

this.GetBranchSwitch = function(chapterID)
    local timestamp = LuaMgr.Timestamp()
    local tempData = nil
    local time = nil
    for i = 1, #ConfigMgr.Config.branchStoryList do
        if ConfigMgr.Config.branchStoryList[i].chapterID == chapterID then
            tempData = ConfigMgr.Config.branchStoryList[i]
            time = tempData.UnlockConditions[1].ElementID == "" and 0 or tonumber(tempData.UnlockConditions[1].ElementID)
            timeBool = time <= timestamp
            if (tempData.UnlockConditions[1].UnlockType == 4 or tempData.UnlockConditions[1].UnlockType == 0) and timeBool then
                return true
            end
        end
    end
    return false
end


this.GetHeroBranchBar = function(storyKey)
    local bar = 0
    local tempData = DataMgr.Player.branch.children["Reg1001"].children[storyKey].children
    for key,value in pairs(tempData) do
        for i = 1, #ConfigMgr.Config.branchEventList do
            if ConfigMgr.Config.branchEventList[i].ID == key and 
                    ConfigMgr.Config.branchEventList[i].type == "1" then
                if value.completed then bar = bar + 1 end
            end
        end
    end
    return bar
end



this.GetDungeonStatus = function(storyID)
    if IsNullOrEmpty(storyID) then return end
    local tempList = {}
    for i = 1, #ConfigMgr.Config.branchEventList do
        if ConfigMgr.Config.branchEventList[i].storyID == storyID then
            table.insert(tempList,ConfigMgr.Config.branchEventList[i])
        end
    end
    this.dungeonStateList[storyID] = {}
    local dungeonData = nil
    local challengeCount = nil
    local completeCount = nil
    local tempData = nil
    for i = 1, #tempList do
        if tempList[i].type == "1" then

            local isNovel = DataMgr.Player.branch.children["Reg2001"].children[storyID].children[tempList[i].ID].completed
            if isNovel then
                tempData = {id = tempList[i].ID,before = tempList[i].before,param = tempList[i].param,state = 1,type = tempList[i].type} 
            else
                tempData = {id = tempList[i].ID,before = tempList[i].before,param = tempList[i].param,state = 3,type = tempList[i].type}
            end
        else

            dungeonData = DataMgr.Player.dungeonRecords[tempList[i].param]
            challengeCount = ConfigAreaMgr.GetChallengeCountById(tempList[i].param)
            completeCount = 0
            if challengeCount > 0 then
                completeCount = PlayerAreaMgr.GetChallengeCompleteCountById(tempList[i].param)
            end
            if dungeonData == nil or IsNullOrEmpty(dungeonData.historyRating) then
                tempData = {id = tempList[i].ID,before = tempList[i].before,param = tempList[i].param,state = 3,type = tempList[i].type}
            else
                if dungeonData.historyRating == "S" and challengeCount == completeCount then
                    tempData = {id = tempList[i].ID,before = tempList[i].before,param = tempList[i].param,state = 1,type = tempList[i].type}
                else
                    tempData = {id = tempList[i].ID,before = tempList[i].before,param = tempList[i].param,state = 2,type = tempList[i].type}
                end
            end
        end
        table.insert(this.dungeonStateList[storyID],tempData)
    end
    local perfectCount,passCount = 0,0
    local length = #this.dungeonStateList[storyID]
    for i = 1, length do
        if this.dungeonStateList[storyID][i].state == 1 then
            perfectCount = perfectCount + 1
        elseif this.dungeonStateList[storyID][i].state == 2 then
            passCount = passCount + 1
        end
    end
    if perfectCount >= length then
        return 1
    elseif passCount >= length then
        return 2
    end
    return 3
end

this.ItemClickEvent = function(args)
    if args.Length == 0 then return end
    local index = args[0]
    this.SetItemChoose(index)
    this.vm.data.rewardPopup = false
end

this.DungeonClickEvent = function(args)
    if args.Length == 0 then return end
    local index = args[0]
    command.dungeonCommand.execute(nil,index)
end

this.SetItemChoose = function(index)
    this.vm.data.anecdoteAnimName = "ani_ui_BranchMissionPanel_Anecdote"
    if this.anecdoteScrollView.itemMap[this.anecdoteIndex] ~= nil then
        SetActive(this.anecdoteScrollView.itemMap[this.anecdoteIndex].normal,true)
        SetActive(this.anecdoteScrollView.itemMap[this.anecdoteIndex].choose,false)
    end
    this.anecdoteScrollView.dataList[this.anecdoteIndex].data.select = false
    this.anecdoteIndex = index
    if this.anecdoteScrollView.itemMap[this.anecdoteIndex] == nil then
        this.anecdoteScrollView:MoveToIndex(this.anecdoteIndex)
    end
    SetActive(this.anecdoteScrollView.itemMap[this.anecdoteIndex].normal,false)
    SetActive(this.anecdoteScrollView.itemMap[this.anecdoteIndex].choose,true)
    this.anecdoteScrollView.dataList[this.anecdoteIndex].data.select = true
    this.anecdoteScrollView.itemMap[this.anecdoteIndex]:RecordRed()
    
    this.UpdateAnecdote()
end

this.UpdateAnecdote = function()
    local config = this.anecdoteList[this.anecdoteIndex]
    this.vm.data.anecdoteIcon = LuaMgr.GetTexture(this.anecdotePath..config.page..".png")
    this.vm.data.anecdoteText = LuaMgr.GetTexture(this.anecdotePath..config.page.."_Text.png")
    local tempState = this.dungeonStateList[config.ID]
    local tempData = DataMgr.Player.branch.children["Reg2001"].children[config.ID].children
    local completeCount,canGetCount = 0,0

    this.anecdoteDungeonView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local itemIndex = 1
    for i = 1, #tempState do
        if tempState[i].type ~= "4" then
            groupData = {}
            groupData.id = config.ID
            groupData.index = i
            groupData.data = tempState[i]
            scrollData = UIScrollData.GetData(this.dungeonTemplate,"AnecdoteDungeonItem",348,76 + 33,groupData)
            table.insert(scrollDatas,scrollData)
        else
            this.vm.data.dungeonList[itemIndex].pass = tempState[i].state == 2
            this.vm.data.dungeonList[itemIndex].perfect = tempState[i].state == 1
            this.vm.data.dungeonList[itemIndex].lock = not tempData[tempState[i].id].unlocked
            this.vm.data.dungeonList[itemIndex].effect = tempData[tempState[i].id].unlocked
            this.vm.data.dungeonList[itemIndex].number = "0"..i
            this.vm.data.dungeonList[itemIndex].icon = LuaMgr.GetTexture(this.anecdotePath..config.page.."_Dungeon_2.png")
            this.vm.data.dungeonList[itemIndex].color = tempData[tempState[i].id].unlocked and UnityEngine.Color(1,1,1,1) or UnityEngine.Color(1,1,1,0.6)
            itemIndex = itemIndex + 1
        end
        if tempData[tempState[i].id].completed then
            completeCount = completeCount + 1
            if not tempData[tempState[i].id].received then
                canGetCount = canGetCount + 1
            end
        end
    end
    this.anecdoteDungeonView:SetParams(375,386)
    this.anecdoteDungeonView:SetPadding(0,0,-20,0)
    this.anecdoteDungeonView:SetData(scrollDatas, true)
    
    this.vm.data.rewardEffect = canGetCount > 0
    local length = #tempState
    this.vm.data.rewardBar = completeCount / length
    local color = ConfigMgr.Config.constants.aecdoteColor[this.anecdoteIndex]
    if color == nil then color = {1,1,1} end
    this.vm.data.rewardBarColor = UnityEngine.Color(color[1] / 255,color[2] / 255,color[3] / 255,1)
    this.vm.data.rewardAlready = completeCount == length and canGetCount <= 0
    local text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15016"].NameLan)
    this.vm.data.rewardPopupBarText = string.format(text,completeCount,length)

    local rewardIndex = length
    for i = 1, length do
        if not tempData[tempState[i].id].received then
            rewardIndex = i
            break
        end
    end
    this.vm.data.rewardIcon = GetItemTexture(config.reward[rewardIndex].id)
    this.vm.data.rewardCount = config.reward[rewardIndex].count
end

this.OpenRewardPopup = function(num)
    if not this.vm.data.rewardPopup then
        local config = this.anecdoteList[this.anecdoteIndex]
        local id = ""
        local tempItem,tempList = {},{}
        local length = #config.reward
        for i = 1, length do
            id = config.reward[i].id
            tempItem = {itemIcon = GetItemTexture(id),itemId = id,already = i <= num,bar = i < length}
            table.insert(tempList,tempItem)
        end
        this.vm.data.rewardList = tempList
    end
    this.vm.data.rewardPopup = not this.vm.data.rewardPopup
end


this.PlayCircleAnimation = function(index, completes)
    if index == nil or completes then return end
    coroutine_runner.start(function()
        coroutine_runner.wait(0.5)

        if this ~= nil then
            local root = this.BookLayout:Find("Viewport/Content/"..tostring(index))
            local BranchAnimator = nil
            if root ~= nil then
                BranchAnimator = root:GetComponent("Animator")
            end
            if BranchAnimator ~= nil then
                BranchAnimator:Play("ani_ui_BrancheNewItem_003", 0, 0)
            end
        end
        index = nil
    end)
end


this.PlayBookAnimation = function()
    if not this.vm.data.BranchMainShow then
        return
    end

    local root = nil
    local BranchAnimator = nil
    for i = 1, #this.vm.data.branchList, 1 do
        root = this.BookLayout:Find("Viewport/Content/"..tostring(i))
        if root ~= nil then
            BranchAnimator = root:GetComponent("Animator")
        end
        if BranchAnimator ~= nil then
            BranchAnimator:Play("ani_ui_BrancheNewItem_002", 0, 0)
        end
    end
    local Complete = this.PlayerBranchData.children[this.vm.data.branchList[Currentbranch].chapterID].completed

end


this.showBooksEffect = function(index, effectIds)
    local BranchAnimator
    coroutine_runner.start(function()
        if this ~= nil then
            this.BranchEffectNet(effectIds)
            this.vm.data.closeDoubleClicks = true
        end
        coroutine_runner.wait(0.6)
        PlayeBookEffect = nil
        if this ~= nil then
            this.vm.data.branchList[index].UnLock = true
            this.vm.data.branchList[index].HeroIconShow = true
            BranchAnimator = this.BookLayout:Find("Viewport/Content/" .. tostring(index)):GetComponent("Animator")
            BranchAnimator:Play("ani_ui_BrancheNewItem_001", 0, 0)
        end
    end)
    coroutine_runner.start(function()
        coroutine_runner.wait(2)
        if this ~= nil then
            this.vm.data.branchList[index].uiEffectShow = false
            this.vm.data.closeDoubleClicks = false
        end
    end)
end
this.BattleResultShow = function(characterID, type)
    local Clear = false
    local nowComplete = false
    local Complete = false
    local PicturePath = ""
    if tonumber(type) == 1 then
        for key, value in ipairs(DataMgr.Player.completedChapters) do
            if value == characterID then
                Complete = true
                Clear = true
            end
        end
    elseif tonumber(type) == 2 then
        local levelChallenges = nil
        for key, value in pairs(DataMgr.Player.dungeonRecords) do
            if key == characterID then
                PicturePath = "ui_zqzb_pj_" .. value.historyRating
                Clear = true
                if value.historyRating == "S" then
                    nowComplete = true
                    for Levelkey, levelvalue in
                    pairs(ConfigMgr.Config.levelChallenges) do
                        if Levelkey == characterID then
                            levelChallenges = levelvalue
                        end
                    end
                else
                    nowComplete = false
                end
                break
            else
                Clear = false
            end
        end
        if Clear and nowComplete then
            if levelChallenges ~= nil then
                for levelkey, levelvalue in pairs(levelChallenges) do
                    if DataMgr.Player.completedTags[levelvalue] == nil then
                        Complete = false
                    end
                end
            else
                Complete = true
            end
        end
    end
    return Clear, Complete, PicturePath
end

this.RefushChildPageShow = function(tab)
    local tempList = {}
    local CurrentShowMission = 0
    local Totolcomplete = 0
    local currentindex = 0
    local showEffectIndex = 0
    for key, value in pairs(ConfigMgr.Config.branchEventList) do
        if value.storyID == tab.itemId then
            currentindex = currentindex + 1
            local Locks = true
            for netkey, netvalue in pairs(CurrrentSelectBattledata.children) do
                if netvalue.id == value.ID then
                    Locks = not netvalue.unlocked
                end
            end
            local Branchs = {}
            local Clear, Complete, message = BranchMissionHelper.BattleResultShow(value.param, value.type)
            local Pagestates = false
            local Textture = message
            if not Clear and not Complete then
                Pagestates = false
            elseif not Complete and Clear then
                Pagestates = true
            elseif Complete and Clear then
                Pagestates = true
            end
            if Complete then Clear = false end
            local Goto = not Locks and (not Clear and not Complete)
            local bgsprite = Locks and "ui_zx_zk_lb03" or
            (Goto and "ui_zx_zk_lb02" or "ui_zx_zk_lb01")
            if not Locks and not (Complete or Clear) then
                if key > 1 then
                    CurrentShowMission = currentindex
                    PlayeBattlelEffect = DataMgr.Player.animationRecords[value.param] == nil and value.param or nil
                end
            end
            if (Complete or Clear) then
                Totolcomplete = Totolcomplete + 1
            end
            local Opiniontype1 = value.Unlock1.UnlockType
            local Opiniontype2 = value.Unlock2.UnlockType
            local OpiniontId1 = value.Unlock1.ElementID
            local OpiniontId2 = value.Unlock2.ElementID
            local AnimationAlpha
            if currentindex > 1 and PlayeBattlelEffect == value.param then
                AnimationAlpha = true
            end
            local missionname = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[value.param].NameLan)
            local effectBgLocksBg = LuaMgr.GetSprite("BranchMission", "ui_zx_zk_lb03")
            Branchs = {
                EventId = value.ID,
                StoryId = value.storyID,
                itemStateNum = "",
                itemName = missionname,
                itempages = "",
                Lock = Locks,
                BattleGoto = not Locks and (not Clear and not Complete),
                selsect = false,
                unlockEffect = false,
                effecAnimationName = "ui_ani_BglocksOpenpanel",
                states = Pagestates,
                unselsect = true,
                perfect = Complete,
                clear = Clear,
                ItemIcon = LuaMgr.GetSprite("AreaMapRes", Textture),
                Bgtexture = LuaMgr.GetSprite("BranchMission", bgsprite),
                effectBgIcon = effectBgLocksBg,
                param = value.param,
                before = value.before,
                Opiniontype1 = Opiniontype1,
                Opiniontype2 = Opiniontype2,
                OpiniontId1 = OpiniontId1,
                OpiniontId2 = OpiniontId2,
                unlockshow = false,
                redId = "1083" .. "_" .. value.param
            }
            table.insert(tempList, Branchs)
            table.insert(this.SelectBattleGroup, Branchs)
        end
    end
    this.vm.data.selectMission = tempList
    CurrentShowMission = Totolcomplete == tempList and #tempList or
    CurrentShowMission
    if CurrentShowMission > 1 and PlayeBattlelEffect ~= nil then
        showEffectIndex = CurrentShowMission
        CurrentShowMission = CurrentShowMission - 1
        if BackToBranch then
            this.vm.data.selectMission[showEffectIndex].unlockshow = true
            this.vm.data.selectMission[showEffectIndex].effecAnimationName = "ui_ani_Bglockspanel"
            this.vm.data.selectMission[showEffectIndex].unlockEffect = true
        else
            this.vm.data.selectMission[showEffectIndex].unlockshow = true
            this.vm.data.selectMission[showEffectIndex].unlockEffect = true
            this.vm.data.selectMission[showEffectIndex].effecAnimationName = "ui_ani_BglocksClosepanel"
            coroutine_runner.start(function()
                coroutine_runner.wait(0.6)
                if this ~= nil then
                    this.vm.data.selectMission[showEffectIndex].effecAnimationName = "ui_ani_Bglockspanel"
                end
            end)
        end
        this.BranchEffectNet(this.vm.data.selectMission[showEffectIndex].param)
    end

    this.BattleScroll(CurrentShowMission, #tempList)
end

this.NoveToggleshow = function(value)
    local Locks = true
    for netkey, netvalue in pairs(CurrrentSelectBattledata.children) do
        if netvalue.id == value.ID then Locks = not netvalue.unlocked end
    end
    local Clear, Complete, message = BranchMissionHelper.BattleResultShow(value.param, "1")
    local Pagestates = false
    if not Clear and not Complete then
        Pagestates = false
    elseif not Complete and Clear then
        Pagestates = true
    elseif Complete and Clear then
        Pagestates = true
    end

    return Locks, Pagestates, Clear, Complete
end

this.EventNovelShow = function(tab)
    local tempList = {}
    local playAnimation = false
    local PlayeAnimationIndex = 0
    local index = 0
    local NeedsId = 0
    for key, value in pairs(ConfigMgr.Config.branchEventList) do
        if value.storyID == tab.itemId then
            local Locks, Pagestates, Clear, Complete = this.NoveToggleshow(value)
            local BattleState = value.BattleUnlock.ElementID ~= ""
            local UnBattleState = value.BattleUnlock.ElementID == ""
            local Opiniontype1 =            BattleState and value.BattleUnlock.UnlockType or
                    value.Unlock1.UnlockType
            local Opiniontype2 = BattleState and nil or value.Unlock2.UnlockType
            local OpiniontId1 = BattleState and value.BattleUnlock.ElementID or
                    value.Unlock1.ElementID
            local OpiniontId2 = BattleState and nil or value.Unlock2.ElementID
            local NovelBranchs = {}
            index = index + 1
            local GlobalIdex = tostring(2224 + index)
            local langGlobal=ConfigMgr.Config.langGlobal[GlobalIdex]
            local NameLan=GlobalIdex;

            if langGlobal ~=nil then
                NameLan = LuaMgr.GetLangText(langGlobal.NameLan)
            else

            end

            NovelBranchs = {
                itemId = value.ID,
                beforId = value.before,
                itemStateNum = "",
                itemName = "",
                itemcfigName = NameLan,
                itempages = "",
                Lock = Locks,
                chapterID = value.chapterID,
                storyID = value.storyID,
                Complete = Complete,
                State = Pagestates,
                descLight = false,
                LockAnimation = false,
                LockAnimationBg = LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab03"),
                descDark = false,
                battleLock = BattleState,
                battleUnLock = UnBattleState,
                battleLockTab = value.BattleUnlock,
                novOpiniontype1 = Opiniontype1,
                novOpiniontype2 = Opiniontype2,
                novOpiniontId1 = OpiniontId1,
                novOpiniontId2 = OpiniontId2,
                param = value.param,
                types = value.type,
                ItemIcon = Locks and LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab03") or LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab01"),
                stateIcon = DefaultTexture,
                alreadyLook = false,
                redIds = "1084" .. "_" .. value.ID,
                showRedPoint= not Locks;
            }

            table.insert(tempList, NovelBranchs)
        end
    end
    for index, value in ipairs(tempList) do
        if value.Lock then
            for cfgindex, cfgvalue in ipairs(ConfigMgr.Config.branchEventList) do
                if value.beforId == cfgvalue.ID then
                    value.Lock = this.checkBeforData(cfgvalue.param)
                end
            end
        end
        if not value.Lock then
            NeedsId = index
            PlayeNovelEffect = DataMgr.Player.animationRecords[value.itemId] ==
                    nil and index or nil
        end
    end
    if ComData.branchData.bookindex == this.SelectBranch then
        CurrentNovelSelect = ComData.branchData.novelIndex ~= nil and
                ComData.branchData.novelIndex or NeedsId
    else
        CurrentNovelSelect = CurrentNovelSelect ~= nil and CurrentNovelSelect or
                NeedsId
    end
    if ComData.branchData.novelIndex == nil and PlayeNovelEffect ~= nil then
        if CurrentNovelSelect > 1 then
            playAnimation = true
            PlayeAnimationIndex = CurrentNovelSelect
            CurrentNovelSelect = CurrentNovelSelect - 1
        end
    elseif ComData.branchData.novelIndex ~= nil and PlayeNovelEffect ~= nil then
        if CurrentNovelSelect < #tempList then
            playAnimation = not tempList[CurrentNovelSelect + 1].Lock
            PlayeAnimationIndex = CurrentNovelSelect + 1
        end
    end
    for index, value in ipairs(tempList) do
        if index == CurrentNovelSelect and not value.Lock then
            value.ItemIcon = LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab01")
            value.itemName = string.format(
                    "<color=#fff9ea>" .. value.itemcfigName .. "</color>")
        else
            if value.Lock then
                value.ItemIcon = LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab03")
                value.itemName = string.format("<color=#9997977d>" .. value.itemcfigName .. "</color>")
            else
                value.ItemIcon = LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab02")
                value.itemName = string.format("<color=#887a65>" .. value.itemcfigName .. "</color>")
            end
        end
    end
    this.vm.data.novelEvent = tempList

    if playAnimation then
        local StoryId = tempList[PlayeAnimationIndex].itemId
        this.UnLockNovelAnimation(PlayeAnimationIndex)
        local CompletAnimation = function() PlayeNovelEffect = nil end
        this.BranchEffectNet(StoryId, CompletAnimation)
    end
    this.SeleNovel = this.vm.data.novelEvent[CurrentNovelSelect]
end


this.checkBeforData = function(id)
    local BeforeLocks = false
    for key, value in ipairs(DataMgr.Player.completedChapters) do
        if value == id then BeforeLocks = true end
    end
    if BeforeLocks then
        BeforeLocks = false
    else
        BeforeLocks = true
    end
    return BeforeLocks
end


this.currentNovelState = function(id)
    local BeforeLocks = false
    for key, value in ipairs(DataMgr.Player.completedChapters) do
        if value == id then BeforeLocks = true end
    end
    return BeforeLocks
end

this.GetEventNovelShow = function(tab)
    local tempList = {}
    local NovelGroups = {}
    local index = 0
    for key, value in pairs(ConfigMgr.Config.branchEventList) do
        if value.storyID == tab.itemId then
            local Locks, Pagestates, Clear, Complete = this.NoveToggleshow(value)
            local NovelBranchs = {}
            index = index + 1
            local BattleState = value.BattleUnlock.ElementID ~= ""
            local UnBattleState = value.BattleUnlock.ElementID == ""
            local Opiniontype1 = BattleState and value.BattleUnlock.UnlockType or value.Unlock1.UnlockType
            local Opiniontype2 = BattleState and nil or value.Unlock2.UnlockType
            local OpiniontId1 = BattleState and value.BattleUnlock.ElementID or value.Unlock1.ElementID
            local OpiniontId2 = BattleState and nil or value.Unlock2.ElementID
            NovelBranchs = {
                itemId = value.ID,
                beforId = value.before,
                itemStateNum = "",
                itemName = LuaMgr.GetLangText(ConfigMgr.Config.narrativeMap[value.param].nameLan),
                itempages = "",
                Lock = Locks,
                state = Pagestates,
                types = value.type,
                UnLock = false,
                selsect = false,
                unselsect = true,
                battleLock = BattleState,
                battleUnLock = UnBattleState,
                battleLockTab = value.BattleUnlock,
                param = value.param,
                LockAnimation = false,
                LockAnimationBg = LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab03"),
                stateIcon = DefaultTexture,
                novOpiniontype1 = Opiniontype1,
                novOpiniontype2 = Opiniontype2,
                novOpiniontId1 = OpiniontId1,
                novOpiniontId2 = OpiniontId2,
                BattleUnlock = value.BattleUnlock
            }
            table.insert(tempList, NovelBranchs)
        end
    end
    for index, value in ipairs(tempList) do
        if value.Lock then
            for cfgindex, cfgvalue in ipairs(ConfigMgr.Config.branchEventList) do
                if value.beforId == cfgvalue.ID then
                    value.Lock = this.checkBeforData(cfgvalue.param)
                end
            end
            value.ItemIcon = value.Lock and LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab01") or LuaMgr.GetSprite("BranchMission", "ui_zx_bq_tab03")
        end
    end
    return tempList
end
this.PlayeChangePageAnimation = function(IsforeId, isnormal)

    if CurrentSelectNovel == nil then
        CurrentSelectNovel = { IsforeId = nil, normalId = nil }
        if IsforeId then
            CurrentSelectNovel.IsforeId = true
            CurrentSelectNovel.normalId = false
            GrandSondAnimation:Play("ani_ui_GrandSonPanelOne_001", 0, 0)
            CurrentSelectNovel = nil
        elseif isnormal then
            CurrentSelectNovel.IsforeId = false
            CurrentSelectNovel.normalId = true
            GrandSondAnimation:Play("ani_ui_GrandSonPanelOne_003", 0, 0)
            CurrentSelectNovel = nil
        end
    else
        if CurrentSelectNovel.IsforeId and isnormal then
            CurrentSelectNovel.IsforeId = false
            CurrentSelectNovel.normalId = true
            GrandSondAnimation:Play("ani_ui_GrandSonPanelOne_002", 0, 0)
        elseif CurrentSelectNovel.normalId and IsforeId then
            CurrentSelectNovel.IsforeId = true
            CurrentSelectNovel.normalId = false
            GrandSondAnimation:Play("ani_ui_GrandSonPanelOne_005", 0, 0)
        elseif CurrentSelectNovel.normalId and isnormal then
            CurrentSelectNovel.IsforeId = false
            CurrentSelectNovel.normalId = true
            GrandSondAnimation:Play("ani_ui_GrandSonPanelOne_004", 0, 0)
        end
    end
end


this.changeDataState = function(tab)
    BeforBattleId = tab.BattleUnlock.ElementID ~= "" and
    tab.BattleUnlock.ElementID or nil
    BeforBattleClear, BeforBattleComplete = BranchMissionHelper.BattleResultShow(BeforBattleId, "2")
end


this.playChageStateAnimation = function(tab)
    local alreadyComplete = BeforBattleClear or BeforBattleComplete
    if (BeforBattleId ~= nil and alreadyComplete) then

        if DataMgr.Player.animationRecords[BeforBattleId] == nil then
            this.BranchEffectNet(BeforBattleId)
            PlayeNovelBeforeEffect = true
            this.NovelDatarefush(tab)
            coroutine_runner.start(function()
                coroutine_runner.wait(1.5)
                if this ~= nil then
                    this.vm.data.BranchNovelbattleLock = false
                    this.vm.data.closeDoubleClicks = false
                end
            end)
            this.vm.data.closeDoubleClicks = true
            GrandSondAnimation:Play("ani_ui_GrandSonPanelOne_002", 0, 0)
            this.vm.data.showBeforeBattleUnlock = true
            this.vm.data.BranchNovelbattleLock = true
            this.vm.data.BranchNovelbattleUnLock = false
            coroutine_runner.start(function()
                coroutine_runner.wait(1)
                GrandSondAnimation:Play("ani_ui_GrandSonPanelOne_008", 0, 0)
                PlayeNovelBeforeEffect = false
                if this ~= nil then
                    this.vm.data.showBeforeBattleUnlock = false
                    this.vm.data.BranchNovelbattleUnLock = true
                end
            end)
        else
            PlayeNovelBeforeEffect = false
            this.NovelDatarefush(tab)
        end
    else
        GrandSondAnimation:Play("ani_ui_GrandSonPanelOne_002", 0, 0)
        this.NovelDatarefush(tab)
    end
end


this.NovelDatarefush = function(tab)
    this.vm.data.novelEnpty = false
    this.vm.data.novelNotEnpty = true
    BeforBattleId = tab.BattleUnlock.ElementID ~= "" and
    tab.BattleUnlock.ElementID or nil
    NovelBattleId = tab.param
    ComData.branchData.novelParam = NovelBattleId
    ComData.branchData.novelEvent = tab.itemId
    local Clear, Complete
    local tabLocak = {}
    this.SetBranchRedShow(tab.itemId)
    if BackToBranch then
        this.BranchOpenOrCloseRed(1, 1)
    end
    if BeforBattleId ~= nil then
        Clear, Complete = BranchMissionHelper.BattleResultShow(BeforBattleId, "2")
        tabLocak.type = tab.BattleUnlock.UnlockType
        tabLocak.ID = tab.BattleUnlock.ElementID
        if Clear or Complete then

            if not PlayeNovelBeforeEffect then
                this.PlayeChangePageAnimation(false, true)
            end
            this.vm.data.BranchNovelbattleLock = false
            this.vm.data.BranchNovelbattleUnLock = true
            this.LockBattleStateShow(true, tabLocak)
        else
            this.PlayeChangePageAnimation(true, false)
            this.LockBattleStateShow(false, tabLocak)
            this.vm.data.BranchNovelbattleLock = true
            this.vm.data.BranchNovelbattleUnLock = false
        end
    else
        this.PlayeChangePageAnimation(false, true)
        local TotolGroup = false
        if (tab.novOpiniontId1 == nil or tab.novOpiniontId1 == "") and
        (tab.novOpiniontId2 == nil or tab.novOpiniontId2 == "") then
            TotolGroup = true
        end
        this.vm.data.BranchNovelbattleLock = false
        this.vm.data.BranchNovelbattleUnLock = true

        this.vm.data.novelEnpty = TotolGroup
        this.vm.data.novelNotEnpty = not TotolGroup
        if CurrentNovelSelect ~= nil or ComData.branchData.novelIndex ~= nil then
            this.NovelSelectStateShow(this.CurrentNovel, CurrentNovelSelect, true)
        end
    end
    local ShowNovelLooK = this.currentNovelState(NovelBattleId)
    this.vm.data.alreadySeeNovel = ShowNovelLooK
    this.vm.data.firstSeeNovel = not ShowNovelLooK
    local Novel = ConfigMgr.Config.narrativeMap[tab.param]
    local CurrentNovelText = LuaMgr.GetLangText(Novel.narraDesLan)
    this.vm.data.BrancNovelTextShow = CurrentNovelText
    local Getitem = { { id = Novel.fixedDropShow, count = 1 } }
    if Novel.fixedDropShow == "" or Novel.fixedDropShow == nil then return end
    this.ItemViewData(Getitem, false)
end

this.LockBattleStateShow = function(state, tab)
    local opinion = {}
    local a, b = this.checkUnlock(tab, true)
    local OpinionList = {
        description = b,
        object = true,
        achieve = state,
        unAchieve = not state
    }
    table.insert(opinion, OpinionList)
    this.vm.data.OpinionList = opinion
end

this.LockStoryStateShow = function(tab, unlock)
    local locks = unlock or nil
    local opinion = {}
    local state = {}
    for key, value in pairs(tab) do
        local a, b = this.checkUnlock(value, locks)
        if not a then
            OptionGropu = false
            OptionGropuTips = b
        end
        table.insert(state, a)
        local OpinionList = {
            description = b,
            object = true,
            achieve = a,
            unAchieve = not a
        }
        table.insert(opinion, OpinionList)
    end
    if not unlock then return end
    this.vm.data.OpinionList = opinion
    return state
end


this.ClickBranchItems = function(index, state)
    if this.StageGroup[this.SelectBranch] == nil then return end
    for key, value in pairs(CurrrentSelectPageChild) do
        if value.id == this.StageGroup[this.SelectBranch].itemId then
            CurrrentSelectBattledata = value
        end
    end
    this.vm.data.BranchPageShow = false
    if ComData.branchData.BattleGoto == nil and ComData.branchData.NorvelGoto ==
    nil then
        this.vm.data.BranchMainShow = false
    else






    end

    if not this.vm.data.BranchePropShow then
        this.vm.data.BranchePropShow = true
        this.branchNovelBg.anchoredPosition = Vector2(780,0)
        this.leftBg.anchoredPosition = Vector2(-82,0)
    end
    if this.vm.OpenProp == nil then
        this.vm.behaviour:UpdateTopBar("branchArea", this.CloseProps)
        this.vm.OpenProp = true
    end

    local RefushNovelBattleState = function()
        if this.showOtherPropEvent then
            LuaMgr.HidePanel(UIName.BranchMissionEvent3ViewModel)
        end

        if this.StageGroup[this.SelectBranch] ~= nil and this.StageGroup[this.SelectBranch].itemType == BranchEventType.Battle then
            this.showOtherPropEvent = false
            this.vm.data.BranchBattleEventShow = true
            this.vm.data.BranchNovelEventshow = false
            this.RefushChildPageShow(this.StageGroup[this.SelectBranch])
            ComData.branchData.novelParam = nil

        elseif this.StageGroup[this.SelectBranch] ~= nil and this.StageGroup[this.SelectBranch].itemType == BranchEventType.AVG then
            this.showOtherPropEvent = false
            this.InitNovelListShow()
        elseif this.StageGroup[this.SelectBranch] ~= nil and this.StageGroup[this.SelectBranch].itemType == BranchEventType.Weapon then
            local BookId = this.StageGroup[this.SelectBranch].itemId
            this.showOtherPropEvent = true
            this.vm.data.BranchBattleEventShow = false
            this.vm.data.BranchNovelEventshow = false
            this.vm.data.BranchNovelEventshow = false
            LuaMgr.ShowLuaPanel(UIName.BranchMissionEvent3ViewModel, GrandSondTransForm, BookId, this.IntoBattlePanel)

        end
    end
    if state == 0 then
        local function InitValueState(value)
            value.LockShowPage = value.Lock
            value.uiEffectShow = value.Lock
            value.UnLock = not value.Lock
            value.HeroIconShow = not value.Lock
        end
        if PlayeBookEffect and PlayeBookPropEffect ~= nil and BackToBranch then
            for index, value in ipairs(this.StageGroup) do
                if index == PlayeBookEffectIndex then
                    value.LockShowPage = true
                    value.UnLock = false
                    value.Showeffect = false
                    value.HeroIconShow = false
                else
                    InitValueState(value)
                end
            end
        else
            for index, value in ipairs(this.StageGroup) do
                InitValueState(value)
            end
        end

        for i = 1, 5, 1 do
            local indexdata = i + index - 3
            local CurrentState = indexdata >= 1 and indexdata <= 5 and indexdata <= #this.StageGroup
            local datagroup = {}
            if CurrentState then
                this.StageGroup[indexdata].Itemactive = true
                this.StageGroup[indexdata].Showeffect = false
                this.StageGroup[indexdata].circleLocalPos = Vector3(6.3, -13.7, 0)
                table.insert(datagroup, this.StageGroup[indexdata])
            else
                this.StageGroup[1].Itemactive = false
                table.insert(datagroup, this.StageGroup[indexdata])
            end
            local Object = "branchListChild" .. tostring(i)
            this.vm.data[Object] = datagroup
        end

        this.vm.data.branchListChild3[1].circleLocalPos = Vector3(6.3, -13.7, 0)
        for index, value in ipairs(BranchTransformGroup) do
            if index == 3 then
                GrandSonPanelShow:SetParent(value.transform, false)
            end
        end
        local OpenClosePanel = function()
            if not PlayeBookEffect then
                this.vm.data.closeDoubleClicks = false
            end
        end
        this.vm.data.closeDoubleClicks = true
        RefushNovelBattleState()
        local battleBack = ComData.branchData.BattleGoto ~= nil or
        ComData.branchData.NorvelGoto ~= nil
        this.changeGropPointion(true, BranchRunPos, Branchstandard, OpenClosePanel, battleBack)
        this.CloseAndOpenPage(true)
    else
        local function CompleteFuns()
            local name, dataIndex = this.clockToLeftOrRight(state, this.SelectBranch,
            #this.vm.data
            .branchList)
            local datagroup = {}
            if dataIndex ~= 0 then
                this.StageGroup[dataIndex].Itemactive = true
                this.StageGroup[dataIndex].circleLocalPos = Vector3(6.3, -13.7, 0)
                table.insert(datagroup, this.StageGroup[dataIndex])
            else
                this.StageGroup[1].Itemactive = false
                this.StageGroup[1].circleLocalPos = Vector3(6.3, -13.7, 0)
                table.insert(datagroup, this.StageGroup[dataIndex])
            end
            this.vm.data[name] = datagroup
            this.SetGrandeSonParent()
            local function forbid()
                this.vm.data.closeDoubleClicks = false
            end
            local Achieve = function()
                if PlayeBookEffect and PlayeBookPropEffect ~= nil and BackToBranch then
                    if this.battlBackToBranch ~= nil then
                        coroutine_runner.stop(this.battlBackToBranch)
                        this.battlBackToBranch = nil
                    end
                    this.battlBackToBranch = coroutine_runner.start(function()

                        this.vm.data.branchListChild4[1].AnimationName = "ani_ui_BrancheNewSelectItem_001"
                        this.vm.data.branchListChild4[1].UnLock = true
                        this.vm.data.branchListChild4[1].Showeffect = true
                        this.vm.data.branchListChild4[1].uiEffectShow = true
                        this.vm.data.branchListChild4[1].HeroIconShow = true
                        LuaMgr.NextFrame(function()
                            this.vm.data.branchListChild4[1].LockShowPage = false
                        end)

                        this.vm.data.branchListChild4[1].circleLocalPos = Vector3(6.3, -13.7, 0)
                        coroutine_runner.wait(2)
                        this.InitEffectState()
                        this.CompleteCloseAndOpenEvent()
                        this.changeGropPointion(true, BranchRunPos,
                        Branchstandard, forbid)
                        PlayeBookEffect = false
                    end)
                else
                    this.CompleteCloseAndOpenEvent()
                    this.changeGropPointion(true, BranchRunPos, Branchstandard,
                    forbid)
                end
            end

            RefushNovelBattleState()
            this.RefushBranchPosition(state, Achieve)
        end
        this.vm.data.closeDoubleClicks = true
        this.changeGropPointion(false, Branchstandard, BranchRunPos,
        CompleteFuns)
        this.CloseAndOpenPage(false)
    end
end


this.InitEffectState = function()
    PlayeBookEffect = nil
    PlayeBookPropEffect = nil
    PlayeBookEffectIndex = nil
end


this.CompleteCloseAndOpenEvent = function()
    this.CloseAndOpenPage(true)
end

this.SetGrandeSonParent = function()
    local MiddleShow = currentItem[3]

    for index, value in ipairs(BranchTransformGroup) do
        if value.key == MiddleShow.itemName then
            GrandSonPanelShow:SetParent(value.transform, false)
        end
    end
end

this.InitNovelListShow = function()
    this.vm.data.BranchBattleEventShow = false
    this.vm.data.BranchNovelEventshow = true

    this.EventNovelShow(this.StageGroup[this.SelectBranch])
    this.CurrentNovelGroup = this.GetEventNovelShow(this.StageGroup[this.SelectBranch])

    this.CurrentNovel = this.CurrentNovelGroup[CurrentNovelSelect]

    this.changeDataState(this.CurrentNovel)
    this.playChageStateAnimation(this.CurrentNovel)
end



this.UnLockNovelAnimation = function(index)
    this.vm.data.novelEvent[index].showRedPoint=false;
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/branch_unlock.mp3")
    this.vm.data.novelEvent[index].LockAnimation = true

    coroutine_runner.start(
            function()
                coroutine_runner.wait(1)
                if this ~= nil then
                    this.vm.data.novelEvent[index].showRedPoint=true;
                end
            end )
end

this.StateChage = function(state, i)
    local tempList = {}
    local Branchs = {}
    Branchs = {
        itemId = "",
        itemStateNum = "",
        itemName = "",
        itempages = "",
        Lock = false,
        UnLock = false,
        selsect = false,
        unselsect = true,
        ItemIcon = DefaultTexture,
        stateIcon = DefaultTexture,
        Rareindex = i,
        Itemactive = state
    }
    table.insert(tempList, Branchs)
    return tempList
end

this.BranchPropsViewData = function()
    for i = 1, 5, 1 do
        local tempList = {}
        local ss = "branchListChild" .. tostring(i)
        local Branchs = {}
        Branchs = {
            itemId = "",
            itemStateNum = "",
            Lock = false,
            UnLock = false,
            selsect = false,
            unselsect = true,
            ItemIcon = DefaultTexture,
            stateIcon = DefaultTexture,
            showChildMisson = false
        }
        if i == 1 then Branchs.showChildMisson = true end
        table.insert(tempList, Branchs)
        this.vm.data[ss] = tempList
    end
end
this.checkUnlock = function(tabs, showtip)
    local isCan = false
    local Message = ""
    if tonumber(tabs.type) == 1 then
        isCan = DataMgr.Player.level >= tonumber(tabs.ID)
        Message = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2106"].NameLan), tabs.ID)
        if not isCan and showtip == nil then
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", Message)
        end
    elseif tonumber(tabs.type) == 2 or tonumber(tabs.type) == 10 then
        if tonumber(tabs.type) == 10 then
            local Clear, Complete = BranchMissionHelper.BattleResultShow(tabs.ID, 2)
            isCan = Clear
            if isCan then
                local text = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[tabs.ID].NameLan)
                Message = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2104"].NameLan), text)
            end
        else
            for key, value in pairs(DataMgr.Player.completedAreaEvents) do
                if key == tabs.ID then
                    isCan = true
                    break
                end
            end
            local areaEvent = ConfigMgr.Config.areaEvents[tabs.ID]
            if areaEvent.type == 1 then
                local text = LuaMgr.GetLangText(
                ConfigMgr.Config.narrativeMap[areaEvent.eventParam].nameLan)
                Message = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2104"].NameLan), text)
            elseif areaEvent.type == 2 then
                local text = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[areaEvent.eventParam].NameLan)
                Message = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2104"].NameLan), text)
            end
            if not isCan and showtip == nil then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", Message)
            end
        end
    elseif tabs.type == 3 then
        if DataMgr.Player.items[tabs.ID] ~= nil then
            isCan = DataMgr.Player.items[tabs.ID].count0 ~= 0
        else
            isCan = false
        end
        local text = LuaMgr.GetLangText(ConfigMgr.Config.itemMap[tabs.ID].nameLan)
        Message = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2105"].NameLan), text)
        if not isCan and showtip == nil then
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", Message)
        end
    end
    return isCan, Message
end

this.ItemViewData = function(tabs, iscount)
    local tempList = {}
    for key, value in pairs(tabs) do
        local items = {
        }
        items = {
            itemId = value.id,
            object = true,
            equipRare = LuaMgr.GetSprite("ItemRare", "itemRare" ..
            ConfigHelper.GetItemById(value.id)
            .rare),
            already = true,
            equipIcon = LuaMgr.GetTexture(this.equipIconPath .. value.id .. ".png"),
            equipTrue = Vector3(0.5, 0.5, 0.5),
            equipFalse = Vector3(0.5, 0.5, 0.5),
            rare = ConfigHelper.GetItemById(value.id).rare,
            isCount = iscount,
            count = LuaMgr.NumFormat(value.count)
        }
        table.insert(tempList, items)
    end
    table.sort(tempList, function(a, b) return a.rare > b.rare end)
    if iscount then
        this.vm.data.bookitemList = tempList
    else
        this.vm.data.itemList = tempList
    end
end

this.BranchOpenOrCloseRed = function(panelType, open)
    if this.RedShowData == nil then return end
    for key, value in pairs(this.RedShowData) do
        local childcount = 0
        for Childkey, Childvalue in pairs(value.ChildRedData) do
            if Childvalue.GrandSonRedData ~= nil then
                local GrandSoncount = 0
                for GrandSonkey, GrandSonvalue in pairs(Childvalue.GrandSonRedData) do
                    RedMgr.Singleton:UpdateClientRedData(GrandSonvalue.tag .. "_" .. GrandSonvalue.gridechildid, this.RedDataTab[GrandSonvalue.gridechildid] ~= nil and 0 or 1)
                    GrandSoncount = GrandSoncount + 1
                    if this.RedDataTab[GrandSonvalue.gridechildid] ~= nil then
                        GrandSoncount = GrandSoncount - 1
                    end
                end
                RedMgr.Singleton:UpdateClientRedData(Childvalue.tag .. "_" .. Childvalue.childid, GrandSoncount > 0 and 1 or 0)
                childcount = childcount + 1
                if GrandSoncount <= 0 then
                    childcount = childcount - 1
                end
            else
                childcount = childcount + 1
                if this.RedDataTab[Childkey] ~= nil then
                    RedMgr.Singleton:UpdateClientRedData(Childvalue.tag .. "_" .. Childvalue.childid, 0)
                    childcount = childcount - 1
                else
                    RedMgr.Singleton:UpdateClientRedData(Childvalue.tag .. "_" .. Childvalue.childid, 1)
                end
            end
        end
        RedMgr.Singleton:UpdateClientRedData(value.tag .. "_" .. value.id, childcount > 0 and 1 or 0)
    end
    RedMgr.Singleton:Refresh()
end

this.checkStoryTag = function(id)
    for index, value in ipairs(ConfigMgr.Config.branchStoryList) do
        if id == value.ID then return value.type == 2 end
    end
end

this.RefuSheBranchPosition = function() end
return vm({
    data = data,
    command = command,
    hook = hook
})