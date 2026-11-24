
require("SeasonSLG/SeasonSLGHeroTalentItem")
local this = {
   talentUIList={};
   talentItemObj=nil;
   tabNames={"Personal", "Guild", "Talent"};
   tabToggleNodes={};
   isChangingTab=false;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Middle = uiLink:Get("Middle");
    ui.goAlentDetails = uiLink:Get("goAlentDetails");
    ui.goArrow = uiLink:Get("goArrow");
    ui.goDescBG2 = uiLink:Get("goDescBG2");
    ui.goItemParent = uiLink:Get("goItemParent");
    ui.goGotObj = uiLink:Get("goGotObj");
    ui.goPersonGroup = uiLink:Get("goPersonGroup");
    ui.goUnlockFlag = uiLink:Get("goUnlockFlag");
    ui.Right = uiLink:Get("Right");
    ui.btnBg = uiLink:Get("btnBg"):GetComponent("Button");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.imgTalentIcon = uiLink:Get("imgTalentIcon"):GetComponent("Image");
    ui.txtName1 = uiLink:Get("txtName1"):GetComponent("Text");
    ui.txtName2 = uiLink:Get("txtName2"):GetComponent("Text");
    ui.txtCurDesc = uiLink:Get("txtCurDesc"):GetComponent("Text");
    ui.txtNextDesc = uiLink:Get("txtNextDesc"):GetComponent("Text");
    ui.txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    ui.txtBtnName = uiLink:Get("txtBtnName"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.rawCostIcon = uiLink:Get("rawCostIcon"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
   ui = nil
end

this.SetMainTab = function(index, value)
    if value == false then return end
    this.isChangingTab = true
    for i, node in ipairs(this.tabToggleNodes) do
        local on = i == index
        node.toggle.isOn = on
        node:SetIsOn(on)
    end
    this.isChangingTab = false
end

this.ClickPageToggle = function(index, value)
    if index == SeasonSLGConst.TechType.Guild and PlayerGuildMgr.HaveGuild() == false then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("SeasonSLGHeroTalentViewModel_0"))
        this.SetMainTab(SeasonSLGConst.TechType.Person)
        return
    end
    if value ~= true or this.isChangingTab then return end
    if index == SeasonSLGConst.TechType.Talent then
        this.SetMainTab(SeasonSLGConst.TechType.Talent, true)
        return
    end
    LuaMgr.ShowLuaPanel(UIName.SeasonSLGTechPanel, index)
end

this.InitPageTabs = function(vm)
    local tabRoot = vm.behaviour.transform:Find("root/Left/Tab")
    if tabRoot == nil then return end
    local group = tabRoot:GetComponent(UITool.ToggleGroup)
    for i, name in ipairs(this.tabNames) do
        local go = tabRoot:Find(name)
        if go ~= nil then
            local node = CommonToggleItem.New(go.gameObject, nil, false, i, this.ClickPageToggle, group)
            node:SetData({})
            table.insert(this.tabToggleNodes, node)
        end
    end
    this.SetMainTab(SeasonSLGConst.TechType.Talent, true)
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnConfrim",function()
        if this.characterId==nil or this.talentInfo==nil then return end;
        if not this.isUnlock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("SeasonSLGHeroTalentViewModel_1"))
            return;
        end
        if not this.isCanExamine then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("SeasonSLGHeroTalentViewModel_2"))
            return;
        end
        SeasonSLGAPI.OnAskSeasonalCharacterTalent(this.characterId_S,this.talentInfo.Id,function()
            this.ParseData();
            this.SetTalentItemInfo()
        end);
    end)







    uiLink:AddClickEvent("btnBg",function()
        this.CancelCurSelect();
    end)

end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.InitPageTabs(vm)
        this.talentUIList=UIListView.New(ui.tranContent)
        this.talentItemObj=vm.behaviour.transform:Find("template/talentItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        SetActive(ui.goAlentDetails,false);
        this.characterId=SeasonSLGMapMgr.curSeasonal.SeasonalHero;
        if this.characterId==nil then
            this.characterId="V0055";
        end
        this.curIndex=nil;
        this.ParseCfg();
        this.ParseData();
        this.SetMainTab(SeasonSLGConst.TechType.Talent, true)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.talentUIList:Clear();
    end,
    before_destroy = function()
        this.tabToggleNodes = {}
        this.ClearUI();
        UIListView.ClearItem("SeasonSLGHeroTalentItem")
    end
}


this.ParseCfg=function()
    this.cfgTalentList={};
    for i,v in pairs(ConfigMgr.Config.SeasonalTalentMap) do
        if v.CharacterId==this.characterId then
            table.insert(this.cfgTalentList,v);
        end
    end
    table.sort(this.cfgTalentList,function(a, b)
        return a.Id<b.Id;
    end)
end

this.ParseData=function()
    this.dataTalents={};
    local seasonHero = ConfigCharacterMgr.GetSeasonalHeroConfig(this.characterId)
    this.characterId_S=seasonHero.Id;
    local dataCharacter=DataMgr.Player.SeasonalCharacters[seasonHero.Id]
    if dataCharacter~=nil  and not IsNull(dataCharacter.Talents) then
        this.dataTalents=dataCharacter.Talents;
    end
    this.SetTalentUIList();
end

this.SetTalentUIList=function()
    this.talentUIList:Clear()
    if #this.cfgTalentList==0 then return end;
    local list={}
    for i,v in ipairs(this.cfgTalentList) do
        local serLevel=this.dataTalents[v.Id]==nil and 0 or this.dataTalents[v.Id];
        local talentItem={
            index=i,
            isUnLock=#v.PrefixId==0 or this.dataTalents[v.PrefixId[1]]~=nil,
            name=this.GetTalentName(v,serLevel);
            curLevel=serLevel,
            maxLevel=v.MaxLevel,
            iconName=v.Image,
            isSelect=this.curIndex==i,
            callBack=this.TalentItemCallBack,
            isRed=false;
        }
        local level=serLevel==0 and 1 or serLevel;
        if talentItem.isUnLock and talentItem.curLevel<talentItem.maxLevel and
                DataHelper.GetItemCountById(tostring(v.RequireItems))>=v.RequireItemsNum[level] then
            talentItem.isRed=true;
        end
        local talentData=UIListData.GetData(this.talentItemObj,"SeasonSLGHeroTalentItem",talentItem);
        table.insert(list,talentData);
    end
    this.talentUIList:SetData(list);
end

this.TalentItemCallBack=function(index)
    if this.curIndex==index then return end;
    if this.curIndex~=nil then
        this.talentUIList.itemList[this.curIndex].data.isSelect=false;
    end
    this.curIndex=index;
    this.talentUIList.itemList[index].data.isSelect=true;
    this.talentUIList:Refresh();
    this.SetTalentItemInfo();
end

this.CancelCurSelect=function()
    SetActive(ui.goAlentDetails,false);
    if this.curIndex~=nil then
        this.talentUIList.itemList[this.curIndex].data.isSelect=false;
        this.talentUIList:Refresh();
    end
    this.curIndex=nil;
end

this.SetTalentItemInfo=function()
    SetActive(ui.goAlentDetails,true);
    this.talentInfo=this.cfgTalentList[this.curIndex]
    ui.imgTalentIcon.sprite=LuaMgr.GetSprite("SeasonSLGAtlas",this.talentInfo.Image);


    this.isUnlock=false;
    if #this.talentInfo.PrefixId==0 then
        this.isUnlock=true;
    else
        local unlockTalentInfo=ConfigMgr.Config.SeasonalTalentMap[this.talentInfo.PrefixId[1]]
        this.isUnlock=this.dataTalents[unlockTalentInfo.Id]~=nil
    end
    local talentLV=this.dataTalents[this.talentInfo.Id]==nil and 0 or this.dataTalents[this.talentInfo.Id];

    local isAlready=talentLV>=this.talentInfo.MaxLevel;
    ui.txtBtnName.text=talentLV>0 and not isAlready and LuaMgr.GetLangText("SeasonSLGHeroTalentViewModel_3") or LuaMgr.GetLangText("SeasonSLGHeroTalentViewModel_4")
    SetActive(ui.goUnlockFlag,isAlready)
    SetActive(ui.goPersonGroup,not isAlready);
    SetActive(ui.goItemParent,not isAlready);
    local curDesLevel=talentLV==0 and 1 or talentLV;
    ui.txtCurDesc.text=this.GetBuffOrTalentName(this.talentInfo,curDesLevel);
    ui.txtName1.text=this.GetTalentName(this.talentInfo,talentLV);
    SetActive(ui.goDescBG2,false);
    SetActive(ui.txtName2.gameObject,not isAlready)
    SetActive(ui.goArrow,not isAlready);
    SetActive(ui.goItemParent,not isAlready)
    if talentLV>0 and not isAlready then
        SetActive(ui.goDescBG2,true);
        ui.txtNextDesc.text=this.GetBuffOrTalentName(this.talentInfo,talentLV+1);
    end
    this.isCanExamine=false;
    if not isAlready then
        ui.txtName2.text=this.GetTalentName(this.talentInfo,talentLV+1);
        local itemId=tostring(this.talentInfo.RequireItems);
        ui.rawCostIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(itemId))
        local myCount=DataHelper.GetItemCountById(itemId);
        local maxCount=this.talentInfo.RequireItemsNum[talentLV==0 and 1 or talentLV];
        this.isCanExamine=myCount>=maxCount;
        ui.txtCostCount.text=string.format("<color=#CF64C9>%s</color>/%s",myCount,maxCount)
        SetActive(ui.goGotObj,this.isCanExamine);
    end

end

this.GetTalentName=function(talentInfo,lv)
    local name=LuaMgr.GetLangText(talentInfo.NameLan)
    if lv==0 then
        return name;
    elseif lv==1 then
        return name.."I";
    elseif lv==2 then
        return name.."II";
    elseif lv==3 then
        return name.."III";
    end
end


this.GetBuffOrTalentName=function(talentInfo,lv)
    if IsNull(talentInfo.TalentId) or #talentInfo.TalentId==0 then
        local buffId=talentInfo.BuffId[lv]
        local buffCfg=ConfigMgr.Config.SeasonalBuffMap[buffId]
        if buffCfg~=nil then
            return LuaMgr.GetLangText(buffCfg.BuffDesLan)
        end
    else
        local cfgTalentBank=ConfigMgr.Config.talentBankMap[talentInfo.TalentId[lv]];
        if cfgTalentBank~=nil then
            return LuaMgr.GetLangText(cfgTalentBank.DescriptionLan)
        end
    end
end

this.SetItemCost=function(talentInfo,lv)
    if this.material==nil then
        this.material=MaterialItem.New(ui.tranGoods);
    end
    this.material:SetData(1, tostring(talentInfo.RequireItems), talentInfo.RequireItemsNum[lv], 0.65)
end
return vm({
    data = data,
    command = command,
    hook = hook
})