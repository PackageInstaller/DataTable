ActivityBattlePrepareTeamTowerEquippedBuffItem = {}

ActivityBattlePrepareTeamTowerEquippedBuffItem.__index = ActivityBattlePrepareTeamTowerEquippedBuffItem

local objs = 
{
    bg = {path = "Bg",type = "Image"},
    quality = {path = "quality",type = "Image"},
    icon = {path = "icon",type = "Image"},
}

function ActivityBattlePrepareTeamTowerEquippedBuffItem.New(prefab, parent,isInstantiate)
    local self = {}
    setmetatable(self, ActivityBattlePrepareTeamTowerEquippedBuffItem)
    if isInstantiate then
        self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
        self:Init()
    end
    SetActive(self.gameObject, true)
    return self
end

function ActivityBattlePrepareTeamTowerEquippedBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBattlePrepareTeamTowerEquippedBuffItem:SetData(id)
    if IsNullOrEmpty(id) then
        SetActive(self.quality.gameObject,false)
        SetActive(self.icon.gameObject,false)
        return
    end
    SetActive(self.quality.gameObject,true)
    SetActive(self.icon.gameObject,true)
    local buff = ConfigMgr.Config.TeamTowerBuffPoolMap[id];
    if not IsNull(buff) then
        local buffConfig = ConfigMgr.Config.TeamTowerBuffDescMap[buff.Key];
        self.quality.sprite = LuaMgr.GetSprite("TeamTowerSprite", "ui_hd_trj_pt_qw_bd0" .. buffConfig.Param[1])
        self.icon.sprite = LuaMgr.GetSprite("BuffIcon", buffConfig.BuffIcon)
    end
end

function ActivityBattlePrepareTeamTowerEquippedBuffItem:Clear()
    SetActive(self.gameObject, false)
end

function ActivityBattlePrepareTeamTowerEquippedBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end