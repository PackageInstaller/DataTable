HuanZhang_HeadGroup = {};

HuanZhang_HeadGroup.__index = HuanZhang_HeadGroup;
local objs = {
    rootTF={path="root",type="Transform"},
    list={path="root/list",type="Transform"},
}



function HuanZhang_HeadGroup.New()
    local self = {};
    setmetatable(self, HuanZhang_HeadGroup);
    return self;
end

function HuanZhang_HeadGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.headUIList=UIListView.New(self.list);
end


function HuanZhang_HeadGroup:SetData(pdata)
    self.data=pdata.data
    self:SetHeadList();
end






function HuanZhang_HeadGroup:SetHeadList()
    if IsNull(self.data.dataList) or #self.data.dataList==0 then return end;
    local list={}
    self.headCalBack=function(id,index)
        self.data.groupCallBack(id,self.data.groupIndex,index);
    end
    for i,v in ipairs(self.data.dataList) do
        local headItem={
            rowIndex=self.data.index,
            colIndex=i,
            heroData=v;
            headCallBack=self.data.callBack
        }
        local headData=UIListData.GetData(self.data.headItemObj,"HuanZhang_HeadItem",headItem);
        table.insert(list,headData)
    end
    self.headUIList:SetData(list);

end



function HuanZhang_HeadGroup:Clear()
    self.headUIList:Clear();
    self.data=nil
end

function HuanZhang_HeadGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
