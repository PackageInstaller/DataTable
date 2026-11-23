TeamRelay2RewardItem = {};

TeamRelay2RewardItem.__index = TeamRelay2RewardItem;

local objs = {
    clickBtn = { path = "Item", type = UITool.Button },
    rare = { path = "Item", type = UITool.Image },
    icon = { path = "Item/Icon", type = UITool.RawImage },
    countGo = { path = "Item/Count", type = UITool.GameObject },
    countText = { path = "Item/Count/Text", type = UITool.Text },
    claimedGo = { path = "Claimed", type = UITool.GameObject },
}

function TeamRelay2RewardItem.New(prefab, parent)
    local self = {};
    setmetatable(self, TeamRelay2RewardItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject:GetComponent("RectTransform");
    self:Init()
    
    return self;
end

function TeamRelay2RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data ~= nil and not IsNullOrEmpty(self.data.id) then
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, self.data.id, true, false, false, 0);
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.onClickCommand);
end

function TeamRelay2RewardItem:SetData(pdata)
    self.data = pdata
    self.icon.texture = self.data.icon
    self.rare.sprite = self.data.rare
    self.countText.text = self.data.count
    SetActive(self.countGo, self.data.isCount)
    SetActive(self.claimedGo, self.data.isClaimed)
    SetActive(self.gameObject, true)
end

function TeamRelay2RewardItem:Hide()
    SetActive(self.gameObject, false)
end

function TeamRelay2RewardItem:Clear()
    self.data = nil
end

function TeamRelay2RewardItem:Destroy()
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
end 