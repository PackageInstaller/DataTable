














KingDeerPictureBookBtnItem = {}
KingDeerPictureBookBtnItem.__index = KingDeerPictureBookBtnItem

local objs = {
    clickBtn = {path = "", type = UITool.Button},
    canActiveBG = {path = "Group/CanActive", type = UITool.GameObject},
    canActiveFlagObj = {path = "Group/CanActiveFlag", type = UITool.GameObject},
    activatedObj = {path = "Group/Activated", type = UITool.GameObject},
    lockObj = {path = "Group/Lock", type = UITool.GameObject}
}




function KingDeerPictureBookBtnItem.New(obj, index, clickCallback)

    local self = {}
    setmetatable(self, KingDeerPictureBookBtnItem)
    self.gameObject = obj
    UITool.Parse(self.gameObject, self, objs)
    self.clickCallback = clickCallback
    self.index = index
    local onClick = function()
        local tempData = self.data
        if tempData.status == KingDeerData.PictureBookStatus.Lock then
            local tipsContent = LuaMgr.GetLangText(tempData.config.remarksLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        elseif tempData.status == KingDeerData.PictureBookStatus.Actived then
            local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7321")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        self.clickCallback(self.index)
    end
    LuaMgr.AddClick(self.clickBtn, onClick)
    return self
end

function KingDeerPictureBookBtnItem:SetData(data)
    if data ~= nil then
        self.data = data
    end
    self:SetItem()
end

function KingDeerPictureBookBtnItem:SetItem()
    SetActive(self.canActiveBG, self.data.status == KingDeerData.PictureBookStatus.CanActive)
    SetActive(self.canActiveFlagObj, self.data.status == KingDeerData.PictureBookStatus.CanActive)
    SetActive(self.activatedObj, self.data.status == KingDeerData.PictureBookStatus.Actived)
    SetActive(self.lockObj, self.data.status == KingDeerData.PictureBookStatus.Lock)
end