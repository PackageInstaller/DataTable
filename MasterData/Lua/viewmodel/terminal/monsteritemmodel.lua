




MonsterItemModel = {}

MonsterItemModel.__index = MonsterItemModel

local objs = {
    isBoos = {path = "IsBoos", type = "GameObject"},
    icon = {path = "Icon", type = "RawImage"},
    iconIsShow = {path = "Icon", type = "GameObject"},
    name = {path = "Name", type = "Text"},
    nameIsShow = {path = "Name", type = "GameObject"},
    jobIsShow = {path = "Job", type = "GameObject"},
    jobIcon = {path = "Job/Job", type = "Image"},
    button = {path = "Button", type = "Button"},
}

function MonsterItemModel.New(prefab, parent)
    local self = {}
    setmetatable(self, MonsterItemModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.clickCommand = function()
        if self.data.unLock then
            LuaMgr.InvokeUIEventListeners(UIEventConst.MonsterItemClick, self.data.Id)
        end
    end
    LuaMgr.AddClick(self.button,self.clickCommand)
    return self
end

function MonsterItemModel:SetData(data)
    self.data = data
    if self.data.unLock then
        local config = ConfigMgr.Config.monsterMap[self.data.MonsterSkin]
        self.name.text = LuaMgr.GetLangText(config.NameLan)
        self.jobIcon.sprite = LuaMgr.GetSprite("JobIcon","job2_"..config.job)
        self.icon.texture = LuaMgr.GetTexture(ConfigHelper.GetMonsterAvatarPath(config.id))
    end
    SetActive(self.isBoos,self.data.Type == 4)
    SetActive(self.iconIsShow,self.data.unLock)
    SetActive(self.nameIsShow,self.data.unLock)
    SetActive(self.jobIsShow,self.data.unLock)
    self.gameObject:SetActive(true)
end

function MonsterItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function MonsterItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end