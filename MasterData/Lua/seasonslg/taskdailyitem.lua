TaskDailyItem = {};

TaskDailyItem.__index = TaskDailyItem;
local objs = {
    root={ path = "root", type = "Transform" },
    rewardedObj={ path = "root/bg/rewarded", type = "GameObject" },
    rewardBtn={ path = "root/bg/rewarding", type = "Button" },
    rewardObj={ path = "root/bg/reward", type = "GameObject" },
    progress={ path = "root/bg/reward/pro", type = "Text" },
    desc={ path = "root/bg/des", type = "Text" },
    rewardDesc={ path = "root/bg/value", type = "Text" },
};

function TaskDailyItem.New()
    local self = {};
    setmetatable(self, TaskDailyItem);
    self.onClick = nil
    return self;
end

function TaskDailyItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClick = function()
        if self.data ~= nil then
            if self.data.canGet and self.data.rewardCallBack ~= nil then
                self.data.rewardCallBack(self.data.id)
            elseif self.data.jumpCallBack ~= nil then
                self.data.jumpCallBack(self.data.id)
            end
        end
    end
    LuaMgr.AddClick(self.rewardBtn, self.onClick)
end

function TaskDailyItem:SetData(data)
    self.data = data.data;
    if self.data == nil then
        return
    end
    if self.desc ~= nil then
        self.desc.text = self.data.config ~= nil and LuaMgr.GetLangText(self.data.config.DescLan or "") or ""
    end
    if self.progress ~= nil then
        self.progress.text = string.format("%s/%s", tostring(self.data.current or 0), tostring(self.data.target or 0))
    end
    if self.rewardDesc ~= nil then
        self.rewardDesc.text = self.data.isDone and LuaMgr.GetLangText("TaskDailyItem_0") or (self.data.canGet and LuaMgr.GetLangText("TaskDailyItem_1") or LuaMgr.GetLangText("TaskDailyItem_2"))
    end
    SetActive(self.rewardedObj, self.data.isDone == true)
    SetActive(self.rewardObj, self.data.isDone ~= true and self.data.canGet ~= true)
    SetActive(self.rewardBtn.gameObject, self.data.canGet == true)
end

function TaskDailyItem:Clear()
    self.data = nil;
end

function TaskDailyItem:Destroy()
    if self.rewardBtn ~= nil and self.onClick ~= nil then
        LuaMgr.RemoveClick(self.rewardBtn, self.onClick)
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end