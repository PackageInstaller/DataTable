




local this = {
    vm = nil,
    collection = nil,archives = nil,journal = nil,eventPlayback = nil,imageRecord = nil,
    collectionAddAttr = nil,collectionRoot = nil,
    collectionRed = nil,archivesRed = nil,journalRed = nil,eventPlaybackRed = nil,imageRecordRed = nil,
    collectionAddAttrRed = nil,
    dispatchStoryLock = nil,
    dispatchStoryRed = nil,
}

local data = {
    
}

local command = {
    mapCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            FeatureManager.GotoPanel("1100")
        end
    },
    archivesCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            FeatureManager.GotoPanel("4004")
        end
    },
    journalCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            FeatureManager.GotoPanel("4003")
        end
    },
    eventPlaybackCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            FeatureManager.GotoPanel("4002")
        end
    },
    imageRecordCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            FeatureManager.GotoPanel("4005")
        end
    },
    collectionAddAttrCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            FeatureManager.GotoPanel("4006")
        end
    },
    activityReviewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            FeatureManager.GotoPanel("4007")
            if not FeatureManager.IsLock("4007") then
                PlayerPrefs.SetInt(DataMgr.Player.uid.."ActivityReview",1);
            end
        end
    },
    dispatchStoryCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            FeatureManager.GotoPanel("30097")
            if not FeatureManager.IsLock("30097") then
                PlayerPrefs.SetInt(DataMgr.Player.uid.."DispatchStory", 1);
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.collection = vm.behaviour.transform:Find("root/Middle/CollectionMap/Lock").gameObject
        this.collectionRed = vm.behaviour.transform:Find("root/Middle/CollectionMap/RedIcon").gameObject
        
        this.archives = vm.behaviour.transform:Find("root/Middle/Archives/Lock").gameObject
        this.archivesRed = vm.behaviour.transform:Find("root/Middle/Archives/RedIcon").gameObject
        
        this.journal = vm.behaviour.transform:Find("root/Middle/Journal/Lock").gameObject
        this.journalRed = vm.behaviour.transform:Find("root/Middle/Journal/RedIcon").gameObject
        
        this.eventPlayback = vm.behaviour.transform:Find("root/Middle/EventPlayback/Lock").gameObject
        this.eventPlaybackRed = vm.behaviour.transform:Find("root/Middle/EventPlayback/RedIcon").gameObject

        this.imageRecord = vm.behaviour.transform:Find("root/Middle/ImageRecord/Lock").gameObject
        this.imageRecordRed = vm.behaviour.transform:Find("root/Middle/ImageRecord/RedIcon").gameObject
        
        this.collectionRoot = vm.behaviour.transform:Find("root/Middle/CollectionAddAttr").gameObject
        this.collectionAddAttr = vm.behaviour.transform:Find("root/Middle/CollectionAddAttr/Lock").gameObject
        this.collectionAddAttrRed = vm.behaviour.transform:Find("root/Middle/CollectionAddAttr/RedIcon").gameObject
        this.activityReveiwRed=vm.behaviour.transform:Find("root/Middle/activityReview/RedIcon").gameObject;

        this.dispatchStoryLock = vm.behaviour.transform:Find("root/Middle/DispatchStory/Lock").gameObject;
        this.dispatchStoryRed = vm.behaviour.transform:Find("root/Middle/DispatchStory/RedIcon").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
        this.InitRedPoint()
        HeroParameter.EmptyMainIndexList()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy = function(vm)
        this = nil
    end,
}


this.InitParameter = function()
    SetActive(this.collection,FeatureManager.IsLock("1100"))
    SetActive(this.archives,FeatureManager.IsLock("4004"))
    SetActive(this.journal,FeatureManager.IsLock("4003"))
    SetActive(this.eventPlayback,FeatureManager.IsLock("4002"))
    
    SetActive(this.imageRecord,FeatureManager.IsLock("4005"))
    local nowTime = LuaMgr.Timestamp()
    SetActive(this.collectionRoot,nowTime >= ConfigMgr.Config.constants.BestiarySupplyTime)
    SetActive(this.collectionAddAttr,FeatureManager.IsLock("4006"))
    SetActive(this.dispatchStoryLock,FeatureManager.IsLock("30097"))
    
end


this.InitRedPoint = function()
    local count = 0

    count = PlayerCharacterMgr.CheckCGMap()
    SetActive(this.collectionRed,count > 0)

    count = PlayerCharacterMgr.CheckArchives()
    SetActive(this.archivesRed,count > 0)

    count = PlayerCharacterMgr.CheckJournal()
    SetActive(this.journalRed,count > 0)

    count = PlayerCharacterMgr.CheckEventPlayback()
    SetActive(this.eventPlaybackRed,count > 0)

    count = PlayerCharacterMgr.CheckGroupPhotoRed()
    SetActive(this.imageRecordRed,count > 0)

    count = PlayerCharacterMgr.CheckAddAttrActiveRed()
    SetActive(this.collectionAddAttrRed,count > 0)

    count =PlayerCharacterMgr.GetReveiwActivityRed()
    SetActive(this.activityReveiwRed,count > 0)

    count = DispatchData.GetStoryRewardRed()
    SetActive(this.dispatchStoryRed,count > 0)
end

return vm({
    data = data,
    command = command,
    hook = hook
})