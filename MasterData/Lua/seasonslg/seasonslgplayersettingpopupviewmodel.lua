require("SeasonSLG/EventPopUp/HeroHeadGroup")
require("SeasonSLG/EventPopUp/HeroHeadItem")
local this = {
    vm = nil,
    heroScrollView = {};
    headListGroupObj = nil;
    headItemObj = nil;

};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.goScrollView = uiLink:Get("goScrollView");
    ui.Middle = uiLink:Get("Middle");
    ui.Right = uiLink:Get("Right");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnArrow = uiLink:Get("btnArrow"):GetComponent("Button");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    ui.ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");
    ui.togMaskOther = uiLink:Get("togMaskOther"):GetComponent("Toggle");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnArrow",function()
        this.UpdatePlayerSetting(false);
        LuaMgr.HidePanel(UIName.SeasonSLGPlayerSettingPopupViewModel);
    end)
    uiLink:AddClickEvent("btnMask",function()
        this.UpdatePlayerSetting(false);
        LuaMgr.HidePanel(UIName.SeasonSLGPlayerSettingPopupViewModel);
    end)
    uiLink:AddToggleClickEvent("togMaskOther",function(isOn)
        this.isOn=isOn;
    end)
    uiLink:AddClickEvent("btnConfrim",function()

        if not SeasonSLGMapMgr.CheckPassesPayRecord() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("35116"))
            return;
        end
        if not IsNullOrEmpty(this.curCharacterId) then
            local skinId=""
            if DataMgr.Player.characters[this.curCharacterId]~=nil then
                skinId=DataMgr.Player.characters[this.curCharacterId].curSkin;
            end
            SeasonSLGAPI.OnAskSeasonalPlayerImage(this.curCharacterId,skinId,function()
                this.UpdatePlayerSetting(true);
                LuaMgr.HidePanel(UIName.SeasonSLGPlayerSettingPopupViewModel);
            end)
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGPlayerSettingPopupViewModel_0"));
        end
    end)
end

local data = {

}
local command={

}
local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour);
        this.heroScrollView=UIScrollView.New(ui.goScrollView);
        this.headListGroupObj=vm.behaviour.transform:Find("template/headListGroup").gameObject;
        this.headItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if vm.behaviour.Params.Length>0 then
            this.curSelectIndex=nil;
            this.callBack=vm.behaviour.Params[0]
            this.key=DataMgr.Player.uid.."SeasonSLGPlayerSetting";
            this.isOn=PlayerPrefs.GetInt(this.key)>0;
            ui.togMaskOther.isOn=this.isOn;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.heroScrollView:Clear();
    end,
    before_destroy = function(vm)
        this = nil;
        UIScrollView.ClearItem("HeroHeadGroup")
        UIListView.ClearItem("HeroHeadItem")
    end
}

this.UpdatePlayerSetting=function(isUpdate)
    PlayerPrefs.SetInt(this.key,this.isOn and 1 or 0);
    SeasonSLGMapMgr.isShowOtherPlayer=not this.isOn;
    this.callBack(isUpdate);
end

this.GetAllCharacter=function()
    this.jobType = HeroParameter.paramBool and HeroParameter.jobType or CharacterJob.All
    this.sortType = HeroParameter.paramBool and HeroParameter.sortType or HeroSortType.Level
    this.sequenceType = HeroParameter.paramBool and HeroParameter.sequenceType or SequenceType.FromBigToSmall
    local characters = DataMgr.Player.characters
    local heroList = {}
    for key, value in pairs(characters) do

        if ConfigCharacterMgr.GetSeasonalHeroConfig(key) then
            local tempData = {}
            local heroConfig = ConfigMgr.Config.characterTable[key]
            tempData.name = LuaMgr.GetLangText(heroConfig.namelan)
            tempData.rare = HeroMgr.GetHeroNowRare(key);
            tempData.skinId=value.curSkin;
            tempData.job=heroConfig.job
            tempData.id = heroConfig.id
            tempData.heroID = heroConfig.id
            tempData.level = value.level
            tempData.star = value.star
            tempData.createTime = value.createTime
            tempData.selectIndex = 0
            tempData.selected=false;
            tempData.isFullExtraCond=false;
            tempData.sLevel=SeasonSLGMapMgr.GetCharacterSeasonLevel(key)
            if this.jobType == CharacterJob.All or (heroConfig ~= nil and this.jobType == heroConfig.job) then
                table.insert(heroList,tempData);
            end
        end
    end

    if #heroList > 1 then
        if this.sortType == HeroSortType.Level then
            table.sort(heroList, SeasonSLGMapMgr.LevelSort)
        elseif this.sortType == HeroSortType.Rare then
            table.sort(heroList, SeasonSLGMapMgr.RareSort)
        elseif this.sortType == HeroSortType.Star then
            table.sort(heroList, SeasonSLGMapMgr.StarSort)
        elseif this.sortType == HeroSortType.Time then
            table.sort(heroList, SeasonSLGMapMgr.TimeSort)
        end
    end
    return heroList
end

this.ParseData=function()
    this.heroList=this.GetAllCharacter();
    this.SetHeroViewList();
end

this.SetHeroViewList=function()
    this.heroScrollView:Clear();
    local heroGroupList = {}
    for i = 1, #this.heroList, 4 do
        local group = {}
        for j = i, math.min(i + 3, #this.heroList) do
            table.insert(group, this.heroList[j])
        end
        table.insert(heroGroupList, group)
    end

    local list={}
    for i,v in ipairs(heroGroupList) do
        local groupList={
            groupIndex=i,
            list=v,
            headItemObj=this.headItemObj,
            callBack=this.HeadCallBack
        }
        local groupListData=UIScrollData.GetData(this.headListGroupObj,"HeroHeadGroup",493,100,groupList)
        table.insert(list,groupListData);
    end
    this.heroScrollView:SetParams(390,400)
    this.heroScrollView:SetData(list);
end

this.HeadCallBack=function(groupIndex,locIndex)
    local index=(groupIndex-1)*4+locIndex
    if this.curSelectIndex~=nil and this.curSelectIndex==index then
        return;
    end
    this.curSelectIndex=index;
    if this.lastGroupIndex~=nil and this.lastLocIndex~=nil then
        this.heroScrollView.dataList[this.lastGroupIndex].data.list[this.lastLocIndex].selected=false;
    end
    this.heroScrollView.dataList[groupIndex].data.list[locIndex].selected=true;

    this.heroScrollView:Refresh();
    this.lastGroupIndex=groupIndex;
    this.lastLocIndex=locIndex
    this.curCharacterId=this.heroList[this.curSelectIndex].id;
end


return vm({
    data = data,
    command = command,
    hook = hook
})