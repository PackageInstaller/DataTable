require("ViewModel/TRJ/TRJProItem")
local this = {
   proItemObj=nil;
   proUIList={};
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Middle = uiLink:Get("Middle");
    ui.goComplete = uiLink:Get("goComplete");
    ui.Right = uiLink:Get("Right");
    ui.rawPuzzle = uiLink:Get("rawPuzzle"):GetComponent("RawImage");
    ui.sliderPuzzle = uiLink:Get("sliderPuzzle"):GetComponent("Slider");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranList = uiLink:Get("tranList"):GetComponent("RectTransform");
    ui.tranReward = uiLink:Get("tranReward"):GetComponent("RectTransform");
    ui.tranItem = uiLink:Get("tranItem"):GetComponent("RectTransform");
    ui.btnGame = uiLink:Get("btnGame"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnGame",function()
       if not DataExHelper.CommonActivityCheck(ActivityKey.ZNHD) then

           LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
           return;
       end
       LuaMgr.ShowLuaPanel(UIName.TRJPuzzleViewModel,this.restoreInfo.Id);
   end)
end

local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour);
        this.proItemObj=vm.behaviour.transform:Find("template/proItem").gameObject;
        this.proUIList=UIListView.New(ui.tranList);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.imgIndex=1;
        this.ParseData();
    end,
    before_deactive = function(vm)
       this.proUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("TRJProItem")
    end
}

this.ParseData=function()
    if this.restoreImgList==nil then
        this.restoreImgList={}
        for i,v in pairs(ConfigMgr.Config.RestoredImgMap) do
            table.insert(this.restoreImgList,v);
        end
        table.sort(this.restoreImgList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end);
    end
    this.dataRestoreImgMap=DataMgr.Player.RestoreImgMap;
    this.SetProUIList();
    this.SetRestoreInfo();
end

this.SetProUIList=function()
    this.proUIList:Clear();
    local list={};
    local curIndex=nil;
    for i,v in ipairs(this.restoreImgList) do
        local restoreItem={
            index=i,
            isUnLock=LuaMgr.Timestamp()>v.UnlockTime;
            lockTime=v.UnlockTime;
            isComplete=this.dataRestoreImgMap[v.Id]~=nil and this.dataRestoreImgMap[v.Id]>0;
            isCur=false;
            callBack=this.RestoreCallBack,
        }
        if curIndex==nil and not restoreItem.isComplete and restoreItem.isUnLock then
            curIndex=i;
        end
        local restoreData=UIListData.GetData(this.proItemObj,"TRJProItem",restoreItem);
        table.insert(list,restoreData);
    end
    this.imgIndex=curIndex~=nil and curIndex or 1;
    this.proUIList:SetData(list);
end

this.RestoreCallBack=function(index)
    if this.imgIndex~=nil and this.imgIndex==index then
        return;
    end
    local itemData=this.proUIList.dataList[index];
    if not itemData.data.isUnLock then
        local tips=ConfigMgr.LangGlobal("7131")
        local reTime=itemData.data.lockTime-LuaMgr.Timestamp();
        local reDay=GetTimeDay(reTime)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tips,reDay));
        return;
    end
    this.imgIndex=index;
    this.SetRestoreInfo();
end

this.SetRestoreInfo=function()
    this.restoreInfo=this.restoreImgList[this.imgIndex];
    local isComplete=this.dataRestoreImgMap[this.restoreInfo.Id]~=nil and this.dataRestoreImgMap[this.restoreInfo.Id]>0;
    SetActive(ui.goComplete,isComplete);
    SetActive(ui.btnGame.gameObject,not isComplete);
    local imgPath=string.format("%sTRJ/%s.png",Path.Image,this.restoreInfo.ImgRes);
    ui.rawPuzzle.texture=LuaMgr.GetTexture(imgPath);

    local initPos=Vector2(520,260);
    ui.tranReward.anchoredPosition=initPos+Vector2(0,-81*(this.imgIndex-1))
    local items=this.restoreInfo.Reward;
    if this.itemVM~=nil then
        SetActive(this.itemVM.transform.gameObject,false);
    end
    if IsNull(items) or #items==0 then return end
    if this.itemVM==nil then
        this.itemVM=GoodsDataItem.New(ui.tranItem);
    end
    SetActive(this.itemVM.transform.gameObject,true);
    local itemData = ConfigMgr.Config.itemMap[items[1].id];
    itemData.count0 = items[1].count;
    this.itemVM:SetData(1, itemData, 1, false, Vector3(0.5, 0.5, 1), false);
end



return vm({
    data = data,
    command = command,
    hook = hook
})