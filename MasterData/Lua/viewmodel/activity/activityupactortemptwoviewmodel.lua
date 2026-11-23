





require("ViewModel/Activity/Upactor_goodItem")

local this = {vm=nil,
              rewardUIList=nil,
              rewardItemObj=nil,

};
local spineCharacter=nil;
local characterId=nil;
local dungeonId=nil;
local drawingAdjustTool=nil;
local curCardPool=nil;

local tarGameObject = nil;
local tarRect = nil;
local goods = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local textName = nil;
local textTime = nil;
local textChName = nil;
local tranContent = nil;
local btnJump = nil;
local btnDetail = nil;
local imgJob = nil;
local btnGotoBtn = nil;
local rawImageHead = nil;
local textTip1 = nil;
local textTip2 = nil;
local videoName = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");

    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    textName = uiLink:Get("textName"):GetComponent("Text");
    textTime = uiLink:Get("textTime"):GetComponent("Text");
    textChName = uiLink:Get("textChName"):GetComponent("Text");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    btnJump = uiLink:Get("btnJump"):GetComponent("Button");
    btnDetail = uiLink:Get("btnDetail"):GetComponent("Button");
    imgJob = uiLink:Get("imgJob"):GetComponent("Image");
    btnGotoBtn = uiLink:Get("btnGotoBtn"):GetComponent("Button");
    rawImageHead = uiLink:Get("rawImageHead"):GetComponent("RawImage");
    textTip1 = uiLink:Get("textTip1"):GetComponent("Text");
    textTip2 = uiLink:Get("textTip2"):GetComponent("Text");
    this.AddRegister(uiLink)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    goods = nil;
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    textName = nil;
    textTime = nil;
    textChName = nil;
    tranContent = nil;
    btnJump = nil;
    btnDetail = nil;
    imgJob = nil;
    btnGotoBtn = nil;
    rawImageHead = nil;
    textTip1 = nil;
    textTip2 = nil;
    videoName = nil;
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnDetail",function()
        LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",characterId);
    end)
    uiLink:AddClickEvent("btnJump",function()
        LuaMgr.HidePanel(UIName.ActivityUpactorTempTwoViewModel)
        BattlePrepareMgr.EnterBattlePrepare(dungeonId,dungeonId);
        HeroParameter.SaveActivityKey(ActivityKey.UpactorTwo)
    end)
    uiLink:AddClickEvent("btnGotoBtn",function()
        LuaMgr.ShowLuaPanel(UIName.PlayVideoViewModel,videoName)
    end)
end


local data = {
  bodyPath="";
}

local command = {
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour);
        spineCharacter =vm.behaviour.transform:Find("root/Middle/Bg/Character/Body"):GetComponent("UISpineCharacter");
        drawingAdjustTool=vm.behaviour.transform:Find("root/Middle/Bg/Character/Body"):GetComponent("DrawingAdjustTool");
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.rewardUIList=UIListView.New(tranContent);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            curCardPool=ConfigHelper.GetCurCardPoolsData()
            if #curCardPool>1 then
                characterId=curCardPool[2].characterShow[1];
                dungeonId="UP"..characterId;
                if TableIsNull(curCardPool[2].moveShow) then
                    videoName = ""
                else
                    videoName = "UP_"..characterId
                end
            end
            if characterId==nil or dungeonId==nil  then return end;
            HeroParameter.EmptyActivityKey()
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if spineCharacter~=nil then
            spineCharacter:Clear();
        end
    end,
}

this.SetCharacter=function()
    local skinId = characterId.."001";
    local path = HeroManager.SetCharacterDrawing( spineCharacter, characterId,skinId);
    if path ~= "" then
        this.vm.data.bodyPath=path;
    end
    local cfgCharacter=ConfigMgr.Config.characterTable[characterId];
    textName.text=LuaMgr.GetLangText(cfgCharacter.namelan);
    textChName.text=LuaMgr.GetLangText(cfgCharacter.namelan);
    imgJob.sprite=LuaMgr.GetSprite("JobIcon","job2_"..cfgCharacter.job);
    rawImageHead.texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(characterId,skinId))
end


this.ParseData=function()
    SetActive(btnGotoBtn.gameObject,not IsNullOrEmpty(videoName))
    this.SetCharacter();
    this.SetRewards();
    this.SetTimer();
    this.SetLanguageText();
end

this.SetRewards=function()
    local dungeon=ConfigMgr.Config.dungeonMap[dungeonId];
    local dungeonRecord=DataMgr.Player.dungeonRecords[dungeonId];
    local isPass=dungeonRecord~=nil and dungeonRecord.completeCount>0;
    local rewardMap={}
    if IsNull(dungeon) then return end;
    for i,v in ipairs(dungeon.firstDrop) do
        local items=ConfigMgr.Config.dropMap[v.id].items;
        for p,m in ipairs(items) do
            if rewardMap[m.id]==nil then
                rewardMap[m.id]=m.count;
            else
                rewardMap[m.id]=rewardMap[m.id]+m.count;
            end
        end
    end
    local rewardList={}
    for i,v in pairs(rewardMap) do
        local rare=ConfigMgr.Config.itemMap[i].rare;
        table.insert(rewardList,{id=i,count=v,rare=rare})
    end
    table.sort(rewardList,function(a, b) return a.rare>b.rare end)
    local list={}
    for i,v in ipairs(rewardList) do
        local rewardItem={
            id=v.id,
            count=v.count,
            isPass=isPass,
            scale=0.6,
            isCount=true,
        }
        local rewardData=UIListData.GetData(this.rewardItemObj,"Upactor_goodItem",rewardItem);
        table.insert(list,rewardData)
    end
    this.rewardUIList:SetData(list);
end


this.SetTimer=function()
    if #curCardPool>1 then
        local remainTime=curCardPool[2].endTime-LuaMgr.Timestamp();
        local d, h, m = GetTimeDHM2(remainTime);
        textTime.text=string.format(ConfigMgr.LangGlobal("15506"),d,h,m);
    end
end

this.SetLanguageText = function()
    textTip1.text = ConfigMgr.LangGlobal("10222")
    textTip2.text = ConfigMgr.LangGlobal("10223")
end

return vm({
    data = data,
    command = command,
    hook = hook
})