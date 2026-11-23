MapBlockGroup = {};

MapBlockGroup.__index = MapBlockGroup;
local objs = { 
    rootTF = { path = "root", type = "Transform" },
};

function MapBlockGroup.New()
    local self = {};    
    setmetatable(self, MapBlockGroup);
    return self;
end

function MapBlockGroup:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.blockUIList=UIListView.New(self.rootTF);
end

function MapBlockGroup:SetData(data)   
    self.data = data.data;
    self.rootTF.anchoredPosition=self.data.groupIndex%2==0 and Vector2(52,0) or Vector2(0,0);
    local list={};
    for i,v in ipairs(self.data.list) do
        local blockItem={
            groupIndex=self.data.groupIndex,
            index=i,
            callBack=self.data.callBack;
            data=v;
        }
        local blockData=UIListData.GetData(self.data.blockItemObj,"MapBlockItem",blockItem);
        table.insert(list,blockData);
    end
    self.blockUIList:SetData(list);
end


function MapBlockGroup:UpdateBlock(index)
    local blockItem=self.blockUIList.itemList[index]
end

function MapBlockGroup:Clear()    
    self.data = nil;
    self.blockUIList:Clear();
end

function MapBlockGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end