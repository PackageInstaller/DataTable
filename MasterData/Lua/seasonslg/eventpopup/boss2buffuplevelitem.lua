Boss2BuffUpLevelItem = {};

Boss2BuffUpLevelItem.__index = Boss2BuffUpLevelItem;
local objs = {
    btnRoot={ path = "root", type = "Button" },
    imgIcon = { path = "root/icon", type = "Image" },
    goType1={ path = "root/type1", type = "GameObject" },
    goType2={ path = "root/type2", type = "GameObject" },
    txtLevel={ path = "root/type1/Level", type = "Text" },
    txtBeforeLevel= { path = "root/type2/UpBeforeLevel", type = "Text" },
    txtAfterLevel= { path = "root/type2/UpAfterLevel", type = "Text" },
};

function Boss2BuffUpLevelItem.New()
    local self = {};
    setmetatable(self, Boss2BuffUpLevelItem);
    return self;
end

function Boss2BuffUpLevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnRoot, function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
end







function Boss2BuffUpLevelItem:SetData(data)
    self.data = data.data;
    self.imgIcon.sprite=self.data.icon;
    if self.oldLevel==nil or self.oldLevel==self.newLevel then
        SetActive(self.goType2,false)
        SetActive(self.goType1,true)
        self.txtLevel.text="Lv."..self.data.newLevel;
    else
        SetActive(self.goType2,true)
        SetActive(self.goType1,false)
        self.txtBeforeLevel.text="Lv."..self.data.oldLeve;
        self.txtAfterLevel.text="Lv."..self.data.newLevel;
    end
end


function Boss2BuffUpLevelItem:Clear()
    self.data = nil;

end

function Boss2BuffUpLevelItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end