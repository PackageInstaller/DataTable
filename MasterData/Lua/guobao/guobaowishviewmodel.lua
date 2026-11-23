require("GuoBao/GuoBaoWishItem")

local this = {
    wishList = nil,
    msgText = nil,
    selectItem = nil,
    finishEvent = nil,
};

local objs = {
    msgItem = { path = "template/MsgItem", type = "GameObject" },
    msgList = { path = "root/Middle/MsgList", type = "Transform" },
    msgsGO = { path = "root/Middle/Msgs", type = "GameObject" },
    skipBtn = { path = "root/Middle/Msgs/Skip", type = "Button" },
    wishBtn = { path = "root/Middle/Msgs/Wish", type = "Button" },
    wishGO = { path = "root/Middle/Wish", type = "GameObject" },
    wishItem = { path = "template/WishItem", type = "GameObject" },
    wishListTF = { path = "root/Middle/Wish/Group/ScrollView/Viewport/Content", type = "Transform" },
    wishTitle = { path = "root/Middle/Wish/Group/Title", type = "Text" },
    wishCloseBtn = { path = "root/Middle/Wish/Group/Close", type = "Button" },
    wishCancelBtn = { path = "root/Middle/Wish/Group/Cancel", type = "Button" },
    wishConfirmBtn = { path = "root/Middle/Wish/Group/Confirm", type = "Button" },
};


this.SetData = function()
    SetActive(this.msgsGO, true);
    SetActive(this.wishGO, false);
    this.SetWishs();
    this.wishTitle.text = LuaMgr.GetLangText("GuoBaoWishViewModel_0");
end


this.SetWishs = function()
    this.wishList:Clear();
    local guoBaoBulletHellList = ConfigMgr.Config.constants.GuoBaoBulletHellList;
    local len = #guoBaoBulletHellList;
    if (len > 0) then
        local listDatas = {};
        for i = 1, len do
            local listData = UIListData.GetData(this.wishItem, "GuoBaoWishItem", {id=i,text=guoBaoBulletHellList[i],select=false});
            table.insert(listDatas, listData);
        end
        this.wishList:SetData(listDatas);
    end
end


this.OnClickSkip = function()
    LuaMgr.Back();
end


this.OnClickWish = function()
    if (PlayerGuoBaoMgr.GetSimulatedShopWish() == nil) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("GuoBaoWishViewModel_4"));
        return;
    end
    SetActive(this.msgsGO, false);
    SetActive(this.wishGO, true);
    this.wishList:Refresh();
end


this.OnClickWishClose = function()
    SetActive(this.msgsGO, true);
    SetActive(this.wishGO, false);
    this.ClearSelectItem();
end


this.OnClickWishCancel = function()
    SetActive(this.msgsGO, true);
    SetActive(this.wishGO, false);
    this.ClearSelectItem();
end


this.OnClickWishConfirm = function()
    if (this.selectItem == nil) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("GuoBaoWishViewModel_5"));
        return;
    end
    this.finishEvent = PlayerGuoBaoMgr.GetSimulatedShopWish();
    if (this.finishEvent == nil) then return end
    
    PlayerGuoBaoMgr.SimulatedShopWish(this.selectItem.data.id, this.SimulatedShopWishResponse);
end


this.SimulatedShopWishResponse = function(result)
    PlayerGuoBaoMgr.SimulatedShopFinishEvent(this.finishEvent.ID, this.SimulatedShopFinishEventResponse);
    local index = this.selectItem.data.id - 1;
    local playerName = DataMgr.Player.name;
    local msgData = {Id=0, Msg=string.format(this.msgText, playerName, this.GetWishText(index))};
    GuoBaoMsgMgr.AddData(msgData);
    this.OnClickWishClose();
end


this.SimulatedShopFinishEventResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result);
        LuaMgr.ShowItemRewared(reward);
    end
end


this.ClearSelectItem = function()
    if (this.selectItem ~= nil) then
        this.selectItem.data.select = false;
        this.selectItem = nil;
    end
end


this.OnWishSelect = function(args)
    this.ClearSelectItem();
    this.selectItem = args[0];
    this.selectItem.data.select = true;
    this.wishList:Refresh();
end


this.GetWishText = function(index)
    local guoBaoBulletHellList = ConfigMgr.Config.constants.GuoBaoBulletHellList;
    local guoBaoBulletHell = guoBaoBulletHellList[index + 1];
    if (IsNullOrEmpty(guoBaoBulletHell)) then
        guoBaoBulletHell = guoBaoBulletHellList[1];
    end
    return ConfigMgr.LangGlobal(guoBaoBulletHell);
end


this.GenMsgList = function(msgs)
    local msg;
    local msgData;
    local msgList = {};
    local len = #msgs;
    for i = 1, len do
        msg = msgs[i];
        msgData = {Id=i, Msg=string.format(this.msgText, msg.Name, this.GetWishText(msg.Index))};
        msgList[i] = msgData;
    end
    local count = 0;
    if (len <= 50) then
        count = 50;
    elseif (len > 50 and len <= 190) then
        count = 10;
    end
    local index;
    local bulletHell;
    local bulletHellIndex;
    local bulletHellLists = ConfigMgr.Config.BulletHellLists;
    local bulletHellLen = #bulletHellLists;
    for i = 1, count do
        index = math.random(1, len == 0 and 1 or len);
        bulletHellIndex = math.random(1, bulletHellLen);
        bulletHell = bulletHellLists[bulletHellIndex];
        msgData = {Id=len+1, Msg=string.format(this.msgText, LuaMgr.GetLangText(bulletHell.NameLan), this.GetWishText(bulletHell.Text))};
        table.insert(msgList, index, msgData);
        len = len + 1;
    end
    GuoBaoMsgMgr.SetData(msgList);
end


this.OnUpdate = function()
    GuoBaoMsgMgr.Update();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.wishList = UIListView.New(this.wishListTF);
        LuaMgr.AddClick(this.skipBtn, this.OnClickSkip);
        LuaMgr.AddClick(this.wishBtn, this.OnClickWish);
        LuaMgr.AddClick(this.wishCloseBtn, this.OnClickWishClose);
        LuaMgr.AddClick(this.wishCancelBtn, this.OnClickWishCancel);
        LuaMgr.AddClick(this.wishConfirmBtn, this.OnClickWishConfirm);
        GuoBaoMsgMgr.Init(this.msgItem, this.msgList);
        this.msgText = "【%s】<color=#F6F0E4>%s</color>";
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.GuoBaoWishSelect, this.OnWishSelect);
        this.GenMsgList(vm.behaviour.Params[0]);
        this.SetData();
        GuoBaoMsgMgr.Show();
        LuaMgr.AddUpdate(this.OnUpdate);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUpdate(this.OnUpdate);
        LuaMgr.RemoveUIEventListener(UIEventConst.GuoBaoWishSelect, this.OnWishSelect);
        this.wishList:Clear();
        GuoBaoMsgMgr.Clear();
        this.selectItem = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.skipBtn, this.OnClickSkip);
        LuaMgr.RemoveClick(this.wishBtn, this.OnClickWish);
        LuaMgr.RemoveClick(this.wishCloseBtn, this.OnClickWishClose);
        LuaMgr.RemoveClick(this.wishCancelBtn, this.OnClickWishCancel);
        LuaMgr.RemoveClick(this.wishConfirmBtn, this.OnClickWishConfirm);
        GuoBaoMsgMgr.Destroy();
        UIListView.ClearItem("GuoBaoWishItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})