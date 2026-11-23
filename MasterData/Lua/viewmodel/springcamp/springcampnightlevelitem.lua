SpringCampNightLevelItem = {};

SpringCampNightLevelItem.__index = SpringCampNightLevelItem;

local objs = {
    item1Star1 = { path = "group/Stars/Star1/Icon", type = "GameObject" },
    item1Star2 = { path = "group/Stars/Star2/Icon", type = "GameObject" },
    item1Star3 = { path = "group/Stars/Star3/Icon", type = "GameObject" },
    item1Finish = { path = "group/Finish", type = "GameObject" },
    group = { path = "group", type = "GameObject" },
    num = { path = "group/Num/Text", type = "Text" },
    lock = { path = "group/Lock", type = "GameObject" },

}

function SpringCampNightLevelItem.New()
    local self = {};
    setmetatable(self, SpringCampNightLevelItem);
    return self;
end

function SpringCampNightLevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (self:IsUnlock(true)) then
            TrainingCampMgr.SetMembers(self.data.config.SeriesId, self.data.config.DungeonId[3]);
            LuaMgr.ShowLuaPanel(UIName.SpringCampPrepareViewModel, self.data, 3);
        end
    end
    LuaMgr.AddClick(self.group:GetComponent("Button"), self.OnClickItem);
end

function SpringCampNightLevelItem:SetData(data)
    self.data = data.data;
    local config = self.data.config;
    SetActive(self.item1Star1, false);
    SetActive(self.item1Star2, false);
    SetActive(self.item1Star3, false);
    SetActive(self.item1Finish, false);
    local star = TrainingCampMgr.GetStar(config.DungeonId[3]);
    SetActive(self.item1Star1, star >= 1);
    SetActive(self.item1Star2, star >= 2);
    SetActive(self.item1Star3, star >= 3);
    SetActive(self.item1Finish, star >= 3);
    
    self.num.text = tostring(self.data.index);
    SetActive(self.lock, not self:IsUnlock(false));

end

function SpringCampNightLevelItem:IsUnlock(isTips)
    if (TrainingCampMgr.GetCampSeriesLevelLockState(self.data.config.UnlockTime)) then
        return true;
    end
    if (isTips) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(LuaMgr.GetLangText("SpringCampNightLevelItem_0"),self.data.config.UnlockTime + 1));
    end
    return false;
end

function SpringCampNightLevelItem:Hide()
    local anima = self.gameObject:GetComponent("Animator")
    if anima ~= nil then
        anima:Play("ani_SpringCampLevelPanel_item_disappear",0,0)
    end
end

function SpringCampNightLevelItem:Clear()
    self.data = nil;
end

function SpringCampNightLevelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.group:GetComponent("Button"), self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end