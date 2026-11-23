















KingDeerZoneItem = {}
KingDeerZoneItem.__index = KingDeerZoneItem

local objs = {
    areaBtn = {path = "", type = UITool.Button},
    getBtn = {path = "Group/ProgressBG/GetBtn", type = UITool.Button},
    progressTxt = {path = "Group/ProgressBG/ProgressTxt", type = UITool.Text},
    lockObj = {path = "Group/Lock", type = UITool.GameObject},
    progressObj = {path = "Group/ProgressBG", type = UITool.GameObject},
    gotObj = {path = "Group/ProgressBG/GetBtn/GotObj", type = UITool.GameObject}
}
function KingDeerZoneItem.New(obj, index)

    local self = {}
    setmetatable(self, KingDeerZoneItem)
    self.gameObject = obj
    self.index = index
    UITool.Parse(self.gameObject, self, objs)
    local clickArea = function()
        if self.data  == nil  then
            return
        end
        if self.data.isUnLock == false then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.data.unlockTips)
            return
        end
        LuaMgr.ShowLuaPanel(UIName.KingDeerPassPopup, self.index)
    end
    local clickGetReward = function()
        self:OnGetReward()
    end
    LuaMgr.AddClick(self.areaBtn, clickArea)
    LuaMgr.AddClick(self.getBtn, clickGetReward)
    return self
end

function KingDeerZoneItem:OnGetReward()
    local callback = function()
        self:RefreshItem()
    end
    local config = self.data.progressConfig
    DataExHelper.EX_GetAward(config.id, callback)
end

function KingDeerZoneItem:RefreshItem()
    self.data = KingDeerData.GetZoneData(self.index)
    SetActive(self.progressObj, self.data.isUnLock == true)
    SetActive(self.lockObj, self.data.isUnLock == false)
    SetActive(self.gotObj, self.data.status == KingDeerData.GetRewardStatus.Got)
    SetActive(self.getBtn.gameObject, false)
    RedMgr.Singleton:UpdateClientRedData("15074_"..self.index, self.data.status == KingDeerData.GetRewardStatus.CanGet and 1 or 0)
    local progressTxt = string.format("%d%%", self.data.progressNum)
    local txt = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7314"), progressTxt)
    self.progressTxt.text = txt
end