
TalentOptionItem={};
TalentOptionItem.__index = TalentOptionItem
function TalentOptionItem.New(prefab, parent) 
	local self = {}
	setmetatable(self, TalentOptionItem)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	local uiLink = self.gameObject:GetComponent("UILink");
		self.textName = uiLink:Get("textName"):GetComponent("Text");
		self.Scrollbar = uiLink:Get("Scrollbar"):GetComponent("ScrollRect");
		self.goDropdown = uiLink:Get("goDropdown");
        self.dropdown=uiLink:Get("goDropdown"):GetComponent("Dropdown");
        self.OptionId="";
	return self
	end


	function TalentOptionItem:Destroy() 
        LuaMgr.DestroyImmediateGO(self.gameObject);
	    self.gameObject = nil
	    self.transform = nil
		self.textName = nil;
		self.Scrollbar = nil;
		self.goDropdown = nil;
	end

    function TalentOptionItem:SetData(characterDataId,index)
        self.dropdown:ClearOptions()
        local this={}
        this.attrConfig = ConfigMgr.Config.characterOptionalMap[characterDataId]
        this.characterData=DataMgr.Player.characters[characterDataId]
        local level=0;
        local totalLevel = #this.attrConfig[index].talentBankId
        if this.characterData==nil or this.characterData.optional == nil or type(this.characterData.optional) == "function" then
            level = 0
        else
            level = this.characterData.optional[this.attrConfig[index].id] == nil and 0 or this.characterData.optional[this.attrConfig[index].id]
        end
self.OptionId=this.attrConfig[index].id;
        local list={}
        table.insert(list,LuaMgr.GetLangText("talentOptionalItem_0"));
for i = 1, totalLevel, 1 do
            local talentBack=ConfigMgr.Config.talentBankMap[this.attrConfig[index].talentBankId[i]]
            table.insert(list,LuaMgr.GetLangText(talentBack.DescriptionLan));
        end
self.textName.text=LuaMgr.GetLangText(ConfigMgr.Config.talentBankMap[this.attrConfig[index].talentBankId[1]].descriptionRemLan);
LuaMgr.AddOptionalOnDropDown(self.dropdown,list);
        self.dropdown.value = level;
    end