local UINAthRefactorDetail = class("UINAthRefactorDetail", UIBaseNode)
local base = UIBaseNode
local UINAthRfctSubAttrItem = require("Game.Arithmetic.Refactor.UINAthRfctSubAttrItem")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local UINStOConsumeItem = require("Game.StrategyOverview.UI.Side.UINStOConsumeItem")
local UINAthUsingRate = require("Game.Arithmetic.UsingRate.UINAthUsingRate")
local cs_MessageCommon = CS.MessageCommon

function UINAthRefactorDetail:ctor(refactorRoot)
  self.refactorRoot = refactorRoot
end

function UINAthRefactorDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Refactor, self, self.__OnClickRefactor)
  self.__OnSubAttrLockFunc = BindCallback(self, self.__OnClickSubAttrLock)
  self.__onUpdateItemEvent = BindCallback(self, self.OnItemUpdateEvent)
  self.unitSize = self.ui.img_Cube.transform.sizeDelta
  self.ui.attriItem:SetActive(false)
  self.subAttrItemPool = UIItemPool.New(UINAthRfctSubAttrItem, self.ui.attriItem)
  self.ui.consumeItem:SetActive(false)
  self.consumeItemPool = UIItemPool.New(UINStOConsumeItem, self.ui.consumeItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

function UINAthRefactorDetail:InitAthRefactorDetail(athData)
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
  local isSignHero = self.athData:GetAthSignHeroId() > 0
  self.ui.tex_Tips:SetIndex(isSignHero and 1 or 0)
  self:__RefreshSize()
  self:__RefreshMainAttr()
  self:RefreshRfctDetailSubAttr()
  self:UpdAthRfctDetailConsumeItem(0)
  self:RefreshCanRefactorBtn(0)
  self:_UpdAthRfctDetailUsingRate()
  self.ui.signTips.gameObject:SetActive(athData:CanSignAth())
end

function UINAthRefactorDetail:_UpdAthRfctDetailUsingRate()
  if self.athData.bindInfo == nil then
    self.ui.athUsingRate:SetActive(false)
    return
  end
  self._showUsingRate = true
  if self.athUsingRateNode == nil then
    local athUsingRate = UINAthUsingRate.New()
    athUsingRate:Init(self.ui.athUsingRate)
    athUsingRate:InitAthUsingRate(BindCallback(self, self._ShowUsingRateWin))
    self.athUsingRateNode = athUsingRate
  end
  self.athUsingRateNode:Show()
end

function UINAthRefactorDetail:_ShowUsingRateWin()
  local heroData = PlayerDataCenter.heroDic[self.athData.bindInfo.id]
  local areaId = self.athData.bindInfo.idx
  self.athUsingRateNode:ShowAthUsingRateDetail(heroData, areaId)
end

function UINAthRefactorDetail:__RefreshSize()
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

function UINAthRefactorDetail:__RefreshMainAttr()
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

function UINAthRefactorDetail:RefreshRfctDetailSubAttr()
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
        local showLock = 0 < athData:GetAthSignHeroId()
        local attrItem = self.subAttrItemPool:GetOne()
        attrItem:InitAthRfctDetailAttr(k, cfg.affix_para, affix.value, color, showLock, affix.lock, self.__OnSubAttrLockFunc)
        if affix.lock then
          self._lockAttrIdx = k
        end
      end
    end
  end
end

function UINAthRefactorDetail:UpdAthRfctDetailConsumeItem(num)
  self.consumeItemPool:HideAll()
  for k, itemId in ipairs(ConfigData.game_config.athRefactorConsumeItemId) do
    local consumeNum = ConfigData.game_config.athRefactorConsumeItemNum[k] * num
    local consumeItem = self.consumeItemPool:GetOne()
    consumeItem:InitStOConsumeItem(itemId, consumeNum)
  end
end

function UINAthRefactorDetail:OnItemUpdateEvent(itemUpdate)
  for k, itemId in ipairs(ConfigData.game_config.athRefactorConsumeItemId) do
    if itemUpdate[itemId] ~= nil then
      local consumeNum = ConfigData.game_config.athRefactorConsumeItemNum[k]
      local consumeItem = self.consumeItemPool.listItem[k]
      consumeItem:InitStOConsumeItem(itemId, consumeNum)
      self:RefreshCanRefactorBtn(self._costNum)
    end
  end
end

function UINAthRefactorDetail:__OnClickRefactor()
  self.refactorRoot:SendAthRefactor()
end

function UINAthRefactorDetail:__OnClickSubAttrLock(index)
  if self._lockAttrIdx == index then
    return
  end
  local costNum = ConfigData.game_config.athSignChangeAtrCostNum
  if costNum > PlayerDataCenter:GetItemCount(ConfigData.game_config.athSignChangeAtrCostId) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(21006))
    return
  end
  UIManager:ShowWindow(UIWindowTypeID.MessageCommon):ShowTextBoxWithYesAndNo(string.format(ConfigData:GetTipContent(21005), costNum), function()
    self.refactorRoot:SendAthAffixLock(index)
  end, nil)
end

function UINAthRefactorDetail:RefreshAthAffixLock(index)
  if self._lockAttrIdx ~= nil then
    local attrItem = self.subAttrItemPool.listItem[self._lockAttrIdx]
    attrItem:SetAthRfctSubAttrLock(false)
  end
  self._lockAttrIdx = index
  local attrItem = self.subAttrItemPool.listItem[index]
  attrItem:SetAthRfctSubAttrLock(true)
end

function UINAthRefactorDetail:RefreshCanRefactorBtn(costNum)
  self._costNum = costNum
  if costNum <= 0 then
    self.ui.tex_BtnRfct:SetIndex(0)
  elseif costNum == 1 then
    self.ui.tex_BtnRfct:SetIndex(1)
  else
    self.ui.tex_BtnRfct:SetIndex(2)
  end
  self.ui.btn_Refactor.interactable = self.refactorRoot:CanAthRefactor()
end

function UINAthRefactorDetail:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
  self.subAttrItemPool:DeleteAll()
  self.consumeItemPool:DeleteAll()
  if self.athUsingRateNode then
    self.athUsingRateNode:Delete()
  end
  base.OnDelete(self)
end

return UINAthRefactorDetail
