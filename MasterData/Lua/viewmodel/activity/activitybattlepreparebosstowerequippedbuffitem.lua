ActivityBattlePrepareBossTowerEquippedBuffItem = {}

ActivityBattlePrepareBossTowerEquippedBuffItem.__index = ActivityBattlePrepareBossTowerEquippedBuffItem

local objs =
{
    bg = {path = "Bg",type = "Image"},
    quality = {path = "quality",type = "Image"},
    icon = {path = "icon",type = "Image"},
}

function ActivityBattlePrepareBossTowerEquippedBuffItem.New(prefab, parent,isInstantiate)
    local self = {}
    setmetatable(self, ActivityBattlePrepareBossTowerEquippedBuffItem)
    if isInstantiate then
        self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
        self:Init()
    end
    SetActive(self.gameObject, true)
    return self
end

function ActivityBattlePrepareBossTowerEquippedBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBattlePrepareBossTowerEquippedBuffItem:SetData(id)
    if IsNullOrEmpty(id) then
        SetActive(self.quality.gameObject,false)
        SetActive(self.bg.gameObject,false)
        SetActive(self.icon.gameObject,false)
        return
    end
    SetActive(self.quality.gameObject,false)
    SetActive(self.bg.gameObject,false)
    SetActive(self.icon.gameObject,true)


        local buffConfig = ConfigMgr.Config.buffMap[id];
        if IsNull(buffConfig) then
            return
        end

        self.icon.sprite = LuaMgr.GetSprite("BuffIcon", buffConfig.BuffIcon)

end

function ActivityBattlePrepareBossTowerEquippedBuffItem:Clear()
    SetActive(self.gameObject, false)
end

function ActivityBattlePrepareBossTowerEquippedBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end