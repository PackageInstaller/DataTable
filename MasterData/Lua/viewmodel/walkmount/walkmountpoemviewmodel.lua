





require("ViewModel/WalkMount/WalkMount_PoemItem")
require("ViewModel/WalkMount/WalkMount_PoemRewardItem")
local this = {
    vm=nil,
    poemList=nil,
    rewardList=nil,
    poemItemObj=nil,
    rewardItemObj=nil;
    
};

local curType=nil;
local spriteTag=nil
local dataLottery=nil;
local cfgLottery=nil;
local cfgLotteryMap=nil;
local isLockNovel=false;
local redListener=nil;



local tarGameObject = nil;
local tarRect = nil;
local goods = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local textName = nil;
local textPoem = nil;
local btnAnalyse = nil;
local btnMask = nil;
local btnNovel1 = nil;
local btnClose = nil;
local imgValue = nil;
local imgProgross=nil;
local rawImageBG=nil;
local goNovelLock=nil;
local tranRewardContent = nil;
local tranPoemContent = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    goods = uiLink:Get("goods");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    textName = uiLink:Get("textName"):GetComponent("Text");
    textPoem = uiLink:Get("textPoem"):GetComponent("Text");
    btnAnalyse = uiLink:Get("btnAnalyse"):GetComponent("Button");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnNovel1 = uiLink:Get("btnNovel1"):GetComponent("Button");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    imgValue = uiLink:Get("imgValue"):GetComponent("Image");
    imgProgross=uiLink:Get("imgProgross"):GetComponent("Image");
    rawImageBG=uiLink:Get("rawImageBG"):GetComponent("RawImage");
    tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");
    tranPoemContent = uiLink:Get("tranPoemContent"):GetComponent("RectTransform");
    goNovelLock=uiLink:Get("goNovelLock").gameObject;
    redListener=uiLink:Get("btnNovel1"):GetComponent("RedIconListener");
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.WalkMountPoemViewModel)
    end)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.WalkMountPoemViewModel)
    end)
    uiLink:AddClickEvent("btnNovel1",function()
        if isLockNovel then
            local tipStr=LuaMgr.GetLangText(ConfigMgr.LangGlobal("10502"))
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,cfgLottery.Unlock[1][1]));
            return
        end
       local novelId=cfgLottery.Unlock[1][2]
        RedMgr.Singleton:FrushRedCondition("3002_"..curType)
        HeroRedDataHelper.SetWalkMountRed();
        HeroParameter.SaveMountPoem(curType,spriteTag);
        LuaMgr.HidePanel(UIName.WalkMountPoemViewModel)
        LuaMgr.PlayNovel(novelId, function()
            LuaMgr.ShowLuaPanel(UIName.WalkMountMainViewModel)
            LuaMgr.ShowLuaPanel(UIName.WalkMountPoemViewModel,HeroParameter.MountPoem.type,HeroParameter.MountPoem.tag)
        end);
    end)
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
    textPoem = nil;
    btnAnalyse = nil;
    btnMask = nil;
    btnNovel1 = nil;
    btnClose = nil;
    imgValue = nil;
    imgProgross=nil;
    rawImageBG=nil;
    tranRewardContent = nil;
    tranPoemContent = nil;
end

this.BtnClickItem_Execute=function(id)
    LuaMgr.ShowLuaPanel(UIName.WalkMountAnalyseViewModel,id,false)
end


local data = {
}


local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.poemItemObj=vm.behaviour.transform:Find("template/poemItem").gameObject;
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.poemList = UIListView.New(tranPoemContent)
        this.rewardList=UIListView.New(tranRewardContent)
        RedMgr.Singleton:RegisterViewModel(UIName.WalkMountPoemViewModel);
      
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>1 then
                curType =vm.behaviour.Params[0]
                spriteTag=vm.behaviour.Params[1]
                cfgLottery=ConfigMgr.Config.LotteryActivityMap[curType];
                cfgLotteryMap=ConfigMgr.Config.LotteryMap;
                redListener.RedId="3002_"..curType;
                this.ParseData()
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
        end
    end,
    before_destroy=function()
        
    end
        
    
}

this.ParseData=function()
    local texPath=string.format("%sWalkMount/hd_sgwcs_tc_%s_bj.png",Path.Image,spriteTag);
    local imgProName=string.format("hd_sgwcs_tc_%s_dj_jdt2",spriteTag)
    local imgValueName=string.format("hd_sgwcs_tc_%s_dj_jdt1",spriteTag)
    local novelName=string.format("hd_sgwcs_tc_%s_jq",spriteTag)
    imgProgross.sprite=LuaMgr.GetSprite("WalkMount",imgProName)
    imgValue.sprite=LuaMgr.GetSprite("WalkMount",imgValueName)
    local novelSprite=btnNovel1.gameObject:GetComponent("Image")
    novelSprite.sprite=LuaMgr.GetSprite("WalkMount",novelName);
    rawImageBG.texture=LuaMgr.GetTexture(texPath)
    dataLottery=DataMgr.Player.lottery;
    this.SetPoemList()
    this.SetRewards();
    isLockNovel=dataLottery[curType]==nil or #dataLottery[curType]~=tonumber(cfgLottery.Unlock[1][1]);
    SetActive(goNovelLock,isLockNovel)
end

this.SetPoemList=function()
    local list={};
    local completeIndex=0;
    for i,v in ipairs(cfgLottery.Content) do
        local lotteryItem=cfgLotteryMap[v];
        local lock=this.CheckReward(v);;
        if not lock then
            completeIndex=completeIndex+1;
        end
        local PoemItem= {
            index = i,
            id = v,
            spriteTag=spriteTag,
            title = LuaMgr.GetLangText(lotteryItem.NameLan),
            poem = LuaMgr.GetLangText(lotteryItem.DescriptionLan),
            isLock = lock,
            poemClick=this.BtnClickItem_Execute
        }
        local poemData=UIListData.GetData(this.poemItemObj,"WalkMount_PoemItem",PoemItem);
        table.insert(list,poemData);
    end
    this.poemList:SetData(list)
    imgValue.fillAmount=completeIndex/#cfgLottery.Content;
end

this.SetRewards=function()
    local list={};
    for i,v in ipairs(cfgLottery.Content) do
        local lotteryItem=cfgLotteryMap[v];
        local lock=this.CheckReward(v);
        local rewardItem= {
            index = i,
            id = v,
            reward=lotteryItem.Reward[1],
            isLock = lock
        }
        local rewardData=UIListData.GetData(this.rewardItemObj,"WalkMount_PoemRewardItem",rewardItem);
        table.insert(list,rewardData);
    end
    this.rewardList:SetData(list)
    
end

this.CheckReward=function(rewardId)
    if(dataLottery==nil or dataLottery[curType]==nil) then return true end;
    local rewards=dataLottery[curType];
    for i,v in ipairs(rewards) do
        if(v==rewardId) then
            return false;
        end
    end
    return true;
end

return vm({
    data = data,
    command = command,
    hook = hook
})