Simulate_ManageHeadItem = {};

Simulate_ManageHeadItem.__index = Simulate_ManageHeadItem;

local objs = {
    addObj={path="root/BG/add",type="GameObject"},
    heroObj={path="root/BG/hero",type="GameObject"},
    rawIcon={path="root/BG/hero/icon",type="RawImage"},
    imgRare={path="root/BG/hero/rare",type="Image"},
    btnBg={path="root/BG",type="Button"},
}

function Simulate_ManageHeadItem.New()
    local self = {};
    setmetatable(self, Simulate_ManageHeadItem);
    return self;
end

function Simulate_ManageHeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg,function()
        if self.data~=nil and self.data.callBack~=nil then
            self.data.callBack(self.data.characterId);
        end
    end)
end


function Simulate_ManageHeadItem:SetData(data)
    self.data=data.data;
    if IsNullOrEmpty(self.data.characterId) then
        SetActive(self.addObj,true);
        SetActive(self.heroObj,false);
    else
        SetActive(self.addObj,false);
        SetActive(self.heroObj,true);
        local path=ConfigHelper.GetCharacterAvatarPath(self.data.characterId);
        self.rawIcon.texture=LuaMgr.GetTexture(path);

        self.imgRare.sprite=LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..self.data.rare);
    end
end

function Simulate_ManageHeadItem:Clear()
    self.data=nil
end

function Simulate_ManageHeadItem:Destroy()
    self.rawIcon=nil;
    self.imgRare=nil;
    self.addObj=nil;
    self.heroObj=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end

