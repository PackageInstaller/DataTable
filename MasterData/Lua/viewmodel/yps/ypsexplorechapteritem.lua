YPSExploreChapterItem = {};

YPSExploreChapterItem.__index = YPSExploreChapterItem;
local objs = {
    imgTag = { path = "root/nameImg/tagImg", type = "Image" },
    imgName = { path = "root/nameImg", type = "Image" },
    norObj = { path = "root/nor", type = "GameObject" },
    lockObj = { path = "root/lock", type = "GameObject" },
    btnClick = { path = "root/btnClick", type = "Button" },
    pos1 = { path = "root/pos1", type = "RectTransform" },
    pos2 = { path = "root/pos2", type = "RectTransform" },
}

function YPSExploreChapterItem.New()
    local self = {};
    setmetatable(self, YPSExploreChapterItem);
    return self;
end

function YPSExploreChapterItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick, function()
        if self.data.isLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.data.lockInfoTips)
        else
            if self.data.callBack ~= nil then
                self.data.callBack(self.data.index);
            end
        end
    end)
end

function YPSExploreChapterItem:SetData(pdata)
    self.data = pdata.data
    self.transform.anchoredPosition = self.data.locPos;
    self:SetLock(self.data.isLock)
    local cityName = string.format("ui_hd_wps_miangq_0%s", self.data.index)
    self.imgName.sprite = LuaMgr.GetSprite("YPS", cityName);
end

function YPSExploreChapterItem:ShowUnlockEff()

end

function YPSExploreChapterItem:SetLock(lock)
    SetActive(self.norObj, not lock)
    SetActive(self.lockObj, lock)
    local type = lock and "1" or "2"
    if (self:CheckFinish()) then
        type = "3"
        SetActive(self.norObj, false)
    end
    local str          = string.format("ui_hd_wps_miants%s_0%s", self.data.index, type)
    self.imgTag.sprite = LuaMgr.GetSprite("YPS", str);
    self.imgTag:SetNativeSize()
end

function YPSExploreChapterItem:CheckFinish()
    local eventList = YPSMgr.GetEventsByGroupId(self.data.config.id)
    if eventList == nil or #eventList == 0 then return end;
    local totalNum = 0
    local finishNum = 0
    for i, v in ipairs(eventList) do
        totalNum = totalNum + 1
        local pPass = YPSMgr.CheckEventIsComplete(v);
        if (pPass) then
            finishNum = finishNum + 1
        end
    end
    if (totalNum == finishNum) then
        return true
    else
        return false
    end
end

function YPSExploreChapterItem:Clear()
    self.data = nil;
end

function YPSExploreChapterItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end