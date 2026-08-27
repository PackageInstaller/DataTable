local UINEpCommonModeSelectDiffItem = class("UINEpCommonModeSelectDiffItem", UIBaseNode)
local base = UIBaseNode

function UINEpCommonModeSelectDiffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Drop, self, self.__OnClickShowDrop)
end

function UINEpCommonModeSelectDiffItem:InitModelDiffItem(diffCfg, index, callback, mainCfg)
  self._mainCfg = mainCfg
  self._diffCfg = diffCfg
  self._index = index
  self._callback = callback
  self.ui.tex_ModeENName.text = diffCfg.difficulty_name_en
  self.ui.tex_ModeCNName.text = LanguageUtil.GetLocaleText(diffCfg.difficulty_name)
  local totalDes
  for index, catalog_id in ipairs(diffCfg.catalog) do
    local desCfg = ConfigData.act_general_ep_difficulty_catalog[catalog_id]
    local des = LanguageUtil.GetLocaleText(desCfg.catalog_des)
    if string.IsNullOrEmpty(totalDes) then
      totalDes = des
    else
      totalDes = totalDes .. "\n" .. des
    end
  end
  self.ui.tex_EPoints.text = totalDes
  if diffCfg.infinite_coe > 0 then
    self.ui.tex_InfinityAdditon:SetIndex(0, tostring(diffCfg.infinite_coe))
    self.ui.tex_InfinityAdditon.transform.parent.gameObject:SetActive(true)
  else
    self.ui.tex_InfinityAdditon.transform.parent.gameObject:SetActive(false)
  end
  self:SetModelColor(index)
  self:UpdIsHaveDropEpCmDiffItem()
end

function UINEpCommonModeSelectDiffItem:SetModelDiffItemUnLocke(isUnlock, unlockDes)
  self.isUnlock = isUnlock
  if not IsNull(self.ui.obj_Locked) then
    self.ui.obj_Locked:SetActive(not isUnlock)
    if not isUnlock then
      self.ui.tex_unlock.text = unlockDes
    end
  end
end

function UINEpCommonModeSelectDiffItem:SetModelColor(index)
  if self._diffCfg.use_image then
    self.ui.Img_NigtmareBg:SetActive(true)
    return
  else
    self.ui.Img_NigtmareBg:SetActive(false)
  end
  local color = self.ui.color_state[index]
  if color == nil then
    color = self.ui.color_state[#self.ui.color_state]
  end
  self.ui.img_ModeBg.color = color
end

function UINEpCommonModeSelectDiffItem:UpdIsHaveDropEpCmDiffItem()
  local isHaveDrop = false
  if self._diffCfg.card_drop ~= nil and #self._diffCfg.card_drop > 0 then
    self.dropMonCardDataList = {}
    isHaveDrop = true
    local actFrameId = self._mainCfg.activity_id
    for itemId, itemNum in pairs(self._diffCfg.p_card_drop_reward) do
      local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
      local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
      local actBaseData = actFrameData:GetActivityData()
      local monCardPlayData = actBaseData:GetMonsterCardData()
      local isGetted = monCardPlayData:ActMCPD_IsHaveCard(itemId)
      local itemCfg = ConfigData.item[itemId]
      if itemCfg == nil then
        error(string.format("monster card item not exist, itemId:%s", tostring(itemId)))
      else
        table.insert(self.dropMonCardDataList, {
          itemCfg = ConfigData.item[itemId],
          isGetted = isGetted
        })
      end
    end
  end
  self.ui.btn_Drop.gameObject:SetActive(isHaveDrop)
end

function UINEpCommonModeSelectDiffItem:OnClickConfirm()
  if self._callback ~= nil then
    self._callback(self)
  end
end

function UINEpCommonModeSelectDiffItem:__OnClickShowDrop()
  if self.dropMonCardDataList ~= nil and #self.dropMonCardDataList > 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonMonsterCardDrop, function(window)
      if window == nil then
        return
      end
      local actFrameId = self._mainCfg.activity_id
      window:InitActCommonMonsterCardDrop(actFrameId, self.dropMonCardDataList)
    end)
  end
end

function UINEpCommonModeSelectDiffItem:GetModeItemDiffInfoCfg()
  return self._diffCfg, self._index
end

return UINEpCommonModeSelectDiffItem
