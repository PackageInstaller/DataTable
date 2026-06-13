-- baoruichang
-- 2022/11/15 18:00:01
-- 预制体 Masquerade_Gift
local UIMasqueradeGiftCtrl = BaseClass("UIMasqueradeGiftCtrl", BaseUICtrl)
local M = UIMasqueradeGiftCtrl
local tInsert = table.insert
local ItemType = BagConst.ItemType
local UIGiftItemCtrl = require("UI.Ctrl.UIMasquerade.UIGiftItemCtrl")
local UIGiftItemView = require("UI.View.UIMasquerade.UIGiftItemView")
local sGsub = string.gsub
local MASQUERADEGIFT = "MASQUERADEGIFT"

function M:Init()
    self._view.btnBack:onClick(Bind(self, self.Close))
    self.grid = self._view.grid
    self.grid:Init(UIGiftItemCtrl, UIGiftItemView)
    self._tempOnClickItem = EventMgr:AddListener(UIMessageNames.DANCE_CLICKGIFT, Bind(self, self._OnClickItem))
end

-- 进入UI，可传参数
function M:OnEnter(activityId)
    self.ids = {}
    -- 18剧情类道具
    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=activityId})
    if #activityCopys <= 0 then
        Logger.LogError("配置错误")
        return
    end
    local itemSubType = activityCopys[1].itemSubType
    local gifts = ConfigHelper.GetCfgsByLua("item", {type=ItemType.EIT_Show, subType=itemSubType})
    ItemDataMgr:GetInstance():GetAllItemDatas({ItemType.EIT_Show})
    for _, item in ipairs(gifts) do
        tInsert(self.ids, item.id)
    end
    self.grid:SetDataList(self.ids)
    EventMgr:Broadcast(UIMessageNames.DANCE_CLICKGIFT, self.ids[1])
end

function M:_OnClickItem(id)
    local itemConf = ConfigHelper.GetCfg("item", id)
    self._view.labName:SetText(itemConf.name)
    self._view.imgIcon:SetItemIcon(id)
    local desc
    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(id)
    if itemNum > 0 then
        desc = ConfigHelper.GetLocalString(itemConf.desc)
        desc = sGsub(desc, "<playerName>", IPlayerData.NickName)
        PlayerPrefTools.SetPlayerPrefs(MASQUERADEGIFT .. id, 1)
        RedPointMgr:ForceCheck(RedPointConst.MasqueradeGiftRedPointChecker)
    else
        desc = "???\n" .. ConfigHelper.GetLocalString(itemConf.wayValue1)
    end
    self._view.labDes:SetText(desc)
    self._view.tfContent.anchoredPosition = Vector2(0, 0)
end

function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.DANCE_CLICKGIFT, self._tempOnClickItem)
    M.super.OnDispose(self)
end

return UIMasqueradeGiftCtrl
