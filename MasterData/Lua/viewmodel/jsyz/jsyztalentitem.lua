JSYZTalentItem = {};

JSYZTalentItem.__index = JSYZTalentItem;

local objs = {
    rootTf = { path = "", type = "RectTransform" },
    groupBtn = { path = "Group", type = "Button" },
    imageBg = { path = "Group/ImageBg", type = "Image" },
    imageIcon = { path = "Group/ImageIcon", type = "Image" },
    imageSelect = { path = "Group/ImageSelect", type = "Image" },
    vfx_loop = { path = "Group/vfx_loop", type = "GameObject" },
    vfx_once = { path = "Group/vfx_once", type = "GameObject" },
};

function JSYZTalentItem.New()
    local self = {};
    setmetatable(self, JSYZTalentItem);
self.state = 0
    return self;
end

function JSYZTalentItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (not DataExHelper.CommonActivityCheck(ActivityKey.JSYZ)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"));
            return;
        end
        if (self.data.callback ~= nil) then
            self.data.callback(self.data.num)
        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function JSYZTalentItem:SetData(data)
    self.data = data.data;
    self.rootTf.anchoredPosition = Vector2(self.data.pos[1], self.data.pos[2]);
    self.gameObject.name = self.data.config.Id

    self:ShowSelected(self.data.isSelected)
    local isFinishStr = self.data.isFinish == true and "" or "_wjs"
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
    local iconSpriteName = string.format(self.data.config.BuffIcon, isFinishStr)
    if (self.data.config.Para2 == 1) then
        isFinishStr = isFinishStr .. "01"

    end
    local bgSpriteName = string.format("ui_hd_rsrh_kjs_sz%s", isFinishStr)
    self.imageIcon.sprite = LuaMgr.GetSprite("JSYZ", iconSpriteName)
    self.imageBg.sprite = LuaMgr.GetSprite("JSYZ", bgSpriteName)
end

function JSYZTalentItem:ShowSelected(bShow)
    SetActive(self.imageSelect.gameObject, bShow)



end

function JSYZTalentItem:ShowOnce(bShow)
    SetActive(self.vfx_once, bShow)
end

function JSYZTalentItem:Clear()
    self.data = nil;
end

function JSYZTalentItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end