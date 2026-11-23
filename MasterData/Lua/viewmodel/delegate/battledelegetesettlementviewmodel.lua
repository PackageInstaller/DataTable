




require("ViewModel/Delegate/Delegate_FavorItem")
require("ViewModel/Delegate/Delegate_RewardGroup")
require("ViewModel/Delegate/Delegate_RewardItem")
local this = {vm=nil,
              result={},
              prePlayerLevel=nil,
              prePlayerExp=nil,
              preCharacters={},
              members={},
              curExp=nil,
              curLevel=nil,
              dungeonId=nil,
              favorItemObj=nil,
              favorUIList=nil,

              rewardItemObj=nil,
              addFavorNums=nil,
              totalItemMap={},
              totalEquipList={},
              tarItemCount=nil,
              totalTarItemCount=nil,
              intervalScale=nil,
              totalRewardUIList=nil,
              rootAnimator=nil;
              isDouble=false,
};

local cfgDuneon={}
local cfgLevelUpMap={}
local cfgMaxLevel=nil
local cfgFriendshipDescription={}
local cfgFavorShipUp=nil
local cfgMaxFavorValue=nil
local dataCharacters={}
local cfgDungeon={}
local coRewardKey=nil;
local expTweener=nil;
local isStop=nil;
local totalRewardsContent=nil;
local totalCoKey=nil;

local objs={
    tarRoot={path="root/Middle/midLeft/tar", type = "GameObject"},
    tarItemTf={path="root/Middle/midLeft/tar/Item", type = "Transform"},
    tarProText={path="root/Middle/midLeft/tar/pro", type = "Text"},
    dungeonName={path="root/Middle/midLeft/dungonInfo/dungonName", type = "Text"},
    levelText={path="root/Middle/midLeft/levelInfo/Info/level", type = "Text"},
    levelExpProText={path="root/Middle/midLeft/levelInfo/Info/pro", type = "Text"},
    levelExpSlider={path="root/Middle/midLeft/levelInfo/Info/slider", type = "Slider"},
    doneBtn={path="root/Middle/total/doneBtn",type="UIButtonClick"},
    totalObj={path="root/Middle/total",type="GameObject"},
    totalContentTF={path="root/Middle/total/ScrollView/Viewport/Content",type="Transform"},
    rewardsScrollView={path="root/Middle/midRight/rewardInfo/ScrollView",type="ScrollRect"},
    bgBtn={path="root/BG",type="UIButtonClick"},
    totalCanvas={path="root/Middle/total",type="Canvas"},
    doubleObj={path="root/Middle/total/isDouble",type="GameObject"},
    doubleText={path="root/Middle/total/isDouble/Text",type="Text"},



}



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        UITool.Parse(vm.behaviour,this,objs);
        this.favorUIList = UIListView.New(vm.behaviour.transform:Find("root/Middle/midLeft/favorableInfo/content"));
        this.favorItemObj=vm.behaviour.transform:Find("template/favorItem").gameObject;
        this.scrollListContent=vm.behaviour.transform:Find("root/Middle/midRight/rewardInfo/ScrollView/Viewport/Content");
        this.scrollList = UIListView.New(this.scrollListContent)
        this.rewardGroupObj=vm.behaviour.transform:Find("template/rewardGroup").gameObject;
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        totalRewardsContent=vm.behaviour.transform:Find("root/Middle/total/ScrollView/Viewport/Content");
        this.totalRewardUIList=UIListView.New(totalRewardsContent);
        this.rootAnimator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:PopupBack(this.DoneBtnCommand);
            LuaMgr.AddClick(this.doneBtn,this.DoneBtnCommand);
            LuaMgr.AddClick(this.bgBtn,this.BgBtnCommand);
            local data=vm.behaviour.Params
            this.tarItemCount=0;
            this.bgBtn.enabled=true;
            this.totalItemMap={};
            this.totalEquipList={};
            this.intervalScale=1;
            this.result=data[0]
            this.preCharacters=data[1].characters
            this.members=data[2]
            this.dungeonId=data[3]
            cfgDuneon =ConfigMgr.Config.dungeonMap[this.dungeonId];
            cfgLevelUpMap=ConfigMgr.Config.playerLevelUp;
            cfgMaxLevel=ConfigMgr.Config.constants.maxPlayerLevel
            cfgFriendshipDescription=ConfigMgr.Config.friendshipDescription;
            cfgFavorShipUp=ConfigMgr.Config.constants.BattleFriendshipUp;
            local len=NumTool.GetLen(ConfigMgr.Config.friendshipLevelUp)
            cfgMaxFavorValue=ConfigMgr.Config.friendshipLevelUp[tostring(len)];
            dataCharacters=DataMgr.Player.characters;
            cfgDungeon=ConfigMgr.Config.dungeonMap[this.dungeonId];
            this.prePlayerLevel=data[1].preLevel;
            this.prePlayerExp=data[1].preExp;
            isStop=false;
            SetActive(this.totalObj,false);
            this.rootAnimator:Play("UI_BattleDelegateSettlementPanel_chuxian");
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then return end;
        LuaMgr.RemoveClick(this.doneBtn,this.DoneBtnCommand);
        LuaMgr.RemoveClick(this.bgBtn,this.BgBtnCommand);

        this.favorUIList:Clear(true);
        this.scrollList:Clear(true);
        this.totalRewardUIList:Clear(true);
        LuaMgr.InvokeUIEventListeners(UIEventConst.FatigueReply)
        LuaMgr.InvokeUIEventListeners(UIEventConst.UpdateBattlePrepareInfos)
        if totalCoKey~=nil then
            coroutine_runner.stop(totalCoKey);
        end
        if coRewardKey~=nil then
            coroutine_runner.stop(coRewardKey);
        end
        
    end,
    before_destroy=function()
       UIListView.ClearItem("Delegate_FavorItem")
        UIListView.ClearItem("Delegate_RewardGroup")
        UIListView.ClearItem("Delegate_RewardItem")
    end
}


this.ParseData=function()
    this.SetBaseInfo();

    this.SetFavorable();
    this.SetRewardsData();

    this.SetTotalRewards();
end

this.SetBaseInfo=function()
   this.dungeonName.text=LuaMgr.GetLangText(cfgDuneon.NameLan)
    local tarItem=HeroParameter.TarItem
    if tarItem==nil then
        SetActive(this.tarRoot,false)
    else
        SetActive(this.tarRoot,true)
        this.tarItemCount=0;
        this.tarProText.text= string.format("<color=#41746f><size=34>%s</size></color>/%s",0,tarItem.count);
        local item=GoodsDataItem.New(this.tarItemTf)
        local itemConfig = ConfigMgr.Config.itemMap[tarItem.id]
        itemConfig["count0"] = tarItem.count
        item:SetData(1,itemConfig,1,false,Vector3(0.5,0.5,0.5),false,true)
    end
    this.curExp=this.prePlayerExp-cfgLevelUpMap[tostring(this.prePlayerLevel)].exp;
    this.curLevel=this.prePlayerLevel
    this.levelText.text=this.curLevel
end

this.SetLevelInfo=function(deltaExp,ptime) 
    if deltaExp==0 or deltaExp==nil then return end;
    local time=ptime==nil and 0.25 or ptime
    if cfgLevelUpMap[tostring(this.curLevel+1)]==nil then
        return;
    end
    local maxExp=cfgLevelUpMap[tostring(this.curLevel+1)].exp-cfgLevelUpMap[tostring(this.curLevel)].exp;
    local runExp=this.curExp;
    local usedExp=0
    expTweener=DOTWeen.To(function() return 0 end,function(exp)

        if runExp+exp-usedExp>maxExp then
            this.curLevel=this.curLevel+1;
            maxExp=cfgLevelUpMap[tostring(this.curLevel+1)].exp-cfgLevelUpMap[tostring(this.curLevel)].exp;
            runExp=0;
            usedExp=exp;
            this.levelText.text=this.curLevel;
        end
        exp=math.floor(exp);
        this.levelExpProText.text=string.format("<color=#41746f><size=20>%s</size></color>/%s",math.floor(runExp+exp-usedExp),maxExp)
        this.levelExpSlider.value=(runExp+exp-usedExp)/maxExp;
        this.curExp=runExp+exp-usedExp
    end,deltaExp,time):SetEase(Ease.Linear)
end

this.SetFavorable=function()
    if cfgDungeon==nil then return end;
    local staminaConst=nil;
    this.addFavorNums = {}
    for i,v in ipairs(cfgDungeon.consumeItem) do
if v.id=="101" then
            staminaConst=v.count;
            break;
        end
    end
    if staminaConst==nil then
        print("dungeonMap consumItem is null,dungeonId:",this.dungeonId);
        staminaConst=1;
    end

    local list={};
    for i,v in pairs(this.members) do
        local addFavorShipUp= cfgFavorShipUp*staminaConst;
        local prestige=dataCharacters[v].prestige;
        local pIsMax=dataCharacters[v].prestigeLevel>=10;
        if prestige == cfgMaxFavorValue then
addFavorShipUp=0
        end
        table.insert(this.addFavorNums,addFavorShipUp)
        local favorItem={
            characterId=v,
            bgSprite=LuaMgr.GetSprite("BattleRes",pIsMax and "ui_zd_js_txd_01" or "ui_zd_js_txd_02");
            frameSprite=LuaMgr.GetSprite("BattleRes",pIsMax and "ui_zd_js_txk_01" or "ui_zd_js_txk_02");
            iconTexture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(v,dataCharacters[v].curSkin)),
            favorNum = pIsMax and LuaMgr.GetLangText(cfgFriendshipDescription["10"].descriptionLan) or string.format("+%s",addFavorShipUp),
            isMax=pIsMax
        }
        local favorData=UIListData.GetData(this.favorItemObj,"Delegate_FavorItem",favorItem);
        table.insert(list,favorData);
    end
    this.favorUIList:SetData(list)
end

this.ShowFavorableFX=function(index)
    local addFavorShipUp = nil
    local character = nil
    for i = 1, #this.favorUIList.itemList do
        addFavorShipUp = this.addFavorNums[i] * index
        character = dataCharacters[this.favorUIList.itemList[i].data.characterId]
        if character.prestige == cfgMaxFavorValue then
            addFavorShipUp = 0
        end
        this.favorUIList.itemList[i]:SetAddFavor("+"..addFavorShipUp)
    end
end


this.SetRewardsData=function()
    this.isDouble=false;
    local list={}
    this.scrollListContent.anchoredPosition=Vector2.zero;
    if this.result==nil or #this.result==0 then return end;
    for i,v in ipairs(this.result) do
        local groupItem={
            numText=i<10 and "0"..i or i,
            itemList={},
            equipList={},
            itemObj=this.rewardItemObj
        }
        if not IsNull(this.result[i].deltaRewards.Items)  then
            for p,m in pairs(this.result[i].deltaRewards.Items) do
                table.insert(groupItem.itemList,{id=m.id,count=m.count,extra=false})
                if this.totalItemMap[m.id]==nil then
                    this.totalItemMap[m.id]={id=m.id,count=m.count,type=1,extra=false};
                else
                    this.totalItemMap[m.id].count=this.totalItemMap[m.id].count+m.count;
                end
            end
        end
        if not IsNull(this.result[i].deltaRewards.Equipments) then
            for p,m in pairs(this.result[i].deltaRewards.Equipments) do
                local equipData=table.Copy(DataMgr.Player.equipments[m])
                local config = ConfigMgr.Config.equipments[equipData.equipmentId]
                equipData.rare = config.rare
                equipData.wearBool =false
                equipData.choose = false
                equipData.extra=false,
                table.insert(groupItem.equipList,equipData)
                table.insert(this.totalEquipList,equipData)
            end
        end

            if not IsNull(this.result[i].extraDeltaRewards) and #this.result[i].extraDeltaRewards>0 then
                if this.result[i].extraDeltaRewards[1].ActivityName=="ActivityDouble" then
                    this.isDouble=true
                end
                if not IsNull(this.result[i].extraDeltaRewards[1].Items) then
                    for p,m in pairs(this.result[i].extraDeltaRewards[1].Items) do
                        table.insert(groupItem.itemList,{id=m.id,count=m.count,extra=true})
                        if this.totalItemMap[m.id]==nil then
                            this.totalItemMap[m.id]={id=m.id,count=m.count,type=1,extra=true};
                        else
                            this.totalItemMap[m.id].count=this.totalItemMap[m.id].count+m.count;
                        end
                    end
                end
                if not IsNull(this.result[i].extraDeltaRewards[1].Equipments) then
                    for p,m in pairs(this.result[i].deltaRewards.Equipments) do
                        local equipData=table.Copy(DataMgr.Player.equipments[m])
                        local config = ConfigMgr.Config.equipments[equipData.equipmentId]
                        equipData.rare = config.rare
                        equipData.wearBool =false
                        equipData.choose = false
                        equipData.extra=true
                        table.insert(groupItem.equipList,equipData)
                        table.insert(this.totalEquipList,equipData)
                    end
                end
            end

        local rowCount=math.ceil((#groupItem.itemList+#groupItem.equipList)/5);
        rowCount=rowCount<1 and 1 or rowCount
        local height=40+72*rowCount+(rowCount-1)*10;
        groupItem.height=height;
        local groupData=UIListData.GetData(this.rewardGroupObj,"Delegate_RewardGroup",groupItem)
        table.insert(list,groupData);
    end
    local posY=0;
    local totalHeight=0;
    this.scrollList:SetData(list);
    for i,v in ipairs(list) do
        this.scrollList.itemList[i].transform.anchoredPosition=Vector2(0,-posY);
        totalHeight=totalHeight+v.data.height;
        posY=totalHeight;
    end
    this.scrollListContent.sizeDelta=Vector2(550,totalHeight);

    this.ShowRewardsFX();
end

this.ScrollListDoMove=function(height,delay,callBack)
    delay=delay==nil and 0 or delay;
    local tarPosY=this.scrollListContent.anchoredPosition.y+height
    DOTWeen.To(function() return this.scrollListContent.anchoredPosition.y  end,function(y)
        this.scrollListContent.anchoredPosition=Vector2(0,y);
    end
    ,tarPosY,height*0.001):SetEase(Ease.Linear):SetDelay(delay).onComplete=function()
        if callBack~=nil then
            callBack();
        end
    end;
end

this.ShowRewardsFX=function()
    this.rewardsScrollView.vertical=false
    if coRewardKey~=nil then
        coroutine_runner.stop(coRewardKey);
    end
    coRewardKey=coroutine_runner.start(function()
        coroutine_runner.wait(1)
        local totalHeight=0;
        for i,v in ipairs(this.scrollList.itemList) do

            if v~=nil then
                totalHeight=totalHeight+v.data.data.height;
                if totalHeight>340 then
                    this.ScrollListDoMove(v.data.data.height);
                    coroutine_runner.wait(0.2*this.intervalScale)
                end
                v:CoroutineSetActive(this.CheckCompleteTarItem,this.intervalScale);
                this.ShowFavorableFX(i);
                this.SetLevelInfo(this.result[i].deltaExp,0.25*this.intervalScale)
                coroutine_runner.wait(0.8)
            end
        end
        this.rewardsScrollView.vertical=true
        this.bgBtn.enabled=false;
        this.SetCheckMatchLevelUp();
        this.TotalRewardDoMove();
    end)
   
end


this.ShowPlayerUp=function()
    local levelUp=this.result[1].deltaRewards.LevelUp;
    if IsNull(levelUp) then return end;
    if #this.result>1 then
        levelUp.level=DataMgr.Player.level
        levelUp.exp=DataMgr.Player.exp
        levelUp.stamina=DataMgr.Player.stamina
        levelUp.isLevelUp=levelUp.level>levelUp.origLevel
    end
    if not IsNull(levelUp) and levelUp.isLevelUp then
        this.totalCanvas.sortingOrder=20;
        local jsonStr=json.encode(levelUp);
        coroutine_runner.start(function()
            coroutine_runner.wait(0.2)
            LuaMgr.ShowPlayerLevelUp(jsonStr);
        end)
    end
end



this.SetTotalRewards=function()
    local isRe,count=ActivityMgr.DoubleRewards_CheckDungeonID(cfgDuneon.id,this.isDouble);
    SetActive(this.doubleObj,this.isDouble and count>0)
    if this.isDouble then
        this.doubleText.text=ActivityMgr.DoubleRewards_ProText();
    end
    totalRewardsContent.anchoredPosition=Vector2(0,0);
    this.totalTarItemCount=0;
    local itemList={}
    for i,v in pairs(this.totalItemMap) do
        local itemConfig = ConfigMgr.Config.itemMap[i]
        v.isSpecial=itemConfig.isSpecial>0
        v.type=1
        v.rare=itemConfig.rare;
        table.insert(itemList,v);
    end
    for i,v in ipairs(this.totalEquipList) do
        v.type=2
        v.isSpecial=false
        v.isVisiable=false
        table.insert(itemList,v)
    end
    table.sort(itemList,function(a, b) return a.rare>b.rare end)
    if HeroParameter.TarItem~=nil then
        for i,v in ipairs(itemList) do
            if v.id==HeroParameter.TarItem.id then
                this.totalTarItemCount=v.count
            end
        end
    end
    local dataList={}
    local count=#itemList>10 and #itemList or 10
    for i=1,count do
        local item=i<=#itemList and itemList[i] or {};
        local itemData=UIListData.GetData(this.rewardItemObj,"Delegate_RewardItem",item);
        table.insert(dataList,itemData);
    end
    this.totalRewardUIList:SetData(dataList,true);
end

this.TotalRewardDoMove=function(callBack)
    totalRewardsContent.anchoredPosition=Vector2.zero;
    SetActive(this.totalObj,true);
    this.rootAnimator:Play("UI_BattleDelegateSettlementPanel_finish")
    totalCoKey=coroutine_runner.start(function()
        coroutine_runner.wait(0.1)
        for i,v in ipairs(this.totalRewardUIList.itemList) do
            if v.data.data.type~=nil then
                if v.data.data.isSpecial then
                    coroutine_runner.wait(0.15)
                    v:SetActiveFX(true,true);
                    coroutine_runner.wait(0.75)
                else
                    coroutine_runner.wait(0.1)
                    v:SetActiveFX(false,true);
                end
            end
            if i==11 then
                this.DOMoveContent()
            end
        end
        coroutine_runner.wait(0.3)
        this.rootAnimator:Play("UI_BattleDelegateSettlementPanel_wancheng")
        coroutine_runner.wait(0.2)
        if callBack~=nil then
            callBack();
        end
    end)
end


this.DOMoveContent=function()
    local totalCount=#this.totalRewardUIList.itemList;
    local width=(totalCount-9)*72;
    DOTWeen.To(function() return Vector2.zero  end,function(vector)
        totalRewardsContent.anchoredPosition=vector;
    end,Vector2(-width,0),0.15*(totalCount-9));
end

this.CheckCompleteTarItem=function(itemId,itemCount)
    if HeroParameter.TarItem~=nil and itemId==HeroParameter.TarItem.id then
        this.tarItemCount=this.tarItemCount+itemCount;
        this.tarItemCount=this.tarItemCount>this.totalTarItemCount and this.totalTarItemCount or this.tarItemCount;
        this.tarProText.text= string.format("<color=#41746f><size=34>%s</size></color>/%s",this.tarItemCount,HeroParameter.TarItem.count);
    end
end


this.DoneBtnCommand=function()
    HeroParameter.EmptyTarItem()
    LuaMgr.HidePanel(UIName.BattleDelegeteSettlementViewModel)
end


this.BgBtnCommand=function()
    this.bgBtn.enabled=false;
    if coRewardKey~=nil then
        coroutine_runner.stop(coRewardKey);
    end
    if expTweener~=nil then
        expTweener:Kill();
    end
    for i,v in ipairs(this.scrollList.itemList) do
        v:SetActive(this.CheckCompleteTarItem);
    end
    this.ShowFavorableFX(#this.result);
    this.rewardsScrollView.vertical=true
    this.SetCheckMatchLevelUp();
    this.TotalRewardDoMove();
    this.ScrollListDoMove(this.scrollListContent.sizeDelta.y-342-this.scrollListContent.anchoredPosition.y,0.5);
end

this.SetCheckMatchLevelUp=function()
    local levelUp=cfgLevelUpMap[tostring(DataMgr.Player.level)];
    local nextLevelUp=cfgLevelUpMap[tostring(DataMgr.Player.level+1)];
    local totalExp,nowExp=0,0
    if nextLevelUp~=nil then
        totalExp=nextLevelUp.exp-levelUp.exp;
        nowExp=DataMgr.Player.exp-levelUp.exp;
    end
    this.levelText.text=DataMgr.Player.level
    this.levelExpProText.text=string.format("<color=#41746f><size=20>%s</size></color>/%s",nowExp,totalExp)
    this.levelExpSlider.value=nowExp/totalExp;
end


























































return vm({
    data = data,
    command = command,
    hook = hook
})