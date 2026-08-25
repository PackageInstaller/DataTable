local UIAnimationController = CS.Z1Client.UIAnimationController
local KeeperSkillObtainView, Super = NewClass("KeeperSkillObtainView", BaseView)
KeeperSkillObtainView.uiResCls = UI_Keeper_Panel_AcquireResource

function KeeperSkillObtainView:ctor(itemOrSkillId, closeCallback)
  Super.ctor(self)
  self._keeperSkillId = KeeperSkillUtils.GetSkillIdByItem(itemOrSkillId)
  self._closeCallback = closeCallback
end

function KeeperSkillObtainView:OnBuildView()
  Super.OnBuildView(self)
  self:_CreateFilmPrefab()
end

function KeeperSkillObtainView:OnEnterView()
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
  self:BindTimer(1, 0, nil, function()
    StrUtils.SetPreferredHeight(self.ui.Text_Desc_1)
  end)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Tip)
end

function KeeperSkillObtainView:_RefreshText()
  local textTitle = KeeperSkillUtils.GetSkillName(self._keeperSkillId)
  self:SetText(self.ui.Text_Title, textTitle)
  local descText1 = KeeperSkillUtils.GetKeeperSkillDesc(self._keeperSkillId)
  self:SetText(self.ui.Text_Desc_1, descText1, false, function()
    self.ui.Group_Keyword:SetActive(not self.ui.Group_Keyword.activeSelf)
    if self.ui.Group_Keyword.activeSelf and not self._KeyWordComp then
      self._KeyWordComp = self:AddViewComponent(self.ui.Group_Keyword, CommonKeyWordDescGroupItem, {
        KeeperSkillUtils.GetKeeperSkillDesc(self._keeperSkillId)
      })
    end
  end)
end

function KeeperSkillObtainView:_RefreshImage()
  local crystalImage = KeeperSkillUtils.GetDisplayImage(self._keeperSkillId)
  self:SetImage(self.ui.Image_Crystal, crystalImage)
  local iconImage = KeeperSkillUtils.GetSkillIcon(self._keeperSkillId)
  self:SetImage(self.ui.Image_Icon, iconImage)
end

function KeeperSkillObtainView:_RefreshVisible()
  self.ui.Btn_Close:SetActive(false)
end

function KeeperSkillObtainView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Close, System.fn(self, self.Close))
end

function KeeperSkillObtainView:OnExitView()
  Super.OnExitView(self)
  if self._filmGo then
    CS.UnityEngine.GameObject.Destroy(self._filmGo)
    self._filmGo = nil
  end
  if self._closeCallback then
    self._closeCallback()
  end
  self._closeCallback = nil
end

function KeeperSkillObtainView:LoadTempDependenciesResources()
  local resList = {}
  table.insert(resList, CommonRes.KeeperSkillFilmUrl)
  table.append(resList, self:_GetFilmPngs())
  return resList
end

function KeeperSkillObtainView:_GetFilmPngs()
  local pngList = {}
  local itemCfg = KeeperSkillUtils.GetItemCfg(self._keeperSkillId) or {}
  for _, png in ipairs(itemCfg.PossePic or {}) do
    table.insert(pngList, png)
  end
  return pngList
end

function KeeperSkillObtainView:_CreateFilmPrefab(callback)
  self.ui.uiNode:SetActive(false)
  local prefab = self:LoadAsset(CommonRes.KeeperSkillFilmUrl)
  local go = CS.UnityEngine.GameObject.Instantiate(prefab)
  self._filmGo = go
  local filmUI = UI_Keeper_Panel_Acquire_FilmResource(go)
  local filmPngs = self:_GetFilmPngs()
  local finalPngUrl = table.remove(filmPngs, 1)
  local pngUrlCount = #filmPngs
  local pngGoCount = 50
  local pngGo, pngUrl
  if pngUrlCount > 0 then
    for i = 1, pngGoCount do
      pngGo = filmUI["Image_Skill" .. i]
      if pngGo then
        pngUrl = filmPngs[(i - 1) % pngUrlCount + 1]
        self:SetImage(pngGo, pngUrl)
      end
    end
  end
  if filmUI.Image_FinialChoose and finalPngUrl then
    self:SetImage(filmUI.Image_FinialChoose, finalPngUrl)
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
end

function KeeperSkillObtainView:OpenAnimCallback()
  Super.OpenAnimCallback(self)
  self.ui.Btn_Close:SetActive(true)
end

return KeeperSkillObtainView
