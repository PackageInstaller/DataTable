local UINBaseItem = class("UINBaseItem", UIBaseNode)
local base = UIBaseNode
local UINBaseHead = require("Game.CommonUI.Head.UINBaseHead")
local GuideEnum = require("Game.Guide.GuideEnum")

function UINBaseItem:OnInit()
  self.__IsLoadedGreatLoopFx = false
  self.__GreatLoopFxGo = nil
  self.__IsLoadedGreatBlastFx = false
  self.__GreatBlastFxGo = nil
  self.__lastUseHeadItem = false
  self.__isOwn = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.OnClickItemRoot)
  self.defaultQual = self.ui.Img_Quality.sprite
  self.defaultQualColor = self.ui.img_QualityColor.color
end

function UINBaseItem:InitBaseItem(itemCfg, clickEvent, clickExtrEvent, isHideLoopFx)
  self.itemCfg = itemCfg
  self.clickEvent = clickEvent
  self.clickExtrEvent = clickExtrEvent
  self.quality = itemCfg.quality
  self.__athUid = nil
  local useHeadItem = false
  local sprite = CRH:GetSpriteByItemConfig(itemCfg)
  if itemCfg.type == eItemType.Avatar or itemCfg.type == eItemType.AvatarFrame then
    self.ui.Img_Quality.sprite = self.defaultQual
    self.ui.img_QualityColor.color = self.defaultQualColor
    if self.resloader ~= nil then
      useHeadItem = true
    end
  else
    self:_SetItemQuality(itemCfg)
  end
  if self.__lastUseHeadItem ~= useHeadItem then
    self.__lastUseHeadItem = useHeadItem
    self.ui.obj_item:SetActive(not useHeadItem)
    self.ui.obj_baseHead:SetActive(useHeadItem)
  end
  if useHeadItem then
    if self.baseHeadNode == nil then
      self.baseHeadNode = UINBaseHead.New()
      self.baseHeadNode:Init(self.ui.obj_baseHead)
    end
    if itemCfg.type == eItemType.Avatar then
      self.baseHeadNode:InitBaseHead(itemCfg.id, self.resloader)
    else
      self.baseHeadNode:InitBaseHeadFrame(itemCfg.id, self.resloader)
    end
  else
    self.ui.Img_ItemPic.sprite = sprite
  end
  self.ui.obj_IsFrag:SetActive(false)
  self.ui.obj_isHreo:SetActive(false)
  self.ui.img_isSmallIcon.gameObject:SetActive(false)
  local smallIcon = itemCfg.small_icon
  if itemCfg.action_type == eItemActionType.HeroCardFrag then
    self.ui.obj_IsFrag:SetActive(true)
    self.ui.obj_isHreo:SetActive(true)
  elseif smallIcon ~= "" and smallIcon ~= nil then
    self.ui.obj_IsFrag:SetActive(true)
    self.ui.img_isSmallIcon.gameObject:SetActive(true)
    self.ui.img_isSmallIcon.sprite = CRH:GetSprite(smallIcon)
  end
  if itemCfg.small_icon_type then
    self.ui.img_isSmallIcon.color = ItemQualityColor[itemCfg.quality]
  else
    self.ui.img_isSmallIcon.color = Color.white
  end
  self:CloseGreatRewardLoopFx()
  local isGreatItem = ConfigData.game_config.itemWithGreatFxDic[itemCfg.id]
  if isGreatItem and not isHideLoopFx then
    if not self.__IsLoadedGreatLoopFx then
      self:LoadGetGreatRewardLoopFx()
    else
      self.__GreatLoopFxGo:SetActive(true)
    end
  end
  local limitTimeItemCfg = ConfigData.item_time_limit[itemCfg.id]
  if limitTimeItemCfg ~= nil then
    self:SetLimtTimeTagActive(true)
  else
    self:SetLimtTimeTagActive(false)
  end
  self:SetLimtTimeDetailActive(false)
  self.__clickArg = nil
  self:SetItemRecycyleTag(false)
  if itemCfg.icon_scale ~= nil and itemCfg.icon_scale ~= 0 then
    local scale = itemCfg.icon_scale / 1000
    self.ui.Img_ItemPic.transform.localScale = Vector3.Temp(scale, scale, 1)
  else
    self.ui.Img_ItemPic.transform.localScale = Vector3.one
  end
end

function UINBaseItem:SetNotNeedAnyJump(bool)
  self.notNeedAnyJump = bool
end

function UINBaseItem:SetLimtTimeTagActive(bValue)
  if self.ui.obj_TimeLimitIcon ~= nil and self.ui.obj_TimeLimitIcon.activeSelf ~= bValue then
    self.ui.obj_TimeLimitIcon:SetActive(bValue)
  end
end

function UINBaseItem:SetLimtTimeDetailActive(bValue)
  if self.ui.obj_TimeLimitDay ~= nil and self.ui.obj_TimeLimitDay.activeSelf ~= bValue then
    self.ui.obj_TimeLimitDay:SetActive(bValue)
  end
  if bValue then
    self:SetLimtTimeTagActive(false)
  end
end

function UINBaseItem:ShowLimtTimeDetail(outTime)
  self:SetLimtTimeDetailActive(true)
  local diffTime = outTime - PlayerDataCenter.timestamp
  if 0 < diffTime then
    local d, h, m, s = TimeUtil:TimestampToTimeInter(diffTime, false, true)
    if 0 < d then
      self.ui.tex_TimeLimitText:SetIndex(0, tostring(d))
    elseif 0 < h then
      self.ui.tex_TimeLimitText:SetIndex(1, tostring(h))
    else
      self.ui.tex_TimeLimitText:SetIndex(1, tostring(1))
    end
  else
    self.ui.tex_TimeLimitText:SetIndex(2)
  end
end

function UINBaseItem:SetItemNoClickEvent(bool)
  self._noClickEvent = bool
end

function UINBaseItem:BindAthItemUid(uid)
  self.__athUid = uid
end

function UINBaseItem:BindClickCustomArg(arg)
  self.__clickArg = arg
end

function UINBaseItem:BindBaseItemResloader(resloader)
  self.resloader = resloader
end

function UINBaseItem:OnClickItemRoot()
  if self.__isOwn == true then
    return
  end
  if self._noClickEvent then
    return
  end
  if self.clickEvent ~= nil then
    self.clickEvent(self.itemCfg, self.__clickArg)
  else
    if GuideManager.inGuide and not GuideManager:HasGuideFeature(GuideEnum.GuideFeature.ItemDetail) then
      return
    end
    local athData
    if self.__athUid ~= nil then
      athData = PlayerDataCenter.allAthData.athDic[self.__athUid]
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      if win ~= nil then
        win:SetNotNeedAnyJump(self.notNeedAnyJump)
        if athData ~= nil then
          win:InitAthDetail(self.itemCfg, athData)
        else
          win:InitCommonItemDetail(self.itemCfg)
        end
      end
    end)
  end
  if self.clickExtrEvent ~= nil then
    self.clickExtrEvent(self.itemCfg)
  end
end

function UINBaseItem:SetIsShowNewTag(isShow)
  self.ui.obj_New:SetActive(isShow)
end

function UINBaseItem:SetCountDownTime(timeStr)
  if IsNull(self.ui.obj_LockTime) or IsNull(self.ui.tex_LockTime) then
    return
  end
  if string.IsNullOrEmpty(timeStr) then
    self.ui.obj_LockTime:SetActive(false)
  end
  self.ui.obj_LockTime:SetActive(true)
  self.ui.tex_LockTime.text = timeStr
end

function UINBaseItem:SetCountDownTimeShow(isShow)
  if not IsNull(self.ui.obj_LockTime) then
    self.ui.obj_LockTime:SetActive(isShow)
  end
end

function UINBaseItem:_SetItemQuality(itemCfg)
  if itemCfg.heroId ~= nil and itemCfg.type == eItemType.HeroCard then
    local heroCfg = ConfigData.hero_data[itemCfg.heroId]
    local rare = ConfigData.hero_rank[heroCfg.rank].rare
    self.quality = eHeroRareToQaulity[rare]
  end
  self.ui.Img_Quality.sprite = CRH:GetSprite(ItemQualitySprite[self.quality], CommonAtlasType.BaseItemQuailty)
  self.ui.img_QualityColor.color = ItemQualityColor[self.quality]
end

function UINBaseItem:SetPressCallback(pressEvent, responseOnceByPress)
  self.pressEvent = pressEvent
  self.ui.btn_Root.responseOnceByPress = responseOnceByPress
  self.ui.btn_Root.onPressUp:AddListener(function()
    self.pressEvent(self.itemCfg, false)
  end)
  self.ui.btn_Root.onPress:AddListener(function()
    self.pressEvent(self.itemCfg, true)
  end)
end

function UINBaseItem:GetQuality()
  return self.quality
end

function UINBaseItem:LoadGetRewardFx(resloader, xRotate)
  local path = ItemEffPatch[self.itemCfg.quality]
  if self.__qualityFxGoDic == nil then
    self.__qualityFxGoDic = {}
  end
  if self.__qualityFxGoDic[self.itemCfg.quality] ~= nil then
    local go = self.__qualityFxGoDic[self.itemCfg.quality]
    go:SetActive(true)
    local particleSystem = go:GetComponentInChildren(typeof(CS.UnityEngine.ParticleSystem))
    particleSystem:Stop()
    particleSystem:Play()
    return
  end
  resloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or self.__stop or IsNull(self.transform) then
      return
    end
    local go = prefab:Instantiate(self.transform)
    local particleSystem = go:GetComponentInChildren(typeof(CS.UnityEngine.ParticleSystem))
    particleSystem:Stop()
    go.transform:Rotate(Vector3.New(xRotate or 0, 0, 0))
    particleSystem:Play()
    self.__qualityFxGoDic[self.itemCfg.quality] = go
  end)
end

function UINBaseItem:LoadGetGreatRewardFx(resloader, xRotate)
  if self.__IsLoadedGreatLoopFx then
    self.__GreatLoopFxGo:SetActive(false)
  end
  if self.__IsLoadedGreatBlastFx then
    self.__GreatBlastFxGo:SetActive(true)
  end
  local path = ItemEffPatch.greetBlastThenLoop
  resloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or self.__stop or IsNull(self.transform) then
      return
    end
    local go = prefab:Instantiate(self.transform)
    local particleSystem = go:GetComponentInChildren(typeof(CS.UnityEngine.ParticleSystem))
    particleSystem:Stop()
    go.transform:Rotate(Vector3.New(xRotate or 0, 0, 0))
    particleSystem:Play()
    self.__IsLoadedGreatBlastFx = true
    self.__GreatBlastFxGo = go
  end)
end

function UINBaseItem:LoadGetGreatRewardLoopFx(xRotate)
  if not self.ui.isNeedGreatFX then
    return
  end
  local prefab = CRH:GetBaseItemFx().greetLoop
  if IsNull(prefab) or self.__stop or IsNull(self.transform) then
    return
  end
  local go = prefab:Instantiate(self.transform)
  local particleSystem = go:GetComponentInChildren(typeof(CS.UnityEngine.ParticleSystem))
  particleSystem:Stop()
  go.transform:Rotate(Vector3.New(xRotate or 0, 0, 0))
  particleSystem:Play()
  self.__IsLoadedGreatLoopFx = true
  self.__GreatLoopFxGo = go
end

function UINBaseItem:TrySetGreatRewardLoopFxScale(Scale)
  if self.__GreatLoopFxGo ~= nil then
    self.__GreatLoopFxGo.transform.localScale = Scale
  end
end

function UINBaseItem:CloseGreatRewardLoopFx()
  if self.__IsLoadedGreatLoopFx then
    self.__GreatLoopFxGo:SetActive(false)
    self.__GreatLoopFxGo.transform.localScale = Vector3.one
  end
  if self.__IsLoadedGreatBlastFx then
    self.__GreatBlastFxGo:SetActive(false)
  end
end

function UINBaseItem:CloseQualityFx()
  if self.__qualityFxGoDic ~= nil then
    for _, go in pairs(self.__qualityFxGoDic) do
      go:SetActive(false)
    end
  end
end

function UINBaseItem:EnableButton(flag)
  self.ui.btn_Root.enabled = flag
end

function UINBaseItem:SetItemRecycyleTag(bool)
  if not IsNull(self.ui.obj_recycleTag) then
    self.ui.obj_recycleTag:SetActive(bool)
  end
end

function UINBaseItem:SetItemFragTag(bool)
  if not IsNull(self.ui.obj_IsFrag) then
    self.ui.obj_IsFrag:SetActive(bool)
  end
end

function UINBaseItem:SetHasFlagObjActive(bValue)
  self.__isOwn = bValue
  if not IsNull(self.ui.obj_isOwn) then
    self.ui.obj_isOwn:SetActive(bValue)
  end
end

function UINBaseItem:OnHide()
  self.__stop = true
end

function UINBaseItem:OnDelete()
  base.OnDelete(self)
end

return UINBaseItem
