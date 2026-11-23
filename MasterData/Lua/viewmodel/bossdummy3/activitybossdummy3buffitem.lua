ActivityBossDummy3BuffItem = {}

ActivityBossDummy3BuffItem.__index = ActivityBossDummy3BuffItem

local objs = 
{
    Text    = {path = "Text", type = "Text"},
    icon    = {path = "icon", type = "Image"}
}

function ActivityBossDummy3BuffItem.New()
    local obj = {}
    setmetatable(obj, ActivityBossDummy3BuffItem)
    return obj
end

function ActivityBossDummy3BuffItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBossDummy3BuffItem:SetData(d)
    local data      = d.data
    local config    = data.config
    local instance  = self
    self.config     = config
    self.enemy      = data.enemy
    local function a()
        if instance.enemy then
            LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3EnemyBuffDescPopupViewModel, instance.config.Id)
        else
            LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3BuffDescPopupViewModel, instance.config.Id)
        end
    end
    
    LuaMgr.RemoveClick(self.gameObject:GetComponent("Button"), a)
    LuaMgr.AddClick(self.gameObject:GetComponent("Button"), a)

    self.Text.text      = LuaMgr.GetLangText(config.BuffNameLan)
    self.icon.sprite    = LuaMgr.GetSprite("BuffIcon", config.BuffIcon)
    
    local e = self.gameObject.transform:Find("choose_img")
    if e then
        if data.show_choose then
            e.gameObject:SetActive(true)
        else
            e.gameObject:SetActive(false)
        end
    end
end

function ActivityBossDummy3BuffItem:Clear()

end

function ActivityBossDummy3BuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end