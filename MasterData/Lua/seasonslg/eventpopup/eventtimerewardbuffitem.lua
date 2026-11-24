





EventTimeRewardBuffItem = {}

EventTimeRewardBuffItem.__index = EventTimeRewardBuffItem
local objs = {
    icon = {path = "Image", type = "RawImage"},
}

function EventTimeRewardBuffItem.New()
    local self = {}
    setmetatable(self, EventTimeRewardBuffItem)
    return self
end

function EventTimeRewardBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    local nameTextTrans = self.gameObject.transform:Find("name")
    local produceTextTrans = self.gameObject.transform:Find("produce")
    local clickButtonTrans = self.gameObject.transform:Find("button")
    local tfDes=self.gameObject.transform:Find("Des")
    if tfDes~=nil then
        self.txtDes=tfDes:GetComponent("Text");
    end
    if nameTextTrans ~= nil then
        self.txtName = nameTextTrans:GetComponent(UITool.Text)
    end
    if produceTextTrans ~= nil then
        self.txtProduce = produceTextTrans:GetComponent(UITool.Text)
    end

    if clickButtonTrans ~= nil then
        self.clickButton = clickButtonTrans:GetComponent(UITool.Button)
    else
        self.clickButton = self.gameObject:GetComponent(UITool.Button)
    end
    if self.clickButton ~= nil then
        self.OnClickButton = function()
            if self.data.onClick ~= nil then
                self.data.itemTransform = self.gameObject.transform
                self.data.onClick(self.data)
            end
        end
        LuaMgr.AddClick(self.clickButton, self.OnClickButton)
    end
end

function EventTimeRewardBuffItem:SetData(data)
    self.data = data.data
    if self.data.config == nil then
        local path = ConfigHelper.GetItemIconPath(self.data.item.id)
        self.icon.texture = LuaMgr.GetTexture(path)
        self.icon.uvRect = UnityEngine.Rect(0, 0, 1, 1)
        if self.txtName ~= nil then
            local itemData = table.Copy(ConfigMgr.Config.itemMap[self.data.item.id])
            self.txtName.text = LuaMgr.GetLangText(itemData.nameLan)
        end
        if self.txtProduce ~= nil then
            self.txtProduce.text = self.data.item.count .. LuaMgr.GetLangText("EventTimeRewardBuffItem_0")
        end
        return
    end

    local buffConfig = self.data.config
    if buffConfig ~= nil then
        if not IsNullOrEmpty(buffConfig.BUFFIcon) then
            local sprite = LuaMgr.GetSprite("BuffIcon", buffConfig.BUFFIcon)
            local texture = sprite.texture
            self.icon.texture = texture
            if self.txtDes~=nil then
                self.txtDes.text=LuaMgr.GetLangText(buffConfig.NameLan)
            end
        end
        if type(buffConfig.BuffIcon) == "string" and buffConfig.BuffIcon ~= "" then
            local sprite = LuaMgr.GetSprite("BuffIcon", buffConfig.BuffIcon)
            local texture = sprite.texture
            local textureRect = sprite.textureRect
            self.icon.texture = texture
            self.icon.uvRect = UnityEngine.Rect(
                textureRect.x / texture.width,
                textureRect.y / texture.height,
                textureRect.width / texture.width,
                textureRect.height / texture.height)
        end

        if self.txtName ~= nil then
            self.txtName.text = LuaMgr.GetLangText(buffConfig.BuffNameLan or buffConfig.NameLan)
        end

        if self.txtProduce ~= nil then
            self.txtProduce.text = LuaMgr.GetLangText(buffConfig.BuffDesLan)
        end
    end
end

function EventTimeRewardBuffItem:Clear()
    self.data = nil
end

function EventTimeRewardBuffItem:Destroy()
    if self.clickButton ~= nil then
        LuaMgr.RemoveClick(self.clickButton, self.OnClickButton)
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end