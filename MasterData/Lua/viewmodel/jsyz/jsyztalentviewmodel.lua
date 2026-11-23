require("ViewModel/JSYZ/JSYZTalentItem")

local this =
{
    talentList = nil,
    showList = nil,
    posList = { { -144, 89 }, { -116, 209 }, { -8, 270 }, { 181, 21 }, { 270, -63 }, { 270, -187 }, { -29, -234 }, { -147, -270 }, { -254, -207 } },

};

local objs = {
    talentItem = { path = "template/talentItem", type = "GameObject" },
    bg1 = { path = "root/Bg1", type = "Transform" },
    disselected = { path = "root/Bg1/Disselected", type = "Button" },
    imageList = { path = "root/Bg1/ImageList", type = "Transform" },
    imageBox = { path = "root/Right/ImageBox", type = "GameObject" },
    buttonCost = { path = "root/Right/ImageBox/ButtonCost", type = "Button" },
    textCost = { path = "root/Right/ImageBox/ButtonCost/TextCost", type = "Text" },
    imgCost = { path = "root/Right/ImageBox/ButtonCost/TextCost/ImgCost", type = "RawImage" },
    imageMask = { path = "root/Right/ImageBox/ButtonCost/ImageMask", type = "GameObject" },
    textTitle = { path = "root/Right/ImageBox/TextTitle", type = "Text" },
    imageIcon = { path = "root/Right/ImageBox/ImageIcon", type = "Image" },
    textContent = { path = "root/Right/ImageBox/TextContent", type = "Text" },
};




this.SetData = function()
    this.activityKey = ActivityKey.JSYZ

    this.SetTalentList()
end


this.OnBack = function()
    if DataExHelper.CommonActivityCheck(this.activityKey) then
        LuaMgr.Back(this.activityKey)
    else
        LuaMgr.Back()
    end
end

this.OnClickLvUp = function()
    if this.CheckActivityRunning() and this.selectedData ~= nil then
        if (this.selectedData.isUnlock) then
            local cost = this.selectedData.config.Consume[1]
            local count = DataHelper.GetItemCountById(cost.id)
            if cost.count > count then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10204"))
                return
            end
            local id = this.selectedData.config.Id
            ApiMgr.Request("boommap/boomtech", { Id = id }, true, function(result)
                JSYZMgr.SetShowAni(false)
                this.SetTalentList()
                this.FinishTalent(id)
            end, nil, true, true);
        else
            local unlockNum = JSYZMgr.CheckTalentIsUnLock(this.selectedData.config)
            if (unlockNum == 1) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
                    ConfigMgr.LangGlobal(this.selectedData.config.UnlockDesc[2]))
            else
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
                    ConfigMgr.LangGlobal(this.selectedData.config.UnlockDesc[1]))
            end
        end
    end
end

this.OnClickDisselected = function()
    SetActive(this.imageBox, false)

    for k, v in pairs(this.talentList.itemList) do
        v.data.isSelected = false
        v:ShowSelected(v.data.isSelected)
    end
end

this.SetTalentList = function()
    this.talentList:Clear();
    local scrollData;
    local scrollDatas = {};
    local cacheList = {}
    this.totalNum = 0
    local nestNum = 0
    for k, v in pairs(ConfigMgr.Config.BoomTetechMap) do
        this.totalNum = this.totalNum + 1;
        local id = tonumber(v.Id)
        cacheList[id] = v
        if (JSYZMgr.CheckTalentIsUnLock(v) == 3) then
            if (not JSYZMgr.CheckTalentIsComplete(v)) then
                if (nestNum == 0) then
                    nestNum = id
                elseif (nestNum < id) then
                    nestNum = id
                end
            end
        end
    end
    local len = #cacheList;
    for i = 1, len do
        local data = cacheList[i];
        scrollData = UIListData.GetData(this.talentItem, "JSYZTalentItem",
            {
                config = data,
                num = i,
                pos = this.posList[i],
                isSelected = nestNum == i,
                isUnlock = JSYZMgr.CheckTalentIsUnLock(data) == 3,
                isFinish = JSYZMgr.CheckTalentIsComplete(data),
                callback = this.ItemClickCallBack
            });
        table.insert(scrollDatas, scrollData);
    end
    this.talentList:SetData(scrollDatas);
    this.showIndex = 1;
    this.showList = this.talentList.itemList
    local showAni = JSYZMgr.CheckShowAni()
    for _, v in pairs(this.showList) do
        SetActive(v.gameObject, not showAni);
    end
    if (showAni) then
        LuaMgr.AddTimer(TimerConst.SGYNovelListDelay, this.OnTalentList, 0.05, -1, true);
    end
    if (nestNum > 0) then
        this.ItemClickCallBack(nestNum);
    else
        this.ItemClickCallBack(1);
    end
end


this.OnTalentList = function()
    if (this.showIndex > #this.showList) then
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        this.showList = nil;
        return;
    end
    local item = this.showList[this.showIndex];
    SetActive(item.gameObject, true);
    this.showIndex = this.showIndex + 1;
end

this.ItemClickCallBack = function(index)
    local item = this.talentList.itemList[index];
    local data = item.data.config;
    this.selectedData = item.data
    this.imageIcon.sprite = LuaMgr.GetSprite("JSYZ", string.format(data.BuffIcon, "_yl"))
    this.textTitle.text = LuaMgr.GetLangText(data.BuffNameLan);
    this.textContent.text = LuaMgr.GetLangText(data.BuffDesLan);
    this.textCost.text = data.Consume[1].count
    local iconPath = ConfigHelper.GetItemHomeIconPath(data.Consume[1].id)
    local iconTexture = LuaMgr.GetTexture(iconPath)
    this.imgCost.texture = iconTexture
    local isUnlock = item.data.isUnlock
    local isFinish = item.data.isFinish
    SetActive(this.imageMask, not isUnlock);
    SetActive(this.buttonCost.gameObject, not isFinish)
    for k, v in pairs(this.talentList.itemList) do
        v.data.isSelected = false
        if (index == v.data.num) then
            v.data.isSelected = true
        end
        v:ShowSelected(v.data.isSelected)
    end
    SetActive(this.imageBox, true)

end

this.FinishTalent = function(id)    
    for k, v in pairs(this.talentList.itemList) do
        local data = v.data.config;
        if (data.Id == id) then            
            v:ShowOnce(true)
        else
            v:ShowOnce(false)
        end
    end
end



local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.buttonCost, this.OnClickLvUp);
        LuaMgr.AddClick(this.disselected, this.OnClickDisselected)
        RedMgr.Singleton:RegisterViewModel(UIName.JSYZTalentViewModel);
        this.talentList = UIListView.New(this.imageList);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetJSYZRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        this.showList = nil;
        this.talentList:Clear();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.buttonCost, this.OnClickLvUp);
        LuaMgr.RemoveClick(this.disselected, this.OnClickDisselected)
        RedMgr.Singleton:RemoveViewModel(UIName.JSYZTalentViewModel);
        UIListView.ClearItem("JSYZTalentItem");
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(this.activityKey) then
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