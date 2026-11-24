local this = {
    rewardItemList = nil,
    rewardContainer = nil,
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goScrollView = uiLink:Get("goScrollView");
    ui.goBuff = uiLink:Get("goBuff");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnConfirm = uiLink:Get("btnConfirm"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtDesc = uiLink:Get("txtDesc"):GetComponent("Text");
    ui.txtBuffContent = uiLink:Get("txtBuffContent"):GetComponent("Text");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventResultPopup);
        SeasonSLGMapMgr.CheckTopRanReward()
    end)
    uiLink:AddClickEvent("btnConfirm",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventResultPopup);
        SeasonSLGMapMgr.CheckTopRanReward()
    end)
end

local data =
{
    buffList = {
        {
            buffIcon = DefaultSprite,
            desc = "",
        }
    }
}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.rewardItemList={};
        if ui.goScrollView ~= nil then
            local scrollRect = ui.goScrollView:GetComponent("ScrollRect");
            if scrollRect ~= nil then
                this.rewardContainer = scrollRect.content;
            else
                this.rewardContainer = ui.goScrollView.transform;
            end
        end
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm = vm
        if vm.behaviour.Params.Length>2 then
            this.title=vm.behaviour.Params[0]
            this.desc=vm.behaviour.Params[1]
            this.rewards=vm.behaviour.Params[2]
            this.resultType=vm.behaviour.Params[3]
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.ClearReward();
    end,
    before_destroy = function()
        this.ClearReward();
        if this.rewardItemList ~= nil then
            for i,v in pairs(this.rewardItemList) do
                if v ~= nil then
                    v:Clear();
                end
            end
        end
        this.rewardItemList=nil;
        this.ClearUI();
    end
}

this.ParseData=function()
    if ui.txtTitle ~= nil then
        ui.txtTitle.text = this.title or "";
    end
    if ui.txtDesc ~= nil then
        ui.txtDesc.text = this.desc or "";
    end
    SetActive(ui.goBuff,false)
    SetActive(ui.goScrollView,false)
    if this.resultType == SeasonSLGMapMgr.EventResultType.buff then
        this.SetBuff()
    else
        this.SetRewards();
    end
end

this.SetBuff = function()
    SetActive(ui.goBuff,true)
    local tempList = {}
    for i, v in ipairs(this.rewards) do

        local attackConfig = ConfigMgr.Config.SeasonalGridWorldAttackMap[v]
                or ConfigMgr.Config.SeasonalGridWorldAttackMap[tostring(v)]
        if attackConfig ~= nil then
            local seasonBuffConfig = ConfigMgr.Config.SeasonalBuffMap[attackConfig.SeasonalPersonalBuff]
            if seasonBuffConfig ~= nil then
                local item = {}
                item.buffIcon = LuaMgr.GetSprite("BuffIcon", seasonBuffConfig.BuffIcon)
                item.desc = LuaMgr.GetLangText(seasonBuffConfig.BuffDesLan)
                table.insert(tempList,item)
            end
        end
    end
    this.vm.data.buffList = tempList
end

this.SetRewards=function()
    SetActive(ui.goScrollView,true)
    this.ClearReward();
    if this.rewards == nil or this.rewardContainer == nil then
        return;
    end
    local rewards = {}
    if this.resultType == SeasonSLGMapMgr.EventResultType.commonReward then
        for i, v in pairs(this.rewards) do
            table.insert(rewards,v)
        end
    else
        rewards = this.rewards
    end
    for i,v in ipairs(rewards) do
        if this.rewardItemList[i]==nil then
            this.rewardItemList[i]=GoodsDataItem.New(this.rewardContainer)
        end
        local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        if TableIsNull(itemData) then
            SetActive(this.rewardItemList[i].gameObject,false);
        else
            itemData.count0 = v.count;
            SetActive(this.rewardItemList[i].gameObject,true);
            this.rewardItemList[i]:SetData(1, itemData, 1, false, Vector3(0.6,0.6,0.6), false);
        end
    end
end

this.ClearReward=function()
    if this.rewardItemList ~= nil then
        for i,v in pairs(this.rewardItemList) do
            if v ~= nil then
                SetActive(v.gameObject,false);
            end
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})