FoundationHeroChoiceItem = {};

FoundationHeroChoiceItem.__index = FoundationHeroChoiceItem;

local objs = {
    bg = { path = "Bg", type = "Button" },
    body = { path = "Bg/Body", type = "RawImage" },
    job = { path = "Bg/Job", type = "Image" },
    rare = { path = "Bg/Rare", type = "Image" },
    building = { path = "Bg/Building", type = "GameObject" },
    buildingText = { path = "Bg/Building/Text", type = "Text" },
    hgText = { path = "Bg/HG/Text", type = "Text" },
    nameText = { path = "Bg/Name", type = "Text" },
    select = { path = "Bg/Select", type = "GameObject" },
    num = { path = "Bg/Select/Num", type = "Image" },
}

function FoundationHeroChoiceItem.New(prefab, parent)
    local self = {};
    setmetatable(self, FoundationHeroChoiceItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    LuaMgr.SetFont(self.transform);
    self.OnClickBg = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationHeroChoiceClick, self.data);
    end
    LuaMgr.AddClick(self.bg, self.OnClickBg);
    return self;
end

function FoundationHeroChoiceItem:SetData(data)
    self.data = data;
    local config = ConfigMgr.Config.characterTable[data];
    if (config ~= nil) then
        self.body.texture = LuaMgr.GetTexture(HeroManager.GetCharacterCard(data));
        self.job.sprite = LuaMgr.GetSprite("JobIcon","job_" .. config.job);
        local tempRare = HeroMgr.GetHeroNowRare(config.id)
        local imageRare = tempRare >= 5 and 4 or tempRare
        self.rare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_"..imageRare);
        local characterData = DataMgr.Player.characters[data];
        if (characterData ~= nil and characterData.prestigeLevel >= 10) then
            self.hgText.text = ConfigMgr.LangGlobal("6969");
        else
            local hg = DataMgr.Player.weeklyCount["prest_" .. data] or 0;
            local maxHG = ConfigMgr.Config.constants.MaxPrestigeByWorkPerWeek;
            self.hgText.text = string.format(LuaMgr.GetLangText("FoundationHeroChoiceItem_1"), hg, maxHG);
        end
        local buildingId = PlayerFoundationMgr.GetCharacterBuilding(data);
        if (buildingId ~= nil) then
            local buildingConfig = ConfigFoundationMgr.GetInteractionById(buildingId);
            if (buildingConfig ~= nil) then
                self.buildingText.text = LuaMgr.GetLangText(buildingConfig.NameLan);
                SetActive(self.building, true);
            else
                SetActive(self.building, false);
            end
        else
            SetActive(self.building, false);
        end
        self.nameText.text = LuaMgr.GetLangText(config.namelan);
        local num = PlayerFoundationMgr.GetSelectCharacterNum(data);
        if (num > 0) then
            self.num.sprite = LuaMgr.GetSprite("NumberFont", num);
            SetActive(self.select, true);
        else
            SetActive(self.select, false);
        end
    end
    self.gameObject:SetActive(true);
end

function FoundationHeroChoiceItem:Clear()
    self.data = nil;
    self.gameObject:SetActive(false);
end

function FoundationHeroChoiceItem:Destroy()
    if (self.OnClickBg ~= nil) then
        LuaMgr.RemoveClick(self.bg, self.OnClickBg);
        self.OnClickBg = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end