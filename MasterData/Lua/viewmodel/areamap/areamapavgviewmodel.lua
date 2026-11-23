local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local goRewardDetails = nil;
local goDesc = nil;
local goBtnReward = nil;
local goStartNum = nil;
local textName = nil;
local textChapter = nil;
local textStartMsg = nil;
local textStartNum = nil;
local btnReward = nil;
local btnDesc = nil;
local btnStart = nil;
local rawImageStartNumIcon = nil;
local textDesc = nil;
local goBtnDesc = nil;
local this = {
    vm = nil,
}


local narrativeConfig = nil;
local buildingId = nil;
local areaEventConfig = nil;
local maxItemCount = 3;
local rewardDetailsDatasParm = {};
local data = {

    rewardDetailsDatas = {
        {
            goods = { 
            id = 0,
            count = -1,
            showType = ItemShowType.NONE,
            scale = 0,
            isClick = true,
            mark=nil,
            marktype=0,
            isCount = true,
            pathway = false,
            isFirst=false,
            isFixed=false,
            isReceived=false,
            icon=DefaultTexture,
            rare=DefaultSprite,
            },
        }
    },
}
local command = {
}
local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour);
    end,
    before_active = function(vm)
        if (this.vm.behaviour.Params == nil) then
            return
        end
        this.BeforeActive(this.vm.behaviour.Params)
    end,
    after_active = function(vm)
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
    end,
}

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    goRewardDetails = uiLink:Get("goRewardDetails");
    goDesc = uiLink:Get("goDesc");
    goStartNum = uiLink:Get("goStartNum");
    textName = uiLink:Get("textName"):GetComponent("Text");
    textChapter = uiLink:Get("textChapter"):GetComponent("Text");
    textStartMsg = uiLink:Get("textStartMsg"):GetComponent("Text");
    textStartNum = uiLink:Get("textStartNum"):GetComponent("Text");
    btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    btnDesc = uiLink:Get("btnDesc"):GetComponent("Button");
    btnStart = uiLink:Get("btnStart"):GetComponent("Button");
    rawImageStartNumIcon = uiLink:Get("rawImageStartNumIcon"):GetComponent("RawImage");
    textDesc = uiLink:Get("goDesc"):GetComponent("UIText");
    goBtnReward = uiLink:Get("btnReward");
    goBtnDesc = uiLink:Get("btnDesc")
    uiLink:AddClickEvent("root", this.OnClickClose)
    uiLink:AddClickEvent("btnStart", this.OnClickStart)
    uiLink:AddClickEvent("btnReward", this.OnClickReward)
    uiLink:AddClickEvent("btnDesc", this.OnClickDesc)
end


this.Clear = function()
    goBtnReward = nil;
    goBtnDesc = nil;
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    goRewardDetails = nil;
    goDesc = nil;
    goStartNum = nil;
    textName = nil;
    textChapter = nil;
    textStartMsg = nil;
    textStartNum = nil;
    btnReward = nil;
    btnDesc = nil;
    btnStart = nil;
    rawImageStartNumIcon = nil;
    textDesc = nil;
    this.vm.data.rewardDetailsDatas = {}
end

this.SetIsDesc = function(active)
    SetActive(goBtnReward, active);
    SetActive(goDesc, active);
end

this.SetIsRewardDetails = function(active)
    SetActive(goRewardDetails, active);
    SetActive(goBtnDesc, active);
end

this.BeforeActive = function(Params)
    if Params == nil or Params.Length ~= 2 then
        return;
    end
    areaEventConfig = Params[0];
    buildingId = Params[1];
    narrativeConfig = ConfigMgr.Config.narrativeMap[areaEventConfig.eventParam];
    if narrativeConfig == nil then
        return;
    end
    this.SetInfo();
    this.SetIsRewardDetails(false);
    this.SetIsDesc(true);
end

this.SetInfo = function()
    textName.text = LuaMgr.GetLangText(narrativeConfig.nameLan)
    textChapter.text = "";
    textDesc.text = LuaMgr.GetLangText(narrativeConfig.narraDesLan)
    this.SetConsume();
    this.SetIsDesc(true);
    this.SetIsRewardDetails(false);

    this.SetRewardDetails();
end

this.SetConsume = function()
    SetActive(goStartNum, false);
    textStartMsg.text = "";
end









this.SetRewardDetails = function()
    this.vm.data.rewardDetailsDatas = {};
    rewardDetailsDatasParm={};
    if not IsNullOrEmpty(narrativeConfig.fixedDropShow) then
        this.AddItem(narrativeConfig.fixedDropShow, 0, 0.8, true, rewardDetailsDatasParm);
        this.vm.data.rewardDetailsDatas = rewardDetailsDatasParm;
    end
end

this.AddItem = function(str, limit,scaleParm, isClickParm, list)
    if not IsNullOrEmpty(str) then
        local strs = Split(str, ";");
        local len = #strs
        if limit > 0 then
            len = len > limit and limit or len;
        end
for i = 0, len - 1, 1 do
            local item =ConfigMgr.Config.itemMap[tostring(strs[i + 1])];
            local goodsItem = {
                
                id = strs[i + 1],
                showType = ItemShowType.NONE,
                scale = Vector3(scaleParm,scaleParm,1),
                isClick = isClickParm,
                mark=nil,
                marktype=0,
                isCount = false,
                pathway = false,
                isFirst=false,
                isFixed=false,
                sizeDelta = Vector2(102,102),
                isReceived=false,
                icon=ConfigHelper.GetItemTexture( strs[i + 1]),
                rare=LuaMgr.GetSprite("ItemRare", "itemRare" .. item.rare),
                count = "",
            }

            local itemAward={
                goods=goodsItem,
            }
            table.insert(list, itemAward);
        end
    end
end


this.OnClickClose = function(args)
    LuaMgr.HidePanel(UIName.AreaMapAVGViewModel);
end

this.OnClickStart = function(args)
    if narrativeConfig == nil then
        return;
    end
    LuaMgr.HidePanel(UIName.AreaMapAVGViewModel);
    AreaMapSceneMgr.SetBuildingId(buildingId)
    LuaMgr.PlayNovel(areaEventConfig.id, function()
        LuaMgr.ShowLuaPanel(UIName.AreaMapViewModel)
    end)
end

this.OnClickReward = function(args)
    this.SetIsRewardDetails(true);
    this.SetIsDesc(false);
end

this.OnClickDesc = function(args)
    this.SetIsRewardDetails(false);
    this.SetIsDesc(true);
end

return vm({
    data = data,
    command = command,
    hook = hook
})