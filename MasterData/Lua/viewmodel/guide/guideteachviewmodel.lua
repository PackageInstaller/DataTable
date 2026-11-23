require("ViewModel/Guide/GuideTeachGoodsItem")

local this = {
    itemList = nil,
    config = nil,
    dungeonId = "",
};

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
    jobIcon = { path = "root/Middle/Teach/Job/Icon", type = "Image" },
    jobName = { path = "root/Middle/Teach/Job/Name", type = "Text" },
    jobPic = { path = "root/Middle/Teach/Job/Pic", type = "RawImage" },
    jobContent = { path = "root/Middle/Teach/Job/Content", type = "Text" },
    goodsItem = { path = "template/GoodsItem", type = "GameObject" },
    rewardItems = { path = "root/Middle/Teach/Reward/Items", type = "Transform" },
    msgHead = { path = "root/Middle/Teach/Msg/Head", type = "RawImage" },
    msgText = { path = "root/Middle/Teach/Msg/Text", type = "Text" },
    confirmBtn = { path = "root/Middle/Teach/ConfirmBtn", type = "Button" },
    cancelBtn = { path = "root/Middle/Teach/CancelBtn", type = "Button" },
};


this.SetData = function()
    this.config = ConfigMgr.Config.GuideCareerMap[this.dungeonId];
    this.jobIcon.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. this.config.Job);
    this.jobName.text = LuaMgr.GetLangText(this.config.Namelan);
    this.jobPic.texture = LuaMgr.GetTexture("Assets/_BundleResources/Images/GuidePics/" .. this.config.Pic .. ".png");
    this.jobContent.text = LuaMgr.GetLangText(this.config.Desclan);
    this.msgHead.texture = LuaMgr.GetTexture("Assets/_BundleResources/Images/GuidePics/ui_xsyd_NPC304.png");
    this.msgText.text = LuaMgr.GetLangText(this.config.Textlan);
end


this.SetItems = function()
    this.itemList:Clear();
    local listDatas = {};
    local len = #this.config.Rewards;
    for i = 1, len do
        local listData = UIListData.GetData(this.goodsItem, "GuideTeachGoodsItem", this.config.Rewards[i]);
        table.insert(listDatas, listData);
    end
    this.itemList:SetData(listDatas);
end


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.GuideTeachViewModel);
end


this.OnClickConfirm = function()
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = "";
    enterDungeonParams.dungeonId = this.config.CareerId;
    BattlePrepareMgr.BattlePrepare(enterDungeonParams);
    LuaMgr.HidePanel(UIName.GuideTeachViewModel);
end


this.OnClickCancel = function()
    LuaMgr.HidePanel(UIName.GuideTeachViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.itemList = UIListView.New(this.rewardItems);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.dungeonId = vm.behaviour.Params[0];
        this.SetData();
        this.SetItems();
    end,
    before_deactive = function(vm)
        this.itemList:Clear();
        this.jobIcon.sprite = nil;
        this.jobPic.texture = nil;
        this.msgHead.texture = nil;
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancel);
        UIListView.ClearItem("GuideTeachGoodsItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})