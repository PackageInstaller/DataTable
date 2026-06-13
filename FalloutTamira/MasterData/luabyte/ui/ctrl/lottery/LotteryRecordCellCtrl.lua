local LotteryRecordCellCtrl = BaseClass("LotteryRecordCellCtrl")
local M = LotteryRecordCellCtrl

function M:__init(view)
    self._view = view
end

function M:SetData(data)
    self._view.time:SetText(tostring(data.time))
    self._view.New:SetActive(data.spTag)
    local poolcfg = ConfigHelper.GetCfg("luckDraw",data.poolId)
    if poolcfg ~= nil then
        self._view.poolName:SetText(poolcfg.name)
    end
    local itemcfg = ConfigHelper.GetCfg("item",data.items)
    if itemcfg ~= nil then
        local namestr = ConfigHelper.GetLocalString(itemcfg.name)
        self._view.State:SetState(itemcfg.quality)
        self._view.item:SetText(namestr)
        -- if itemcfg.quality >=4 then
        --      self._view.item:SetText("<COLOR=#F1C241>"..namestr.."</COLOR>")
        -- else
        --     self._view.item:SetText("<COLOR=#FFFFFF>"..namestr.."</COLOR>")
        -- end
    end
end

function M:SetActive(b)
    self._view:SetActive(b)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return LotteryRecordCellCtrl