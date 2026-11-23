





AreaMapChapterItem = {};

AreaMapChapterItem.__index = AreaMapChapterItem;
local PREFAB_PATH = "Assets/_BundleResources/UI/Area/AreaMapChapterItem.prefab";

function AreaMapChapterItem.New(parent, index)
	local self = {}
	setmetatable(self, AreaMapChapterItem);
	self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
	LuaMgr.AddPrefabRefCount(PREFAB_PATH);
	self.transform = self.gameObject:GetComponent("RectTransform")
	self.transform:SetParent(parent, false);
	local uiLink = self.gameObject:GetComponent("UILink");
	self.imgBG = uiLink:Get("imgBG"):GetComponent("Image");
	self.btnBG = uiLink:Get("imgBG"):GetComponent("UIButtonClick");
	self.imgName = uiLink:Get("imgName"):GetComponent("Image");
	self.imgNameUnLock = uiLink:Get("imgName")
	self.imgNum = uiLink:Get("imgNum"):GetComponent("Image");
	self.goLoc = uiLink:Get("goLoc");
	self.goTag = uiLink:Get("goTag");
	self.imgTag = uiLink:Get("goTag"):GetComponent("Image");
	self.index = index;
	self.btnBGClickFun = nil;
	self.btnBGClickEvent=function ()
		self.btnBGClickFun(self.index);
	end
	uiLink:AddClickEvent("imgBG",self.btnBGClickEvent)
	return self
end

function AreaMapChapterItem:Clear()
	LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
	LuaMgr.DestroyImmediateGO(self.gameObject);
	self.gameObject = nil
	self.transform = nil
	self.imgBG = nil;
	self.imgName = nil;
	self.imgNum = nil;
	self.goLoc = nil;
	self.goTag = nil;
	self.imgTag = nil;
	self.imgNameUnLock = nil;
	self.index = nil;
	self.btnBGClickFun = nil;
end