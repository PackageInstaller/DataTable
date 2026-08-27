local UINGameSetTypeItem = class("UINGameSetTypeItem", UIBaseNode)
local base = UIBaseNode
local UIMultiSwitchTogItem = require("Game.Setting.UI.UIMultiSwitchTogItem")

function UINGameSetTypeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.item:SetActive(false)
end

function UINGameSetTypeItem:InitGameSetTypeItem(setCtrl, groupCfg)
  self.setCtrl = setCtrl
  self.ui.tex_title.text = LanguageUtil.GetLocaleText(groupCfg.group_name)
  local systemSaveData = self.setCtrl:GetSystemSaveData()
  for _, id in ipairs(groupCfg.order) do
    if id == eGameSetDescType.ultSkill_auto then
      local isOpenAutoUlt = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_battle_auto_ult)
      if not isOpenAutoUlt then
        goto lbl_138
      end
    end
    local cfg = ConfigData.game_set_describe[id]
    if cfg == nil then
      error("can't get setting describe cfg with id:" .. tostring(id))
      return
    end
    local strList = cfg.option_group_name
    local curValue, bindEvent
    if id == eGameSetDescType.chip or id == eGameSetDescType.skill then
      curValue = BindCallback(PlayerDataCenter.gameSettingData, PlayerDataCenter.gameSettingData.GetGSIsShowDetailDescribeValue, id)
      bindEvent = BindCallback(self, self.OnToogleCallback, id)
    else
      curValue = BindCallback(systemSaveData, systemSaveData.GetMultSettingIndex, id)
      bindEvent = BindCallback(self, self.OnToogleCallback, id)
    end
    local item = UIBaseNode.New()
    item:Init(self.ui.item:Instantiate(self.transform))
    UIUtil.LuaUIBindingTable(item.transform, item.ui)
    item.ui.tex_Name.text = LanguageUtil.GetLocaleText(cfg.setting_name)
    item.gameObject:SetActive(true)
    item.gameObject.name = "option_" .. tostring(id)
    local itemGo = self.ui.tog_DisplayGroup:Instantiate(item.transform)
    itemGo:SetActive(true)
    local multiSwitchTogItem = UIMultiSwitchTogItem.New()
    multiSwitchTogItem:Init(itemGo)
    multiSwitchTogItem:InitUIMultiSwitchTogItem(curValue, strList, false, bindEvent, self)
    multiSwitchTogItem.gameObject.name = "togGroup_" .. tostring(id)
    ::lbl_138::
  end
end

function UINGameSetTypeItem:OnToogleCallback(id, value, togItem)
  if id == eGameSetDescType.chip or id == eGameSetDescType.skill then
    local isDetail = false
    if togItem.index == 0 and value then
      isDetail = false
    end
    if togItem.index == 1 and value then
      isDetail = true
    end
    self.setCtrl:SetShowDetailDescribe(id, isDetail)
  elseif value then
    self.setCtrl:SetGSMultSettingIndex(id, togItem.index)
  end
end

function UINGameSetTypeItem:OnDelete()
  base.OnDelete(self)
end

return UINGameSetTypeItem
