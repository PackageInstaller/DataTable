require("Voyage/VoyageSelectCaptainItem")

local this = {
    portConfig = nil,
    captainList = nil,
    captainDatas = nil,
    captainConfig = nil,
};

local objs = {
    backBtn = { path = "root/Left/Back", type = "Button" },
    captain1 = { path = "root/Middle/Captains/Captain1", type = "GameObject" },
    captain2 = { path = "root/Middle/Captains/Captain2", type = "GameObject" },
    captain3 = { path = "root/Middle/Captains/Captain3", type = "GameObject" },
    captainDice = { path = "root/Info/CaptainDice", type = "Image" },
    captainName = { path = "root/Info/CaptainName/Name", type = "Text" },
    skillName = { path = "root/Info/SkillName/Text", type = "Text" },
    captainDesc = { path = "root/Info/CaptainDesc", type = "Text" },
    confirmBtn = { path = "root/Info/Confirm", type = "Button" },
};


this.SetData = function()
    this.InitCaptains();
    local captain = PlayerVoyageMgr.GetCaptain();
    this.captainConfig = ConfigVoyageMgr.GetCaptainConfig(captain);
    this.SetCaptainInfo();
    this.SelectCaptain(this.captainConfig);
end


this.InitCaptains = function()
    this.captainDatas = {};
    local sailingCaptainMap = ConfigMgr.Config.SailingCaptainMap;
    for _, v in pairs(sailingCaptainMap) do
        table.insert(this.captainDatas, v);
    end
    table.sort(this.captainDatas, this.CaptainSort);
end


this.SetCaptains = function()
    local len = #this.captainList;
    for i = 1, len do
        this.captainList[i]:SetData(this.captainDatas[i]);
    end
end


this.CaptainSort = function(a, b)
    return tonumber(a.CaptainID) < tonumber(b.CaptainID);
end


this.SetCaptainInfo = function()
    this.captainDice.sprite = LuaMgr.GetSprite("VoyageRichMan", this.captainConfig.SkillPic);
    this.captainDice:SetNativeSize();
    this.captainName.text = LuaMgr.GetLangText(this.captainConfig.CaptainNameLan);
    this.skillName.text = LuaMgr.GetLangText(this.captainConfig.SkillNameLan);
    this.captainDesc.text = LuaMgr.GetLangText(this.captainConfig.CaptainDesLan);
end


this.GetCaptainIndex = function(id)
    local len = #this.captainDatas;
    for i = 1, len do
        if (this.captainDatas[i].CaptainID == id) then
            return i;
        end
    end
    return 1;
end


this.SelectCaptain = function(selectCaptain)
    local index = this.GetCaptainIndex(selectCaptain.CaptainID);
    this.captainDatas[index] = this.captainDatas[1];
    this.captainDatas[1] = selectCaptain;
    this.captainConfig = selectCaptain;
    this.SetCaptains();
end


this.OnSelectCaptainInfo = function(args)
    this.SelectCaptain(args[0]);
    this.SetCaptainInfo();
end


this.OnClickBack = function()
    LuaMgr.Back();
end


this.OnClickConfirm = function()
    PlayerVoyageMgr.SetCaptain(this.captainConfig.CaptainID);
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageSelectCaptain);
    LuaMgr.HidePanel(UIName.VoyageSelectCaptainViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.backBtn, this.OnClickBack);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
        this.captainList = {};
        this.captainList[1] = VoyageSelectCaptainItem.New(this.captain1, true);
        this.captainList[2] = VoyageSelectCaptainItem.New(this.captain2, false);
        this.captainList[3] = VoyageSelectCaptainItem.New(this.captain3, false);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.VoyageSelectCaptainInfo, this.OnSelectCaptainInfo);
        this.portConfig = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageSelectCaptainInfo, this.OnSelectCaptainInfo);
        this.portConfig = nil;
        this.captainDatas = nil;
        this.captainConfig = nil;
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack);
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})