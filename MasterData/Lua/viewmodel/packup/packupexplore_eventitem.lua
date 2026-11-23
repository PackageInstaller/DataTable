PackUpExplore_EventItem = {};

PackUpExplore_EventItem.__index = PackUpExplore_EventItem;

local objs = {
    btnClick = { path = "", type = "Button" },
    animator = { path = "", type = "Animator" },
    icon = { path = "icon", type = "Image" },
    imgBg = { path = "ImgBg", type = "Image" },
    ImgFinishN = { path = "ImgFinishN", type = "GameObject" },
    ImgFinishH = { path = "ImgFinishH", type = "GameObject" },
    ImgFinishR = { path = "ImgFinishR", type = "GameObject" },
    textName = { path = "ImgBg/TextName", type = "Text" },
    textPos = { path = "TextPos", type = "Text" },
}

function PackUpExplore_EventItem.New()
    local self = {};
    setmetatable(self, PackUpExplore_EventItem);
    return self;
end

function PackUpExplore_EventItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.btnClick.onClick:RemoveAllListeners()
    LuaMgr.AddClick(self.btnClick, function()
        if not self.data.isLock and self.data.callBack ~= nil then
            self.data.callBack(self.data.index);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22801"));
        end
    end)
end

function PackUpExplore_EventItem:SetData(pdata)
    self.data = pdata.data
    self.transform.anchoredPosition = self.data.locPos   
    self.icon.sprite = LuaMgr.GetSprite("PackUp", "ui_hd_ysjt_zx_gk_jd_" .. self.data.config.statusIcon);
    self.imgBg.sprite = LuaMgr.GetSprite("PackUp", "ui_hd_ysjt_zx_gk_bt_" .. self.data.config.statusIcon);
    self.textName.text = LuaMgr.GetLangText(self.data.config.namelan)

    self:ShowFinishImg(self.data.config.statusIcon, self.data.isPass)    
    local hIndex = PackUpMgr.GetHistoryIndex(self.data.config.id);

    if(not self.data.isPass and hIndex == 0)then
        self.animator.enabled = true
        PackUpMgr.UpdateHistoryIndex(self.data.config.id)
    else
        self.animator.enabled = false
    end
    self.gameObject.name = self.data.index
end

function PackUpExplore_EventItem:ShowFinishImg(type, isShow)
    SetActive(self.ImgFinishN, false);
    SetActive(self.ImgFinishH, false);
    SetActive(self.ImgFinishR, false);
    if (type == "sp") then
        return
    end
    if (type == "fs") then
        SetActive(self.ImgFinishR, isShow);
    elseif (type == "gn" or type == "zn") then
        SetActive(self.ImgFinishH, isShow);
    else
        SetActive(self.ImgFinishN, isShow);
    end
end

function PackUpExplore_EventItem:Clear()
    self.data = nil;
end

function PackUpExplore_EventItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end