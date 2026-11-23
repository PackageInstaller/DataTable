




UICollectorTaskItem = {}
UICollectorTaskItem.__index = UICollectorTaskItem
local PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/UICollectorTaskItem.prefab";


function UICollectorTaskItem.New(parent)
    local self = {}
    setmetatable(self, UICollectorTaskItem)
    self.gameObject = LuaMgr.GetPrefab("UI/CollectorPractice/UICollectorTaskItem.prefab")
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localScale = Vector3.one;
    self.transform.localPosition = Vector3.zero;
    self.transform.anchoredPosition = Vector2.zero;
    local uiLink = self.gameObject:GetComponent("UILink");
    self.imgBG = uiLink:Get("imgBG"):GetComponent("Image");
    self.imgStar1 = uiLink:Get("imgStar1"):GetComponent("Image");
    self.imgStar2 = uiLink:Get("imgStar2"):GetComponent("Image");
    self.imgStar3 = uiLink:Get("imgStar3"):GetComponent("Image");
    self.imgStar4 = uiLink:Get("imgStar4"):GetComponent("Image");
    self.imgStar5 = uiLink:Get("imgStar5"):GetComponent("Image");
    self.textOptionName = uiLink:Get("textOptionName"):GetComponent("Text");
    self.textSchedule = uiLink:Get("textSchedule"):GetComponent("Text");
    self.textSpecialOptionName = uiLink:Get("textSpecialOptionName"):GetComponent("Text");
    self.goScheduleNormal = uiLink:Get("goScheduleNormal");
    self.goScheduleSpecial = uiLink:Get("goScheduleSpecial");
    self.rectScheduleTop = uiLink:Get("rectScheduleTop"):GetComponent("RectTransform");
    self.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    self.redPointListener=self.gameObject:GetComponent("RedIconListener")
    self.data = nil;
    uiLink:AddClickEvent("btnClick", function()
        if self.data ~= nil then
            if self.data.questType == 4 then
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStorySpecialListViewModel, self.data);
            else
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStoryViewModel, self.data)
            end
        end
    end)
    return self
end

function UICollectorTaskItem:Destroy()
    LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
    self.transform = nil
    self.imgBG = nil;
    self.imgStar1 = nil;
    self.imgStar2 = nil;
    self.imgStar3 = nil;
    self.imgStar4 = nil;
    self.imgStar5 = nil;
    self.textOptionName = nil;
    self.textSchedule = nil;
    self.textSpecialOptionName = nil;
    self.goScheduleNormal = nil;
    self.goScheduleSpecial = nil;
    self.rectScheduleTop = nil;
    self.btnClick = nil;
end

function UICollectorTaskItem:SetData(data,mapType)
    self.data = data;
    self.redPointListener.RedId="1217_"..tostring(mapType).."#"..self.data.questType;
if data.questType == 4 then
        SetActive(self.textOptionName.gameObject, false);
        SetActive(self.textSpecialOptionName.gameObject, true);
        SetActive(self.goScheduleNormal, false);
        SetActive(self.goScheduleSpecial, true);
        self.imgBG.sprite = LuaMgr.GetSprite("CollectorStoryTask", "ui_sx_dt_jq" .. tostring(data.questType))
        self.textSpecialOptionName.text = ConfigMgr.LangGlobal("7105");
        self.textSchedule.text = tostring(data.completeNum) .. "/" .. tostring(#data.questList);
        self.rectScheduleTop.localScale = Vector3((data.completeNum / #data.questList), 1.0, 1.0)
    else
        SetActive(self.textOptionName.gameObject, true);
        SetActive(self.textSpecialOptionName.gameObject, false);
        SetActive(self.goScheduleNormal, true);
        SetActive(self.goScheduleSpecial, false);
        self.imgBG.sprite = LuaMgr.GetSprite("CollectorStoryTask", "ui_sx_dt_jq" .. tostring(data.questType))
        self.textOptionName.text = LuaMgr.GetLangText(ConfigMgr.Config.characterTable[string.sub(data.characterID, 1, 5)]
        .namelan);
        local temp = {};
        table.insert(temp, self.imgStar1);
        table.insert(temp, self.imgStar2);
        table.insert(temp, self.imgStar3);
        table.insert(temp, self.imgStar4);
        table.insert(temp, self.imgStar5);
        for i = 1, 5, 1 do
            if i <= data.completeNum then
                temp[i].sprite = LuaMgr.GetSprite("CollectorStoryTask", "ui_sx_jq_jdd_02")
            else
                temp[i].sprite = LuaMgr.GetSprite("CollectorStoryTask", "ui_sx_jq_jdd_01")
            end
        end
    end
end
function UICollectorTaskItem:Hide()
    SetActive(self.gameObject, false)
end






































































