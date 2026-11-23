Simulate_BagItem = {};

Simulate_BagItem.__index = Simulate_BagItem;

local objs = {
    imgIcon={path="root/icon",type="Image"},
    txtName={path="root/name",type="Text"},
    txtCount={path="root/count",type="Text"},
    goTag={path="root/tag",type="GameObject"},
    txtTag={path="root/tag/Text",type="Text"},
    iconBtn={path="root/icon",type="Button"},
    goSelect={path="root/select",type="GameObject"},
}



function Simulate_BagItem.New()
    local self = {};
    setmetatable(self, Simulate_BagItem);
    return self;
end

function Simulate_BagItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.gameObject,true);
    LuaMgr.AddClick(self.iconBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end

function Simulate_BagItem:SetData(pdata)
    self.data=pdata.data
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName)
    self.txtName.text=self.data.name;
    if self.data.needCount>0 then
        self.txtCount.text=string.format("%s/%s",self.data.count,self.data.needCount);
    else
        self.txtCount.text=self.data.count;
    end
    if self.data.isTag then
        SetActive(self.goTag,true);
        self.txtTag.text=self.data.tagInfo;
    else
        SetActive(self.goTag,false);
    end
    self:SetSelect(self.data.isSelect)
end

function Simulate_BagItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_BagItem:Clear()
    self.data=nil
end


function Simulate_BagItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

