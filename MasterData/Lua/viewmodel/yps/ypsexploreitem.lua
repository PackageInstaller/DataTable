YPSExploreItem = {};

YPSExploreItem.__index = YPSExploreItem;
local objs = {
    animator = { path = "", type = "Animator" },
    imgTag = { path = "root/tagImg", type = "Image" },
    btnClick = { path = "root/btnClick", type = "Button" },
    imgFinish = { path = "root/imgFinish", type = "GameObject" },
    imgFinish2 = { path = "root/imgFinish2", type = "GameObject" },
}

function YPSExploreItem.New()
    local self = {};
    setmetatable(self, YPSExploreItem);
    return self;
end

function YPSExploreItem:Init()
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

function YPSExploreItem:SetData(pdata)
    self.data = pdata.data
    self.transform.anchoredPosition = self.data.locPos;
    self.imgTag.sprite = LuaMgr.GetSprite("YPS", "ui_hd_wps_gq_" .. self.data.iconName)
    self:CheckPass(self.data.isPass)
end

function YPSExploreItem:CheckPass(isPass)
    self.animator.enabled = not isPass;
    SetActive(self.imgFinish2,
        isPass and (self.data.config.type == 1 or self.data.config.type == 7 or self.data.config.type == 6))
    SetActive(self.imgFinish, isPass and (self.data.config.type == 2))
end

function YPSExploreItem:Clear()
    self.data = nil;
end

function YPSExploreItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end