Dispatch_AttrItem = {};

Dispatch_AttrItem.__index = Dispatch_AttrItem;
local objs = {
    imgIcon = { path = "root/icon", type = "Image" },
    txtName={ path = "root/name", type = "Text" },
    txtMax={ path = "root/max", type = "Text" },
    imgFillAmount={ path = "root/pro/imgFillAmount", type = "Image" },
}

function Dispatch_AttrItem.New()
    local self = {};
    setmetatable(self, Dispatch_AttrItem);
    return self;
end

function Dispatch_AttrItem:Init()
    UITool.Parse(self.gameObject, self, objs);
  
end






function Dispatch_AttrItem:SetData(pdata)
    self.data = pdata.data
    self.imgIcon.sprite=LuaMgr.GetSprite("HMWY","ui_hd_hmwy_qzxq_icon"..self.data.index)
    self.txtName.text=self.data.name;
    self.txtMax.text=NumTool.Round(self.data.curValue);
    self.imgFillAmount.fillAmount=self.data.curValue/self.data.maxValue;
end

function Dispatch_AttrItem:Clear()
    self.data = nil;
end

function Dispatch_AttrItem:Destroy()
   
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject=nil;
end