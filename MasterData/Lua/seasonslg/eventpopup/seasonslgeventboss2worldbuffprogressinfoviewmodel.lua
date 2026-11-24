
require("SeasonSLG/EventPopUp/Boss2BuffUpLevelItem")
local this = {
  buffUpLevelUIList={};
  buffUpLevelItemObj=nil;
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goTips = uiLink:Get("goTips");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.txtCurPro = uiLink:Get("txtCurPro"):GetComponent("Text");
    ui.txtTarPro = uiLink:Get("txtTarPro"):GetComponent("Text");
    ui.tranReardList = uiLink:Get("tranReardList"):GetComponent("RectTransform");
    ui.tranBuffList = uiLink:Get("tranBuffList"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
       LuaMgr.HidePanel(UIName.SeasonSlGEventBoss2WorldBuffProgressInfoViewModel)
    end)

end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.buffUpLevelUIList=UIListView.New(ui.tranBuffList);
        this.buffUpLevelItemObj=vm.behaviour.transform:Find("template/buffUpLevelItem").gameObject;
        this.rewardItemList={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            this.lastProgress=vm.behaviour.Params[0];
            if this.lastProgress<0 then
                this.lastProgress=0;
            end
            this.curProgress=vm.behaviour.Params[1];
        end
        this.ParseData();
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.ClearRewardItem();
        this.buffUpLevelUIList:Clear();
    end,
    before_destroy = function()
        UIListView.ClearItem("Boss2BuffUpLevelItem")
        this.ClearRewardItem(true);
        this.ClearUI();
    end

}

this.ParseData=function()
    ui.txtCurPro.text=SeasonSLGEventMgr.GetProgressName(this.lastProgress);
    ui.txtTarPro.text=SeasonSLGEventMgr.GetProgressName(this.curProgress);
    local preBuffs={};
    local nowBuffs={};
    for i,v in pairs(ConfigMgr.Config.SeasonalGridBOSSHeat) do
        if v.HeatProgress==this.lastProgress then
            preBuffs=v.BuffGroup;
        end
        if v.HeatProgress==this.curProgress then
            nowBuffs=v.BuffGroup;
        end
    end

    local preLevelIdDic={}
    for i,v in ipairs(preBuffs) do
        local buffCfg=ConfigMgr.Config.SeasonalBuffMap[v]
        if buffCfg~=nil then
            preLevelIdDic[buffCfg.Param[1]]=buffCfg.Param[2];
        end
    end
    this.buffUpLevelList={};
    for i,v in ipairs(nowBuffs) do
        local buffCfg=ConfigMgr.Config.SeasonalBuffMap[v];
        local preLevel=nil
        if buffCfg~=nil then
            if preLevelIdDic[buffCfg.Param[1]]~=nil then
                preLevel=preLevelIdDic[buffCfg.Param[1]];
            end
            local curLevel=buffCfg.Param[2];
            table.insert(this.buffUpLevelList,{id=v,BuffIcon=buffCfg.BuffIcon,preLevel=preLevel,curLevel=curLevel})
        end
    end
    this.SetBuffUpLevelList();
    this.SetRewards();
end

this.SetRewards=function()
    this.ClearRewardItem();
    local curRewardCfg=nil;
    for i,v in pairs(ConfigMgr.Config.SeasonalGridBOSSRewardMap) do
        if v.Type==3 and v.Para[1]==this.curProgress then
            curRewardCfg=v;
        end
    end
    if curRewardCfg==nil then
        SetActive(ui.goTips,true)
        return;
    end
    SetActive(ui.goTips,false);
    for i,v in ipairs(curRewardCfg.Award) do
        if this.rewardItemList[i]==nil then
            this.rewardItemList[i]=GoodsDataItem.New(ui.tranReardList)
        end
        local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemData.count0 = v.count;
        SetActive(this.rewardItemList[i].gameObject,true);
        this.rewardItemList[i]:SetData(1, itemData, 1, false, Vector3(0.4,0.4,0.4), false);
    end
end


this.ClearRewardItem=function(isClear)
    if NumTool.GetLen(this.rewardItemList)>0 then
        if isClear then
            for i,v in pairs(this.rewardItemList) do
                v:Clear();
            end
        else
            for i,v in pairs(this.rewardItemList) do
                SetActive(v.gameObject,false);
            end
        end
    end
end

this.SetBuffUpLevelList=function()
    this.buffUpLevelUIList:Clear();
    if #this.buffUpLevelList==0 then
        return;
    end
    local list={}
    for i,v in ipairs(this.buffUpLevelList) do
        local buffItem={
            icon=LuaMgr.GetSprite("BuffIcon", v.BuffIcon);
            oldLevel=v.preLevel,
            newLevel=v.curLevel,
            index=i,
            callBack=this.BuffClickCallBack
        }
        local buffData=UIListData.GetData(this.buffUpLevelItemObj,"Boss2BuffUpLevelItem",buffItem);
        table.insert(list,buffData)
    end
    this.buffUpLevelUIList:SetData(list);
end

this.BuffClickCallBack=function(index)
    local buffId=this.buffUpLevelList[index].id
    LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBuffDesPopUpViewModel,buffId)
end

return vm({
    data = data,
    command = command,
    hook = hook
})