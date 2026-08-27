local UINAthSignDetail = class("UINAthSignDetail", UIBaseNode)
local base = UIBaseNode
local UINAthSignSubAttrItem = require("Game.Arithmetic.Sign.UINAthSignSubAttrItem")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local UINStOConsumeItem = require("Game.StrategyOverview.UI.Side.UINStOConsumeItem")
local CS_MessageCommon = CS.MessageCommon

function UINAthSignDetail:ctor(signRoot)
  self.signRoot = signRoot
end

function UINAthSignDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Link, self, self.__OnClickLink)
  self.__OnSubAttrLockFunc = BindCallback(self, self.__OnClickSubAttrLock)
  self.__onUpdateItemEvent = BindCallback(self, self._OnItemUpdateEvent)
  self.unitSize = self.ui.img_Cube.transform.sizeDelta
  self.ui.attriItem:SetActive(false)
  self.subAttrItemPool = UIItemPool.New(UINAthSignSubAttrItem, self.ui.attriItem)
  self._consumeItem = UINStOConsumeItem.New()
  self._consumeItem:Init(self.ui.consumeItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

function UINAthSignDetail:InitAthSignDetail(athData)
  self.athData = athData
  local qColor = athData:GetAthColor()
  self.ui.img_Cube.color = qColor
  self.ui.mainAttri.color = qColor
  local areaId = athData:GetAthAreaType()
  local areaCfg = ConfigData.ath_area[areaId]
  if areaCfg == nil then
    error("Can't get areaCfg, areaId = " .. areaId)
  else
    self.ui.tex_Area.text = LanguageUtil.GetLocaleText(areaCfg.name2)
  end
  self.ui.img_AreaIcon:SetIndex(areaId - 1)
  self.ui.tex_Name.text = athData:GetName()
  self:__RefreshSize()
  self:__RefreshMainAttr()
  self:RefreshSignDetailSubAttr()
  self:_UpdAthSignDetailConsumeItem()
  self:_UpdLinkBtnState()
end

function UINAthSignDetail:__RefreshSize()
  local size = self.athData:GetAthSize()
  local sizeDelta
  if size == 1 then
    sizeDelta = self.unitSize
  elseif size == 2 then
    sizeDelta = Vector2.New(self.unitSize.x, self.unitSize.y * 2)
  elseif size == 4 then
    sizeDelta = Vector2.New(self.unitSize.x * 2, self.unitSize.y * 2)
  end
  self.ui.img_Cube.transform.sizeDelta = sizeDelta
end

function UINAthSignDetail:__RefreshMainAttr()
  local athData = self.athData
  if #athData.athMainAttrCfg.attrtibute_id > 0 then
    local attrId = athData.athMainAttrCfg.attrtibute_id[1]
    local attrValue = athData.athMainAttrCfg.attrtibute_num[1]
    local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
    self.ui.img_Icon.sprite = CRH:GetSprite(icon)
    self.ui.tex_AttriName.text = name
    self.ui.tex_AttriNum.text = valueStr
  end
end

function UINAthSignDetail:RefreshSignDetailSubAttr()
  local athData = self.athData
  if #athData.affixList == 0 then
    self.ui.attriList:SetActive(false)
  else
    self.ui.attriList:SetActive(true)
    self.subAttrItemPool:HideAll()
    for k, affix in ipairs(athData.affixList) do
      local cfg = ConfigData.ath_affix_pool[affix.id]
      if cfg == nil then
        error("Can't find ath_affix_pool, id = " .. tostring(affix.id))
      else
        local color = ArthmeticEnum.AthQualityColor[affix.quality]
        local attrItem = self.subAttrItemPool:GetOne()
        attrItem:InitAthSignDetailAttr(k, cfg.affix_para, affix.value, color, affix.lock, self.__OnSubAttrLockFunc)
        if affix.lock then
          self._lockAttrIdx = k
        end
      end
    end
  end
end

function UINAthSignDetail:_UpdAthSignDetailConsumeItem()
  self._consumeItem:InitStOConsumeItem(ConfigData.game_config.athSignCostId, ConfigData.game_config.athSignCostNum)
end

function UINAthSignDetail:_OnItemUpdateEvent(itemUpdate)
  if itemUpdate[ConfigData.game_config.athSignCostId] == nil then
    return
  end
  self:_UpdAthSignDetailConsumeItem()
  self:_UpdLinkBtnState()
end

function UINAthSignDetail:_UpdLinkBtnState()
  local canLink = PlayerDataCenter:GetItemCount(ConfigData.game_config.athSignCostId) >= ConfigData.game_config.athSignCostNum and self._lockAttrIdx ~= nil
  self.ui.img_BtnLink.color = canLink and self.ui.color_BtnLink[1] or self.ui.color_BtnLink[2]
end

function UINAthSignDetail:__OnClickLink()
  local containNum = PlayerDataCenter:GetItemCount(ConfigData.game_config.athSignCostId)
  if containNum < ConfigData.game_config.athSignCostNum then
    return
  end
  if self._lockAttrIdx == nil then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(21001))
    return
  end
  self.signRoot:ReqAthSign(self._lockAttrIdx)
end

function UINAthSignDetail:__OnClickSubAttrLock(index)
  if self._lockAttrIdx == index then
    return
  end
  if self._lockAttrIdx ~= nil then
    local attrItem = self.subAttrItemPool.listItem[self._lockAttrIdx]
    attrItem:SetAthSignSubAttrLock(false)
  end
  self._lockAttrIdx = index
  local attrItem = self.subAttrItemPool.listItem[index]
  attrItem:SetAthSignSubAttrLock(true)
  self:_UpdLinkBtnState()
end

function UINAthSignDetail:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
  self.subAttrItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINAthSignDetail
