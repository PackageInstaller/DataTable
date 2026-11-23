UICollectorMainSceneBuffVersion2Item = {}

UICollectorMainSceneBuffVersion2Item.__index = UICollectorMainSceneBuffVersion2Item




function UICollectorMainSceneBuffVersion2Item.New(prefab, parent) 
	local self = {}
	setmetatable(self, UICollectorMainSceneBuffVersion2Item)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.imgBuffIcon = uiLink:Get("imgBuffIcon"):GetComponent("Image");
		self.imgBuffTipsIcon = uiLink:Get("imgBuffTipsIcon"):GetComponent("Image");
		self.textBuffIcon = uiLink:Get("textBuffIcon"):GetComponent("Text");
		uiLink:AddClickEvent("btnClick", function()
LuaMgr.InvokeUIEventListeners(UIEventConst.NeedSaveData);
			LuaMgr.ShowLuaPanel(UIName.CollectorPracticShowAllBuffVersion2ViewModel);
CollectorPracticeMgrVersion2.DeemNotLevelMainScene=true;
		end)
	return self
	end


	function UICollectorMainSceneBuffVersion2Item:Destroy() 
	self.gameObject = nil
	self.transform = nil
		self.imgBuffIcon = nil;
		self.imgBuffTipsIcon = nil;
		self.textBuffIcon = nil;
	end


function UICollectorMainSceneBuffVersion2Item:SetData(showId,buffCount)
	SetActive(self.gameObject,true);
	local buffConfig = json.decode(LuaMgr.GetBuffDes(showId))
	self.imgBuffIcon.sprite = LuaMgr.GetSprite("BuffIcon",CollectorPracticeMgrVersion2.GetBuffValueById(showId).BuffIcon)
	self.imgBuffTipsIcon.sprite=CollectorPracticeMgrVersion2.GetBuffTipsIconSprite(buffCount)
	self.textBuffIcon.text=tostring(buffCount);

end


function UICollectorMainSceneBuffVersion2Item:Hide()
    SetActive(self.gameObject, false);
end