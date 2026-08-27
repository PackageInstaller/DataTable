local UIActSum22StrategySelect = class("UIActSum22StrategySelect", UIBaseWindow)
local base = UIBaseWindow
local UINActSum22StrategySelectItem = require("Game.ActivitySummer.Year22.Tech.Select.UINActSum22StrategySelectItem")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon

function UIActSum22StrategySelect:OnInit()
  self._resloder = cs_ResLoader.Create()
  UIUtil.SetTopStatus(self, self.OnClickCloseSlect)
  UIUtil.SetTopStatusBtnShow(false, false)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self._OnClickReresh)
  self._selectItemPool = UIItemPool.New(UINActSum22StrategySelectItem, self.ui.selectItem, false)
  self._OnClickSelectTechFunc = BindCallback(self, self._OnClickSelectTech)
  self.__RefreshFunc = BindCallback(self, self.__Refresh)
  MsgCenter:AddListener(eMsgEventId.ActivitySectorIIIDayTimeout, self.__RefreshFunc)
end

function UIActSum22StrategySelect:InitTechSelect(sum22Data, closeFunc)
  self._sum22Data = sum22Data
  self._closeFunc = closeFunc
  local actCfg = sum22Data:GetSectorIIIMainCfg()
  self._actCfg = actCfg
  self._refreshCostId = actCfg.refresh_item
  local sprite = CRH:GetSpriteByItemId(actCfg.refresh_item, true)
  self.ui.img_Coin.sprite = sprite
  self:__Refresh()
  UIUtil.RefreshTopResId({
    actCfg.tech_item,
    actCfg.refresh_item
  })
  self._actSumCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII)
  if self._actSumCtrl == nil then
    error("actSumCtrl == nil")
  end
  self:_UpdSelectList()
  sum22Data:SetActSum22TechSelectEntered()
end

function UIActSum22StrategySelect:_UpdSelectList(isRefresh, selectedTechItem)
  local selectIdList = self._sum22Data:GetActSum22TechSelectIdList()
  local techDataDic = self._sum22Data:GetSectorIIITechDic()
  for k, techId in ipairs(selectIdList) do
    local techData = techDataDic[techId]
    if techData == nil then
      error("techData == nil,id:%s", techId)
    else
      local selectItem = self._selectItemPool.listItem[k] or self._selectItemPool:GetOne()
      if isRefresh then
        selectItem:PlayRefreshAnimActSum22TechSelectItem(k, techData, self._resloder, self._OnClickSelectTechFunc)
      elseif selectedTechItem ~= nil then
        local isCurItem = selectItem == selectedTechItem
        selectItem:PlaySelectAnimActSum22TechSelectItem(k, techData, self._resloder, self._OnClickSelectTechFunc, isCurItem)
      else
        selectItem:InitTechSelectItem(k, techData, self._resloder, self._OnClickSelectTechFunc)
      end
    end
  end
  if #selectIdList < #self._selectItemPool.listItem then
    for i = #selectIdList + 1, #self._selectItemPool.listItem do
      self._selectItemPool:HideOne(self._selectItemPool.listItem[i])
    end
  end
end

function UIActSum22StrategySelect:_OnClickReresh()
  if self._remainRefreshNum <= 0 then
    return
  end
  if self._curRefreshCostNum > PlayerDataCenter:GetItemCount(self._refreshCostId) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(8602))
    return
  end
  self._actSumCtrl:ReqSum22RefreshTechSelect(self._sum22Data:GetActFrameId(), function()
    self:_UpdSelectList(true)
    self:__Refresh()
  end)
end

function UIActSum22StrategySelect:_OnClickSelectTech(techData, techItem)
  if not techData:IsLeveUpResEnough() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(8601))
    return
  end
  self._newTechIdDic = self._newTechIdDic or {}
  self._lvUpTechIdDic = self._lvUpTechIdDic or {}
  local isNew = techData:GetCurLevel() == 0
  self._actSumCtrl:ReqSum22TechSelect(techData, function()
    local techId = techData:GetTechId()
    if isNew then
      self._newTechIdDic[techId] = true
    elseif self._newTechIdDic[techId] == nil then
      self._lvUpTechIdDic[techId] = true
    end
    self:_UpdSelectList(nil, techItem)
  end)
end

function UIActSum22StrategySelect:__Refresh()
  local maxNum = #self._actCfg.refresh_price
  local curNum = self._sum22Data:GetActSum22TechRefreshNum()
  local remainNum = math.max(maxNum - curNum, 0)
  self._remainRefreshNum = remainNum
  self.ui.tex_Refresh:SetIndex(0, tostring(remainNum), tostring(maxNum))
  local costNum = self._actCfg.refresh_price[math.min(curNum + 1, maxNum)]
  self.ui.tex_Cost.text = tostring(costNum)
  self._curRefreshCostNum = costNum
  self.ui.btn_Refresh.interactable = 0 < remainNum
  self.ui.ban_Btn_Refresh.enabled = remainNum <= 0
end

function UIActSum22StrategySelect:OnClickCloseSlect()
  UIUtil.SetTopStatusBtnShow(true, true)
  self:Delete()
  if self._closeFunc ~= nil then
    self._closeFunc(self._newTechIdDic or table.emptytable, self._lvUpTechIdDic or table.emptytable)
  end
end

function UIActSum22StrategySelect:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.ActivitySectorIIIDayTimeout, self.__RefreshFunc)
  self._selectItemPool:DeleteAll()
  if self._resloder ~= nil then
    self._resloder:Put2Pool()
    self._resloder = nil
  end
  base.OnDelete(self)
end

return UIActSum22StrategySelect
