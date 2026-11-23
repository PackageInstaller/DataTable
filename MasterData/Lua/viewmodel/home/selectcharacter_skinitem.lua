SelectCharacter_SkinItem = {};

SelectCharacter_SkinItem.__index = SelectCharacter_SkinItem;
local objs = {
    rawIcon={ path = "kuang/icon", type = "RawImage" },
    goSelect = { path = "goSelect", type = "GameObject" },
    btnClick={path = "kuang", type = "Button"},
    goTag={path = "tag", type = "GameObject"},
    goSelected={ path = "goSelected", type = "GameObject" },
    btnAddClick={path = "goSelect/AddBtn", type = "Button"},
    btnRemoveClick={path = "goSelect/RemoveBtn", type = "Button"},
}

function SelectCharacter_SkinItem.New()
    local self = {};
    setmetatable(self, SelectCharacter_SkinItem);
    return self;
end

function SelectCharacter_SkinItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
    LuaMgr.AddClick(self.btnAddClick,function()
        if self.data.addCallBack~=nil then
            self.data.addCallBack(self.data.index);
        end
    end)
    LuaMgr.AddClick(self.btnRemoveClick,function()
        if self.data.removeCallBack~=nil then
            self.data.removeCallBack(self.data.index);
        end
    end)
end


function SelectCharacter_SkinItem:SetActive(isOn)
    SetActive(self.goSelect,isOn)
    if isOn then
        SetActive(self.btnAddClick.gameObject,not self.data.isSelected)
        SetActive(self.btnRemoveClick.gameObject,self.data.isSelected)
    else
        SetActive(self.btnAddClick.gameObject,false)
        SetActive(self.btnRemoveClick.gameObject,false)
    end
end

function SelectCharacter_SkinItem:SetData(pdata)
    self.data = pdata.data;
    self.rawIcon.texture=self.data.skinTex;
    SetActive(self.goTag,self.data.isTag);
    SetActive(self.goSelected,self.data.isSelected);
    self:SetActive(self.data.isSelect)
end

function SelectCharacter_SkinItem:UpdateState(isOn)
    SetActive(self.goSelected,isOn);
    SetActive(self.btnAddClick.gameObject,not isOn);
end

function SelectCharacter_SkinItem:Clear()
    self.data = nil;
end

function SelectCharacter_SkinItem:Destroy()
    self.rawIcon=nil;
    self.goSelect =nil;
    self.btnClick=nil;
    self.goTag=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end