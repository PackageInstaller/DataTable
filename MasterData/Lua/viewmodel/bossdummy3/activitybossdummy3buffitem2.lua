ActivityBossDummy3BuffItem2 = {}

ActivityBossDummy3BuffItem2.__index = ActivityBossDummy3BuffItem2

local objs = 
{
    Text        = {path = "Text", type = "Text"},
    icon        = {path = "icon", type = "Image"},
    choose_go   = {path = "choose", type = "GameObject"},
}

function ActivityBossDummy3BuffItem2.New()
    local obj = {}
    setmetatable(obj, ActivityBossDummy3BuffItem2)
    return obj
end

function ActivityBossDummy3BuffItem2:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBossDummy3BuffItem2:SetData(d)
    local data      = d.data
    local config    = data.config
    local instance  = self
    self.config     = config
    self.callback   = data.callback

    local function a()
        instance.callback(instance.config.Id)
    end

    LuaMgr.RemoveClick(self.gameObject:GetComponent("Button"), a)
    LuaMgr.AddClick(self.gameObject:GetComponent("Button"), a)

    self.Text.text      = LuaMgr.GetLangText(config.BuffNameLan)
    self.icon.sprite    = LuaMgr.GetSprite("BuffIcon", config.BuffIcon)
    self.choose_go:SetActive(false)
end

function ActivityBossDummy3BuffItem2:Clear()

end

function ActivityBossDummy3BuffItem2:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end