require("ViewModel/YPS/YPSExploreItem")
local this = {
    chapterUIList = nil,
    medalList = {},
    itemObjList = {},
    manObj = nil,
    womanObj = nil,
    chatTimes = 0,
    selectChatIndex = 0,
    rewardItems = {},
    oldState = false,
};

local objs = {
    chapterItem = { path = "template/ChapterItem", type = "GameObject" },
    rewardItemObj = { path = "template/RewardItem", type = "GameObject" },
    charaPos = { path = "root/SVChapter/Viewport/charaPos", type = "RectTransform" },
    spineBody = { path = "root/SVChapter/Viewport/charaPos/Body", type = "UISpineCharacter" },
    tranContentB = { path = "root/SVChapterB/Viewport/tranContent", type = "RectTransform" },
    tranCityB = { path = "root/SVChapterB/Viewport/tranContent/tranCity", type = "RawImage" },
    tranContentM = { path = "root/SVChapterM/Viewport/tranContent", type = "RectTransform" },
    tranCityM = { path = "root/SVChapterM/Viewport/tranContent/tranCity", type = "RawImage" },
    tranContent = { path = "root/SVChapter/Viewport/tranContent", type = "RectTransform" },
    tranCity = { path = "root/SVChapter/Viewport/tranContent/tranCity", type = "RawImage" },
    traneffect = { path = "root/SVChapter/Viewport/tranContent/tranCity/Traneffect", type = "Transform" },
    itemBox = { path = "root/itemBox", type = "RectTransform" },
    chatPanel = { path = "root/Middle/ChatPanel", type = "GameObject" },
    comfirmBtn = { path = "root/Middle/ChatPanel/ChatBox/comfirmBtn", type = "Button" },
    chatPanelBtn = { path = "root/Middle/ChatPanel/ChatBox/bgBtn", type = "Button" },
    textChat = { path = "root/Middle/ChatPanel/ChatBox/TextChat", type = "Text" },
    rewardBox = { path = "root/Middle/ChatPanel/ChatBox/RewardBox", type = "Transform" },
    chatBox = { path = "root/Middle/ChatPanel/ChatBox", type = "GameObject" },
    chooseBox = { path = "root/Middle/ChatPanel/ChoosePanel", type = "GameObject" },
    chooseBtn1 = { path = "root/Middle/ChatPanel/ChoosePanel/ChooseBox/Choose1", type = "Button" },
    chooseBtn2 = { path = "root/Middle/ChatPanel/ChoosePanel/ChooseBox/Choose2", type = "Button" },
    chooseBtn3 = { path = "root/Middle/ChatPanel/ChoosePanel/ChooseBox/Choose3", type = "Button" },
    chooseText1 = { path = "root/Middle/ChatPanel/ChoosePanel/ChooseBox/Choose1/Bg/Text", type = "Text" },
    chooseText2 = { path = "root/Middle/ChatPanel/ChoosePanel/ChooseBox/Choose2/Text", type = "Text" },
    chooseText3 = { path = "root/Middle/ChatPanel/ChoosePanel/ChooseBox/Choose3/Text", type = "Text" },
    characterObj = { path = "root/Middle/ChatPanel/Character", type = "GameObject" },
    spineCharacter = { path = "root/Middle/ChatPanel/Character/Body", type = "UISpineCharacter" },
    spineRawImg = { path = "root/Middle/ChatPanel/Character/Body", type = "UIRefRawImage" },
    maskChatBtn = { path = "root/Middle/ChatPanel/MaskBtn", type = "Button" },
    touchEvent = { path = "root/Touch", type = "EventTriggerListener" },
    touchGroup = { path = "root/Touch/Group", type = "GameObject" },
    touchTarget = { path = "root/Touch/Group/target", type = "Transform" },
    touchLeft = { path = "root/Touch/Group/Left", type = "GameObject" },
    touchRight = { path = "root/Touch/Group/Right", type = "GameObject" },
    imgFinishGo = { path = "root/Middle/ImgFinish", type = "GameObject" },
    textFinish = { path = "root/Middle/ImgFinish/TextFinish", type = "Text" },
};



this.SetData = function()
    this.groupList = YPSMgr.GetGroupsByYPS("YPS01");
    this.SetChapterList()
    this.SetCharacter()
end

this.SetChapterList = function()
    local curGroup = this.groupList[this.chapterIndex];
    this.eventList = YPSMgr.GetEventsByGroupId(curGroup.id)
    if this.eventList == nil or #this.eventList == 0 then return end;
    this.chapterUIList:Clear();
    local list = {}
    local unLockIndex = 1
    local finishNum = 0
    for i, v in ipairs(this.eventList) do
        local pUnLock = YPSMgr.CheckEventIsUnLock(v);
        local pPass = YPSMgr.CheckEventIsComplete(v);
        if ((pUnLock == true and not pPass)) then
            unLockIndex = i
        end
        if (pPass) then
            finishNum = finishNum + 1
        end
        local eventItem = {
            index = i,
            iconName = v.statusIcon,
            config = v,
            isPass = pPass,
            locPos = YPSMgr.GetEventLocPosition(v.classId),
            callBack = this.CityCallBack,
        }
        local eventData = UIListData.GetData(this.chapterItem, "YPSExploreItem", eventItem);
        if (pUnLock) then
            table.insert(list, eventData);
        end
    end
    this.chapterUIList:SetData(list);
    this.SetMapPos(unLockIndex, false)
    if (finishNum == #this.eventList) then
        this.textFinish.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29124")
    else
        this.textFinish.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29123")
    end

end



this.CityCallBack = function(index)
    local event = this.eventList[index];
    if event == nil then return end;
    if (event.type == 1) then
        LuaMgr.PlayNovel(event.eventParam, function()
            LuaMgr.ShowLuaPanel(UIName.YPSExploreViewModel, this.chapterIndex);
        end);
    else
        this.InitChatPanel(event)
    end











end


this.SetMapPos = function(moveIndex, bAnim, callback)
    local item = nil
    for k, v in pairs(this.chapterUIList.itemList) do
        if (v.data.index == moveIndex) then
            item = v
            break
        end
    end
    if item == nil then return end

    local itemPos = item.transform.anchoredPosition
    local W = this.screenWidth
    local maxMainX = (2500 - W) / 2
    local maxMX = (2250 - W) / 2
    local maxBX = (2000 - W) / 2
    local targetX = math.min(math.max(-itemPos.x, -maxMainX), maxMainX)
    local startX = this.tranContent.anchoredPosition.x
    local progress = targetX / maxMainX
    local origY = this.tranContent.anchoredPosition.y
    local origMY = this.tranContentM.anchoredPosition.y
    local origBY = this.tranContentB.anchoredPosition.y
    local origCY = this.charaPos.anchoredPosition.y

    local function UpdateLayers(curX, curProgress)
        this.tranContent.anchoredPosition = Vector2(curX, origY)
        this.tranContentM.anchoredPosition = Vector2(curProgress * maxMX, origMY)
        this.tranContentB.anchoredPosition = Vector2(curProgress * maxBX, origBY)
        local itemOnScreenX = curX + itemPos.x
        this.charaPos.anchoredPosition = Vector2(itemOnScreenX - 150, origCY)
        this.itemBox.anchoredPosition = this.tranContent.anchoredPosition
    end

    if (bAnim) then
        if this.tweener2 ~= nil then this.tweener2:Kill() end
        local distance = math.abs(targetX - startX)
        local moveSpeed = 300
        local duration = math.max(0.6, distance / moveSpeed)
        this.SwichBodyState(true)
        this.tweener2 = DOTWeen.To(function() return this.tranContent.anchoredPosition.x end,
            function(x)
                local p = x / maxMainX
                UpdateLayers(x, p)
            end, targetX, duration):SetEase(Ease.Linear)
        this.tweener2.onComplete = function()
            if (callback ~= nil) then
                callback()
                this.SwichBodyState(false)
            end
        end
    else
        UpdateLayers(targetX, progress)
    end
end

this.ShowItems = function(bShow)
    for k, v in pairs(this.chapterUIList.itemList) do
        SetActive(v.gameObject, bShow);
    end
end

this.InitChatPanel = function(event)
    SetActive(this.chatPanel, true)
    this.ShowItems(false)
    if (event.type == 2 or event.type == 6) then
        SetActive(this.rewardBox.gameObject, true)
        SetActive(this.comfirmBtn.gameObject, true)
        SetActive(this.characterObj, true)
        this.chatPanelBtn.enabled = false
        this.maskChatBtn.enabled = true
        this.textChat.text = LuaMgr.GetLangText(event.descriptionlan)
        this.curSelectedItem = event
        this.SetRewardItems(event, this.rewardBox)
    else

        SetActive(this.rewardBox.gameObject, false)
        SetActive(this.comfirmBtn.gameObject, false)
        this.chatPanelBtn.enabled = true
        this.maskChatBtn.enabled = false
        this.chatTimes = 0
        this.selectChatIndex = 0
        this.chatList = YPSMgr.GetChatListByGroupType(event.eventParam)
        this.OnClickChat()
    end
end

this.SetRewardItems = function(_config, _container)
    local rewardConfigList = {}
    local itemDataLis = {}
    local isFirst = false
    local isFinish = false
    local dropShow = nil
    local record = DataMgr.Player.dungeonRecords[_config.eventParam];
    local dungeonConfig = ConfigMgr.Config.dungeonMap[_config.eventParam]
    if (record == nil or record.completeCount == 0) then
        isFirst = true
        dropShow = dungeonConfig.firstDropShow;
    else
        dropShow = dungeonConfig.fixedDropShow;
    end
    itemDataLis = NumTool.split(dropShow, ';')
    for i = 1, #itemDataLis do
        local itemData = table.Copy(ConfigMgr.Config.itemMap[itemDataLis[i]]);
        table.insert(rewardConfigList, itemData)
    end
    if (this.rewardItems ~= nil) then
        for k, v in pairs(this.rewardItems) do
            v.rewardObj:Hide();
            SetActive(v.go, false)
        end
    end
    if (#rewardConfigList > 0) then
        SetActive(_container.gameObject, true)
        for i, v in ipairs(rewardConfigList) do
            if (this.rewardItems == nil) then
                this.rewardItems = {}
            end
            if (this.rewardItems[i] == nil) then
                local go = GameObject.Instantiate(this.rewardItemObj)
                local cache = {}
                cache.go = go
                cache.box = go.transform:Find("reward"):GetComponent("Transform");
                cache.get = go.transform:Find("get").gameObject;
                cache.first = go.transform:Find("first").gameObject;
                cache.rewardObj = GoodsDataItem.New(cache.box);
                this.rewardItems[i] = cache
            end
            local obj = this.rewardItems[i]
            obj.go.transform:SetParent(_container, false);
            obj.rewardObj:SetData(1, v, 1, false, Vector3(0.6, 0.6, 0.6), false, true);

            SetActive(obj.get, isFinish)
            SetActive(obj.first, isFirst)
            SetActive(obj.go, true)
        end
    else
        SetActive(_container.gameObject, false)
    end
end

this.OnClickChat = function()
    this.chatTimes = this.chatTimes + 1
    local totalNum = #this.chatList
    if this.chatTimes > totalNum then
        local chatConfig = this.chatList[totalNum]
        if (DataMgr.Player.CookGame.ChatRewards[chatConfig.GroupType] ~= nil) then
            SetActive(this.chatPanel, false)
            this.ShowItems(true)
            return
        end
        ApiMgr.Request("cookgame/chatGameRewards", { GroupType = chatConfig.GroupType }, true, function(re)
            local re = json.decode(re);
            local data = json.encode(re.result.Rewards);
            LuaMgr.ShowItemRewared(data);
            SetActive(this.chatPanel, false)
            this.ShowItems(true)
            this.SetChapterList()
        end, nil, true)
    else
        local chatConfig = this.chatList[this.chatTimes]
        SetActive(this.characterObj, true)
        this.CheckCharacterTalk(chatConfig.Position == 1)
        SetActive(this.chatBox, true)
        SetActive(this.chooseBox, chatConfig.ChatType ~= 1)
        local chatChooseList = NumTool.split(chatConfig.Text, '_')
        if (chatConfig.ChatType == 1) then
            if (#chatChooseList > 1 and this.selectChatIndex ~= nil) then
                this.textChat.text = chatChooseList[this.selectChatIndex]
                this.selectChatIndex = nil
            else
                this.textChat.text = chatChooseList[1]
            end
        else
            for i = 1, 3 do
                if (i <= #chatChooseList) then
                    SetActive(this["chooseBtn" .. i].gameObject, true)
                    this["chooseText" .. i].text = chatChooseList[i]
                else
                    SetActive(this["chooseBtn" .. i].gameObject, false)
                end
            end
        end
    end
end

this.OnClickComfirm = function()
    if (this.curSelectedItem) then
        BattlePrepareMgr.EnterBattlePrepare(this.curSelectedItem.id, this.curSelectedItem.eventParam)
        this.curSelectedItem = nil
    end
end

this.ChooseBtnClick1 = function()
    this.selectChatIndex = 1
    this.OnClickChat()
end

this.ChooseBtnClick2 = function()
    this.selectChatIndex = 2
    this.OnClickChat()
end

this.ChooseBtnClick3 = function()
    this.selectChatIndex = 2
    this.OnClickChat()
end

this.SetCharacter = function()
    local skinId = "V0172001";
    this.spineBody:SetBattle(skinId, skinId, "-1", 0, function()
        this.spineBody:Play("idle", true, nil);
    end)
    this.spineCharacter:SetDrawingFace("V0172", "V0172001_novel", 7, 16, 0);
end

this.CheckCharacterTalk = function(isTalk)
    local num = isTalk and 1 or 160 / 255
    this.spineRawImg.color = UnityEngine.Color(num, num, num, 1);
end



this.OnBack = function()

    if (this.chatPanel.activeSelf) then
        this.OnClickCloseChat()
        return
    end
    if DataExHelper.CommonActivityCheck(ActivityKey.YPS) then
        LuaMgr.Back(ActivityKey.YPS)
    else
        LuaMgr.Back()
    end
end

this.OnClickCloseChat = function()
    this.ShowItems(true)
    SetActive(this.chatPanel, false)
end


this.ClearTouch = function()
    this.touchPosX = 0;
    this.isTouchDown = false;
    this.touchTarget.localPosition = Vector3.zero;
    this.SwichBodyState(false)
    SetActive(this.touchGroup, false);
    SetActive(this.touchRight, false);
    SetActive(this.touchLeft, false);
end


this.OnTouchDown = function()
    local pos = UnityEngine.Input.mousePosition;
    this.touchPosX = pos.x;
    this.isTouchDown = true;
    SetActive(this.touchGroup, true);
end


this.OnTouchUp = function()
    this.ClearTouch();
end


this.OnTouchLongPress = function()
    if (this.isTouchDown) then
        local pos = UnityEngine.Input.mousePosition
        local W = this.screenWidth
        local maxMainX = (2500 - W) / 2
        local maxMX = (2250 - W) / 2
        local maxBX = (2000 - W) / 2

        local ratio = 1
        local interval = math.abs(this.touchPosX - pos.x)
        if (interval > 150) then interval = 150 end

        if (pos.x > this.touchPosX) then
            ratio = 1
            SetActive(this.touchLeft, false); SetActive(this.touchRight, true)
        elseif (pos.x < this.touchPosX) then
            ratio = -1
            SetActive(this.touchLeft, true); SetActive(this.touchRight, false)
        end

        local moveInterval = interval * ratio * 0.05

        local nextMainX = math.min(math.max(this.tranContent.anchoredPosition.x - moveInterval, -maxMainX), maxMainX)
        local progress = nextMainX / maxMainX


        this.tranContent.anchoredPosition = Vector2(nextMainX, this.tranContent.anchoredPosition.y)
        this.tranContentM.anchoredPosition = Vector2(progress * maxMX, this.tranContentM.anchoredPosition.y)
        this.tranContentB.anchoredPosition = Vector2(progress * maxBX, this.tranContentB.anchoredPosition.y)


        local nextCharX = this.charaPos.anchoredPosition.x + moveInterval
        if (nextCharX < -this.halfWidth + 150) then
            nextCharX = -this.halfWidth + 150
        elseif (nextCharX > this.halfWidth - 150) then
            nextCharX = this.halfWidth - 150
        end

        this.SwichBodyState(interval ~= 0)
        this.charaPos.anchoredPosition = Vector2(nextCharX, this.charaPos.anchoredPosition.y)
        this.charaPos.localScale = Vector3(1 * ratio, 1, 1)
        this.touchTarget.localPosition = Vector3(interval * ratio, 0, 0)
        this.itemBox.anchoredPosition = this.tranContent.anchoredPosition
    end
end

this.SwichBodyState = function(isRun)
    if (this.oldState == isRun) then
        return
    end
    this.oldState = isRun;
    if (isRun) then
        this.spineBody:Play("run", true, nil);
    else
        this.spineBody:Play("idle", true, nil);
    end
end

this.CheckShowItem = function()
    if (this.chapterUIList.itemList ~= nil) then
        local posX = this.charaPos.transform.position.x;
        for k, v in pairs(this.chapterUIList.itemList) do
            local interval = math.abs(posX - v.transform.position.x);
            SetActive(v.gameObject, (interval < 2 or v.data.isPass == true));
        end
    end
end


local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.maskChatBtn, this.OnClickCloseChat);
        LuaMgr.AddClick(this.chatPanelBtn, this.OnClickChat);
        LuaMgr.AddClick(this.comfirmBtn, this.OnClickComfirm)
        for i = 1, 3 do
            LuaMgr.AddClick(this["chooseBtn" .. i], this["ChooseBtnClick" .. i]);
        end
        RedMgr.Singleton:RegisterViewModel(UIName.YPSExploreViewModel);
        this.chapterUIList = UIListView.New(this.itemBox);
        this.touchEvent.onDown = this.OnTouchDown;
        this.touchEvent.onUp = this.OnTouchUp;
        this.touchEvent.onLongPress = this.OnTouchLongPress;
        this.screenWidth = LuaMgr.ScreenWidth();
        this.halfWidth = this.screenWidth / 2;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 0 then
            this.chapterIndex = vm.behaviour.Params[0]
        end
        HeroRedDataHelper.SetYPSRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        SetActive(this.chatPanel, false)

        this.charaPos.localScale = Vector3.one;
        this.tranCity.texture = LuaMgr.GetTexture(string.format(
            "Assets/_BundleResources/Images/YPS/ui_hd_wps_gqcjbg_0%s_1.png", this.chapterIndex));
        this.tranCityB.texture = LuaMgr.GetTexture(string.format(
            "Assets/_BundleResources/Images/YPS/ui_hd_wps_gqcjbg_0%s_3.png", this.chapterIndex));
        this.tranCityM.texture = LuaMgr.GetTexture(string.format(
            "Assets/_BundleResources/Images/YPS/ui_hd_wps_gqcjbg_0%s_2.png", this.chapterIndex));


        for i = 1, this.traneffect.childCount do
            SetActive(this.traneffect:GetChild(i - 1).gameObject, i == this.chapterIndex)
        end
        this.SetData();
        this.ClearTouch()
    end,
    before_deactive = function(vm)
        this.chapterUIList:Clear();
        if this.itemObjList ~= nil then
            for i = 1, #this.itemObjList do
                this.itemObjList[i]:Clear()
            end
            this.itemObjList = {}
        end
        if this.tweener2 ~= nil then
            this.tweener2:Kill();
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.chatPanelBtn, this.OnClickChat);
        LuaMgr.RemoveClick(this.comfirmBtn, this.OnClickComfirm)
        LuaMgr.RemoveClick(this.maskChatBtn, this.OnClickCloseChat);
        for i = 1, 3 do
            LuaMgr.RemoveClick(this["chooseBtn" .. i], this["ChooseBtnClick" .. i]);
        end
        RedMgr.Singleton:RemoveViewModel(UIName.YPSExploreViewModel);
        UIListView.ClearItem("YPSExploreItem");
        if this.spineCharacter ~= nil then
            this.spineCharacter:Clear();
        end
        if this.spineBody ~= nil then
            this.spineBody:Clear();
        end
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.YPS) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end


return vm({
    data = data,
    command = command,
    hook = hook
})