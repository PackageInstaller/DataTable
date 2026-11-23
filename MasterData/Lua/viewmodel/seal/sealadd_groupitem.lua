SealAdd_GroupItem = {};

SealAdd_GroupItem.__index = SealAdd_GroupItem;
local objs = {
  
    bgSprite={ path = "bg", type = "Image" },
    rawIcon={ path = "bg/raw", type = "RawImage" },
    name={ path = "bg/name", type = "Text" },
    goSelect={ path = "bg/select", type = "GameObject" },
    btnClick={path="bg",type="Button"},
}

function SealAdd_GroupItem.New()
    local self = {};
    setmetatable(self, SealAdd_GroupItem);
    self.isActive=false;
    return self;
end

function SealAdd_GroupItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick,function()
        if self.data~=nil and self.data.callBack~=nil then
            self.data.callBack(self.data.indexData,not self.isActive);
        end
    end)
end


function SealAdd_GroupItem:SetData(pdata)
    self.data = pdata.data.itemData
    self:SetActive(self.data.isActive)
    self.rawIcon.texture=LuaMgr.GetTexture(Path.Image.."FriendlyIcon/friendly_"..self.data.friendly_id..".png")
    self.name.text=self.data.name;
end



function SealAdd_GroupItem:SetActive(isOn)
    self.isActive=isOn;
    SetActive(self.goSelect,isOn);
    self.bgSprite.sprite=isOn and LuaMgr.GetSprite("Seal","ui_sz_yz_yzdb_02") or LuaMgr.GetSprite("Seal","ui_sz_yz_yzdb_01")
end


function SealAdd_GroupItem:Clear()
    self.data = nil;
    self.isActive=false;
end

function SealAdd_GroupItem:Destroy()
    self.goOff=nil;
    self.goOn=nil;
    self.texName=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end