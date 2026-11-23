SelectCharacter_HeadItem = {};

SelectCharacter_HeadItem.__index = SelectCharacter_HeadItem;
local objs = {
    rawIcon={ path = "Icon", type = "RawImage" },
    imgRare = { path = "Frame", type = "Image" },
    textName = { path = "Name/Text", type = "Text" },
    goSelect={path = "Select", type = "GameObject"},
    btnIcon={path = "Icon", type = "Button"}
}

function SelectCharacter_HeadItem.New()
    local self = {};
    setmetatable(self, SelectCharacter_HeadItem);
    return self;
end

function SelectCharacter_HeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        if self.data.data.callBack~=nil then
           SetActive(self.goSelect,true)
            self.data.data.callBack(self.data.data.indexData)
        end
    end)
end

function SelectCharacter_HeadItem:SetData(pdata)
    self.data = pdata.data;
    self.rawIcon.texture=self.data.data.datas.icon;
    self.textName.text=self.data.data.datas.name;
    local imageRare = self.data.data.datas.rare >= 5 and 4 or self.data.data.datas.rare
    self.imgRare.sprite=LuaMgr.GetSprite("CommonRes","ui_home_kbn_tx"..imageRare);
    print(self.data.data.isSelect)
    SetActive(self.goSelect,self.data.data.isSelect)
end

function SelectCharacter_HeadItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end


function SelectCharacter_HeadItem:Clear()
    self.data = nil;
end

function SelectCharacter_HeadItem:Destroy()
    self.rawIcon=nil;
    self.imgRare =nil;
    self.textName = nil;
    self.goSelect=nil;
    self.btnIcon=nill;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end