















ZXLGlassItem = {}
ZXLGlassItem.__index = ZXLGlassItem

local objs = {
    button = {path = "Group", type = UITool.Button},
    icon = {path = "Group/Unlock/Icon", type = UITool.Image},
    unlockObj = {path = "Group/Unlock", type = UITool.GameObject},
    selectFlag = {path = "Group/SelectFlag", type = UITool.GameObject},
    lockObj = {path = "Group/Lock", type = UITool.GameObject},
    numberText = {path = "Group/NumberBG/NumberText", type = UITool.Text},
    unlockNumberBG = {path = "Group/NumberBG", type = UITool.GameObject},
    completeGroup = {path = "Group/CompleteGroup", type = UITool.GameObject},
    passLevelGroup = {path = "Group/CompleteGroup/PassLevel", type = UITool.GameObject},
    gameLevelGroup = {path = "Group/CompleteGroup/GameLevel", type = UITool.GameObject},
    novelObj = {path = "Group/CompleteGroup/Novel", type = UITool.GameObject},
    gotFlag = {path = "Group/CompleteGroup/GotFlag", type = UITool.GameObject}
}

function ZXLGlassItem.New(prefab, parent)

    local self = {}
    setmetatable(self, ZXLGlassItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self:BatchInitNode()
    UITool.Parse(self.gameObject, self, objs)
    local func = function()
        if self.clickCallback then
            self.clickCallback(self, false)
        end
    end
    LuaMgr.AddClick(self.button, func)
    return self
end

function ZXLGlassItem:BatchInitNode()
    for i = 1, 3 do
        local name1 = "scorePassLevel" .. i
        local data = {}
        data.path = string.format("Group/CompleteGroup/PassLevel/Level%d", i)
        data.type = UITool.GameObject
        objs[name1] = data

        local name2 = "scoreGameLevelLight" .. i
        local data = {}
        data.path = string.format("Group/CompleteGroup/GameLevel/Level%d/Light", i)
        data.type = UITool.GameObject
        objs[name2] = data

        local name3 = "scoreGameLevelDark" .. i
        local data = {}
        data.path = string.format("Group/CompleteGroup/GameLevel/Level%d/Dark", i)
        data.type = UITool.GameObject
        objs[name3] = data
    end
end

function ZXLGlassItem:SetData(data)
    self.data = data.data
    self.isSelected = self.data.isSelected
    self.clickCallback = data.clickCallback
    self:SetItem()
    if self.clickCallback ~= nil then
        self.clickCallback(self, true)
    end
    SetActive(self.gameObject, true)
end

function ZXLGlassItem:SetItem()
    self:RefreshSeletedStatus()
    SetActive(self.unlockObj, self.data.isUnlock == true)
    SetActive(self.lockObj, self.data.isUnlock ~= true)
    SetActive(self.completeGroup, self.data.isUnlock == true)
    SetActive(self.unlockNumberBG, self.data.isUnlock == true)
    self.numberText.text = tostring(self.data.glassNumber)
    if self.data.isUnlock == true then
        self.icon.sprite = LuaMgr.GetSprite(ZXLConst.AtlaName, self.data.config.Icon)
        self:RefreshCompleteFlag()
    end
end

function ZXLGlassItem:RefreshCompleteFlag()
    local data = self.data
    SetActive(self.novelObj, data.config.Area == ZXLConst.EventType.Novel)
    SetActive(self.gameLevelGroup, data.config.Area == ZXLConst.EventType.Play)
    SetActive(self.passLevelGroup, data.config.Area ~= ZXLConst.EventType.Novel and data.config.Area ~= ZXLConst.EventType.Play)
    if data.config.Area == ZXLConst.EventType.Novel then
        SetActive(self.novelObj, data.status == CommonRewardItem.Status.Got)
    elseif data.config.Area == ZXLConst.EventType.Play then
        SetActive(self.gameLevelGroup, data.scoreLevel > 0)
        if data.scoreLevel > 0 then
            for i = 1, 3 do
                local nameLight = "scoreGameLevelLight" .. i
                local nameDark = "scoreGameLevelDark" .. i
                SetActive(self[nameLight], i <= data.scoreLevel)
                SetActive(self[nameDark], i > data.scoreLevel)
            end
        end
    elseif data.config.Area ~= nil then
        for i = 1, 3 do
            local raringName = "scorePassLevel" .. i
            SetActive(self[raringName], data.scoreLevel == i)
        end
    else
        SetActive(self.gotFlag, data.canJoin == true)
    end
end

function ZXLGlassItem:SetSelected(selected)
    self.isSelected = selected
    self:RefreshSeletedStatus()
end

function ZXLGlassItem:RefreshSeletedStatus()
    SetActive(self.selectFlag, self.isSelected)
end

function ZXLGlassItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function ZXLGlassItem:Destroy()
    if self.item ~= nil then
        self.item:Clear()
        self.item = nil
    end
    if self.OnClickItem ~= nil then
        LuaMgr.RemoveClick(self.button, self.OnClickItem)
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end