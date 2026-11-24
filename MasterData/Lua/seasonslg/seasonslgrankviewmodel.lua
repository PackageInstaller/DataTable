
require("SeasonSLG/Rank_BarItem")
require("SeasonSLG/Rank_SubBarItem")
require("SeasonSLG/Rank_HeadItem")
require("SeasonSLG/Rank_ContributionItem")
require("SeasonSLG/Rank_ResourceItem")
require("SeasonSLG/Rank_BossItem")
require("SeasonSLG/Rank_RewardItem")

local this = {
    bossRankView = {};
    resourceRankView = {};
    contributionRankView = {};
    barUIList = {};
    subBarUIList = {};
    bossRankItemObj = nil;
    resourceRankItemObj = nil;
    contributionRankItemObj = nil;
    barItemObj = nil;
    subBarItemObj = nil;
    myMemberUIList={};
    rankRewardUIList={};
    rewardItemObj=nil;
}

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Middle = uiLink:Get("Middle");
    ui.goPanelBoss = uiLink:Get("goPanelBoss");
    ui.goBossScrollView = uiLink:Get("goBossScrollView");
    ui.goBossRankNone = uiLink:Get("goBossRankNone");
    ui.goPanelResourse = uiLink:Get("goPanelResourse");
    ui.goResourseScrollView = uiLink:Get("goResourseScrollView");
    ui.goPanelContribution = uiLink:Get("goPanelContribution");
    ui.goContributionScrollView = uiLink:Get("goContributionScrollView");
    ui.goMyRank = uiLink:Get("goMyRank");
    ui.goFrist = uiLink:Get("goFrist");
    ui.goSecond = uiLink:Get("goSecond");
    ui.goThrid = uiLink:Get("goThrid");
    ui.goOther = uiLink:Get("goOther");
    ui.goNone = uiLink:Get("goNone");
    ui.goLable = uiLink:Get("goLable");
    ui.goHeadInfo = uiLink:Get("goHeadInfo");
    ui.Right = uiLink:Get("Right");
    ui.goRewardPanel = uiLink:Get("goRewardPanel");
    ui.goFristReward = uiLink:Get("goFristReward");
    ui.goSecondReward = uiLink:Get("goSecondReward");
    ui.goThridReward = uiLink:Get("goThridReward");
    ui.goOtherReward = uiLink:Get("goOtherReward");
    ui.goNoneReward = uiLink:Get("goNoneReward");
    ui.goHeadInfoReward = uiLink:Get("goHeadInfoReward");
    ui.UIFX = uiLink:Get("UIFX"):GetComponent("UIParticle");
    ui.tranBarList = uiLink:Get("tranBarList"):GetComponent("RectTransform");
    ui.tranSubBarList = uiLink:Get("tranSubBarList"):GetComponent("RectTransform");
    ui.tranBossHeroList = uiLink:Get("tranBossHeroList"):GetComponent("RectTransform");
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");
    ui.txtMyBossRankScore = uiLink:Get("txtMyBossRankScore"):GetComponent("Text");
    ui.txtMyResourseProduct = uiLink:Get("txtMyResourseProduct"):GetComponent("Text");
    ui.txtMyResourseProgress = uiLink:Get("txtMyResourseProgress"):GetComponent("Text");
    ui.txtMyContributionProduct = uiLink:Get("txtMyContributionProduct"):GetComponent("Text");
    ui.txtMyContributionProgress = uiLink:Get("txtMyContributionProgress"):GetComponent("Text");
    ui.txtOrder = uiLink:Get("txtOrder"):GetComponent("Text");
    ui.txtName = uiLink:Get("txtName"):GetComponent("Text");
    ui.txtRankTime = uiLink:Get("txtRankTime"):GetComponent("Text");
    ui.txtRankText = uiLink:Get("txtRankText"):GetComponent("Text");
    ui.txtOrderReward = uiLink:Get("txtOrderReward"):GetComponent("Text");
    ui.txtNameReward = uiLink:Get("txtNameReward"):GetComponent("Text");
    ui.rawHeadIcon = uiLink:Get("rawHeadIcon"):GetComponent("RawImage");
    ui.rawHeadIconReward = uiLink:Get("rawHeadIconReward"):GetComponent("RawImage");
    ui.imgHeadFrame = uiLink:Get("imgHeadFrame"):GetComponent("Image");
    ui.imgHeadFrameReward = uiLink:Get("imgHeadFrameReward"):GetComponent("Image");
    ui.btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    ui.btnRankReward = uiLink:Get("btnRankReward"):GetComponent("Button");
    ui.btnRewardMask = uiLink:Get("btnRewardMask"):GetComponent("Button");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.SeasonSlGRankViewModel);
    end)
    uiLink:AddClickEvent("btnRankReward",function()
        this.SetRewardPanel();
    end)
    uiLink:AddClickEvent("btnRewardMask",function()
        SetActive(ui.goRewardPanel,false);
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.InitUI(vm.behaviour)
        this.myMemberUIList=UIListView.New(ui.tranBossHeroList)
        this.bossRankView=UIScrollView.New(ui.goBossScrollView);
        this.bossRankItemObj=vm.behaviour.transform:Find("template/bossRankItem").gameObject;
        this.resourceRankView=UIScrollView.New(ui.goResourseScrollView);
        this.resourceRankItemObj=vm.behaviour.transform:Find("template/resourceRankItem").gameObject;
        this.contributionRankView=UIScrollView.New(ui.goContributionScrollView);
        this.contributionRankItemObj=vm.behaviour.transform:Find("template/contributionRankItem").gameObject;
        this.barUIList=UIListView.New(ui.tranBarList);
        this.barItemObj=vm.behaviour.transform:Find("template/barItem").gameObject;
        this.subBarUIList=UIListView.New(ui.tranSubBarList);
        this.subBarItemObj=vm.behaviour.transform:Find("template/subBarItem").gameObject;
        this.rankHeadItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
        this.dynamicAvatar=vm.behaviour.transform:Find("root/Middle/goMyRank/goHeadInfo/DynamicAvatar"):GetComponent("PlayerDynamicAvatar");
        this.dynamicAvatarReward=vm.behaviour.transform:Find("root/goRewardPanel/BG/myRank/goHeadInfoReward/DynamicAvatar"):GetComponent("PlayerDynamicAvatar");

        this.rankRewardUIList=UIListView.New(ui.tranRewardContent);
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then return end
        SetActive(ui.goMyRank,false);
        this.isBarOpen=false;
        this.mainType=nil;
        this.subType=nil;
        if vm.behaviour.Params.Length>0 then
            this.mainType=vm.behaviour.Params[0]
        end
        if vm.behaviour.Params.Length>1 then
            this.subType=vm.behaviour.Params[1]
        end
        this.ParseCfg();
        SetActive(ui.goRewardPanel,false);
        this.ParseData();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then return end
        this.resourceRankView:Clear();
        this.bossRankView:Clear();
        this.contributionRankView:Clear();
        this.barUIList:Clear();
        this.subBarUIList:Clear();
        this.myMemberUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI();
        UIScrollView.ClearItem("Rank_ContributionItem")
        UIScrollView.ClearItem("Rank_BossItem")
        UIScrollView.ClearItem("Rank_ResourceItem")
        UIListView.ClearItem("Rank_BarItem")
        UIListView.ClearItem("Rank_SubBarItem")
        UIListView.ClearItem("Rank_HeadItem")
    end
}

this.ParseCfg=function()
    this.rankListMap={}
    local cfgRankingListMap=ConfigMgr.Config.SeasonalRankingListMap;
    for i,v in pairs(cfgRankingListMap) do
        if LuaMgr.Timestamp()>v.OpenTime  and LuaMgr.Timestamp()<v.EndTime then
            if this.rankListMap[v.MainType]==nil then
                this.rankListMap[v.MainType]={};
            end
            table.insert(this.rankListMap[v.MainType],v);
        end
    end
    for i,v in pairs(this.rankListMap) do
        table.sort(v,function(a, b)
            return a.SubType<b.SubType;
        end)
    end
    if this.mainType==nil and this.subType==nil then
        for i,v in ipairs(this.rankListMap) do
            this.subType=this.GetDefaultSubType(i)
            if this.subType~=nil then
                this.mainType=i;
            end
            break;
        end
    end
    SeasonSLGMapMgr.rankTimeInterval=this.rankListMap[1][1].SearchCD;
end


this.GetDefaultSubType=function(mainType)
    local defaultSubType=nil;
    for i,v in ipairs(this.rankListMap[mainType]) do
        if LuaMgr.Timestamp()>=v.OpenTime and LuaMgr.Timestamp()<v.EndTime then
            defaultSubType=i;
            break;
        end
    end
    return defaultSubType;
end


this.ParseData=function()
    this.ClearText();
    this.SetBarUIList();
end

this.SetBarUIList=function()
    this.barUIList:Clear();
    local list={};
    local len=NumTool.GetLen(this.rankListMap);
    for i=1,len do
        local barItem={
            index=i,
            name=LuaMgr.GetLangText(this.rankListMap[i][1].MainNameLan);
            isOn=i==this.mainType;
            pos=this.GetBarPosition(i);
            callBack=this.BarCallBack,
        }
        local barData=UIListData.GetData(this.barItemObj,"Rank_BarItem",barItem);
        table.insert(list,barData);
    end
    this.barUIList:SetData(list);
    if this.mainType~=nil then
        this.BarCallBack(this.mainType,true);
    end
end
this.GetBarPosition=function(i,barIndex)
    local posY=(i-1)*72;
    if barIndex~=nil and i>barIndex then
        local subLen=#this.rankListMap[barIndex];
        posY=posY+subLen*47
    end
    return Vector2(0,-posY);
end
this.BarCallBack=function(index,isJump)
    SetActive(ui.tranSubBarList.gameObject,false);
    if this.mainType==index and this.isBarOpen then
        this.isBarOpen=false;

        for i,v in ipairs(this.barUIList.itemList) do
            local newPosition=this.GetBarPosition(i);
            v:UpdateBarState(newPosition,i>this.mainType,false,false);
        end
    else
        this.mainType=index;
        this.isBarOpen=true;
        if not isJump then
            this.subType=this.GetDefaultSubType(index);
        end
        for i,v in ipairs(this.barUIList.itemList) do
            local newPosition=this.GetBarPosition(i,this.mainType);
            v:UpdateBarState(newPosition,i>this.mainType,i==this.mainType);
        end
        this.SetSubUIList();
    end
end

this.SetSubUIList=function()
    SetActive(ui.tranSubBarList.gameObject,true);
    ui.tranSubBarList.anchoredPosition=Vector2(0,-72*this.mainType);
    this.subBarUIList:Clear();
    local list={}
    local rankList=this.rankListMap[this.mainType];
    for i,v in ipairs(rankList) do
        local subBarItem={
            index=i,
            name=LuaMgr.GetLangText(v.SubNameLan);
            isOn=i==this.subType;
            callBack=this.SubBarCallBack,
            isUnlock=LuaMgr.Timestamp()>=v.OpenTime;
            isEnd=LuaMgr.Timestamp()>v.EndTime;
        }
        local subBarData=UIListData.GetData(this.subBarItemObj,"Rank_SubBarItem",subBarItem);
        table.insert(list,subBarData);
    end
    this.subBarUIList:SetData(list);
    this.SetPanel();
end

this.SubBarCallBack=function(index)
    if this.subType~=nil and this.subType==index then
        return;
    end
    if this.subBarUIList.dataList[index].data.isEnd then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGRankViewModel_0"))
        return;
    end
    if not this.subBarUIList.dataList[index].data.isUnlock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGRankViewModel_1"))
        return;
    end
    this.subType=index;
    for i,v in ipairs(this.subBarUIList.dataList) do
        v.data.isOn=i==this.subType;
    end
    this.subBarUIList:Refresh();
    this.SetPanel()
end

this.ClearText=function()
    SetActive(ui.btnRankReward.gameObject,false)
    ui.txtMyContributionProduct.text="";
    ui.txtMyResourseProduct.text=""
    ui.txtMyBossRankScore.text="";
end

this.SetPanel=function()
    SetActive(ui.goPanelBoss,this.mainType==1)
    SetActive(ui.goPanelResourse,this.mainType==2)
    SetActive(ui.goPanelContribution,this.mainType==3)
    SetActive(ui.goMyRank,this.subType~=nil);
    if this.subType==nil then
        this.ClearText();
        return
    end;
    if this.mainType==1 then
        this.SetBOSSView();
    elseif this.mainType==2 then
        this.SetResourceView();
    elseif this.mainType==3 then
        this.SetContributionView();
    end
end

this.SetMyHeadInfo=function(guidName)
    SetActive(ui.btnRankReward.gameObject,not IsNull(this.cfgCurRank.Reward) and #this.cfgCurRank.Reward>0)
    SetActive(ui.goHeadInfo,this.cfgCurRank.RankSubType~=2)
    SetActive(ui.goHeadInfoReward,this.cfgCurRank.RankSubType~=2)
    SetActive(ui.goLable,this.cfgCurRank.RankSubType~=2)
    ui.txtName.text=this.cfgCurRank.RankSubType~=2 and DataMgr.Player.name or guidName;
    ui.txtNameReward.text=this.cfgCurRank.RankSubType~=2 and DataMgr.Player.name or guidName;
    ui.txtRankText.text=this.cfgCurRank.RankSubType~=2 and LuaMgr.GetLangText("SeasonSlGRankViewModel_2") or LuaMgr.GetLangText("SeasonSlGRankViewModel_3")
    if this.cfgCurRank.RankSubType==2 then
        return;
    end
    local avatarPath,avatarFrame,isDynamicAvatar=ConfigHelper.GetAvatarAndAvatarFramePath(nil,nil);
    if not isDynamicAvatar then
        ui.rawHeadIcon.texture=LuaMgr.GetTexture(avatarPath);
        ui.rawHeadIconReward.texture=LuaMgr.GetTexture(avatarPath);
    else

        this.dynamicAvatar:AppointAvatar(DataMgr.Player.Avatar)
        this.dynamicAvatarReward:AppointAvatar(DataMgr.Player.Avatar);
    end
    SetActive(this.dynamicAvatar.gameObject,isDynamicAvatar)
    SetActive(this.dynamicAvatarReward.gameObject,isDynamicAvatar);
    SetActive(ui.rawHeadIcon.gameObject,not isDynamicAvatar)
    SetActive(ui.rawHeadIconReward.gameObject,not isDynamicAvatar)
    PlayerAvatarFrameTool.SetAvatarFrame(ui.imgHeadFrame, avatarFrame)
    PlayerAvatarFrameTool.SetAvatarFrame(ui.imgHeadFrameReward, avatarFrame)
end

this.SetMyRankInfo=function(rankData)
    this.rankData=rankData
    local guidName=(rankData==nil or IsNullOrEmpty(rankData.Name)) and LuaMgr.GetLangText("SeasonSlGRankViewModel_4") or rankData.Name
    this.SetMyHeadInfo(guidName);
    SetActive(ui.goFrist,rankData~=nil and rankData.Rank==1)
    SetActive(ui.goSecond,rankData~=nil and rankData.Rank==2)
    SetActive(ui.goThrid,rankData~=nil and rankData.Rank==3)
    SetActive(ui.goOther,rankData~=nil and rankData.Rank>=4 and rankData.Rank<=50)
    SetActive(ui.goNone,rankData==nil or rankData.Rank>50);
    SetActive(ui.goFristReward,rankData~=nil and rankData.Rank==1)
    SetActive(ui.goSecondReward,rankData~=nil and rankData.Rank==2)
    SetActive(ui.goThridReward,rankData~=nil and rankData.Rank==3)
    SetActive(ui.goOtherReward,rankData~=nil and rankData.Rank>=4 and rankData.Rank<=50)
    SetActive(ui.goNoneReward,rankData==nil or rankData.Rank>50);

    local startTime=os.date(LuaMgr.GetLangText("SeasonSlGRankViewModel_5"),this.cfgCurRank.OpenTime)
    local endTime=os.date(LuaMgr.GetLangText("SeasonSlGRankViewModel_6"),this.cfgCurRank.EndTime)
    ui.txtRankTime.text=string.format("%s-%s",startTime,endTime)
    if rankData~=nil then
        ui.txtOrder.text=rankData.Rank;
        ui.txtOrderReward.text=rankData.Rank;
    end
end

this.SetBOSSView=function()
    this.bossRankView:Clear();
    local list={};
    this.cfgCurRank=this.rankListMap[this.mainType][this.subType]
    local rankList=SeasonSLGMapMgr.commonRankData[this.cfgCurRank.Id];
    if IsNull(rankList) or #rankList==0 then
        SetActive(ui.goBossRankNone,true);
        this.SetMyRankInfo(nil)
        return
    end;
    SetActive(ui.goBossRankNone,false);

    local len=#rankList;
    local myRankData=rankList[len];
    if myRankData.Uid~=DataMgr.Player.uid then
        myRankData=nil;
    else
        len=len-1;
    end
    for i=1,len do
        local rankItem={
            index=i,
            callBack=this.BossRankLikeCallBack,
            headItemObj=this.rankHeadItemObj,
            rankData=rankList[i];
            isGuid=this.cfgCurRank.RankSubType==2;
        }
        local bossRankData=UIScrollData.GetData(this.bossRankItemObj,"Rank_BossItem",940,140,rankItem);
        table.insert(list,bossRankData);
    end
    this.bossRankView:SetParams(1000,436)
    this.bossRankView:SetData(list,true);
    this.SetMyRankInfo(myRankData);
    this.SetMyMemberUIList(myRankData)
end
this.SetMyMemberUIList=function(rankData)
    ui.txtMyBossRankScore.text=rankData~=nil and LuaMgr.NumFormat(rankData.Score) or 0;
    this.myMemberUIList:Clear();
    if rankData==nil then return end;
    local memberList={}
    for i,v in pairs(rankData.Members) do
        v.id=i;
        v.rare=SeasonSLGMapMgr.GetOtherPlayerCharacterRare(i,v.RareLevel);
        table.insert(memberList,v);
    end
    this.SortMember(memberList)
    local list={}
    for i,v in pairs(memberList) do
        local memberItem={
            id=v.id,
            level=v.Level,
            sLevel=v.SeasonalLevel,
            rare=v.rare,
        }
        local memberData=UIListData.GetData(this.rankHeadItemObj,"Rank_HeadItem",memberItem);
        table.insert(list,memberData);
    end
    this.myMemberUIList:SetData(list);
end

this.SortMember = function(members)
    table.sort(members,function(a, b)
        if not IsNullOrEmpty(a.Sort) and not IsNullOrEmpty(b.Sort) then
            return tonumber(a.Sort) < tonumber(b.Sort)
        end
        if a.Level==b.Level then
            if a.SeasonalLevel==b.SeasonalLevel then
                return a.rare>b.rare;
            end
            return a.SeasonalLevel>b.SeasonalLevel
        else
            return a.Level>b.Level
        end
    end)
end

this.BossRankLikeCallBack=function(index)

end

this.GetProgressFormat=function(rankId,progress)
    return "0%"
end

this.SetResourceView=function()
    this.resourceRankView:Clear();
    local list={};
    this.cfgCurRank=this.rankListMap[this.mainType][this.subType]
    local rankList=SeasonSLGMapMgr.commonRankData[this.cfgCurRank.Id];
    if IsNull(rankList) or #rankList==0 then
        ui.txtMyResourseProduct.text=0;

        this.SetMyRankInfo(nil)
        return
    end;

    local len=#rankList;
    local myRankData=rankList[len];
    if myRankData.Uid~=DataMgr.Player.uid then
        myRankData=nil;
    else
        len=len-1;
    end
    for i=1,len do
        local rankItem={
            index=i,
            callBack=this.BossRankLikeCallBack,
            rankData=rankList[i];
            isGuid=this.cfgCurRank.RankSubType==2;
        }
        local bossRankData=UIScrollData.GetData(this.resourceRankItemObj,"Rank_ResourceItem",940,140,rankItem);
        table.insert(list,bossRankData);
    end
    this.resourceRankView:SetParams(1000,436)
    this.resourceRankView:SetData(list,true);
    ui.txtMyResourseProduct.text=myRankData==nil and 0 or LuaMgr.NumFormat(myRankData.Score);

    this.SetMyRankInfo(myRankData)
end

this.SetContributionView=function()
    this.contributionRankView:Clear();
    local list={};
    this.cfgCurRank=this.rankListMap[this.mainType][this.subType]
    local rankList=SeasonSLGMapMgr.commonRankData[this.cfgCurRank.Id];
    if IsNull(rankList) or #rankList==0 then
        ui.txtMyContributionProduct.text=0;
        this.SetMyRankInfo(nil)
        return
    end;

    local len=#rankList;
    local myRankData=rankList[len];
    if myRankData.Uid~=DataMgr.Player.uid and myRankData.Uid~=DataMgr.Player.guildData.guildId then
        myRankData=nil;
    else
        len=len-1;
    end
    for i=1,len do
        local rankItem={
            index=i,
            callBack=this.BossRankLikeCallBack,
            rankData=rankList[i];
            isGuid=this.cfgCurRank.RankSubType==2;
        }
        local rankData=UIScrollData.GetData(this.contributionRankItemObj,"Rank_ContributionItem",940,140,rankItem);
        table.insert(list,rankData);
    end
    this.contributionRankView:SetParams(1000,436)
    this.contributionRankView:SetData(list,true);
    ui.txtMyContributionProduct.text=myRankData==nil and 0 or LuaMgr.NumFormat(myRankData.Score);
    this.SetMyRankInfo(myRankData)
end

this.SetRewardPanel=function()
    SetActive(ui.goRewardPanel,true);
    this.rankRewardUIList:Clear();
    local rankArea=this.cfgCurRank.RankArea;
    local list={}
    for i,v in ipairs(rankArea) do
        local rewardItem={
            ranArea=v;
            itemId=this.cfgCurRank.Reward[i];
        }
        local rewardData=UIListData.GetData(this.rewardItemObj,"Rank_RewardItem",rewardItem);
        table.insert(list,rewardData);
    end
    this.rankRewardUIList:SetData(list);
end


return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)