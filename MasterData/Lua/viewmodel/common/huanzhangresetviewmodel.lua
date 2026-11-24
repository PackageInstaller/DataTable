require("ViewModel/Common/HuanZhang_HeadGroup")
require("ViewModel/Common/HuanZhang_HeadItem")
local this = {
    heroUIView = nil,
    heroItemObj = nil,
    heroGroupItemObj=nil;
    col=6;
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.Middle = uiLink:Get("Middle");
    ui.goScrollView = uiLink:Get("goScrollView");
    ui.goNotCharacter = uiLink:Get("goNotCharacter");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.HuanZhangResetViewModel);
    end)
    uiLink:AddClickEvent("btnConfrim",function()
        if IsNullOrEmpty(this.heroId) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("HuanZhangResetViewModel_0"))
            return;
        end
        local heroCfg=ConfigMgr.Config.characterTable[this.heroId];
        local heroName=LuaMgr.GetLangText(heroCfg.namelan);
        local tip=string.format(ConfigMgr.LangGlobal("35168"),heroName);
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tip,function()
            local data={
                CharacterId=this.heroId
            }
            ApiMgr.Request("brilliant/restart",data,true,function(result)
                ConfigHelper.ShowCommonItemReward(result);
                LuaMgr.HidePanel(UIName.HuanZhangResetViewModel);
                LuaMgr.InvokeUIEventListeners(UIEventConst.PropUse,"3412");
            end,nil,true)
        end,nil);
    end)
end

local data ={}
local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
        this.heroUIView=UIScrollView.New(ui.goScrollView);
        this.heroGroupItemObj=vm.behaviour.transform:Find("template/headGroup").gameObject;
        this.heroItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.ParseData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.heroUIView:Clear();
    end,
    before_destroy = function()
        this.ClearUI();
        UIScrollView.ClearItem("HuanZhang_HeadGroup")
        UIListView.ClearItem("HuanZhang_HeadItem");
    end
}

this.ParseData=function()
    this.curRowIndex=nil;
    this.curColIndex=nil;
    this.heroId=nil;
    this.SetHZHeroList();
    this.SetHeroViewList();
end

this.SetHZHeroList=function()
    this.hzHeroList={}
    for i,v in pairs(DataMgr.Player.characters) do
        if not IsNull(v.brilliant) and v.brilliant.RareLevel>0 then
            local heroCfg=ConfigMgr.Config.characterTable[v.id]
            if heroCfg~=nil then
                local heroData={
                    id=v.id,
                    skin=v.curSkin,
                    rare=HeroMgr.GetHeroNowRare(v.id),
                    job=heroCfg.job,
                    level=v.level,
                    isSelect=false,
                    name=LuaMgr.GetLangText(heroCfg.namelan)
                }
                table.insert(this.hzHeroList,heroData)
            end
        end
    end
    if #this.hzHeroList>0 then
        table.sort(this.hzHeroList,function(a, b)
            if a.rare==b.rare then
                return a.level>b.level;
            else
                return a.rare>b.rare;
            end
        end);
    end
end

this.SetHeroViewList=function()
    this.heroUIView:Clear();
    if #this.hzHeroList==0 then

        SetActive(ui.goNotCharacter,true);
        return ;
    end
    SetActive(ui.goNotCharacter,false);

    this.groupList=NumTool.ListToListGroup(this.hzHeroList,this.col);
    local list={}
    for i,vList in ipairs(this.groupList) do
        local groupItem={
            index=i,
            dataList=vList,
            headItemObj=this.heroItemObj,
            callBack=this.HeadCallBack,
        }
        local groupData=UIScrollData.GetData(this.heroGroupItemObj,"HuanZhang_HeadGroup",600,100,groupItem);
        table.insert(list,groupData);
    end
    this.heroUIView:SetParams(600,314);
    this.heroUIView:SetData(list);
end

this.HeadCallBack=function(rowIndex,colIndex,heroId)
    if this.curRowIndex~=nil and this.curColIndex~=nil then
        this.heroUIView.dataList[this.curRowIndex].data.dataList[this.curColIndex].isSelect=false;
    end
    this.heroUIView.dataList[rowIndex].data.dataList[colIndex].isSelect=true;
    this.heroUIView:Refresh()
    this.curRowIndex=rowIndex;
    this.curColIndex=colIndex;
    this.heroId=heroId;
end


return vm({
    data = data,
    command = command,
    hook = hook
})