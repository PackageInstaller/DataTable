require("Foundation/ViewModel/FoundationMsgBoardItem")

local this = {
    msgSV = nil,
    msgHeight = 360,
    tabType = 1,
    normalColor = UnityEngine.Color(0,0,0,1),
    selectColor = UnityEngine.Color(1,1,1,1),
    operateItem = nil,
    answerData = nil,
}

local objs = {
    closeBtn = { path = "root/Middle/MsgBoard/Close", type = "Button" },
    msgItem = { path = "template/MsgItem", type = "GameObject" },
    title = { path = "root/Middle/MsgBoard/Title", type = "Text" },
    scrollViewTF = { path = "root/Middle/MsgBoard/ScrollView", type = "RectTransform" },
    scrollViewGO = { path = "root/Middle/MsgBoard/ScrollView", type = "GameObject" },
    tabs = { path = "root/Middle/MsgBoard/Tabs", type = "GameObject" },
    allBtn = { path = "root/Middle/MsgBoard/Tabs/All", type = "Button" },
    allText = { path = "root/Middle/MsgBoard/Tabs/All/Text", type = "Text" },
    allIcon = { path = "root/Middle/MsgBoard/Tabs/All/Icon", type = "Image" },
    allSelect = { path = "root/Middle/MsgBoard/Tabs/All/Select", type = "GameObject" },
    friendBtn = { path = "root/Middle/MsgBoard/Tabs/Friend", type = "Button" },
    friendText = { path = "root/Middle/MsgBoard/Tabs/Friend/Text", type = "Text" },
    friendIcon = { path = "root/Middle/MsgBoard/Tabs/Friend/Icon", type = "Image" },
    friendSelect = { path = "root/Middle/MsgBoard/Tabs/Friend/Select", type = "GameObject" },
    strangerBtn = { path = "root/Middle/MsgBoard/Tabs/Stranger", type = "Button" },
    strangerText = { path = "root/Middle/MsgBoard/Tabs/Stranger/Text", type = "Text" },
    strangerIcon = { path = "root/Middle/MsgBoard/Tabs/Stranger/Icon", type = "Image" },
    strangerSelect = { path = "root/Middle/MsgBoard/Tabs/Stranger/Select", type = "GameObject" },
    msgInput = { path = "root/Middle/MsgBoard/MsgInput", type = "GameObject" },
    input = { path = "root/Middle/MsgBoard/MsgInput/Input", type = "InputField" },
    inputPlaceholder = { path = "root/Middle/MsgBoard/MsgInput/Input/Placeholder", type = "Text" },
    sendBtn = { path = "root/Middle/MsgBoard/MsgInput/Send", type = "Button" },
    notMsgTF = { path = "root/Middle/MsgBoard/NotMsg", type = "RectTransform" },
    notMsgGO = { path = "root/Middle/MsgBoard/NotMsg", type = "GameObject" },
    settingGO = { path = "root/Middle/MsgBoard/Setting", type = "GameObject" },
    settingBtn = { path = "root/Middle/MsgBoard/Setting", type = "Button" },
    settingArrowUp = { path = "root/Middle/MsgBoard/Setting/ArrowUp", type = "GameObject" },
    settingArrowDown = { path = "root/Middle/MsgBoard/Setting/ArrowDown", type = "GameObject" },
    settingListGO = { path = "root/Middle/MsgBoard/SettingList", type = "GameObject" },
    settingFriendText = { path = "root/Middle/MsgBoard/SettingList/Friend", type = "Text" },
    settingFriendOnGO = { path = "root/Middle/MsgBoard/SettingList/Friend/On", type = "GameObject" },
    settingFriendOnBtn = { path = "root/Middle/MsgBoard/SettingList/Friend/On", type = "Button" },
    settingFriendOffGO = { path = "root/Middle/MsgBoard/SettingList/Friend/Off", type = "GameObject" },
    settingFriendOffBtn = { path = "root/Middle/MsgBoard/SettingList/Friend/Off", type = "Button" },
    settingStrangerOnGO = { path = "root/Middle/MsgBoard/SettingList/Stranger/On", type = "GameObject" },
    settingStrangerOnBtn = { path = "root/Middle/MsgBoard/SettingList/Stranger/On", type = "Button" },
    settingStrangerOffGO = { path = "root/Middle/MsgBoard/SettingList/Stranger/Off", type = "GameObject" },
    settingStrangerOffBtn = { path = "root/Middle/MsgBoard/SettingList/Stranger/Off", type = "Button" },
}


this.SetData = function()
    SetActive(this.settingListGO, false);
    if (FoundationMgr.IsVisitor()) then
        SetActive(this.tabs, false);
        SetActive(this.settingGO, false);
        this.SetInput(1);
        this.tabType = 1;
        this.SetMsgList(true);
    else
        this.SetTab(1);
        SetActive(this.tabs, true);
        this.SetInput(2);
        this.SetSetting();
        this.SetSettingArrow(false);
        SetActive(this.settingGO, true);
    end
end


this.SetInput = function(type)
    local notMsgPos = this.notMsgTF.localPosition;
    if (type == 1) then
        this.msgHeight = 360;
        this.scrollViewTF.anchoredPosition = Vector2(0, -70);
        notMsgPos.y = 36;
        local messageLength = ConfigMgr.Config.FriendConstants.MessageLength;
        this.input.characterLimit = messageLength;
        this.inputPlaceholder.text = string.format(LuaMgr.GetLangText("FoundationMsgBoardViewModel_0"), messageLength);
        SetActive(this.msgInput, true);
    elseif (type == 2) then
        this.msgHeight = 360;
        this.scrollViewTF.anchoredPosition = Vector2(0, -118);
        notMsgPos.y = -12;
        SetActive(this.msgInput, false);
    elseif (type == 3) then
        this.msgHeight = 315;
        this.scrollViewTF.anchoredPosition = Vector2(0, -118);
        notMsgPos.y = 16;
        local replyLength = ConfigMgr.Config.FriendConstants.ReplyLength;
        this.input.characterLimit = replyLength;
        this.inputPlaceholder.text = string.format(LuaMgr.GetLangText("FoundationMsgBoardViewModel_1"), replyLength);
        SetActive(this.msgInput, true);
    end
    this.msgSV:SetParams(760, this.msgHeight);
    this.msgSV:Refresh();
    this.notMsgTF.localPosition = notMsgPos;
end


this.SetTab = function(tabType)
    this.tabType = tabType;
    if (tabType == 1) then
        SetActive(this.allSelect, true);
        SetActive(this.friendSelect, false);
        SetActive(this.strangerSelect, false);
        this.allText.color = this.selectColor;
        this.friendText.color = this.normalColor;
        this.strangerText.color = this.normalColor;
        this.allIcon.color = this.selectColor;
        this.friendIcon.color = this.normalColor;
        this.strangerIcon.color = this.normalColor;
    elseif (tabType == 2) then
        SetActive(this.allSelect, false);
        SetActive(this.friendSelect, true);
        SetActive(this.strangerSelect, false);
        this.allText.color = this.normalColor;
        this.friendText.color = this.selectColor;
        this.strangerText.color = this.normalColor;
        this.allIcon.color = this.normalColor;
        this.friendIcon.color = this.selectColor;
        this.strangerIcon.color = this.normalColor;
    elseif (tabType == 3) then
        SetActive(this.allSelect, false);
        SetActive(this.friendSelect, false);
        SetActive(this.strangerSelect, true);
        this.allText.color = this.normalColor;
        this.friendText.color = this.normalColor;
        this.strangerText.color = this.selectColor;
        this.allIcon.color = this.normalColor;
        this.friendIcon.color = this.normalColor;
        this.strangerIcon.color = this.selectColor;
    end
    this.SetMsgList(true);
end


this.SetMsgList = function(reset)
    this.msgSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local dataList = FoundationMsgMgr.GetDataList(this.tabType);
    local len = #dataList;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.msgItem, "FoundationMsgBoardItem", 760, 104, dataList[i]);
        table.insert(scrollDatas, scrollData);
    end
    this.msgSV:SetParams(760, this.msgHeight);
    this.msgSV:SetData(scrollDatas, reset);
    local titleStr = LuaMgr.GetLangText("FoundationMsgBoardViewModel_6");
    if (FoundationMgr.IsVisitor()) then
        this.title.text = titleStr;
    else
        this.title.text = string.format(LuaMgr.GetLangText("FoundationMsgBoardViewModel_7"), titleStr, len, ConfigMgr.Config.FriendConstants.MaxMessageCount);
    end
    SetActive(this.notMsgGO, len <= 0);
end


this.SetSetting = function()
    local settingFriend = PlayerFoundationMgr.GetSettingFriend();
    local settingStranger = PlayerFoundationMgr.GetSettingStranger();
    this.settingFriendText.text = ConfigMgr.LangGlobal(settingFriend and "17017" or "17018")
    SetActive(this.settingFriendOnGO, settingFriend);
    SetActive(this.settingFriendOffGO, not settingFriend);
    SetActive(this.settingStrangerOnGO, settingStranger);
    SetActive(this.settingStrangerOffGO, not settingStranger);
end


this.SetSettingArrow = function(status)
    if (status) then
        SetActive(this.settingArrowUp, true);
        SetActive(this.settingArrowDown, false);
    else
        SetActive(this.settingArrowUp, false);
        SetActive(this.settingArrowDown, true);
    end
end


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.FoundationMsgBoardViewModel);
end


this.OnClickSend = function()
    local msg = this.input.text;
    if (this.answerData ~= nil) then
        if (IsNullOrEmpty(msg)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationMsgBoardViewModel_2"));
            return;
        end
        local len = LuaMgr.GetStringLength(msg);
        if (len > ConfigMgr.Config.FriendConstants.ReplyLength) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationMsgBoardViewModel_3"));
            return;
        end
        PlayerFoundationMgr.VisitLeaveMessageAnswer(this.answerData.Id, msg, this.VisitLeaveMessageAnswerResponse);
        return;
    end
    if (IsNullOrEmpty(msg)) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationMsgBoardViewModel_4"));
        return;
    end
    local len = LuaMgr.GetStringLength(msg);
    if (len > ConfigMgr.Config.FriendConstants.MessageLength) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationMsgBoardViewModel_5"));
        return;
    end
    PlayerFoundationMgr.VisitLeaveMessage(msg, this.VisitLeaveMessageResponse);
end


this.VisitLeaveMessageResponse = function(result)
    this.input.text = "";
    PlayerFoundationMgr.VisitLeaveMessageList(nil, true);
end


this.VisitLeaveMessageAnswerResponse = function(result)
    this.input.text = "";
    this.answerData = nil;
    this.SetInput(2);
    PlayerFoundationMgr.VisitLeaveMessageList(DataMgr.Player.uid, false);
end


this.OnClickAll = function()
    this.SetTab(1);
end


this.OnClickFriend = function()
    this.SetTab(2);
end


this.OnClickStranger = function()
    this.SetTab(3);
end


this.OnClickSetting = function()
    if (this.settingListGO.activeSelf) then
        this.SetSettingArrow(false);
        SetActive(this.settingListGO, false);
    else
        this.SetSettingArrow(true);
        SetActive(this.settingListGO, true);
    end
end


this.OnClickFriendOn = function()
    PlayerFoundationMgr.SetSettingFriend(false);
    PlayerFoundationMgr.SetLeaveMessage(this.SetSetting);
end


this.OnClickFriendOff = function()
    PlayerFoundationMgr.SetSettingFriend(true);
    PlayerFoundationMgr.SetLeaveMessage(this.SetSetting);
end


this.OnClickStrangerOn = function()
    PlayerFoundationMgr.SetSettingStranger(false);
    PlayerFoundationMgr.SetLeaveMessage(this.SetSetting);
end


this.OnClickStrangerOff = function()
    PlayerFoundationMgr.SetSettingStranger(true);
    PlayerFoundationMgr.SetLeaveMessage(this.SetSetting);
end


this.OnOperate = function(args)
    local item = args[0];
    if (this.operateItem ~= nil and this.operateItem ~= item) then
        this.operateItem:SetOperate(false);
        this.operateItem = nil;
    end
    local type = args[1];
    if (type == 0) then
        this.operateItem = item;
        item:SetOperate(not item.isOperate);
    else
        this.operateItem = nil;
        item:SetOperate(false);
        if (type == 1) then
            local isTop = item.data.Order == 0 and true or false;
            PlayerFoundationMgr.SetMessageTop(item.data.Id, isTop, this.SetMessageTopResponse);
        elseif (type == 2) then
            this.answerData = item.data;
            this.SetInput(3);
        elseif (type == 3) then
            PlayerFoundationMgr.VisitRemoveMessage(item.data.Id, this.VisitRemoveMessageResponse);
        end
    end
end


this.VisitRemoveMessageResponse = function(result)
    PlayerFoundationMgr.VisitLeaveMessageList(DataMgr.Player.uid, true);
end


this.SetMessageTopResponse = function(result)
    PlayerFoundationMgr.VisitLeaveMessageList(DataMgr.Player.uid, true);
end


this.OnRefresh = function(args)
    this.SetMsgList(args[0]);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.msgSV = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
        LuaMgr.AddClick(this.sendBtn, this.OnClickSend);
        LuaMgr.AddClick(this.allBtn, this.OnClickAll);
        LuaMgr.AddClick(this.friendBtn, this.OnClickFriend);
        LuaMgr.AddClick(this.strangerBtn, this.OnClickStranger);
        LuaMgr.AddClick(this.settingBtn, this.OnClickSetting);
        LuaMgr.AddClick(this.settingFriendOnBtn, this.OnClickFriendOn);
        LuaMgr.AddClick(this.settingFriendOffBtn, this.OnClickFriendOff);
        LuaMgr.AddClick(this.settingStrangerOnBtn, this.OnClickStrangerOn);
        LuaMgr.AddClick(this.settingStrangerOffBtn, this.OnClickStrangerOff);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.FoundationMsgBoardOperate, this.OnOperate);
        LuaMgr.AddUIEventListener(UIEventConst.FoundationMsgBoardRefresh, this.OnRefresh);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationMsgBoardOperate, this.OnOperate);
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationMsgBoardRefresh, this.OnRefresh);
        this.msgSV:Clear(true);
        this.operateItem = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        LuaMgr.RemoveClick(this.sendBtn, this.OnClickSend);
        LuaMgr.RemoveClick(this.allBtn, this.OnClickAll);
        LuaMgr.RemoveClick(this.friendBtn, this.OnClickFriend);
        LuaMgr.RemoveClick(this.strangerBtn, this.OnClickStranger);
        LuaMgr.RemoveClick(this.settingBtn, this.OnClickSetting);
        LuaMgr.RemoveClick(this.settingFriendOnBtn, this.OnClickFriendOn);
        LuaMgr.RemoveClick(this.settingFriendOffBtn, this.OnClickFriendOff);
        LuaMgr.RemoveClick(this.settingStrangerOnBtn, this.OnClickStrangerOn);
        LuaMgr.RemoveClick(this.settingStrangerOffBtn, this.OnClickStrangerOff);
        UIScrollView.ClearItem("FoundationMsgBoardItem");
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})