





require("ViewModel/AreaTeaching/JoinJobNovel_TabItem")
require("ViewModel/AreaTeaching/JoinJobNovel_CardItem")
local this = {
    vm=nil,
    novelBarList={},
    novelDataMap={},
    tabUIList=nil,
    novelUIScroll=nil;
    curTabIndex=nil,
    dataEntryEvents={},
    cfgUnlockEnterStory={}
};
local tabItemObj=nil;
local novelItemObj=nil

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local ScrollViewTab = nil;
local ScrollViewNovel = nil;
local tranContentTab = nil;
local tranContentNovel = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    ScrollViewTab = uiLink:Get("ScrollViewTab"):GetComponent("ScrollRect");
    ScrollViewNovel = uiLink:Get("ScrollViewNovel"):GetComponent("ScrollRect");
    tranContentTab = uiLink:Get("tranContentTab"):GetComponent("RectTransform");
    tranContentNovel = uiLink:Get("tranContentNovel"):GetComponent("RectTransform");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    ScrollViewTab = nil;
    ScrollViewNovel = nil;
    tranContentTab = nil;
    tranContentNovel = nil;

end

this.TabBtnCommmand=function(index)
    if this.curTabIndex==index then return end;
    this.curTabIndex=index;
    this.SetTabState();
end

this.CardBtnCommand=function(data)
    if not data.unLock then
        local tips=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12000"].NameLan);
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips);
        return;
    end
    if not data.isCan then
        local tips=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12001"].NameLan);
        local itemName=LuaMgr.GetLangText(ConfigMgr.Config.itemMap[this.cfgUnlockEnterStory[1]].nameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tips,itemName))
        return;
    end
    HeroParameter.SaveJoinJobNovelTab(this.curTabIndex)
    LuaMgr.PlayNovel(data.eventParam,function()
        LuaMgr.ShowLuaPanel(UIName.JoinJobNovelViewModel)
    end)
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        tabItemObj=vm.behaviour.transform:Find("template/tabItem").gameObject;
        novelItemObj=vm.behaviour.transform:Find("template/novelItem").gameObject;
        this.tabUIList=UIListView.New(tranContentTab)
        this.novelUIScroll=UIScrollView.New(ScrollViewNovel)
        RedMgr.Singleton:RegisterViewModel(UIName.JoinJobNovelViewModel);
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.ParseData();
            vm.behaviour:UpdateTopBar("", this.OnBack);
        end
    end,
    before_deactive = function(vm)
        this.tabUIList:Clear();
        this.novelUIScroll:Clear();
    end,
    before_destroy=function()
        UIListView.ClearItem("JoinJobNovel_TabItem")
        UIScrollView.ClearItem("JoinJobNovel_CardItem")
        this.Clear()
    end
}

this.OnBack=function()
    HeroParameter.EmptyJoinJobNovelTab()
    LuaMgr.Back();
end

this.ParseData=function()
    HeroRedDataHelper.SetJoinJobRed();
    this.novelBarList=DataExHelper.EX_GetGroupListByArea("entry");
    this.novelDataMap=DataExHelper.EX_GetEventMapByArea("entry")
    this.dataEntryEvents=DataMgr.Player.activityMaps["entry"].activityEvents;
    if IsNull(this.dataEntryEvents) then
        this.dataEntryEvents={}
    end
    this.cfgUnlockEnterStory=ConfigMgr.Config.constants.UnlockEnterStory;
    this.SetTabList();
end

this.SetTabList=function()
    local dataList={}
    for i,v in ipairs(this.novelBarList) do
        local tabItem={
            tabIcon=LuaMgr.GetSprite("JoinJob","ui_rz_scjhy_tab"..i),
            tabDes=LuaMgr.GetLangText(v.DescriptionLan),
            tabIsOn=i==this.curTabIndex,
            tabUnLock=true,
            tabLockInfo="",
            callBack=this.TabBtnCommmand,
            index=i,
            redId="1172_"..i
        }
        if v.unlockParam~="" then
            tabItem.tabUnLock=DataMgr.Player.dungeonRecords[v.unlockParam]~=nil and DataMgr.Player.dungeonRecords[v.unlockParam].completeCount>0;
            if not tabItem.tabUnLock then
                local str=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12002"].NameLan)
                local tip=LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[v.unlockParam].NameLan)
                tabItem.tabLockInfo=string.format(str,tip);
            end
        end
        local tabData=UIListData.GetData(tabItemObj,"JoinJobNovel_TabItem",tabItem)
        table.insert(dataList,tabData);
    end
    this.curTabIndex=1;







    if HeroParameter.JoinJobNovelTabIndex~=nil then
        this.curTabIndex=HeroParameter.JoinJobNovelTabIndex
        HeroParameter.JoinJobNovelTabIndex=nil;
    end
    
    this.tabUIList:SetData(dataList,true);
    this.SetTabState()
    this.SetNovelList();
end

this.SetTabState=function()
    for i,v in ipairs(this.tabUIList.itemList) do
        v:SetTabIsOn(i==this.curTabIndex);
    end
    this.SetNovelList();
end

this.SetNovelList=function()
    this.novelUIScroll:Clear();
    local novelData=this.novelDataMap[this.novelBarList[this.curTabIndex].id];
    if novelData==nil then return end;
    local count=#novelData;
    local scrollWidth=LuaMgr.GetScreenWidth()-300
    local offsetX=LuaMgr.GetScreenWidth()-1280
    local dataList={}
    for i,v in ipairs(novelData) do
        local unLock=v.unlockParam=="" or this.dataEntryEvents[v.unlockParam]~=nil and this.dataEntryEvents[v.unlockParam].complete
        local pass=this.dataEntryEvents[v.id]~=nil and this.dataEntryEvents[v.id].complete
        local isEnough=unLock and DataHelper.GetItemCountById(v.itemExpend[1].id)>=tonumber(v.itemExpend[1].count) 
        local isFirst=not pass and isEnough
        local cardItem={
            unLock=unLock,
            isCan=isEnough or pass,
            isTip=not pass and v.itemExpend[1].count>0,
            isFirst=isFirst,
            costId=this.cfgUnlockEnterStory[1],
            costCount=this.cfgUnlockEnterStory[2],
            name=LuaMgr.GetLangText(v.namelan);
            callBack=this.CardBtnCommand,
            eventParam=v.eventParam,
            iconName=v.cover
        }
        local width=330+offsetX/4;
        local cardData=UIScrollData.GetData(novelItemObj,"JoinJobNovel_CardItem",width,440,cardItem)
        table.insert(dataList,cardData)
    end
    ScrollViewNovel.transform.anchoredPosition=Vector2(300+offsetX/2,-29)
    this.novelUIScroll:SetParams(scrollWidth, 446)
    this.novelUIScroll:SetData(dataList,true);
    coroutine_runner.start(function()
        for i,v in ipairs(this.novelUIScroll.screenList) do
            v:SetActive();
            coroutine_runner.wait(0.1)
        end
        coroutine_runner.wait(1.5)

        LuaMgr.HidePanel(UIName.JoinJobLoadingViewModel)
    end)
end


return vm({
    data = data,
    command = command,
    hook = hook
})