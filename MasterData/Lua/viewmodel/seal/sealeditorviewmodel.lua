




require("ViewModel/Seal/SealEditor_Item")

local this = {vm=nil,
              sealItemObj=nil,
              sealUIList=nil,
};

local  sealPos={Vector2(-645,228),Vector2(-645,29),Vector2(-472,327),Vector2(-472,133),Vector2(-472,-73),
                Vector2(-302,228),Vector2(-302,29),Vector2(-129,327),Vector2(-129,133),Vector2(-129,-73),
                Vector2(45,228),Vector2(45,29),Vector2(217,327),Vector2(217,133),Vector2(217,-73),
                Vector2(387,228),Vector2(387,29),

}
local sealDataList=nil;

local tarGameObject = nil;
local tarRect = nil;

local btnResetSeal = nil;
local btnAddSeal = nil;
local btnSaveSeal = nil;
local btnPreviewSeal = nil;
local btnPopMask = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goPopSeal = nil;
local Right = nil;
local ScrollView = nil;
local tranContent = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");

    btnResetSeal = uiLink:Get("btnResetSeal"):GetComponent("Button");
    btnAddSeal = uiLink:Get("btnAddSeal"):GetComponent("Button");
    btnSaveSeal = uiLink:Get("btnSaveSeal"):GetComponent("Button");
    btnPreviewSeal = uiLink:Get("btnPreviewSeal"):GetComponent("Button");
    btnPopMask = uiLink:Get("btnPopMask"):GetComponent("Button");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goPopSeal = uiLink:Get("goPopSeal");
    Right = uiLink:Get("Right");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    this.AddRegister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil

    btnResetSeal = nil;
    btnAddSeal = nil;
    btnSaveSeal = nil;
    btnPreviewSeal = nil;
    btnPopMask = nil;
    root = nil;
    Left = nil;
    Middle = nil;
    goPopSeal = nil;
    Right = nil;
    ScrollView = nil;
    tranContent = nil;

end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnResetSeal",function()
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("15803"),function()
            this.InitSealDataList()
            this.SetSealList();
        end,nil);
    end)
    uiLink:AddClickEvent("btnAddSeal",function()
        LuaMgr.ShowLuaPanel(UIName.SealAddViewModel,sealDataList);
    end)
    uiLink:AddClickEvent("btnSaveSeal",function()
        this.SaveData()
       
    end)
    uiLink:AddClickEvent("btnPreviewSeal",function()
        SetActive(goPopSeal,true);
        this.SetPreviewSeal();
    end)
    
    uiLink:AddClickEvent("btnPopMask",function()
        SetActive(goPopSeal,false);
    end)
end




this.SaveData=function()
    local askData={Seals=sealDataList}
    ApiMgr.Request("add_friendshipSeal",askData,true,function(re)
        LuaMgr.Back();
    end,nil,true);
end



local data={
    sealList={
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
        {isOn=false,texture=DefaultTexture},
    },
}








local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.sealItemObj=vm.behaviour.transform:Find("template/sealItem").gameObject;
        this.sealUIList=UIListView.New(tranContent);
     
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            SetActive(goPopSeal,false);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        this.sealUIList:Clear();
      
    end,
    before_destroy=function()
        this.Clear()
        UIListView.ClearItem("SealEditor_Item")
    end
}

this.ParseData=function()
    this.UpdateSealData()
    this.SetSealList();
    
end


this.InitSealDataList=function(friendShipSeal)
    sealDataList={};
    for i=1,17,1 do
        if not IsNull(friendShipSeal) and friendShipSeal~=nil and #friendShipSeal>0 and i<=#friendShipSeal then
            table.insert(sealDataList,friendShipSeal[i])
        else
            table.insert(sealDataList,"")
        end
    end
end


this.UpdateSealData=function()
    if HeroParameter.sealChangeList==nil or #HeroParameter.sealChangeList==0 then
        this.InitSealDataList(DataMgr.Player.friendShipSeal)
        return
    end
    this.InitSealDataList(HeroParameter.sealChangeList);
    HeroParameter.sealChangeList=nil;
end




this.SetSealList=function()
    local sealData={}
    if not IsNull(sealDataList) and sealDataList~=nil then
        for i,v in ipairs(sealDataList) do
            if v~="" then
                table.insert(sealData,ConfigMgr.Config.characterPreferences[v].friendshipTalent[10][1]);
            else
                table.insert(sealData,"");
            end
        end
    end
    local list={}
    for i=1,17,1 do
        local sealItem={
            index=i,
            pos=sealPos[i];
            scale=(i==4 or i==9 or i==14) and 0.8 or 0.5;
            isActive=sealData[i]~="";
            rawTexture=sealData[i]~="" and LuaMgr.GetTexture(Path.Image.."FriendlyIcon/friendly_"..sealData[i]..".png") or DefaultTexture;
            callBack=this.SealItemClickCallBack;
        }
        local sealData=UIListData.GetData(this.sealItemObj,"SealEditor_Item",sealItem);
        table.insert(list,sealData);
    end
    this.sealUIList:SetData(list);
end

this.SealItemClickCallBack=function(index)
    LuaMgr.ShowLuaPanel(UIName.SealAddViewModel,sealDataList,index);
end


this.SetPreviewSeal=function()
    local sealCharacterIds=sealDataList;
    for i=1,7,1 do
        if sealCharacterIds[i]~=nil and sealCharacterIds[i]~="" then
            local iconId=ConfigMgr.Config.characterPreferences[sealCharacterIds[i]].friendshipTalent[10][1]
            this.vm.data.sealList[i].isOn=true;
            this.vm.data.sealList[i].texture=LuaMgr.GetTexture(Path.Image.."FriendlyIcon/friendly_"..iconId..".png");
        else
            this.vm.data.sealList[i].isOn=false;
        end
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})