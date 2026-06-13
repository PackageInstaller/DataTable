local RankTipItemCtrl = BaseClass("RankTipItemCtrl")
local M = RankTipItemCtrl

function M:__init(view)
    self._view = view
    self._view.gameObject:SetActive(true)
    
end

function M:_SetRankItemInfo(rankRewardCfg)
    self._view.title:SetText(rankRewardCfg.languageId)
    local groupCfg  = ConfigHelper.GetCfgByLua("itemGroup",rankRewardCfg.reward)
    if groupCfg then
        local itemCfg = ConfigHelper.GetCfgByLua("item",groupCfg.items[0])
        self._view.icon:SetPic(itemCfg.icon)
        local str  =  "X"..groupCfg.cnts[0]
        self._view.num:SetText(str)
    end
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return RankTipItemCtrl