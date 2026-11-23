JSYZMapLvItem = {};

JSYZMapLvItem.__index = JSYZMapLvItem;
local objs = {
    rootTf = { path = "", type = "RectTransform" },
    btnBg = { path = "", type = "Button" },
    bgbox = { path = "bgbox", type = "GameObject" },
    bg1 = { path = "bgbox/bg1", type = "GameObject" },
    bg2 = { path = "bgbox/bg2", type = "GameObject" },
    imgFinish1 = { path = "bgbox/ImgFinish1", type = "GameObject" },
    imgFinish2 = { path = "bgbox/ImgFinish2", type = "GameObject" },
    textName = { path = "TextName", type = "Text" },
    bgLockbox = { path = "bgLockbox", type = "GameObject" },
    bgLock1 = { path = "bgLockbox/bgLock1", type = "GameObject" },
    bgLock2 = { path = "bgLockbox/bgLock2", type = "GameObject" },
    textNameLock = { path = "TextNameLock", type = "Text" },
}

function JSYZMapLvItem.New()
    local self = {};
    setmetatable(self, JSYZMapLvItem);
    self.isActive = false;
    return self;
end

function JSYZMapLvItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg, function()
        if self.data.callBack ~= nil then
            self.data.callBack(self.data);
        end
    end)
end

function JSYZMapLvItem:SetData(pdata)
    self.data = pdata.data
    self.textName.text = LuaMgr.GetLangText(self.data.config.namelan)
    self.textNameLock.text = ""
    if (self.data.isRotate) then
        self.imgFinish1.transform.localEulerAngles = Vector3(0, 180, 0);
        self.bgbox.transform.localEulerAngles = Vector3(0, 180, 0);
        self.bgLockbox.transform.localEulerAngles = Vector3(0, 180, 0);
        self.rootTf.anchoredPosition = JSYZMgr.GetEventLocPosition(self.data.config.classId, -70, 0)
        self.textName.transform.localPosition = Vector3(-15, 0, 0);
        self.textNameLock.transform.localPosition = Vector3(-15, 0, 0);
    else
        self.imgFinish1.transform.localEulerAngles = Vector3(0, 0, 0);
        self.bgbox.transform.localEulerAngles = Vector3(0, 0, 0);
        self.bgLockbox.transform.localEulerAngles = Vector3(0, 0, 0);
        self.textName.transform.localPosition = Vector3(15, 0, 0);
        self.textNameLock.transform.localPosition = Vector3(15, 0, 0);
        self.rootTf.anchoredPosition = JSYZMgr.GetEventLocPosition(self.data.config.classId, 70, 0)
    end
    local showBg1 = self.data.config.type == 1
    if (self.data.isPass) then
        SetActive(self.imgFinish1, showBg1)
        SetActive(self.imgFinish2, not showBg1)
        SetActive(self.bg1, showBg1)
        SetActive(self.bg2, not showBg1)
        SetActive(self.bgLock1, false)
        SetActive(self.bgLock2, false)
    else
        if (self.data.isUnLock) then
            SetActive(self.imgFinish1, false)
            SetActive(self.imgFinish2, false)
            SetActive(self.bg1, showBg1)
            SetActive(self.bg2, not showBg1)
            SetActive(self.bgLock1, false)
            SetActive(self.bgLock2, false)
        else
            self.textNameLock.text = LuaMgr.GetLangText(self.data.config.namelan)
            SetActive(self.imgFinish1, false)
            SetActive(self.imgFinish2, false)
            SetActive(self.bg1, false)
            SetActive(self.bg2, false)
            SetActive(self.bgLock1, showBg1)
            SetActive(self.bgLock2, not showBg1)
        end
    end
end

function JSYZMapLvItem:Clear()
    self.data = nil;
end

function JSYZMapLvItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end