



local this = {
grids = {},
row = 4,
col = 4,
    canCreateNumberGrid = {},
    pointerDownPos = nil,
    pointerUpPos = nil,
    isNeedCreateNumber = false,
    mergeScore = 2,
    numberItems = {},
    co = nil,
    startTime = 0,
    specialModelMap = {
["isAllowRevoke"]=false;
["isAllowChainMerge"]=false;
["isEndWhenMerge"]=false;
["isStartBoard"]=false;
["isSaveArchive"]=false;
["isOnlyTriggerCreateNumber"]=false;
},
specialModelData={
        ["isAllowRevoke"]={
maxStep=0,
        },
        ["isAllowChainMerge"]={},
        ["isEndWhenMerge"]={
endBlockId="",
        },
        ["isStartBoard"]={
            startBoardData="",
createNumberOnStart=0,
        },
["isSaveArchive"]={
        },
        ["isOnlyTriggerCreateNumber"]={};
    },

specialModelGameData={
        ["isAllowRevoke"]={
nowStep=0,
nowRoundLeftStep=0,
RevokeArchive={},
        },
        ["isAllowChainMerge"]=nil,
        ["isEndWhenMerge"]=nil,
        ["isStartBoard"]=nil,
        ["isSaveArchive"]=nil,
        ["isOnlyTriggerCreateNumber"]=nil;
    },
openTypeValueMap={},
    selectType=nil,
    randomRevokeList=nil;
mapToTypeToReward={};
createNumberData={
allWeight=0,
numberAndWeight={},
    };
    nowMaxLevelBlockId=nil;
rankData={};
    debugList3={};
isLegalMove=false;
    reqOPList={};
    reqInitBoard={}
}

require("ViewModel/MiniGames/UI2048Grid")
require("ViewModel/MiniGames/UI2048Number")
require("ViewModel/MiniGames/MiniGame2048GamePlayFrameWorkMgr")
require("Tools/RandomRevokeList");
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local goGrid = nil;
local goStart = nil;
local goSelectType1 = nil;
local goSelectType2 = nil;
local goSelectType3 = nil;
local UIglowstart = nil;
local goStart1 = nil;
local goStart2 = nil;
local goStart3 = nil;
local goGoodsItem1 = nil;
local goGoodsItem2 = nil;
local goGoodsItem3 = nil;
local goHasReward1 = nil;
local goHasReward2 = nil;
local goHasReward3 = nil;
local goResult = nil;
local goDebug = nil;
local imgIconBG1Show1 = nil;
local imgIconBG2Show3 = nil;
local imgIconBG3Show2 = nil;
local imgIconBG4Show3 = nil;
local imgIconBG5Show2 = nil;
local imgIconBG6Show4 = nil;
local imgIconBG7Show3 = nil;
local imgIconBG8Show3 = nil;
local imgLeftTips = nil;
local imgType1 = nil;
local imgType2 = nil;
local imgType3 = nil;
local textMaxScore = nil;
local textScore = nil;
local textType1Name = nil;
local textType2Name = nil;
local textType3Name = nil;
local textReward1 = nil;
local textReward2 = nil;
local textReward3 = nil;
local textResult = nil;
local btnRestart = nil;
local btnExit = nil;
local btnStartAgain = nil;
local btnGm = nil;
local btnGMExit=nil;
local btnGMAddNumber = nil;
local sliderRewardNum = nil;
local inputField1 = nil;
local inputField2 = nil;
local dropDown1 = nil;
local dropDown2 = nil;
local dropDown3 = nil;
local Scrollbar = nil;
local textNowRankNumber=nil;
local eventTrigger = nil;
local rootAin = nil;
local rawImage = nil;
local gridParent = nil;
local goRewardGroup=nil;
local goIsAllowRevokeGroup=nil;
local textRevokeNum=nil;
local rectSpecialGroup=nil;
local btnSwitchType1=nil;
local btnSwitchType2=nil;
local btnSwitchType3=nil;
local UpdateSpecialModePanelHelpFun={
    ["isAllowRevoke"]=function ()
        if this.specialModelGameData["isAllowRevoke"].nowRoundLeftStep==-1 then
            textRevokeNum.text="";
        else
            textRevokeNum.text=tostring(this.specialModelGameData["isAllowRevoke"].nowRoundLeftStep);
        end
    end,
    ["isAllowChainMerge"]=function ()
        
end;
    ["isEndWhenMerge"]=function ()
        
end;
    ["isStartBoard"]=function ()
        
end;
    ["isSaveArchive"]=function ()
        
end;
    ["isOnlyTriggerCreateNumber"]=function ()
        
    end;
}


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    goGrid = uiLink:Get("goGrid");
    eventTrigger = uiLink:Get("goGrid"):GetComponent("OnDragBehaviour");
    goStart = uiLink:Get("goStart");
    goSelectType1 = uiLink:Get("goSelectType1");
    goSelectType2 = uiLink:Get("goSelectType2");
    goSelectType3 = uiLink:Get("goSelectType3");
    UIglowstart = uiLink:Get("UIglowstart");
    goStart1 = uiLink:Get("goStart1");
    goStart2 = uiLink:Get("goStart2");
    goStart3 = uiLink:Get("goStart3");
    goGoodsItem1 = uiLink:Get("goGoodsItem1"):GetComponent("GoodsViewModel");
    goGoodsItem2 = uiLink:Get("goGoodsItem2"):GetComponent("GoodsViewModel");
    goGoodsItem3 = uiLink:Get("goGoodsItem3"):GetComponent("GoodsViewModel");
    goHasReward1 = uiLink:Get("goHasReward1");
    goHasReward2 = uiLink:Get("goHasReward2");
    goHasReward3 = uiLink:Get("goHasReward3");
    goResult = uiLink:Get("goResult");
    goDebug = uiLink:Get("goDebug");
    imgIconBG1Show1 = uiLink:Get("imgIconBG1Show1"):GetComponent("Image");
    imgIconBG2Show3 = uiLink:Get("imgIconBG2Show3"):GetComponent("Image");
    imgIconBG3Show2 = uiLink:Get("imgIconBG3Show2"):GetComponent("Image");
    imgIconBG4Show3 = uiLink:Get("imgIconBG4Show3"):GetComponent("Image");
    imgIconBG5Show2 = uiLink:Get("imgIconBG5Show2"):GetComponent("Image");
    imgIconBG6Show4 = uiLink:Get("imgIconBG6Show4"):GetComponent("Image");
    imgIconBG7Show3 = uiLink:Get("imgIconBG7Show3"):GetComponent("Image");
    imgIconBG8Show3 = uiLink:Get("imgIconBG8Show3"):GetComponent("Image");
    imgLeftTips = uiLink:Get("imgLeftTips"):GetComponent("Image");
    imgType1 = uiLink:Get("imgType1"):GetComponent("Image");
    imgType2 = uiLink:Get("imgType2"):GetComponent("Image");
    imgType3 = uiLink:Get("imgType3"):GetComponent("Image");
    textMaxScore = uiLink:Get("textMaxScore"):GetComponent("Text");
    textScore = uiLink:Get("textScore"):GetComponent("Text");
    textType1Name = uiLink:Get("textType1Name"):GetComponent("Text");
    textType2Name = uiLink:Get("textType2Name"):GetComponent("Text");
    textType3Name = uiLink:Get("textType3Name"):GetComponent("Text");
    textReward1 = uiLink:Get("textReward1"):GetComponent("Text");
    textReward2 = uiLink:Get("textReward2"):GetComponent("Text");
    textReward3 = uiLink:Get("textReward3"):GetComponent("Text");
    textResult = uiLink:Get("textResult"):GetComponent("Text");
    btnRestart = uiLink:Get("btnRestart"):GetComponent("Button");
    btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    btnStartAgain = uiLink:Get("btnStartAgain"):GetComponent("Button");
    btnGm = uiLink:Get("btnGm"):GetComponent("Button");
    btnGMExit=uiLink:Get("btnGMExit"):GetComponent("Button");
    btnGMAddNumber = uiLink:Get("btnGMAddNumber"):GetComponent("Button");
    sliderRewardNum = uiLink:Get("sliderRewardNum"):GetComponent("Slider");
    inputField1 = uiLink:Get("inputField1"):GetComponent("InputField");
    inputField2 = uiLink:Get("inputField2"):GetComponent("InputField");
    dropDown1 = uiLink:Get("dropDown1"):GetComponent("Dropdown");
    dropDown2 = uiLink:Get("dropDown2"):GetComponent("Dropdown");
    dropDown3 = uiLink:Get("dropDown3"):GetComponent("Dropdown");
    Scrollbar = uiLink:Get("Scrollbar"):GetComponent("ScrollRect");
    gridParent = uiLink:Get("goGrid"):GetComponent("GridLayoutGroup");
    rootAin = uiLink:Get("root"):GetComponent("Animator");
    rawImage = uiLink:Get("root"):GetComponent("RawImage");
    textNowRankNumber= uiLink:Get("textNowRankNumber"):GetComponent("Text");
    goRewardGroup=uiLink:Get("goRewardGroup");
    goIsAllowRevokeGroup=uiLink:Get("goIsAllowRevokeGroup");
    textRevokeNum=uiLink:Get("textRevokeNum"):GetComponent("Text");
    rectSpecialGroup=uiLink:Get("rectSpecialGroup"):GetComponent("RectTransform");
    btnSwitchType1=uiLink:Get("btnSwitchType1"):GetComponent("Button");
    btnSwitchType2=uiLink:Get("btnSwitchType2"):GetComponent("Button");
    btnSwitchType3=uiLink:Get("btnSwitchType3"):GetComponent("Button");
SetActive(goDebug, false);

uiLink:AddClickEvent("btnRevoke", function()
        if this.specialModelGameData["isAllowRevoke"].nowStep<=0 then
            return;
        end
        if this.specialModelGameData["isAllowRevoke"].nowRoundLeftStep~=-1 and this.specialModelGameData["isAllowRevoke"].nowRoundLeftStep<=0 then
            return;
        end
        local archive=this.specialModelGameData["isAllowRevoke"].RevokeArchive:PopFirst();
        this.LoadArchive(archive,false);
        this.randomRevokeList:RevokeStep(1);
        table.remove(this.reqOPList,#this.reqOPList);
        this.specialModelGameData["isAllowRevoke"].nowStep=this.specialModelGameData["isAllowRevoke"].RevokeArchive:Size();
        if this.specialModelGameData["isAllowRevoke"].nowRoundLeftStep~=-1 then
            this.specialModelGameData["isAllowRevoke"].nowRoundLeftStep=this.specialModelGameData["isAllowRevoke"].nowRoundLeftStep-1;
        end
        
        UpdateSpecialModePanelHelpFun["isAllowRevoke"]();
    end);

    uiLink:AddClickEvent("btnRestart", function()
        btnRestart.enabled = false;
        btnSwitchType1.enabled= false;
        btnSwitchType2.enabled= false;
        btnSwitchType3.enabled= false;
        this.StartNewGame(1);
    end);

    uiLink:AddClickEvent("btnRank", function()
        LuaMgr.ShowLuaPanel(UIName.MiniGame2048RankViewModel,this.rankData);
    end);

    uiLink:AddClickEvent("btnStartAgain", function()
        this.StartNewGame(2);
    end);
    uiLink:AddClickEvent("btnGm", function()
        if inputField1.text ~= nil and inputField1.text ~= "" then
            MiniGame2048GamePlayFrameWorkMgr.nowScore = tonumber(inputField1.text)
        end
        if inputField2.text ~= nil and inputField2.text ~= "" then
            MiniGame2048GamePlayFrameWorkMgr.nowMergeBlock[inputField2.text] = true;
        end
        this.UpdateScore();
        this.NetDataSuccssful(true);
    end)

    uiLink:AddClickEvent("btnGMAddNumber", function()
        this.DebugAddNumber();
    end)

    eventTrigger.onPointerDown = this.OnPointerDown
    eventTrigger.onPointerUp = this.OnPointerUp

    uiLink:AddClickEvent("btnExit", function()
        this.SwitchMainPanel();
    end);
    uiLink:AddClickEvent("btnSwitchType1", function()
        if this.selectType==1 then
            return;
        end
        this.SwitchTypePanel(1);
    end)
    uiLink:AddClickEvent("btnSwitchType2", function()
        if this.selectType==2 then
            return;
        end
        this.SwitchTypePanel(2);
    end)
    uiLink:AddClickEvent("btnSwitchType3", function()
        if this.selectType==3 then
            return;
        end
        this.SwitchTypePanel(3);
    end)
    uiLink:AddClickEvent("btnGMExit", function()
        LuaMgr.Back();
    end);
end

this.InitDebugBtn = function()
    if not LuaMgr.IsDebug() then
        return;
    end
    SetActive(goDebug,true);
    local list1 = { LuaMgr.GetLangText("MiniGame2048ViewModel_0"), LuaMgr.GetLangText("MiniGame2048ViewModel_1"), LuaMgr
        .GetLangText("MiniGame2048ViewModel_2"), LuaMgr.GetLangText("MiniGame2048ViewModel_3") };
    local list2 = { LuaMgr.GetLangText("MiniGame2048ViewModel_4"), LuaMgr.GetLangText("MiniGame2048ViewModel_5"), LuaMgr
        .GetLangText("MiniGame2048ViewModel_6"), LuaMgr.GetLangText("MiniGame2048ViewModel_7") };
    this.debugList3={};
    for key, value in pairs(ConfigMgr.Config.NumberBlockMap) do
        table.insert(this.debugList3,value.ID);
    end
    table.sort(this.debugList3);
    LuaMgr.AddOptionalOnDropDown(dropDown1, list1);
    LuaMgr.AddOptionalOnDropDown(dropDown2, list2);
    LuaMgr.AddOptionalOnDropDown(dropDown3, this.debugList3);
end


this.AwakeInitData=function ()
    this.mapToTypeToReward={};
    local config=ConfigMgr.Config.NumberRewardMap;
    for key, value in pairs(config) do
        if this.mapToTypeToReward[value.Group]==nil then
            this.mapToTypeToReward[value.Group]={};
        end
        if this.mapToTypeToReward[value.Group][value.Type]==nil then
            this.mapToTypeToReward[value.Group][value.Type]={};
        end
        table.insert(this.mapToTypeToReward[value.Group][value.Type],value);
    end
    for key, value in pairs(this.mapToTypeToReward) do
        table.sort(value[1],function (a, b)
            return tonumber(a.Goal)<tonumber(b.Goal);
        end)
    end
    MiniGame2048GamePlayFrameWorkMgr.InitData();
end

this.AwakeInitPanel = function()
gridParent.constraintCount = this.row;


    for i = 1, this.row, 1 do
        this.grids[i] = {}
        for j = 1, this.col, 1 do
            this.grids[i][j] = UI2048Grid.New(gridParent.transform);
            this.grids[i][j].gameObject.name = i .. "_" .. j
        end
    end
end

this.InitData = function()
    this.openTypeValueMap={};

    local config=ConfigMgr.Config.NumberMainMap;
    local nowTime = LuaMgr.Timestamp();
    for key, value in pairs(config) do
       if value.OpenDate<=nowTime and value.CloseDate>=nowTime then
        this.openTypeValueMap[value.Type]=value;
       end 
    end
this.selectType=1;
    this.randomRevokeList=nil;
end

this.InitPanel = function()

    imgType1.sprite=LuaMgr.GetSprite("2048Panel", this.openTypeValueMap[1].Cover);
    textType1Name.text=LuaMgr.GetLangText(this.openTypeValueMap[1].ModeNameLan);

    imgType2.sprite=LuaMgr.GetSprite("2048Panel", this.openTypeValueMap[2].Cover);
    textType2Name.text=LuaMgr.GetLangText(this.openTypeValueMap[2].ModeNameLan);

    imgType3.sprite=LuaMgr.GetSprite("2048Panel", this.openTypeValueMap[3].Cover);
    textType3Name.text=LuaMgr.GetLangText(this.openTypeValueMap[3].ModeNameLan);
    this.SwitchMainPanel();
    
end


local switchTypePanelFun={
    [1]=function ()
        this.selectType=1;
        SetActive(goSelectType1,true);
        SetActive(goSelectType2,false);
        SetActive(goSelectType3,false);
        this.UpdateScore()
        this.SwitchTypePanelHelpFun(1);
        this.UpdateBackGround();
        this.UpdateRewardSlider();
    end,
    [2]=function ()
        this.selectType=2;
        SetActive(goSelectType1,false);
        SetActive(goSelectType2,true);
        SetActive(goSelectType3,false);
        this.UpdateScore()
        this.SwitchTypePanelHelpFun(2);
        this.UpdateBackGround();
        this.UpdateRewardSlider();
    end,
    [3]=function ()
        this.selectType=3;
        SetActive(goSelectType1,false);
        SetActive(goSelectType2,false);
        SetActive(goSelectType3,true);
        this.UpdateScore()
        this.SwitchTypePanelHelpFun(3);
        this.UpdateBackGround();
        this.UpdateRewardSlider();
    end,
}
this.SwitchTypePanel=function (panelType)
    switchTypePanelFun[panelType]();
end
this.SwitchTypePanelHelpFun=function (type)
    imgLeftTips.sprite=LuaMgr.GetSprite("2048Panel",this.openTypeValueMap[type].PartPicture);
    imgIconBG1Show1.sprite=LuaMgr.GetSprite("2048Panel",this.openTypeValueMap[type].PartPicture.."_hw1");
    imgIconBG2Show3.sprite=LuaMgr.GetSprite("2048Panel",this.openTypeValueMap[type].PartPicture.."_hw3");
    imgIconBG3Show2.sprite=LuaMgr.GetSprite("2048Panel",this.openTypeValueMap[type].PartPicture.."_hw2");
    imgIconBG4Show3.sprite=LuaMgr.GetSprite("2048Panel",this.openTypeValueMap[type].PartPicture.."_hw3");
    imgIconBG5Show2.sprite=LuaMgr.GetSprite("2048Panel",this.openTypeValueMap[type].PartPicture.."_hw2");
    imgIconBG6Show4.sprite=LuaMgr.GetSprite("2048Panel",this.openTypeValueMap[type].PartPicture.."_hw4");
    imgIconBG7Show3.sprite=LuaMgr.GetSprite("2048Panel",this.openTypeValueMap[type].PartPicture.."_hw3");
    imgIconBG8Show3.sprite=LuaMgr.GetSprite("2048Panel",this.openTypeValueMap[type].PartPicture.."_hw3");
end



local openModelSwitchFun={
    ["isAllowRevoke"]=function (params)
        this.specialModelData["isAllowRevoke"].maxStep=tonumber(params[2]);
        this.randomRevokeList=RandomRevokeList.New(this.specialModelData["isAllowRevoke"].maxStep);
        SetActive(goIsAllowRevokeGroup,true);
        this.specialModelGameData["isAllowRevoke"].RevokeArchive=LuaO1DeQueue.New();
        this.specialModelGameData["isAllowRevoke"].nowRoundLeftStep=tonumber(params[3]);
        this.specialModelGameData["isAllowRevoke"].nowStep=0;
    end,
    ["isAllowChainMerge"]=function (params)

    end,
    ["isEndWhenMerge"]=function (params)
        this.specialModelData["isEndWhenMerge"].endBlockId=params[2];
    end,
    ["isStartBoard"]=function (params)
        this.specialModelData["isStartBoard"].startBoardData=params[2];
        this.specialModelData["isStartBoard"].createNumberOnStart=tonumber(params[3]);
    end,
    ["isSaveArchive"]=function (params)

    end,
    ["isOnlyTriggerCreateNumber"]=function (params)
    end,
}
local closeModelSwitchFun={
    ["isAllowRevoke"]=function ()
this.randomRevokeList=RandomRevokeList.New(5);
        SetActive(goIsAllowRevokeGroup,false);

    end,
    ["isAllowChainMerge"]=function ()
    end,
    ["isEndWhenMerge"]=function ()
    end,
    ["isStartBoard"]=function ()
    end,
    ["isSaveArchive"]=function ()
    end,
    ["isOnlyTriggerCreateNumber"]=function ()
    end,
}

this.InitGameDataPanel=function ()
    MiniGame2048GamePlayFrameWorkMgr.InitViewModelData();
    this.UpdateScore();
    local data=this.openTypeValueMap[this.selectType].Warning
    local tempOpenModel={};

    for index, value in ipairs(data) do
        tempOpenModel[value[1]]=value;
    end
    for key, value in pairs(this.specialModelMap) do
        if tempOpenModel[key]~=nil then
            this.specialModelMap[key]=true;
            openModelSwitchFun[key](tempOpenModel[key]);
        else
            this.specialModelMap[key]=false;
            closeModelSwitchFun[key]();
        end
    end
    this.InitTypeData(this.selectType);

    for i = 1, this.row, 1 do
        for j = 1, this.col, 1 do
            if this.grids[i][j]:IsHaveNumberObj() then
                this.grids[i][j]:OnRecover();
            end
        end
    end
if this.specialModelMap["isOnlyTriggerCreateNumber"] then
        this.isNeedCreateNumber = false;
    else
        this.isNeedCreateNumber = true;
    end
end


this.InitTypeData=function (type)
this.createNumberData={
allWeight=0,
        numberAndWeight={
            blockId="",
            weight=0,
},
    };
    local data=this.openTypeValueMap[type].Create;
    for index, value in ipairs(data) do
        this.createNumberData.allWeight=this.createNumberData.allWeight+tonumber(value[2]);
        table.insert(this.createNumberData.numberAndWeight,{blockId=value[1],weight=tonumber(value[2])});
    end
end


this.SwitchMainPanel = function()
    SetActive(goStart,true);
    SetActive(goGrid,false);
MiniGame2048GamePlayFrameWorkMgr.InitViewModelData();
    for key, value in pairs(this.specialModelMap) do
closeModelSwitchFun[key]();
    end
    this.SwitchTypePanel(this.selectType);
    btnRestart.enabled = true;
    btnSwitchType1.enabled= true;
    btnSwitchType2.enabled= true;
    btnSwitchType3.enabled= true;
    SetActive(goResult, false);
    this.NetRankData(nil);
end


this.NetDataSuccssful = function(isNormalExit)
    local modeId=this.openTypeValueMap[this.selectType].ID;
    local before_score = DataMgr.Player.numberMergeV2[modeId].totalScore;
    local target={};
    for key, value in pairs(MiniGame2048GamePlayFrameWorkMgr.nowMergeBlock) do
        table.insert(target,key);
    end





    local board={}
    for i,v in ipairs(this.grids) do
        for p,m in ipairs(v) do
            if m.numberObj~=nil then
                local key=this.GetReqPosByLocName(m.transform.name);
                board[tostring(key)]=m.numberObj.score>0 and m.numberObj.score or -1;
            end
        end
    end
  
    local stepData={
Start=0;
Ops=NumTool.GetLen(this.reqOPList)>0 and this.reqOPList or nil;
        Board=board;
        InitBoard=this.reqInitBoard
    }
    local data = {ID=modeId, Score = MiniGame2048GamePlayFrameWorkMgr.nowScore, Target = target,Step=stepData };
    LuaDebug.Nerror(data);
    local Url = "numberMerge/reward"
    ApiMgr.Request(Url, data, true,
        function(result)
            local re = json.decode(result);
            if re.result.Items ~= nil then
                local data = json.encode(re.result);
                LuaMgr.ShowItemRewared(data);
            end
            SetActive(goStart, false)
            SetActive(goResult, true)
            this.UpdateRewardSlider();
            this.PlayAin("UI_MiniGame2048Panel_goResult_appear");
            local reward = re.result.Items
            local firstItem = nil;
            if re.result.Items ~= nil and (not IsNull(re.result.Items)) then
                for i, v in pairs(reward) do
                    firstItem = { ID = v.id, Count = v.count }
                end
            end
            local askData = {}
            local cp_param = {
                modeId=modeId,
            };
            askData["game_uid"] = (tostring(DataMgr.Player.uid) .. "|" .. tostring(this.startTime) .. "|" .. "foundation_tearoom_hehe_end")
            askData["game_result"] = isNormalExit ~= nil and 1 or 0;
            askData["score"] = this.currentScore
            askData["before_score"] = before_score
            askData["after_socre"] = DataMgr.Player.numberMerge.totalScore
            askData["item_id"] = firstItem == nil and "" or firstItem.ID
            askData["item_num"] = firstItem == nil and "" or firstItem.Count
            askData["complete_time"] = tostring(LuaMgr.Timestamp() - this.startTime);
            askData["cp_param"] = json.encode(cp_param)
            DataReportMgr.RequestBiliData("foundation_tearoom_hehe_end", askData, nil, nil);
            this.startTime = LuaMgr.Timestamp();
        end,
        function(failCode)
        end,
        true
    )
end

this.UpdateRewardSlider = function()
    local selectGroupId=this.openTypeValueMap[this.selectType].ID;
    if this.mapToTypeToReward[selectGroupId][1]==nil then
        SetActive(goRewardGroup,false);
        return;
    end
    SetActive(goRewardGroup,true);
    local value1 = tonumber(this.mapToTypeToReward[selectGroupId][1][1].Goal);
    local value2 = tonumber(this.mapToTypeToReward[selectGroupId][1][2].Goal);
    local value3 = tonumber(this.mapToTypeToReward[selectGroupId][1][3].Goal);
    local Reward1=this.mapToTypeToReward[selectGroupId][1][1].Reward[1];
    local Reward2=this.mapToTypeToReward[selectGroupId][1][2].Reward[1];
    local Reward3=this.mapToTypeToReward[selectGroupId][1][3].Reward[1];
    local value = DataMgr.Player.numberMergeV2[selectGroupId].totalScore;
    SetActive(goHasReward1, false);
    SetActive(goStart1, false);
    SetActive(goHasReward2, false);
    SetActive(goStart2, false);
    SetActive(goHasReward3, false);
    SetActive(goStart3, false);
    goGoodsItem1:SetData(tostring(Reward1.id), Reward1.count, 1, 1, true, true);
    goGoodsItem2:SetData(tostring(Reward2.id), Reward2.count, 1, 1, true, true);
    goGoodsItem3:SetData(tostring(Reward3.id), Reward3.count, 1, 1, true, true);
    textReward1.text = tostring(value1);
    textReward2.text = tostring(value2);
    textReward3.text = tostring(value3);



    if value < value1 then
        sliderRewardNum.value = (value / value1 * 0.21);
    elseif value < value2 then
        sliderRewardNum.value = 0.25 + ((value - value1) / (value2 - value1) * (0.59 - 0.25));
        SetActive(goHasReward1, true);
        SetActive(goStart1, true);
    elseif value < value3 then
        sliderRewardNum.value = 0.63 + ((value - value2) / (value3 - value2) * (0.97 - 0.63));
        SetActive(goHasReward1, true);
        SetActive(goStart1, true);
        SetActive(goHasReward2, true);
        SetActive(goStart2, true);
    else
        sliderRewardNum.value = 1;
        SetActive(goHasReward1, true);
        SetActive(goStart1, true);
        SetActive(goHasReward2, true);
        SetActive(goStart2, true);
        SetActive(goHasReward3, true);
        SetActive(goStart3, true);
    end
end


this.LoadArchive=function (archive,loadRandom)
    MiniGame2048GamePlayFrameWorkMgr.LoadArchive(archive.MiniGame2048GamePlayFrameWorkMgrData);
    
    for i = 1, this.row, 1 do
        for j = 1, this.col, 1 do
            local numberData=archive.gridList[((i-1)*this.col)+j];
if numberData.currentId==nil and this.grids[i][j]:IsHaveNumberObj() then
                this.grids[i][j]:OnRecover();
elseif numberData.currentId~=nil and this.grids[i][j]:IsHaveNumberObj() then
                this.grids[i][j]:GetNumberObj():ArchiveSetData(this.grids[i][j],numberData.currentId);
                this.grids[i][j]:GetNumberObj():ArchiveSetBuffData(numberData.gameplayBuffList,numberData.gameplayBuffAttribute);
                this.grids[i][j]:GetNumberObj():ArchiveSetGCData(numberData.gameplayCueMap);
elseif numberData.currentId~=nil and (not this.grids[i][j]:IsHaveNumberObj()) then
                local tempNumber=this.GetUnActiveNumber(this.grids[i][j]);
                tempNumber:ArchiveSetData(this.grids[i][j],numberData.currentId);
                tempNumber:ArchiveSetBuffData(numberData.gameplayBuffList,numberData.gameplayBuffAttribute);
                tempNumber:ArchiveSetGCData(numberData.gameplayCueMap);
            end
            
        end
    end

    for key, value in pairs(archive.specialGameData) do
if key=="isAllowRevoke" then
            this.specialModelGameData[key].nowRoundLeftStep=value;
        else
            this.specialModelGameData[key]=value;
        end
    end
    

    if loadRandom then
        this.randomRevokeList:LoadRamdomList(archive.randomListData);
    end
    this.UpdateBackGround();
    this.UpdateScore();
    
end

this.SaveArchive=function (saveRandom)
    local archive={
        gridList={};
        specialGameData={};
        MiniGame2048GamePlayFrameWorkMgrData=nil;
        randomListData="";
    };
    archive.MiniGame2048GamePlayFrameWorkMgrData=MiniGame2048GamePlayFrameWorkMgr.GetArchiveData();


    for i = 1, this.row, 1 do
        for j = 1, this.col, 1 do
            if this.grids[i][j]:IsHaveNumberObj() then
                local number={
                    currentId=nil,
                    gameplayBuffList={},
                    gameplayBuffAttribute={},
                    gameplayCueMap={},
                }
                local nowNumberObject=this.grids[i][j]:GetNumberObj();
                number.currentId=nowNumberObject.currNumId;
                number.gameplayBuffList=table.Copy(nowNumberObject.gameplayBuffList);
                number.gameplayBuffAttribute=table.Copy(nowNumberObject.gameplayBuffAttribute);
                for key, value in pairs(nowNumberObject.gameplayCueMap) do
                    number.gameplayCueMap[key]=true;
                end
                table.insert(archive.gridList,number);
            else
                table.insert(archive.gridList,{});
            end
        end
    end

    for key, value in pairs(this.specialModelGameData) do
if key=="isAllowRevoke" then
            archive.specialGameData[key]=value.nowRoundLeftStep;
        else
            archive.specialGameData[key]=value;
        end
    end


    if saveRandom then
        archive.randomListData=this.randomRevokeList:GetRamdomList();
    end
    return archive;
end


this.StartNewGame = function(type)
    this.InitGameDataPanel();
    this.UpdateSpecialModePanel();
    SetActive(goGrid,true);
    this.reqOPList={};
    this.reqInitBoard={};
    local nowSelectId=this.openTypeValueMap[this.selectType].ID;
    local nowArchive=DataMgr.Player.numberMergeV2[nowSelectId].archive;
    local loadFun=function ()
        this.LoadArchive(json.decode(nowArchive),true);

        for i,v in ipairs(this.grids) do
            for p,m in ipairs(v) do
                if m.numberObj~=nil then
                    local key=this.GetReqPosByLocName(m.transform.name);
                    this.reqInitBoard[tostring(key)]=m.numberObj.score>0 and m.numberObj.score or -1;
                end
            end
        end
        if type==1 then
            this.PlayAin("UI_MiniGame2048Panel_goStart");
            this.co = coroutine_runner.start(
                function()
                    coroutine_runner.wait(2)
                    SetActive(goStart, false)
                    this.co=nil;
                end)
        elseif type==2 then
            this.PlayAin("UI_MiniGame2048Panel_goResult_disappear");
            this.co = coroutine_runner.start(
                function()
                    coroutine_runner.wait(0.25)
                    SetActive(goResult, false)
                    this.co=nil;
                end)
        end

    end
    local normalFun=function ()
        if this.specialModelMap["isStartBoard"] then
            if this.specialModelData["isStartBoard"].createNumberOnStart~="1" then
                this.CreateNumber(true,0);
            end
            this.UpdateBackGround();
        else
            this.CreateNumber(true,0);
            this.UpdateBackGround();
        end
        if type==1 then
            this.PlayAin("UI_MiniGame2048Panel_goStart");
            this.co = coroutine_runner.start(
                function()
                    coroutine_runner.wait(2)
                    SetActive(goStart, false)
                    this.co=nil;
                end)
        elseif type==2 then
            this.PlayAin("UI_MiniGame2048Panel_goResult_disappear");
            this.co = coroutine_runner.start(
                function()
                    coroutine_runner.wait(0.25)
                    SetActive(goResult, false)
                    this.co=nil;
                end)
        end
    end
    if this.specialModelMap["isSaveArchive"] and (not IsNullOrEmpty(nowArchive)) then


        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, ConfigMgr.LangGlobal("7068"), loadFun,normalFun);
else
        normalFun();
    end
end

this.UpdateBackGround=function ()
    if MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock==nil then
        rawImage.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/MiniGame2048/%s.png",
        "ui_jj_2048_bj0"))
        return;
    else
        if this.nowMaxLevelBlockId==MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock then
            return;
        else
local targetBg=ConfigMgr.Config.NumberBlockMap[MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock].BasePicture;
            if not IsNullOrEmpty(targetBg) then
                this.nowMaxLevelBlockId=MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock;
                rawImage.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/MiniGame2048/%s.png",
                targetBg))
            end
        end
    end
end

this.UpdateScore = function()
    local score=MiniGame2048GamePlayFrameWorkMgr.nowScore;
    textScore.text = tostring(score);
    textResult.text = textScore.text;
    local nowSelectId=this.openTypeValueMap[this.selectType].ID;
    local maxScore = DataMgr.Player.numberMergeV2[nowSelectId].maxScore;
    if score > maxScore then
        textMaxScore.text = textScore.text;
    else
        textMaxScore.text = maxScore
    end
end


this.CreateNumber = function(needWait,dir)
    this.canCreateNumberGrid = {};

    for i = 1, this.row, 1 do
        for j = 1, this.col, 1 do
            if not this.grids[i][j]:IsHaveNumberObj() then



                table.insert(this.canCreateNumberGrid, this.grids[i][j])
            end
        end
    end

    if #this.canCreateNumberGrid <= 0 then
        return;
    end

local randomValue=this.randomRevokeList:GetRandomValue();
    local index =this.GetRamdomIndexByRandomValue(10000,randomValue,#this.canCreateNumberGrid);
    local myGrid = this.canCreateNumberGrid[index];
    local tmpNumber = this.GetUnActiveNumber(myGrid);

randomValue=this.randomRevokeList:GetRandomValue();
    local needCreateNumberWeight=this.GetRamdomIndexByRandomValue(10000,randomValue,this.createNumberData.allWeight);

    local nowWeight=0;
    local createNumberId="";
    local cnt=#this.createNumberData.numberAndWeight;

    for i = 1, cnt+1, 1 do
if nowWeight>=needCreateNumberWeight then
            createNumberId=this.createNumberData.numberAndWeight[i-1].blockId;
            break;
        else
            nowWeight=nowWeight+this.createNumberData.numberAndWeight[i].weight;
        end
    end

tmpNumber:SkillCreateSelf(myGrid,createNumberId,needWait);
    table.insert(this.reqOPList,{Op=dir,Pos=this.GetReqPosByLocName(myGrid.UI2048Grid.name),
                                 T=ConfigMgr.Config.NumberBlockMap[createNumberId].Score>0 and ConfigMgr.Config.NumberBlockMap[createNumberId].Score or -1;})
end

this.GetReqPosByLocName=function(locName)
    local locs=NumTool.split(locName,"_");
    local row=tonumber(locs[1])
    local col=tonumber(locs[2])
    if col==0 then col=4 end;
    local pos=(5-row)*100+col-1;
    return pos;
end


this.GetRamdomIndexByRandomValue=function (maxRandom,nowRandom,maxListLength)
    local temp1=(nowRandom*maxListLength)/(maxRandom*maxListLength);
    if temp1>1 then
        temp1=temp1-math.floor(temp1);
    end
return math.ceil(maxListLength*temp1);
end

this.GetUnActiveNumber=function (createGrid)
    local tmpNumber = nil;

    for i = 1, #this.numberItems do
        if not this.numberItems[i].gameObject.activeSelf then
            tmpNumber = this.numberItems[i]
            break
        end
    end

    if tmpNumber == nil then
tmpNumber = UI2048Number.New(createGrid.transform);
        table.insert(this.numberItems, tmpNumber)
    end
    return tmpNumber;
end


this.IsGameLose = function()
    if this.specialModelMap["isEndWhenMerge"] then
        if MiniGame2048GamePlayFrameWorkMgr.nowMergeBlock[this.specialModelData["isEndWhenMerge"].endBlockId] then
            return true;
        end
    end

    for i = 1, this.row, 1 do
        for j = 1, this.col, 1 do
            if not this.grids[i][j]:IsHaveNumberObj() then
                return false;
            end
        end
    end

    for i = 1, this.row, 1 do
        for j = 1, this.col, 1 do
            local up = this.IsHaveGrid(i - 1, j) and this.grids[i - 1][j] or nil;
            local down = this.IsHaveGrid(i + 1, j) and this.grids[i + 1][j] or nil;
            local left = this.IsHaveGrid(i, j - 1) and this.grids[i][j - 1] or nil;
            local right = this.IsHaveGrid(i, j + 1) and this.grids[i][j + 1] or nil;

            if up ~= nil then
                if this.CheckMerge(this.grids[i][j]:GetNumberObj(),up:GetNumberObj())~=0 then
                    return false;
                end
            end

            if down ~= nil then
                if this.CheckMerge(this.grids[i][j]:GetNumberObj(),down:GetNumberObj())~=0 then
                    return false;
                end
            end

            if left ~= nil then
                if this.CheckMerge(this.grids[i][j]:GetNumberObj(),left:GetNumberObj())~=0 then
                    return false;
                end
            end

            if right ~= nil then
                if this.CheckMerge(this.grids[i][j]:GetNumberObj(),right:GetNumberObj())~=0 then
                    return false;
                end
            end
        end
    end

return true;
end

this.OnPointerDown = function()

    this.pointerDownPos = UnityEngine.Input.mousePosition;
end

this.OnPointerUp = function()

    this.pointerUpPos = UnityEngine.Input.mousePosition;

    if Vector3.Distance(this.pointerDownPos, this.pointerUpPos) < 100 then
        LuaDebug.error("无效的操作!");
        return;
    end

    local tempArchive=nil;
    if this.specialModelMap["isAllowRevoke"] then
        tempArchive=this.SaveArchive(false);
    end
    this.isLegalMove=false;
    this.randomRevokeList:OpenStage();

    local moveDir=this.MoveNumber();
    

    if this.isNeedCreateNumber then
        this.CreateNumber(true,moveDir);
    end
if this.specialModelMap["isAllowRevoke"] and this.isLegalMove then
this.specialModelGameData["isAllowRevoke"].RevokeArchive:PushFirst(tempArchive);
        if this.specialModelGameData["isAllowRevoke"].RevokeArchive:Size()>this.specialModelData["isAllowRevoke"].maxStep then
            this.specialModelGameData["isAllowRevoke"].RevokeArchive:PopLast();
        end
        this.specialModelGameData["isAllowRevoke"].nowStep=this.specialModelGameData["isAllowRevoke"].RevokeArchive:Size();
    end


    for i = 1, this.row, 1 do
        for j = 1, this.col, 1 do
            if this.grids[i][j]:IsHaveNumberObj() then
                this.grids[i][j]:GetNumberObj().status = 0;
                this.grids[i][j]:GetNumberObj():SkillCheckBuff();
            end
        end
    end
    if this.specialModelMap["isOnlyTriggerCreateNumber"] then
        this.isNeedCreateNumber = false;
    else
        this.isNeedCreateNumber = true;
    end
    this.UpdateBackGround();
    this.UpdateScore();

if this.IsGameLose() then

        this.NetDataSuccssful(true);
    end
    this.UpdateSpecialModePanel();
this.randomRevokeList:EndStage(this.isLegalMove);
end


local CenterBlockMoveFun=function (nowi,nowj,type)

    local rowOffset={0,0,-1,1};
    local colOffset={1,-1,0,0};
    local row=nowi+rowOffset[type];
    local col=nowj+colOffset[type];
    local lastHaveGridGridPos=this.grids[nowi][nowj]
    local nowNumber=this.grids[nowi][nowj]:GetNumberObj();
if nowNumber.gameplayBuffAttribute["isFreeze"] then
return false;
    end

while this.IsHaveGrid(row,col) do
        local targetGrid = this.grids[row][col];
if targetGrid:IsHaveNumberObj() then
local mergeResult=this.CheckMerge(nowNumber,targetGrid:GetNumberObj());
if mergeResult~=0 then
                nowNumber:SkillMoveAndMerge(lastHaveGridGridPos,targetGrid,mergeResult,not this.specialModelMap["isAllowChainMerge"]);
                this.isNeedCreateNumber=true;
                this.isLegalMove=true;
                return true;
else
                nowNumber:SkillMove(lastHaveGridGridPos)
                if lastHaveGridGridPos~=this.grids[nowi][nowj] then
                    this.isNeedCreateNumber=true;
                    this.isLegalMove=true;
                end
                return false;
            end
        end
        lastHaveGridGridPos=this.grids[row][col];
        row=row+rowOffset[type];
        col=col+colOffset[type];
    end

    nowNumber:SkillMove(lastHaveGridGridPos);
    if lastHaveGridGridPos~=this.grids[nowi][nowj] then
        this.isNeedCreateNumber=true;
        this.isLegalMove=true;
    end
    return false;
end

local CheckMove=function (type)
    local result=false;

    local firstForParams={
        {this.row,1,-1},
        {1,this.row,1},
        {1,this.row,1},
        {this.row,1,-1},
    };
    local secondForParams={
        {this.col, 1, -1},
        {1, this.col, 1},
        {1, this.col, 1},
        {this.col, 1, -1},
    };
    for i = firstForParams[type][1], firstForParams[type][2], firstForParams[type][3] do
        for j = secondForParams[type][1], secondForParams[type][2], secondForParams[type][3] do
            if this.grids[i][j]:IsHaveNumberObj() then
                result=CenterBlockMoveFun(i,j,type) or result;
            end
        end
    end
    
    return result;
end

this.MoveNumber = function()
    local ChainMerge=false;
    local haveMerge=false;
    if this.specialModelMap["isAllowChainMerge"] then
        ChainMerge=true;
    end
    local dir=0;
    local MoveNumberFun=function ()
        if UnityEngine.Mathf.Abs(this.pointerUpPos.x - this.pointerDownPos.x) > UnityEngine.Mathf.Abs(this.pointerDownPos.y - this.pointerUpPos.y) then

            if this.pointerUpPos.x - this.pointerDownPos.x > 0 then

                haveMerge=CheckMove(1);
                dir=4;
            else

                haveMerge=CheckMove(2);
                dir=3;
            end
        else

            if this.pointerUpPos.y - this.pointerDownPos.y > 0 then

                haveMerge=CheckMove(3);
                dir=1;
            else

                haveMerge=CheckMove(4);
                dir=2;
            end
        end
    end
    MoveNumberFun();
while haveMerge and ChainMerge do
        MoveNumberFun();
    end
    return dir;
end

this.CheckMerge=function (nowBlock,targetBlock)
    if nowBlock.gameplayBuffAttribute["NotMerge"] or targetBlock.gameplayBuffAttribute["NotMerge"] then
        return 0;
    end
    local nowBlockId=nowBlock.currNumId;
    local targetBlockId=targetBlock.currNumId;

    local config=ConfigMgr.Config.NumberBlockMap;
    local activeRange=MiniGame2048GamePlayFrameWorkMgr.GetBlockIdMapByTag(config[nowBlockId].BoardBegin);
    if activeRange[targetBlockId] then
        return 1;
    end
    local passiveRange=MiniGame2048GamePlayFrameWorkMgr.GetBlockIdMapByTag(config[targetBlockId].BoardEnd);
    if passiveRange[nowBlockId] then
        return 2;
    end
    return 0;
end

this.IsHaveGrid = function(i, j)
    if (i >= 1 and i <= this.row and j >= 1 and j <= this.col) then
        return true;
    end

    return false;
end

this.DebugAddNumber = function()
    if goResult.activeSelf or (not goGrid.activeSelf) then
        return;
    end
    local i = dropDown1.value + 1;
    local m = dropDown2.value + 1;
    local numberId = this.debugList3[dropDown3.value + 1];
    local tarGetNumberObj = nil;
    if this.grids[i][m]:IsHaveNumberObj() then
        tarGetNumberObj = this.grids[i][m]:GetNumberObj();
        tarGetNumberObj:ArchiveSetData(this.grids[i][m],numberId);
local funList,paramsList=MiniGame2048GamePlayFrameWorkMgr.GetActionByOutInterface(numberId,1)
        local count=#funList;
        for i = 1, count, 1 do
            funList[i](tarGetNumberObj,paramsList[i]);
        end
    else
        local myGrid = this.grids[i][m];
        local tmpNumber = this.GetUnActiveNumber(myGrid);
        tmpNumber:ArchiveSetData(myGrid,numberId);
local funList,paramsList=MiniGame2048GamePlayFrameWorkMgr.GetActionByOutInterface(numberId,1)
        local count=#funList;
        for i = 1, count, 1 do
            funList[i](tmpNumber,paramsList[i]);
        end
    end
end

this.UpdateSpecialModePanel=function ()
    for key, value in pairs(this.specialModelMap) do
        if value then
            UpdateSpecialModePanelHelpFun[key]();
        end
    end
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    goGrid = nil;
    goStart = nil;
    goSelectType1 = nil;
    goSelectType2 = nil;
    goSelectType3 = nil;
    UIglowstart = nil;
    goStart1 = nil;
    goStart2 = nil;
    goStart3 = nil;
    goGoodsItem1 = nil;
    goGoodsItem2 = nil;
    goGoodsItem3 = nil;
    goHasReward1 = nil;
    goHasReward2 = nil;
    goHasReward3 = nil;
    goResult = nil;
    goDebug = nil;
    imgIconBG1Show1 = nil;
    imgIconBG2Show3 = nil;
    imgIconBG3Show2 = nil;
    imgIconBG4Show3 = nil;
    imgIconBG5Show2 = nil;
    imgIconBG6Show4 = nil;
    imgIconBG7Show3 = nil;
    imgIconBG8Show3 = nil;
    imgLeftTips = nil;
    imgType1 = nil;
    imgType2 = nil;
    imgType3 = nil;
    textMaxScore = nil;
    textScore = nil;
    textType1Name = nil;
    textType2Name = nil;
    textType3Name = nil;
    textReward1 = nil;
    textReward2 = nil;
    textReward3 = nil;
    textResult = nil;
    btnRestart = nil;
    btnExit = nil;
    btnStartAgain = nil;
    btnGm = nil;
    btnGMExit=nil;
    btnGMAddNumber = nil;
    sliderRewardNum = nil;
    inputField1 = nil;
    inputField2 = nil;
    dropDown1 = nil;
    dropDown2 = nil;
    dropDown3 = nil;
    Scrollbar = nil;
    eventTrigger = nil;
    rootAin = nil;
    rawImage = nil;
    gridParent = nil;
    textNowRankNumber=nil;
    goRewardGroup=nil;
    goIsAllowRevokeGroup=nil;
    textRevokeNum=nil;
    rectSpecialGroup=nil;
    btnSwitchType1=nil;
    btnSwitchType2=nil;
    btnSwitchType3=nil;
    this.co = nil;
    for i = 1, #this.numberItems do
        this.numberItems[i]:OnRecover();
        this.numberItems[i]:Destroy();
    end

    for i = 1, this.row, 1 do
        for j = 1, this.col, 1 do
            this.grids[i][j]:OnRecover();
            this.grids[i][j]:Destroy();
        end
    end

    this.numberItems = nil;
    this.grids = nil;
    this = nil;
end


this.UpdataPosition = function()
    if this == nil then
        return
    end
    for i = 1, #this.numberItems do
        this.numberItems[i]:Update();
    end
end

this.PlayAin = function(ainName)
    rootAin.enabled = false;
    rootAin.enabled = true;
    rootAin:Rebind();
    rootAin:Play(ainName);
end


this.NetRankData = function(fun)
    local data = {}
    local Url = "numberMerge/rank"
    ApiMgr.Request(Url, data, true,
        function(result)
            local re = json.decode(result)
            local rankResult = re.result

            this.rankData = {};
            if type(rankResult.Self) == "table" and rankResult.Self.Rank > 0 then
                textNowRankNumber.text = tostring(rankResult.Self.Rank)
            else
                textNowRankNumber.text = ConfigMgr.LangGlobal("7069");
            end

            if type(rankResult.List) == "table" then
                table.sort(rankResult.List, function(a, b)
                    return a.Rank < b.Rank
                end)

                local num = #rankResult.List;

                if num > 20 then
                    for i = 1, 20 do
                        table.insert(this.rankData, rankResult.List[i])
                    end
                else
                    for i = 1, num do
                        table.insert(this.rankData, rankResult.List[i])
                    end
                end
            end

            if re.code == 0 then
                if fun ~= nil then
                    fun()
                end
            end
        end,
        function(failCode)
            print("EnterDungeonError,ErrorCode:", failCode)
        end,
        true
    )
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        this.AwakeInitData();
        this.AwakeInitPanel();
        MiniGame2048GamePlayFrameWorkGamePlayCueMgr.InitCueMgr(rectSpecialGroup);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", this.OnBack);
            this.InitData();
            this.InitPanel();
            this.SwitchMainPanel();
            LuaMgr.AddUpdate(this.UpdataPosition)
            this.PlayAin("UI_MiniGame2048Panel_Bg");
            this.InitDebugBtn();
            this.RefreshFirstJoinRed(1);
            HeroRedDataHelper.RefreshMiniGameRed();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.RemoveUpdate(this.UpdataPosition)
            if this.co ~= nil and (not coroutine_runner.checkIsDestory()) then
                coroutine_runner.stop(this.co)
            end
        end
    end,
    before_destroy = function(vm)
        this.Clear();
        MiniGame2048GamePlayFrameWorkGamePlayCueMgr.ClearCueMgr();
    end
}

this.RefreshFirstJoinRed=function (type)
    local config=ConfigMgr.Config.constants["GamePoint"]
    for index, value in ipairs(config) do
        if value[1]==tostring(type) and value[2]~="nil" then
PlayerPrefs.SetInt(DataMgr.Player.uid .. "#" .. value[1] .. "#" ..value[2],1);
            break;
        end
    end
end

this.UpdateArchive=function ()
    local modeId=this.openTypeValueMap[this.selectType].ID;
    local before_score = DataMgr.Player.numberMergeV2[modeId].totalScore;
    local archive=this.SaveArchive(true);
    





    local board={}
    for i,v in ipairs(this.grids) do
        for p,m in ipairs(v) do
            if m.numberObj~=nil then
                local key=this.GetReqPosByLocName(m.transform.name);
                board[tostring(key)]=m.numberObj.score>0 and m.numberObj.score or -1;
            end
        end
    end
    local stepData={
Start=0;
Ops=NumTool.GetLen(this.reqOPList)>0 and this.reqOPList or nil;
        Board=board;
        InitBoard=this.reqInitBoard
    }
    local data = {ID=modeId, Archive = json.encode(archive),Step=stepData};
    local Url = "numberMerge/archive"
    ApiMgr.Request(Url, data, true,
        function(result)
            local re = json.decode(result);
            this.SwitchMainPanel();
            this.UpdateRewardSlider();
            this.PlayAin("UI_MiniGame2048Panel_goResult_appear");
            local reward = re.result.Items
            local firstItem = nil;
            local askData = {}
            local cp_param = {
                modeId=modeId,
                isSaveArchive=true,
            };
            askData["game_uid"] = (tostring(DataMgr.Player.uid) .. "|" .. tostring(this.startTime) .. "|" .. "foundation_tearoom_hehe_end")
            askData["game_result"] = 1;
            askData["score"] = this.currentScore
            askData["before_score"] = before_score
            askData["after_socre"] = DataMgr.Player.numberMerge.totalScore
            askData["item_id"] = firstItem == nil and "" or firstItem.ID
            askData["item_num"] = firstItem == nil and "" or firstItem.Count
            askData["complete_time"] = tostring(LuaMgr.Timestamp() - this.startTime);
            askData["cp_param"] = json.encode(cp_param)
            DataReportMgr.RequestBiliData("foundation_tearoom_hehe_end", askData, nil, nil);
            this.startTime = LuaMgr.Timestamp();
        end,
        function(failCode)
        end,
        true
    )
end

this.OnBack = function()
    if goResult.gameObject.activeSelf or (not goGrid.activeSelf) then
        LuaMgr.Back();
    else
        if this.specialModelMap["isSaveArchive"] then
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, ConfigMgr.LangGlobal("7067"), this.NetDataSuccssful,this.UpdateArchive);
else
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7066"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipStr, this.NetDataSuccssful, nil)
        end
    end
end

return vm({
    hook = hook
})