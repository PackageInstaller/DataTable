Squal_HeadItem = {};

Squal_HeadItem.__index = Squal_HeadItem;

local objs = {
    texName = { path = "bg/nameText", type = "Text" },
    rawHead={path="bg/Image/headImg",type="RawImage"},
    imgRare={path="bg/rare",type="Image"},
    btnBg={path="bg",type="Button"}
}


function Squal_HeadItem.New()
    local self = {};
    setmetatable(self, Squal_HeadItem);
    return self;
end

function Squal_HeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Squal_HeadItem:SetData(pdata)
    self.data=pdata.data
    self.texName.text=self.data.name;
    local path=ConfigHelper.GetCharacterAvatarPath(self.data.id)
    self.rawHead.texture=LuaMgr.GetTexture(path);
    self.imgRare.sprite=LuaMgr.GetSprite("Squad","ui_dzr_yh_xztxk_"..self.data.rare)
    self.onClickBg=function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index)
        end
    end
    LuaMgr.AddClick(self.btnBg,self.onClickBg);
    
end



function Squal_HeadItem:Clear()
    self.data = nil;
    LuaMgr.RemoveClick(self.btnBg,self.onClickBg)
end

function Squal_HeadItem:Destroy()
    self.goRewarded=nil;
    self.goods=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end