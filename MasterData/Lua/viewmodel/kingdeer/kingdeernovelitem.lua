













KingDeerNovelItem = {}
KingDeerNovelItem.__index = KingDeerNovelItem

local objs = {
    clickBtn = {path = "", type = UITool.Button},
    normalObj = {path = "Group/NomalObj", type = UITool.GameObject},
    lockObj = {path = "Group/LockObj", type = UITool.GameObject},
    normalText = {path = "Group/NomalObj/NameText", type = UITool.Text},
    lockText = {path = "Group/LockObj/NameText", type = UITool.Text}
}

function KingDeerNovelItem.New()

    local self = {}
    setmetatable(self, KingDeerNovelItem)
    return self
end

function KingDeerNovelItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    local onClickItem = function()
        self:OnPlayNovel()
    end
    LuaMgr.AddClick(self.clickBtn, onClickItem)
end

function KingDeerNovelItem:OnPlayNovel()
    if self.data.isUnLock ~= true then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.data.unlockText)
        return
    end
    local playNovelCallback = function()
        LuaMgr.ShowLuaPanel(UIName.KingDeerMainViewModel)
        LuaMgr.ShowLuaPanel(UIName.KingDeerNovelPopup)
    end
    LuaMgr.PlayNovel(self.data.ID, playNovelCallback)
    LuaMgr.HidePanel(UIName.KingDeerNovelPopup)
end

function KingDeerNovelItem:SetData(data)
    self.data = data.data
    self.normalText.text = self.data.name
    self.lockText.text = self.data.name
    SetActive(self.normalObj, self.data.isUnLock == true)
    SetActive(self.lockObj, self.data.isUnLock ~= true)
end

function KingDeerNovelItem:Clear()
    self.data = nil
end

function KingDeerNovelItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end