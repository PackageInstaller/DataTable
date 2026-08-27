local base = UIBaseNode
local UINComRankPage = class("UINComRankPage", base)
local UINComRankPageItem = require("Game.CommonUI.Rank.Page.UINComRankPageItem")
local eCommonRank = require("Game.CommonUI.Rank.eCommonRank")
local eComRankPage = eCommonRank.eComRankPage

function UINComRankPage:OnInit(comRankRoot)
  self._comRankRoot = comRankRoot
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._pageItemPool = UIItemPool.New(UINComRankPageItem, self.ui.obj_Page, false)
end

function UINComRankPage:InitComRankPage(rankCfg, selectPageFunc)
  self._rankCfg = rankCfg
  self._selectPageFunc = selectPageFunc
  self:AddComRankPage(eComRankPage.RankList)
  self:_UpdSettleTimer()
end

function UINComRankPage:ComRankPageSelectFirst()
  self.ui.togGroup:SetAllTogglesOff()
  local item = self._pageItemPool.listItem[1]
  item:SetComRankPageItemIsOn()
end

function UINComRankPage:AddComRankPage(comRankPageType)
  self._OnClickPageItemFunc = self._OnClickPageItemFunc or BindCallback(self, self._OnClickPageItem)
  local pageItem = self._pageItemPool:GetOne()
  pageItem:InitComRankPageItem(comRankPageType, self._OnClickPageItemFunc)
end

function UINComRankPage:_OnClickPageItem(comRankPageType)
  if self._selectPageFunc then
    self._selectPageFunc(comRankPageType)
  end
end

function UINComRankPage:_UpdSettleTimer()
  if self._rankCfg.settle_time <= 0 then
    self:_StopSettleTimer()
    return
  end
  local remainTs = self._rankCfg.settle_time - PlayerDataCenter.timestamp
  if remainTs < 0 then
    self:_StopSettleTimer()
    return
  end
  if self._settleTimerId == nil then
    self.ui.timer:SetActive(true)
    self._settleTimerId = TimerManager:StartTimer(1, self._UpdSettleTimer, self, false)
  end
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remainTs, false, true)
  local hStr = 10 <= h and tostring(h) or "0" .. tostring(h)
  local mStr = 10 <= m and tostring(m) or "0" .. tostring(m)
  local sStr = 10 <= s and tostring(s) or "0" .. tostring(s)
  if 0 < d then
    self.ui.tex_Timer:SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    self.ui.tex_Timer:SetIndex(1, hStr, mStr, sStr)
  end
end

function UINComRankPage:_StopSettleTimer()
  self.ui.timer:SetActive(false)
  TimerManager:StopTimer(self._settleTimerId)
end

function UINComRankPage:OnDelete()
  self:_StopSettleTimer()
  self._pageItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINComRankPage
