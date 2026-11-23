




local this = { };

require("ViewModel/Shop/UIShopSkinItem")

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local uiShopSkinItem = nil;
local rectItem=nil;
local charge=nil;


local textDescription=nil;

local textBtnConfirm = nil;
local rawImageIcon = nil;
local goConfirm = nil;
local goConfirm2 = nil;
local textBtnConfirm2 = nil;
local goMianFei = nil;
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");



    textDescription=uiLink:Get("textDescription"):GetComponent("Text");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    rectItem=uiLink:Get("rectItem"):GetComponent("RectTransform");
    uiShopSkinItem = UIShopSkinItem.New(rectItem);

    textBtnConfirm = uiLink:Get("textBtnConfirm"):GetComponent("Text");
    rawImageIcon = uiLink:Get("rawImageIcon"):GetComponent("RawImage");
    goConfirm = uiLink:Get("goConfirm"):GetComponent("Button");
    goConfirm2 = uiLink:Get("goConfirm2"):GetComponent("Button");
    textBtnConfirm2 = uiLink:Get("textBtnConfirm2"):GetComponent("Text");
    goMianFei = uiLink:Get("goMianFei")
    
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.ShopSkinsConfirmViewModel)
    end)
    LuaMgr.AddClick(goConfirm,this.BuySkin)
    LuaMgr.AddClick(goConfirm2,this.UsingCurrencyBuySkin)

end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    uiShopSkinItem:Destroy();
    uiShopSkinItem = nil;
    rectItem=nil;
    charge=nil;


    textDescription=nil;
    textBtnConfirm = nil;
    rawImageIcon = nil;
    goConfirm = nil;
    goConfirm2 = nil;
    textBtnConfirm2 = nil;
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        SetActive(goConfirm.gameObject,false)
        SetActive(goConfirm2.gameObject,false)

        local goodsID = vm.behaviour.Params[0]
        charge=HeroRedDataHelper.GetChargeById(goodsID)
        if charge~=nil then
            local skinData = HeroRedDataHelper.GetSkinByItemID(charge.Reward[1].id)
            local priceIconPath = 'Assets/_BundleResources/Images/ItemIcons/itemicon_home_'.. charge.Cost.id..'.png'
            local skinName = LuaMgr.GetLangText(skinData.skinNamelan)
            
            if not IsNullOrEmpty(charge.ChargeGroup) then
                local chargeChanel = ConfigHelper.GetChargeChannel(charge.ChargeGroup)
                textBtnConfirm2.text = chargeChanel.CurrencySymbol.." "..chargeChanel.PriceShow
                SetActive(goConfirm2.gameObject,true)
            end
            if not IsNullOrEmpty(charge.Cost.id) then
                if charge.Cost.count == 0 then
                    SetActive(goMianFei,true)
                    SetActive(textBtnConfirm.gameObject,false)
                else
                    SetActive(goMianFei,false)
                    textBtnConfirm.text = charge.Cost.count
                    rawImageIcon.texture = LuaMgr.GetTexture(priceIconPath)
                    SetActive(textBtnConfirm.gameObject,true)
                end
                SetActive(goConfirm.gameObject,true)
            end
            
            textDescription.text= charge.Cost.count>0 and string.format(LuaMgr.GetLangText("ShopSkinsConfirmViewModel_0"), skinName) or string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_1602"),skinName);
            SetActive(uiShopSkinItem.gameObject,true)
            uiShopSkinItem:SetData(charge,false);
        end
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}

this.BuySkin = function()
    if charge ~= nil then
        local skinData = HeroRedDataHelper.GetSkinByItemID(charge.Reward[1].id)
        if skinData ~= nil then
            if DataMgr.Player.characters[skinData.characterId] ~= nil then
                this.SkinCostItemNum()
            else
                local heroConfig = ConfigMgr.Config.characterTable[skinData.characterId]
                if heroConfig ~= nil then
                    local tipStr_1 = ConfigMgr.LangGlobal("1600")
                    local tipStr_2 = string.format(tipStr_1,LuaMgr.GetLangText(heroConfig.namelan),LuaMgr.GetLangText(skinData.skinNamelan))
                    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr_2,function()
                        this.SkinCostItemNum()
                    end,nil)
                end
            end
        end
    end
end

this.SkinCostItemNum = function()
    LuaMgr.HidePanel(UIName.ShopSkinsConfirmViewModel)
    local currentHave = DataHelper.GetItemCountById(charge.Cost.id)
    if currentHave >= charge.Cost.count then
        this.SendBuySkin(charge.Id, 1)
    else
local SkinCost = "8"
        local Currency = "2"
        local exchangeConfig = ConfigItemMgr.GetItemExchangeConfig(Currency .. "_" .. SkinCost)

if exchangeConfig==nil or SkinCost~=charge.Cost.id then
            return
        end
        


local needPay = math.ceil((charge.Cost.count - currentHave) / (exchangeConfig.GetNum / exchangeConfig.CostNum))
local costAll=needPay * exchangeConfig.CostNum;
local skinCostAll=needPay * (exchangeConfig.GetNum / exchangeConfig.CostNum);
        local tipStr = string.format(LuaMgr.GetLangText("DataHelper_0"), LuaMgr.GetLangText(ConfigMgr.Config.itemMap[SkinCost].nameLan), costAll, LuaMgr.GetLangText(ConfigMgr.Config.itemMap[Currency].nameLan))
local item1 = { ID = Currency, Count = costAll }
local item2 = { ID = SkinCost, Count = skinCostAll }
        local data = {[1] = item1, [2] = item2 }
        LuaMgr.ShowGoodsConver(json.encode(data), tipStr, function()
            local itemCount = DataHelper.GetItemCountById(Currency);
            if itemCount >= costAll then                              
                ApiMgr.Request("exchange_item", {CostItm = Currency, GetItm = SkinCost, ExchangeCnt = needPay}, true, function()
                    currentHave = DataHelper.GetItemCountById(charge.Cost.id)
                    if currentHave >= charge.Cost.count then
                        this.SendBuySkin(charge.Id, 1)
                    else

                    end
                end, nil, true, true);
            else
                local tipMessage = string.format(LuaMgr.GetLangText("ExtractCardViewModel_5"), tostring(costAll - itemCount), LuaMgr.GetLangText(ConfigMgr.Config.itemMap[Currency].nameLan));
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipMessage, function()
                    ComData.skipJump = nil
                    SDKMgr.Singleton:ShowMainShopCharge()
                end, nil)
            end
        end )
    end
end
this.UsingCurrencyBuySkin = function()
    if charge ~= nil then
        local skinData = HeroRedDataHelper.GetSkinByItemID(charge.Reward[1].id)
        if skinData ~= nil then
            if DataMgr.Player.characters[skinData.characterId] ~= nil then
                LuaMgr.HidePanel(UIName.ShopSkinsConfirmViewModel)
                LuaMgr.LuaOnAskPay(charge.Id)
            else
                local heroConfig = ConfigMgr.Config.characterTable[skinData.characterId]
                if heroConfig ~= nil then
                    local tipStr_1 = ConfigMgr.LangGlobal("1600")
                    local tipStr_2 = string.format(tipStr_1,LuaMgr.GetLangText(heroConfig.namelan),LuaMgr.GetLangText(skinData.skinNamelan))
                    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr_2,function()
                        LuaMgr.HidePanel(UIName.ShopSkinsConfirmViewModel)
                        LuaMgr.LuaOnAskPay(charge.Id)
                    end,nil)
                end
            end
        end
    end
end


this.SendBuySkin = function(id, count)
    local askData={goods=id}
    ApiMgr.Request("shop/direct_buy",askData,true,function(result)
        local re=json.decode(result);
        if re.code == 0 then 

            local data=json.encode(re.result);
            LuaMgr.ShowItemRewared(data);
        end
    end,function()
    end,true);
end

return vm({
    command = command,
    hook = hook
})