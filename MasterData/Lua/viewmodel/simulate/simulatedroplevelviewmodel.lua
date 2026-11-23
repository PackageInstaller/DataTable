require("ViewModel/Simulate/Simulate_DropLevelItem")
require("ViewModel/Simulate/SimulateDropMat")

local this = {
    vm = nil,
    levelUIList={};
    levelItemObj=nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranLevelContent = uiLink:Get("tranLevelContent"):GetComponent("RectTransform");
    ui.btnBook = uiLink:Get("btnBook"):GetComponent("Button");
    this.AddRegister(uiLink)
end

this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnBook",function()
       LuaMgr.ShowLuaPanel(UIName.SimulateDropBookViewModel);
   end)
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.levelUIList=UIListView.New(ui.tranLevelContent);
        this.levelItemObj=vm.behaviour.transform:Find("template/levelItem").gameObject;
        RedMgr.Singleton:RegisterViewModel(UIName.SimulateDropLevelViewModel)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.levelList={}
            for i,v in pairs(ConfigMgr.Config.SimulateCatchGameMap) do
                table.insert(this.levelList,v);
            end
            table.sort(this.levelList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
            SimulateRoomMgr.CheckDropGameRed();
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.levelUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_DropLevelItem")
    end
}

this.ParseData=function()
    this.dataBuild_1001= {};
    if not IsNull(DataMgr.Player.SimulateArchitect.SimulateBuilds) then
        if DataMgr.Player.SimulateArchitect.SimulateBuilds["1001"]~=nil then
            this.dataBuild_1001=DataMgr.Player.SimulateArchitect.SimulateBuilds["1001"];
        end
    end
    this.dataGame=DataMgr.Player.SimulateGame;
    this.SetLevelUIList();
end

this.SetLevelUIList=function()
    this.levelUIList:Clear();
    local list={};
    for i,v in ipairs(this.levelList) do
        local lock,lockInfo=this.GetLockInfo(v);
        local cpos=this.GetDefaultPos(i);
        if not IsNull(v.Pos) then
            cpos=Vector2(tonumber(v.Pos[1]),tonumber(v.Pos[2]));
        end
        local levelItem={
            index=i,
            pos=cpos,
            name=LuaMgr.GetLangText(v.NameLan),
            lockInfo=lockInfo,
            isLock=lock,
            matList=v.Material;
            red="17308_"..v.Id;
            callBack=this.LevelCallBack,
        }
        local levelData=UIListData.GetData(this.levelItemObj,"Simulate_DropLevelItem",levelItem);
        table.insert(list,levelData);
    end
    this.levelUIList:SetData(list);
    ui.tranLevelContent.sizeDelta=Vector2(#list*350,500)
end

this.GetDefaultPos=function(index)
    local isEnd_1=index%2~=0;
    local posY=-265
    if isEnd_1 then
        posY=-42
    end
    return Vector2(100+(index-1)*300,posY);
end

this.GetLockInfo=function(levelData)
    local lock=false;
    local lockInfo="";
    if levelData.Type==0 then

    elseif levelData.Type==1 then
        if this.dataBuild_1001.Level<tonumber(levelData.Unlock) then
            lock=true;
            local buildNameLan=ConfigMgr.Config.SimulateArchitectMap["1001"].NameLan;
            local buildName=LuaMgr.GetLangText(buildNameLan);
            lockInfo=string.format(string.format(LuaMgr.GetLangText("SimulateDropLevelViewModel_0"),buildName,levelData.Unlock));
        end

    elseif levelData.Type==2 then

        if IsNull(this.dataGame.UnlockMap) or this.dataGame.UnlockMap[levelData.Unlock]==nil then
            lock=true;
            lockInfo=string.format(LuaMgr.GetLangText("SimulateDropLevelViewModel_1"))
        end
    end
    return lock,lockInfo;
end

this.LevelCallBack=function(index)
    local levelItem=this.levelList[index]
    SimulateSceneMgr.ClearNPC();
    LuaMgr.ShowLuaPanel(UIName.SimulateDropGameViewModel,levelItem.Id);
end

return vm({
    data = data,
    command = command,
    hook = hook
})