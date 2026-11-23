




local this = { };

require("ViewModel/Shop/UIShopSkinItem")

local listItem={};
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local rectScrollView = nil;
local scrollView = nil; 
local imgZheZhao = nil;
local rectContent=nil;
local horLayout=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    rectScrollView = uiLink:Get("ScrollView"):GetComponent("RectTransform");
    scrollView=uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    imgZheZhao = uiLink:Get("imgZheZhao"):GetComponent("Image");
    rectContent=uiLink:Get("rectContent"):GetComponent("RectTransform");
    horLayout=uiLink:Get("rectContent"):GetComponent("HorizontalLayoutGroup")

    uiLink:AddClickEvent("btnDrawingGuide",function()
        ComData.skipJump=1;
        LuaMgr.ShowLuaPanel(UIName.MainShopPicPanel)
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;

    local allCount=#listItem;
    for i = 1, allCount do
        listItem[i]:Clear();
        listItem[i]:Destroy()
        listItem[i]=nil;
    end
    
    listItem=nil;
    rectScrollView = nil;
    imgZheZhao = nil;
    rectContent=nil;
    horLayout=nil;
    scrollView=nil;
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return end
        
        ComData.skipJump=nil;


        local shop = ConfigMgr.Config.shop['5001']
        if nil == shop then
            print('shop is nil')
            return
        end

        local fristDiscount=false;
        
        local num=1;
        if shop.shelfs~=nil then
            local shelfNum = #shop.shelfs
            for k = 1, shelfNum do
                for i in pairs(shop.shelfs[k].goods) do
                    local charge=HeroRedDataHelper.GetChargeById(shop.shelfs[k].goods[i].Id);
if (charge ~=nil and not HeroRedDataHelper.IsOverdue(charge)) then
                        
                        if num>#listItem then
                            table.insert(listItem,UIShopSkinItem.New(rectContent));
                        end
                        
                        local discount = tonumber(charge.Discount)
                        if(discount<1) then
                            fristDiscount=true;
                        end
                        
                        SetActive(listItem[num].gameObject,true);
                        listItem[num]:SetData(charge,true, num);
                        num=num+1;
                    else

                    end
                end
            end
        else

        end

        horLayout.padding.left=fristDiscount and 10 or 0;
        
        local allCount=#listItem;
        for i = num, allCount do
            SetActive(listItem[i].gameObject,false);
        end

        table.sort(listItem, function(a, b)
            if a.getSort==b.getSort then
return tonumber(a.data.Sort) > tonumber(b.data.Sort);
            else
return a.getSort < b.getSort;
            end
        end )

        for i = 1, allCount do
            listItem[i].transform:SetSiblingIndex(i-1);
        end

DataReportMgr.NetClickGoodsAndPage ("",ShopType.Skin,ShopType.Skin)
        DataReportMgr.OpenShopView(ShopType.Skin,"",LuaMgr.GetLangText(shop.NameLan),shop.shelfs[1].goods,3,true)
        DataReportMgr.OpenShopShowView(ShopType.Skin,"",LuaMgr.GetLangText(shop.NameLan),shop.shelfs[1].goods,3,true)
        scrollView.normalizedPosition= Vector2.zero;
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}

return vm({
    hook = hook
})