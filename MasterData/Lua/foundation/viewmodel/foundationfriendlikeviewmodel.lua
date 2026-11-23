require("Foundation/ViewModel/FoundationFriendLikeItem")

local this = {
    likeSV = nil,
    likeDatas = nil,
}

local objs = {
    closeBtn = { path = "root/Middle/FriendLike/Close", type = "Button" },
    likeItem = { path = "template/LikeItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/FriendLike/ScrollView", type = "GameObject" },
    count = { path = "root/Middle/FriendLike/Count/Text", type = "Text" },
    notLike = { path = "root/Middle/FriendLike/NotLike", type = "GameObject" },
}


this.SetData = function()
    local alyUseLikePoint = PlayerFoundationMgr.GetAlyUseLikePoint();
    local maxGetItemTimes = ConfigMgr.Config.FriendConstants.MaxGetItemTimes;
    this.count.text = string.format("<size=28><color=#262429>%d</color></size>/%d", alyUseLikePoint, maxGetItemTimes);
    this.SetLikeList();
    if (PlayerFoundationMgr.GetLikePoint() > 0) then
        PlayerFoundationMgr.VisitLikeAward();
    end
end


this.SetLikeList = function()
    this.likeSV:Clear(false);
    local likeData;
    local scrollData;
    local scrollDatas = {};
    local len = #this.likeDatas;
    for i = 1, len do
        likeData = this.likeDatas[i];
        if (likeData.Like) then
            scrollData = UIScrollData.GetData(this.likeItem, "FoundationFriendLikeItem", 578, 80, likeData);
            table.insert(scrollDatas, scrollData);
        end
    end
    this.likeSV:SetParams(685, 330);
    this.likeSV:SetData(scrollDatas, true);
    SetActive(this.notLike, #scrollDatas <= 0);
end


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.FoundationFriendLikeViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.likeSV = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.likeDatas = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        this.likeSV:Clear(true);
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        UIScrollView.ClearItem("FoundationFriendLikeItem");
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})