





WishItem = {}

WishItem.__index = WishItem

local objs = {
    heroPic = {path = "HeroPic",type = "RawImage"},
    job = {path = "Job",type = "Image"},
    choose = {path = "Choose",type = "GameObject"},
    nameText = {path = "Name/Text",type = "Text"},
    heroPicBtn = {path = "HeroPic",type = "Button"},
}

function WishItem.New()
    local self = {}
    setmetatable(self, WishItem)
    return self
end

function WishItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        self.callBack(self.index)
    end
    LuaMgr.AddClick(self.heroPicBtn,self.clickCommand)
end

function WishItem:SetData(data)
    self.data = data.data.data
    self.index = data.data.index
    self.chooseState = data.data.chooseState
    self.callBack = data.data.callBack
    local config = ConfigMgr.Config.characterTable[self.data]
    if TableIsNull(config) then return end
    self.heroPic.texture = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(self.data,"001"))
    self.job.sprite = LuaMgr.GetSprite("JobIcon","job_"..config.job)
    self.nameText.text = LuaMgr.GetLangText(config.namelan)
    SetActive(self.choose,self.chooseState)
    self.transform.anchoredPosition = Vector2(self.transform.anchoredPosition.x,0)
    self.gameObject:SetActive(true)
end

function WishItem:Clear()
    self.data = nil
    self.callBack = nil
    self.index = nil
    self.chooseState = nil
    self.gameObject:SetActive(false)
end

function WishItem:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.heroPicBtn, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end