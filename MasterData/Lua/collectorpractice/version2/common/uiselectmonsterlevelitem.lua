UISelectMonsterLevelItem = {}
UISelectMonsterLevelItem.__index = UISelectMonsterLevelItem




function UISelectMonsterLevelItem.New(prefab, parent) 
	local self = {}
	setmetatable(self, UISelectMonsterLevelItem)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.goIsNotSelected = uiLink:Get("goIsNotSelected");
		self.goIsSelected = uiLink:Get("goIsSelected");
		self.textLevel1 = uiLink:Get("textLevel1"):GetComponent("Text");
		self.textLevel2 = uiLink:Get("textLevel2"):GetComponent("Text");
		self.btnClickLevel = uiLink:Get("btnClickLevel"):GetComponent("Button");
self.goLevel1=uiLink:Get("goLevel1");
		self.goLevel2=uiLink:Get("goLevel2");
		self.goLevel3=uiLink:Get("goLevel3");

        self.fun=nil;
		self.mapId=nil;
		self.parent=nil;
		self.index=nil;
        uiLink:AddClickEvent("btnClickLevel", function()
            if self.fun~=nil then
                self.fun(self.parent,self);
            end
        end)
	return self
	end


	function UISelectMonsterLevelItem:Destroy() 
	self.gameObject = nil
	self.transform = nil
		self.goIsNotSelected = nil;
		self.goIsSelected = nil;
		self.textLevel1 = nil;
		self.textLevel2 = nil;
		self.btnClickLevel = nil;
        self.fun=nil;
		self.mapId=nil;
		self.parent=nil;
		self.index=nil;
		self.goLevel1=nil;
		self.goLevel2=nil;
		self.goLevel3=nil;
	end


function UISelectMonsterLevelItem:SetData(mapId,index,titleText,fun,parent)
	SetActive(self.gameObject,true);
	self.mapId=mapId;
	self.index=index;
    self.textLevel1.text = titleText;
    self.textLevel2.text = titleText;
    self.fun=fun;
	self.parent=parent;
	local temp={self.goLevel1,self.goLevel2,self.goLevel3};
	for i = 1, 3, 1 do
		if i==index then
			SetActive(temp[i],true);
		else
			SetActive(temp[i],false);
		end
	end
end

function UISelectMonsterLevelItem:SetSelectState(isSelected)
    SetActive(self.goIsSelected,isSelected);
    SetActive(self.goIsNotSelected,not isSelected);
end

function UISelectMonsterLevelItem:Hide()
    SetActive(self.gameObject, false);
end

