require("ViewModel/Rogue/Rogue_ExploreShopItem")

local this = {
    vm = nil,
    shopUIList={},
    shopItemObj=nil,
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.goPanelPop = uiLink:Get("goPanelPop");
    ui.goHead = uiLink:Get("goHead");
    ui.goBuff = uiLink:Get("goBuff");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.btnBag = uiLink:Get("btnBag"):GetComponent("Button");
    ui.btnRefrush = uiLink:Get("btnRefrush"):GetComponent("Button");
    ui.btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    ui.btnHero = uiLink:Get("btnHero"):GetComponent("Button");
    ui.btnBuy = uiLink:Get("btnBuy"):GetComponent("Button");
    ui.btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    ui.txtFrushCount = uiLink:Get("txtFrushCount"):GetComponent("Text");
    ui.txtHeadLevel = uiLink:Get("txtHeadLevel"):GetComponent("Text");
    ui.txtName = uiLink:Get("txtName"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    ui.rawFrushIcon = uiLink:Get("rawFrushIcon"):GetComponent("RawImage");
    ui.rawHeadIcon = uiLink:Get("rawHeadIcon"):GetComponent("RawImage");
    ui.rawCostIcon = uiLink:Get("rawCostIcon"):GetComponent("RawImage");
    ui.imgHeadRare = uiLink:Get("imgHeadRare"):GetComponent("Image");
    ui.imgHeadJob = uiLink:Get("imgHeadJob"):GetComponent("Image");
    ui.imgBuffRare = uiLink:Get("imgBuffRare"):GetComponent("Image");
    ui.imgBuffIcon = uiLink:Get("imgBuffIcon"):GetComponent("Image");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnBuy",function()
        this.BuyShopExecute();
    end);
    uiLink:AddClickEvent("btnExit",function()
        SetActive(ui.goPanelPop,false);
    end);
    uiLink:AddClickEvent("btnClose",function()
        SetActive(ui.goPanelPop,false);
    end);
    uiLink:AddClickEvent("btnHero",function()
        if this.buyIndex~=nil then
            local infoId=this.eventInfoList[this.buyIndex+1];
            RogueMgr.ShowCharacterDetailInfo(infoId)
        end
    end)
    uiLink:AddClickEvent("btnRefrush",function()
        local maxCount=ConfigMgr.Config.RogueConstants.RogueShopRefresh;
        local AddCount= RogueExploreMgr.CheckIsRefreshAddCount();
        maxCount=maxCount+AddCount;
        if this.curRefreshCount>=maxCount then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("26218"))
            return;
        end
        local mapId=RogueExploreMgr.GetCurMapID();
        local eventNumber=RogueExploreMgr.CurEventNumber();
        RogueMgr.OnAskRefreshCharacterOrBUFF(mapId,eventNumber,this.RefrushShop);
    end);
    uiLink:AddClickEvent("btnBag",function()
        LuaMgr.ShowLuaPanel(UIName.RogueExploreBagViewModel);
    end);
end



local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.KZRYExploreViewModel);
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.shopUIList = UIListView.New(ui.tranContent);
        this.shopItemObj=vm.behaviour.transform:Find("template/shopItem").gameObject;
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>1 then
                vm.behaviour:UpdateTopBar("",this.OnAskExitShop)
                this.curEventNumber=vm.behaviour.Params[0];
                this.callBack=vm.behaviour.Params[1];
                LuaMgr.ShowLuaPanel(UIName.RogueTopBarResViewModel)
                SetActive(ui.goPanelPop,false);
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if this.shopUIList ~= nil then
            this.shopUIList:Clear();
        end
        LuaMgr.HidePanel(UIName.RogueTopBarResViewModel)
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Rogue_ExploreShopItem")
    end
}


this.BuyShopExecute=function()
    if this.buyIndex~=nil then
        local typeId=this.eventInfoList[this.buyIndex];
        local infoId=this.eventInfoList[this.buyIndex+1];





        local buyData={}
        buyData[typeId]=infoId;
        local mapId=RogueExploreMgr.GetCurMapID();
        local eventNumber=RogueExploreMgr.CurEventNumber();
        local cfgShop=RogueExploreMgr.GetEventShopConfig(this.shelfId,typeId);
        if cfgShop.Type==2 then
            this.characterType=DataMgr.Player.Rogue.Characters[infoId]~=nil and 1 or 0
        end
        RogueMgr.OnAskBuyShop(mapId,eventNumber,buyData,function(data)
            this.BuyShopResult(data);
            LuaMgr.InvokeUIEventListeners(UIEventConst.RogueUpdateTopRes)
        end)
    end
end

this.ParseData=function()
    this.CheckShopData();
    this.SetBaseInfo();
end

this.OnAskExitShop=function()
    local mapId=RogueExploreMgr.GetCurMapID();
    local eventNumber=RogueExploreMgr.CurEventNumber();
    RogueMgr.OnAskExitCharacterOrBuff(mapId,eventNumber,function()
        if this.callBack~=nil then
            this.callBack();
        end
        LuaMgr.Back();
    end)
end


this.CheckShopData=function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.RogueUpdateTopRes)
    local reData,reEventId=RogueExploreMgr.GetEventResultData(this.curEventNumber)
    if reData.EventType==4 then
        this.shelfId=reData.EventParams[1];
        this.eventInfoList=reData.EventResult;
        this.eventId=reEventId;
        this.curRefreshCount=reData.RefreshCount;
        this.SetGoodList();
    else
        LuaDebug.error("reData is Error")
    end
end

this.RefrushShop=function()
    this.CheckShopData();
end




this.SetBaseInfo=function()
    local shopRefesh=ConfigMgr.Config.RogueConstants.RogueShopRefreshCost
    ui.txtFrushCount.text=string.format(LuaMgr.GetLangText("RogueExploreShopViewModel_0"),shopRefesh[2])
    ui.rawFrushIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(shopRefesh[1]));
    local isRefreshOpen=RogueExploreMgr.CheckIsOpenRefresh();
    SetActive(ui.btnRefrush.gameObject,isRefreshOpen);
end

this.SetGoodList=function()
    this.shopUIList:Clear();
    local list={}
    for i=1,#this.eventInfoList,2 do
        local cfgShop=RogueExploreMgr.GetEventShopConfig(this.shelfId,this.eventInfoList[i]);
        local key=string.format("%s_%s_%s_%s",RogueExploreMgr.GetCurMapID(),this.eventId,this.curRefreshCount,this.eventInfoList[i])
        local shopItem={
            index=i,
            infoId=this.eventInfoList[i+1],
            type=cfgShop.Type,
            cost=cfgShop.Consume,
            isSellOut=RogueExploreMgr.CheckShopRecord(key);
            callBack=this.ShopCallBack,
            discount=1
        }
        if RogueExploreMgr.CheckShopDiscount() then
            shopItem.discount=ConfigMgr.Config.RogueConstants.Rogue2ShopDiscount/10000;
        end
        local shopData=UIListData.GetData(this.shopItemObj,"Rogue_ExploreShopItem",shopItem);
        table.insert(list,shopData);
    end
    this.shopUIList:SetData(list);
end


this.ShopCallBack=function(index)
    local cfgShop=RogueExploreMgr.GetEventShopConfig(this.shelfId,this.eventInfoList[index]);
    local costCount=tonumber(cfgShop.Consume[2]);
    if RogueExploreMgr.CheckShopDiscount() then
        local discount=ConfigMgr.Config.RogueConstants.Rogue2ShopDiscount/10000*costCount;
        costCount=math.ceil(discount);
    end
    if costCount>DataMgr.Player.Rogue.Shell then
        if RogueExploreMgr.CheckShopExchangelByOxg() then
            local shellRate=tonumber(ConfigMgr.Config.RogueConstants.Rogue2Exchange[1][2]);
            local oxgRate=tonumber(ConfigMgr.Config.RogueConstants.Rogue2Exchange[2][2]);
            local exchangeShell=DataMgr.Player.Rogue.Oxygen*shellRate/oxgRate;
            if costCount<=DataMgr.Player.Rogue.Shell+exchangeShell then
                LuaMgr.ShowLuaPanel(UIName.RogueConfirmViewModel,ConfigMgr.LangGlobal("26529"),function()
                    this.ShowBuyTipInfo(index);
                end,nil);
                return;
            end
        end
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("26228"))
        return;
    end
    this.ShowBuyTipInfo(index);
end


this.ShowBuyTipInfo=function(index)
    this.buyIndex=index;
    local style=this.eventInfoList[index];
    local infoId=this.eventInfoList[index+1];
    local cfgShop=RogueExploreMgr.GetEventShopConfig(this.shelfId,style);
    SetActive(ui.goPanelPop,true);
    SetActive(ui.goHead,cfgShop.Type==2)
    SetActive(ui.goBuff,cfgShop.Type~=2)
    if cfgShop.Type==2 then
        ui.rawHeadIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(infoId));
        local cfgCharacter=ConfigMgr.Config.characterTable[infoId];
        local heroData=RogueMgr.GetCharacterDataByID(infoId)
        local rare=cfgCharacter.rare;
        if  not IsNull(heroData.brilliant) then
            rare = rare + heroData.brilliant.RareLevel
        end
        rare=rare>=5 and 4 or rare;
        ui.imgHeadRare.sprite=LuaMgr.GetSprite("CommonRes","ui_zd_jntx_"..rare)
        ui.imgHeadJob.sprite=LuaMgr.GetSprite("JobIcon","job_"..cfgCharacter.job)
        ui.txtHeadLevel.text="LV.100";
        ui.txtName.text=LuaMgr.GetLangText(cfgCharacter.namelan);
        ui.txtDes.text=string.format(ConfigMgr.LangGlobal("26217"),ui.txtName.text);
    elseif cfgShop.Type==1 then
        local cfgBuff=ConfigMgr.Config.RogueBuffDescMap[infoId];
        ui.imgBuffRare.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_csqzxbfd_0"..cfgBuff.BuffQuality)
        ui.imgBuffIcon.sprite=LuaMgr.GetSprite("BuffIcon",cfgBuff.BuffIcon)
        ui.txtName.text=LuaMgr.GetLangText(cfgBuff.BuffNameLan);
        ui.txtDes.text=LuaMgr.GetLangText(cfgBuff.BuffDesLan);
    elseif cfgShop.Type==3 then

        local cfgItem=ConfigMgr.Config.RogueItems[infoId];
        ui.imgBuffRare.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_csqzxbfd_0"..cfgItem.Quality)
        ui.imgBuffIcon.sprite=LuaMgr.GetSprite("BuffIcon",cfgItem.Icon)
        ui.txtName.text=LuaMgr.GetLangText(cfgItem.NameLan);
        ui.txtDes.text=LuaMgr.GetLangText(cfgItem.DescLan);
    end
    ui.rawCostIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(cfgShop.Consume[1]));
    local costCount=tonumber(cfgShop.Consume[2]);
    if RogueExploreMgr.CheckShopDiscount() then
        local discount=ConfigMgr.Config.RogueConstants.Rogue2ShopDiscount/10000*costCount;
        costCount=math.ceil(discount);
    end
    ui.txtCostCount.text=costCount;
    
end
    
    
this.BuyShopResult=function(reData)
    if IsNull(reData.RogueItem) or NumTool.GetLen(reData.RogueItem)==0 then
        LuaDebug.error("On Ask Buy Shop respon RogueItem is nil or func")
        return
    end
    SetActive(ui.goPanelPop,false);
    this.SetGoodList();
    for i,v in pairs(reData.RogueItem) do
        local cfgShop=RogueExploreMgr.GetEventShopConfig(this.shelfId,i);
        if cfgShop.Type==2 then
            local heroInfo=v;
            if this.characterType~=nil then
                heroInfo=string.format("%s_%s",v,this.characterType);
            end
            LuaMgr.ShowNewCardPanel(heroInfo);
            RogueExploreMgr.CheckShowCharacterExploreLevel(v);
        elseif cfgShop.Type==1 then
            LuaMgr.ShowLuaPanel(UIName.RogueExploreBuffInfoViewModel,v,nil);
        elseif cfgShop.Type==3 then
            LuaMgr.ShowLuaPanel(UIName.RogueExploreBuffInfoViewModel,v,nil);
            break;
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})