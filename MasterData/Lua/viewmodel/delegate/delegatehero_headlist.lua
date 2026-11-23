DelegateHero_HeadList = {};

DelegateHero_HeadList.__index = DelegateHero_HeadList;

local objs = {
    
}

function DelegateHero_HeadList.New()
    local self = {};
    setmetatable(self, DelegateHero_HeadList);
    return self;
end

function DelegateHero_HeadList:Init()
    UITool.Parse(self.gameObject, self, objs);
    require("ViewModel/Delegate/DelegateHero_HeadItem")
    self.headUIList=UIListView.New(self.transform);
end

function DelegateHero_HeadList:SetData(pdata)
    self.data = pdata.data;
    local list={}
    for i,v in ipairs(self.data) do
       local headItem={
           data=v,
       }
        local headData=UIListData.GetData(v.heroItemObj,"DelegateHero_HeadItem",headItem);
        table.insert(list,headData);
    end
    self.headUIList:SetData(list);
end


function DelegateHero_HeadList:SetIndex(index,isOn)
    for i,v in ipairs(self.headUIList.itemList) do
        if v.data.indexData.col==index then
            v:SetActiveNum(isOn)
            break
        end
    end
end

function DelegateHero_HeadList:Clear()
    self.data = nil;
end

function DelegateHero_HeadList:Destroy()
  
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.headUIList=nil
    self.gameObject = nil;
end