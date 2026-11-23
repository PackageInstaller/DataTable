ActivityBattlePrepareBossDummy3RewardItem = {}

ActivityBattlePrepareBossDummy3RewardItem.__index = ActivityBattlePrepareBossDummy3RewardItem

local objs = 
{
    rare    = {path = "rare", type = "Image"},
    icon    = {path = "icon", type = "RawImage"},
    count   = {path = "count", type = "Text"},
    receive = {path = "receive", type = "GameObject"},
}

function ActivityBattlePrepareBossDummy3RewardItem.New()
    local obj = {}
    setmetatable(obj, ActivityBattlePrepareBossDummy3RewardItem)
    return obj
end

function ActivityBattlePrepareBossDummy3RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBattlePrepareBossDummy3RewardItem:SetData(d)
    local data = d.data
    local item = ConfigMgr.Config.itemMap[data.id]
    local instance = self
    self.itemId = data.id

    self.rare.sprite    = LuaMgr.GetSprite("ItemRare", "itemRare" ..item.rare)
    self.icon.texture   = LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. data.id ..".png")
    self.count.text     = tostring(data.count)

    if data.receive then
        self.receive:SetActive(true)
    else
        self.receive:SetActive(false)
    end

    local function f()
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, instance.itemId, false, false, false, 0)
    end

    LuaMgr.RemoveClick(self.gameObject:GetComponent("Button"), f)
    LuaMgr.AddClick(self.gameObject:GetComponent("Button"), f)
end

function ActivityBattlePrepareBossDummy3RewardItem:Clear()

end

function ActivityBattlePrepareBossDummy3RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end