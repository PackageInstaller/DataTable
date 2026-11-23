AssistHero_HeadGroup = {};

AssistHero_HeadGroup.__index = AssistHero_HeadGroup;
local objs = {
    rootTF={path="root",type="Transform"},
    list={path="root/list",type="Transform"},
}

   

function AssistHero_HeadGroup.New()
    local self = {};
    setmetatable(self, AssistHero_HeadGroup);
    return self;
end

function AssistHero_HeadGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.headUIList=UIListView.New(self.list);
end


function AssistHero_HeadGroup:SetData(pdata)
    self.data=pdata.data
    self:SetHeadList();
end

function AssistHero_HeadGroup:SetHeadList()
    if IsNull(self.data.dataList) or #self.data.dataList==0 then return end;
    local list={}
    self.headCalBack=function(id,index)
        self.data.groupCallBack(id,self.data.groupIndex,index);
    end
    for i,v in ipairs(self.data.dataList) do
        local headItem={
            index=i,
            character=v;
            callBack=self.headCalBack
        }
        local headData=UIListData.GetData(self.data.headItemObj,"AssistHero_HeadItem",headItem);
        table.insert(list,headData)
    end
    self.headUIList:SetData(list);
    
end



function AssistHero_HeadGroup:Clear()
    self.headUIList:Clear();
    self.data=nil
end

function AssistHero_HeadGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

