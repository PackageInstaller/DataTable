ActivityBattlePrepareInfoConditionItem = {}

ActivityBattlePrepareInfoConditionItem.__index = ActivityBattlePrepareInfoConditionItem

local objs = 
{
    bg = {path = "Bg",type = "Image"},
    text = {path = "Text",type = "Text"},
}

function ActivityBattlePrepareInfoConditionItem.New()
    local obj = {}
    setmetatable(obj, ActivityBattlePrepareInfoConditionItem)
    return obj
end

function ActivityBattlePrepareInfoConditionItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBattlePrepareInfoConditionItem:SetData(data)
    self.bg.sprite = data.data.bgRes;
    self.text.text = data.data.content
end

function ActivityBattlePrepareInfoConditionItem:Clear()

end
function ActivityBattlePrepareInfoConditionItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end