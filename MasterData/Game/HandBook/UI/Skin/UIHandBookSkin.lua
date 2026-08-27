local UIHandBookSkin = class("UIHandBookSkin", UIBaseWindow)
local base = UIBaseWindow
local UINHBSkinSingle = require("Game.HandBook.UI.Skin.UINHBSkinSingle")
local UINHandBookSkinTag = require("Game.HandBook.UI.Skin.UINHandBookSkinTag")
local SkinEnum = require("Game.Skin.SkinEnum")
local CS_Resloader = CS.ResLoader
local cs_Tweening = CS.DG.Tweening
local SkinConditionSortOrder = {
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Store] = 1,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Gift] = 2,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active] = 3,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank] = 4
}

function UIHandBookSkin:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickCloseSingle)
  self.__SelectSkinCallback = BindCallback(self, self.__SelectSkin)
  self._resloder = CS_Resloader.Create()
  self._itemPool = UIItemPool.New(UINHBSkinSingle, self.ui.skinItem)
  self.ui.skinItem:SetActive(false)
  self._tagPool = UIItemPool.New(UINHandBookSkinTag, self.ui.hot.gameObject)
  self.ui.hot.gameObject:SetActive(false)
  self.__OnActivityShowChangeCallback = BindCallback(self, self.__OnActivityShowChange)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self.__OnActivityShowChangeCallback)
  self.__OnHeroSkinUpgrade = BindCallback(self, self._OnHeroSkinUpgrade)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinUpgrade, self.__OnHeroSkinUpgrade)
end

function UIHandBookSkin:InitHBSkinThemeSingle(themeId, isInSell, callback)
  self._isInSell = isInSell
  self._themeId = themeId
  self._callback = callback
  local themeCfg = ConfigData.skinTheme[themeId]
  self._hbCtrl = ControllerManager:GetController(ControllerTypeId.HandBook)
  self._hbCtrl:SetHBViewSetLayer(2, LanguageUtil.GetLocaleText(themeCfg.name))
  self.ui.img_SkinBg.gameObject:SetActive(false)
  self._resloder:LoadABAssetAsync(PathConsts:GetHeroSkinThemePicPath(themeCfg.pic), function(Texture)
    if Texture == nil or IsNull(self.transform) then
      return
    end
    self.ui.img_SkinBg.texture = Texture
    self.ui.img_SkinBg.gameObject:SetActive(true)
  end)
  self.ui.tex_SkinGroupName.text = LanguageUtil.GetLocaleText(themeCfg.name)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(themeCfg.theme_info)
  local skinIdList = ConfigData.skin.themeDic[self._themeId]
  local totalCount = 0
  self._skinCfgList = {}
  for i, skinId in ipairs(skinIdList) do
    local skinCfg = ConfigData.skin[skinId]
    if PlayerDataCenter.skinData:IsSkinUnlocked(skinId) then
      if skinCfg == nil then
        error("skin is nil id is " .. tostring(skinId))
      elseif not skinCfg.skin_locked then
        table.insert(self._skinCfgList, skinCfg)
        totalCount = totalCount + 1
      end
    end
  end
  self._totalCount = totalCount
  self:RefreshHBSkinItems()
  self:RefreshHBSkinCollect(isInSell)
  self:Try2StartSkinTimer()
end

function UIHandBookSkin:PlayeHBSkinAni(startWorldPos)
  self:__StopAni()
  self.ui.skinGroupItem:DOScale(Vector2.New(1.26, 1.26), 0.2):From()
  self.ui.skinGroupItem:DOMove(startWorldPos, 0.2):From():SetEase(cs_Tweening.Ease.OutQuad)
  self.ui.slider:DOValue(0, 0.5):From():SetEase(cs_Tweening.Ease.OutQuad)
  for index, item in ipairs(self._itemPool.listItem) do
    item:PlayHBSkinSingleAni(index * 0.066)
  end
end

function UIHandBookSkin:__StopAni()
  self.ui.skinGroupItem:DOComplete()
  self.ui.skinGroupItem:DOComplete()
  self.ui.slider:DOComplete()
end

function UIHandBookSkin:RefreshHBSkinItems()
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  table.sort(self._skinCfgList, function(a, b)
    local aConditionList = skinCtrl:GetAllSourceValid(a.id)
    local bConditionList = skinCtrl:GetAllSourceValid(b.id)
    local aCount = #aConditionList
    local bCount = #bConditionList
    if aCount ~= bCount then
      return aCount > bCount
    end
    if 0 < aCount then
      local aCondition = aConditionList[1]
      local bCondition = bConditionList[1]
      local aOrder = SkinConditionSortOrder[aCondition] or math.maxinteger
      local bOrder = SkinConditionSortOrder[bCondition] or math.maxinteger
      if aOrder ~= bOrder then
        return aOrder < bOrder
      end
    end
    return a.id > b.id
  end)
  self._itemPool:HideAll()
  for index, skinCfg in ipairs(self._skinCfgList) do
    local item = self._itemPool:GetOne()
    item:InitHBSkinSingle(skinCfg, self._resloder, self.__SelectSkinCallback)
  end
end

function UIHandBookSkin:RefreshHBSkinCollect(isInSell)
  if self._isInSell ~= isInSell then
    self:RefreshHBSkinItems()
  end
  self._isInSell = isInSell
  local count = self._hbCtrl:GetSkinThemeCollectNum(self._themeId)
  self.ui.tex_Progress:SetIndex(0, tostring(count), tostring(self._totalCount))
  if self._totalCount == 0 then
    self.ui.slider.value = 1
  else
    self.ui.slider.value = count / self._totalCount
  end
  self._tagPool:HideAll()
  if isInSell then
    local tag = self._tagPool:GetOne()
    tag:InitBookSkinTag(1)
  end
  if ConfigData.skin.themeActivityDic[self._themeId] ~= nil then
    local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local flag = false
    for actFrameId, _ in pairs(ConfigData.skin.themeActivityDic[self._themeId]) do
      local activityData = activityCtrl:GetActivityFrameData(actFrameId)
      if activityData ~= nil and activityData:IsActivityOpen() then
        flag = true
        break
      end
    end
    if flag then
      local tag = self._tagPool:GetOne()
      tag:InitBookSkinTag(2)
    end
  end
end

function UIHandBookSkin:Try2StartSkinTimer()
  self:OnSkinTimerEnd()
  self:__OnSkinTimer()
  self.skinTimer = TimerManager:StartTimer(1, self.__OnSkinTimer, self)
end

function UIHandBookSkin:_OnHeroSkinUpgrade(heroId, skinId)
  self:Try2StartSkinTimer()
end

function UIHandBookSkin:__OnSkinTimer()
  local skinData = PlayerDataCenter.skinData
  local canUpgrade = 0
  local skinLimitNum = 0
  for _, item in ipairs(self._itemPool.listItem) do
    local skinCfg = item._skinCfg
    item:UpdHBSkinSingle()
    if skinData:IsSkinCanUpgrade(skinCfg.id) and skinData:IsInSkinUpgradeTimeRange(skinCfg.id) then
      canUpgrade = canUpgrade + 1
    end
    if skinData:IsHaveSkinLimit(skinCfg.id) then
      skinLimitNum = skinLimitNum + 1
    end
  end
  if canUpgrade < 1 and skinLimitNum < 1 then
    self:OnSkinTimerEnd()
  end
end

function UIHandBookSkin:OnSkinTimerEnd()
  if self.skinTimer ~= nil then
    TimerManager:StopTimer(self.skinTimer)
    self.skinTimer = nil
  end
end

function UIHandBookSkin:__OnActivityShowChange(ids)
  local activityIdDic = ConfigData.skin.themeActivityDic[self._themeId]
  if activityIdDic == nil then
    return
  end
  local flag = false
  for _, activityId in ipairs(ids) do
    if activityIdDic[activityId] then
      flag = true
      break
    end
  end
  if not flag then
    return
  end
  self:RefreshHBSkinCollect(self._isInSell)
  self:RefreshHBSkinItems()
end

function UIHandBookSkin:__SelectSkin(skinId)
  local skinSortList = {}
  for i, v in ipairs(self._skinCfgList) do
    table.insert(skinSortList, v.id)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkin, function(win)
    if IsNull(win) then
      return
    end
    win:SetSkinFromWhere(SkinEnum.fromWhere.heroInfoAndHandbook)
    win:InitSkinBySkinList(skinId, skinSortList)
  end)
end

function UIHandBookSkin:GetHBSkinThemeId()
  return self._themeId
end

function UIHandBookSkin:OnClickCloseSingle()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIHandBookSkin:OnDelete()
  self:OnSkinTimerEnd()
  self._resloder:Put2Pool()
  self._resloder = nil
  self:__StopAni()
  self._itemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__OnActivityShowChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinUpgrade, self.__OnHeroSkinUpgrade)
  base.OnDelete(self)
end

return UIHandBookSkin
