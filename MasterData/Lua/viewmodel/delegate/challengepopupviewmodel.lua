




require("ViewModel/Delegate/ChallengeItem")
local this = {vm=nil,
              dungeonId=nil,
              challengeUIList=nil,
              challengeItemObj=nil,
              challengeTags={},
};

local callBack=nil;

local objs={
    maskBtn={path="root/Middle/MaskBtn",type="UIButtonClick"}
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        UITool.Parse(vm.behaviour,this,objs);
        this.challengeUIList=UIListView.New(vm.behaviour.transform:Find("root/Middle/challenge/content"));
        this.challengeItemObj=vm.behaviour.transform:Find("template/challengeItem").gameObject;
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.AddClick(this.maskBtn,this.MaskBtnCommand)
            this.challengeTags=vm.behaviour.Params[0]
            this.dungeonId=vm.behaviour.Params[1]
            if vm.behaviour.Params.Length>2 then
                callBack=vm.behaviour.Params[2]
            end
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveClick(this.maskBtn,this.MaskBtnCommand);
        this.challengeTags={}
        if callBack~=nil then
            callBack();
        end
    end,
    before_destroy=function()
    end
}

this.MaskBtnCommand=function()
    LuaMgr.HidePanel(UIName.ChallengePopupViewModel);
end


this.ParseData=function()
    local challengeList=ConfigMgr.Config.levelChallenges[this.dungeonId]
    if challengeList==nil or #challengeList==0 then
        return
    end
    local challengeMap=ConfigMgr.Config.challengesMap;
    local challengeDataList={}
    for i,v in ipairs(challengeList) do
        if challengeMap[v]~=nil then
            local isNewComplete=this.CheckIsNewCompleteTag(v)
            local challengeItem={
                itemId=challengeMap[v].rewardShow[1].id,
                itemCount=challengeMap[v].rewardShow[1].count,
                des=LuaMgr.GetLangText(challengeMap[v].desLan),
                isCompleted=not isNewComplete and DataMgr.Player.completedTags[v]~=nil,
                isNew=isNewComplete
            }
            local challengeData=UIListData.GetData(this.challengeItemObj,"ChallengeItem",challengeItem)
            table.insert(challengeDataList,challengeData)
        end
    end
    this.challengeUIList:SetData(challengeDataList,true)
end

this.CheckIsNewCompleteTag=function(tag)
    if IsNull(this.challengeTags) or #this.challengeTags==0 then
        return false
    end
    for i,v in ipairs(this.challengeTags) do
        if v==tag then
            return true;
        end
    end
    return false;
end

return vm({
    data = data,
    command = command,
    hook = hook
})