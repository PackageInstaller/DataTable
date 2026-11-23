local this = {
    selectedIndex = 0,
    canUp = false,
    talentBox = {}
};

local objs = {
    btnClose = { path = "root/Middle/Bg/BtnClose", type = "Button" },
    btnComfirm = { path = "root/Middle/Bg/BtnComfirm", type = "Button" },
    textCost = { path = "root/Middle/Bg/BtnComfirm/Image/TextCost", type = "Text" },
    imgCost = { path = "root/Middle/Bg/BtnComfirm/Image/TextCost/ImgCost", type = "RawImage" },
    imageFinish = { path = "root/Middle/Bg/ImageFinish", type = "GameObject" },
    imageLock = { path = "root/Middle/Bg/ImageLock", type = "GameObject" },
    textLock = { path = "root/Middle/Bg/ImageLock/TextLock", type = "Text" },
    Talent1 = { path = "root/Middle/Bg/Talent1", type = "Transform" },
    Talent2 = { path = "root/Middle/Bg/Talent2", type = "Transform" },
    Talent3 = { path = "root/Middle/Bg/Talent3", type = "Transform" },
    Talent4 = { path = "root/Middle/Bg/Talent4", type = "Transform" },
    Talent5 = { path = "root/Middle/Bg/Talent5", type = "Transform" },
};


this.SetData = function()
    this.selectedIndex = 1
    local cacheIndex = 10
    for k, v in pairs(this.talentBox) do
        local data = DataMgr.Player.CookGame.TalentMap[v.dataKey]
        if (data ~= nil and data == 0 and v.index < cacheIndex) then
            cacheIndex = v.index
        end
    end
    if (cacheIndex < 10) then
        this.selectedIndex = cacheIndex
    end
    this.selectTarget(this.selectedIndex);
end

this.InitTalentBox = function()
    this.talentBox = {}
    for i = 1, 5 do
        local cache = {}
        local item = this["Talent" .. i]
        cache.index = i
        cache.dataKey = "talent" .. i
        cache.btn = item:GetComponent("Button");
        cache.imgSelect = item:GetChild(0).gameObject
        cache.imgUnFinish = item:GetChild(1).gameObject
        cache.imgFinish = item:GetChild(2).gameObject
        cache.textName = item:GetChild(3):GetComponent("Text");
        cache.imgLock = item:GetChild(4).gameObject
        this.talentBox["Talent" .. i] = cache
        LuaMgr.AddClick(cache.btn, function()
            this.selectTarget(i)
        end);
    end
end

this.selectTarget = function(index)
    this.canUp = false
    for k, v in pairs(this.talentBox) do
        local config = ConfigMgr.Config.CookConstants[k]
        local data = DataMgr.Player.CookGame.TalentMap[v.dataKey]
        v.textName.text = ConfigMgr.LangGlobal(config[4][1]);
        SetActive(v.imgSelect, v.index == index)
        SetActive(v.imgLock, data == nil)
        SetActive(v.imgUnFinish, data ~= 1)
        SetActive(v.imgFinish, data == 1)
        if (v.index == index) then
            SetActive(this.imageLock, data == nil)
            SetActive(this.btnComfirm.gameObject, data == 0)
            SetActive(this.imageFinish, data == 1)
            if (data == nil) then
                this.textLock.text = ConfigMgr.LangGlobal(config[5][1]);
            else
                if (data == 0) then
                    local itemList = config[2]
                    this.textCost.text = itemList[2]
                    local myCount = DataHelper.GetItemCountById(itemList[1])
                    if (myCount >= tonumber(itemList[2])) then
                        this.canUp = true
                    end
                    this.imgCost.texture = GetItemHomeIcon(itemList[1]);
                end
            end
        end
    end
    this.selectedIndex = index
end

this.OnClickExit = function()
    LuaMgr.HidePanel(UIName.YPSGameSkillViewModel);
end

this.OnClickComfirm = function()
    if (this.canUp) then
        local key = "talent" .. this.selectedIndex
        ApiMgr.Request("cookgame/unlockCookTalent", { Id = key }, true, function(result)
            local data = json.decode(result);
            if (data ~= nil and data.result ~= nil) then
                this.selectTarget(this.selectedIndex)
                RedMgr.Singleton:Refresh()
            end
        end, nil, true, true);
    else

    end
end

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.btnClose, this.OnClickExit);
        LuaMgr.AddClick(this.btnComfirm, this.OnClickComfirm);
        this.InitTalentBox()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetData()
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.btnClose, this.OnClickExit);
        LuaMgr.RemoveClick(this.btnComfirm, this.OnClickComfirm);
        for k, v in pairs(this.talentBox) do
            v.btn.onClick:RemoveAllListeners();
        end
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})