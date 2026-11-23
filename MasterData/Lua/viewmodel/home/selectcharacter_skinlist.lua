
SelectCharacter_SkinList = {};

SelectCharacter_SkinList.__index = SelectCharacter_SkinList;

local objs = {

}

function SelectCharacter_SkinList.New()
    local self = {};
    setmetatable(self, SelectCharacter_SkinList);
    return self;
end

function SelectCharacter_SkinList:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.headUIList = UIListView.New(self.transform);
end

function SelectCharacter_SkinList:SetData(pdata)
    self.data = pdata.data;
    local list = {}
    for i, v in ipairs(self.data) do
        local headData = UIListData.GetData(v.itemObj, "SelectCharacter_SkinItem", v);
        table.insert(list, headData);
    end
    self.headUIList:SetData(list);
end

function SelectCharacter_SkinList:SetIndex(index, isOn)
    for i, v in ipairs(self.headUIList.itemList) do
        if v.data.index.col == index then
            v:SetActive(isOn)
            break
        end
    end
end

function SelectCharacter_SkinList:Clear()
    self.data = nil;
end

function SelectCharacter_SkinList:Destroy()    
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.headUIList = nil
    self.gameObject = nil;
end