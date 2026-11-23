





local this = {
    vm=nil,
    data = {
        tab_suffix=nil;
        tab_prefix=nil;
        tab_endfix=nil;
        curTabIndex=nil;
        popPanelName=nil;
        drawPath="Images/Shop/";
        bannerTime=0;
        coroutine_key=nil;
        drawing=nil;
        cfgPush=nil;
        curPushIndex=nil;
        pushSubPanelName=nil;
        cfgRecommandShelf=nil;
        tweener=nil;
        tabTweener=nil;
        tabData={};
        tabId={"1212","1211","1210","1218","1209"};
        pushSubNames={};
        pushSubColor={};
        rectTab=nil;
        recommendPanel=nil;
firstOpen=true,
        scrollView=nil,
    }
};

local data = {

    tabList={
        {
            imgChooseName=DefaultSprite,
            imgNoChooseName=DefaultSprite,
            imgNoCheooseLog=DefaultSprite,
            imgCheooseLog=DefaultSprite,
            goOpen=false,
            goClose=false,
            suo=false,
            redId="",
        }
    },
    
    pushBarList={
        {
            barName="",
            goOpen=false,
            goClose=false;
            barId="",
            lockBool=false,
            redId="",
            imgType1=false,
            imgType2=false,
            imgColor=UnityEngine.Color(237/255,230/255,229/255,1)
        }
    },
    
    playAnimName="",
    imgBan1_flow=nil;
    imgBan1_idle=nil;
    imgBan2_flow=nil;
    imgBan2_idle=nil;
    

    recommandBool=false;
    recomandBarName="";
    recomandRaw=DefaultTexture;
    recomandTypeList={
        {typeIsOn=false},
        {typeIsOn=false},
        {typeIsOn=false},
        {typeIsOn=false},
    },
    recomand_characterPos=Vector2(0,0);
    recomand_BgPos=Vector2(0,0);
}

local command = {






    tabBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1;
            if index ~= this.data.curTabIndex then
                this.data.curTabIndex = index;
                this.data.tab_endfix = nil;
                LuaMgr.NextFrame(this.FrushTabState)
                this.OpenSubPanel();
            end
        end
    },

    chapterBarBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1;
            this.SwitchLeftBar(index);
        end
    },
    buyGoodsBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1;
            local goods = this.vm.data.goodsList[index].goods
            local limitType = this.vm.data.goodsList[index].refreshCycle;
            LuaMgr.ShowLuaPanel(UIName.BuyTipViewModel, goods, limitType, function()
                this.ParseData();
            end)
        end
    },
    pushBarBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1;
            if this.data.curPushIndex == index then
                return
            end ;
            for i, v in ipairs(this.vm.data.pushBarList) do
                v.goClose= not (index==i)
                v.goOpen=index==i;
            end

            this.data.curPushIndex=index;
            this.Push_OpenSubPanel();
        end
    },
    tabLockBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1;
            local interfaceId = this.data.tabId[index];
            if FeatureManager.IsLock(interfaceId) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr(interfaceId));
            end
        end
    },
    recomandSkipBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param);
            this.RecommandSkipPage(index);
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.data.tabData= {
            push = { index = 1, id = "push", tabId = "1212", name = LuaMgr.GetLangText("MainShopViewModel_24")},
            skin = { index = 2, id = "skin", tabId = "1211", name = LuaMgr.GetLangText("MainShopViewModel_26")},
            gift = { index = 3, id = "gift", tabId = "1210", name = LuaMgr.GetLangText("MainShopViewModel_27")},
            charge = { index = 4, id = "charge", tabId = "1218", name = LuaMgr.GetLangText("MainShopViewModel_28")},

            totalRecharge = { index = 5, id = "totalRecharge", tabId = "1209", name = LuaMgr.GetLangText("MainShopViewModel_0")}
        }
        RedMgr.Singleton:RegisterViewModel(UIName.MainShopViewModel);
        this.data.rectTab=vm.behaviour.transform:Find("root/Middle/rectTab"):GetComponent("RectTransform");
        this.data.recommendPanel=vm.behaviour.transform:Find("root/Left/Mid/recommendPanel");
        this.data.scrollView=vm.behaviour.transform:Find("root/Left/Mid/recommendPanel/Left_Bar/Contrl/ScrollView"):GetComponent("ScrollRect");


        this.data.imgBan1_flow=vm.behaviour.transform:Find("root/BG/imgBan1_flow"):GetComponent("RectTransform");
        this.data.imgBan1_idle=vm.behaviour.transform:Find("root/BG/imgBan1_idle"):GetComponent("RectTransform");
        this.data.imgBan2_flow=vm.behaviour.transform:Find("root/BG/imgBan2_flow"):GetComponent("RectTransform");
        this.data.imgBan2_idle=vm.behaviour.transform:Find("root/BG/imgBan2_idle"):GetComponent("RectTransform");
    end ,
    before_active = function(vm)
        this.Refresh(vm);
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/SpecialtyStore_open.mp3");
        LuaMgr.RemoveUIEventListener(UIEventConst.PropUse, this.OnPropUse);
        LuaMgr.AddUIEventListener(UIEventConst.PropUse, this.OnPropUse);
    end,
    refresh = function(vm)
        this.Refresh(vm);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PropUse, this.OnPropUse);
        
        if (vm.behaviour.Params == nil) then return end
        this.Clear();
        this.data.tab_suffix=nil;
        this.data.tab_prefix=nil;
this.data.firstOpen=true
    end,
    before_destroy=function()
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        if (this.data.tabTweener ~= nil) then
            this.data.tabTweener:Kill()
        end
        this.data.tabTweener=nil;

        if (this.data.tweener ~= nil) then
            this.data.tweener:Kill()
        end
        this.data.tweener=nil;
        this.data = nil;
    end
}

this.OnPropUse = function(args)
    this.Refresh(this.vm);
end

this.Refresh = function(vm)
    if (vm.behaviour.Params == nil) then return end
    local data=nil;
    if vm.behaviour.Params.Length>0 then
        data=vm.behaviour.Params[0];
    else
        data=ConfigMgr.Config.constants.DefaultShop[2];;
    end
    local tabs=NumTool.split(data,"_");
    this.data.tab_prefix=tabs[1];
    if #tabs>1 then
        this.data.tab_suffix=tabs[2];
    end
    if ComData.skipJump~=nil and vm.behaviour.IsPop then
        this.data.tab_prefix="skin";
        ComData.skipJump=nil;
    elseif HeroParameter.giftJump~=nil and vm.behaviour.IsPop then
        this.data.tab_prefix=HeroParameter.giftJump
        HeroParameter.giftJump=nil
    end
    this.data.tab_endfix=nil;
    if #tabs > 2 then
        this.data.tab_endfix = tabs[3]
    end
    this.data.drawing=false;
    this.ParseData();
this.data.firstOpen=false
    this.vm.data.playAnimName="ani_ui_HomeShopPanel_PushPanel";
    this.data.scrollView.normalizedPosition= Vector2.one;
end

this.ParseData=function()
    this.SetTabList();
    this.SetRectTabBySizeDelta();
end

this.FrushTabState=function()
    if this == nil or this.vm == nil then
        return
    end
    local root = nil
    local rect = nil
    for i,v in ipairs(this.vm.data.tabList) do
        v.goOpen=this.data.curTabIndex==i;
        v.goClose=not (this.data.curTabIndex==i)

        if this.data.rectTab ~= nil and this.data.rectTab.childCount > 0 then
            root = this.data.rectTab:GetChild(i - 1)
            if root ~= nil then
                rect=root:GetComponent("RectTransform")
            end
        end
        if rect == nil then return end
        rect.sizeDelta= not v.goOpen and Vector2(231,76.9) or Vector2(294,76.9)

        if v.goOpen then

            local rectOpen=rect:Find("Group/btn/goOpen"):GetComponent("RectTransform");
            local startSize=Vector2(231,76.9);
            local endSize=Vector2(294,76.9);

            if (this.data.tabTweener ~= nil) then
                this.data.tabTweener:Kill()
            end

            SetActive(this.data.imgBan1_flow.gameObject,true)
            SetActive(this.data.imgBan1_idle.gameObject,false)
            SetActive(this.data.imgBan2_flow.gameObject,true)
            SetActive(this.data.imgBan2_idle.gameObject,false)

            this.data.tabTweener=  DOTWeen.To(
                    function()
                        return startSize
                    end,
                    function(vector)
                        rectOpen.sizeDelta = vector
                    end,
                    endSize,
                    0.3
            )

            this.data.tabTweener.onComplete = function()
                SetActive(this.data.imgBan1_flow.gameObject,false)
                SetActive(this.data.imgBan1_idle.gameObject,true)
                SetActive(this.data.imgBan2_flow.gameObject,false)
                SetActive(this.data.imgBan2_idle.gameObject,true)
            end
        end
    end
    
    UnityEngine.UI.LayoutRebuilder.MarkLayoutForRebuild(this.data.rectTab)
end

this.SetTabList=function()
    this.vm.data.tabList={};
    local tab=this.data.tabData[this.data.tab_prefix];
    if tab == nil then
        LuaDebug.error("MainShopViewModel 外部传参无效， 配置表有误！")
        return
    end
    local list={};
    for i,v in pairs(this.data.tabData) do
        local tabItem={
            imgChooseName=LuaMgr.GetSprite("Shop","ui_st_tab_title_"..v.index),
            imgNoChooseName=LuaMgr.GetSprite("Shop","ui_st_tab_title_0"..v.index),
            imgCheooseLog=LuaMgr.GetSprite("Shop","ui_shop_icon_"..v.index),
            imgNoCheooseLog=LuaMgr.GetSprite("Shop","ui_shop_icon_0"..v.index),
            goOpen=tab.id==v.id,
            goClose=not (tab.id==v.id),
            suo=FeatureManager.IsLock(v.tabId),
            index=v.index,
            name=v.name,
            redId="1135_"..i,
        }
        table.insert(list,tabItem);
    end
    table.sort(list,function(a, b) return a.index<b.index end)
    this.vm.data.tabList=list;
    list=nil;
    this.data.curTabIndex=tab.index;
    LuaMgr.NextFrame(this.FrushTabState)
    this.OpenSubPanel()
end

this.SetRectTabBySizeDelta=function()
    local itemCount=#this.vm.data.tabList;

    if itemCount<=0 then
        return;
    end

   local width = (itemCount-1) *231;
   local allWidth= width+294

    this.data.rectTab.sizeDelta=Vector2(allWidth,76.9)
end

this.OpenSubPanel=function()
    this.Clear();
    
    if this.data.curTabIndex==1 then
        this.data.recommendPanel.gameObject:SetActive(true)
        this.vm.data.recommandBool=true;
        this.InitPush();
    elseif this.data.curTabIndex==2 then
        this.data.recommendPanel.gameObject:SetActive(false)
        this.vm.data.recommandBool=false;
        this.InitSkin();
    elseif this.data.curTabIndex==3 then
        this.data.recommendPanel.gameObject:SetActive(false)
        this.vm.data.recommandBool=false;
        this.InitGift();
    elseif this.data.curTabIndex==4 then
        this.data.recommendPanel.gameObject:SetActive(false)
        this.vm.data.recommandBool=false;
        this.InitPay();
    elseif this.data.curTabIndex==5 then
        this.data.recommendPanel.gameObject:SetActive(false)
        this.vm.data.recommandBool=false;
        this.InitTotalRecharge();
    end
end

this.Clear=function()
    if this.data.popPanelName~=nil then
        LuaMgr.HidePanel(this.data.popPanelName);
    end
    if  this.data.coroutine_key~=nil then
        coroutine_runner.stop(this.data.coroutine_key);
    end

end

this.InitPush=function()
    this.data.pushSubNames["3001001"]=UIName.FristPayViewModel;
    this.data.pushSubNames["3001002"]=UIName.MonthPayViewModel;
    this.data.pushSubNames["3001003"]=UIName.FundPayViewModel;
    this.data.pushSubNames["3001004"]=UIName.Fund2PayViewModel;
    this.data.pushSubNames["3001005"]=UIName.MonthPayDoubleViewModel;
    this.data.pushSubNames["3001006"]=UIName.DrawPayViewModel;
    this.data.pushSubNames["3001101"]=UIName.FristNewPayViewModel;
    this.data.pushSubNames["3001102"]=UIName.FirstPayExtendViewModel;
    this.data.pushSubNames["3001103"]=UIName.FirstPayExtendViewModel;
    this.data.pushSubNames["3001103"]=UIName.FirstPayExtendViewModel;


this.data.pushSubColor["3001101"]=UnityEngine.Color(202/255,88/255,58/255,1);
this.data.pushSubColor["3001102"]=UnityEngine.Color(202/255,88/255,58/255,1);
this.data.pushSubColor["3001103"]=UnityEngine.Color(202/255,88/255,58/255,1);
this.data.pushSubColor["3001002"]=UnityEngine.Color(168/255,53/255,32/255,1);
this.data.pushSubColor["3001005"]=UnityEngine.Color(168/255,53/255,32/255,1);
this.data.pushSubColor["3001003"]=UnityEngine.Color(154/255,133/255,82/255,1);
this.data.pushSubColor["3001004"]=UnityEngine.Color(154/255,133/255,82/255,1);

this.data.pushSubColor["9999999"]=UnityEngine.Color(54/255,96/255,83/255,1);
    
    this.data.cfgPush=ConfigMgr.Config.shop[ShopType.Push];
    this.data.curPushIndex=1;
    local shelfs=table.Copy(this.data.cfgPush.shelfs);
    local isShow,v = false,nil
    for i = #shelfs, 1, -1 do
        v = shelfs[i]
        isShow = (v.StartTime <= LuaMgr.Timestamp() and v.EndTime >= LuaMgr.Timestamp()) or (v.StartTime == 0 and v.EndTime == 0)
        if not isShow then
            table.remove(shelfs,i)
        end
    end
    isShow,v = nil,nil
    table.sort(shelfs,function(a, b) return a.Order<b.Order; end)
    
    this.vm.data.pushBarList={};
    local list={};

    local firstPayIds = this.GetFirstPayIds();
    local len = #firstPayIds;
    for i = len, 1, -1 do
        local firstPayId = firstPayIds[i];
        if (not DataHelper.CheckFristPay(firstPayId)) then
            this.RemoveShelfById(firstPayId, shelfs);
        end
    end
    if  this.data.tab_suffix~=nil then
        for i,v in ipairs(shelfs) do
            if v.Id== this.data.tab_suffix then
                this.data.curPushIndex=i;
                break;
            end
        end
    end
    len = #shelfs;
    for i = 1, len do
        table.insert(list, this.GetPushBar(shelfs[i], i));
    end
    this.vm.data.pushBarList=list;
    this.Push_OpenSubPanel();
    RedMgr.Singleton:Refresh();
    this.data.scrollView.vertical=(#this.vm.data.pushBarList)>=6
end


this.GetPushBar = function(data, index)
    local imgColor = this.data.pushSubColor[data.Id];
    if imgColor == nil then
        imgColor = this.data.pushSubColor["9999999"];
    end
    local pushBar= {
        barName = LuaMgr.GetLangText(data.NameLan),
        goOpen = this.data.curPushIndex == index,
        goClose = not (this.data.curPushIndex == index),
        barId = data.Id,
        lockBool = false,
        name = LuaMgr.GetLangText(data.NameLan),
        redId = "1136_" .. data.Id,
        order = data.Order,
imgType1 = data.Id == "3001003" or data.Id == "3001004",
        imgType2 = data.Id == "3001002" or data.Id=="3001005",
        imgColor = imgColor,
        type=data.Type,
    };
    if data.goods~=nil and #data.goods > 0 then
        pushBar.goodsId=data.goods[1].Id;
    end
    return pushBar;
end


this.GetFirstPayIds = function()
    local firstPayId = ConfigMgr.Config.constants.FirstPayShelfId[2];
    local ids = {firstPayId};
    for i = 1, 2 do
        local payId = tonumber(firstPayId) + i;
        table.insert(ids, tostring(payId));
    end
    return ids;
end


this.RemoveShelfById = function(id, shelfs) 
    local len = #shelfs;
    for i = 1, len do
        if (shelfs[i].Id == id) then
            table.remove(shelfs, i);
            break;
        end
    end
end

this.Push_OpenSubPanel=function()
    if this.data.pushSubPanelName~=nil then
        LuaMgr.HidePanel(this.data.pushSubPanelName);
    end
    local barItem=this.vm.data.pushBarList[this.data.curPushIndex];
    if barItem.barId~=nil then
    this.vm.behaviour:UpdateTopBar("push_"..barItem.barId,nil);
    end
    this.data.pushSubPanelName=this.data.pushSubNames[barItem.barId];
    if not this.data.firstOpen then
DataReportMgr.NetClickGoodsAndPage ("",ShopType.Push,barItem.barId)
    end
    if this.data.pushSubPanelName~=nil then
        LuaMgr.ShowLuaPanel(this.data.pushSubPanelName,barItem.goodsId);
        this.data.popPanelName=this.data.pushSubPanelName;
        this.vm.data.recommandBool=false
    elseif barItem.type==5 then

        LuaMgr.ShowLuaPanel(UIName.JobBagViewModel,barItem.barId);
        this.data.popPanelName=UIName.JobBagViewModel;
        this.data.pushSubPanelName=UIName.JobBagViewModel;
        this.vm.data.recommandBool=false
    else
        this.SetRecommand(barItem.barId)
        this.vm.data.recommandBool=true
    end
    local tempData = nil
    for i = 1, #this.data.cfgPush.shelfs do
        if this.data.cfgPush.shelfs[i].Id == barItem.barId then
            tempData = this.data.cfgPush.shelfs[i]
            break
        end
    end
    DataReportMgr.OpenShopView(ShopType.Push,barItem.barId,LuaMgr.GetLangText(tempData.NameLan),tempData.goods,3,true)
    DataReportMgr.OpenShopShowView(ShopType.Push,barItem.barId,LuaMgr.GetLangText(tempData.NameLan),tempData.goods,3,true)
end

this.InitShop=function()
    this.data.popPanelName=UIName.BaseShopViewModel;
    LuaMgr.ShowLuaPanel(UIName.BaseShopViewModel, this.data.tab_suffix,function(tab)
        this.vm.behaviour:UpdateTopBar(tab,nil);
    end);
end

this.InitSkin=function()
    this.vm.behaviour:UpdateTopBar("skin",nil);
    this.data.popPanelName=UIName.ShopSkinsViewModel;
    LuaMgr.ShowLuaPanel(UIName.ShopSkinsViewModel,this);
end

this.InitPay=function()
    this.vm.behaviour:UpdateTopBar("charge",nil);
    this.data.popPanelName=UIName.PayOnlineViewModel;
    LuaMgr.ShowLuaPanel(UIName.PayOnlineViewModel,this.data.tab_prefix,this.vm.behaviour);
end

this.InitGift=function()
    this.vm.behaviour:UpdateTopBar("gift_4001001",nil);
    this.data.popPanelName=UIName.ShopGiftViewModel;
    LuaMgr.ShowLuaPanel(UIName.ShopGiftViewModel, this.data.tab_suffix,this.data.tab_endfix);
end

this.InitTotalRecharge=function()
    this.vm.behaviour:UpdateTopBar("gift_4001001",nil);
    this.data.popPanelName=UIName.TotalRechargeViewModel;
    LuaMgr.ShowLuaPanel(UIName.TotalRechargeViewModel);
end

this.SetRecommand=function(shelfId)
    for i,v in ipairs(this.data.cfgPush.shelfs) do
        if v.Id==shelfId then
            this.data.cfgRecommandShelf=v;
            break;
        end
    end
    for i,v in ipairs(this.vm.data.recomandTypeList) do
        local typeBool=i==this.data.cfgRecommandShelf.Type-1;
        v.typeIsOn=typeBool;
    end
    this.vm.data.recomandBarName=LuaMgr.GetLangText(this.data.cfgRecommandShelf.NameLan);
    this.vm.data.recomandRaw=LuaMgr.GetTexture(this.data.drawPath..this.data.cfgRecommandShelf.Recommend..".png");
    this.Recomand_BG_DoMove();
end

this.RecommandSkipPage=function(index)
    local Jump=this.data.cfgRecommandShelf.Jump[index]
    if Jump==nil then return end;

    local tabs=NumTool.split(Jump,"_");

    if tabs[1] =="skin" then
        if FeatureManager.IsLock("1211") then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1211"));
            return ;
        end
    end


    if tabs[1] =="gift" then
        if FeatureManager.IsLock("1218") then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1218"));
            return ;
        end
    end

    this.data.tab_prefix=tabs[1];
    this.data.tab_suffix=tabs[2];
    this.data.tab_endfix=tabs[3];
    this.data.curTabIndex=this.data.tabData[this.data.tab_prefix].index;
    LuaMgr.NextFrame(this.FrushTabState)
    this.OpenSubPanel();
end

this.Recomand_BG_DoMove=function()
    if this.data.tweener~=nil then
        this.data.tweener:Kill();
    end
    this.data.tweener=DOTWeen.To(function()return Vector2(631,-68.80003)  end,function(vector)
        this.vm.data.recomand_BgPos=vector;
    end,Vector2(131,-68.80003),0.3);
end

return vm({
    data = data,
    command = command,
    hook = hook
})