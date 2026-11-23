require("ViewModel/Simulate/Simulate_BlessingPicItem")
require("ViewModel/Simulate/Simulate_BlessingTextItem")
require("ViewModel/Simulate/Simulate_BlessingRewardItem")

local this = {
    vm = nil,
    picUIList={},
    picItemObj=nil;
    textUIList={};
    myTextUIList={};
    textItemObj=nil;
    rewardUIList={};
    rewardItemObj=nil;
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.picItem = uiLink:Get("picItem"):GetComponent("Image");
    ui.imgBless = uiLink:Get("imgBless"):GetComponent("Image");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.textItem = uiLink:Get("textItem"):GetComponent("Text");
    ui.txtBlessInfo = uiLink:Get("txtBlessInfo"):GetComponent("Text");
    ui.txtTips2 = uiLink:Get("txtTips2"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranPicContent = uiLink:Get("tranPicContent"):GetComponent("RectTransform");
    ui.tranTextContent = uiLink:Get("tranTextContent"):GetComponent("RectTransform");
    ui.tranGoods = uiLink:Get("tranGoods"):GetComponent("RectTransform");
    ui.btnBless = uiLink:Get("btnBless"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnBless",function()
        if #this.myTextList==0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateBlessingViewModel_0"))
            return;
        end
        local ids={}
        local picName=this.picList[this.picIndex]
        table.insert(ids,picName);

        for i,v in ipairs(this.myTextList) do
            table.insert(ids,v.Id);
        end
        SimulateRoomMgr.OnAskBlessingPray(ids,function()
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateBlessingViewModel_1"))
            this.ParseData();
        end)
    end)
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.picUIList=UIListView.New(ui.tranPicContent)
        this.picItemObj=vm.behaviour.transform:Find("template/picItem").gameObject;
        this.textUIList=UIListView.New(ui.tranTextContent)

        this.textItemObj=vm.behaviour.transform:Find("template/textItem").gameObject;
        this.firstRewardVM=nil;
        this.rewardUIList=UIListView.New(ui.tranGoods);
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", this.OnBack);
            this.prayList={}
            for i,v in pairs(ConfigMgr.Config.SimulatePrayMap) do
                table.insert(this.prayList,v);
            end
            table.sort(this.prayList,function(a, b)  return tonumber(a.Id)<tonumber(b.Id) end)
            this.picList=ConfigMgr.Config.SimulateConstants.SimulatePrayPic;
            this.maxPrayCount=ConfigMgr.Config.SimulateConstants.SimulatePrayChooseLimit
            this.firstRewards=ConfigMgr.Config.SimulateConstants.SimulatePrayFirstReward;
            this.picIndex=1;
            this.textIndex=1;
            this.myTextList={};
            table.insert(this.myTextList,this.prayList[this.picIndex]);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.picUIList:Clear();
        this.textUIList:Clear();
        this.rewardUIList:Clear();

    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_BlessingPicItem")
        UIListView.ClearItem("Simulate_BlessingTextItem")
        UIListView.ClearItem("Simulate_BlessingRewardItem")
    end
}
this.OnBack=function()
    SimulateRoomMgr.OnAskOnAskBlessingPrayList(function()
        LuaMgr.Back();
    end)
end

this.ParseData=function()
    this.dataSimulatePray=DataMgr.Player.SimulatePray;
    this.SetPicUIList();
    this.SetTextUIList();
    this.SetFirstRewards();
    ui.txtTips2.text=string.format(LuaMgr.GetLangText("SimulateBlessingViewModel_2"),this.maxPrayCount);
    
end


this.SetPicUIList=function()
    this.picUIList:Clear();
    local list={}
    for i,v in ipairs(this.picList) do
        local picItem={
            index=i,
            picName=v;
            isSelect=i==this.picIndex,
            callBack=this.PicCallBack,
        }
        local picData=UIListData.GetData(this.picItemObj,"Simulate_BlessingPicItem",picItem)
        table.insert(list,picData);
    end
    this.picUIList:SetData(list);
    this.SetPicInfo();
end

this.PicCallBack=function(index)
    if this.picIndex~=nil and this.picIndex==index then
        return
    end
    this.picIndex=index;
    for i,v in ipairs(this.picUIList.dataList) do
        v.data.isSelect=i==this.picIndex;
    end
    this.picUIList:Refresh();
    this.SetPicInfo()
end

this.SetPicInfo=function()
    local picName=this.picList[this.picIndex]
    ui.imgBless.sprite=LuaMgr.GetSprite("Simulate",picName);
end

this.SetTextUIList=function()
    this.textUIList:Clear();
    local list={}
    for i,v in ipairs(this.prayList) do
        local textItem={
            id=v.Id,
            index=i,
            num=0,
            isSelect=false;
            info=LuaMgr.GetLangText(v.TextLan),
            callBack=this.TextCallBack
        }
        local locIndex=this.FindInMyList(v.Id)
        if locIndex>0  then
            textItem.num=locIndex;;
            textItem.isSelect=true;
        end
        local textData=UIListData.GetData(this.textItemObj,"Simulate_BlessingTextItem",textItem);
        table.insert(list,textData);
    end
    this.textUIList:SetData(list);
    this.SetMyText()
end



this.FindInMyList=function(id)
    for i,v in ipairs(this.myTextList) do
        if v.Id==id then
            return i;
        end
    end
    return 0
end

this.TextCallBack=function(index)
    local prayItem=this.prayList[index];
    local locIndex=this.FindInMyList(prayItem.Id)
    if locIndex>0 then
        table.remove(this.myTextList,locIndex);
    else
        if #this.myTextList>=this.maxPrayCount then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateBlessingViewModel_3"))
            return;
        end
        table.insert(this.myTextList,prayItem);
    end
    this.textIndex=index;
    for i,v in ipairs(this.textUIList.dataList) do
        local num= this.FindInMyList(v.data.id);
        v.data.num=num;
        v.data.isSelect=num>0;
    end
    this.textUIList:Refresh();
    this.SetMyText();
end

this.SetMyText=function()
    local info="";
    for i,v in ipairs(this.myTextList) do
        if IsNullOrEmpty(info) then
            info=info..LuaMgr.GetLangText(v.TextLan);
        else
            info=info..","..LuaMgr.GetLangText(v.TextLan);
        end
    end
    ui.txtBlessInfo.text=info;
end



this.SetFirstRewards=function()
    this.rewardUIList:Clear();
    local list={}
    for i,v in ipairs(this.firstRewards) do
        local item={
            item=v,
            isGet=this.dataSimulatePray.First;
        }
        local itemData=UIListData.GetData(this.rewardItemObj,"Simulate_BlessingRewardItem",item);
        table.insert(list,itemData);
    end
    this.rewardUIList:SetData(list);
   
end

return vm({
    data = data,
    command = command,
    hook = hook
})