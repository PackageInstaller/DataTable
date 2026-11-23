







ManagementNovelItem = {}
ManagementNovelItem.__index = ManagementNovelItem

local objs = {
    clickBtn = {path = "", type = UITool.Button},
    animator = {path = "", type = UITool.Animator},
    canvasGroup = {path = "Group", type = UITool.CanvasGroup},
    normalObj = {path = "Group/NomalObj", type = UITool.GameObject},
    lockObj = {path = "Group/LockObj", type = UITool.GameObject},
    normalText = {path = "Group/NomalObj/NameText", type = UITool.Text},
    rewatchFlag = {path = "Group/NomalObj/RewatchFlag", type = UITool.GameObject}
}

function ManagementNovelItem.New()

    local self = {}
    setmetatable(self, ManagementNovelItem)
    return self
end

function ManagementNovelItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    local onClickItem = function()
        self:OnPlayNovel()
    end
    LuaMgr.AddClick(self.clickBtn, onClickItem)
end

function ManagementNovelItem:OnPlayNovel()
    if self.data.isUnLock ~= true then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.data.unlockText)
        return
    end
    local playNovelCallback = function()
        LuaMgr.ShowLuaPanel(UIName.ManagementHomePanel)
        LuaMgr.ShowLuaPanel(UIName.ManagementNovelPanel)
    end
    LuaMgr.PlayNovel(self.data.config.eventParam, playNovelCallback)
    LuaMgr.HidePanel(UIName.ManagementNovelPanel)
end

function ManagementNovelItem:SetData(data)
    self.data = data.data
    self.normalText.text = self.data.name
    SetActive(self.normalObj, self.data.isUnLock == true)
    SetActive(self.lockObj, self.data.isUnLock ~= true)
    SetActive(self.rewatchFlag, self.data.isWatch == true)
end

function ManagementNovelItem:SetAlpha(alpha)
    self.canvasGroup.alpha = alpha
end

function ManagementNovelItem:SetAnimtor(isEnabled)
    self.animator.enabled = isEnabled
end

function ManagementNovelItem:Clear()
    self.data = nil
end

function ManagementNovelItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end