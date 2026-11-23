










SSYXEmployUIInfo = {}
SSYXEmployUIInfo.__index = SSYXEmployUIInfo

local objs = {
    heroIcon = {path = "HeroItem/HeroIcon", type = UITool.RawImage},
    heroJob = {path = "HeroItem/HeroJob", type = UITool.Image},
    heroName = {path = "HeroName", type = UITool.Text},
    managementLevel = {path = "HeroLevel", type = UITool.Text},
    efficiency = {path = "Efficiency", type = UITool.Text},
    efficiencyTitle = {path = "EfficiencyTitle", type = UITool.Text},
    employBtn = {path = "EmployBtn", type = UITool.Button},
    employingObj = {path = "EmployingObj", type = UITool.GameObject}
}

SSYXEmployUIInfo.New = function(obj)

    local self = {}
    setmetatable(self, SSYXEmployUIInfo)
    self.gameObject = obj
    self:Init()
    return self
end

function SSYXEmployUIInfo:Init()

    self.wordItems = {}
    for i = 1, 2 do
        local wordItemName = "WordItem" .. i
        local path = string.format("WordParent/%s", wordItemName)
        objs[wordItemName] = {path = path, type = UITool.GameObject}
    end
    for i = 1, 2 do
        local additionItemName = "Addition" .. i
        local path = string.format("ContentBG/AdditionParent/%s", additionItemName)
        objs[additionItemName] = {path = path, type = UITool.Text}
    end

    UITool.Parse(self.gameObject, self, objs)
    for i = 1, 2 do
        local wordItemObjName = "WordItem" .. i
        local worldItem = SSYXWordItem.New(self[wordItemObjName], false)
        SetActive(self[wordItemObjName], false)
        self.wordItems[i] = worldItem
    end
    self.OnClickEmployBtn = function()
        if self.data == nil then
            return
        end
        if self.data.OnEmployeeCallback ~= nil then
            self.data.OnEmployeeCallback(self)
        end
    end
    LuaMgr.AddClick(self.employBtn, self.OnClickEmployBtn)
end

function SSYXEmployUIInfo:SetData(data)
    self.data = data
    if self.data == nil then
        LuaDebug.error("SSYXEmployUIInfo:SetData data is nil")
        return
    end
    local headIconPath = ConfigHelper.GetCharacterAvatarPath(self.data.ID, self.data.ID .. "001")
    self.heroIcon.texture = LuaMgr.GetTexture(headIconPath)
    self.heroJob.sprite = HeroMgr.GetHeroJobRareIcon1(self.data.ID, self.data.Rare)
    self.heroName.text = self.data.Name
    self.managementLevel.text = string.format("Lv.%s", self.data.Level)
    self.efficiency.text = string.format("%d%%", math.floor(self.data.Config.Attribute / 100))
    SetActive(self.employingObj, self.data.BeEmplooyed == true)
    local wordDatas = SSYXData.GetEmployeeWordDatas(self.data.ID)
    for i = 1, 2 do
        local additionItemName = "Addition" .. i
        local additionItemNameTxt = self[additionItemName]
        if wordDatas[i] ~= nil then
            SetActive(self.wordItems[i].gameObject, true)
            local data = table.CopyNoMeta(wordDatas[i])
            data.IsEmployee = true
            self.wordItems[i]:SetData(data)
            SetActive(additionItemNameTxt.gameObject, true) 
            additionItemNameTxt.text = LuaMgr.GetLangText(wordDatas[i].Config.NameLan) .. " " .. LuaMgr.GetLangText(wordDatas[i].Config.DescriptionLan)
        else
            SetActive(self.wordItems[i].gameObject, false)
            SetActive(additionItemNameTxt.gameObject, false)
        end
    end
    SetActive(self.employBtn.gameObject, self.data.BeEmplooyed == false)
    SetActive(self.employingObj, self.data.BeEmplooyed == true)
end

function SSYXEmployUIInfo:SetEfficiencyTitle(lanstr)
    self.efficiencyTitle.text = LuaMgr.GetLangText(lanstr)
end

function SSYXEmployUIInfo:ClearItems()
end

function SSYXEmployUIInfo:Clear()
    self:ClearItems()
end

function SSYXEmployUIInfo:Destroy()
    LuaMgr.RemoveClick(self.employBtn, self.OnClickEmployBtn)
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end