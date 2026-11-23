require("ViewModel/Rogue/Rogue_BagBuffItem")
require("ViewModel/Rogue/Rogue_BagHeroItem")
require("ViewModel/Rogue/Rogue_BagBuffTypeItem")

local this = {
    vm = nil,
    type=1;
    cardItemObj =nil,
    cardUIList={},
    buffUIList={},
    buffItemObj=nil;
    buffTypeUIList={},
    buffTypeItemObj=nil,
    curBuffType=nil;
    buffList={},
};




local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.goHeroIsOn = uiLink:Get("goHeroIsOn");
    ui.goBuffIsOn = uiLink:Get("goBuffIsOn");
    ui.Right = uiLink:Get("Right");
    ui.goHeroBtns = uiLink:Get("goHeroBtns");
    ui.goRareIsOn = uiLink:Get("goRareIsOn");
    ui.goHZIsOn = uiLink:Get("goHZIsOn");
    ui.Middle = uiLink:Get("Middle");
    ui.goNo = uiLink:Get("goNo");
    ui.goHeroScrollView = uiLink:Get("goHeroScrollView");
    ui.goBuffPanel = uiLink:Get("goBuffPanel");
    ui.goBuffInfo = uiLink:Get("goBuffInfo");
    ui.btnHero = uiLink:Get("btnHero"):GetComponent("Button");
    ui.btnBuff = uiLink:Get("btnBuff"):GetComponent("Button");
    ui.btnRare = uiLink:Get("btnRare"):GetComponent("Button");
    ui.btnHZ = uiLink:Get("btnHZ"):GetComponent("Button");
    ui.rect = uiLink:Get("rect"):GetComponent("RectTransform");
    ui.tranHeroContent = uiLink:Get("tranHeroContent"):GetComponent("RectTransform");
    ui.tranTopContent = uiLink:Get("tranTopContent"):GetComponent("RectTransform");
    ui.tranBuffContent = uiLink:Get("tranBuffContent"):GetComponent("RectTransform");
    ui.imgRare = uiLink:Get("imgRare"):GetComponent("Image");
    ui.imgBuff = uiLink:Get("imgBuff"):GetComponent("Image");
    ui.txtBuffName = uiLink:Get("txtBuffName"):GetComponent("Text");
    ui.txtBuffDes = uiLink:Get("txtBuffDes"):GetComponent("Text");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end





this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnHero",function()
        this.SwitchType(1);
    end)
    uiLink:AddClickEvent("btnBuff",function()
        this.SwitchType(2);
    end)
    uiLink:AddClickEvent("btnRare",function()
        this.SortHeroList(1);
        this.SetHeroList()
    end)
    uiLink:AddClickEvent("btnHZ",function()
        this.SortHeroList(2);
        this.SetHeroList();
    end)
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.cardUIList = UIListView.New(ui.tranHeroContent);
        this.buffUIList=UIListView.New(ui.tranBuffContent);
        this.buffTypeUIList=UIListView.New(ui.tranTopContent);
        this.buffItemObj = vm.behaviour.transform:Find("template/bagBuffItem").gameObject
        this.buffTypeItemObj = vm.behaviour.transform:Find("template/typeItem").gameObject
        this.cardItemObj=vm.behaviour.transform:Find("template/RogueHeroCardItem").gameObject
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then     
            this.type=nil;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if this.cardUIList~= nil then
            this.cardUIList:Clear();
        end
        if this.buffUIList~= nil then
            this.buffUIList:Clear();
        end
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Rogue_BagBuffItem")
        UIListView.ClearItem("Rogue_BagHeroItem")
        UIListView.ClearItem("Rogue_BagBuffTypeItem")
    end
}

this.ParseData=function()
    this.heroList={}
    local characters={};
    if not IsNull(DataMgr.Player.Rogue) and not IsNull(DataMgr.Player.Rogue.Characters)  then
        local heroIdList={}
        for i,v in pairs(DataMgr.Player.Rogue.Characters) do
            table.insert(heroIdList,v.CharacterId);
        end
        characters=RogueMgr.GetCharacterDatasByIDList(heroIdList);
    end
    for i,v in pairs(characters) do
        local cfgCharacter=ConfigMgr.Config.characterTable[v.id];
        local rare=cfgCharacter.rare
        if not IsNull(v.brilliant) then
            rare=rare+ v.brilliant.RareLevel
        end
        v.name=LuaMgr.GetLangText(cfgCharacter.namelan);
        v.job=cfgCharacter.job;
        v.isHZ=not IsNull(v.brilliant) and rare > 4;
        v.isNoHZ=not IsNull(v.brilliant) and rare <= 4
        v.rare=rare>5 and 4 or rare;
        table.insert(this.heroList,v);
    end
    this.buffIds={}
    if not IsNull(DataMgr.Player.Rogue) and not IsNull(DataMgr.Player.Rogue.BuffIds) then
        this.buffIds=DataMgr.Player.Rogue.BuffIds;
    end
    this.SortHeroList(1);
    this.SwitchType(1);
    
end


this.SwitchType=function(index)
    if this.type==index then return end;
    this.type=index;
    this.SetButtonState(index);
    if this.type==1 then
        this.SetHeroList();
    else
        this.SetBuffPanel()
    end
end

this.SetButtonState=function(index)
    SetActive(ui.goHeroIsOn,index==1)
    SetActive(ui.btnHZ.gameObject,index==1);
    SetActive(ui.btnRare.gameObject,index==1);
    SetActive(ui.goBuffIsOn,index==2)
    SetActive(ui.goHeroScrollView,index==1);
    SetActive(ui.goBuffPanel ,index==2);
    SetActive(ui.goNo,index==1 and #this.heroList==0)
    SetActive(ui.goBuffInfo,false);
end


this.SortHeroList=function(sortType)
    SetActive(ui.goRareIsOn,sortType==1);
    SetActive(ui.goHZIsOn,sortType==2);
    if sortType==1 then
        table.sort(this.heroList,function(a, b)
            if a.rare==b.rare then
                return a.id<b.id;
            else
                return a.rare>b.rare;
            end
        end)
    else
        table.sort(this.heroList,function(a, b)
            if (a.isHZ and b.isHZ) or (not a.isHZ and not b.isHZ) then
                if a.rare==b.rare then
                    return a.id<b.id;
                else
                    return a.rare>b.rare;
                end
            else
                return a.isHZ and not b.isHZ
            end
        end)
    end
end

this.SetHeroList=function()
    this.cardUIList:Clear();
    local list={}
    for i,v in pairs(this.heroList) do
        local cardItem= {
            index=i,
            id = v.id,
            data = v;
            isChoice = false,
            scale=0.9,
            callback = this.HeroCallBack,
            exploreLevel=RogueExploreMgr.GetCharacterExploreLevel(v.id);
        }
        local cardData=UIListData.GetData(this.cardItemObj,"Rogue_BagHeroItem",cardItem);
        table.insert(list,cardData);
    end
    this.cardUIList:SetData(list);
    
end

this.HeroCallBack=function(index)
    local characterId=this.heroList[index].id
    RogueMgr.ShowCharacterDetailInfo(characterId)
end

this.SetBuffPanel=function()
    this.SetBuffTypeList();
end

this.SetBuffTypeList=function()
    this.buffTypeUIList:Clear();
    this.curBuffType=1;
    local list={}

    for i=1,8,1 do
        local topItem={
            type=i;
            isOn=i==this.curBuffType;
            callBack=this.BuffTypeCallBack
        }
        local topData=UIListData.GetData(this.buffTypeItemObj,"Rogue_BagBuffTypeItem",topItem);
        table.insert(list,topData);
    end
    this.buffTypeUIList:SetData(list);
    this.SwitchBuffType();
end

this.BuffTypeCallBack=function(type)
    if this.curBuffType==type then return end;
    this.curBuffType=type;
    for i,v in ipairs(this.buffTypeUIList.itemList) do
        v:SetSelect(i==type);
    end
    this.SwitchBuffType();
end

this.SwitchBuffType=function()

    local buffGenre=this.curBuffType-1;
    this.buffList=RogueMgr.GetBuffListByGenreBuff(this.buffIds,buffGenre)
    this.SetBuffList();
end

this.SetBuffList=function()
    this.buffUIList:Clear();
    SetActive(ui.goNo,#this.buffList==0);
    SetActive(ui.goBuffInfo,#this.buffList>0);
    if #this.buffList>0 then
        this.buffIndex=nil;
        local list={}
        for i,v in ipairs(this.buffList) do
            local buffItem={
                index=i,
                rare=v.BuffQuality,
                icon=v.BuffIcon,
                name=LuaMgr.GetLangText(v.BuffNameLan);
                isOn=i==this.buffIndex,
                callBack=this.BuffCallBack,
            }
            local buffData=UIListData.GetData(this.buffItemObj,"Rogue_BagBuffItem",buffItem);
            table.insert(list,buffData);
        end
        this.buffUIList:SetData(list);
        this.BuffCallBack(1);
    end
end

this.BuffCallBack=function(index)
    if this.buffIndex~=nil and this.buffIndex==index then
        return;
    end
    this.buffIndex=index;
    for i,v in ipairs(this.buffUIList.itemList) do
        v:SetSelect(i==this.buffIndex);
    end
    local curBuffInfo=this.buffList[this.buffIndex]
    this.SetBuffDetailInfo(curBuffInfo)
end

this.SetBuffDetailInfo=function(buffInfo)
    ui.imgRare.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_csqzxbfd_0"..buffInfo.BuffQuality);
    ui.imgBuff.sprite=LuaMgr.GetSprite("BuffIcon",buffInfo.BuffIcon);
    ui.txtBuffName.text=LuaMgr.GetLangText(buffInfo.BuffNameLan);
    ui.txtBuffDes.text=LuaMgr.GetLangText(buffInfo.BuffDesLan);
end

return vm({
    data = data,
    command = command,
    hook = hook
})