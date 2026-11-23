BossDummy5BuffDescItem = {}

BossDummy5BuffDescItem.__index = BossDummy5BuffDescItem

local objs = {
    itemTF = { path = "", type = "RectTransform" },
    clickBtn = { path = "Group/Bg", type = "UIButtonClick" },
    iconImg = { path = "Group/IconBg/Icon", type = "Image" },
    nameText = { path = "Group/Name", type = "Text" },
    descText = { path = "Group/Desc", type = "Text" },
    chooseGo = { path = "Group/Choose", type = "GameObject" },
}

function BossDummy5BuffDescItem.New()
    local obj = {}
    setmetatable(obj, BossDummy5BuffDescItem)
    return obj
end

function BossDummy5BuffDescItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickItem = function()
        if self.callback ~= nil then
            self.callback(self.config.Id)
        else
            LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3BuffDescPopupViewModel, self.config.Id);
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.OnClickItem);
end

function BossDummy5BuffDescItem:SetData(pdata)
    self.data = pdata.data
    self.callback = self.data.callback
    self.config = self.data.config
    
    self.iconImg.sprite = LuaMgr.GetSprite("BuffIcon", self.config.BuffIcon)
    self.nameText.text = LuaMgr.GetLangText(self.config.BuffName)
    self.descText.text = LuaMgr.GetLangText(self.config.BuffDes)
    self.itemTF.anchoredPosition = Vector2(self.data.listHeight.offset_x, -self.data.listHeight.height)
    local preferredHeight = self.descText.preferredHeight
    local itemHeight = preferredHeight + 48
    if itemHeight < 108 then
        itemHeight = 108
    end
    self.itemTF.sizeDelta = Vector2(self.data.listHeight.width, itemHeight)
    self.data.listHeight.height = self.data.listHeight.height + itemHeight

    SetActive(self.chooseGo, self.data.choose)
end

function BossDummy5BuffDescItem:Clear()
    self.data = nil
end

function BossDummy5BuffDescItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end