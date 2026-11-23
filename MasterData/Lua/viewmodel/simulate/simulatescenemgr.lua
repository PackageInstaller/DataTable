require("ViewModel/Simulate/SimulateBuilding")
require("ViewModel/Simulate/SimulateCharacter")
SimulateSceneMgr = {
orderCharacter_NPC=nil;
walk_NPCList={};
dailyCharacter_NPC=nil;
    walkNPCBuffTF=nil;
};

local cameraPos=Vector3(-13.9,20,-14);
local cameraEuler=Vector3(45,45,0);
local cameraFieldView=17;
local walkNPCIndex=1;

local this = {
    NPCListMap= {};
    rootTF = nil;
    buildDic={},
};

SimulateSceneMgr.InitData=function()
    local rootObj=UnityEngine.GameObject("Simulate");
    this.rootTF=rootObj.transform;
    this.rootTF.localScale=Vector3.one;
    this.rootTF.localPosition=Vector3.zero;
    this.rootTF.localEulerAngles =Vector3.zero;
    this.buildsTF=UnityEngine.GameObject.Find("Art/BakedObjects").transform;
    
    this.cfgSIMArchitectMap=ConfigMgr.Config.SimulateArchitectMap;
    this.cfgSIMConstants=ConfigMgr.Config.SimulateConstants;
    this.NPCListMap={};
    this.orderCharacter_NPC=nil;
    this.walk_NPCList={};
    this.pathList={};
    for i,v in pairs(ConfigMgr.Config.SimulatePositionMap) do
        if this.NPCListMap[tostring(v.Type)]==nil then
            this.NPCListMap[tostring(v.Type)]={};
        end
        table.insert(this.NPCListMap[tostring(v.Type)],v);
    end
    LuaMgr.RemoveUpdate(this.OnUpdate);
    LuaMgr.AddUpdate(this.OnUpdate);
    this.buildDic={}
    walkNPCIndex=1;
    this.SetSceneBuildings();
end

this.GetNPCPath=function()
    this.pathList={};
    local pathObj = LuaMgr.GetPrefab("Assets/_BundleResources/UI/Simulate/SimulatePaths.prefab");
    if pathObj~=nil then
        pathObj.transform:SetParent(this.rootTF, false);
        pathObj.transform.localPosition=Vector3(100,0,0);
        for i=1,pathObj.transform.childCount,1 do
            this.pathList[i]={};
            local childTF_i=pathObj.transform:GetChild(i-1);
            for j=1,childTF_i.childCount,1 do
                local pos_j=childTF_i:GetChild(j-1).localPosition
                table.insert(this.pathList[i],pos_j);
            end
        end
    end
end

this.SetSceneBuildings=function()
    for i,v in pairs(this.cfgSIMArchitectMap) do

        if v.Id~="1006" then
            local themeName,buildLevel=SimulateRoomMgr.GetBuildingThemeNameAndLevel(v.Id)
            local buildingVM=nil;
            if this.buildDic[v.Id]==nil then
                this.buildDic[v.Id]={vm=nil,level=buildLevel}
                this.buildDic[v.Id].vm=SimulateBuilding.New(this.buildsTF,v.Id);
            end
            buildingVM=this.buildDic[v.Id].vm;
            buildingVM:SetData(themeName,buildLevel);
        end
    end
end



this.OnUpdate=function()
    if not IsNull(this.walk_NPCList) and #this.walk_NPCList>0 then
        for i,v in ipairs(this.walk_NPCList) do
            v.vm:Update();
        end
    end
end


SimulateSceneMgr.Clear=function()
    walkNPCIndex=nil;
    LuaMgr.RemoveUpdate(this.OnUpdate);
    LuaMgr.RemoveTimer(TimerConst.SimulateWalkNPC)
    LuaMgr.RemoveTimer(TimerConst.SimulateMsgTip)
    SimulateSceneMgr.ClearNPC();
end

SimulateSceneMgr.ClearNPC=function()
    SimulateSceneMgr.ClearDailyRewardQSpine();
    SimulateSceneMgr.ClearSpecialOrderNPC();
    SimulateSceneMgr.ClearWalkNPC();
end


SimulateSceneMgr.UpdateCheckBuildingUpLevel=function()
    for i,v in pairs(this.cfgSIMArchitectMap) do

        if v.Id~="1006" then
            local themeName,newLevel=SimulateRoomMgr.GetBuildingThemeNameAndLevel(v.Id)
            if this.buildDic[v.Id].level<newLevel then
                this.buildDic[v.Id].vm:UpLevel(newLevel);
                this.buildDic[v.Id].level=newLevel
            end
        end
    end
end


SimulateSceneMgr.DailyRewardQSpine=function(uiTF,callBack)
    if this.dailyCharacter_NPC==nil then
        this.dailyCharacter_NPC =SimulateCharacter.New(this.rootTF)
        local cfgNPC=this.NPCListMap["1"][1];
        local pos=Vector3(tonumber(cfgNPC.Positioning[1]),0,tonumber(cfgNPC.Positioning[2]));
        local randomIndex=math.random(#cfgNPC.Random)
        local chId=cfgNPC.Random[randomIndex];
        this.dailyCharacter_NPC:SetData("daily",chId,chId.."001",pos);
        this.dailyCharacter_NPC:SetBuffer(uiTF,1,function()
            SimulateRoomMgr.OnAskDailyRandomReward(function()
                SimulateSceneMgr.ClearDailyRewardQSpine();
                if callBack~=nil then
                    callBack();
                end
            end)
        end);
    end
    return this.dailyCharacter_NP;
end
SimulateSceneMgr.ClearDailyRewardQSpine=function()
    if this.dailyCharacter_NPC~=nil then
        this.dailyCharacter_NPC:Clear();
    end
    this.dailyCharacter_NPC=nil;
end


SimulateSceneMgr.SpecialOrderQSpine=function(uiTF,orderList)

    if #orderList==0 then
        if this.orderCharacter_NPC~=nil then
            this.orderCharacter_NPC:Clear();
        end
        return;
    end
    if this.orderCharacter_NPC==nil then
        local cfgNpc=this.NPCListMap["2"][1];
        local pos=Vector3(tonumber(cfgNpc.Positioning[1]),0.5,tonumber(cfgNpc.Positioning[2]));
        this.orderCharacter_NPC=SimulateCharacter.New(this.rootTF)
        local randomIndex=math.random(#cfgNpc.Random)
        local chId=cfgNpc.Random[randomIndex];
        this.orderCharacter_NPC:SetData(orderList[1],chId,chId.."001",pos);
        this.orderCharacter_NPC:SetBuffer(uiTF,2,function()
            LuaMgr.ShowLuaPanel(UIName.SimulateOrderSpecialViewModel)
        end);
    end
end


SimulateSceneMgr.ClearSpecialOrderNPC=function()
    if this.orderCharacter_NPC~=nil then
        this.orderCharacter_NPC:Clear();
    end
    this.orderCharacter_NPC=nil;
end


SimulateSceneMgr.SetWalkNPC=function(uiTF)
    if #this.walk_NPCList>0 or  IsNull(this.NPCListMap) or #this.NPCListMap["3"]==0 then
        return;
    end
    if #this.pathList==0 then
        this.GetNPCPath();
    end
    SimulateSceneMgr.walkNPCBuffTF=uiTF;
    math.randomseed(LuaMgr.Timestamp())
    LuaMgr.RemoveTimer(TimerConst.SimulateWalkNPC)
    LuaMgr.AddTimer(TimerConst.SimulateWalkNPC, SimulateSceneMgr.UpdateWalkNPC, 15, -1, true);


















end

SimulateSceneMgr.UpdateWalkNPC=function()
    local index=walkNPCIndex%#this.NPCListMap["3"];
    local curCfgPNC=this.NPCListMap["3"][index+1];
    local walkNPC=SimulateCharacter.New(this.rootTF);
    local randomIndex=math.random(#curCfgPNC.Random)
    local chId=curCfgPNC.Random[randomIndex];
    local pathList=this.pathList[index+1];
    walkNPC:SetData("walk_"..index+1,chId,chId.."001",pathList[1],LuaMgr.GetLangText(curCfgPNC.MsgLan));
    walkNPC:SetPath(walkNPCIndex,pathList,60,false,SimulateSceneMgr.walkNPCBuffTF);
    table.insert(this.walk_NPCList,{index=walkNPCIndex,vm=walkNPC});
    walkNPCIndex=walkNPCIndex+1;
end

SimulateSceneMgr.RemoveWalkNPC=function(index)
    if #this.walk_NPCList==0 then return end;
    for i=#this.walk_NPCList,1,-1 do
        if this.walk_NPCList[i].index==index then
            table.remove(this.walk_NPCList,i);
        end
    end
end
SimulateSceneMgr.ClearWalkNPC=function()
    LuaMgr.RemoveTimer(TimerConst.SimulateWalkNPC);
    if not IsNull(this.walk_NPCList) and #this.walk_NPCList>0 then
        for i,v in ipairs(this.walk_NPCList) do
            v.vm:Clear();
        end
    end
    this.walk_NPCList={}
end













