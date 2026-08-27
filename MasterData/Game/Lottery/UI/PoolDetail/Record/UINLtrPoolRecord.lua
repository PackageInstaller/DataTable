local UINLtrPoolRecord = class("UINLtrPoolRecord", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolRecordItem = require("Game.Lottery.UI.PoolDetail.Record.UINLtrPoolRecordItem")

function UINLtrPoolRecord:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemDic = {}
end

function UINLtrPoolRecord:InitLtrPoolRecord(ltrPoolData)
  self.ltrRecords = PlayerDataCenter.allLtrData.ltrRecords
  local poolCfg = ltrPoolData:GetLtrPoolDataCfg()
  local num = PlayerDataCenter.allLtrData.ltrSpecial[poolCfg.guaranteeType] or 0
  local total = poolCfg.guaranteeNums
  self.ui.tex_GachaCount.text = tostring(num) .. "/" .. tostring(total)
  self.ui.tex_title.text = ConfigData:GetTipContent(316)
  self.ui.list_record.onInstantiateItem = BindCallback(self, self._OnInstantiateItem)
  self.ui.list_record.onChangeItem = BindCallback(self, self._OnChangeItem)
  local hasData = #self.ltrRecords > 0
  if hasData then
    self.ui.list_record.totalCount = #self.ltrRecords
    self.ui.list_record:RefillCells()
  end
  self.ui.obj_listNode:SetActive(hasData)
  self.ui.obj_empty:SetActive(not hasData)
end

function UINLtrPoolRecord:_OnInstantiateItem(go)
  local item = UINLtrPoolRecordItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UINLtrPoolRecord:_OnChangeItem(go, index)
  local item = self.itemDic[go]
  local records = self.ltrRecords[index + 1]
  item:InitLtrPoolRecordItem(records)
end

function UINLtrPoolRecord:OnDelete()
  base.OnDelete(self)
end

return UINLtrPoolRecord
