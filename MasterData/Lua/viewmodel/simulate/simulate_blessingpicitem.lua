Simulate_BlessingPicItem = {};

Simulate_BlessingPicItem.__index = Simulate_BlessingPicItem;

local objs = {
    imgIcon={path="root/icon",type="Image"},
    txtName={path="root/name",type="Text"},
    iconBtn={path="root/icon",type="Button"},
    goSelect={path="root/select",type="GameObject"},
}



function Simulate_BlessingPicItem.New()
    local self = {};
    setmetatable(self, Simulate_BlessingPicItem);
    return self;
end

function Simulate_BlessingPicItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.gameObject,true);
    LuaMgr.AddClick(self.iconBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end

function Simulate_BlessingPicItem:SetData(pdata)
    self.data=pdata.data
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.picName.."_1")
    self.txtName.text=self.data.picName;
    self:SetSelect(self.data.isSelect)
end

function Simulate_BlessingPicItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_BlessingPicItem:Clear()
    self.data=nil
end


function Simulate_BlessingPicItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

