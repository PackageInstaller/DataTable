Simulate_headItem = {};

Simulate_headItem.__index = Simulate_headItem;

local objs = {
    addObj={path="root/BG/add",type="GameObject"},
    heroObj={path="root/BG/hero",type="GameObject"},
    rawIcon={path="root/BG/hero/icon",type="RawImage"},
    imgRare={path="root/BG/hero/rare",type="Image"},
    btnBg={path="root/BG",type="Button"},
}

function Simulate_headItem.New(parent,scale)
    local self = {};
    setmetatable(self, Simulate_headItem);
    local path="Assets/_BundleResources/UI/Simulate/SimulateHeadItem.prefab";
    self.gameObject=LuaMgr.GetPrefab(path);
    if self.gameObject~=nil then
        self.gameObject.transform:SetParent(parent,false);
        self.gameObject.transform.localPosition = Vector3.zero;
        scale=scale==nil and 1 or scale;
        self.gameObject.transform.localScale=Vector3.one*scale;
    end
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg,function()
        if self.data~=nil and self.data.callBack~=nil then
            self.data.callBack(self.data.characterId);
        end
    end)
    return self;
end


function Simulate_headItem:SetData(data)
    self.data=data;
    SetActive(self.addObj,data==nil);
    SetActive(self.heroObj,data~=nil);
    if data~=nil then
        local path=ConfigHelper.GetCharacterAvatarPath(data.characterId);
        self.rawIcon.texture=LuaMgr.GetTexture(path);
        self.imgRare.sprite=LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..data.rare);
    end
end

function Simulate_headItem:Destroy()
    self.rawIcon=nil;
    self.imgRare=nil;
    self.addObj=nil;
    self.heroObj=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

