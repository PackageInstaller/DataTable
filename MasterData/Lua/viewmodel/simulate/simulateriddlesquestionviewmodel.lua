require("ViewModel/Simulate/Simulate_RiddlesQueItem")

local this = {
    vm = nil,
    riddleQueUIList={};
    riddleItemObj=nil;
    qSpineId="W0147";
    qSpineSkinId="W0147001";
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
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.txtTips = uiLink:Get("txtTips"):GetComponent("Text");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
   
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
        this.riddleQueUIList=UIListView.New(ui.tranContent);
        this.riddleItemObj=vm.behaviour.transform:Find("template/riddleItem").gameObject;
        this.QSpine=vm.behaviour.transform:Find("root/Middle/qSpine"):GetComponent("UISpineCharacter");
        RedMgr.Singleton:RegisterViewModel(UIName.SimulateRiddlesQuestionViewModel)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then

            SimulateRoomMgr.CheckRiddlesRed();
            this.riddleList={};
            this.riddleOptionMap=ConfigMgr.Config.SimulateRiddleOptionMap;
            for i,v in pairs(ConfigMgr.Config.SimulateRiddleMap) do
                table.insert(this.riddleList,v);
            end
            table.sort(this.riddleList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
            this.ParseData();
        end
        
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.riddleQueUIList:Clear();
        if this.spineCharacter~=nil then
            this.spineCharacter:Clear();
        end
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_RiddlesQueItem")
    end
}

this.ParseData=function()
    this.dataRiddleMap=DataMgr.Player.SimulateGame.RiddleMap;
    this.SetRiddleUIList();
end

this.SetRiddleUIList=function()
    this.riddleQueUIList:Clear();
    local list={};
    for i,v in ipairs(this.riddleList) do
        local answer=this.GetQueAnswerInfo(v);
        local lockInfo=this.GetQueLockIno(v);
        local riddleItem={
            index=i,
            id=v.Id,
            isPass=answer~=nil;
            answer=answer;
            isLock=lockInfo~=nil;
            lockInfo=lockInfo;
            posY=v.PosY~=nil and tonumber(v.PosY) or 0;
            redId="17313_"..v.Id,
            callBack=this.QueCallBack,
        }
        local riddleData=UIListData.GetData(this.riddleItemObj,"Simulate_RiddlesQueItem",riddleItem);
        table.insert(list,riddleData);
    end
    this.riddleQueUIList:SetData(list);
end


this.GetQueLockIno=function(v)
    if v.Type==0 then

        return nil;
    elseif v.Type==1 then
        local startTime=SimulateRoomMgr.GetXCHDActiveStartTime()+v.Unlock*24*60*60
        if LuaMgr.Timestamp()>startTime then
            return nil;
        end

        local lockInfo = os.date(LuaMgr.GetLangText("SimulateRiddlesQuestionViewModel_0"),startTime)
        return lockInfo;
    end
    return nil;
end


this.GetQueAnswerInfo=function(v)
    if IsNull(this.dataRiddleMap) or this.dataRiddleMap[v.Id]==nil then
        return nil;
    end
    local option=this.riddleOptionMap[v.Answer];
    if option~=nil then
        return LuaMgr.GetLangText(option.ContentLan);
    end
end

this.QueCallBack=function(index)
    local riddleData=this.riddleQueUIList.dataList[index].data;
    if riddleData.isLock then
       LuaMgr.ShowPanel(UIName.MessageTipsViewModel,riddleData.lockInfo) 
        return;
    end
    LuaMgr.ShowLuaPanel(UIName.SimulateRiddlesAnswerViewModel,riddleData.id);
end

return vm({
    data = data,
    command = command,
    hook = hook
})