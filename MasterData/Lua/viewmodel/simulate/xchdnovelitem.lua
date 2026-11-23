XCHDNovelItem = {};

XCHDNovelItem.__index = XCHDNovelItem;

local objs = {
    rootTf = { path = "", type = "RectTransform" },
    groupBtn = { path = "Group", type = "Button" },
    bg = { path = "Group/bg", type = "Transform" },
    selected = { path = "Group/bg/selected", type = "GameObject" },
    name = { path = "Group/bg/Name", type = "Text" },
    nameTf = { path = "Group/bg/Name", type = "Transform" },
    imgLock = { path = "Group/bg/ImgLock", type = "GameObject" },
};

function XCHDNovelItem.New()
    local self = {};
    setmetatable(self, XCHDNovelItem);
    return self;
end

function XCHDNovelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (not DataExHelper.CommonActivityCheck(ActivityKey.XCHD)) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"));
            return;
        end        
        if (self.isUnLock) then
            if (self.data.callback ~= nil) then
                self.data.callback(self.data.num)
            end
        else
            return












        end
    end
    LuaMgr.AddClick(self.groupBtn, self.OnClickItem);
end

function XCHDNovelItem:SetData(data)
    self.data = data.data;
    self.rootTf.anchoredPosition = Vector2(self.data.pos[1], self.data.pos[2]);
    if (self.data.num < 6 or self.data.num == 12) then
        self.bg.localRotation = UnityEngine.Quaternion.Euler(0, 0, 0);
        self.nameTf.localRotation = UnityEngine.Quaternion.Euler(0, 0, 0);
    else
        self.bg.localRotation = UnityEngine.Quaternion.Euler(0, 180, 0);
        self.nameTf.localRotation = UnityEngine.Quaternion.Euler(0, 180, 0);
    end
    self.isUnLock = XCHDMgr.CheckEventIsUnLock(self.data.config)
    if (self.isUnLock) then
        SetActive(self.imgLock, false);
        self.name.text = LuaMgr.GetLangText(self.data.config.namelan);
    else
        SetActive(self.imgLock, true);
        self.name.text = LuaMgr.GetLangText("XCHDNovelItem_0");
    end
    self:ShowSelected(self.data.isSelected)
end

function XCHDNovelItem:ShowSelected(bShow)
    SetActive(self.selected, bShow)
end

function XCHDNovelItem:Clear()
    self.data = nil;
end

function XCHDNovelItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.groupBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end