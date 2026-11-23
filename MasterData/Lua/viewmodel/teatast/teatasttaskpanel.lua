






local this = {}

require("ViewModel/TeaTast/UITeaTaskItem")

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local goBG = nil;
local uiTeaTaskItem = nil;
local scrollView = nil;
local rectContent = nil;
local goIsOn=nil;
local goLock=nil;
local goFrame=nil;
local goGoodsItem=nil;
local textTitle=nil;
local textValue=nil;
local goIsMax=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    goBG = uiLink:Get("goBG");
    goIsOn=uiLink:Get("goIsOn");
    goLock=uiLink:Get("goLock");
    goFrame=uiLink:Get("goFrame");
    goGoodsItem = uiLink:Get("goGoodsItem"):GetComponent("GoodsViewModel");
    textTitle=uiLink:Get("textTitle"):GetComponent("Text");
    textValue=uiLink:Get("textValue"):GetComponent("Text");
    goIsMax=uiLink:Get("goIsMax");
    
    uiTeaTaskItem = uiLink:Get("UITeaTaskItem");
    SetActive(uiTeaTaskItem,false)
    scrollView= UIScrollView.New(uiLink:Get("ScrollView"))
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    
    uiLink:AddClickEvent("btnShow",function()
        if goBG.activeSelf then
            SetActive(goBG,false);
            SetActive(goLock,true);
            SetActive(goIsOn,false);
        else
            SetActive(goBG,true);
            SetActive(goLock,false);
            SetActive(goIsOn,true);
            this.UpdateUI();
        end
LuaMgr.HidePanel(UIName.FoundationOperateViewModel);
    end)
    
    uiLink:AddClickEvent("btnClose",function()
        SetActive(goBG,false);
        SetActive(goLock,true);
        SetActive(goIsOn,false);
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    goBG = nil;
    uiTeaTaskItem = nil;
    scrollView = nil;
    rectContent = nil;
    UIScrollView.ClearItem("UITeaTaskItem")
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        local params = vm.behaviour.Params;
        if (params == nil) then
            return
        end
       local data= ConfigMgr.Config.constants.TeaItemLimit1;
        if data~=nil then
            goGoodsItem:SetData(data.id,data.count,0,0.54,true)
            local item=ConfigMgr.Config.itemMap[data.id]
            local str=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7071"].NameLan);
            local itemName=LuaMgr.GetLangText(item.nameLan)
            textTitle.text=string.format(str, itemName);
        end

        SetActive(goBG,false);
        SetActive(goLock,true);
        SetActive(goIsOn,false);
        this.UpdateUI(true);
    end,
    before_deactive = function(vm)
        scrollView:Clear(true)
    end,
    before_destroy = function(vm)
        this.Clear();
    end
}

this.UpdateUI=function(showValue)
    
    local teaItemLimit1= ConfigMgr.Config.constants.TeaItemLimit1;
    local count = DataMgr.Player.teaTask.AwardItem[teaItemLimit1.id];
    count=count ~=nil and count or 0;
    local isMax=count >= teaItemLimit1.count;
    
    SetActive(goIsMax,isMax);

    textValue.text= string.format("%s/<color=#ad9f87>%s</color>", count, teaItemLimit1.count);

    if showValue~=nil and showValue then
        return
    end
    
    
    local teaTaskMap=ConfigMgr.Config.TeaTaskMap;

    local itemList={ }
    if teaTaskMap~=nil then
        for key,value in pairs(teaTaskMap) do
            table.insert(itemList,value)
        end
    end

    table.sort(itemList, function(a, b)
        local asort=this.GetSort(a)
        local bsort=this.GetSort(b)
        
        if asort == bsort then
            return a.Id < b.Id
        else
            return asort < bsort
        end
    end)
    
    local maxLength = #itemList;
    local scrollDatas = {}
    local index = 1
    while (index <= maxLength) do

        local fun = function(id)
            this.NetDataSuccssful(id);
        end
        
        local groupData = {
            fun = fun,
            taskData = itemList[index]
        }
        
        local scrollData = UIScrollData.GetData(uiTeaTaskItem, "UITeaTaskItem", 320, 89, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + 1
    end
    
    scrollView:SetParams(320, 411.8269)
    scrollView:SetData(scrollDatas, true)
end

this.CheckMax=function()
    local teaItemLimit1= ConfigMgr.Config.constants.TeaItemLimit1;
    local count = DataMgr.Player.teaTask.AwardItem[teaItemLimit1.id];
    count=count ~=nil and count or 0;
    local isMax=count >= teaItemLimit1.count;
    return isMax;
end

this.GetSort=function(data)
    local isMax=this.CheckMax();
    local teaTask = DataMgr.Player.teaTask.List[data.Id];
    local configTask=ConfigMgr.Config.TeaTaskMap[data.Id];
    
    if teaTask~=nil and configTask~=nil then
        local value=configTask.Condition1[#configTask.Condition1]
        if not teaTask.IsPrize then
            if teaTask.Value>=value then
                if isMax then
                    return 2;
                else
                    return 1;
                end
            else
                if isMax then
                    return 2;
                else
                    return 1;
                end
            end
        else
            return 4;
        end
    else
        if isMax then
            return 3;
        else
            return 3;
        end
    end
end


this.NetDataSuccssful=function(id)  
    local data={TaskId= id};
    local Url = "teaTask/getReward"
    ApiMgr.Request(Url, data, true,
            function(result)
                local re=json.decode(result);
                if re.result.Items ~= nil then
                    local data=json.encode(re.result);
                    LuaMgr.ShowItemRewared(data);
                end
                this.UpdateUI();
            end,
            function(failCode)
            end,
            true)
end


return vm({ hook = hook })