Qin2Main_LineItem = {};

Qin2Main_LineItem.__index = Qin2Main_LineItem;
local objs = {
  
    icon={ path = "root/bg/icon", type = "Image" },
    nameText={ path = "root/Text", type = "Text" },
    proText={ path = "root/pro", type = "Text" },
    lockObj={path="root/lock",type="GameObject"},
    btnBG={path="root/bg",type="Button"},
}

function Qin2Main_LineItem.New()
    local self = {};
    setmetatable(self, Qin2Main_LineItem);
    self.isActive=false;
    return self;
end

function Qin2Main_LineItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBG,function()
        if  self.data.locCallBack~=nil then
            self.data.locCallBack(self.data.id,self.data.isUnLock);
        end
    end)
end







function Qin2Main_LineItem:SetData(pdata)
    self.data = pdata.data
    self.icon.sprite=LuaMgr.GetSprite("Qin2",self.data.iconName.."_1");
    self.nameText.text=self.data.name;
    self.proText.text=self.data.pro;
    SetActive(self.lockObj,not self.data.isUnLock)
end





function Qin2Main_LineItem:Clear()
    self.data = nil;
end

function Qin2Main_LineItem:Destroy()
    self.icon=nil;
    self.nameText=nil;
    self.proText=nil;
    self.btnBG=nil;
    self.lockObj=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end