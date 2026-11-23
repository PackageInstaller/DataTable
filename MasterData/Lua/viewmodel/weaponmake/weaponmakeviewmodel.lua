





local this = {
    vm=nil,
    data = {
        orderType=nil;
        contactCount=nil;
        currIndex=0;
        isRare=false;
        callBack=nil;
        animator=nil;
    }
};

local data = {
    orderDoingText="";
    orderGroupSpacing=0.0;
    
    orderStateList= {
        {
            goDone = false;
            goDoing = false;
            goLock = false;
        }, {
            goDone = false;
            goDoing = false;
            goLock = false;
        }, {
            goDone = false;
            goDoing = false;
            goLock = false;
        }, {
            goDone = false;
            goDoing = false;
            goLock = false;
        }, {
            goDone = false;
            goDoing = false;
            goLock = false;
        }
    };
    
    orderTypeList={
        {
            orderType="",
            active=false,
            propsIcon=DefaultTexture,
            isChoose=false;
        },
        {
            orderType="",
            active=false,
            propsIcon=DefaultTexture,
            isChoose=false;
        },
        {
            orderType="",
            active=false,
            propsIcon=DefaultTexture,
            isChoose=false;
        }
    },
    craftIconList={
        {
        icon=DefaultSprite,
        }
    },
    
    

    contactProcText="";
    contactRestText="";

    orderTypeName="";
    orderTypeNameEn="";
    orderTypeShadowColor=UnityEngine.Color();
    contactResetSlider=0.0;

    craftsNameText="";
    craftsCertificateSprite=DefaultSprite;
    craftsIconSprite=DefaultSprite;
    craftsJobIconSprite=DefaultSprite;
    craftsQtSprite=DefaultSprite;
    craftsTeamText="";
    craftsDescriText="";



    orderSpendItem1="";
    orderSpendItem2="";
    constPropsIcon1=DefaultTexture;
    constPropsIcon2=DefaultTexture;

    contactBool=false;
    signBool=false;
    restActive=false;
    signMaskBool=false;
    goodsActive=false;
    timeDesActive=false;
    

    craftState_active=false;
    craftState_free=false;

    craftDataList={
        {
            craftID="";
            craftName="";
            craftIcon=DefaultSprite;
            craftJobIcon = DefaultSprite;
            craftJobName="";
            craftQt=DefaultSprite;
            craftDescri="";
            craftState=0;
            craftIsOn=false;
            craftIsOff=false;
            craft_on=false;
            craft_off=false;
        }
    },
    
    specialtyList={
        {
            active=false,
            text="",
        },
        {
            active=false,
            text="",
        },
        {
            active=false,
            text="",
        },
    },

    contentLocalPos=Vector3(0,0,0);
    contentRset="";

}

local command = {
    moreCraftsBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.WeaponItemsViewModel,this.data.orderType);
        end
    },
    
    orderLockBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2016"].NameLan))
        end
    },

    openOrderPanleBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.UIWpOrderListPanel)
        end
    },
    

    craftTog={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            
            local index=tonumber(param)+1;
            
            if this.data.currIndex==index then
                return;
            end
            
            this.SetCraftsInfo(index);
            this.data.animator.enabled=false;
            this.data.animator.enabled=true;
            this.data.animator:Play("UI_WeaponMakePanel_CraftsImfo");
        end
    },
    
    signPactBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.data.currIndex<=0 then return end;
            
            local selectCraftID=this.vm.data.craftDataList[this.data.currIndex].craftID;
            
            local askData={
                OrdersType=this.data.orderType,
                Craftsman=selectCraftID
            }
            if not IsNullOrEmpty(selectCraftID) then
                local signPactCallBack = function()
                    ApiMgr.Request("weaponmade/sign_contract",askData,true,function(result)
                        if this.data.callBack~=nil then
                            this.data.callBack();
                        end

                        this.ParseData();

                        LuaMgr.ShowLuaPanel(UIName.UIWpOrderListPanel);
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2528"));
                    end,nil,true)
                end

                local popupBool = nil
                local isClose = SettingHelper.GetPrefasBool(ESetting.Msg_EquipPopup_Close)

                if isClose then
                    popupBool = false
                else
                    local isOpen = SettingHelper.GetPrefasBool(ESetting.Msg_EquipPopup_Open)

                    if isOpen then
                        popupBool = true
                    else

                        local playerPrefsKey = DataMgr.Player.uid.."EquipPopup"
                        if not UnityEngine.PlayerPrefs.HasKey(playerPrefsKey) then
                            popupBool = true
                        else
                            local playerPrefsValue = UnityEngine.PlayerPrefs.GetString(playerPrefsKey)
                            local time = os.date("*t", LuaMgr.Timestamp())
                            local value = time.month..time.day
                            popupBool = playerPrefsValue ~= value
                        end
                    end
                end
                if popupBool then
                    local cfgCraft = ConfigMgr.Config.weaponMade.Craftsman[selectCraftID]
                    if cfgCraft ~= nil then
                        LuaMgr.ShowLuaPanel(UIName.WeaponMakePopup,selectCraftID,signPactCallBack)
                    end
                else
                    signPactCallBack()
                end
            end
        end
    },
    
    refreshBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.data.contactCount<=0 then
                local goods = ConfigMgr.Config.constants.RefreshWeapon[1]
                local mas1 = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29500"), goods.count)
                local mas2 = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29501")
                local mas3 = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29502")
                local goodsId = goods.id
                LuaMgr.ShowPanel(UIName.ConfirmImageTextViewModel, goodsId, mas1, mas2, mas3, this.AskAddWeaponmadeRecontactCount, nil)
            elseif this.data.isRare then
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,LuaMgr.GetLangText("TenderCraftsViewModel_22"),function()
                    this.AskWeaponmadeRecontact();
                end,nil);
            else
                this.AskWeaponmadeRecontact();
            end
        end
    },

    clockBtn= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            if this.vm.data.timeDesActive then
                this.vm.data.timeDesActive = false;
            else
                this.vm.data.timeDesActive = true;
            end

        end
    },
    previewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local selectCraftID = this.vm.data.craftDataList[this.data.currIndex].craftID
            local cfgCraft = ConfigMgr.Config.weaponMade.Craftsman[selectCraftID]
            if cfgCraft ~= nil then
                LuaMgr.ShowLuaPanel(UIName.WeaponMakePopup,selectCraftID)
            end
        end
    }

}

require("ViewModel/WeaponMake/UIOrderPdItem")

local tarGameObject = nil;
local tarRect = nil;
local rectOrderPd = nil;
local uiOrderPdItem = nil;
local orderItems={};

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    rectOrderPd = uiLink:Get("rectOrderPd"):GetComponent("RectTransform");
    uiOrderPdItem = uiLink:Get("UIOrderPdItem");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    rectOrderPd = nil;
    uiOrderPdItem = nil;

end



local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.Init(vm.behaviour.gameObject)
        this.data.animator=vm.behaviour.transform:Find("root/Middle"):GetComponent("Animator");
        RedMgr.Singleton:RegisterViewModel(UIName.WeaponMakeViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        this.vm.data.timeDesActive=false;

        if vm.behaviour.Params.Length > 0 then
            this.data.orderType = vm.behaviour.Params[0]
        else
            this.data.orderType = "1002"
        end
        this.UpdateUI(this.data.orderType)
        
        this.vm.behaviour:UpdateTopBar(this.data.orderType, nil);
        
        this.ParseData();

        LuaMgr.RemoveTimer(TimerConst.WeaponContactTime)
        LuaMgr.AddTimer(TimerConst.WeaponContactTime, function()
            this.UpdateOrderCatal();
        end, 1, -1, true);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.WeaponContactRecoverTime)
        LuaMgr.RemoveTimer(TimerConst.WeaponContactTime)
    end,
    before_destroy = function(vm)
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        this.data = nil;
        
        this.Clear();
    end,
}

this.UpdateUI=function(orderType)
    local craftsman = DataMgr.Player.weaponMade.Craftsman;
    local index=0;
    for key, value in pairs(craftsman) do
        if #value.List > 0 then
            index=index+1;
            if index>#orderItems then
                table.insert(orderItems,UIOrderPdItem.New(uiOrderPdItem,rectOrderPd))
            end

            SetActive(orderItems[index].gameObject,true);
            orderItems[index]:SetData(key,key == orderType,value,this.btnEnterCrafts);
        end
    end

    for i = index+1, #orderItems do
        orderItems[i]:Clear();
    end

    table.sort(orderItems,function(a,b)
        if a.Order==b.Order then
            return tonumber(a.orderType)< tonumber(b.orderType);
        else
            return tonumber(a.Order)< tonumber(b.Order);
        end
    end )

    for i = 1, #orderItems do
        orderItems[i].transform:SetSiblingIndex(i);
    end

    if orderType ==nil and #orderItems>0 then
        this.btnEnterCrafts(orderItems[1].orderType);
    end
end

this.btnEnterCrafts=function(key)
    this.data.orderType = key;
    this.data.currIndex=0;
    this.ParseData();
    this.UpdateUI(key);
    
    this.data.animator.enabled=false;
    this.data.animator.enabled=true;
    this.data.animator:Play("UI_WeaponMakePanel_CraftsImfo");
end 


this.ParseData=function()
    this.data.isRare=false;
    this.SetCraftList();
    this.SetContactInfo();
    this.UpdateOrderCatal();
end

this.AskWeaponmadeRecontact=function()
    local askData={OrdersType=this.data.orderType}
    ApiMgr.Request("weaponmade/recontact",askData,true,function()
        this.ParseData();
    end,nil,true);
end

this.AskAddWeaponmadeRecontactCount = function()
    local data = {OrdersType = this.data.orderType}
    local callback = function(result)
        this.ParseData()
    end
    ApiMgr.Request("weaponmade/costRecontact", data, true, callback, nil, true);
end

this.SetContactInfo=function()
    local constants=ConfigMgr.Config.constants;
    this.data.contactCount=math.floor((LuaMgr.Timestamp()-DataMgr.Player.weaponMade.RecontactStartTime)/(constants.ContactDurationMinute*60));
    if this.data.contactCount>constants.ContactMaxCount then this.data.contactCount=constants.ContactMaxCount;
    elseif this.data.contactCount<0 then this.data.contactCount=0; end

    local restTime=constants.ContactDurationMinute/60;
    local minTime=restTime%1;
    if minTime>0 then
        restTime=string.format("%.1f",restTime);
    else
        restTime=math.ceil(restTime);
    end

        this.vm.data.contentRset=string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2525"),restTime);
        this.vm.data.contactProcText=string.format("<color=#ffffff><size=18>%s</size></color>/<color=#c1c0c0><size=18>%s</size></color>",
                this.data.contactCount,constants.ContactMaxCount);

        if this.data.contactCount>=constants.ContactMaxCount then
            this.vm.data.contactRestText=LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2527");
            this.vm.data.contactResetSlider=1.0;
            return;
        end
        local recover=(constants.ContactMaxCount*constants.ContactDurationMinute*60 +DataMgr.Player.weaponMade.RecontactStartTime) -LuaMgr.Timestamp();
        if recover>0 then
            LuaMgr.RemoveTimer(TimerConst.WeaponContactRecoverTime)
            LuaMgr.AddTimer(TimerConst.WeaponContactRecoverTime,function()
                local num=math.ceil(recover/(constants.ContactDurationMinute*60));
                local currContact=constants.ContactMaxCount-num;
                
                if currContact<0 then
                    currContact=0;
                end
                
                this.vm.data.restActive=true;
                this.vm.data.contactProcText=string.format("<color=#efe5cc><size=18>%s</size></color>/<color=#a29a85><size=18>%s</size></color>", currContact,constants.ContactMaxCount);

                local rate=recover/(constants.ContactMaxCount*constants.ContactDurationMinute*60);
                this.vm.data.contactResetSlider=1-rate;
                
                local num=math.floor(recover/3600);
                local num2=math.floor(recover%3600/60);
                local num3=math.ceil(recover%3600%60);
                
                local str=string.format("<color=#d46b37><size=18>%.2d:%.2d:%.2d</size></color><color=#d46b37><size=18>%s</size></color>",
                        num,num2,num3,"");
                this.vm.data.contactRestText =string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2526"),str);

                recover=recover-1;
                if recover<0 then
                    this.vm.data.restActive=false;
                    LuaMgr.RemoveTimer(TimerConst.WeaponContactRecoverTime);
                    this.ParseData();
                end

            end,1,-1,true);

        end
    end


this.SetCraftList=function()
    
    local cfgCraftsman= ConfigMgr.Config.weaponMade.Craftsman;
    local dataCraftsmanList=DataMgr.Player.weaponMade.Craftsman[this.data.orderType].List;
    
    this.vm.data.craftState_active=dataCraftsmanList~=0;
    this.vm.data.craftState_free=dataCraftsmanList==0;
    this.vm.data.craftDataList={};
    local list={};
    for i=1,5,1 do
        local craftInfo=nil;
        if #dataCraftsmanList~=0 and i<=#dataCraftsmanList then
            local craft_id=dataCraftsmanList[i];
            local cfgCraft=cfgCraftsman[craft_id];

            if cfgCraft~=nil then

                this.data.isRare=this.data.isRare or cfgCraft.MasterClass>=4;

                craftInfo={
                    craftID=craft_id;
                    craftName=LuaMgr.GetLangText(cfgCraft.MasterNameLan);
                    craftIcon=LuaMgr.GetSprite("CraftsIcon",cfgCraft.MasterIcon);
                    craftJobIcon = LuaMgr.GetSprite("JobIcon","jobweapon_"..cfgCraft.MasterType);
                    craftJobName=LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_253"..cfgCraft.MasterType);
                    craftQt=LuaMgr.GetSprite("WeaponMake","ui_wqzz_bq0"..cfgCraft.MasterClass);
                    craftDescri=LuaMgr.GetLangText(cfgCraft.MasterDes1Lan);
                    craftIsOn=false;
                    craftIsOff=false;
                    craft_on=true;
                    craft_off=false;
                }
            else
                craftInfo={
                    craftIsOn=false;
                    craftIsOff=false;
                    craftJobName="";
                    craftID="";
                    craft_on=false;
                    craft_off=true;
                }
                LuaDebug.error("Craftsman 找不到 id "..craft_id)
            end
        else
            craftInfo={
                craftIsOn=false;
                craftIsOff=false;
                craftJobName="";
                craftID="";
                craft_on=false;
                craft_off=true;
            }
        end
        
        table.insert(list,craftInfo)
    end
    
    this.vm.data.craftDataList=list;

    if this.data.currIndex<=0 then
        this.SetCraftsInfo(1);
    else
        this.SetCraftsInfo(this.data.currIndex);
    end

    list=nil;

end



this.SetCraftsInfo=function(index)
    if index<=0 then
        this.vm.data.signMaskBool.Set(true);
        return
    end;


    local cfgCraftsman= ConfigMgr.Config.weaponMade.Craftsman;

    local num=#this.vm.data.craftDataList;

    for i = 1, num do
        local item=this.vm.data.craftDataList[i];
        item.craftIsOn=i==index;
        item.craftIsOff=i~=index;
    end

    local craftID=this.vm.data.craftDataList[index].craftID;

    this.data.currIndex=index;

    local cfgCraft=cfgCraftsman[craftID];
    
    if cfgCraft~=nil then
        this.vm.data.craftsNameText=LuaMgr.GetLangText(cfgCraft.MasterNameLan);
        this.vm.data.craftsQtSprite=LuaMgr.GetSprite("WeaponMake","ui_wqzz_bq0"..cfgCraft.MasterClass);
        this.vm.data.craftsIconSprite=LuaMgr.GetSprite("CraftsIcon",cfgCraft.MasterIcon);

        this.vm.data.craftsJobIconSprite=LuaMgr.GetSprite("JobIcon","jobweapon_"..cfgCraft.MasterType)
        this.vm.data.craftsTeamText=LuaMgr.GetLangText(cfgCraft.MasterCompanyLan);
        this.vm.data.craftsDescriText=LuaMgr.GetLangText(cfgCraft.MasterDes2Lan);


        this.vm.data.contentLocalPos=Vector3(0,0,0);


        local tagDes=LuaMgr.GetLangText(cfgCraft.MasterTagLan);
        local tags=NumTool.split(tagDes,";")



        for i=1,3,1 do
            this.vm.data.specialtyList[i].active=i<=#tags;
            this.vm.data.specialtyList[i].text=i<=#tags and tags[i] or "";
        end


        local spends=cfgCraft.SpendItems;
        if spends~=nil and #spends>0 then
            this.vm.data.constPropsIcon1=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(spends[1].id))
            this.vm.data.constPropsIcon2=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(spends[2].id))
            local myItem1Count=DataHelper.GetItemCountById(spends[1].id);
            local myItem2Count=DataHelper.GetItemCountById(spends[2].id);
            this.vm.data.orderSpendItem1=myItem1Count>=spends[1].count
                    and ("x"..spends[1].count) or string.format("<color=#FD2917>%s%s</color>","x",LuaMgr.NumFormat(spends[1].count));
            this.vm.data.orderSpendItem2=myItem2Count>=spends[2].count
                    and ("x".. spends[2].count) or string.format("<color=#FD2917>%s%s</color>","x",LuaMgr.NumFormat(spends[2].count));
        else
            this.vm.data.signMaskBool.Set(true);
        end
    else

    end
end

this.UpdateOrderCatal=function()
    local dataWeaponMade=DataMgr.Player.weaponMade;

    local orderDone=0;
    local orderDoing=0;

    local fundBuildingLevel_7=PlayerFoundationMgr.GetBuildingLevelByType(7)
    local unlockNum=ConfigMgr.Config.MakeUpGradeList[fundBuildingLevel_7].WaitNum;

    local orderNum=#this.vm.data.orderStateList;
    for i=1,orderNum,1 do
        if i<=#dataWeaponMade.OrdersList then
            local order= dataWeaponMade.OrdersList[i];
            local lastTime=order.EndTime-LuaMgr.Timestamp();
            orderDoing=orderDoing+1;
            if lastTime>0 then

            else
                orderDone=orderDone+1;
                orderDoing=orderDoing-1;
            end
        end
    end

    if orderDoing<0 then
        orderDoing=0
    end;

    local stateNum=#this.vm.data.orderStateList;
    local allorderNum=orderDone+orderDoing;

    for i=1,stateNum do
        if i<=orderDone then
            this.vm.data.orderStateList[i].goDone=true;
            this.vm.data.orderStateList[i].goDoing=false;
            this.vm.data.orderStateList[i].goLock=false;
        end
    end

    for i=1,stateNum do
        if i>orderDone and i<=allorderNum then
            this.vm.data.orderStateList[i].goDone=false;
            this.vm.data.orderStateList[i].goDoing=true;
            this.vm.data.orderStateList[i].goLock=false;
        end
    end

    for i = 1,stateNum do
        if i>allorderNum then
            if i<=unlockNum then
                this.vm.data.orderStateList[i].goDone=false;
                this.vm.data.orderStateList[i].goDoing=false;
                this.vm.data.orderStateList[i].goLock=false;
            else
                this.vm.data.orderStateList[i].goDone=false;
                this.vm.data.orderStateList[i].goDoing=false;
                this.vm.data.orderStateList[i].goLock=true;
            end
        end
    end

    this.vm.data.orderDoingText=string.format("( %s/<color=#525252><size=20>%s</size></color> )", allorderNum,unlockNum);

    if RedMgr.Singleton:GetRedStateById("1002")~=orderDone then
        RedMgr.Singleton:UpdateClientRedData("1002",orderDone);
        RedMgr.Singleton:Refresh();
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})