local this =
{
    lightItemList = {},
    rewardItems = {},
    canGetReward = {},
    questConfByCondition = {},
    groupId = 3085
};

local objs = {
    rootAni = { path = "root", type = "Animator" },
    rawImgAni = { path = "root/Middle/RawImage", type = "Animator" },
    bottleAni1 = { path = "root/Middle/RawImage/RImgBottle1", type = "Animator" },
    bottleAni4 = { path = "root/Middle/RawImage/RImgBottle2", type = "Animator" },
    bottleAni3 = { path = "root/Middle/RawImage/RImgBottle3", type = "Animator" },
    bottleAni2 = { path = "root/Middle/RawImage/RImgBottle4", type = "Animator" },

    bottleBtn1 = { path = "root/Middle/RawImage/RImgBottle1/Btn", type = "ClickPressButton" },
    bottleBtn4 = { path = "root/Middle/RawImage/RImgBottle2/Btn", type = "ClickPressButton" },
    bottleBtn3 = { path = "root/Middle/RawImage/RImgBottle3/Btn", type = "ClickPressButton" },
    bottleBtn2 = { path = "root/Middle/RawImage/RImgBottle4/Btn", type = "ClickPressButton" },

    lightItemObj = { path = "template/LightItem", type = "GameObject" },
    lightBoxRt = { path = "root/Middle/LightBox", type = "RectTransform" },
    btnGetAll = { path = "root/Middle/BtnGetAll", type = "Button" },
    btnReward1 = { path = "root/Middle/BtnRewardBox/BtnReward1", type = "Button" },
    btnReward4 = { path = "root/Middle/BtnRewardBox/BtnReward2", type = "Button" },
    btnReward3 = { path = "root/Middle/BtnRewardBox/BtnReward3", type = "Button" },
    btnReward2 = { path = "root/Middle/BtnRewardBox/BtnReward4", type = "Button" },
    textReward1 = { path = "root/Middle/BtnRewardBox/BtnReward1/numBg/Text", type = "Text" },
    textReward4 = { path = "root/Middle/BtnRewardBox/BtnReward2/numBg/Text", type = "Text" },
    textReward3 = { path = "root/Middle/BtnRewardBox/BtnReward3/numBg/Text", type = "Text" },
    textReward2 = { path = "root/Middle/BtnRewardBox/BtnReward4/numBg/Text", type = "Text" },
    btnGet1 = { path = "root/Middle/BtnRewardGetBox/BtnGet1", type = "Button" },
    btnGet4 = { path = "root/Middle/BtnRewardGetBox/BtnGet2", type = "Button" },
    btnGet3 = { path = "root/Middle/BtnRewardGetBox/BtnGet3", type = "Button" },
    btnGet2 = { path = "root/Middle/BtnRewardGetBox/BtnGet4", type = "Button" },
    rewardBox1 = { path = "root/Middle/BtnRewardGetBox/BtnGet1/Image", type = "Transform" },
    rewardBox4 = { path = "root/Middle/BtnRewardGetBox/BtnGet2/Image", type = "Transform" },
    rewardBox3 = { path = "root/Middle/BtnRewardGetBox/BtnGet3/Image", type = "Transform" },
    rewardBox2 = { path = "root/Middle/BtnRewardGetBox/BtnGet4/Image", type = "Transform" },
};


this.SetData = function()
    local cacheTotalList = nil
    local totalNumTb = {}
    for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if ZGCXLevelStrType[v.area] ~= nil then
            local list = NumTool.split(v.classId, ";");
            local key = nil
            if (list ~= nil or #list ~= 0) then
                key = list[1]
                if (totalNumTb[key] == nil) then
                    totalNumTb[key] = {}
                    totalNumTb[key].total = 0
                    totalNumTb[key].cur = 0
                end
                totalNumTb[key].total = totalNumTb[key].total + 1
            end
            local isFinish = PlayerZGCXMgr.CheckFinish(v)
            if (isFinish) then
                if (cacheTotalList == nil) then
                    cacheTotalList = {}
                end
                if (key ~= nil) then
                    if (cacheTotalList[key] == nil) then
                        cacheTotalList[key] = {}
                    end
                    table.insert(cacheTotalList[key], v)
                    totalNumTb[key].cur = totalNumTb[key].cur + 1
                end
            end
        end
    end
    this.SetLightItem(cacheTotalList)
    for k, v in pairs(totalNumTb) do
        local index = ZGCXLevel2NumType[k]
        this["textReward" .. index].text = v.cur .. "/" .. v.total
    end
    this.SetReward()
end

this.SetLightItem = function(_dataList)
    if (_dataList ~= nil) then
        local num = 0
        for i, v in pairs(_dataList) do
            local collectCofList = ConfigZGCXMgr.GetLightCollectTbByType(i)
            for key, value in ipairs(v) do
                num = num + 1
                if (this.lightItemList[num] == nil or this.lightItemList[num].Obj == nil) then
                    this.lightItemList[num] = {}
                    local go = LuaMgr.InstantiateGO(this.lightItemObj, this.lightBoxRt, true)
                    local cacheObj = {}
                    SetActive(go, false)
                    cacheObj.go = go
                    cacheObj.icon = go.transform:Find("ImgIcon"):GetComponent("Image");
                    this.lightItemList[num].Obj = cacheObj
                end
                local cache = {}
                local obj = this.lightItemList[num].Obj
                obj.go.transform:SetParent(this.lightBoxRt, false);
                cache.pos = collectCofList[key].Coordinate
                local pos = obj.go.transform.localPosition
                pos.x = cache.pos[1]
                pos.y = cache.pos[2]
                pos.z = 0
                obj.go.transform.localPosition = pos
                local typeIndex = ZGCXLevel2NumType[i]


                local str = string.format("bottleAni%s", typeIndex)
                local trans = this[str].transform
                obj.go.transform:SetParent(trans, true);
                SetActive(obj.go, true)
                cache.icon = string.gsub(value.area, "ZGCX", "");

                obj.icon.sprite = LuaMgr.GetSprite("ZGCX", "ui_hd_zgcx_zx_gqjp_gq2_" .. cache.icon);
                this.lightItemList[num].data = cache
            end
        end
    end
end

this.SetReward = function()
    if (this.configQuest == nil) then
        this.configQuest = DataExHelper.Check_ConfigQuestEventByGroupId(this.groupId);
    end
    this.canGetReward = {}
    this.questConfByCondition = {}
    if (this.rewardItems ~= nil) then
        for k, v in pairs(this.rewardItems) do
            v:Hide();
        end
    end
    for i = 1, 4 do
        SetActive(this["btnGet" .. i].gameObject, false)
    end
    for k, v in pairs(this.configQuest) do
        if (v.text == "ZGCX") then
            local key = v.conditionArgs[1]
            local level = v.conditionArgs[2]
            if (this.questConfByCondition[key] == nil) then
                this.questConfByCondition[key] = {}
            end
            table.insert(this.questConfByCondition[key], v)
            local state = DataExHelper.Check_RewardState(v.id);
            if (state ~= nil and state == 2) then
                if (this.canGetReward[key] == nil) then
                    this.canGetReward[key] = {}
                    this.canGetReward[key].level = level
                    this.canGetReward[key].config = v
                    local index = ZGCXLevel2NumType[key]
                    SetActive(this["btnGet" .. index].gameObject, true)
                end
                if (this.canGetReward[key].level < level) then
                    this.canGetReward[key].level = level
                    this.canGetReward[key].config = v
                end
            end
        end
    end
    local num = 0
    for k, v in pairs(this.canGetReward) do
        local index = ZGCXLevel2NumType[k]
        local config = v.config
        for key, value in pairs(config.reward) do
            num = num + 1
            if (this.rewardItems[num] == nil) then
                this.rewardItems[num] = GoodsDataItem.New(this.rewardBox1);
            end
            local rewardObj = this.rewardItems[num]
            local itemData = table.Copy(ConfigMgr.Config.itemMap[value.id]);
            itemData.count0 = value.count
            rewardObj:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 0.6), false);
            rewardObj.transform:SetParent(this["rewardBox" .. index], false)
        end
    end
    SetActive(this.btnGetAll.gameObject, num > 0)
end


this.OnBack = function()
    LuaMgr.Back()
end


this.OnClickBtnGetAll = function()
    local canAchieveIds = {}
    for k, v in pairs(this.configQuest) do
        local state = DataExHelper.Check_RewardState(v.id);
        if (v.text == "ZGCX" and state ~= nil and state == 2) then
            table.insert(canAchieveIds, v.id)
        end
    end
    DataExHelper.EX_GetAwards(canAchieveIds, function(_result)
        this.SetReward()
        PlayerZGCXMgr.CheckTaskRedDot()
        RedMgr.Singleton:Refresh()
    end)
end


this.OnClickBtnReward = function(index)
    local key = ZGCXLevelNumType[index]
    local cacheList = this.questConfByCondition[key]
    if (cacheList ~= nil) then
        LuaMgr.ShowLuaPanel(UIName.ZGCXRewardListViewModel, cacheList);
    end
end

this.OnClickBtnGet = function(index)
    local key = ZGCXLevelNumType[index]
    local config = this.canGetReward[key]
    if (config ~= nil and config.config ~= nil) then
        DataExHelper.EX_GetAward(config.config.id, function(_result)
            this.SetReward()
            PlayerZGCXMgr.CheckTaskRedDot()
            RedMgr.Singleton:Refresh()
        end)
    end
end


local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        for i = 1, 4 do
            LuaMgr.AddClick(this["btnReward" .. i], function()
                this.OnClickBtnReward(i)
            end);
        end
        for i = 1, 4 do
            LuaMgr.AddClick(this["btnGet" .. i], function()
                this.OnClickBtnGet(i)
            end);
        end
        LuaMgr.AddClick(this.btnGetAll, this.OnClickBtnGetAll);
        for i = 1, 4 do
            this["bottleBtn" .. i].OnClick:AddListener(function()
                this.OnClickBtnReward(i)
            end)
            this["bottleBtn" .. i].OnPress:AddListener(function()
                this["bottleAni" .. i].enabled = true
                this["bottleAni" .. i]:Rebind();
            end)
            this["bottleBtn" .. i].OnLiftUp:AddListener(function()
                this["bottleAni" .. i]:Rebind();
                this["bottleAni" .. i].enabled = false
            end)
        end
        RedMgr.Singleton:RegisterViewModel(UIName.ZGCXRewardViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.AddUIEventListener(UIEventConst.ZGCXMsgShow, this.SetReward);
        PlayerZGCXMgr.CheckTaskRedDot()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.rawImgAni.enabled = false
        this.SetData();
        this.rawImgAni.enabled = true
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.ZGCXMsgShow, this.SetReward);
    end,
    before_destroy = function()

        if (this.lightItemList ~= nil) then
            for k, v in pairs(this.lightItemList) do
                if (v.Obj ~= nil and v.Obj.go ~= nil) then
                    LuaMgr.DestroyGO(v.Obj.go)
                end
            end
            this.lightItemList = {}
        end

        LuaMgr.RemoveClick(this.btnGetAll, this.OnClickBtnGetAll);
        for i = 1, 4 do
            this["btnReward" .. i].onClick:RemoveAllListeners()
        end
        for i = 1, 4 do
            this["btnGet" .. i].onClick:RemoveAllListeners()
        end
        for i = 1, 4 do
            this["bottleBtn" .. i].OnClick:RemoveAllListeners()
            this["bottleBtn" .. i].OnPress:RemoveAllListeners()
            this["bottleBtn" .. i].OnLiftUp:RemoveAllListeners()
        end
        RedMgr.Singleton:RemoveViewModel(UIName.ZGCXRewardViewModel);
    end
}


return vm({
    data = data,
    command = command,
    hook = hook
})