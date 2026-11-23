YPSNovelItem = {};

YPSNovelItem.__index = YPSNovelItem;

local objs = {
    groupBtn = { path = "Group", type = "Button" },
    unlock = { path = "Group/Unlock", type = "GameObject" },
    replay = { path = "Group/Unlock/Replay", type = "GameObject" },
    unlock2 = { path = "Group/Unlock2", type = "GameObject" },
    rating = { path = "Group/Unlock2/Rating", type = "Image" },
    scrollViewGo = { path = "Group/Unlock2/ScrollViewReward", type = "GameObject" },
    Content = { path = "Group/Unlock2/ScrollViewReward/Viewport/Content", type = "RectTransform" },
    lock = { path = "Group/Lock", type = "GameObject" },
    lockBg = { path = "Group/Lock/LockBg", type = "GameObject" },
    lockBg2 = { path = "Group/Lock/LockBg2", type = "GameObject" },
    num = { path = "Group/Num", type = "Text" },
    name = { path = "Group/Name", type = "Text" },
};

function YPSNovelItem.New()
    local self = {};
    setmetatable(self, YPSNovelItem);
    self.rewardList = {}
    return self;
end

function YPSNovelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (not DataExHelper.CommonActivityCheck(ActivityKey.YPS)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"));
            return;
        end
        local pPass = YPSMgr.CheckEventIsComplete(self.data.config);
        if (pPass) then
            if (self.data.config.type == 1) then
                LuaMgr.PlayNovel(self.data.config.eventParam, function()
                    YPSMgr.SetShowAni(false);
                    LuaMgr.ShowLuaPanel(UIName.YPSMainViewModel);
                    LuaMgr.ShowLuaPanel(UIName.YPSNovelViewModel);
                end);
            else
                local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
                enterDungeonParams.eventId = self.data.config.id
                enterDungeonParams.dungeonId = self.data.config.eventParam
                BattlePrepareMgr.BattlePrepare(enterDungeonParams)
            end
            LuaMgr.HidePanel(UIName.YPSNovelViewModel);
        else
            local eventMap = DataExHelper.GetActivityMapEventMap();
            local unlockEvent = eventMap[self.data.config.eventParam]
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
                string.format(ConfigMgr.LangGlobal("10001"), LuaMgr.GetLangText(unlockEvent.namelan)));
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function YPSNovelItem:SetData(data)
    self.data = data.data;
    SetActive(self.unlock, false);
    SetActive(self.unlock2, false);
    SetActive(self.lock, false);
    SetActive(self.lockBg, false);
    SetActive(self.lockBg2, false);
    SetActive(self.replay, false);
    SetActive(self.scrollViewGo, false)
    local pPass = YPSMgr.CheckEventIsComplete(self.data.config);
    if (pPass) then
        self.name.text = LuaMgr.GetLangText(self.data.config.namelan);
        if (self.data.config.type == 1) then
            SetActive(self.unlock, true);
            SetActive(self.replay, true);
        else
            SetActive(self.unlock2, true);
            SetActive(self.scrollViewGo, true)
            self:GetRareText()
            self:SetReward(self.data.config)
        end
    else
        self.name.text = "";
        SetActive(self.lock, true);
        SetActive(self.scrollViewGo, false)
        if (self.data.config.type == 1) then
            SetActive(self.lockBg, true);
        else
            SetActive(self.lockBg2, true);
        end
    end
end

function YPSNovelItem:GetRareText()
    local rating = DataExHelper.GetDungeonDecordRating(self.data.config.eventParam)
    SetActive(self.rating.gameObject, true)
    local str = nil
    if (rating == 1) then
        str = "y"
    elseif (rating == 2) then
        str = "l"
    elseif (rating == 3) then
        str = "z"
    else
        SetActive(self.rating.gameObject, false)
        return
    end
    local titleSpriteName = string.format("ui_hd_wps_jqhg_%s", str)
    self.rating.sprite = LuaMgr.GetSprite("YPS", titleSpriteName)
    self.rating:SetNativeSize()
end

function YPSNovelItem:SetReward(config)
    local index = 1
    local itemData
    local scaleNum = 0.5
    local scale = Vector3(scaleNum, scaleNum, scaleNum)
    local dungeon = ConfigMgr.Config.dungeonMap[config.eventParam]   
    if IsNull(dungeon) then
        return
    end   
    local itemDataLis = NumTool.split(dungeon.firstDropShow, ';')
    for k, v in pairs(itemDataLis) do
        local data = self.rewardList[index]
        if (data == nil) then
            local goodsItem = GoodsDataItem.New(self.Content)
            self.rewardList[index] = {
                item = goodsItem,
            }
            data = self.rewardList[index]
        end
        local itemConfig = ConfigMgr.Config.itemMap[v]
        if (itemConfig == nil) then
            return
        end
        itemData = table.Copy(itemConfig)        
        data.item:SetData(index, itemData, 1, false, scale, false, true)
        index = index + 1
    end
    local len = #self.rewardList
    for i = index, len do
        self.rewardList[i].item:Hide()
    end
end

function YPSNovelItem:Clear()
    self.data = nil;
    if (self.rewardList ~= nil) then
        for k, v in pairs(self.rewardList) do
            v.item:Clear()
        end
        self.rewardList = {}
    end
end

function YPSNovelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end