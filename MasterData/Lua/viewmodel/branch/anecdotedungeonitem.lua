





AnecdoteDungeonItem = {}
AnecdoteDungeonItem.__index = AnecdoteDungeonItem
AnecdoteDungeonItem.IconPath = "Assets/_BundleResources/Images/BranchAnecdote/"

local objs = {
    icon = {path = "Icon",type = "RawImage"},
    clickBtn = {path = "Icon",type = "Button"},
    isNovel = {path = "Novel",type = "GameObject"},
    isBattle = {path = "Battle",type = "GameObject"},
    isPass = {path = "Pass",type = "GameObject"},
    isPerfect = {path = "Perfect",type = "GameObject"},
    isLock = {path = "Lock",type = "GameObject"},
    numText = {path = "Text",type = "Text"},
    novelEffect = {path = "AnecdoteEff_group",type = "GameObject"},
    battleEffect = {path = "AnecdoteEff_group_02",type = "GameObject"},
}

function AnecdoteDungeonItem.New()
    local self = {}
    setmetatable(self, AnecdoteDungeonItem)
    return self
end

function AnecdoteDungeonItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.AnecdoteDungeonClick,self.data.index)
    end
    LuaMgr.AddClick(self.clickBtn,self.clickCommand)
end

function AnecdoteDungeonItem:SetData(data)
    self.id = data.data.id
    self.data = data.data
    self.icon.texture = LuaMgr.GetTexture(self.IconPath..self.id.."_Dungeon_1.png")
    self.numText.text = "0"..self.data.index
    SetActive(self.isNovel,self.data.data.type == "1")
    SetActive(self.isBattle,self.data.data.type == "2")
    SetActive(self.isPass,self.data.data.state == 2)
    SetActive(self.isPerfect,self.data.data.state == 1)
    local unlocked = DataMgr.Player.branch.children["Reg2001"].children[self.id].children[self.data.data.id].unlocked
    self.icon.color = unlocked and UnityEngine.Color(1,1,1,1) or UnityEngine.Color(1,1,1,0.6)
    SetActive(self.isLock,not unlocked)
    SetActive(self.novelEffect,self.data.data.type == "1" and unlocked)
    SetActive(self.battleEffect,self.data.data.type == "2" and unlocked)
    self.gameObject:SetActive(true)
end

function AnecdoteDungeonItem:Clear()
    self.gameObject:SetActive(false)
end

function AnecdoteDungeonItem:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.clickCommand)
        self.clickCommand = nil
    end
    self.data = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end