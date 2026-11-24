LHSAEventItem = {};

LHSAEventItem.__index = LHSAEventItem;
local objs = {
    imgIcon = { path = "root/icon", type = "Image" },
    goState1 = { path = "root/buttom/state1", type = "GameObject" },
    goState2 = { path = "root/buttom/state2", type = "GameObject" },
    imgState1Type = { path = "root/buttom/state1/type", type = "Image" },
    txtState1Name = { path = "root/buttom/state1/name", type = "Text" },
    imgState1Tag = { path = "root/buttom/state1/tag", type = "Image" },
    goRed = { path = "root/buttom/red", type = "GameObject" },
    btnBg = { path = "root/icon", type = "Button" },

}
function LHSAEventItem.New()
    local self = {};
    setmetatable(self, LHSAEventItem);
    return self;
end

function LHSAEventItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg, function()
        if self.data.callBack ~= nil then
            self.data.callBack(self.data.index);
        end
    end)
end

function LHSAEventItem:SetData(pdata)
    self.data = pdata.data
    local iconName = self.data.isUnlock and string.format("%s%s", "ui_hd_tytm_zjm_tc_graphic_", self.data.tag)
        or string.format("%s%s_wjs", "ui_hd_tytm_zjm_tc_graphic_", self.data.tag)
    self.imgIcon.sprite = LuaMgr.GetSprite("FSMY", iconName);
    SetActive(self.goState1, self.data.isUnlock)
    SetActive(self.goState2, not self.data.isUnlock);
    SetActive(self.goRed, self.data.isRed);
    if not self.data.isUnlock then
        return;
    end
    self.txtState1Name.text = self.data.name;
    self.imgState1Type.sprite = LuaMgr.GetSprite("FSMY", "ui_hd_tytm_zjm_tc_bt_icon_" .. self.data.tag);
    if self.data.passTag ~= nil then
        SetActive(self.imgState1Tag.gameObject, true)
        self.imgState1Tag.sprite = LuaMgr.GetSprite("FSMY", "ui_hd_tytm_zjm_tc_bt_pj_" .. self.data.passTag);
    else
        SetActive(self.imgState1Tag.gameObject, false)
    end
end

function LHSAEventItem:Clear()
    self.data = nil;
end

function LHSAEventItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self = nil;
end