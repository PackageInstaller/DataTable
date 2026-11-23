





require("ViewModel/AreaDaily/Squal_TeachingItem")

local this = { vm = nil,
               teachingUIList = nil,
               teachingItemObj = nil,
}

local cfgTeachingList=nil;
local dataDungeonRecords=nil;


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnMask = nil;
local ScrollView = nil;
local tranContent = nil;
local btnReset=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnReset=uiLink:Get("btnReset"):GetComponent("Button");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    this.AddRegister(uiLink);
    
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnMask = nil;
    ScrollView = nil;
    tranContent = nil;
    btnReset=nil;

end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.AreaSqualTeachingViewModel)
    end)

    uiLink:AddClickEvent("btnReset",function()
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("2724"),function()
            this.ResetTeachingLevel();
        end,nil);
       
    end)
    
end



this.ResetTeachingLevel=function()
    local matchData={Theme="JX"}
    ApiMgr.Request("moremod/reset_progress",matchData,true,function(result)
        dataDungeonRecords=DataMgr.Player.dungeonRecords;
        this.SetTeachingList();
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2725"))
    end,nil,true)
end


this.TeachingLevelClick=function(index)
    local moreModId=cfgTeachingList[index].Id
    local guidDungeon=DataMgr.Player.guideMoreModData.Dungeons[moreModId];
    if guidDungeon.Score>0 then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2234"].NameLan),function()
            LuaMgr.HidePanel(UIName.AreaSqualTeachingViewModel)
            LuaMgr.ShowLuaPanel(UIName.AreaSqualEntryViewModel,moreModId,2);
        end,nil);
        return;
    end
    LuaMgr.HidePanel(UIName.AreaSqualTeachingViewModel)
    LuaMgr.ShowLuaPanel(UIName.AreaSqualEntryViewModel,moreModId,2);
    HeroParameter.moremodeTeaching=1;
end

local data = {

}

local command = {
 


}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.teachingUIList=UIListView.New(tranContent);
        this.teachingItemObj=vm.behaviour.transform:Find("template/teachingItem").gameObject;
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end
        cfgTeachingList={};
        for i,v in pairs(ConfigMgr.Config.moreModMap) do
            if v.Group=="JX" then
                table.insert(cfgTeachingList,v);
            end
        end
        table.sort(cfgTeachingList,function(a, b) return a.Id<b.Id end)
        if not this.CheckIsRewardBox() then
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
       
    end,
    before_destroy=function(vm)
      
    end
}



this.CheckIsRewardBox=function()
    local dungeonId=nil;
    if IsNull(DataMgr.Player.guideMoreModData.Dungeons) then return end;
    for i,v in pairs(DataMgr.Player.guideMoreModData.Dungeons) do
        if tonumber(v.Score)>0 and DataMgr.Player.guideMoreModData.Box[v.Id]==nil then
            dungeonId=v.Id;
            break;
        end
    end
    if dungeonId~=nil then
        this.OnAskRewardBox(dungeonId);
    end
    return dungeonId~=nil;
end

this.OnAskRewardBox=function(dungeonId)
    SetActive(root,false)
    local matchData={Id=dungeonId};
    ApiMgr.Request("moremod/draw_box_reward",matchData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        SetActive(root,true)
        LuaMgr.ShowItemRewared(data);
        this.ParseData();
    end,nil,true)
end


this.ParseData=function()
    ApiMgr.Request("moremod/open_jx_theme", { } ,true,function(result)
        local re=json.decode(result);
        UnityEngine.PlayerPrefs.SetInt("open_theme",0);
        this.SetTeachingList();
    end,nil,true)
    dataDungeonRecords=DataMgr.Player.dungeonRecords;
end

this.SetTeachingList=function()
    local list={}
    for i,v in ipairs(cfgTeachingList) do
        local tRare="";
        if dataDungeonRecords[v.DungeonIDs[1]]~=nil and dataDungeonRecords[v.DungeonIDs[1]].completeCount>0 then
            tRare=dataDungeonRecords[v.DungeonIDs[1]].historyRating;
        end
        local teachingItem={
            index=i,
            name=LuaMgr.GetLangText(v.NameTextLan),
            rare=tRare,
            passScore=DataMgr.Player.guideMoreModData.Dungeons[v.Id].Score;
            callBack=this.TeachingLevelClick,
            isUnLock=v.RequireID=="" or DataMgr.Player.guideMoreModData.Dungeons[v.RequireID].Score>0
        }
        local teachingData=UIListData.GetData(this.teachingItemObj,"Squal_TeachingItem",teachingItem);
        table.insert(list,teachingData);
    end
    this.teachingUIList:SetData(list);
end

return vm({
    data = data,
    command = command,
    hook = hook
})