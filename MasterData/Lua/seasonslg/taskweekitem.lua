TaskWeekItem = {};

TaskWeekItem.__index = TaskWeekItem;
local objs = {
    root={ path = "root", type = "Transform" },
    number={ path = "root/num", type = "Text" },
    title={ path = "root/title", type = "Text" },
    star = { path = "root/star", type = "Image"},
    desc = { path = "root/des", type = "Text"},
    rewardContent = { path = "root/reward", type = "Transform" },
    contributionReward = { path = "root/tip", type = "Text" },
    gotoBtn = { path = "root/jump", type = "Button" },
    getBtn = { path = "root/get", type = "Button" },
    isDoneObj = { path = "root/done", type = "GameObject" },
};

function TaskWeekItem.New()
    local self = {};
    setmetatable(self, TaskWeekItem);
    self.jumpClick = nil
    self.getClick = nil
    return self;
end

function TaskWeekItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.jumpClick = function()
        if self.data ~= nil and self.data.jumpCallBack ~= nil then
            self.data.jumpCallBack(self.data.id)
        end
    end
    self.getClick = function()
        if self.data ~= nil and self.data.canGet and self.data.rewardCallBack ~= nil then
            self.data.rewardCallBack(self.data.id)
        end
    end
    LuaMgr.AddClick(self.gotoBtn, self.jumpClick)
    LuaMgr.AddClick(self.getBtn, self.getClick)
end

function TaskWeekItem:SetData(data)
    self.data = data.data;
    if self.data == nil then
        return
    end
    if self.number ~= nil then
        self.number.text = tonumber(self.data.config.Para[2]) <= 9 and "0" .. tostring(self.data.config.Para[2]) or tostring(self.data.config.Para[2])
    end
    if self.title ~= nil then
        self.title.text = self.data.config ~= nil and (self.data.config.Name or LuaMgr.GetLangText(self.data.config.NameLan or "")) or ""
    end
    if self.desc ~= nil then
        self.desc.text = self.data.config ~= nil and LuaMgr.GetLangText(self.data.config.DescLan or "") or ""
    end
    if self.contributionReward ~= nil then
        self.contributionReward.text = self.data.isDone and LuaMgr.GetLangText("TaskWeekItem_0") or (self.data.canGet and LuaMgr.GetLangText("TaskWeekItem_1") or LuaMgr.GetLangText("TaskWeekItem_2"))
    end
    if #self.data.config.Para > 1 then
        self.star.sprite = LuaMgr.GetSprite("SLGSeason",("sjz-zlfy-rw-dqch-nd"..self.data.config.Para[1]))
    else
        self.star.sprite = LuaMgr.GetSprite("SLGSeason",("sjz-zlfy-rw-dqch-nd1"))
    end
    SetActive(self.getBtn.gameObject, self.data.canGet == true and not self.data.isDone)
    SetActive(self.gotoBtn.gameObject, self.data.canGet ~= true and not self.data.isDone)
    SetActive(self.isDoneObj, self.data.isDone == true)
end

function TaskWeekItem:Clear()
    self.data = nil;
end

function TaskWeekItem:Destroy()
    if self.gotoBtn ~= nil and self.jumpClick ~= nil then
        LuaMgr.RemoveClick(self.gotoBtn, self.jumpClick)
    end
    if self.getBtn ~= nil and self.getClick ~= nil then
        LuaMgr.RemoveClick(self.getBtn, self.getClick)
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end