





YXTwoNovelItemViewModel = {}

YXTwoNovelItemViewModel.__index = YXTwoNovelItemViewModel
YXTwoNovelItemViewModel.IconPath = "Assets/_BundleResources/Images/CollectorNovel/YX2Novel_"
local objs = {
    novelIcon = {path = "NovelIcon",type = "RawImage"},
    lock = {path = "Lock",type = "GameObject"},
    lockIcon = {path = "Lock/LockIcon",type = "RawImage"},
    lockText = {path = "Lock/Tips/Text",type = "Text"},
    novelIcon_1 = {path = "Name/Icon_1",type = "RawImage"},
    novelName = {path = "Name/Text",type = "Text"},
    clickBtn = {path = "NovelIcon",type = "Button"},
    unlockBtn = {path = "Lock",type = "Button"},
}

function YXTwoNovelItemViewModel.New()
    local self = {}
    setmetatable(self, YXTwoNovelItemViewModel)
    return self
end

function YXTwoNovelItemViewModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        local str = ConfigMgr.LangGlobal("7208")
        local goods = ConfigMgr.Config.itemMap[self.data.UnlockType[2]]
        local tipStr = string.format(str,self.data.UnlockType[3],LuaMgr.GetLangText(goods.nameLan))
        LuaMgr.ShowPanel
        (
                UIName.ConfirmSmallViewModel,tipStr,
function()
                    if self.data ~= nil then
self:UnLock()
                    end
                end,nil
        )
    end
    self.playCommand = function()
        self:PlayNovel()
    end
    LuaMgr.AddClick(self.unlockBtn,self.clickCommand)
    LuaMgr.AddClick(self.clickBtn,self.playCommand)
end

function YXTwoNovelItemViewModel:SetData(data)
    self.data = data.data.data
    local icon = LuaMgr.GetTexture(self.IconPath..self.data.Id..".png")
    self.novelIcon.texture = icon
    self.lockIcon.texture = icon
    local icon_1 = LuaMgr.GetTexture(self.IconPath..self.data.Id.."_1.png")
    self.novelIcon_1.texture = icon_1
    self.novelName.text = LuaMgr.GetLangText(self.data.NameLan)
    local tempLock = data.data.state
    if tempLock then
        local goods = ConfigMgr.Config.itemMap[self.data.UnlockType[2]]
        self.lockText.text = string.format(ConfigMgr.LangGlobal("7205"),self.data.UnlockType[3],LuaMgr.GetLangText(goods.nameLan))
    end
    SetActive(self.lock,tempLock)
    self.gameObject:SetActive(true)
end

function YXTwoNovelItemViewModel:UnLock()
    DataHelper.ConditionCheck(self.data.UnlockType[2], tonumber(self.data.UnlockType[3]), function() self:PlayNovel() end)
end
function YXTwoNovelItemViewModel:PlayNovel()
    LuaMgr.PlayNovel(self.data.NarrativesID,
            function()
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeAchievementViewModel,"novel")
            end)
end

function YXTwoNovelItemViewModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function YXTwoNovelItemViewModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.unlockBtn, self.clickCommand)
        self.clickCommand = nil
    end
    if (self.playCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.playCommand)
        self.playCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end