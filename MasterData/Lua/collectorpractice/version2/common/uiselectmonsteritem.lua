
UISelectMonsterItem = {}
UISelectMonsterItem.__index = UISelectMonsterItem

require("CollectorPractice/Version2/Common/UISelectMonsterLevelItem")
require("CollectorPractice/Version2/Common/UISelectMonsterGoodItem")
require("CollectorPractice/Version2/Common/UICollectorSelectCharacterItem")
function UISelectMonsterItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UISelectMonsterItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goAddBG = uiLink:Get("goAddBG");
    self.goStep1 = uiLink:Get("goStep1");
    self.UISelectMonsterGoodItem = uiLink:Get("UISelectMonsterGoodItem");
    self.UICollectorSelectCharacterItem = uiLink:Get("UICollectorSelectCharacterItem");
    self.UISelectMonsterLevelItem = uiLink:Get("UISelectMonsterLevelItem");
    self.goStep2 = uiLink:Get("goStep2");
    self.goIsSelected1 = uiLink:Get("goIsSelected1");
    self.goIsSelected2 = uiLink:Get("goIsSelected2");
    self.goIsSelected3 = uiLink:Get("goIsSelected3");
    self.goIsSelected4 = uiLink:Get("goIsSelected4");
    self.goIsSelected5 = uiLink:Get("goIsSelected5");
    self.goIsSelected6 = uiLink:Get("goIsSelected6");
    self.goIsSelected7 = uiLink:Get("goIsSelected7");
    self.rawImageMonsterStep1 = uiLink:Get("rawImageMonsterStep1"):GetComponent("RawImage");
    self.rawImageMonster = uiLink:Get("rawImageMonster"):GetComponent("RawImage");
    self.textLevel = uiLink:Get("textLevel"):GetComponent("Text");
    self.textReward = uiLink:Get("textReward"):GetComponent("Text");
    self.textMonsterNameStep1 = uiLink:Get("textMonsterNameStep1"):GetComponent("Text");
    self.textDominantStep1 = uiLink:Get("textDominantStep1"):GetComponent("Text");
    self.textCharacterLevel = uiLink:Get("textCharacterLevel"):GetComponent("Text");
    self.textBuffIntro = uiLink:Get("textBuffIntro"):GetComponent("Text");
    self.textBuffName = uiLink:Get("textBuffName"):GetComponent("Text");
    self.textAddBuffName1 = uiLink:Get("textAddBuffName1"):GetComponent("Text");
    self.textAddBuffName2 = uiLink:Get("textAddBuffName2"):GetComponent("Text");
    self.textAddBuffName3 = uiLink:Get("textAddBuffName3"):GetComponent("Text");
    self.textMonsterName = uiLink:Get("textMonsterName"):GetComponent("Text");
    self.textDominant = uiLink:Get("textDominant"):GetComponent("Text");
    self.imgJobIconStep1 = uiLink:Get("imgJobIconStep1"):GetComponent("Image");
    self.imgAddBuffIcon1 = uiLink:Get("imgAddBuffIcon1"):GetComponent("Image");
    self.imgAddBuffIcon2 = uiLink:Get("imgAddBuffIcon2"):GetComponent("Image");
    self.imgAddBuffIcon3 = uiLink:Get("imgAddBuffIcon3"):GetComponent("Image");
    self.imgJobIcon = uiLink:Get("imgJobIcon"):GetComponent("Image");
    self.btnMonsterDesc = uiLink:Get("btnMonsterDesc"):GetComponent("Button");
    self.btnStep1Next = uiLink:Get("btnStep1Next"):GetComponent("Button");
    self.btnClickBuffItem1 = uiLink:Get("btnClickBuffItem1"):GetComponent("Button");
    self.btnClickBuffItem2 = uiLink:Get("btnClickBuffItem2"):GetComponent("Button");
    self.btnClickBuffItem3 = uiLink:Get("btnClickBuffItem3"):GetComponent("Button");
    self.btnClickBuffItem4 = uiLink:Get("btnClickBuffItem4"):GetComponent("Button");
    self.btnClickBuffItem5 = uiLink:Get("btnClickBuffItem5"):GetComponent("Button");
    self.btnClickBuffItem6 = uiLink:Get("btnClickBuffItem6"):GetComponent("Button");
    self.btnClickBuffItem7 = uiLink:Get("btnClickBuffItem7"):GetComponent("Button");
    self.btnStep2Next = uiLink:Get("btnStep2Next"):GetComponent("Button");
    self.btnCloseAddBG = uiLink:Get("btnCloseAddBG"):GetComponent("Button");
    self.btnClickSelectMonsetItem = uiLink:Get("btnClickSelectMonsetItem"):GetComponent("Button");
    self.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    self.rectCharacterList = uiLink:Get("rectCharacterList"):GetComponent("RectTransform");
    self.rectSelectLevelListGroup = uiLink:Get("rectSelectLevelListGroup"):GetComponent("RectTransform");
    self.rectGoodsContent = uiLink:Get("rectGoodsContent"):GetComponent("RectTransform");
    self.root=uiLink:Get("root");
    self.animator=uiLink:Get("root"):GetComponent("Animator");;

    self.mapIdList = {};
    self.funList = {};
    self.nowSelectBuff = 1;
    self.levelItemList = {};
    self.goodItemList = {};
    self.startCharacterList = {};
    self.buffSelectedList = {};
    table.insert(self.buffSelectedList, self.goIsSelected1);
    table.insert(self.buffSelectedList, self.goIsSelected2);
    table.insert(self.buffSelectedList, self.goIsSelected3);
    table.insert(self.buffSelectedList, self.goIsSelected4);
    table.insert(self.buffSelectedList, self.goIsSelected5);
    table.insert(self.buffSelectedList, self.goIsSelected6);
    table.insert(self.buffSelectedList, self.goIsSelected7);
    self.addBuffNameList = {};
    table.insert(self.addBuffNameList, self.textAddBuffName1);
    table.insert(self.addBuffNameList, self.textAddBuffName2);
    table.insert(self.addBuffNameList, self.textAddBuffName3);
    self.addBuffImageIconList = {};
    table.insert(self.addBuffImageIconList, self.imgAddBuffIcon1);
    table.insert(self.addBuffImageIconList, self.imgAddBuffIcon2);
    table.insert(self.addBuffImageIconList, self.imgAddBuffIcon3);
    self.characterItemList = {};
    self.buffList = {};
    self.nowStep = 1;
    self.nowSelectLevelIndex = 1;
    self.index = 1;

    uiLink:AddClickEvent("btnMonsterDesc", function()
        if self.funList.isDotweenMove() then
            return;
        end
        self.funList.saveSerializeData();
        local configData = ConfigMgr.Config.YX2Maps[self.levelItemList[self.nowSelectLevelIndex].mapId].MonsterID;
        LuaMgr.ShowLuaPanel("BattlePrepareEnemyViewModel", nil, configData)
    end)
    uiLink:AddClickEvent("btnStep1Next", function()
        local configData = ConfigMgr.Config.YX2Maps[self.levelItemList[self.nowSelectLevelIndex].mapId].CharacterNumber;
        if #self.startCharacterList > configData or #self.startCharacterList<=0 then
            return;
        end
        self:SwitchStep(3, false);
    end)
    uiLink:AddClickEvent("btnClickBuffItem1", function()
        self:BuffClickFun(1);
    end)
    uiLink:AddClickEvent("btnClickBuffItem2", function()
        self:BuffClickFun(2);
    end)
    uiLink:AddClickEvent("btnClickBuffItem3", function()
        self:BuffClickFun(3);
    end)
    uiLink:AddClickEvent("btnClickBuffItem4", function()
        self:BuffClickFun(4);
    end)
    uiLink:AddClickEvent("btnClickBuffItem5", function()
        self:BuffClickFun(5);
    end)
    uiLink:AddClickEvent("btnClickBuffItem6", function()
        self:BuffClickFun(6);
    end)
    uiLink:AddClickEvent("btnClickBuffItem7", function()
        self:BuffClickFun(7);
    end)
    uiLink:AddClickEvent("btnStep2Next", function()
        local MembersTemp={};
        for index, value in ipairs(self.startCharacterList) do
            local temp={};
            temp.ID=value;
            temp.State=0;
            table.insert(MembersTemp,temp);
        end
        local data = { 
            MapId = self.levelItemList[self.nowSelectLevelIndex].mapId, 
            BuffTyp = self.nowSelectBuffType;
            Members=MembersTemp;
        }
        local Url = "practice2/choose_map"
        ApiMgr.Request(Url, data, true,
        function(result)
            CollectorPracticeMgrVersion2.IsFirstOpenPanel=true;
            CollectorPracticeAllMgr.InitCurrentMapData();
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeMainSceneVersion2ViewModel)
        end,nil,
        true
        )
    end)
    uiLink:AddClickEvent("btnCloseAddBG", function()
        if self.funList.isDotweenMove() then
            return;
        end
        self.funList.clickBackMonsterItem(self)
        self:SwitchStep(1, false);
    end)
    uiLink:AddClickEvent("btnClickSelectMonsetItem", function()
        self.funList.clickMonsterItem(self);
        self:SwitchStep(2, false);
    end)
    uiLink:AddClickEvent("btnClickAddBuff1", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeShowBuffDataVersion2ViewModel, self.buffList[1].Id)
    end)
    uiLink:AddClickEvent("btnClickAddBuff2", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeShowBuffDataVersion2ViewModel, self.buffList[2].Id)
    end)
    uiLink:AddClickEvent("btnClickAddBuff3", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeShowBuffDataVersion2ViewModel, self.buffList[3].Id)
    end)
    return self
end

function UISelectMonsterItem:Destroy()
    for index, value in ipairs(self.levelItemList) do
        value:Destroy();
    end
    for index, value in ipairs(self.goodItemList) do
        value:Destroy();
    end
    for index, value in ipairs(self.characterItemList) do
        value:Destroy();
    end
    self.gameObject = nil
    self.transform = nil
    self.goAddBG = nil;
    self.goStep1 = nil;
    self.UISelectMonsterGoodItem = nil;
    self.UICollectorSelectCharacterItem = nil;
    self.UISelectMonsterLevelItem = nil;
    self.goStep2 = nil;
    self.goIsSelected1 = nil;
    self.goIsSelected2 = nil;
    self.goIsSelected3 = nil;
    self.goIsSelected4 = nil;
    self.goIsSelected5 = nil;
    self.goIsSelected6 = nil;
    self.goIsSelected7 = nil;
    self.rawImageMonsterStep1 = nil;
    self.rawImageMonster = nil;
    self.textLevel = nil;
    self.textReward = nil;
    self.textMonsterNameStep1 = nil;
    self.textDominantStep1 = nil;
    self.textCharacterLevel = nil;
    self.textBuffIntro = nil;
    self.textBuffName = nil;
    self.textAddBuffName1 = nil;
    self.textAddBuffName2 = nil;
    self.textAddBuffName3 = nil;
    self.textMonsterName = nil;
    self.textDominant = nil;
    self.imgJobIconStep1 = nil;
    self.imgAddBuffIcon1 = nil;
    self.imgAddBuffIcon2 = nil;
    self.imgAddBuffIcon3 = nil;
    self.imgJobIcon = nil;
    self.btnMonsterDesc = nil;
    self.btnStep1Next = nil;
    self.btnClickBuffItem1 = nil;
    self.btnClickBuffItem2 = nil;
    self.btnClickBuffItem3 = nil;
    self.btnClickBuffItem4 = nil;
    self.btnClickBuffItem5 = nil;
    self.btnClickBuffItem6 = nil;
    self.btnClickBuffItem7 = nil;
    self.btnStep2Next = nil;
    self.btnCloseAddBG = nil;
    self.btnClickSelectMonsetItem = nil;
    self.ScrollView = nil;
    self.rectCharacterList = nil;
    self.rectSelectLevelListGroup = nil;
    self.rectGoodsContent = nil;

    self.mapIdList = nil;
    self.nowSelectBuff = nil;
    self.funList = nil;
    self.levelItemList = nil;
    self.goodItemList = nil;
    self.characterItemList = nil;
    self.startCharacterList = nil;
    self.nowStep = nil;
    self.nowSelectLevelIndex = nil;
    self.buffSelectedList = nil;
    self.addBuffNameList = nil;
    self.addBuffImageIconList = nil;
    self.buffList = nil;
    self.animator=nil;
    self.index = nil;
    self.root=nil;
end

function UISelectMonsterItem:GetSaveData()
    local data={};
    data.nowSelectBuffType=self.nowSelectBuffType;
    data.nowStep=self.nowStep;
    data.nowSelectLevelIndex=self.nowSelectLevelIndex;
    data.transformPos=self.transform.anchoredPosition;
    return data;
end

function UISelectMonsterItem:SetData(index, mapIdList, funList)
    SetActive(self.gameObject, true);
    self.index = index;
    self.mapIdList = mapIdList;
    self.funList = funList;
    self:SwitchStep(self.nowStep, true);
    self:PrivateInitPanel(mapIdList);
end

function UISelectMonsterItem:SetClickMonsterButton(isActive)
    SetActive(self.btnClickSelectMonsetItem.gameObject, isActive);
end

function UISelectMonsterItem:SwitchStep(nextStep, isSetData)
    if nextStep == 1 then
        SetActive(self.goStep1, false);
        SetActive(self.goStep2, false);
        SetActive(self.goAddBG, false);
        self.nowStep=nextStep;
        if not isSetData then
            self.funList.nextStep1Fun(self);
        end
    elseif nextStep == 2 then
        SetActive(self.goStep1, true);
        SetActive(self.goStep2, false);
        SetActive(self.goAddBG, true);
        self.nowStep=nextStep;

        if not isSetData then
            self:PublicInitFirstReward(self.levelItemList[self.nowSelectLevelIndex].mapId)
            self.funList.nextStep2Fun(self);
        end
    elseif nextStep == 3 then
        SetActive(self.goStep1, false);
        SetActive(self.goStep2, true);
        SetActive(self.goAddBG, true);
        self.nowStep=nextStep;
        if not isSetData then
            self.funList.nextStep3Fun(self);
        end
    end
end

function UISelectMonsterItem:InitSaveData()
    self.startCharacterList = {};
    self.nowSelectBuffType = 1;
    self.nowStep = 1;
    self.nowSelectLevelIndex = 1;
end

function UISelectMonsterItem:LoadSaveData(data)
    self.nowSelectBuffType = data.nowSelectBuffType;
    self.nowStep = data.nowStep;
    self.nowSelectLevelIndex = data.nowSelectLevelIndex;
    self.transform.anchoredPosition=data.transformPos;
end

function UISelectMonsterItem:PrivateInitPanel(mapIdList)
    self:PrivateInitOutPanel(mapIdList);
    self:PrivateInitStep1Panel(mapIdList);
    self:PrivateInitStep2Panel(mapIdList)
end

function UISelectMonsterItem:PrivateInitOutPanel(mapIdList)
    local configData = ConfigMgr.Config.YX2Maps[mapIdList[1]];
    self.rawImageMonster.texture = LuaMgr.GetTexture(string.format("Images/CollectorPracticeMonster/%s.png",
        configData.MonsterID[1]));
    self.textMonsterName.text = LuaMgr.GetLangText(configData.BossNameLan);
    if configData.Job[1] == "1" then
        self.imgJobIcon.sprite = LuaMgr.GetSprite("JobIcon", "job_3")
        self.textDominant.text = ConfigMgr.LangGlobal("7167");
    elseif configData.Job[1] == "2" then
        self.imgJobIcon.sprite = LuaMgr.GetSprite("JobIcon", "job_2")
        self.textDominant.text = ConfigMgr.LangGlobal("7168");
    elseif configData.Job[1] == "3" then
        self.imgJobIcon.sprite = LuaMgr.GetSprite("JobIcon", "job_4")
        self.textDominant.text = ConfigMgr.LangGlobal("7169");
    end
end

function UISelectMonsterItem:PrivateInitStep1Panel(mapIdList)

    local configData = ConfigMgr.Config.YX2Maps[mapIdList[1]];
    self.rawImageMonsterStep1.texture = LuaMgr.GetTexture(string.format("Images/CollectorPracticeMonster/%s.png",
        configData.MonsterID[1]));
    self.textMonsterNameStep1.text = LuaMgr.GetLangText(configData.BossNameLan);
    if configData.Job[1] == "1" then
        self.imgJobIconStep1.sprite = LuaMgr.GetSprite("JobIcon", "job_3")
        self.textDominantStep1.text = ConfigMgr.LangGlobal("7167");
    elseif configData.Job[1] == "2" then
        self.imgJobIconStep1.sprite = LuaMgr.GetSprite("JobIcon", "job_2")
        self.textDominantStep1.text = ConfigMgr.LangGlobal("7168");
    elseif configData.Job[1] == "3" then
        self.imgJobIconStep1.sprite = LuaMgr.GetSprite("JobIcon", "job_4")
        self.textDominantStep1.text = ConfigMgr.LangGlobal("7169");
    end



    self:PrivateInitStep1LevelItem(mapIdList);
    self:PrivateInitChatacter(mapIdList[1]);
    self:ChildrenLevelClickFun(self.levelItemList[self.nowSelectLevelIndex]);
end

function UISelectMonsterItem:PrivateInitStep1LevelItem(mapIdList)

    for i = 1, #mapIdList, 1 do
        local configData = ConfigMgr.Config.YX2Maps[mapIdList[i]];
        if i > #self.levelItemList then
            local temp = UISelectMonsterLevelItem.New(self.UISelectMonsterLevelItem, self.rectSelectLevelListGroup);
            table.insert(self.levelItemList, temp);
        end
        self.levelItemList[i]:SetData(mapIdList[i],i, LuaMgr.GetLangText(configData.BossDesLan), self
        .ChildrenLevelClickFun, self);
    end
    for i = #mapIdList + 1, #self.levelItemList, 1 do
        self.levelItemList[i]:Hide();
    end
end

function UISelectMonsterItem:PrivateInitStep2Panel(mapIdList)
    self:BuffClickFun(self.nowSelectBuffType);
end

function UISelectMonsterItem:StringHelperFun(str)
    local tb=StringToTable(str);
    local needAdd=false;
    local result="";
    for index, value in ipairs(tb) do
        if value=="[" then
            needAdd=true;
        elseif value=="]" then
            break;
        elseif needAdd then
            result=result..value;
        end
    end
    return result;
end

function UISelectMonsterItem:ChildrenLevelClickFun(children)
    local configData = ConfigMgr.Config.YX2Maps[children.mapId];
    self.nowSelectLevelIndex=children.index;
    local langText = LuaMgr.GetLangText(configData.BossDesLan);
    if string.find(langText, "%[") ~= nil then
        self.textLevel.text = self:StringHelperFun(langText);
    else
        self.textLevel.text = langText
    end
    self.textCharacterLevel.text = tostring(configData.LevelShow);

    self:PublicInitFirstReward(children.mapId)
    for key, value in pairs(self.levelItemList) do
        value:SetSelectState(false);
    end
    children:SetSelectState(true);
    if children.index == 1 then
        self.textReward.text = ConfigMgr.LangGlobal("7171");
    elseif children.index == 2 then
        self.textReward.text = ConfigMgr.LangGlobal("7172");
    elseif children.index == 3 then
        self.textReward.text = ConfigMgr.LangGlobal("7173");
    end
end

function UISelectMonsterItem:ChildrenCharacterClickFun(children)
    if self.funList.isDotweenMove() then
        return;
    end

    self.funList.saveSerializeData();
    local extendParams={};
    extendParams.thisObject=self;
    local characterNumber = ConfigMgr.Config.YX2Maps[self.levelItemList[self.nowSelectLevelIndex].mapId].CharacterNumber;
    HeroParameter.InitCommonOpenSelectQuickCharacter(self.startCharacterList,characterNumber,false,nil,extendParams,self.ChildrenCharacterCallBack,{},nil);
    FeatureManager.GotoPanel("1004");
end


function UISelectMonsterItem.ChildrenCharacterCallBack(extendParams,battleMembers)
local thisObject=extendParams.thisObject;
    thisObject.startCharacterList=battleMembers;
end

function UISelectMonsterItem:BuffClickFun(buffType)
    for index, value in ipairs(self.buffSelectedList) do
        SetActive(value, false);
    end
    if buffType == 1 then
        SetActive(self.buffSelectedList[1], true);
        self.nowSelectBuffType = 1;
        self.textBuffName.text = ConfigMgr.LangGlobal("7183");
        self.textBuffIntro.text = string.gsub(string.format(ConfigMgr.LangGlobal("7180"), ConfigMgr.LangGlobal("7183")),
            "\\n", "\n");
    elseif buffType == 2 then
        SetActive(self.buffSelectedList[2], true);
        self.nowSelectBuffType = 2;
        self.textBuffName.text = ConfigMgr.LangGlobal("7184");
        self.textBuffIntro.text = string.gsub(string.format(ConfigMgr.LangGlobal("7180"), ConfigMgr.LangGlobal("7184")),
            "\\n", "\n");
    elseif buffType == 3 then
        SetActive(self.buffSelectedList[3], true);
        self.nowSelectBuffType = 3;
        self.textBuffName.text = ConfigMgr.LangGlobal("7185");
        self.textBuffIntro.text = string.gsub(string.format(ConfigMgr.LangGlobal("7180"), ConfigMgr.LangGlobal("7185")),
            "\\n", "\n");
    elseif buffType == 4 then
        SetActive(self.buffSelectedList[4], true);
        self.nowSelectBuffType = 4;
        self.textBuffName.text = ConfigMgr.LangGlobal("7186");
        self.textBuffIntro.text = string.gsub(string.format(ConfigMgr.LangGlobal("7180"), ConfigMgr.LangGlobal("7186")),
            "\\n", "\n");
    elseif buffType == 5 then
        SetActive(self.buffSelectedList[5], true);
        self.nowSelectBuffType = 5;
        self.textBuffName.text = ConfigMgr.LangGlobal("7187");
        self.textBuffIntro.text = string.gsub(string.format(ConfigMgr.LangGlobal("7180"), ConfigMgr.LangGlobal("7187")),
            "\\n", "\n");
    elseif buffType == 6 then
        SetActive(self.buffSelectedList[6], true);
        self.nowSelectBuffType = 6;
        self.textBuffName.text = ConfigMgr.LangGlobal("7188");
        self.textBuffIntro.text = string.gsub(string.format(ConfigMgr.LangGlobal("7180"), ConfigMgr.LangGlobal("7188")),
            "\\n", "\n");
    elseif buffType == 7 then
        SetActive(self.buffSelectedList[7], true);
        self.nowSelectBuffType = 7;
        self.textBuffName.text = ConfigMgr.LangGlobal("7189");
        self.textBuffIntro.text = string.gsub(string.format(ConfigMgr.LangGlobal("7180"), ConfigMgr.LangGlobal("7189")),
            "\\n", "\n");
    end
    self:BuffClickFunInitAddBuff(buffType)
end

function UISelectMonsterItem:BuffClickFunInitAddBuff(buffType)
    self.buffList = CollectorPracticeMgrVersion2.ReawrdTypeBuffMap[buffType];
    local config = ConfigMgr.Config.YX2Buffs;
    for i = 1, 3, 1 do
        self.addBuffNameList[i].text = LuaMgr.GetLangText(self.buffList[i].BuffNameLan);

        self.addBuffImageIconList[i].sprite = LuaMgr.GetSprite("BuffIcon", self.buffList[i].BuffIcon)
    end
end

function UISelectMonsterItem:PublicInitFirstReward(mapId)
    local configData = ConfigMgr.Config.YX2Maps[mapId].FinishReward;
    local finishMap = {};
    if not IsNull(DataMgr.Player.practiceStage2.passBoss) then
        for index, value in ipairs(DataMgr.Player.practiceStage2.passBoss) do
            finishMap[value] = true;
        end
    end
    for i = 1, #configData, 1 do
        if i > #self.goodItemList then
            local temp = UISelectMonsterGoodItem.New(self.UISelectMonsterGoodItem, self.rectGoodsContent);
            table.insert(self.goodItemList, temp);
        end
    end
for i = 1, #configData, 1 do
        self.goodItemList[i]:SetData(configData[i].id, configData[i].count, finishMap[mapId] ~= nil and true or false);
    end
    for i = #configData + 1, #self.goodItemList, 1 do
        self.goodItemList[i]:Hide();
    end
end

function UISelectMonsterItem:PrivateInitChatacter(mapId)
    local configData = ConfigMgr.Config.YX2Maps[mapId].CharacterNumber;
    for i = 1, configData, 1 do
        if i > #self.characterItemList then
            local temp = UICollectorSelectCharacterItem.New(self.UICollectorSelectCharacterItem, self.rectCharacterList);
            table.insert(self.characterItemList, temp);
        end
        self.characterItemList[i]:SetData(self.ChildrenCharacterClickFun, self);
        if self.startCharacterList[i] ~= nil then
            self.characterItemList[i]:SetCharacter(self.startCharacterList[i]);
        else
            self.characterItemList[i]:SetCharacter("");
        end
    end
    for i = configData + 1, #self.characterItemList, 1 do
        self.characterItemList[i]:Hide();
    end
end

function UISelectMonsterItem:Hide()
    SetActive(self.gameObject, false);
end
function UISelectMonsterItem:ReadyToShowFirstAnimation()
	self.animator.enabled = false;
	self.root:GetComponent("RectTransform"):Find("BG"):GetComponent("CanvasGroup").alpha = 0.0;
end

function UISelectMonsterItem:PlayFirstAnimation()
    self.animator.enabled = true;
    self.animator:Play("ani_UISelectMonsterIntem_enter",0,0);
end