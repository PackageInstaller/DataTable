require("SeasonSLG/EventPopUp/ProductItem")
local this = {
   productUIList={},
   productItemObj=nil;
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
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnComfrim = uiLink:Get("btnComfrim"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtAdd = uiLink:Get("txtAdd"):GetComponent("Text");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
       LuaMgr.HidePanel(UIName.SeasonSlGEventDispatchPopupViewModel)
    end)
    uiLink:AddClickEvent("btnComfrim",function()
        SeasonSLGAPI.OnAskDispatchProgress(tostring(SeasonSLGEventMgr.curGridIndex),this.dispatchWorldId,function(progress,guildName)
            LuaMgr.HidePanel(UIName.SeasonSlGEventDispatchPopupViewModel)
            LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventDispatchInfoPopupViewModel,this.dispatchLocId,this.dispatchWorldId,progress,guildName)
        end)
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.productUIList=UIListView.New(ui.tranContent)
        this.productItemObj= vm.behaviour.transform:Find("template/productItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            this.dispatchLocId=vm.behaviour.Params[0]
            this.dispatchWorldId=vm.behaviour.Params[1]
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.productUIList:Clear();
    end,
    before_destroy = function()
       UIListView.ClearItem("ProductItem")
        this.ClearUI();
    end
}

this.ParseData=function()
    ui.txtTitle.text=SeasonSLGMapMgr.GetGridName(SeasonSLGEventMgr.curGridIndex)
    local locDispatchCfg=ConfigMgr.Config.SeasonalGridGuardMap[this.dispatchLocId]
    local worldDispatchCfg=ConfigMgr.Config.SeasonalGridGuardMap[this.dispatchWorldId]
    local itemIdList={}
    local productItemMap={};

    for i,v in ipairs(locDispatchCfg.HourlyProduce) do
        if productItemMap[v.id]==nil then
            productItemMap[v.id]={id=v.id,count=0}
        end
        productItemMap[v.id].count=productItemMap[v.id].count+v.count
        table.insert(itemIdList,v.id);
    end
    for i,v in ipairs(worldDispatchCfg.HourlyProduce) do
        if productItemMap[v.id]==nil then
            productItemMap[v.id]={id=v.id,count=0}
        end
        productItemMap[v.id].count=productItemMap[v.id].count+v.count
    end
    local addValue=SeasonSLGEventMgr.GetProductByBuff(itemIdList)
    ui.txtAdd.text=string.format(LuaMgr.GetLangText("SeasonSlGEventDispatchPopupViewModel_0").."%.1f%%",addValue);

    local dispatchData=SeasonSLGEventMgr.GetDispatchData(SeasonSLGEventMgr.curGridIndex)
    this.add_product={};
    this.add_productRate=0;
    if dispatchData~=nil then
        local productLevelDic={};
        local productSeasonLevelDic={}
        local productSeasonLevelRare={}

        if #dispatchData.Members1>0 then

            productLevelDic=SeasonSLGEventMgr.GetProductAddByHeroLevel(dispatchData.Members1,locDispatchCfg.ExtraLevel,locDispatchCfg.ExtraLevelReward)
            for i,v in pairs(productLevelDic) do
                if this.add_product[v.id]==nil then
                    this.add_product[v.id]={id=v.id,count=0}
                end
                this.add_product[v.id].count=this.add_product[v.id].count+v.count;
            end

            productSeasonLevelDic=SeasonSLGEventMgr.GetProductAddByHeroSeasonLevel(dispatchData.Members1,locDispatchCfg.ExtraSeasonalLevel,locDispatchCfg.ExtraSeasonalLevelReward)
            for i,v in pairs(productSeasonLevelDic) do
                if this.add_product[v.id]==nil then
                    this.add_product[v.id]={id=v.id,count=0}
                end
                this.add_product[v.id].count=this.add_product[v.id].count+v.count;
            end

            productSeasonLevelRare=SeasonSLGEventMgr.GetProductAddByHeroRareLevel(dispatchData.Members1,locDispatchCfg.Rare,locDispatchCfg.RareReward)
            for i,v in pairs(productSeasonLevelRare) do
                if this.add_product[v.id]==nil then
                    this.add_product[v.id]={id=v.id,count=0}
                end
                this.add_product[v.id].count=this.add_product[v.id].count+v.count;
            end
        end
        productLevelDic={}
        productSeasonLevelDic={}
        productSeasonLevelRare={}

        if not IsNull(dispatchData.Members2) and #dispatchData.Members2>0 then

            productLevelDic=SeasonSLGEventMgr.GetProductAddByHeroLevel(dispatchData.Members2,worldDispatchCfg.ExtraLevel,worldDispatchCfg.ExtraLevelReward)
            for i,v in pairs(productLevelDic) do
                if this.add_product[v.id]==nil then
                    this.add_product[v.id]={id=v.id,count=0}
                end
                this.add_product[v.id].count=this.add_product[v.id].count+v.count;
            end

            productSeasonLevelDic=SeasonSLGEventMgr.GetProductAddByHeroSeasonLevel(dispatchData.Members2,worldDispatchCfg.ExtraSeasonalLevel,worldDispatchCfg.ExtraSeasonalLevelReward)
            for i,v in pairs(productSeasonLevelDic) do
                if this.add_product[v.id]==nil then
                    this.add_product[v.id]={id=v.id,count=0}
                end
                this.add_product[v.id].count=this.add_product[v.id].count+v.count;
            end

            productSeasonLevelRare=SeasonSLGEventMgr.GetProductAddByHeroRareLevel(dispatchData.Members2,worldDispatchCfg.Rare,worldDispatchCfg.RareReward)
            for i,v in pairs(productSeasonLevelRare) do
                if this.add_product[v.id]==nil then
                    this.add_product[v.id]={id=v.id,count=0}
                end
                this.add_product[v.id].count=this.add_product[v.id].count+v.count;
            end
        end

        local itemId=locDispatchCfg.HourlyProduce[1].id;
        if productItemMap[itemId]~=nil and this.add_product[itemId]~=nil then
            this.add_productRate=this.add_product[itemId].count/productItemMap[itemId].count;
        end
    end
    this.SetProductUIList(productItemMap)
end

this.SetProductUIList=function(productMap)
    this.productUIList:Clear();
    local list={}
    for i,v in pairs(productMap) do
        local item={
            name=string.format(LuaMgr.GetLangText("SeasonSlGEventDispatchPopupViewModel_1"),ConfigHelper.ItemName(v.id)),
            des=string.format(LuaMgr.GetLangText("SeasonSlGEventDispatchPopupViewModel_2"),v.count)
        }
        local itemData=UIListData.GetData(this.productItemObj,"ProductItem",item);
        table.insert(list,itemData);
    end
    local expendItem={
        name=LuaMgr.GetLangText("SeasonSlGEventDispatchPopupViewModel_3"),
        des=string.format("%.f%%",this.add_productRate*100)
    }
    local itemData=UIListData.GetData(this.productItemObj,"ProductItem",expendItem);
    table.insert(list,itemData);
    this.productUIList:SetData(list);
end



return vm({
    data = data,
    command = command,
    hook = hook
})