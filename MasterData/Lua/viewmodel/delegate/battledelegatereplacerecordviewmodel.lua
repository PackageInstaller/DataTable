require("ViewModel/Delegate/Delegate_FrameItem")

local this = { vm = nil,
               memberItemObj=nil,
               oldMemberUIList=nil,
               curMemberUIList=nil };

local confirmFunc = nil
local cancelFunc = nil

local data = { }

local function ClearFunc()
    cancelFunc = nil
    confirmFunc = nil
end

local command = {
    cancelBtn = {
        type = XLuaCommandType.Void;
        execute = function(vm, param)
            if cancelFunc ~= nil then
                cancelFunc()
                ClearFunc()
            end
            LuaMgr.HidePanel(UIName.BattleDelegateReplaceRecordViewModel)
        end
    },

    okBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if confirmFunc ~= nil then
                confirmFunc()
                ClearFunc()
            end
            LuaMgr.HidePanel(UIName.BattleDelegateReplaceRecordViewModel)
        end
    },
}


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.oldMemberUIList = UIListView.New(vm.behaviour.transform:Find("root/Middle/delegatePanel/Old"));
        this.curMemberUIList = UIListView.New(vm.behaviour.transform:Find("root/Middle/delegatePanel/New"));
        this.memberItemObj   = vm.behaviour.transform:Find("template/frameItem").gameObject;
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        local oldCharacters      = vm.behaviour.Params[0];
        local oldCharactersLevel = vm.behaviour.Params[1];
        local curCharacters      = vm.behaviour.Params[2];
        confirmFunc              = vm.behaviour.Params[3];
        cancelFunc               = vm.behaviour.Params[4];

        this.SetAvatarList(this.oldMemberUIList, oldCharacters, oldCharactersLevel);
        this.SetAvatarList(this.curMemberUIList, curCharacters, nil);
    end,

    before_deactive = function(vm)

    end,
}


this.SetAvatarList=function(memberUIList, repCharacters, levels)
    local chaCount=0;
    local memberItems={};

    for i, characterID in pairs(repCharacters) do
        local headPath=ConfigHelper.GetCharacterAvatarPath(characterID, DataMgr.Player.characters[characterID].curSkin);
        local memberItem={
            isActive=true,
            headIcon=LuaMgr.GetTexture(headPath),
            level=levels==nil and DataMgr.Player.characters[characterID].level or levels[i],
        }
        table.insert(memberItems,memberItem);
        chaCount = chaCount + 1;
    end 

    if (chaCount < 6) then
        for i=chaCount+1,6,1 do
            local memberItem={
                isActive=false,
            }
            table.insert(memberItems,memberItem);
        end
    end


    local list={};

    for _, memberItem in pairs(memberItems) do
        local listData =UIListData.GetData(this.memberItemObj,"Delegate_FrameItem", memberItem);
        table.insert(list,listData);
    end 

    memberUIList:SetData(list);
end


return vm({
    data = data,
    command = command,
    hook = hook
})