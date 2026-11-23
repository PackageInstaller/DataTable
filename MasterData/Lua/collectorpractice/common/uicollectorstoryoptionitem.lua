
UICollectorStoryOptionItem = {}

UICollectorStoryOptionItem.__index = UICollectorStoryOptionItem

function UICollectorStoryOptionItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UICollectorStoryOptionItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.imgOptionBG = uiLink:Get("imgOptionBG"):GetComponent("Image");
    self.imgStar1 = uiLink:Get("imgStar1"):GetComponent("Image");
    self.imgStar2 = uiLink:Get("imgStar2"):GetComponent("Image");
    self.imgStar3 = uiLink:Get("imgStar3"):GetComponent("Image");
    self.imgStar4 = uiLink:Get("imgStar4"):GetComponent("Image");
    self.imgStar5 = uiLink:Get("imgStar5"):GetComponent("Image");
    self.textOptionName = uiLink:Get("textOptionName"):GetComponent("Text");
    self.textSpecialOptionName = uiLink:Get("textSpecialOptionName"):GetComponent("Text");
    self.textSchedule = uiLink:Get("textSchedule"):GetComponent("Text");
    self.goScheduleNormal = uiLink:Get("goScheduleNormal");
    self.goimgStar01 = uiLink:Get("goimgStar01");
    self.goimgStar02 = uiLink:Get("goimgStar02");
    self.goimgStar03 = uiLink:Get("goimgStar03");
    self.goimgStar04 = uiLink:Get("goimgStar04");
    self.goimgStar05 = uiLink:Get("goimgStar05");
    self.goScheduleSpecial = uiLink:Get("goScheduleSpecial");
    self.rectScheduleTop = uiLink:Get("rectScheduleTop"):GetComponent("RectTransform");
    self.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    self.redPoint=self.imgOptionBG.gameObject:GetComponent("RedIconListener");
    self.data = nil;
    self.animator=self.gameObject:GetComponent("Animator");
    uiLink:AddClickEvent("btnClick", function()
        if self.data ~= nil then
            if self.data.questType == 4 then
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStorySpecialListViewModel,self.data);
            else
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStoryViewModel,self.data)
            end
        end
    end)
    return self
end

function UICollectorStoryOptionItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.transform = nil
    self.imgOptionBG = nil;
    self.imgStar1 = nil;
    self.imgStar2 = nil;
    self.imgStar3 = nil;
    self.imgStar4 = nil;
    self.imgStar5 = nil;
    self.textOptionName = nil;
    self.textSpecialOptionName = nil;
    self.textSchedule = nil;
    self.goScheduleNormal = nil;
    self.goimgStar01 = nil;
    self.goimgStar02 = nil;
    self.goimgStar03 = nil;
    self.goimgStar04 = nil;
    self.goimgStar05 = nil;
    self.goScheduleSpecial = nil;
    self.rectScheduleTop = nil;
    self.btnClick = nil;
    self.redPoint=nil;
    self.data=nil;
end

function UICollectorStoryOptionItem:ShowAnimation()
    SetActive(self.gameObject,true);
    self.animator.enabled = true;
    self.animator:Play("UI_UICollectorStoryOptionItem_01",0,0);
end

function UICollectorStoryOptionItem:Hide()
    SetActive(self.gameObject, false);
end















function UICollectorStoryOptionItem:SetData(data,mapId)
    SetActive(self.gameObject,true);
    self.data = data;
    self.redPoint.RedId="1215_"..tostring(mapId).."#"..self.data.questType;
if data.questType == 4 then
        self.redPoint.redLocOffSet=Vector2(-76.2,-100.7)
        self.redPoint:GetComponent("RectTransform"):Find("RedIconItem(Clone)"):GetComponent("RectTransform").anchoredPosition=Vector2(-76.2,-100.7);

        SetActive(self.textOptionName.gameObject, false);
        SetActive(self.textSpecialOptionName.gameObject, true);
        SetActive(self.goScheduleNormal, false);
        SetActive(self.goScheduleSpecial, true);
        self.imgOptionBG.sprite = LuaMgr.GetSprite("CollectorStory", "ui_sx_jq_0" .. tostring(data.questType))
        self.textSpecialOptionName.text = ConfigMgr.LangGlobal("7105");
        self.textSchedule.text = tostring(data.completeNum) .. "/" .. tostring(#data.questList);
        self.rectScheduleTop.localScale = Vector3((data.completeNum / #data.questList), 1.0, 1.0)
    else
        SetActive(self.textOptionName.gameObject, true);
        SetActive(self.textSpecialOptionName.gameObject, false);
        SetActive(self.goScheduleNormal, true);
        SetActive(self.goScheduleSpecial, false);
        self.imgOptionBG.sprite = LuaMgr.GetSprite("CollectorStory", "ui_sx_jq_0" .. tostring(data.questType))
        self.textOptionName.text = LuaMgr.GetLangText(ConfigMgr.Config.characterTable[string.sub(data.characterID,1,5)].namelan);
        local temp = {};
        table.insert(temp, self.imgStar1);
        table.insert(temp, self.imgStar2);
        table.insert(temp, self.imgStar3);
        table.insert(temp, self.imgStar4);
        table.insert(temp, self.imgStar5);
        local temp2 = {};
        table.insert(temp2, self.goimgStar01);
        table.insert(temp2, self.goimgStar02);
        table.insert(temp2, self.goimgStar03);
        table.insert(temp2, self.goimgStar04);
        table.insert(temp2, self.goimgStar05);
        local needShow={}
        for i = 1, 5, 1 do
            if i <= data.completeNum then
                temp[i].sprite = LuaMgr.GetSprite("CollectorStory", "ui_sx_jq_jdd_02")
                table.insert(needShow,temp2[i]);
            else
                temp[i].sprite = LuaMgr.GetSprite("CollectorStory", "ui_sx_jq_jdd_01")
            end
            SetActive(temp2[i],false);
        end
        for key, value in pairs(needShow) do
            SetActive(value,true);
        end
    end
end