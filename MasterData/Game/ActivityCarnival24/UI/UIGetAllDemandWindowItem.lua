local base = UIBaseNode
local UIGetAllDemandWindowItem = class("UIGetAllDemandWindowItem", base)
local eDemandState = require("Game.Task.TaskEnum").eTaskState

function UIGetAllDemandWindowItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_KeyTog, self, self.OnClickKeyDemandToggle)
  UIUtil.AddButtonListener(self.ui.btn_CommonTog, self, self.OnClickCommonDemandToggle)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.OnClickCancel)
  UIUtil.AddButtonListener(self.ui.btn_Comfirm, self, self.OnClickComfirm)
  self.selectKeyDemandToggle = true
  self.selectCommonDemandToggle = true
  self:RefreshToggle()
end

function UIGetAllDemandWindowItem:InitGetAllDemandWindowItem(stageId, demandCfgList, carnival24Data)
  self.stageId = stageId
  self.demandCfgList = demandCfgList
  self.carnival24Data = carnival24Data
  self:Refresh()
end

function UIGetAllDemandWindowItem:Refresh()
  self:RefreshCompeletedDemandList()
  self:RefreshToggle()
  self:RefreshBtnComfirmState()
end

function UIGetAllDemandWindowItem:RefreshToggle()
  self.ui.obj_KeyTog:SetActive(self.selectKeyDemandToggle)
  self.ui.obj_CommonTog:SetActive(self.selectCommonDemandToggle)
end

function UIGetAllDemandWindowItem:RefreshBtnComfirmState()
  self.ui.img_Comfirm.color = #self.demandIds == 0 and Color.gray or self.ui.comfirmColor
end

function UIGetAllDemandWindowItem:OnClickKeyDemandToggle()
  self.selectKeyDemandToggle = not self.selectKeyDemandToggle
  self:Refresh()
end

function UIGetAllDemandWindowItem:OnClickCommonDemandToggle()
  self.selectCommonDemandToggle = not self.selectCommonDemandToggle
  self:Refresh()
end

function UIGetAllDemandWindowItem:OnClickCancel()
  self.gameObject:SetActive(false)
end

function UIGetAllDemandWindowItem:RefreshCompeletedDemandList()
  self.demandIds = {}
  self.compeletedDemandAvgIds = {}
  local consumCountList = {}
  for key, demandCfg in pairs(self.demandCfgList) do
    if not self.carnival24Data:IsMemoryFragMentDemandPicked(demandCfg.stage_id, demandCfg.demand_id) and (demandCfg.type_id ~= 1 or self.selectKeyDemandToggle) and (demandCfg.type_id ~= 2 or self.selectCommonDemandToggle) then
      for index, itemId in ipairs(demandCfg.consume_ids) do
        if consumCountList[itemId] == nil then
          consumCountList[itemId] = PlayerDataCenter:GetItemCount(itemId)
        end
        if consumCountList[itemId] < demandCfg.consume_nums[index] then
          goto lbl_69
        end
      end
      for index, itemId in ipairs(demandCfg.consume_ids) do
        consumCountList[itemId] = consumCountList[itemId] - demandCfg.consume_nums[index]
      end
      table.insert(self.demandIds, demandCfg.demand_id)
      table.insert(self.compeletedDemandAvgIds, demandCfg.avg_id)
    end
    ::lbl_69::
  end
end

function UIGetAllDemandWindowItem:OnClickComfirm()
  if #self.demandIds == 0 then
    return
  end
  local actFrameNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  local stageId = self.stageId
  local demandIds = self.demandIds
  local compeletedDemandAvgIds = self.compeletedDemandAvgIds
  actFrameNetCtrl:CS_ACTIVITY_Carnival24_Demand_Multi(stageId, demandIds, function(msg)
    NetworkManager:GetNetwork(NetworkTypeID.Avg):CS_AVG_Complete_Multi(compeletedDemandAvgIds, 0, function()
      if msg.rewards ~= nil then
        UIUtil.ShowCommonReward(msg.rewards, nil, function()
          local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
          if ctrl then
            ctrl:TryChangeLobby(self.carnival24Data:GetActId())
          end
        end)
      end
    end)
  end)
end

function UIGetAllDemandWindowItem:OnDelete()
  base.OnDelete(self)
end

return UIGetAllDemandWindowItem
