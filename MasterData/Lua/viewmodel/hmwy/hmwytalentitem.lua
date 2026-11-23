HMWYTalentItem = {};

HMWYTalentItem.__index = HMWYTalentItem;

local objs = {
    animator = { path = "", type = "Animator" },
    rootTf = { path = "", type = "RectTransform" },
    groupBtn = { path = "Group", type = "Button" },
    imageBg = { path = "Group/ImageBg", type = "GameObject" },
    textBg = { path = "Group/ImageBg/textBg", type = "GameObject" },
    textLv = { path = "Group/ImageBg/textBg/TextLv", type = "Text" },
    imageLock = { path = "Group/ImageLock", type = "GameObject" },
    lockTextBg = { path = "Group/ImageLock/textBg", type = "GameObject" },
    lockTextLv = { path = "Group/ImageLock/textBg/TextLv", type = "Text" },
    imageIcon = { path = "Group/ImageIcon", type = "Image" },
    imageSelect = { path = "Group/ImageSelect", type = "Image" },
    vfx_loop = { path = "Group/vfx_loop", type = "GameObject" },
    vfx_once = { path = "Group/vfx_levelup", type = "GameObject" },
};

function HMWYTalentItem.New()
    local self = {};
    setmetatable(self, HMWYTalentItem);
self.state = 0
    return self;
end

function HMWYTalentItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (not DataExHelper.CommonActivityCheck(ActivityKey.HMWY)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"));
            return;
        end
        if (self.data.callback ~= nil) then
            self.data.callback(self.data.numIndex)
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function HMWYTalentItem:SetData(data)
    self.data = data.data;
    self.rootTf.anchoredPosition = Vector2(self.data.config.Pos[1], self.data.config.Pos[2]);
    self.gameObject.name = self.data.config.Id

    self:ShowSelected(self.data.isSelected)
    SetActive(self.vfx_once, false)
    if (self.data.isFinish) then
        if (self.state == 1) then
            SetActive(self.vfx_once, true)
        end
        self.state = 2
    elseif (self.data.isUnlock and not self.data.isFinish) then
        self.state = 1
    else
        self.state = 0
    end
    SetActive(self.vfx_loop, self.state == 1)
    local isFinishStr = self.data.isFinish == true and "b" or "a"
    self.imageIcon.sprite = LuaMgr.GetSprite("HMWY", self.data.config.Icon .. isFinishStr)
    SetActive(self.imageBg, self.data.isFinish)
    SetActive(self.imageLock, not self.data.isFinish)
    local textBox = { "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" }
    local numIndex = self.data.isFinish and self.data.config.Index or (self.data.config.Index - 1)
    if (numIndex >= 1) then
        self.textLv.text = textBox[numIndex]
        self.lockTextLv.text = textBox[numIndex]
        SetActive(self.textBg, true)
        SetActive(self.lockTextBg, true)
    else
        SetActive(self.textBg, false)
        SetActive(self.lockTextBg, false)
    end
end

function HMWYTalentItem:ShowSelected(bShow)
    SetActive(self.imageSelect.gameObject, bShow)



end

function HMWYTalentItem:ShowOnce(bShow)
    SetActive(self.vfx_once, bShow)
end

function HMWYTalentItem:Clear()
    self.data = nil;
end

function HMWYTalentItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end