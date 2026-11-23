TeamRelay2RecordHeadItem = {}

TeamRelay2RecordHeadItem.__index = TeamRelay2RecordHeadItem

local objs = {
    icon = { path = "Icon", type = UITool.RawImage },
    job = { path = "Job", type = UITool.Image },
}

function TeamRelay2RecordHeadItem.New(obj, parent)
    local self = {}
    setmetatable(self, TeamRelay2RecordHeadItem)
    self.gameObject = LuaMgr.InstantiateGO(obj, parent, false)
    self.transform = self.gameObject.transform;
    self:Init()
    return self
end

function TeamRelay2RecordHeadItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.gameObject, false)
end

function TeamRelay2RecordHeadItem:SetData(characterId)
    self.characterId = characterId
    local tempCharacter = ConfigMgr.Config.characterTable[characterId]
    self.icon.texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(characterId))
    self.job.sprite = LuaMgr.GetSprite("JobIcon","job_"..tempCharacter.job)
    SetActive(self.gameObject, true)
end

function TeamRelay2RecordHeadItem:Hide()
    SetActive(self.gameObject, false)
end

function TeamRelay2RecordHeadItem:Clear()
    self.data = nil
end

function TeamRelay2RecordHeadItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end