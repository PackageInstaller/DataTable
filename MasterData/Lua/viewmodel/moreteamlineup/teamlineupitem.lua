





TeamlineupItem = {}

TeamlineupItem.__index = TeamlineupItem

local objs = {
    normal = {path = "Normal", type = "GameObject"},
    normalImg = {path = "Normal", type = "Image"},
    name = {path = "Normal/Name", type = "Text"},
    icon = {path = "Normal/Icon", type = "Image"},
    completed = {path = "Normal/Completed", type = "GameObject"},
    number = {path = "Normal/Number", type = "Text"},
    selectBox = {path = "Normal/Select", type = "GameObject"},
    red = {path = "Normal/Red", type = "GameObject"},

    null = {path = "Null", type = "GameObject"},
    nullText = {path = "Null/Text", type = "Text"},
    isClick = {path = "Normal", type = "Button"},
}

function TeamlineupItem.New()
    local self = {}
    setmetatable(self, TeamlineupItem)
    return self
end

function TeamlineupItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        if self.callBack ~= nil then
            self.callBack(self.index,self.data.data)
        end
    end
    LuaMgr.AddClick(self.isClick,self.clickCommand)
end

function TeamlineupItem:SetData(data)
    self.data = data.data
    self.index = data.id
    local isNull = TableIsNull(self.data)
    if isNull then
        self.nullText.text = ConfigMgr.LangGlobal("30208")
    else
        self:SetRed()
        self.callBack = data.data.callBack
        self.name.text = LuaMgr.GetLangText(self.data.data.ThemeNameLan)
        self.icon.sprite = LuaMgr.GetSprite("MoreTeamlineupLabel","Label_"..self.data.data.Id)
        self.normalImg.sprite = LuaMgr.GetSprite("MoreTeamlineupLabel","Label_"..self.data.data.Id.."_1")
        SetActive(self.selectBox,self.index == data.data.index)
    end
    SetActive(self.null,isNull)
    SetActive(self.normal,not isNull)
    self.gameObject:SetActive(true)
end

function TeamlineupItem:SetRed()
    local redCount = 0
    if self.data.data.Id == "5172" then

        redCount = HeroRedDataHelper.SetTeamRelay2Red()
        SetActive(self.red,redCount > 0)
    elseif self.data.data.Id == "10002" then

        local red1, red2 = HeroRedDataHelper.GetTrainingRewardRed()
        SetActive(self.red,red1 + red2 > 0)
    end
end

function TeamlineupItem:Clear()
    self.data = nil
    self.index = nil
    self.callBack = nil
    self.gameObject:SetActive(false)
end

function TeamlineupItem:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.isClick, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end