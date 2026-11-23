





require("ViewModel/AreaDaily/Squal_HeadItem")

local this = { vm = nil,
               headUIList = nil,
               headItemObj = nil,
}
local jointCharacterList={}


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnmask = nil;
local ScrollView = nil;
local tranContent = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    btnmask = uiLink:Get("btnmask"):GetComponent("Button");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    this.AddRegister(uiLink)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnmask = nil;
    ScrollView = nil;
    tranContent = nil;

end




this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnmask",function()
        LuaMgr.HidePanel(UIName.AreaSqualJointViewModel)
    end)
end

this.HeadItemClick=function(index)
    local chId=jointCharacterList[index].id
    LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",chId);
end

local data = {

}

local command = {
 


}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.headUIList=UIListView.New(tranContent);
        this.headItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end
        
        this.ParseData();
    end,
    before_deactive = function(vm)
       
    end,
    before_destroy=function(vm)
      
    end
}



this.ParseData=function()
    jointCharacterList={}
    for i,v in pairs(DataMgr.Player.moreModAssist) do
        local rare=ConfigMgr.Config.characterTable[i].rare
        local nameLan=ConfigMgr.Config.characterTable[i].namelan;
        local jointItem={id=i,rare=rare,nameLan=nameLan}
        table.insert(jointCharacterList,jointItem)
    end
    table.sort(jointCharacterList,function(a, b) return a.rare>b.rare end)
    this.SetHeadList();
end

this.SetHeadList=function()
    local list={}
    for i,v in ipairs(jointCharacterList) do
        local jointItem={
            index=i,
            id=v.id,
            name=LuaMgr.GetLangText(v.nameLan),
            rare=v.rare,
            callBack=this.HeadItemClick,
        }
        local jointData=UIListData.GetData(this.headItemObj,"Squal_HeadItem",jointItem);
        table.insert(list,jointData);
    end
    this.headUIList:SetData(list);
end

return vm({
    data = data,
    command = command,
    hook = hook
})