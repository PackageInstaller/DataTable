require("Voyage/VoyageMailItem")

local this = {
    mailList = nil,
    selectItem = nil,
    rewardItem = nil,
    showContent = false,
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    title = { path = "root/Details/Title", type = "Text" },
    child = { path = "root/Details/Child", type = "Text" },
    lockMsg = { path = "root/Details/LockMsg", type = "Text" },
    line = { path = "root/Details/Line", type = "GameObject" },
    arrowDown = { path = "root/Details/ArrowDown", type = "GameObject" },
    arrowUp = { path = "root/Details/ArrowUp", type = "GameObject" },
    scrollRect = { path = "root/Details/ScrollView", type = "ScrollRect" },
    contentTF = { path = "root/Details/ScrollView/Viewport/Content", type = "RectTransform" },
    content = { path = "root/Details/ScrollView/Viewport/Content", type = "Text" },
    mails = { path = "root/Mails", type = "Transform" },
    mailItem = { path = "template/MailItem", type = "GameObject" },
};


this.SetData = function()
    this.SetMails();
    this.selectItem = this.mailList[1];
    local isMask = this.selectItem:Select(true);
    this.SetMailMask(isMask);
    this.SetMailDetails(this.selectItem.config);
end


this.OnBack = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
end


this.InitMails = function()
    this.mailList = {};
    local mails = {};
    local sailingMailMap = ConfigMgr.Config.SailingMailMap;
    for _, v in pairs(sailingMailMap) do
        table.insert(mails, v);
    end
    table.sort(mails, this.MailSort);
    local mailItem;
    local len = #mails;
    for i = 1, len do
        mailItem = VoyageMailItem.New(this.mailItem, this.mails, mails[i]);
        mailItem:SetPosition(i);
        this.mailList[i] = mailItem;
    end
end


this.MailSort = function(a, b)
    return tonumber(a.MailID) < tonumber(b.MailID);
end


this.SetMails = function()
    local len = #this.mailList;
    for i = 1, len do
        this.mailList[i]:SetData();
    end
end


this.SetMailMask = function(isMask)
    local len = #this.mailList;
    for i = 1, len do
        this.mailList[i]:SetMask(isMask);
    end
end


this.ClearMails = function()
    local len = #this.mailList;
    for i = 1, len do
        this.mailList[i]:Clear();
    end
end


this.DestroyMails = function()
    if (this.mailList ~= nil) then
        local len = #this.mailList;
        for i = 1, len do
            this.mailList[i]:Destroy();
        end
        this.mailList = nil;
    end
end


this.OnMailSelect = function(args)
    local mailItem;
    if (args.Length == 0) then
        mailItem = this.rewardItem;
        this.rewardItem = nil;
    else
        mailItem = args[0];
        local mailData = DataMgr.Player.SailingMails[mailItem.config.MailID];
        if (mailData.Status == 1) then
            PlayerVoyageMgr.GetSailingMailReward(mailItem.config.MailID);
            this.rewardItem = mailItem;
            return;
        end
    end
    if (this.selectItem ~= nil) then
        this.selectItem:Select(false);
        this.selectItem = nil;
    end
    this.selectItem = mailItem;
    local isMask = this.selectItem:Select(true);
    this.SetMailMask(isMask);
    this.SetMailDetails(mailItem.config);
    this.animator.AnimationName = "ani_VoyageMailPanel_switch";
end


this.SetMailDetails = function(mailConfig)
    this.title.text = LuaMgr.GetLangText(mailConfig.MailTitle1Lan);
    this.child.text = LuaMgr.GetLangText(mailConfig.MailTitle2Lan);
    local mailData = DataMgr.Player.SailingMails[mailConfig.MailID];
    if (mailData.Status == 0) then
        this.showContent = false;
        this.lockMsg.text = LuaMgr.GetLangText(mailConfig.MailLockLan);
        this.content.text = "";
        SetActive(this.line, false);
        SetActive(this.arrowDown, false);
        SetActive(this.arrowUp, false);
    else
        this.showContent = true;
        this.lockMsg.text = "";
        this.content.text = LuaMgr.GetLangText(mailConfig.MailDetailLan);
        this.scrollRect.vertical = false;
        this.contentTF.anchoredPosition = Vector2.zero;
        LuaMgr.NextFrame(this.OnNextFrame);
    end
end


this.OnNextFrame = function()
    this.scrollRect.vertical = true;
    this.OnValueChanged();
end


this.OnValueChanged = function()
    if (not this.showContent) then return end
    
    local height = this.contentTF.sizeDelta.y - 470;
    if (height > 0) then
        local py = this.contentTF.anchoredPosition.y;
        if (py >= height - 1) then
            SetActive(this.arrowDown, false);
            SetActive(this.arrowUp, true);
        else
            SetActive(this.arrowDown, true);
            SetActive(this.arrowUp, false);
        end
        SetActive(this.line, true);
    else
        SetActive(this.line, false);
        SetActive(this.arrowDown, false);
        SetActive(this.arrowUp, false);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.InitMails();
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        vm.behaviour:UpdateTopBar("", this.OnBack);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageMailSelect, this.OnMailSelect);
        this.scrollRect.onValueChanged:AddListener(this.OnValueChanged);
        this.SetData();
        this.animator.AnimationName = "ani_VoyageMailPanel_root";
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageMailSelect, this.OnMailSelect);
        this.scrollRect.onValueChanged:RemoveListener(this.OnValueChanged);
        this.ClearMails();
        this.selectItem = nil;
        this.rewardItem = nil;
    end,
    before_destroy = function()
        this.DestroyMails();
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})