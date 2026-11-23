





require("ViewModel/AreaTeaching/Teaching_LevelItem")
require("ViewModel/AreaTeaching/Teaching_JCItem")
local this = {vm=nil,
              teachingLevelItemObj=nil,
              contentList=nil,
              jcItemObj=nil,
              jcPopList=nil,
              jjPopList=nil,
              zzDungeon=nil,
              zzDungeonIndex=nil;
              itemList={},
              getCount=nil,
              maxCount=nil,
              isShow=false,
};
local template_petalLan=nil;
local itemPool={}
local petalsList={}
local job1Category=8;
local job2Category=9
local cfgJobEvents={};
local cfgUnlockCondition={};
local cfgDungeou={};
local zzDungeouList={}
local curLevelIndex=nil
local doMoveDir=nil
local width=nil
local job1Pos={Vector2(-270,100),Vector2(-180,-94.6),Vector2(6,13.5),Vector2(148,-97),Vector2(274,50),}
local job2Pos={Vector2(-191.6,-14.2),Vector2(-59,120),Vector2(101.5,-88),Vector2(294.7,115.7),Vector2(392,-19.4)}
local teachLevelList={
    {
        isLock=false,
        width=347,
        pos=Vector2(-418.5,3),
        tag="jc",
        text=""
    },
    {
        isLock=false,
        width=347,
        pos=Vector2(4.5,3),
        tag="jj",
        text=""
    },
    {
        isLock=false,
        width=347,
        pos=Vector2(427.5,3),
        tag="sz",
        text=""
    },
}
local enterDungeonParams =nil

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local slider = nil;
local ScrollView = nil;
local btnClose = nil;
local btnConfrom = nil;
local tranContent = nil;
local tranJC = nil;
local tranJCList = nil;
local tranJJ = nil;
local tranJJList = nil;
local tranSZ = nil;
local tranLevel = nil;
local tranEffboom = nil;
local tranHuoyan=nil;
local tranComfrom = nil;
local tranRewardContent = nil;
local tranGroup = nil;
local tranGroup1 = nil;
local tranGroup2 = nil;
local tranDone = nil;
local tranEff = nil;
local tranEff02 = nil;
local textLevel = nil;
local textGroup = nil;
local textInfo = nil;
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    slider = uiLink:Get("slider"):GetComponent("Slider");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    btnConfrom = uiLink:Get("btnConfrom"):GetComponent("Button");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    tranJC = uiLink:Get("tranJC"):GetComponent("RectTransform");
    tranJCList = uiLink:Get("tranJCList"):GetComponent("RectTransform");
    tranJJ = uiLink:Get("tranJJ"):GetComponent("RectTransform");
    tranJJList = uiLink:Get("tranJJList"):GetComponent("RectTransform");
    tranSZ = uiLink:Get("tranSZ"):GetComponent("RectTransform");
    tranLevel = uiLink:Get("tranLevel"):GetComponent("RectTransform");
    tranEffboom = uiLink:Get("tranEffboom"):GetComponent("RectTransform");
    tranHuoyan=uiLink:Get("tranHuoyan"):GetComponent("RectTransform");
    tranComfrom = uiLink:Get("tranComfrom"):GetComponent("RectTransform");
    tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");
    tranGroup = uiLink:Get("tranGroup"):GetComponent("RectTransform");
    tranGroup1 = uiLink:Get("tranGroup1"):GetComponent("RectTransform");
    tranGroup2 = uiLink:Get("tranGroup2"):GetComponent("RectTransform");
    tranDone = uiLink:Get("tranDone"):GetComponent("RectTransform");
    tranEff = uiLink:Get("tranEff"):GetComponent("RectTransform");
    tranEff02 = uiLink:Get("tranEff02"):GetComponent("RectTransform");
    textLevel = uiLink:Get("textLevel"):GetComponent("Text");
    textGroup = uiLink:Get("textGroup"):GetComponent("Text");
    textInfo = uiLink:Get("textInfo"):GetComponent("Text");
    uiLink:AddClickEvent("btnClose",function()
        if not doMoveDir then
            this.DoMoveAnimation(curLevelIndex,-1,0.3);
        end
    end)
    uiLink:AddClickEvent("btnConfrom",this.btnConfrimCommand)
end
this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    slider = nil;
    ScrollView = nil;
    btnClose = nil;
    btnConfrom = nil;
    tranContent = nil;
    tranJC = nil;
    tranJCList = nil;
    tranJJ = nil;
    tranJJList = nil;
    tranSZ = nil;
    tranLevel = nil;
    tranEffboom = nil;
    tranHuoyan=nil;
    tranComfrom = nil;
    tranRewardContent = nil;
    tranGroup = nil;
    tranGroup1 = nil;
    tranGroup2 = nil;
    tranDone = nil;
    tranEff = nil;
    tranEff02 = nil;
    textLevel = nil;
    textGroup = nil;
    textInfo = nil;

end

this.btnConfrimCommand=function()
    enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = this.zzDungeon.id
    enterDungeonParams.dungeonId = this.zzDungeon.id;
    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    HeroParameter.SaveTeachingLevel(curLevelIndex);
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        RedMgr.Singleton:RegisterViewModel(UIName.AreaTeachingViewModel);
        this.Init(vm.behaviour)
        this.teachingLevelItemObj=vm.behaviour.transform:Find("template/teachingLevelItem").gameObject;
        local flower=tranSZ:Find("flower")
        for i=1,flower.childCount do
            table.insert(petalsList,flower:GetChild(i-1).transform);
        end
        this.contentList=UIListView.New(tranContent)
        this.jcItemObj=vm.behaviour.transform:Find("template/jcItem").gameObject;
        this.jcPopList=UIListView.New(tranJCList)
        this.jjPopList=UIListView.New(tranJJList);
        template_petalLan=vm.behaviour.transform:Find("template/petalLan"):GetComponent("Image");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("",function()
                LuaMgr.Back();
                HeroParameter.EmptyTeachingLevel();
            end);
            HeroRedDataHelper.SetJoinJobRed();
            this.ParseData();
            this.isShow=false
            
            if HeroParameter.TeachingLevel~=nil then
                this.isShow=not HeroParameter.TeachingReturn
                if this.zzDungeonIndex~=nil and DataMgr.Player.dungeonRecords[zzDungeouList[this.zzDungeonIndex].id]~=nil
                        and DataMgr.Player.dungeonRecords[zzDungeouList[this.zzDungeonIndex].id].completeCount==0 then
                    this.isShow=false;
                end
                HeroParameter.TeachingReturn=false
                curLevelIndex=HeroParameter.TeachingLevel
                this.OnClickLevelCommand(curLevelIndex);
                return;
            end
            if vm.behaviour.Params.Length>0 then
                curLevelIndex=3;
                this.OnClickLevelCommand(curLevelIndex);
            end
        end
    end,
    before_deactive = function(vm)
        this.contentList:Clear();
        this.jcPopList:Clear();
        this.AddItemPool();
    end,
    before_destroy=function()
        UIListView.ClearItem("Teaching_LevelItem")
        UIListView.ClearItem("Teaching_JCItem")
    end
}


this.OnClickLevelCommand=function(index)
    RedMgr.Singleton:FrushRedCondition("1174_"..index)
    if index~=curLevelIndex then
        if doMoveDir then

            this.DoMoveAnimation(index,1,0.3);
        else

                this.DoMoveAnimation(curLevelIndex,-1,0.1,function()
                    this.DoMoveAnimation(curLevelIndex,1,0.3);
                end);
        end
    else
        if doMoveDir then

            this.DoMoveAnimation(index,1,0.3);
        else

            this.DoMoveAnimation(index,-1,0.3);
        end
    end
    curLevelIndex=index
end
this.OnClickJobCommand=function(teachItem)
    if not teachItem.active then
        local dungeon=ConfigMgr.Config.dungeonMap[teachItem.unlockParam];
        if dungeon~=nil then
            local tips=string.format(LuaMgr.GetLangText("AreaTeachingViewModel_1"),LuaMgr.GetLangText(dungeon.NameLan));
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips);
        end
        return;
    end
    local dungeonId=teachItem.dungeonId;
    local eventId=teachItem.eventId;
    enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = eventId
    enterDungeonParams.dungeonId = dungeonId
    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    HeroParameter.SaveTeachingLevel(curLevelIndex);
end


this.DoMoveAnimation=function(index,dir,time,callBack)
    doMoveDir=dir<0
    if index==1 then
        SetActive(tranJC.gameObject,dir>0)
        SetActive(tranEff.gameObject,dir>0)
        if dir>0 then
            this.SetJobData(this.jcPopList,cfgJobEvents[index],job1Pos,index);
        end
    elseif index==2 then
        SetActive(tranEff.gameObject,dir>0)
        SetActive(tranJJ.gameObject,dir>0)
        if dir>0 then
            this.SetJobData(this.jjPopList,cfgJobEvents[index],job2Pos,index);
        end
    elseif index==3 then
        SetActive(tranEff02.gameObject,dir>0)
        SetActive(tranSZ.gameObject,dir>0)
        if dir>0 then
            this.SetJobSZData();
        else
            this.AddItemPool();
        end
    end
    for i,v in ipairs(this.contentList.itemList) do
        v:DoMove(index,dir,time,callBack);
    end
end



this.ParseData=function()
    SetActive(tranEff.gameObject,false)
    SetActive(tranEff02.gameObject,false)
    cfgUnlockCondition=ConfigMgr.Config.constants.UnlockTeach;
    cfgDungeou=ConfigMgr.Config.dungeonMap;
    curLevelIndex=0;
    doMoveDir=true
    width=LuaMgr.GetScreenWidth();
    local Job1Events={};
    local Job2Events={}
    for i,v in pairs(ConfigMgr.Config.areaEvents) do
        if v.category==job1Category then
            table.insert(Job1Events,v);
        elseif v.category==job2Category then
            table.insert(Job2Events,v);
        end
    end
    table.sort(Job1Events,function(a, b) return a.id<b.id end)
    table.sort(Job2Events,function(a, b) return a.id<b.id end)
    table.insert(cfgJobEvents,Job1Events)
    table.insert(cfgJobEvents,Job2Events)

    zzDungeouList={}
    for i,v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if v.area=="entry" and v.type==2 then
            table.insert(zzDungeouList,cfgDungeou[v.eventParam])
        end
    end
    table.sort(zzDungeouList,function(a, b) return a.id<b.id end)
    this.zzDungeonIndex=nil;
    local dungeonRecords=DataMgr.Player.dungeonRecords
    for i,v in ipairs(zzDungeouList) do
        if dungeonRecords[v.id]==nil or dungeonRecords[v.id].completeCount==0 then
            this.zzDungeonIndex=i;
            break;
        end
    end
    local wheelIndex=this.zzDungeonIndex==nil and 8 or (this.zzDungeonIndex-1)%8
    SetActive(tranGroup1.gameObject,wheelIndex==0)
    SetActive(tranGroup2.gameObject,wheelIndex~=0)
    this.GetZZItemPro();
    this.SetTeachingLevel();
end

this.GetZZItemPro=function()
    local getCount=0;
    local maxCount=0;
    local records=DataMgr.Player.dungeonRecords
    for _i,_v in ipairs(zzDungeouList) do
        local isGet=records[_v.id]~=nil and records[_v.id].completeCount>0
        for i,v in ipairs(_v.firstDrop) do
            local items=ConfigMgr.Config.dropMap[v.id].items;
            for p,m in ipairs(items) do
                if m.id=="1" then
                    maxCount=maxCount+m.count;
                    if isGet then
                        getCount=getCount+m.count;
                    end
                end
            end
        end
    end
    this.getCount=getCount
    this.maxCount=maxCount;
end

this.SetTeachingLevel=function()
    SetActive(tranJC.gameObject,false)
    SetActive(tranJJ.gameObject,false)
    SetActive(tranSZ.gameObject,false)
    local levelDataList={}
    for i,v in ipairs(teachLevelList) do
        v.isLock=cfgUnlockCondition[i]~="0" and  (DataMgr.Player.dungeonRecords[cfgUnlockCondition[i]]==nil
                or DataMgr.Player.dungeonRecords[cfgUnlockCondition[i]].completeCount==0)
        v.type=i;
        v.events=cfgJobEvents[i]
        if cfgUnlockCondition[i]~="0" then
            local tip=LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[cfgUnlockCondition[i]].NameLan)
            v.text=string.format(LuaMgr.GetLangText("AreaTeachingViewModel_2"),tip)
        end
        v.callBack=this.OnClickLevelCommand;
        v.zzInfo=i==3 and {
            getCount=this.getCount,
            maxCount=this.maxCount,
            cur=this.zzDungeonIndex==nil and #zzDungeouList or this.zzDungeonIndex-1,
            max=#zzDungeouList
        } or nil;
        v.redId="1174_"..i
        local levelData=UIListData.GetData(this.teachingLevelItemObj,"Teaching_LevelItem",v);
        table.insert(levelDataList,levelData);
    end
    this.contentList:SetData(levelDataList,true);
end

this.SetJobData=function(popList,jobEvents,pos,index)
    local dataList={}
    local reward=ConfigMgr.Config.constants.TeachingReward[1];
    for i,v in ipairs(jobEvents) do
        local dungeonRecords=DataMgr.Player.dungeonRecords[v.unlockParam];
        local isActive=v.unlockParam=="" or (dungeonRecords~=nil and dungeonRecords.completeCount>0);
        local jobItem={}
        jobItem.icon=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(reward.id))
        jobItem.pos = pos[i];
        jobItem.active = isActive;
        jobItem.name=LuaMgr.GetLangText(cfgDungeou[v.id].NameLan);
        jobItem.dungeonId=v.id;
        jobItem.eventId=v.eventParam;
        jobItem.noPass=DataMgr.Player.dungeonRecords[v.id]==nil or DataMgr.Player.dungeonRecords[v.id].completeCount==0;
        jobItem.unlockParam=v.unlockParam;
        jobItem.callBack=this.OnClickJobCommand
        jobItem.type=index
        local itemData=UIListData.GetData(this.jcItemObj,"Teaching_JCItem",jobItem)
        table.insert(dataList,itemData);
    end
    popList:SetData(dataList,true);
end

 this.SetJobSZData=function()
     SetActive(tranDone.gameObject,this.zzDungeonIndex==nil);
     SetActive(tranComfrom.gameObject,this.zzDungeonIndex~=nil);
     SetActive(tranLevel.gameObject,this.zzDungeonIndex~=nil);
     if this.zzDungeonIndex==nil then
         this.SetPetalsState(8)
         return
     end
     this.zzDungeon=zzDungeouList[this.zzDungeonIndex];

     textGroup.text=LuaMgr.GetLangText(this.zzDungeon.descriptionLan)
     textInfo.text=LuaMgr.GetLangText(this.zzDungeon.NameLan)
     this.itemList={}

     for i,v in ipairs(this.zzDungeon.firstDrop) do
         local drop=ConfigMgr.Config.dropMap[v.id];
         if drop~=nil then
             for p,m in ipairs(drop.items) do
                 local item=nil
                 if #itemPool==0 then
                     item=GoodsDataItem.New(tranRewardContent)
                 else
                     item=itemPool[1];
                     table.remove(itemPool,1);
                 end
                 local itemConfig = ConfigMgr.Config.itemMap[m.id]
                 itemConfig["count0"] =m.count*v.count
                 item:SetData(1,itemConfig,1,false,Vector3(0.6,0.6,0.6),false)
                 table.insert(this.itemList,item);
             end
         end
     end

     this.SetJobSZ_Petal();
 end

this.AddItemPool=function()
    for i,v in ipairs(this.itemList) do
        table.insert(itemPool,v);
    end
end

this.SetPetalsState=function(index,callBack)
    for i,v in ipairs(petalsList) do
        local obj=v:GetChild(0).gameObject;
        if i-1<index then
            SetActive(obj,false)
        else
            SetActive(obj,true)
            if callBack~=nil then
                callBack(obj);
            end
        end
    end
end

this.SetJobSZ_Petal=function()
    local curPetalIndex=this.zzDungeonIndex==nil and 8 or (this.zzDungeonIndex-1)%8
    if not this.isShow then
        this.SetPetalsState(curPetalIndex,function(v)

            if curPetalIndex==0 and this.zzDungeonIndex<#zzDungeouList then
                local dissolveController=v:GetComponent(typeof(CS.Laigu.Art.UIDissolveController))
                if dissolveController~=nil then
                    dissolveController.DissolveStep=0.24;
                end
            end
        end)
        this.SetTranLevelInfo(curPetalIndex+1,this.zzDungeonIndex)
        local tarParent=petalsList[curPetalIndex+1]:GetChild(2).transform
        tranHuoyan.transform.parent=tarParent
        tranHuoyan.localPosition=Vector3(0,0,0)
        SetActive(tranHuoyan.gameObject,false)
        SetActive(tranHuoyan.gameObject,true)
    else
        this.isShow=false
        if curPetalIndex==0 and this.zzDungeonIndex~=1 then

            this.SetNextSheel(curPetalIndex+1);
            return
        end
        this.ShowDOAnimation(curPetalIndex);
    end
    
end

this.ShowDOAnimation=function(curPetalIndex)
    this.SetPetalsState(curPetalIndex-1);
    if curPetalIndex==0 then
        this.SetTranLevelInfo(curPetalIndex+1,this.zzDungeonIndex)
        SetActive(tranGroup.gameObject,true)
        return
    end
    SetActive(tranGroup.gameObject,false)
    this.SetTranLevelInfo(curPetalIndex,this.zzDungeonIndex-1)
    this.DoNumMove(curPetalIndex+1);
    this.DoPetalDissove(curPetalIndex)
end


this.SetTranLevelInfo=function(index,dungeonIndex)
    local tarParent=petalsList[index]:GetChild(1).transform
    tranLevel.transform.parent=tarParent
    tranLevel.anchoredPosition=Vector2(0,0)
    textLevel.text=dungeonIndex
end

this.SetNextSheel=function(index)
    SetActive(tranLevel.gameObject,false)
    local controller=nil;
    for i,v in ipairs(petalsList) do
        local petal=v:GetChild(0):GetComponent("Image");
        petal.material=template_petalLan.material;
        local dissolveController=petal.transform:GetComponent(typeof(CS.Laigu.Art.UIDissolveController))
        if dissolveController==nil then
            dissolveController=petal.gameObject:AddComponent(typeof(CS.Laigu.Art.UIDissolveController))
        end
        if dissolveController~=nil then
            dissolveController.DissolveStep=0.78;
        end
        if controller==nil then
            controller=dissolveController
        end
    end
    controller.enabled=false;
    DOTWeen.To(function() return 0.68  end,function(vetor)
        controller.enabled=true;
        controller.dissolveStep=vetor
    end,0.24,1):SetDelay(1).onComplete=function()
        SetActive(tranLevel.gameObject,true)
        local tarParent=petalsList[index]:GetChild(2).transform
        tranHuoyan.transform.parent=tarParent
        tranHuoyan.localPosition=Vector3(0,0,0)
        SetActive(tranHuoyan.gameObject,false)
        SetActive(tranHuoyan.gameObject,true)
        SetActive(tranHuoyan.gameObject,false)
        SetActive(tranHuoyan.gameObject,true)
        this.SetTranLevelInfo(index,this.zzDungeonIndex)
    end;
    
end

this.DoNumMove=function(tarIndex)
    local tarParent=petalsList[tarIndex]:GetChild(1).transform
    tranLevel.transform.parent=tarParent
    local tweener=tranLevel.transform:DOLocalMove(Vector3(0,0,0),0.3):SetDelay(1):SetEase(CS.DG.Tweening.Ease.Linear);
    tweener.onComplete=function()
        textLevel.text=this.zzDungeonIndex;
         tarParent=petalsList[tarIndex]:GetChild(2).transform
        tranHuoyan.transform.parent=tarParent
        tranHuoyan.localPosition=Vector3(0,0,0)
        SetActive(tranHuoyan.gameObject,false)
        SetActive(tranHuoyan.gameObject,true)
    end
    
end

this.DoPetalDissove=function(tarIndex)
    local petal=petalsList[tarIndex]:GetChild(0):GetComponent("Image");
    petal.material=template_petalLan.material;
    local dissolveController=petal.transform:GetComponent(typeof(CS.Laigu.Art.UIDissolveController))
    if dissolveController==nil then
        dissolveController=petal.gameObject:AddComponent(typeof(CS.Laigu.Art.UIDissolveController))
    end
    if dissolveController~=nil then
        dissolveController.DissolveStep=0.24;
        local tarStep=0.68
        DOTWeen.To(function() return dissolveController.DissolveStep  end,function(vetor)
            dissolveController.DissolveStep=vetor
        end,tarStep,2):SetDelay(2)
    end
    coroutine_runner.start(function()
        coroutine_runner.wait(1.7)
        local tarParent=petalsList[tarIndex]:GetChild(2).transform
        tranEffboom.transform.parent=tarParent
        tranEffboom.localPosition=Vector3(0,0,0)
        SetActive(tranEffboom.gameObject,true)
        coroutine_runner.wait(0.8)
        SetActive(tranGroup.gameObject,true)
        SetActive(tranEffboom.gameObject,false)
    end)
end


return vm({
    data = data,
    command = command,
    hook = hook
})