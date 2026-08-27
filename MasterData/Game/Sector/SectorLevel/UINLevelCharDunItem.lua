local UINLevelCharDunItem = class("UINLevelCharDunItem", UIBaseNode)
local base = UIBaseNode

function UINLevelCharDunItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickStage)
end

function UINLevelCharDunItem:InitCharDunSectorStage(stageId, clickEvent, seclectStateFunc, resLoader)
  self._stageId = stageId
  self._stageCfg = ConfigData.sector_stage[stageId]
  self._clickEvent = clickEvent
  self._resLoader = resLoader
  self._seclectStateFunc = seclectStateFunc
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self._stageCfg.name)
  self.ui.tex_Number:SetIndex(0, tostring(self._stageCfg.num))
  local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow)
  local actHeroCfg
  local actId, data = heroGrowCtrl:GetHeroGrowDataBySectorId(self._stageCfg.sector)
  if data ~= nil then
    actHeroCfg = data:GetHeroGrowCfg()
  elseif actId ~= nil then
    actHeroCfg = ConfigData.activity_hero[actId]
  end
  local path = PathConsts:GetCharDunPrefabPath(self._stageCfg.pic)
  if IsNull(self.bgPrefab) then
    self._resLoader:LoadABAssetAsync(path, function(prefab)
      if IsNull(prefab) or IsNull(self.ui.rect_Holder) then
        return
      end
      self.bgPrefab = prefab:Instantiate(self.ui.rect_Holder)
      self.transform.sizeDelta = self.bgPrefab.transform.sizeDelta
    end)
  end
  local markItemCfg, strDrop
  if actHeroCfg ~= nil then
    local markItemId = actHeroCfg.token
    markItemCfg = ConfigData.item[markItemId]
    strDrop = LanguageUtil.GetLocaleText(actHeroCfg.token_drop)
  end
  self.ui.tex_Drop.text = strDrop or ""
  if markItemCfg == nil then
    self.ui.imgDrop:SetActive(false)
  else
    self.ui.imgDrop:SetActive(true)
    self.ui.img_BigIcon.sprite = CRH:GetSprite(markItemCfg.icon)
    self.ui.img_SmallIcon.sprite = CRH:GetSprite(markItemCfg.small_icon)
    self.ui.tex_Count.text = ""
  end
  self._lastSelectState = false
  self:RefreshStageUI()
  self:SeletedLevelItem(false, false)
  self:RefreshUncompletedEp(false, false)
end

function UINLevelCharDunItem:RefreshStageUI()
  local isunLock = PlayerDataCenter.sectorStage:IsStageUnlock(self._stageId)
  if isunLock then
    self.ui.obj_Lock:SetActive(false)
    return
  end
  self.ui.obj_Lock:SetActive(true)
  self.ui.tex_Condition.text = PlayerDataCenter.sectorStage:GetGetUnlockInfo(self._stageId)
end

function UINLevelCharDunItem:OnClickStage()
  if self._clickEvent ~= nil then
    self._clickEvent(self)
  end
end

function UINLevelCharDunItem:GetLevelStageData()
  return self._stageCfg
end

function UINLevelCharDunItem:IsLevelUnlock()
  return PlayerDataCenter.sectorStage:IsStageUnlock(self._stageId)
end

function UINLevelCharDunItem:SeletedLevelItem(select, withTween)
  if self._seclectStateFunc ~= nil and select ~= self._lastSelectState then
    self._seclectStateFunc(self, select, self._lastSelectState)
  end
  self._lastSelectState = select
end

function UINLevelCharDunItem:RefreshUncompletedEp(flag)
end

function UINLevelCharDunItem:SetBluedot(show)
  self.ui.blueDot:SetActive(show)
end

function UINLevelCharDunItem:OnDelete()
  if not IsNull(self.bgPrefab) then
    DestroyUnityObject(self.bgPrefab)
  end
  base.OnDelete(self)
end

return UINLevelCharDunItem
