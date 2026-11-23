





local this = {
    vm = nil, rareSprite = nil,iconTexture = nil,countText = nil,
    getBtnObj = nil,groupId = 800,missionId = nil,goods = nil,nameText = "",
}

local data = {

}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CelebrationViewModel)
        end
    },
    getCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            DataExHelper.EX_GetAward(this.missionId,function()
                LuaMgr.HidePanel(UIName.CelebrationViewModel)
            end)
        end
    },
    goodsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,this.goods.id,false,false,false)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.rareSprite = vm.behaviour.transform:Find("root/Middle/Group/Good/Rare"):GetComponent("Image")
        this.iconTexture = vm.behaviour.transform:Find("root/Middle/Group/Good/RawImage"):GetComponent("RawImage")
        this.countText = vm.behaviour.transform:Find("root/Middle/Group/Good/Count/Text"):GetComponent("Text")
        this.getBtnObj = vm.behaviour.transform:Find("root/Middle/Group/GetBtn").gameObject
        this.nameText = vm.behaviour.transform:Find("root/Middle/Group/Name/Text"):GetComponent("Text")

        this.FinishIcon = vm.behaviour.transform:Find("root/Middle/Group/Good/FinishIcon").gameObject
        this.FinishBtn = vm.behaviour.transform:Find("root/Middle/Group/FinishBtn").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()
end
this.RemoveUIEvent = function()
end


this.InitParameter = function()

    local activityData = DataExHelper.Check_ConfigQuestEventByGroupId(this.groupId)
    this.missionId = activityData[1].id
    this.goods = activityData[1].showReward[1]
    local tempData = DataMgr.Player.quests[this.missionId]
    SetActive(this.getBtnObj,tempData.state ~= 3)
    local tempConfig = ConfigMgr.Config.itemMap[this.goods.id]
    this.rareSprite.sprite = GetRareSprite(tempConfig.rare)
    this.iconTexture.texture = GetItemTexture(tempConfig.id)
    this.nameText.text = LuaMgr.GetLangText(tempConfig.nameLan)
    this.countText.text = this.goods.count

    if  DataMgr.Player.quests[activityData[1].id].state == 3 then
        SetActive(this.FinishBtn,true);
        SetActive(this.FinishIcon,true);
        SetActive(this.getBtnObj,false);
    else
        SetActive(this.FinishBtn,false);
        SetActive(this.FinishIcon,false);
        SetActive(this.getBtnObj,true);
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})