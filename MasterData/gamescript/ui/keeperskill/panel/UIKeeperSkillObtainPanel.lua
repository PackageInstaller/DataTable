local UIAnimationController = CS.Z1Client.UIAnimationController
local UIKeeperSkillObtainPanel, Super = System.NewClass("UIKeeperSkillObtainPanel", UIBasePanel)
UIKeeperSkillObtainPanel.uiResCls = UI_Keeper_Panel_AcquireResource

function UIKeeperSkillObtainPanel:ctor(itemOrSkillId, closeCallback)
  Super.ctor(self)
  self.keeperSkillId = KeeperSkillUtils.GetSkillIdByItem(itemOrSkillId)
  self.closeCallback = closeCallback
end

function UIKeeperSkillObtainPanel:LoadTempDependenciesResources()
  local resList = {}
  table.insert(resList, CommonRes.KeeperSkillFilmUrl)
  table.append(resList, self:GetFilmPngs())
  return resList
end

function UIKeeperSkillObtainPanel:GetFilmPngs()
  local pngList = {}
  local itemCfg = KeeperSkillUtils.GetItemCfg(self.keeperSkillId) or {}
  for _, png in ipairs(itemCfg.PossePic or {}) do
    table.insert(pngList, png)
  end
  return pngList
end

function UIKeeperSkillObtainPanel:OnBind(binder)
  self.binder = binder
  self:CreateFilmPrefab()
  self.ui.Btn_Close:SetActive(false)
  binder:BindButtonClick(self.ui.Btn_Close, function()
    self:Close()
  end)
  binder:BindToImage(self.ui.Image_Crystal, function()
    do return KeeperSkillUtils.GetDisplayImage end
    return KeeperSkillUtils.GetDisplayImage, self.keeperSkillId
  end)
  self.binder:BindToText(self.ui.Text_Title, function()
    do return KeeperSkillUtils.GetSkillName end
    return KeeperSkillUtils.GetSkillName, self.keeperSkillId
  end)
  self.binder:BindToText(self.ui.Text_Desc_1, function()
    do return KeeperSkillUtils.GetKeeperSkillDesc end
    return KeeperSkillUtils.GetKeeperSkillDesc, self.keeperSkillId
  end, false, function()
    self.ui.Group_Keyword:SetActive(not self.ui.Group_Keyword.activeSelf)
    if self.ui.Group_Keyword.activeSelf and not self.KeyWordComp then
      self.KeyWordComp = self.binder:BindComponent(CommonKeyWordDescGroup(self.ui.Group_Keyword, {
        KeeperSkillUtils.GetKeeperSkillDesc(self.keeperSkillId)
      }))
    end
  end)
  self.binder:BindToImage(self.ui.Image_Icon, function()
    do return KeeperSkillUtils.GetSkillIcon end
    return KeeperSkillUtils.GetSkillIcon, self.keeperSkillId
  end)
  self.binder:BindTimer(1, 0, nil, function()
    local height = StrUtils.SetPreferredHeight(self.ui.Text_Desc_1)
  end)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Tip)
end

function UIKeeperSkillObtainPanel:CreateFilmPrefab(callback)
  self.ui.uiNode:SetActive(false)
  local prefab = self.binder:LoadAsset(CommonRes.KeeperSkillFilmUrl)
  local go = CS.UnityEngine.GameObject.Instantiate(prefab)
  local filmUI = UI_Keeper_Panel_Acquire_FilmResource(go)
  local filmPngs = self:GetFilmPngs()
  local finalPngUrl = table.remove(filmPngs, 1)
  local pngUrlCount = #filmPngs
  local pngGoCount = 50
  local pngGo, pngUrl
  if pngUrlCount > 0 then
    for i = 1, pngGoCount do
      pngGo = filmUI["Image_Skill" .. i]
      if pngGo then
        pngUrl = filmPngs[(i - 1) % pngUrlCount + 1]
        self.binder:SetImage(pngGo, pngUrl)
      end
    end
  end
  if filmUI.Image_FinialChoose and finalPngUrl then
    self.binder:SetImage(filmUI.Image_FinialChoose, finalPngUrl)
  end
  self.ui.uiNode:SetActive(true)
  local animCtr = go:GetComponent(typeof(UIAnimationController))
  if animCtr then
    animCtr:PlayState("UI_Keeper_Panel_Acquire_Film_Open", function()
      if callback then
        callback()
      end
    end)
  end
  self.binder:onDestroy(function()
    CS.UnityEngine.GameObject.Destroy(go)
  end)
end

function UIKeeperSkillObtainPanel:OpenAnimCallback()
  Super.OpenAnimCallback(self)
  self.ui.Btn_Close:SetActive(true)
end

function UIKeeperSkillObtainPanel:OnUnbind()
  Super.OnUnbind(self)
  if self.closeCallback then
    self.closeCallback()
  end
  self.closeCallback = nil
end

return UIKeeperSkillObtainPanel
