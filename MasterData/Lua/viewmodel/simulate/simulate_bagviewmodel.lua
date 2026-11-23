require("ViewModel/Simulate/Simulate_BagItem")
Simulate_BagViewModel = {};

Simulate_BagViewModel.__index = Simulate_BagViewModel;

local objs = {
    tranContent={path="root/ScrollView/Viewport/tranContent",type="Transform"},
    lanternItemObj={path="root/ScrollView/Viewport/tranContent/lanternItem",type="GameObject"},
}


function Simulate_BagViewModel.New(parent)
    local self = {};
    setmetatable(self, Simulate_BagViewModel);
    local path="Assets/_BundleResources/UI/Simulate/SimulateBagItem.prefab";
    self.gameObject=LuaMgr.GetPrefab(path);
    if self.gameObject~=nil then
        self.gameObject.transform:SetParent(parent,false);
        self.gameObject.transform.localPosition = Vector3.zero;
        self.gameObject.transform.localScale=Vector3.one;
    end
    self:Init();
    return self;
end


function Simulate_BagViewModel:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.lightUIList=UIListView.New(self.tranContent);

    self.lightList={}
    for i,v in pairs(ConfigMgr.Config.SimulateHandBookMap) do
        table.insert( self.lightList,v);
    end
    table.sort( self.lightList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
    self.selectDic={};
end



function Simulate_BagViewModel:SetData(exchangeId,orderNeedDic,callBack)
    self.selectDic={};
    if not IsNull(orderNeedDic) then
        for i,v in ipairs(self.lightList) do
            if orderNeedDic[v.Id]~=nil then
                v.sortNum=i;
            else
                v.sortNum=100;
            end
        end
        table.sort(self.lightList,function(a, b)
            if a.sortNum==b.sortNum then
                return tonumber(a.Id)<tonumber(b.Id)
            else
                return a.sortNum<b.sortNum;
            end
        end)
    end
    self.bagCallBack=callBack;
    local exchangeOrderInfo=nil;
    self.orderNeedDic=orderNeedDic==nil and {} or orderNeedDic;
    if exchangeId~=nil then
        exchangeOrderInfo=ConfigMgr.Config.SimulateExchangePoolMap[exchangeId]
    end
self.orderNeedCount=0;
    for i,v in pairs(self.orderNeedDic) do
        self.orderNeedCount=self.orderNeedCount+v.count;
    end
    self.maxNum=self.orderNeedCount;
    self.lightUIList:Clear();
    local list={}
    for i,v in ipairs(self.lightList) do

        if exchangeOrderInfo==nil or exchangeOrderInfo.Type==1 or (exchangeOrderInfo.Type==2 and self.orderNeedDic[v.Id]~=nil) then
            local myCount=SimulateRoomMgr.GetLanternCount(v.Id);
            if myCount>0 then
                local lanternItem={
                    id=v.Id,
                    index=i,
                    name=LuaMgr.GetLangText(v.NameLan),
                    iconName=v.Icon;
                    count=myCount;
                    needCount=0;
                    isSelect=false;
                    isTag=false
                }
                if exchangeOrderInfo~=nil and exchangeOrderInfo.Type==1 and self.orderNeedDic[v.Id]~=nil then
                    lanternItem.isTag=true
                    local index=self.orderNeedDic[v.Id].index;
                    local rate=exchangeOrderInfo.Rate[index];
                    if rate~=nil then
                        lanternItem.tagInfo=string.format("+%s%%",rate/100);
                    end
                else
                    lanternItem.isTag=false
                end
                lanternItem.callBack=function(index)
                    self:ClickCallBack(index);
                end
                local lanternData=UIListData.GetData(self.lanternItemObj,"Simulate_BagItem",lanternItem)
                table.insert(list,lanternData)
            end
        end
    end
    self.lightUIList:SetData(list);
end

function Simulate_BagViewModel:UpdateData(autoDic)
    self.selectDic=autoDic;
    for i,v in ipairs(self.lightUIList.dataList) do
        if autoDic[v.data.id]~=nil then
            v.data.isSelect=true;
            v.data.needCount=self.selectDic[v.data.id].count
            self.orderNeedCount=self.maxNum-self.selectDic[v.data.id].count;
        else
            v.data.isSelect=false;
        end
    end
    self.lightUIList:Refresh();
end

function Simulate_BagViewModel:ClickCallBack(index)
    if self.bagCallBack==nil then return end;
    local lightId=self.lightList[index].Id
    if self.selectDic[lightId]==nil then
        local num=1;
        if self.orderNeedCount>0 then
            local myCount=SimulateRoomMgr.GetLanternCount(lightId);
            num=myCount>self.orderNeedCount and self.orderNeedCount or myCount;
        end
        self.orderNeedCount=self.orderNeedCount-num;
        self.selectDic[lightId]={id=lightId,time=LuaMgr.Timestamp(),count=num};
    else
        self.orderNeedCount=self.orderNeedCount+self.selectDic[lightId].count;
        self.selectDic[lightId]=nil;
    end
    for i,v in ipairs(self.lightUIList.dataList) do
        v.data.isSelect=self.selectDic[v.data.id]~=nil;
        v.data.needCount=self.selectDic[v.data.id]~=nil and self.selectDic[v.data.id].count or 0
    end
    self.lightUIList:Refresh();
    if self.bagCallBack~=nil then
        self.bagCallBack(self.selectDic)
    end
end

function Simulate_BagViewModel:Clear()
    self.data=nil
    self.lightUIList:Clear();
    self.selectDic={};
    self.orderNeedCount=0;
end


function Simulate_BagViewModel:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    UIListView.ClearItem("Simulate_BagItem");
end

