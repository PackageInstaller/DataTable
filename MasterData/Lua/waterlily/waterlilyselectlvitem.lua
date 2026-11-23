









WaterlilySelectLvItem = {}
WaterlilySelectLvItem.__index = WaterlilySelectLvItem

local objs = {
    selectBtn = {path = "", type = UITool.Button},
    group = {path = "Group", type = UITool.GameObject},
    canvasGroup = {path = "Group", type = UITool.CanvasGroup},
    titleImage = {path = "Group/TitleImage", type = UITool.Image},
    finishFlag = {path = "Group/FinishFlag", type = UITool.Image},
    BG_2_1 = {path = "Group/BG_2_1", type = UITool.GameObject},
    LockBG_2_1 = {path = "Group/LockBG_2_1", type = UITool.GameObject}
}

function WaterlilySelectLvItem.New()
    local self = {}
    setmetatable(self, WaterlilySelectLvItem)
    return self
end

function WaterlilySelectLvItem:Init()
    for i = 1, 3 do
        local name = string.format("BG_1_%d", i)
        local tempPath = string.format("Group/%s", name)
        objs[name] = {path = tempPath, type = UITool.GameObject}

        name = string.format("LockBG_1_%d", i)
        tempPath = string.format("Group/%s", name)
        objs[name] = {path = tempPath, type = UITool.GameObject}
    end
    UITool.Parse(self.gameObject, self, objs)
    self.onClickCallback = function()
        if self.data.isUnlock == false then
            local tipsContent = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7319"), self.data.unlockPassName)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        if self.data and self.data.onClickCallback then
            self.data.onClickCallback(self)
        else
            LuaDebug.error("WaterlilySelectLvItem onClickCallback is nil")
        end
    end
    LuaMgr.AddClick(self.selectBtn, self.onClickCallback)
end

function WaterlilySelectLvItem:SetData(data)
    self.canvasGroup.alpha = 1
    self.data = data.data
    local tempType = 1
    if self.data.config.type ~= 4 then
        tempType = 2
    end
    SetActive(self.BG_2_1, tempType == 2)
    SetActive(self.LockBG_2_1, tempType == 2 and self.data.isUnlock == false)
    local index = (data.id - 1) % 3 + 1
    for i = 1, 3 do
        local name1 = string.format("BG_1_%d", i)
        local name2 = string.format("LockBG_1_%d", i)
        SetActive(self[name1], tempType == 1 and i == index)
        SetActive(self[name2], tempType == 1 and i == index and self.data.isUnlock == false)
    end
    local pageIndex = math.floor((data.id - 1) / 3) + 1
    if index % 2 == 0 then
        if pageIndex % 2 == 1 then
            self.group.transform.anchoredPosition = Vector2(0, -80)
        else
            self.group.transform.anchoredPosition = Vector2(0, 20)
        end
    else
        if pageIndex % 2 == 1 then
            self.group.transform.anchoredPosition = Vector2(0, 20)
        else
            self.group.transform.anchoredPosition = Vector2(0, -80)
        end
    end
    local titleSpriteName = string.format("ui_hd_sl_tz_zn_bt%d", data.id)
    local atlaName = "Waterlily"
    if tempType ~= 1 then
        titleSpriteName = string.format("ui_hd_sl_tz_gn_bt%d", data.id)
    end
    self.titleImage.sprite = LuaMgr.GetSprite(atlaName, titleSpriteName)
    self.finishFlag.sprite = LuaMgr.GetSprite(atlaName, self:GetRareSprite(tempType))
    self.finishFlag:SetNativeSize()
    SetActive(self.finishFlag.gameObject, self.data.isFinish == true)
end

function WaterlilySelectLvItem:GetRareSprite(pageType)
    local rating = DataExHelper.GetDungeonDecordRating(self.data.config.eventParam)
    if pageType == 2 and rating > 0 then
        return string.format("ui_hd_sl_tz_pj_%d", 0)
    end
    return string.format("ui_hd_sl_tz_pj_%d", 4 - rating)
end

function WaterlilySelectLvItem:Clear()
    self:ClearItems()
end

function WaterlilySelectLvItem:ClearItems()
    self.data = nil
end

function WaterlilySelectLvItem:Destroy()
end