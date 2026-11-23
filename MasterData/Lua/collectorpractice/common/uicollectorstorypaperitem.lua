

UICollectorStoryPaperItem = {}
UICollectorStoryPaperItem.__index = UICollectorStoryPaperItem
local PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/UICollectorStoryPaperItem.prefab";
function UICollectorStoryPaperItem.New(parent)
    local self = {}
    setmetatable(self, UICollectorStoryPaperItem)
    self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent, false);
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goUnLock = uiLink:Get("goUnLock");
    self.goLock = uiLink:Get("goLock");
    self.imgPaperBG = uiLink:Get("imgPaperBG"):GetComponent("Image");
    self.textTitlePaper = uiLink:Get("textTitlePaper"):GetComponent("Text");
    self.textIntroducePaper = uiLink:Get("textIntroducePaper"):GetComponent("Text");
    self.textLockText1 = uiLink:Get("textLockText1"):GetComponent("Text");
    self.textLockText2 = uiLink:Get("textLockText2"):GetComponent("Text");
    self.textLockText3 = uiLink:Get("textLockText3"):GetComponent("Text");
    self.textLockText4 = uiLink:Get("textLockText4"):GetComponent("Text");
    self.goRedPoint=uiLink:Get("goRedPoint")
    self.uiGoodsItem = uiLink:Get("uiGoodsItem"):GetComponent("GoodsViewModel");
    self.data = nil;
    self.BGType = nil;
    self.isGroup=nil;
    self.groupIndex=nil;
    self.callback=nil;
    self.index=nil;
    self.questType=nil;
    uiLink:AddClickEvent("btnClick", function()
        if self.data ~= nil then
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStoryIntroduceViewModel, self.data);
        end
    end)
    uiLink:AddClickEvent("btnGetReward", function()
        if (not self.data.complete) and DataMgr.Player.storyQuest[self.data.questID] == false then
            local sendData = { QuestID = self.data.questID }
            local Url = "practice/story_reward"
            ApiMgr.Request(Url, sendData, true,
                function(result)
                    local resultData = json.decode(result)
                    SetActive(self.goLock, false);
                    SetActive(self.goUnLock, true);
                    self.imgPaperBG.sprite = LuaMgr.GetSprite("CollectorStory", "ui_sx_jq_bq_0" .. tostring(self.BGType));

                    local textIntroduceString = LuaMgr.GetLangText(ConfigMgr.Config.EventStoryMap
                    [self.data.storyShow[1]].EventDesLan);
                    local temp = CNSub(textIntroduceString, 1, 160);
                    local leastChar = string.sub(temp, -1, -1)
                    local finallyString = "";
                    if leastChar == LuaMgr.GetLangText("UICollectorStoryPaperItem_0") or leastChar == "," or leastChar == "." or leastChar == LuaMgr.GetLangText("UICollectorStoryPaperItem_1") then
                        finallyString = string.sub(temp, 1, -2);
                        finallyString = finallyString .. "......";
                    else
                        finallyString = temp .. "......";
                    end

                    self.textIntroducePaper.text = finallyString;
                    self.textTitlePaper.text = LuaMgr.GetLangText(ConfigMgr.Config.EventStoryMap[self.data.storyShow[1]]
                    .EventTitleLan);

                    if self.isGroup then
                        self.callback(self.index,self.groupIndex)
                    else
                        CollectorPracticeMgr.RefushStoryData("MapA");
                    end
                    if not IsNull(resultData.result.Items) then
                        local items = {};
                        local reward = resultData.result.Items
                        for i, v in pairs(reward) do
                            local item = { ID = v.id, Count = v.count }
                            table.insert(items, item);
                        end

                        LuaMgr.ShowItemGetPanel(items);
                    end
                end,
                function(failCode)
                    print("EnterDungeonError,ErrorCode:", failCode)
                end,
                true
            )
        end
    end)
    return self
end

function UICollectorStoryPaperItem:Destroy()
    LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
    self.transform = nil
    self.goUnLock = nil;
    self.goLock = nil;
    self.imgPaperBG = nil;
    self.textTitlePaper = nil;
    self.textIntroducePaper = nil;
    self.textLockText1 = nil;
    self.textLockText2 = nil;
    self.textLockText3 = nil;
    self.textLockText4 = nil;
    self.btnClick = nil;
    self.uiGoodsItem = nil;
end

function UICollectorStoryPaperItem:Hide()
    SetActive(self.gameObject, false);
end

function UICollectorStoryPaperItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end












function UICollectorStoryPaperItem:SetData(data, BGType,questType,isGroup,index,groupIndex,callback)
    self.data = data;
    self.BGType = BGType;
    self.isGroup=isGroup;
    self.index=index;
    self.groupIndex=groupIndex;
    self.callback=callback;
    self.questType=questType;
    if data.complete then
        SetActive(self.goLock, false);
        SetActive(self.goUnLock, true);
        self.imgPaperBG.sprite = LuaMgr.GetSprite("CollectorStory", "ui_sx_jq_bq_0" .. tostring(BGType));

        local textIntroduceString = LuaMgr.GetLangText(ConfigMgr.Config.EventStoryMap[data.storyShow[1]].EventDesLan);
        local temp = CNSub(textIntroduceString, 1, 160);
        local leastChar = string.sub(temp, -1, -1)
        local finallyString = "";
        if leastChar == LuaMgr.GetLangText("UICollectorStoryPaperItem_2") or leastChar == "," or leastChar == "." or leastChar == LuaMgr.GetLangText("UICollectorStoryPaperItem_3") then
            finallyString = string.sub(temp, 1, -2);
            finallyString = finallyString .. "......";
        else
            finallyString = temp .. "......";
        end

        self.textIntroducePaper.text = finallyString;
        self.textTitlePaper.text = LuaMgr.GetLangText(ConfigMgr.Config.EventStoryMap[data.storyShow[1]].EventTitleLan);
    else
        SetActive(self.goLock, true);
        SetActive(self.goUnLock, false);
        local textTemp = ConfigMgr.LangGlobal("7108");
self.textLockText1.text = string.sub(textTemp, 1, 3);
        self.textLockText2.text = string.sub(textTemp, 4, 6);
        self.textLockText3.text = string.sub(textTemp, 7, 9);
        self.textLockText4.text = string.sub(textTemp, 10, 12);
        self.uiGoodsItem:SetData(tostring(data.reward[1].id), tonumber(data.reward[1].count), 1, 0.6, true)
    end

if (not self.data.complete) and DataMgr.Player.storyQuest[self.data.questID] == false then
        SetActive(self.goRedPoint,true);
    else
        SetActive(self.goRedPoint,false);
    end

end

