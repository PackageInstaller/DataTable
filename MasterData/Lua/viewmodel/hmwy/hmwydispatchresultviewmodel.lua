require("ViewModel/HMWY/Dispatch_HeroResultItem")
local this = {
    heroUIList={};
    heroItemObj=nil;
    proValueList={0.084,0.3,0.51,0.72,1}
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
    ui.rawIcon = uiLink:Get("rawIcon"):GetComponent("RawImage");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtTips = uiLink:Get("txtTips"):GetComponent("Text");
    ui.imgPro = uiLink:Get("imgPro"):GetComponent("Image");
    ui.tranRate = uiLink:Get("tranRate"):GetComponent("RectTransform");
    ui.tranRewardList = uiLink:Get("tranRewardList"):GetComponent("RectTransform");
    ui.tranHeroList = uiLink:Get("tranHeroList"):GetComponent("RectTransform");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnConfrim",function()
       if HMWYDispatchMgr.dispatchCallBack~=nil then
           HMWYDispatchMgr.dispatchCallBack();
       end
       LuaMgr.HidePanel(UIName.HMWYDispatchResultViewModel);
   end)
end



local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour);
        this.itemList={};
        this.heroUIList=UIListView.New(ui.tranHeroList);
        this.heroItemObj=vm.behaviour.transform:Find("template/heroItem").gameObject;
        this.childList={};
        for i=1,ui.tranRate.childCount,1 do
            local child_i=ui.tranRate:GetChild(i-1):GetChild(0)
            table.insert(this.childList,child_i.gameObject);
        end
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            HMWYDispatchMgr.ClearSettlement();
            this.resultData=vm.behaviour.Params[0];
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        for i,v in pairs(this.itemList) do
            SetActive(v.gameObject,false);
        end
        this.heroUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Dispatch_HeroResultItem")
    end
}

this.ParseData=function()
    this.hmwyGame=DataMgr.Player.HMWYGame;
    this.SetBaseInfo();
    this.SetReward();
    this.SetHeroUIList();
end


this.SetBaseInfo=function()
    local eventCfg=ConfigMgr.Config.HmwyDispatchEventCheckMap[this.resultData.eventId];
    ui.txtTitle.text=LuaMgr.GetLangText(eventCfg.NameLan);
    local attrArray=HMWYDispatchMgr.GetDispatchRareText();
    local level=this.resultData.level+1>#attrArray and #attrArray or this.resultData.level+1;
    local rareText=attrArray[level]
    ui.txtTips.text=string.format(LuaMgr.GetLangText("HMWYDispatchResultViewModel_0"),rareText);
    ui.imgPro.fillAmount=this.proValueList[level];
    for i,v in ipairs(this.childList) do
        SetActive(v.gameObject,false);
    end
    DOTWeen.To(function() return 0.0  end,function(value)
        ui.imgPro.fillAmount=value;
        for i,v in ipairs(this.proValueList) do
            if math.abs(value-v)<0.1 then
                SetActive(this.childList[i].gameObject,true);
            end
        end
    end,this.proValueList[level],1.5);
end


this.SetReward=function()
    local itemsList={};
    for i,v in pairs(this.resultData.items) do
        table.insert(itemsList,v);
    end
    for i,v in ipairs(itemsList) do
        if this.itemList[i]==nil then
            this.itemList[i]=GoodsDataItem.New(ui.tranRewardList);
        end
        SetActive(this.itemList[i].gameObject,true);
        local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemData.count0 = v.count;
        this.itemList[i]:SetData(1, itemData, 1, false, Vector3.one*0.625, false, false);
    end
end

this.SetHeroUIList=function()
    this.heroUIList:Clear();
    local list={};
    for i,v in ipairs(this.resultData.heroList) do
        local heroItem=HMWYDispatchMgr.GetDispatchResultHeroData(v);
        heroItem.id=v;
        local heroData=UIListData.GetData(this.heroItemObj,"Dispatch_HeroResultItem",heroItem);
        table.insert(list,heroData);
    end
    this.heroUIList:SetData(list);
end

return vm({
    data = data,
    command = command,
    hook = hook
})