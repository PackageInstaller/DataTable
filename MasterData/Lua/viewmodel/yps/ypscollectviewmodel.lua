require("ViewModel/PackUp/PackUpCollectItem")

local this = {
    itemScrollView = nil,
    scrollWidth = 0,
    itemObjList = {},
    chatTimes = 0,
    curSelectedItem = nil,
};

local objs = {
    collectItem = { path = "template/CollectItem", type = "GameObject" },
    ratioTex = { path = "root/Left/Other/RatioText", type = "Text" },
    itemScrollViewGo = { path = "root/Middle/ItemScrollView", type = "GameObject" },
    chatPanel = { path = "root/Middle/ChatPanel", type = "GameObject" },
    comfirmBtn = { path = "root/Middle/ChatPanel/comfirmBtn", type = "GameObject" },
    chatPanelBtn = { path = "root/Middle/ChatPanel/bgBtn", type = "Button" },
    textChat = { path = "root/Middle/ChatPanel/TextChat", type = "Text" },
    rewardBox = { path = "root/Middle/ChatPanel/RewardBox", type = "Transform" },
    textTitle = { path = "root/Middle/ChatPanel/ImgTitleBg/TextTitle", type = "Text" },

};


this.SetCharacter = function()
    local id = "D0166" 
local skinId = id.."001";



    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, id, skinId);
    if path ~= "" then
        this.vm.data.bodyPath = path;
    end
end


this.OnBack = function()
    if DataExHelper.CommonActivityCheck(ActivityKey.PackUp) then
        LuaMgr.Back(ActivityKey.PackUp)
    else
        LuaMgr.Back()
    end
end

this.RefreshItemCollectPanel = function()
    this.chatTimes = 0
    this.curSelectedItem = nil
    this.itemScrollView:Clear(false)
    SetActive(this.chatPanel, false)
    SetActive(this.itemScrollViewGo.gameObject, true)
    SetActive(this.comfirmBtn, false)
    local scrollData, scrollDatas = {}, {}
    local getNum = 0
    local totalNum = 0
    for i, v in pairs(ConfigMgr.Config.PackUpCollectMap) do
        totalNum = totalNum + 1
        local item = DataMgr.Player.items[v.UnClock[1].id]
        local isFinish = DataMgr.Player.PackUpCollectMap[v.Id]
        if ((item ~= nil and item.count0 > 0) or isFinish) then
            getNum = getNum + 1
        end
        local itemConfig = table.Copy(ConfigMgr.Config.itemMap[v.UnClock[1].id]);
        local cache = {}
        cache.canGet = item ~= nil and item.count0 > 0
        cache.finish = isFinish
        cache.config = v
        cache.callBack = function()
            SetActive(this.itemScrollViewGo.gameObject, false)
            SetActive(this.rewardBox.gameObject, false)
            SetActive(this.chatPanel, true)
            this.textChat.text = LuaMgr.GetLangText(v.AnswerLan)
            local str = LuaMgr.GetLangText(itemConfig.nameLan)
            this.textTitle.text = string.format("%s<color=ffffff>[%s]</color>", LuaMgr.GetLangText("PackUpCollectViewModel_0"), str)
            this.curSelectedItem = v
            local itemCount = 0
            for k, v in ipairs(v.Reward) do
                local cache = this.itemObjList[k]
                if (cache == nil) then
                    cache = GoodsDataItem.New(this.rewardBox);
                    this.itemObjList[k] = cache;
                end
                local scale = Vector3(0.6, 0.6, 1);
                local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
                itemData.count0 = v.count
                cache:SetData(1, itemData, 1, false, scale, false, false);
                SetActive(cache.gameObject, true)
                itemCount = itemCount + 1
            end
            for key = itemCount + 1, #this.itemObjList do
                this.itemObjList[key]:Hide()
            end
        end
        scrollData = UIScrollData.GetData(this.collectItem, "PackUpCollectItem", 350, 321, cache)
        table.insert(scrollDatas, scrollData)
    end    
    this.ratioTex.text = "<color=#ffffff><size=38>" ..
    getNum .. "</size></color>/<color=#c9ded2>" .. totalNum .. "</color>"
    this.itemScrollView:SetParams(this.scrollWidth, 325)
    this.itemScrollView:SetData(scrollDatas, true)
end

this.OnClickChat = function()
    this.chatTimes = this.chatTimes + 1
    if this.chatTimes > 1 then
        ApiMgr.Request("packUpCollect/award", { Id = this.curSelectedItem.Id }, true, function(re)
            local re = json.decode(re);
            local data = json.encode(re.result.Rewards);
            LuaMgr.ShowItemRewared(data);
            this.RefreshItemCollectPanel()
        end, nil, true)
    else
        this.textChat.text = LuaMgr.GetLangText("PackUpCollectViewModel_1")
        SetActive(this.rewardBox.gameObject, true)
        SetActive(this.comfirmBtn, true)
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.chatPanelBtn, this.OnClickChat);
        RedMgr.Singleton:RegisterViewModel(UIName.PackUpMainViewModel);
        this.itemScrollView = UIScrollView.New(this.itemScrollViewGo);
        local addWidth = LuaMgr.GetScreenAddWidth();
        this.scrollWidth = 1280 + addWidth;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetYPSRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.RefreshItemCollectPanel()

    end,
    before_deactive = function(vm)
        this.itemScrollView:Clear(true);
        if this.itemObjList ~= nil then
            for i = 1, #this.itemObjList do
                this.itemObjList[i]:Clear()
            end
            this.itemObjList = {}
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.chatPanelBtn, this.OnClickChat);

        UIScrollView.ClearItem("PackUpCollectItem");



    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.PackUp) then
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