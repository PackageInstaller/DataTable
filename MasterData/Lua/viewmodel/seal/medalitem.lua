





MedalItem = {}
MedalItem.__index = MedalItem

local objs = {
    choose = {path = "Choose",type = "GameObject"},
    medalIcon = {path = "MedalIcon",type = "Image"},
    medalName = {path = "MedalName",type = "Text"},
    medalIntro = {path = "MedalIntro",type = "Text"},
    time = {path = "Time",type = "Text"},
    itemBtn = {path = "Btn",type = "Button"},
    medalIconBtn = {path = "MedalIcon",type = "Button"},
    tipContent = {path = "TipContent",type = "GameObject"},
    tipText = {path = "TipContent/Text",type = "Text"},
}

function MedalItem.New()
    local self = {}
    setmetatable(self, MedalItem)
    return self
end

function MedalItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.itemCommand = function()
        if self.itemClick ~= nil then
            if self.unlock then
                SetActive(self.choose,not self.choose.activeSelf)
                self.itemClick(self.choose.activeSelf,self.data.Id)
            else
                local tipStr = ConfigMgr.LangGlobal("24065")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
            end
        end
    end
    self.iconCommand = function()
        SetActive(self.tipContent,not self.tipContent.activeSelf)
    end
    LuaMgr.AddClick(self.medalIconBtn,self.iconCommand)
    LuaMgr.AddClick(self.itemBtn,self.itemCommand)
end

function MedalItem:SetData(data)
    self.data = data.data.data
    self.itemClick = data.data.callBack
    self.medalIcon.sprite = LuaMgr.GetSprite("ZhanXunIcon", self.data.Id)
    self.medalName.text = LuaMgr.GetLangText(self.data.NameLan)
    self.medalIntro.text = LuaMgr.GetLangText(self.data.DesLan)
    self.tipText.text = LuaMgr.GetLangText(self.data.RemarksLan)
    SetActive(self.tipContent,false)
    if self:GetState() then
        self.unlock = true
        self.time.text = string.format(ConfigMgr.LangGlobal("24064"),self:SetTime())
        self.time.color = UnityEngine.Color(95 / 255, 92 / 255, 66 / 255, 1)
        SetActive(self.choose,PlayerMedalMgr.Contain(self.data.Id))
    else
        self.unlock = false
        self.time.text = ConfigMgr.LangGlobal("24065")
        self.time.color = UnityEngine.Color(152 / 255, 74 / 255, 61 / 255, 1)
        SetActive(self.choose,false)
    end
    self.gameObject:SetActive(true)
end

function MedalItem:Clear()
    self.data = nil
    self.itemClick = nil
    self.unlock = nil
    self.gameObject:SetActive(false)
end

function MedalItem:GetState()
    if TableIsNull(DataMgr.Player.MedalMap) then
        return false
    end
    if DataMgr.Player.MedalMap[self.data.Id] == nil then
        return false
    end
    return true
end

function MedalItem:SetTime()
    local unlockTime = DataMgr.Player.MedalMap[self.data.Id].UnlockTime
    return os.date("%Y/%m/%d", unlockTime)
end

function MedalItem:Destroy()
    if (self.itemCommand ~= nil) then
        LuaMgr.RemoveClick(self.itemBtn, self.itemCommand)
        self.itemCommand = nil
    end
    if (self.iconCommand ~= nil) then
        LuaMgr.RemoveClick(self.medalIconBtn, self.iconCommand)
        self.iconCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end