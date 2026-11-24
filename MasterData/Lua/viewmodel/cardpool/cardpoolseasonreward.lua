





CardPoolSeasonReward = {}

CardPoolSeasonReward.__index = CardPoolSeasonReward

local objs = {
    count = {path = "Count",type = "Text"},
    name = {path = "Name",type = "Text"},
    rare = {path = "Rare",type = "Image"},
    icon = {path = "Icon",type = "RawImage"},
    iconBtn = {path = "Icon",type = "Button"},
    isGet = {path = "IsGet",type = "GameObject"},
    isGetText = {path = "IsGet/Text",type = "Text"},
    getBtn = {path = "IsGet",type = "Button"},
    isProgress = {path = "IsProgress",type = "GameObject"},
    isProgressText = {path = "IsProgress/Text",type = "Text"},
    isComleted = {path = "IsComleted",type = "GameObject"},
    isComletedText = {path = "IsComleted/Text",type = "Text"},
    mask = {path = "Mask",type = "GameObject"},
}

function CardPoolSeasonReward.New()
    local self = {}
    setmetatable(self, CardPoolSeasonReward)
    return self
end

function CardPoolSeasonReward:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        self.callBack(self.data)
    end
    self.iconCommand = function()
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, self.data[2], false, false, false)
    end
    LuaMgr.AddClick(self.getBtn,self.clickCommand)
    LuaMgr.AddClick(self.iconBtn,self.iconCommand)
end

function CardPoolSeasonReward:SetData(data)
    self.data = data.data.data
    self.state = data.data.state
    self.callBack = data.data.callBack

    self.count.text = string.format(ConfigMgr.LangGlobal("34161"),self.data[1])
    local cfgItem = ConfigItemMgr.GetItemById(self.data[2])
    if not TableIsNull(cfgItem) then
        self.name.text = LuaMgr.GetLangText(cfgItem.nameLan).."*"..self.data[3];
        self.rare.sprite = ConfigHelper.GetRareSprite(cfgItem.rare)
        self.icon.texture = ConfigHelper.GetItemTexture(cfgItem.id)
    end
    self.isGetText.text = ConfigMgr.LangGlobal("34165")
    self.isProgressText.text = ConfigMgr.LangGlobal("34166")
    self.isComletedText.text = ConfigMgr.LangGlobal("34164")
    SetActive(self.isGet,self.state == 3)
    SetActive(self.isProgress,self.state == 2)
    SetActive(self.isComleted,self.state == 1)
    SetActive(self.mask,self.state == 1)
    self.gameObject:SetActive(true)
end

function CardPoolSeasonReward:Clear()
    self.data = nil
    self.state = nil
    self.callBack = nil
    self.gameObject:SetActive(false)
end

function CardPoolSeasonReward:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.getBtn, self.clickCommand)
        self.clickCommand = nil
    end
    if (self.iconCommand ~= nil) then
        LuaMgr.RemoveClick(self.iconBtn, self.iconCommand)
        self.iconCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end