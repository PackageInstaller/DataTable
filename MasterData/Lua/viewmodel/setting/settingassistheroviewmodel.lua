require("ViewModel/Setting/AssistHero_HeadGroup")
require("ViewModel/Setting/AssistHero_HeadItem")
require("ViewModel/Setting/AssistHero_CardItem")

SettingAssistHeroViewModel = {}

SettingAssistHeroViewModel.__index = SettingAssistHeroViewModel
local objs = {
    scrollViewObj = {path = "group/headList/ScrollView", type = "GameObject"},
    tranCardContent={path = "group/tranCardList", type = "Transform"},
    goRewardPop={path = "group/rewardPop", type = "GameObject"},
    tranRewardContent={path = "group/rewardPop/tranReward", type = "Transform"},
    txtRewardDes={path = "group/rewardPop/des", type = "Text"},
    txtRewardPro={path = "group/rewardPop/pro", type = "Text"},
    tranCardList={path = "group/tranCardList", type = "Transform"},
    btnConform={path = "group/btnConform", type = "Button"},
    btnJump={path = "group/btnJump", type = "Button"},
    btnReward={path = "group/btnReward", type = "Button"},
    btnCancel = {path = "group/btnCancel", type = "Button"},
    goNoCard={path = "group/goNoCard", type = "GameObject"},
    txtAssistCount={path = "group/AssistCount/txtAssistCount", type = "Text"},
}

function SettingAssistHeroViewModel.New()
    local self = {}
    setmetatable(self, SettingAssistHeroViewModel)
    return self
end

function SettingAssistHeroViewModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.headGroupScrollView=UIScrollView.New(self.scrollViewObj)
    self.cardUIList=UIListView.New(self.tranCardList)
    self.characterList={}
    self.colMax=8
    self.curHeadItemData=nil;
    self.rewardsItem={}
    self.clickStop=false;
    LuaMgr.AddClick(self.btnConform,function()
        self:BtnConformCommand()
    end)
    LuaMgr.AddClick(self.btnJump,function()
        self:BtnJumpCommand();
    end)
    LuaMgr.AddClick(self.btnCancel,function()
        self:BtnCancelCommand()
    end)
    LuaMgr.AddClick(self.btnReward,function()
        self:BtnRewardCommand();
    end)
end


function SettingAssistHeroViewModel:BtnConformCommand()
    if self.curHeadItemData==nil then return end;
    if self.clickStop then return end;
    self.clickStop=true;
    local helpIds={};
    if not IsNull(DataMgr.Player.FriendHelp) and not IsNull(DataMgr.Player.FriendHelp.HelpCharacterIds) and #DataMgr.Player.FriendHelp.HelpCharacterIds>0 then
        helpIds=DataMgr.Player.FriendHelp.HelpCharacterIds;
    end
    if #helpIds>=ConfigMgr.Config.FriendConstants.LendSupport then

        table.remove(helpIds,1);
    end
    table.insert(helpIds,self.curHeadItemData.id)
    PlayerAssistMgr.LendFriendsHelp(helpIds,function()
        self.clickStop=false;
        self.curHeadItemData.isAssist=true;
        self:SetAssistCardList();
        self:UpdateData();
    end)
    
end


function SettingAssistHeroViewModel:BtnJumpCommand()
    if self.curHeadItemData~=nil then
        HeroParameter.SettingHeroData=self.curHeadItemData;
        PlayerAssistMgr.ClearCurAssistData();
        PlayerAssistMgr.GoToPanel_HeroInfo(self.curHeadItemData.id,nil)
    end
end

function SettingAssistHeroViewModel:BtnCancelCommand()
    if self.curHeadItemData==nil then return end;
    if self.clickStop then return end;
    self.clickStop=true;
    local helpIds={};
    if not IsNull(DataMgr.Player.FriendHelp) and not IsNull(DataMgr.Player.FriendHelp.HelpCharacterIds) and #DataMgr.Player.FriendHelp.HelpCharacterIds>0 then
        helpIds=DataMgr.Player.FriendHelp.HelpCharacterIds;
    end
    if #helpIds>0 then
        for i=1,#helpIds,1 do
            if helpIds[i]==self.curHeadItemData.id then
                table.remove(helpIds,i);
            end
        end
    end
    PlayerAssistMgr.LendFriendsHelp(helpIds,function()
        self.clickStop=false;;
        self.curHeadItemData.isAssist=false;
        self:SetAssistCardList();
        self:UpdateData();
    end)
end
function SettingAssistHeroViewModel:BtnRewardCommand()
    self.isRewardPop=not self.isRewardPop
    SetActive(self.goRewardPop,self.isRewardPop);
    if self.isRewardPop then
        self:ShowRewardPopInfo();
    end
end


function SettingAssistHeroViewModel:ShowRewardPopInfo()
    local alReadlyCount=DataMgr.Player.FriendHelp.AlreadyCount

    local totalCount=ConfigMgr.Config.FriendConstants.RewardLimit;
    local rewards=ConfigMgr.Config.FriendConstants.DailyReward;
    local remainCount=totalCount-alReadlyCount;
    remainCount=remainCount<0 and 0 or remainCount;
    self.txtRewardPro.text=string.format("<color=#1d9978>%s</color>/%s",remainCount,totalCount);
    for i,v in ipairs(rewards) do
        if self.rewardsItem[i]==nil then
            self.rewardsItem[i]=GoodsDataItem.New(self.tranRewardContent);
        end
        local itemConfig = ConfigMgr.Config.itemMap[v.id];
        itemConfig.count0 = v.count;
        self.rewardsItem[i]:SetData(1, itemConfig, 1, false, Vector3(0.6,0.6,1), false);
    end
end


function SettingAssistHeroViewModel:CheckGetReward()
    if RedMgr.Singleton:CheckRedCondition("16100") then
        RedMgr.Singleton:FrushRedCondition("16100")
        HeroRedDataHelper.SetSettingAssistRed();
        RedMgr.Singleton:Refresh();
    end
    if DataMgr.Player.FriendHelp.CanCount>0 then
        PlayerAssistMgr.FriendHelpReward(function()
            HeroRedDataHelper.SetSettingAssistRed();
            RedMgr.Singleton:Refresh();
        end)
    end
end


function SettingAssistHeroViewModel:SetData()
    self:CheckGetReward();
    self.curHeadItemData=nil;
    self.clickStop=false;
    local curSelectId=nil
    if HeroParameter.SettingHeroData~=nil then
        self.curHeadItemData=HeroParameter.SettingHeroData;
        curSelectId=self.curHeadItemData.id;
    end
    self.group={}
    local assistHeros={}
    local HelpCharacterIds={}
    if not IsNull(DataMgr.Player.FriendHelp) and not IsNull(DataMgr.Player.FriendHelp.HelpCharacterIds) and #DataMgr.Player.FriendHelp.HelpCharacterIds>0 then
        HelpCharacterIds=DataMgr.Player.FriendHelp.HelpCharacterIds;
    end
    for i,v in ipairs(HelpCharacterIds) do
        assistHeros[v]=v;
    end
    if curSelectId==nil then

        if #HelpCharacterIds>0 then
            curSelectId=HelpCharacterIds[1];
        end
    end
    SetActive(self.btnCancel.gameObject,curSelectId~=nil);
    local characters=table.Copy(DataMgr.Player.characters);

    self.characterList={}
    for i,v in pairs(characters) do
        local cfgCharacter=ConfigMgr.Config.characterTable[v.id];
        if cfgCharacter~=nil then
            local chItem={
                rare=cfgCharacter.rare;
                job=cfgCharacter.job;
                level=v.level,
                id=v.id,
                curSkin=v.curSkin,
                name=cfgCharacter.namelan,
                isSelect= curSelectId~=nil and curSelectId==v.id,
                isAssist=assistHeros[v.id]~=nil;
            }
            chItem.sortNum=chItem.isAssist and 1 or 0;
            table.insert(self.characterList,chItem);
            if self.curHeadItemData==nil and chItem.isSelect then
                self.curHeadItemData=chItem;
            end
        end
    end
    local btnType=0;
    if self.curHeadItemData~=nil then
        btnType=self.curHeadItemData.isAssist and 2 or 1;
    end
    self:SetButtonsState(btnType);

    self:SetSort();

    local group={}
    local row=math.ceil(#self.characterList/self.colMax);
    local index=nil;
    for i=1,row,1 do
        local groupList={}
        for j=1,self.colMax,1 do
            index=(i-1)*self.colMax +j;
            if self.characterList[index]~=nil then
                table.insert(groupList,self.characterList[index])
            end
        end
        table.insert(group,groupList);
    end

    self.group=group;
    self:SetScrollViewList();
    self:SetAssistCardList();
    self.isRewardPop=false;
    SetActive(self.goRewardPop,self.isRewardPop);
end



function SettingAssistHeroViewModel:UpdateData()
    local assistHeros={}
    if not IsNull(DataMgr.Player.FriendHelp) and not IsNull(DataMgr.Player.FriendHelp.HelpCharacterIds) and #DataMgr.Player.FriendHelp.HelpCharacterIds>0 then
        for i,v in ipairs(DataMgr.Player.FriendHelp.HelpCharacterIds) do
            assistHeros[v]=v;
        end
    end
    for i,v in ipairs(self.group) do
        for index,value in pairs(v) do
            value.isAssist=assistHeros[value.id]~=nil
            if value.id==self.curHeadItemData.id then
                value.isSelect=true;
            end
        end
    end
    self.headGroupScrollView:Refresh();
    local typeType=self.curHeadItemData.isAssist and 2 or 1;
    self:SetButtonsState(typeType)
end




function SettingAssistHeroViewModel:SetSort()
    table.sort(self.characterList,function(a, b)
        local rareA = HeroMgr.GetHeroNowRare(a.id)
        local rareB = HeroMgr.GetHeroNowRare(b.id)
        if a.sortNum==b.sortNum then
            if rareA == rareB then
                if a.level==b.level then
                    return a.id<b.id
                end
                return a.level>b.level;
            else
                return rareA > rareB
            end
        else
            return a.sortNum>b.sortNum;
        end
    end)
end

function SettingAssistHeroViewModel:SetScrollViewList()
    self.headGroupScrollView:Clear()
    self.groupCallBack=function(id,rowIndex,colIndex)
        self:GroupCallBack(id,rowIndex,colIndex);
    end
    local list={}
    for i,v in ipairs(self.group) do
        local groupItem={
            groupIndex=i,
            headItemObj=self.headItemObj;
            dataList=v;
            groupCallBack=self.groupCallBack,
        }
        local groupData=UIScrollData.GetData(self.headGroupObj,"AssistHero_HeadGroup",980,87,groupItem)
        table.insert(list,groupData);
    end
    self.headGroupScrollView:SetParams(980,194)
    self.headGroupScrollView:SetData(list,true);
end

function SettingAssistHeroViewModel:GroupCallBack(id,groupIndex,locIndex)

    local groupData=self.headGroupScrollView.dataList[groupIndex]
    local headItemData=groupData.data.dataList[locIndex]
    if self.curHeadItemData~=nil and self.curHeadItemData.id~=headItemData.id then
        self.curHeadItemData.isSelect=false;
    end
    headItemData.isSelect=true;
    self.curHeadItemData=headItemData;

    for i,v in pairs(self.headGroupScrollView.itemMap) do
        for index,value in ipairs(v.headUIList.itemList) do
            value:SetSelect(value.data.character.id==id);
        end
    end
    local typeType=self.curHeadItemData.isAssist and 2 or 1;
    self:SetButtonsState(typeType)
end


function SettingAssistHeroViewModel:UpdateButtonState()
    SetActive(self.btnConform.gameObject,not self.curHeadItemData.isAssist);
    SetActive(self.btnCancel.gameObject,self.curHeadItemData.isAssist);
end

function SettingAssistHeroViewModel:SetButtonsState(type)
    SetActive(self.btnCancel.gameObject,type==2);
    SetActive(self.btnConform.gameObject,type==1)
    SetActive(self.btnJump.gameObject,type>0)
end


function SettingAssistHeroViewModel:SetAssistCardList()
    self.cardUIList:Clear();
    local helpIds={};
    if not IsNull(DataMgr.Player.FriendHelp) and not IsNull(DataMgr.Player.FriendHelp.HelpCharacterIds) and #DataMgr.Player.FriendHelp.HelpCharacterIds>0 then
        helpIds=DataMgr.Player.FriendHelp.HelpCharacterIds;
    end
    SetActive(self.goNoCard,#helpIds==0);
    local max=ConfigMgr.Config.FriendConstants.LendSupport;
    self.txtAssistCount.text=string.format("%s/%s",max-#helpIds,max)
    if #helpIds==0 then return end;
    local list={}
    for i,v in ipairs(helpIds) do
        local dataCharacter=DataMgr.Player.characters[v]
        local cfgCharacter=ConfigMgr.Config.characterTable[v];
        local cardItem={
            name=LuaMgr.GetLangText(cfgCharacter.namelan),
            level=dataCharacter.level,
            rare=cfgCharacter.rare,
            job=cfgCharacter.job,
            star=dataCharacter.star>0 and dataCharacter.star or -1;
            id=dataCharacter.id,
            curSkin=dataCharacter.curSkin;
        }
        local cardData=UIListData.GetData(self.cardItemObj,"AssistHero_CardItem",cardItem);
        table.insert(list,cardData);
    end
    self.cardUIList:SetData(list);
    
end


function SettingAssistHeroViewModel:Clear()
    self.data=nil;
end


function SettingAssistHeroViewModel:Destroy()
    self.gameObject = nil
    UIScrollView.ClearItem("AssistHero_HeadGroup")
    UIListView.ClearItem("AssistHero_HeadItem")
    UIListView.ClearItem("AssistHero_CardItem")
end