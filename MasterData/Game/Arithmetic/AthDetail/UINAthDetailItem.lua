local UINAthDetailItem = class("UINAthDetailItem", UIBaseNode)
local base = UIBaseNode
local UINAthDetailAttr = require("Game.Arithmetic.AthDetail.UINAthDetailAttr")
local UINAthDetailSuitItem = require("Game.Arithmetic.AthDetail.UINAthDetailSuitItem")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local UINAttrIntroItem = require("Game.Formation.UI.Common.UINHeroAttrIntroItem")
local cs_MessageCommon = CS.MessageCommon

function UINAthDetailItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Lock, self, self.__OnClickLock)
  UIUtil.AddButtonListener(self.ui.btn_Optimize, self, self.__OnClickOptimize)
  UIUtil.AddButtonListener(self.ui.btn_Uninstall, self, self.__OnClickUninstall)
  UIUtil.AddButtonListener(self.ui.btn_Equip, self, self.__OnClickInstall)
  UIUtil.AddButtonListener(self.ui.btn_Switch, self, self.__OnClickReplace)
  UIUtil.AddButtonListener(self.ui.btn_Link, self, self.__OnClickSignHero)
  self.ui.attrPopDetail:SetActive(false)
  self.ui.attriItem:SetActive(false)
  self.attriItemPool = UIItemPool.New(UINAthDetailAttr, self.ui.attriItem)
  self.ui.suitInfoItem:SetActive(false)
  self.suitAttriPool = UIItemPool.New(UINAthDetailSuitItem, self.ui.suitInfoItem)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  self.unitSize = self.ui.img_Cube.transform.sizeDelta
  self._resloader = CS.ResLoader.Create()
end

function UINAthDetailItem:SetAthDetailItemBrief(isBrief)
  self._isBrief = isBrief
  self.ui.suitScroll:SetActive(not isBrief)
  self.ui.btnGroup:SetActive(not isBrief)
  return self
end

function UINAthDetailItem:SetAthDetailItemLockBtnShow(show)
  self.ui.btn_Lock.gameObject:SetActive(show)
end

function UINAthDetailItem:InitAthDetailItem(detailRoot, athData, heroData, isAddPreview, isReplace, isOnlyInfo)
  self.detailRoot = detailRoot
  self.athData = athData
  self.heroData = heroData
  self._isOnlyInfo = isOnlyInfo
  self.ui.btn_Uninstall.gameObject:SetActive(false)
  self.ui.btn_Equip.gameObject:SetActive(false)
  self.ui.btn_Switch.gameObject:SetActive(false)
  self.ui.curEquip:SetActive(false)
  self.ui.btn_Optimize.gameObject:SetActive(false)
  self.ui.btn_Link.gameObject:SetActive(false)
  if not isOnlyInfo then
    if isReplace then
      if isAddPreview then
        self.ui.btn_Switch.gameObject:SetActive(true)
      else
        self.ui.curEquip:SetActive(true)
      end
    elseif isAddPreview then
      self.ui.btn_Equip.gameObject:SetActive(true)
    else
      self.ui.btn_Uninstall.gameObject:SetActive(true)
    end
    local canStrenthen = ArthmeticEnum.StrengthenQuality == athData:GetAthQuality() and athData:GetAthSize() > 1
    self.ui.btn_Optimize.gameObject:SetActive(canStrenthen)
  end
  local qColor = athData:GetAthColor()
  self.ui.img_Quailty.color = qColor
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
  self:__RefreshLock()
  self.ui.tex_Name.text = athData:GetName()
  self:__RefreshSize()
  self:RefreshAthDetailItemAttr()
  self:_UpdSuit()
  if self.ui.optimizeLock ~= nil then
    self.ui.optimizeLock:SetActive(not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro))
  end
  self:UpdAthDetailItemState()
end

function UINAthDetailItem:_UpdHeroSign()
  if IsNull(self.ui.obj_Link) then
    return
  end
  local signHeroId = self.athData:GetAthSignHeroId()
  self.ui.obj_Link:SetActive(signHeroId ~= 0)
  if signHeroId ~= 0 then
    self.ui.imgSignHeroPic.enabled = false
    local heroData = PlayerDataCenter.heroDic[signHeroId]
    self._resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroData:GetResPicName()), function(texture)
      if IsNull(self.transform) or IsNull(texture) then
        return
      end
      self.ui.imgSignHeroPic.texture = texture
      self.ui.imgSignHeroPic.enabled = true
    end)
  end
end

function UINAthDetailItem:_UpdSuit()
  if self._isBrief then
    return
  end
  local athData = self.athData
  local suitId = athData:GetAthSuit()
  self.ui.suitScroll:SetActive(suitId ~= 0)
  local suitCfltDic = ConfigData.arithmetic.suitDic[athData.suit]
  if suitCfltDic ~= nil then
    local suitAthCount = 0
    for k, suitAthList in pairs(suitCfltDic) do
      for k2, athId in ipairs(suitAthList) do
        local athCfg = ConfigData.arithmetic[athId]
        local itemCfg = ConfigData.item[athId]
        if itemCfg == nil then
          error("Can't find itemCfg, id = " .. tostring(athId))
          break
        end
        local slotId = athCfg.area_type
        local installed = false
        if self.heroData ~= nil then
          installed = PlayerDataCenter.allAthData:HeroContainAthById(self.heroData.dataId, slotId, athId)
        end
        if installed then
          suitAthCount = suitAthCount + 1
        end
      end
    end
    local suitCfg = ConfigData.ath_suit[suitId]
    if suitCfg == nil then
      error("Can't find suitCfg, id = " .. tostring(suitId))
      return
    end
    local suitNum = 0
    for k, v in ipairs(suitCfg) do
      if suitAthCount >= v.num then
        suitNum = v.num
      end
    end
    self.suitAttriPool:HideAll()
    for k, v in ipairs(suitCfg) do
      local suitCount = v.num
      local info = LanguageUtil.GetLocaleText(v.describe)
      local suitItem = self.suitAttriPool:GetOne()
      suitItem:InitAthDetailSuitItem(suitNum, suitCount, info)
    end
  end
end

function UINAthDetailItem:UpdAthDetailItemState()
  self:_UpdHeroSign()
  if not self._isOnlyInfo then
    self.ui.btn_Link.gameObject:SetActive(self.athData:CanSignAth())
  end
end

function UINAthDetailItem:RefreshAthDetailItemAttr()
  local athData = self.athData
  if #athData.athMainAttrCfg.attrtibute_id > 0 then
    local attrId = athData.athMainAttrCfg.attrtibute_id[1]
    local attrValue = athData.athMainAttrCfg.attrtibute_num[1]
    local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
    local iconSprite = CRH:GetSprite(icon)
    self.ui.img_Icon.sprite = iconSprite
    self.ui.tex_AttriName.text = name
    self.ui.tex_AttriNum.text = valueStr
    self.__showAttrWin = BindCallback(self, self.__showAttrIntro, attrId, iconSprite, self.ui.btn_mainAttri.transform)
    self.__hideAttrWin = BindCallback(self, self.__hideAttrIntro)
    self.ui.btn_mainAttri.onPressDown:AddListener(self.__showAttrWin)
    self.ui.btn_mainAttri.onPressUp:AddListener(self.__hideAttrWin)
  end
  self:RefreshAthDetailItemSubAttr(athData.affixList)
end

function UINAthDetailItem:RefreshAthDetailItemSubAttr(affixList)
  if #affixList == 0 then
    self.ui.attriList:SetActive(false)
  else
    self.ui.attriList:SetActive(true)
    self.attriItemPool:HideAll()
    for k, affix in ipairs(affixList) do
      local cfg = ConfigData.ath_affix_pool[affix.id]
      if cfg == nil then
        error("Can't find ath_affix_pool, id = " .. tostring(affix.id))
      else
        local color = ArthmeticEnum.AthQualityColor[affix.quality]
        local attrItem = self.attriItemPool:GetOne()
        attrItem:InitAthDetailAttr(cfg.affix_para, affix.value, color)
        self:__registerSubAttrItemPressPop(attrItem)
      end
    end
  end
end

function UINAthDetailItem:__registerSubAttrItemPressPop(attrItem)
  if attrItem.ui ~= nil and attrItem.ui.button ~= nil then
    attrItem:InjectPressPopFunc(BindCallback(self, self.__showAttrIntro), BindCallback(self, self.__hideAttrIntro))
  end
end

function UINAthDetailItem:__showAttrIntro(attrId, iconSprite, itemTrans)
  if self.popIntroUI == nil then
    self.popIntroUI = UINAttrIntroItem.New()
    self.popIntroUI:Init(self.ui.attrPopDetail)
  end
  self.popIntroUI:ShowAttrPopIntro(attrId, iconSprite)
  self.popIntroUI.transform:SetParent(itemTrans, false)
  self.popIntroUI:Show()
end

function UINAthDetailItem:__hideAttrIntro()
  if self.popIntroUI ~= nil then
    self.popIntroUI:Hide()
  end
end

function UINAthDetailItem:__RefreshSize()
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

function UINAthDetailItem:__RefreshLock()
  local lock = self.athData.lockUnlock
  self.ui.img_Lock:SetIndex(lock and 1 or 0)
end

function UINAthDetailItem:__OnClickLock()
  if self.__onLockComplete == nil then
    self.__onLockComplete = BindCallback(self, self.OnAthLockComplete)
  end
  self.athNetwork:CS_ATH_AthLock(self.athData.uid, self.__onLockComplete)
end

function UINAthDetailItem:OnAthLockComplete()
  self:__RefreshLock()
end

function UINAthDetailItem:__OnClickOptimize()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro) then
    local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro)
    cs_MessageCommon.ShowMessageTips(msg)
    return
  end
  local strengthenEnable = ArthmeticEnum.StrengthenQuality == self.athData:GetAthQuality() and self.athData:GetAthSize() > 1
  if not strengthenEnable then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.arithmetic_Strengthlimt))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.AthRefactor, function(window)
    if window == nil then
      return
    end
    window:InitAthRefactor(self.athData, self.heroData)
  end)
end

function UINAthDetailItem:__OnClickSignHero()
  local bindHeroId = self.athData:GetAthBindHeroId()
  if bindHeroId ~= 0 and bindHeroId ~= self.heroData.dataId then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(21007))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.AthSignMain, function(window)
    if window == nil then
      return
    end
    window:InitAthSignMain(self.athData, self.heroData)
  end)
end

function UINAthDetailItem:__OnClickUninstall()
  self.detailRoot:OnClickUninstallAth()
end

function UINAthDetailItem:__OnClickInstall()
  self.detailRoot:OnClickInstallAth()
end

function UINAthDetailItem:__OnClickReplace()
  self.detailRoot:OnClickReplaceAth()
end

function UINAthDetailItem:__releasePressFunc()
  if self.__showAttrWin ~= nil then
    self.ui.btn_mainAttri.onPressDown:RemoveListener(self.__showAttrWin)
  end
  if self.__hideAttrWin ~= nil then
    self.ui.btn_mainAttri.onPressUp:RemoveListener(self.__hideAttrWin)
  end
end

function UINAthDetailItem:OnDelete()
  if self._resloader then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self.attriItemPool:DeleteAll()
  self.suitAttriPool:DeleteAll()
  self:__releasePressFunc()
  if self.popIntroUI ~= nil then
    self.popIntroUI:Hide()
    self.popIntroUI:OnDelete()
  end
  base.OnDelete(self)
end

return UINAthDetailItem
