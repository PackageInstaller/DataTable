
UIPathSLotItem = {}
UIPathSLotItem.__index = UIPathSLotItem


function UIPathSLotItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UIPathSLotItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goBottomImage = uiLink:Get("goBottomImage");
    self.goCharacter = uiLink:Get("goCharacter");
    self.goFinishStart1 = uiLink:Get("goFinishStart1");
    self.goimgStar01 = uiLink:Get("goimgStar01");
    self.goFinishStart2 = uiLink:Get("goFinishStart2");
    self.goimgStar02 = uiLink:Get("goimgStar02");
    self.goFinishStart3 = uiLink:Get("goFinishStart3");
    self.goimgStar03 = uiLink:Get("goimgStar03");
    self.goFinishStart4 = uiLink:Get("goFinishStart4");
    self.goimgStar04 = uiLink:Get("goimgStar04");
    self.goFinishStart5 = uiLink:Get("goFinishStart5");
    self.goimgStar05 = uiLink:Get("goimgStar05");
    self.goLock = uiLink:Get("goLock");
    self.imgTagIcon1 = uiLink:Get("imgTagIcon1"):GetComponent("Image");
    self.imgTagIcon2 = uiLink:Get("imgTagIcon2"):GetComponent("Image");
    self.textTagIconName1 = uiLink:Get("textTagIconName1"):GetComponent("Text");
    self.textTagIconIntro1 = uiLink:Get("textTagIconIntro1"):GetComponent("Text");
    self.textTagIconName2 = uiLink:Get("textTagIconName2"):GetComponent("Text");
    self.textTagIconIntro2 = uiLink:Get("textTagIconIntro2"):GetComponent("Text");
    self.textTime = uiLink:Get("textTime"):GetComponent("Text");
    self.rawImageHead = uiLink:Get("rawImageHead"):GetComponent("RawImage");
    self.btnStart = uiLink:Get("btnStart"):GetComponent("Button");
    self.CHARACTERPATH = "Assets/_BundleResources/Character/%s/Avatar/%s.png";
    self.animator = self.gameObject:GetComponent("Animator");
    self.isLock = false;
    self.mapId = nil;
    uiLink:AddClickEvent("btnStart", function()
        if self.isLock then
            return;
        end
        CollectorPracticeMgr.StartNewGame(self.mapId);
    end);
    return self
end

function UIPathSLotItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.goBottomImage = nil;
    self.goCharacter = nil;
    self.goFinishStart1 = nil;
    self.goimgStar01 = nil;
    self.goFinishStart2 = nil;
    self.goimgStar02 = nil;
    self.goFinishStart3 = nil;
    self.goimgStar03 = nil;
    self.goFinishStart4 = nil;
    self.goimgStar04 = nil;
    self.goFinishStart5 = nil;
    self.goimgStar05 = nil;
    self.goLock = nil;
    self.imgTagIcon1 = nil;
    self.imgTagIcon2 = nil;
    self.textTagIconName1 = nil;
    self.textTagIconIntro1 = nil;
    self.textTagIconName2 = nil;
    self.textTagIconIntro2 = nil;
    self.textTime = nil;
    self.rawImageHead = nil;
    self.btnStart = nil;
    self.mapId = nil;
    self.animator=nil;
end

function UIPathSLotItem:SetData(startTime, data)
    self.mapId = data.MapId;
    local otConfig = ConfigMgr.Config.OriginsTalentMap;
    local otShow1 = otConfig[data.OTshow[1]];
    local teleten = ConfigMgr.Config.talentBankMap
    self.imgTagIcon1.sprite = LuaMgr.GetSprite("CollectorHome", otShow1.OriginsID);
    self.textTagIconName1.text = LuaMgr.GetLangText(otShow1.OtNameLan);
    self.textTagIconIntro1.text = LuaMgr.GetLangText(teleten[otShow1.TalentId[1]].DescriptionLan)
    local otShow2 = otConfig[data.OTshow[2]];
    self.imgTagIcon2.sprite = LuaMgr.GetSprite("CollectorHome", otShow2.OriginsID);
    self.textTagIconName2.text = LuaMgr.GetLangText(otShow2.OtNameLan);
    self.textTagIconIntro2.text = LuaMgr.GetLangText(teleten[otShow2.TalentId[1]].DescriptionLan)

    local nowTime = LuaMgr.Timestamp();
    local endTime = startTime + (data.EndTime*60);
    local openTime = startTime + (data.StartTime*60)
if nowTime >= endTime then
        local timeTipsString = ConfigMgr.LangGlobal("7130");
        self.textTime.text = timeTipsString;
        self.isLock = true;
elseif nowTime < openTime then
        local day = math.floor((openTime - nowTime) / 86400);
if day < 0.5 then
            local timeTipsString = ConfigMgr.LangGlobal("7132");
self.textTime.text = string.format(timeTipsString, math.floor((openTime - nowTime) / 3600),math.ceil(((openTime - nowTime) % 3600)/60))
        else
            local timeTipsString = ConfigMgr.LangGlobal("7131");
self.textTime.text = string.format(timeTipsString, math.ceil((openTime - nowTime) / 86400))
        end
        self.isLock = true;
    else
        self.isLock = false;
    end
    self:SetLock();
    local suggestLevelString = ConfigMgr.LangGlobal("7129");

    self.rawImageHead.texture = LuaMgr.GetTexture(string.format(self.CHARACTERPATH, string.sub(data.CharacterID, 1, 5),
        tostring(data.CharacterID)));
local completeNum = CollectorPracticeMgr.characterToCompleteNum["MapA"][data.CharacterID];
    local temp = {};
    table.insert(temp, self.goFinishStart1);
    table.insert(temp, self.goFinishStart2);
    table.insert(temp, self.goFinishStart3);
    table.insert(temp, self.goFinishStart4);
    table.insert(temp, self.goFinishStart5);
    local temp2 = {};
    table.insert(temp2, self.goimgStar01);
    table.insert(temp2, self.goimgStar02);
    table.insert(temp2, self.goimgStar03);
    table.insert(temp2, self.goimgStar04);
    table.insert(temp2, self.goimgStar05);
    local needShow = {}
    for i = 1, 5, 1 do
        if i <= completeNum then
            SetActive(temp[i], true);
            table.insert(needShow, temp2[i]);
        else
            SetActive(temp[i], false);
        end
        SetActive(temp2[i], false);
    end
for key, value in pairs(needShow) do
        SetActive(value, true);
    end
end

function UIPathSLotItem:ShowFirstAnimation()

    self.animator:Play("ani_CollectorPracticeMainScenePanel_rectTips_trigger",0,0);

end

function UIPathSLotItem:SetLock()
    SetActive(self.goLock, self.isLock)
    SetActive(self.goCharacter, not self.isLock)
    SetActive(self.goBottomImage, not self.isLock)
end

function UIPathSLotItem:Hide()
    SetActive(self.gameObject, false);
end

function UIPathSLotItem:Clear()
    SetActive(self.gameObject, false);
end