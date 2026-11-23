SelectCharacter_HeadList = {};

SelectCharacter_HeadList.__index = SelectCharacter_HeadList;

local objs = {
    
}

function SelectCharacter_HeadList.New()
    local self = {};
    setmetatable(self, SelectCharacter_HeadList);
    return self;
end

function SelectCharacter_HeadList:Init()
    UITool.Parse(self.gameObject, self, objs);
    require("ViewModel/Home/SelectCharacter_HeadItem")
    self.headUIList=UIListView.New(self.transform);
end

function SelectCharacter_HeadList:SetData(pdata)
    self.data = pdata.data;
    local list={}
    for i,v in ipairs(self.data) do
       local headItem={
           data=v,
       }
        local headData=UIListData.GetData(v.itemObj,"SelectCharacter_HeadItem",headItem);
        table.insert(list,headData);
    end
    self.headUIList:SetData(list);
end


function SelectCharacter_HeadList:SetIndex(index,isOn)
    for i,v in ipairs(self.headUIList.itemList) do
        if v.data.data.indexData.col==index then
            v:SetSelect(isOn)
            break
        end
    end
end

function SelectCharacter_HeadList:Clear()
    self.data = nil;
end

function SelectCharacter_HeadList:Destroy()
  
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.headUIList=nil
    self.gameObject = nil;
end