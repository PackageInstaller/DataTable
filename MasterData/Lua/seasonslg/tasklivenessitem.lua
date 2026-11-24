TaskLivenessItem = {};

TaskLivenessItem.__index = TaskLivenessItem;
local objs = {
    lockObj = { path = "root/lock", type = "GameObject" },
    rewardingObj = { path = "root/rewarding", type = "GameObject" },
    rewardedObj = { path = "root/rewarded", type = "GameObject" },
    btn = { path = "root", type = "Button" },
    desc = {path = "root/des",type = "Text"},
};

function TaskLivenessItem.New()
    local self = {};
    setmetatable(self, TaskLivenessItem);
    self.onClick = nil
    return self;
end

function TaskLivenessItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClick = function()
        if self.data ~= nil and self.data.onClick ~= nil then
            self.data.itemTransform = self.gameObject.transform
            self.data.onClick(self.data)
        end
    end
    LuaMgr.AddClick(self.btn, self.onClick)
end

function TaskLivenessItem:SetData(data)
    self.data = data.data;
    if self.data == nil then
        return
    end
    SetActive(self.lockObj, (self.data.currentProgress or 0) < (self.data.targetProgress or 0))
    SetActive(self.rewardingObj, (self.data.currentProgress or 0) >= (self.data.targetProgress or 0) and not self.data.rewarded)
    SetActive(self.rewardedObj, self.data.rewarded == true)
    self.desc.text = LuaMgr.GetLangText(self.data.config.DescLan)
end


function TaskLivenessItem:Clear()
    self.data = nil;

end

function TaskLivenessItem:Destroy()
    if self.btn ~= nil and self.onClick ~= nil then
        LuaMgr.RemoveClick(self.btn, self.onClick)
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end