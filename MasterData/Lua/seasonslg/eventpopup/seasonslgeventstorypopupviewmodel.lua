
require("SeasonSLG/EventPopUp/EventStoryItem")
local this = {
   storyUIList={};
   storyItemObj=nil;
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goPanel1 = uiLink:Get("goPanel1");
    ui.goPanel2 = uiLink:Get("goPanel2");
    ui.goReward = uiLink:Get("goReward");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnAccept = uiLink:Get("btnAccept"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.txtAccept = uiLink:Get("txtAccept"):GetComponent("Text");
    ui.txtTitle2 = uiLink:Get("txtTitle2"):GetComponent("Text");
    ui.txtDes2 = uiLink:Get("txtDes2"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.tranReward = uiLink:Get("tranReward"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end

this.ClearUI = function()
    ui = nil
end



this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventStoryPopupViewModel)
    end)
    uiLink:AddClickEvent("btnAccept",function()
        this.GetReward();
    end)

end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.storyUIList=UIListView.New(ui.tranContent);
        this.storyItemObj=vm.behaviour.transform:Find("template/storyItem").gameObject;
        this.rewardItemList={}
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            this.storyId=vm.behaviour.Params[0];
            this.ParseData();
        end

    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.storyUIList:Clear();
    end,
    before_destroy = function()
       UIListView.ClearItem("EventStoryItem")
        this.ClearUI();
    end
}

this.ParseData=function()
    SetActive(ui.goPanel1,true)
    SetActive(ui.goPanel2,false);
    this.eventStory=ConfigMgr.Config.SeasonalEventStoryMap[this.storyId];
    ui.txtTitle.text=LuaMgr.GetLangText(this.eventStory.NameLan);
    ui.txtDes.text=LuaMgr.GetLangText(this.eventStory.DescLan);
    this.SetEventUIList();
end

this.SetEventUIList=function()
    this.storyUIList:Clear();
    local list={};
    local optionStr=LuaMgr.GetLangText(this.eventStory.OptionLan)
    local optionArray=NumTool.split(optionStr,"|");
    for i,v in ipairs(optionArray) do
        local consume=this.eventStory.Consume[i]==nil and this.eventStory.Consume[1] or this.eventStory.Consume[i];
        local myCount=DataHelper.GetItemCountById(consume.id);
        local item={
            index=i,
            des=v,
            cost=consume,
            isMatch=myCount>=consume.count;
            callBack=this.StoryCallBack
        }
        local itemData=UIListData.GetData(this.storyItemObj,"EventStoryItem",item);
        table.insert(list,itemData);
    end
    this.storyUIList:SetData(list);
end

this.StoryCallBack=function(index)
    if not SeasonSLGMapMgr.CheckBlockIsUnLock(tostring(SeasonSLGEventMgr.curGridIndex),SeasonSLGMapMgr.CheckTriggerEventCoverByTime()) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventStoryPopupViewModel_0"));
        return;
    end

    if not this.storyUIList.dataList[index].data.isMatch then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventStoryPopupViewModel_1"))
        return;
    end
    this.optionIndex=index;
    if not TableIsNull(this.eventStory.SubConnect) and #this.eventStory.SubConnect >= this.optionIndex then
        local eventId = this.eventStory.SubConnect[this.optionIndex][2]
        this.cfgDungeon=ConfigMgr.Config.SeasonalEventDungeonMap[eventId];
        local dungeonTag=IsNullOrEmpty(SeasonSLGEventMgr.curTimedEventId) and "normal" or "timed"

        SeasonSLGEventMgr.pendingStoryResult={storyId=this.storyId,optionIndex=this.optionIndex,gridIndex=SeasonSLGEventMgr.curGridIndex}
        LuaMgr.HidePanel(UIName.SeasonSlGEventStoryPopupViewModel)
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.SeasonSLG,eventId,"1", SeasonSLGEventMgr.curGridIndex,dungeonTag,this.RandomDungeon(),tostring(this.optionIndex - 1),this.eventStory.Id)
    else
        SetActive(ui.goPanel1,false)
        SetActive(ui.goPanel2,true);
        this.SetSubPanelInfo();
        this.ShowReward();
    end
end

this.SetSubPanelInfo=function()
    local subNameStr=LuaMgr.GetLangText(this.eventStory.SubNameLan)
    local subDesStr=LuaMgr.GetLangText(this.eventStory.SubDescLan)
    local subOptionStr=LuaMgr.GetLangText(this.eventStory.SubOptionLan)
    local subNames=NumTool.split(subNameStr,"|")
    local subDes=NumTool.split(subDesStr,"|")
    local subOptions=NumTool.split(subOptionStr,"|")
    ui.txtTitle2.text=this.optionIndex>#subNames and subNames[1] or subNames[this.optionIndex];
    ui.txtDes2.text=this.optionIndex>#subDes and subDes[1] or subDes[this.optionIndex];
    ui.txtAccept.text=this.optionIndex>#subOptions and subOptions[1] or subOptions[this.optionIndex];
end

this.RandomDungeon = function()
    local dungs = {}
    local seasonalDungeonRecords = DataMgr.Player.SeasonalDungeonRecords or {}
    local usedDungs = seasonalDungeonRecords[this.cfgDungeon.Id] or {}
    for i = 1, #this.cfgDungeon.Dungeons do
        local cur = this.cfgDungeon.Dungeons[i]
        local fund = false
        for k, v in pairs(usedDungs) do
            if cur == v then
                fund = true
                break
            end
        end
        if not fund then
            table.insert(dungs, cur)
        end
    end

    if #dungs <= 0 then
        LuaDebug.error("err no dungenons")
        return this.cfgDungeon.Dungeons[1]
    end

    local r = math.random(1,#dungs)
    return dungs[r]
end

this.ShowReward=function()
    local rewardList=this.eventStory.Reward;
    if this.optionIndex==2 then
        rewardList=this.eventStory.Reward2;
    elseif this.optionIndex==3 then
        rewardList=this.eventStory.Reward3;
    end
    this.ClearRewardItem();
    if not IsNull(rewardList) and #rewardList>0 then
        SetActive(ui.goReward,true);
        for i,v in ipairs(rewardList) do
            if this.rewardItemList[i]==nil then
                this.rewardItemList[i]=GoodsDataItem.New(ui.tranReward)
            end
            local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
            itemData.count0 = v.count;
            SetActive(this.rewardItemList[i].gameObject,true);
            this.rewardItemList[i]:SetData(1, itemData, 1, false, Vector3(0.5,0.5,0.5), false);
        end
    else
        SetActive(ui.goReward,false);
    end
end

this.ClearRewardItem=function()
    if NumTool.GetLen(this.rewardItemList)>0 then
        for i,v in pairs(this.rewardItemList) do
            SetActive(v.gameObject,false);
        end
    end
end

this.GetReward=function()
    if this.optionIndex==nil then return end;
    SeasonSLGAPI.OnAskSeasonalStory(SeasonSLGEventMgr.curGridIndex,this.storyId,this.optionIndex,function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventStoryPopupViewModel);
        SeasonSLGAPI.OnAskBlockUnlockProgress(tostring(SeasonSLGEventMgr.curGridIndex),function()
            if this.eventStory.Next>0 then
                SeasonSLGEventMgr.DOGridEventContinue();
            end
        end)
    end)
end



return vm({
    data = data,
    command = command,
    hook = hook
})