
RawImageFX = {};
RawImageFX.__index = RawImageFX;
RawImageFX.New = function(prefabPath)
    local self = {};
    setmetatable(self, RawImageFX);
    self.gameObject =LuaMgr.GetPrefab(Path.UI_PATH.."SeasonSLG/RawImageRT.prefab")
    if self.gameObject~=nil then
        self.transform = self.gameObject.transform;
        self.transform.localScale = Vector3.one;
        self.transform.position = Vector3(1000,1000,0)
        self.camera= self.transform:Find("Camera"):GetComponent("Camera");
        self.fxRoot=self.transform:Find("FX");
    end
    return self;
end

function RawImageFX:GetRawImage()
    return self.rt;
end

function RawImageFX:SetData(fxPath,width,heigh)
    self.bgFXObject=LuaMgr.GetPrefab(fxPath)
    if self.bgFXObject==nil then
        LuaDebug.error("bgFXObject is nil")
        return;
    end
    self.bgFXObject.transform.localScale=Vector3.one
    self.bgFXObject.transform.localPosition=Vector3(0,0,0);
    self.bgFXObject.transform:SetParent(self.fxRoot, false);
    local format = self.camera.allowHDR and  UnityEngine.RenderTextureFormat.ARGBHalf or UnityEngine.RenderTextureFormat.ARGB32;
    self.rt=UnityEngine.RenderTexture.GetTemporary(width, heigh, 0,format);
    self.camera.targetTexture = self.rt;
    return self.rt;
end


function RawImageFX:Clear()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
    self.rt=nil;
end
