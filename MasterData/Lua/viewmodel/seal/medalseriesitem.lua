





MedalSeriesItem = {}
MedalSeriesItem.__index = MedalSeriesItem

local objs = {
    item_bg = {path = "Item_Bg",type = "RawImage"},

    display_1 = {path = "Display1",type = "GameObject"},
    display_1_box_1 = {path = "Display1/Item_Box1",type = "RawImage"},
    display_1_icon_1 = {path = "Display1/Item_Box1/MedalIcon",type = "Image"},
    display_1_CanvasGroup_1 = {path = "Display1/Item_Box1",type = "CanvasGroup"},
    display_1_effect_1 = {path = "Display1/Item_Box1/Eff_Medal_par",type = "GameObject"},

    display_2 = {path = "Display2",type = "GameObject"},
    display_2_box_1 = {path = "Display2/Item_Box1",type = "RawImage"},
    display_2_icon_1 = {path = "Display2/Item_Box1/MedalIcon",type = "Image"},
    display_2_CanvasGroup_1 = {path = "Display2/Item_Box1",type = "CanvasGroup"},
    display_2_effect_1 = {path = "Display2/Item_Box1/Eff_Medal_par",type = "GameObject"},
    display_2_box_2 = {path = "Display2/Item_Box2",type = "RawImage"},
    display_2_icon_2 = {path = "Display2/Item_Box2/MedalIcon",type = "Image"},
    display_2_CanvasGroup_2 = {path = "Display2/Item_Box2",type = "CanvasGroup"},
    display_2_effect_2 = {path = "Display2/Item_Box2/Eff_Medal_par",type = "GameObject"},

    display_3 = {path = "Display3",type = "GameObject"},
    display_3_box_1 = {path = "Display3/Item_Box1",type = "RawImage"},
    display_3_icon_1 = {path = "Display3/Item_Box1/MedalIcon",type = "Image"},
    display_3_CanvasGroup_1 = {path = "Display3/Item_Box1",type = "CanvasGroup"},
    display_3_effect_1 = {path = "Display3/Item_Box1/Eff_Medal_par",type = "GameObject"},
    display_3_box_2 = {path = "Display3/Item_Box2",type = "RawImage"},
    display_3_icon_2 = {path = "Display3/Item_Box2/MedalIcon",type = "Image"},
    display_3_CanvasGroup_2 = {path = "Display3/Item_Box2",type = "CanvasGroup"},
    display_3_effect_2 = {path = "Display3/Item_Box2/Eff_Medal_par",type = "GameObject"},
    display_3_box_3 = {path = "Display3/Item_Box3",type = "RawImage"},
    display_3_icon_3 = {path = "Display3/Item_Box3/MedalIcon",type = "Image"},
    display_3_CanvasGroup_3 = {path = "Display3/Item_Box3",type = "CanvasGroup"},
    display_3_effect_3 = {path = "Display3/Item_Box3/Eff_Medal_par",type = "GameObject"},

    itemBtn = {path = "Btn",type = "Button"},
}

function MedalSeriesItem.New()
    local self = {}
    setmetatable(self, MedalSeriesItem)
    return self
end

function MedalSeriesItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.itemCommand = function()
        if self.itemClick ~= nil then
            self.itemClick(self.seriesKey,self.data)
        end
    end
    LuaMgr.AddClick(self.itemBtn,self.itemCommand)
end

function MedalSeriesItem:SetData(data)
    self.data = data.data.data
    self.seriesKey = data.data.seriesKey
    self.itemClick = data.data.callBack

    local texture = LuaMgr.GetTexture(Path.Series_Path..self.seriesKey.."_Item_Bg.png")
    self.item_bg.texture = texture
    
    texture = LuaMgr.GetTexture(Path.Series_Path..self.seriesKey.."_Item_Box.png")
    local length = #self.data > 3 and 3 or #self.data
    if length == 1 then
        self.display_1_box_1.texture = texture
    elseif length == 2 then
        self.display_2_box_1.texture = texture
        self.display_2_box_2.texture = texture
    else
        self.display_3_box_1.texture = texture
        self.display_3_box_2.texture = texture
        self.display_3_box_3.texture = texture
    end
    local sprite = nil
    local uiKey = nil
    local isAlpha = false
    for i = 1, length do
        uiKey = "display_"..length.."_icon_"..i
        sprite = LuaMgr.GetSprite("ZhanXunIcon", self.data[i].Id)
        self[uiKey].sprite = sprite
        uiKey = "display_"..length.."_CanvasGroup_"..i
        isAlpha = self:GetState(self.data[i].Id)
        self[uiKey].alpha = isAlpha and 1.0 or 0.5
        uiKey = "display_"..length.."_effect_"..i
        SetActive(self[uiKey],isAlpha)
    end
    SetActive(self.display_1,length == 1)
    SetActive(self.display_2,length == 2)
    SetActive(self.display_3,length == 3)
    self.gameObject:SetActive(true)
end

function MedalSeriesItem:GetState(id)
    if TableIsNull(DataMgr.Player.MedalMap) then
        return false
    end
    if DataMgr.Player.MedalMap[id] == nil then
        return false
    end
    return true
end

function MedalSeriesItem:Clear()
    self.data = nil
    self.seriesKey = nil
    self.itemClick = nil
    self.gameObject:SetActive(false)
end

function MedalSeriesItem:Destroy()
    if (self.itemCommand ~= nil) then
        LuaMgr.RemoveClick(self.itemBtn, self.itemCommand)
        self.itemCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end