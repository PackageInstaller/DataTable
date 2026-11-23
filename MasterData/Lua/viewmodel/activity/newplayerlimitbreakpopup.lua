local this =
{
    rewardList = {},
    curPage = 0,
    isPaying = false,
    chargeId = "",
    order = "",
};

local objs = {
    goodsItem = { path = "template/GoodsItem", type = "GameObject" },
    characterItem = { path = "template/CharacterItem", type = "GameObject" },
    closeBtn = { path = "root/Middle/obj/CloseBtn", type = "Button" },
    leftBtn = { path = "root/Middle/obj/LeftBtn", type = "Button" },
    rightBtn = { path = "root/Middle/obj/RightBtn", type = "Button" },
    page1 = { path = "root/Middle/obj/page_1", type = "GameObject" },
    page1Ani = { path = "root/Middle/obj/page_1", type = "Animator" },
    page1Content1 = { path = "root/Middle/obj/page_1/ScrollView1/Viewport/Content", type = "Transform" },
    page1GetBtn1 = { path = "root/Middle/obj/page_1/getBtn1", type = "Button" },
    page1GetBtn1St1 = { path = "root/Middle/obj/page_1/getBtn1/ImgState1", type = "GameObject" },
    page1GetBtn1St2 = { path = "root/Middle/obj/page_1/getBtn1/ImgState2", type = "GameObject" },
    page1GetBtn1St3 = { path = "root/Middle/obj/page_1/getBtn1/ImgState3", type = "GameObject" },
    page1GetBtn1St3Lock = { path = "root/Middle/obj/page_1/getBtn1/ImgState3/ImageLock", type = "GameObject" },
    page1GetBtn1TextSt = { path = "root/Middle/obj/page_1/getBtn1/TextState", type = "Text" },
    page1GetBtn1Tras = { path = "root/Middle/obj/page_1/getBtn1/ImageTras/ImageTras", type = "Transform" },
    page1GetBtn2 = { path = "root/Middle/obj/page_1/getBtn2", type = "Button" },
    page1GetBtn2St1 = { path = "root/Middle/obj/page_1/getBtn2/ImgState1", type = "GameObject" },
    page1GetBtn2St2 = { path = "root/Middle/obj/page_1/getBtn2/ImgState2", type = "GameObject" },
    page1GetBtn2St3 = { path = "root/Middle/obj/page_1/getBtn2/ImgState3", type = "GameObject" },
    page1GetBtn2St3Lock = { path = "root/Middle/obj/page_1/getBtn2/ImgState3/ImageLock", type = "GameObject" },
    page1GetBtn2TextSt = { path = "root/Middle/obj/page_1/getBtn2/TextState", type = "Text" },
    page1Content2 = { path = "root/Middle/obj/page_1/Image/ScrollView2/Viewport/Content", type = "Transform" },
    page2 = { path = "root/Middle/obj/page_2", type = "GameObject" },
    page2Ani = { path = "root/Middle/obj/page_2", type = "Animator" },
    page2Point2 = { path = "root/Middle/obj/page_2/Point_2", type = "GameObject" },
    tip1Tra = { path = "root/Middle/obj/page_2/Point_2/tip1Tra", type = "Transform" },
    page2Point3 = { path = "root/Middle/obj/page_2/Point_3", type = "GameObject" },
    tip2Tra = { path = "root/Middle/obj/page_2/Point_3/tip2Tra", type = "Transform" },
    tip3Tra = { path = "root/Middle/obj/page_2/Point_3/tip3Tra", type = "Transform" },
    page2TextTitle = { path = "root/Middle/obj/page_2/Image/TextTitle", type = "Text" },
    page2Content1 = { path = "root/Middle/obj/page_2/ScrollView1/Viewport/Content", type = "Transform" },
    page2Content2 = { path = "root/Middle/obj/page_2/ScrollView2/Viewport/Content", type = "Transform" },
    page2GetBtn1 = { path = "root/Middle/obj/page_2/getBtn1", type = "Button" },
    page2GetBtn1St1 = { path = "root/Middle/obj/page_2/getBtn1/ImgState1", type = "GameObject" },
    page2GetBtn1St2 = { path = "root/Middle/obj/page_2/getBtn1/ImgState2", type = "GameObject" },
    page2GetBtn1St3 = { path = "root/Middle/obj/page_2/getBtn1/ImgState3", type = "GameObject" },
    page2GetBtn1St3Lock = { path = "root/Middle/obj/page_2/getBtn1/ImgState3/ImageLock", type = "GameObject" },
    page2GetBtn1TextSt = { path = "root/Middle/obj/page_2/getBtn1/TextState", type = "Text" },
    page2GetBtn2 = { path = "root/Middle/obj/page_2/getBtn2", type = "Button" },
    page2GetBtn2St1 = { path = "root/Middle/obj/page_2/getBtn2/ImgState1", type = "GameObject" },
    page2GetBtn2St2 = { path = "root/Middle/obj/page_2/getBtn2/ImgState2", type = "GameObject" },
    page2GetBtn2St3 = { path = "root/Middle/obj/page_2/getBtn2/ImgState3", type = "GameObject" },
    page2GetBtn2St3Lock = { path = "root/Middle/obj/page_2/getBtn2/ImgState3/ImageLock", type = "GameObject" },
    page2GetBtn2TextSt = { path = "root/Middle/obj/page_2/getBtn2/TextState", type = "Text" },
    leftTimerText = { path = "root/Middle/obj/LeftTimer/LeftTimerText", type = "Text" },
};



this.SetData = function()
    NewPlayerLimitBreakMgr.RefreshData()
    this.curPage = 0
    this.SetPageByStatus()
end

this.SetPageByStatus = function()
    for k, v in ipairs(NewPlayerLimitBreakMgr.GoodsIDList) do
        local id = v[1]
        local buyStatus = NewPlayerLimitBreakMgr.GetGoodsStatus(id)
        if (buyStatus == NewPlayerLimitBreakMgr.GoodsStatus.Showing) then
            local page = (k + 1) // 2
            this.SwitchPage(page)
            return
        end
    end
    this.SwitchPage(3)
end

this.SwitchPage = function(page)
    if (page == this.curPage) then
        return
    end
    this.curPage = page
    SetActive(this.leftBtn.gameObject, this.curPage > 1)
    SetActive(this.rightBtn.gameObject, this.curPage < 3)
    SetActive(this.page1, this.curPage == 1)
    SetActive(this.page2, this.curPage == 2 or this.curPage == 3)
    SetActive(this.page2Point2, page == 2)
    SetActive(this.page2Point3, page == 3)
    this.page1Ani.enabled = false
    this.page2Ani.enabled = false
    local idList = {}
    if (page == 1) then
        table.insert(idList, NewPlayerLimitBreakMgr.GoodsIDList[1][1])
        table.insert(idList, NewPlayerLimitBreakMgr.GoodsIDList[2][1])
        this.page1Ani:Rebind();
        this.page1Ani.enabled = true
    elseif (page == 2) then
        this.page2TextTitle.text = LuaMgr.GetLangText("NewPlayerLimitBreakPopup_0")
        table.insert(idList, NewPlayerLimitBreakMgr.GoodsIDList[3][1])
        table.insert(idList, NewPlayerLimitBreakMgr.GoodsIDList[4][1])
        this.page2Ani:Rebind();
        this.page2Ani.enabled = true
    else
        this.page2TextTitle.text = LuaMgr.GetLangText("NewPlayerLimitBreakPopup_1")
        table.insert(idList, NewPlayerLimitBreakMgr.GoodsIDList[5][1])
        table.insert(idList, NewPlayerLimitBreakMgr.GoodsIDList[6][1])
        this.page2Ani:Rebind();
        this.page2Ani.enabled = true
    end
    this.SetRewardList(idList)
    this.SetRewardItems()
    if (page == 1) then
        this.SetCharacterItems()
    end
end

this.SetRewardList = function(_IdList)
    this.rewardList = {}
    for i, v in ipairs(_IdList) do
        local cache = {}
        cache.id = v
        cache.type = i
        cache.config = ConfigMgr.Config.charge[v]
        cache.state = NewPlayerLimitBreakMgr.GetGoodsStatus(v)
        cache.containerType = this.curPage
        table.insert(this.rewardList, cache)
    end
end

this.RefreshReward = function()
    NewPlayerLimitBreakMgr.RefreshData()
    for i, v in ipairs(this.rewardList) do
        v.state = NewPlayerLimitBreakMgr.GetGoodsStatus(v.id)
    end
    this.SetRewardItems()
    if (this.curPage == 1) then
        this.SetCharacterItems()
    end
end

this.SetRewardItems = function()
    if (this.rewardItems ~= nil) then
        for k, v in pairs(this.rewardItems) do
            v.rewardObj:Hide();
            SetActive(v.go, false)
        end
    end
    if (#this.rewardList > 0) then
        local num = 0
        for i, v in ipairs(this.rewardList) do
            this.CheckState(v)
            for key, value in ipairs(v.config.Reward) do
                num = num + 1
                local itemConfig = table.Copy(ConfigMgr.Config.itemMap[value.id]);
                itemConfig.count0 = value.count;
                local obj = this.GetRewardItems(num)
                local softText = nil
                if (v.containerType == 1 and v.type == 1) then
                    softText = this.page1GetBtn1TextSt
                    this.SetRewardData1(obj, v, itemConfig)
                end
                if (v.containerType == 1 and v.type == 2) then
                    softText = this.page1GetBtn2TextSt
                    this.SetRewardData2(obj, v, itemConfig)
                end
                if ((v.containerType == 2 or v.containerType == 3) and v.type == 1) then
                    softText = this.page2GetBtn1TextSt
                    this.SetRewardData3(obj, v, itemConfig)
                end
                if ((v.containerType == 2 or v.containerType == 3) and v.type == 2) then
                    softText = this.page2GetBtn2TextSt
                    this.SetRewardData4(obj, v, itemConfig)
                end
                local str = NewPlayerLimitBreakMgr.GetGoodsPriceStr(v.id)
                if (str == "") then
                    str = v.state == 3 and LuaMgr.GetLangText("NewPlayerLimitBreakPopup_2") or
                    LuaMgr.GetLangText("NewPlayerLimitBreakPopup_3")
                end
                softText.text = str
                local cacheColor = softText.color
                softText.color = v.state ~= 3 and UnityEngine.Color(cacheColor.r, cacheColor.g, cacheColor.b, 1) or
                    UnityEngine.Color(cacheColor.r, cacheColor.g, cacheColor.b, 0.6)
                SetActive(obj.go, true)
            end
        end
    end
end

this.CheckState = function(data)
    if (data.containerType == 1 and data.type == 1) then
        SetActive(this.page1GetBtn1St1, data.state == 2)
        SetActive(this.page1GetBtn1St2, data.state == 3)
        SetActive(this.page1GetBtn1St3, data.state == 1)
    end
    if (data.containerType == 1 and data.type == 2) then
        SetActive(this.page1GetBtn2St1, data.state == 2)
        SetActive(this.page1GetBtn2St2, data.state == 3)
        SetActive(this.page1GetBtn2St3, data.state == 1)
    end
    if ((data.containerType == 2 or data.containerType == 3) and data.type == 1) then
        SetActive(this.page2GetBtn1St1, data.state == 2)
        SetActive(this.page2GetBtn1St2, data.state == 3)
        SetActive(this.page2GetBtn1St3, data.state == 1)
    end
    if ((data.containerType == 2 or data.containerType == 3) and data.type == 2) then
        SetActive(this.page2GetBtn2St1, data.state == 2)
        SetActive(this.page2GetBtn2St2, data.state == 3)
        SetActive(this.page2GetBtn2St3, data.state == 1)
    end
end

this.GetRewardItems = function(index)
    if (this.rewardItems == nil) then
        this.rewardItems = {}
    end
    if (this.rewardItems[index] == nil) then
        local go = GameObject.Instantiate(this.goodsItem)
        local cache = {}
        cache.go = go
        cache.group = go.transform:Find("Group"):GetComponent("CanvasGroup");
        cache.box = go.transform:Find("Group/box"):GetComponent("Transform");
        cache.get = go.transform:Find("Group/ImageFinish").gameObject;
        cache.rewardObj = GoodsDataItem.New(cache.box);
        this.rewardItems[index] = cache
    end
    local obj = this.rewardItems[index]
    return obj
end

this.SetRewardData1 = function(_obj, _data, _config)
    _obj.go.transform:SetParent(this.page1GetBtn1Tras, false);
    _obj.go.transform.localPosition = Vector3(-40, 40, 0)
    _obj.rewardObj:SetData(1, _config, 1, false, Vector3(0.8, 0.8, 0.8), false);
    SetActive(_obj.get, _data.state == 3)
    _obj.group.alpha = _data.state == 3 and 0.6 or 1;
end

this.SetRewardData2 = function(_obj, _data, _config)
    _obj.go.transform:SetParent(this.page1Content2, false);
    _obj.rewardObj:SetData(1, _config, 1, false, Vector3(0.5, 0.5, 0.5), false);
    SetActive(_obj.get, _data.state == 3)
    _obj.group.alpha = _data.state == 3 and 0.6 or 1;
end

this.SetRewardData3 = function(_obj, _data, _config)
    _obj.go.transform:SetParent(this.page2Content1, false);
    _obj.rewardObj:SetData(1, _config, 1, false, Vector3(0.8, 0.8, 0.8), false);
    SetActive(_obj.get, _data.state == 3)
    _obj.group.alpha = _data.state == 3 and 0.6 or 1;
end

this.SetRewardData4 = function(_obj, _data, _config)
    _obj.go.transform:SetParent(this.page2Content2, false);
    _obj.rewardObj:SetData(1, _config, 1, false, Vector3(0.8, 0.8, 0.8), false);
    SetActive(_obj.get, _data.state == 3)
    _obj.group.alpha = _data.state == 3 and 0.6 or 1;
end

this.SetCharacterItems = function()
    if (this.characterItems ~= nil) then
        for k, v in pairs(this.characterItems) do
            SetActive(v.go, false)
        end
    end
    for k, v in ipairs(NewPlayerLimitBreakMgr.NewbieGiftCharacter) do
        local heroConfig = ConfigMgr.Config.characterTable[v];
        local obj = this.GetCharacterItems(k)
        obj.imageIcon.texture = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(heroConfig.id, heroConfig.id .. "001"))
        obj.imageType.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. heroConfig.job)
        obj.textName.text = LuaMgr.GetLangText(heroConfig.namelan)
        obj.btn.onClick:RemoveAllListeners();
        obj.CacheCommand = function()
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel", heroConfig.id);
        end
        LuaMgr.AddClick(obj.btn, obj.CacheCommand)
        SetActive(obj.go, true)
    end
end

this.GetCharacterItems = function(index)
    if (this.characterItems == nil) then
        this.characterItems = {}
    end
    if (this.characterItems[index] == nil) then
        local go = GameObject.Instantiate(this.characterItem)
        local cache = {}
        cache.go = go
        cache.btn = go.transform:GetComponent("Button");
        cache.imageIcon = go.transform:Find("Group/ImageIcon"):GetComponent("RawImage");
        cache.imageType = go.transform:Find("Group/ImageType"):GetComponent("Image");
        cache.textName = go.transform:Find("Group/TextName"):GetComponent("Text");
        this.characterItems[index] = cache
        go.transform:SetParent(this.page1Content1, false);
    end
    local obj = this.characterItems[index]
    return obj
end


this.OnBack = function()
    LuaMgr.HidePanel(UIName.NewPlayerLimitBreakPopup);
end

this.OnLeftBtnClick = function()
    if (this.curPage > 1) then
        this.SwitchPage(this.curPage - 1)
    else
        this.SwitchPage(1)
    end
end

this.OnRightBtnClick = function()
    if (this.curPage < 3) then
        this.SwitchPage(this.curPage + 1)
    else
        this.SwitchPage(3)
    end
end

this.Onpage1GetBtn1Click = function()
    this.PayCharge(this.rewardList[1])
end

this.Onpage1GetBtn2Click = function()
    this.PayCharge(this.rewardList[2])
end

this.Onpage2GetBtn1Click = function()
    this.PayCharge(this.rewardList[1])
end

this.Onpage2GetBtn2Click = function()
    this.PayCharge(this.rewardList[2])
end



this.PayCharge = function(data)
    if (data.state == NewPlayerLimitBreakMgr.GoodsStatus.Lock) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23904"))
        return
    elseif (data.state == NewPlayerLimitBreakMgr.GoodsStatus.Bought) then
        return
    end
    if (data.config.ChargeGroup ~= nil and data.config.ChargeGroup ~= "") then
        local id = data.id
        if this.isPaying then
            return
        end;
        this.chargeId = id
        this.isPaying = true;
        LuaMgr.LuaOnAskPay(id);
    else
        this.ShopDirectBuy(data.config)
    end
end

this.ShopDirectBuy = function(_config)
    local charge = _config
    if charge == nil then
        this.isPaying = false;
        return
    end
    if charge.UnlockLv > 0 and DataMgr.Player.level < charge.UnlockLv then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ShopGiftViewModel_3"))
        this.isPaying = false;
        return;
    end

    if DataHelper.GetItemCountById(charge.Cost.id) < charge.Cost.count then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ShopGiftViewModel_4"))
        this.isPaying = false;
        return;
    end

    local askData = { goods = _config.Id }
    ApiMgr.Request("shop/direct_buy", askData, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        this.RefreshReward();
    end, function()
        this.isPaying = false;
    end, true);
end


local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.closeBtn, this.OnBack);
        LuaMgr.AddClick(this.leftBtn, this.OnLeftBtnClick);
        LuaMgr.AddClick(this.rightBtn, this.OnRightBtnClick);
        LuaMgr.AddClick(this.page1GetBtn1, this.Onpage1GetBtn1Click);
        LuaMgr.AddClick(this.page1GetBtn2, this.Onpage1GetBtn2Click);
        LuaMgr.AddClick(this.page2GetBtn1, this.Onpage2GetBtn1Click);
        LuaMgr.AddClick(this.page2GetBtn2, this.Onpage2GetBtn2Click);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.AddTimer(TimerConst.NewPlayerLimitSSRTimer, this.UpdateLeftTimer, 1, -1, true)
        NewPlayerLimitBreakMgr.OnFirstMainPage()
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveTimer(TimerConst.NewPlayerLimitSSRTimer);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnBack);
        LuaMgr.RemoveClick(this.leftBtn, this.OnLeftBtnClick);
        LuaMgr.RemoveClick(this.rightBtn, this.OnRightBtnClick);
        LuaMgr.RemoveClick(this.page1GetBtn1, this.Onpage1GetBtn1Click);
        LuaMgr.RemoveClick(this.page1GetBtn2, this.Onpage1GetBtn2Click);
        LuaMgr.RemoveClick(this.page2GetBtn1, this.Onpage2GetBtn1Click);
        LuaMgr.RemoveClick(this.page2GetBtn2, this.Onpage2GetBtn2Click);
    end
}

this.PayOrder = function(data)
    if data.Length == 2 then
        local reChargeId = tostring(data[0]);
        this.order = tostring(data[1]);
        if this.chargeId ~= reChargeId then return end;
        if LuaMgr.GetPlatform() ~= "EDITOR" then return end;
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.AddTimer(TimerConst.FristPayRechargeStatus, this.OnTimer, 1, 100, true);
    end
end

this.OnTimer = function()
    local askData = { order = this.order }
    ApiMgr.Request("check_recharge_status", askData, true, function(result)
        local re = json.decode(result);
        if re.result.status == 2 then
            LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
            local rewards = re.result.rewards;
            if rewards ~= nil then
                local data = json.encode(rewards);
                LuaMgr.ShowItemRewared(data);
            end
            this.isPaying = false;
            this.RefreshReward();
        end
    end, nil, true);
end

this.OnPayResult = function(data)
    if data.Length == 1 then
        if this.order ~= nil and this.order ~= tostring(data[0]) then return end;
        this.isPaying = false;
    end
end

this.OnPaySuccess = function(data)
    if data.Length == 1 then
        if this.order ~= nil and this.order ~= tostring(data[0]) then return end;
        this.isPaying = false;
        this.RefreshReward();
    end
end

this.UpdateLeftTimer = function()
    local curTime = LuaMgr.Timestamp()
    local minLeftTime = 0
    if (NewPlayerLimitBreakMgr.NewbieGiftDisplayTime > 0) then
        minLeftTime = NewPlayerLimitBreakMgr.NewbieGiftDisplayTime + NewPlayerLimitBreakMgr.NewbieGiftContinueTime -
            curTime
    end
    if minLeftTime <= 0 then
        this.leftTimerText.text = ""
        return
    end
    this.leftTimerText.text = TimeString(minLeftTime)
end



return vm({
    data = data,
    command = command,
    hook = hook
})