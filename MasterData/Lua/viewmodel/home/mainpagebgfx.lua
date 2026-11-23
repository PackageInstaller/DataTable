
MainPageBGFX = {};
MainPageBGFX.__index = MainPageBGFX;
MainPageBGFX.New = function(container)
    local self = {};
    setmetatable(self, MainPageBGFX);
    self.gameObject =LuaMgr.GetPrefab(Path.UI_PATH.."Home/BGRT.prefab")
    if self.gameObject~=nil then
        self.transform = self.gameObject.transform;
        self.transform.localScale = Vector3.one;
        self.transform.position = Vector3(1000,1000,0)
        self.camera= self.transform:Find("Camera"):GetComponent("Camera");
        self.BGFXRoot=self.transform:Find("BGFX");
        self.bgFXObject=nil;
        self.bgName=nil;
self.rt=UnityEngine.RenderTexture.GetTemporary(1680, 720, 0,UnityEngine.RenderTextureFormat.ARGB32);
        self.camera.targetTexture = self.rt;
    end
    return self;
end

function MainPageBGFX:SetBGFX(name,fxPath,rawImg)
    if self.gameObject==nil then return end;
    if self.bgName~=name then
        if self.bgFXObject~=nil then
            LuaMgr.DestroyImmediateGO(self.bgFXObject);
        end
        self.bgFXObject=LuaMgr.GetPrefab(fxPath)
        if self.bgFXObject==nil then
            LuaDebug.error("bgFXObject is nil")
            return;
        end
        self.bgFXObject.transform.localScale=Vector3.one
        self.bgFXObject.transform.localPosition=Vector3(0,0,200);
        self.bgFXObject.transform:SetParent(self.BGFXRoot, false);
    end
    self.bgName=name;
    rawImg.texture=self.rt;
end


function MainPageBGFX:Clear()
    if self.bgFXObject~=nil then
        LuaMgr.DestroyImmediateGO(self.bgFXObject);
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
    self.rt=nil;
    self.bgName=nil;
end

