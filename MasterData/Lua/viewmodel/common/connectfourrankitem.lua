




ConnectFourRankItem = {}
ConnectFourRankItem.__index = ConnectFourRankItem

local objs = {
    heroIcon = { path = "Content/HeadIcon", type = "RawImage" },
    heroFrame = { path = "Content/HeadBGS", type = "Image" },
    normalRank_1 = { path = "LevelBgs/LevelBgsType1", type = "GameObject" },
    normalRank_2 = { path = "LevelBgs/LevelBgsType2", type = "GameObject" },
    AchieveNum = { path = "TextGroup/Downtext", type = "Text" },
    heroName = { path = "HeroName", type = "Text" },
    levelNum_1 = { path = "LevelBgs/LevelBgsType1/Level", type = "Text" },
    levelNum_2 = { path = "LevelBgs/LevelBgsType2/Level", type = "Text" },
    HeroIconConstan = { path = "Content", type = "GameObject" },
    emptyIcon = { path = "HeadEmptyIcon", type = "GameObject" }
}

function ConnectFourRankItem.New(prefab, parent)
    local self = {}
    setmetatable(self, ConnectFourRankItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")





    return self
end

function ConnectFourRankItem:SetData(data)
    self.data = data
    SetActive(self.emptyIcon, data.emptyData)
    SetActive(self.HeroIconConstan, not data.emptyData)
    SetActive(self.normalRank_1, data.frontTree)
    SetActive(self.normalRank_2, data.normalRank)
    self.heroIcon.texture = data.avatar
    PlayerAvatarFrameTool.SetAvatarFrame(self.heroFrame, data.avatarFrame)
    self.heroName.text = data.heroName
    self.levelNum_1.text = data.levelNum
    self.levelNum_2.text = data.levelNum
    self.AchieveNum.text = data.AchieveNum

    SetActive(self.gameObject, true)
end

function ConnectFourRankItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.heroFrame)
    self.data = nil
    SetActive(self.gameObject, false)
end

function ConnectFourRankItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.heroFrame)
    if (self.OnClickBg ~= nil) then
        LuaMgr.RemoveClick(self.bg, self.OnClickBg)
        self.OnClickBg = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end