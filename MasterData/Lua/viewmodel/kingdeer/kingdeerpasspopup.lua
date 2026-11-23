







require("ViewModel/KingDeer/KingDeerPassButton")
local objs = {
    rewardParentPrefab = {path = "template/RewardItem", type = UITool.GameObject},
    animator = {path = "root", type = UITool.Animator},
    titleTxt = {path = "root/Middle/TitleBG/Title", type = UITool.Text},
    zoneIcon = {path = "root/Middle/LeftGroup/Icon", type = UITool.Image},
    rewardParent = {path = "root/Middle/LeftGroup/TipImg/ItemParent", type = UITool.Transform},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    maskBtn = {path = "root/Mask", type = UITool.Button},
canGetObj = {path = "root/Middle/LeftGroup/TipImg/CanGet", type = UITool.GameObject},
    canGetBtn = {path = "root/Middle/LeftGroup/TipImg/CanGet/GetReward", type = UITool.Button},
    tipsText = {path = "root/Middle/LeftGroup/TipImg/TipsText", type = UITool.Text}
}

local this = {
    passCount = 5,

    passBtnItems = {},
    rewardParents = {},
    rewardUIItems = {},
canGetObjs = {},
gotObjs = {}
}

this.before_active = function()
    KingDeerData.SetLastZoneIndex()
    local data = KingDeerData.GetZoneData(this.zoneIndex)
    this.data = data
    this.titleTxt.text = data.zoneName
    this.zoneIcon.sprite = LuaMgr.GetSprite("ActivityKingDeer", "ui_hd_hy_zjmtc_gqjz" .. this.zoneIndex)
    this.animator.enabled = true
    for key, value in pairs(data.progressConfig.reward) do
        if #this.rewardParents < key then
            local obj = LuaMgr.InstantiateGO(this.rewardParentPrefab, this.rewardParent, false)
            local index = #this.rewardParents + 1
            table.insert(this.rewardParents, index, obj)
            table.insert(this.canGetObjs, index, obj.transform:Find("CanGetFlag").gameObject)
            table.insert(this.gotObjs, index, obj.transform:Find("GotFlag").gameObject)
        end
        local parent = this.rewardParents[key]
        if #this.rewardUIItems < key then
            local goodsData = GoodsDataItem.New(parent.transform)
            goodsData.transform:SetSiblingIndex(0)
            table.insert(this.rewardUIItems, goodsData)
        end
        local showItem = value
        local itemConfig = ConfigMgr.Config.itemMap[showItem.id]
        if itemConfig ~= nil then
            local itemData = table.Copy(itemConfig)
            itemData.count0 = showItem.count
            this.rewardUIItems[key]:SetData(1, itemData, 1, false, Vector3(0.4, 0.4, 1), false)
            this.rewardUIItems[key]:SetCount(nil, Vector2(-10, 10), Vector3.one)
            this.rewardUIItems[key]:SetIconBg(false)
        end
    end
    this.SetRightRewardStatus(data)
    local zoneData = KingDeerData.GetZoneData(this.zoneIndex)

    local eventMapData = zoneData.eventMapData
    local tempIndex = 1
    for key, value in pairs(eventMapData) do
        this.passBtnItems[tempIndex]:SetData(value, this.zoneIndex)
        tempIndex = tempIndex + 1
    end
end

this.SetRightRewardStatus = function(data)
    if data == nil then
        data = KingDeerData.GetZoneData(this.zoneIndex)
    end
    SetActive(this.canGetObj, data.status == KingDeerData.GetRewardStatus.CanGet)
    if data.status == KingDeerData.GetRewardStatus.None then
        this.tipsText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7332")
    elseif data.status == KingDeerData.GetRewardStatus.CanGet then
        this.tipsText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7333")
    else
        this.tipsText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_15705")
    end
    for key, value in pairs(this.rewardParents) do
        SetActive(value, false)
    end
    for key, value in pairs(data.progressConfig.reward) do
        SetActive(this.rewardParents[key], true)
        SetActive(this.canGetObjs[key], data.status == KingDeerData.GetRewardStatus.CanGet)
        SetActive(this.gotObjs[key], data.status == KingDeerData.GetRewardStatus.Got)
    end
    this.data = data
    LuaMgr.AddTimer(TimerConst.KingDeerZoneRewardDelay, this.DelayPlayCanGetAni, 1, 1, false)
end

this.DelayPlayCanGetAni = function()
    local animnName = "ani_KingDeerPassPopup_root_tips"
    if this.data.status == KingDeerData.GetRewardStatus.CanGet then
        this.animator:Play(animnName)
    else
        this.animator.enabled = false
    end
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.KingDeerPassPopup)
end

this.OnIntoBattle = function()
    this.OnClickBack()
end

this.GetReward = function()
    local callback = function()
        this.SetRightRewardStatus()
        local data = {}
        data.zoneIndex = this.zoneIndex
        LuaMgr.InvokeUIEventListeners(UIEventConst.KingDeerMainViewRefresh, data)
    end
    local config = this.data.progressConfig
    DataExHelper.EX_GetAward(config.id, callback)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for i = 1, this.passCount do
            local tempData = {}
            tempData.path = "root/Middle/RightGroup/PassButton" .. i
            tempData.type = UITool.GameObject
            objs["passButton" .. i] = tempData
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.passBtnItems = {}
        for i = 1, this.passCount do
            local passBtnItem = KingDeerPassButton.New(this["passButton" .. i], i, this.OnIntoBattle)
            table.insert(this.passBtnItems, passBtnItem)
        end
        LuaMgr.AddClick(this.closeBtn, this.OnClickBack)
        LuaMgr.AddClick(this.maskBtn, this.OnClickBack)
        LuaMgr.AddClick(this.canGetBtn, this.GetReward)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.zoneIndex = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.KingDeerZoneRewardDelay)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.canGetBtn, this.GetReward)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)