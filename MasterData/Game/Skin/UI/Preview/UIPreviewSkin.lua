local UIPreviewSkin = class("UIPreviewSkin", UIBaseWindow)
local base = UIBaseWindow
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local waitRecorverNUM = 0

function UIPreviewSkin:OnInit()
  self.skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.ui.img_Star.gameObject:SetActive(false)
  self.starList = {}
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnClickClose)
end

function UIPreviewSkin:OnShow()
  if self.l2dBinding ~= nil and not IsNull(self.l2dBinding.renderController) then
    local interation = self.l2dBinding.renderController.transform:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if interation ~= nil then
      interation:RestartBodyAnimation()
    end
  end
  base.OnShow(self)
end

function UIPreviewSkin:ShowSkinPreview(skinId, heroStar, notSetBackFunc)
  self.skinId = skinId
  self.heroStar = heroStar
  if not notSetBackFunc then
    UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  end
  local heroId = self.skinCtrl:GetHeroId(skinId)
  local skinCfg = ConfigData.skin[skinId]
  local resModelCfg = self.skinCtrl:GetResModel(heroId, skinCfg ~= nil and skinCfg.id or nil)
  local heroData = PlayerDataCenter.heroDic[heroId]
  self.ui.tex_HeroName.text = heroData:GetName()
  if heroStar ~= nil then
    self:__RefreshStar(heroStar)
  else
  end
  local resPath = PathConsts:GetCharacterLive2DPath(resModelCfg.src_id_pic)
  local isHaveL2D = PlayerDataCenter.skinData:IsHaveL2d(skinId)
  self.l2dBinding = nil
  if isHaveL2D and not HeroCubismInteration.JudgeL2DLocked(skinCfg.id) then
    self:__LoadLive2D(resPath, skinCfg)
  else
    self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModelCfg.src_id_pic))
  end
end

function UIPreviewSkin:__RefreshStar(heroStar)
  for k, v in ipairs(self.starList) do
    v.gameObject:SetActive(false)
    v:SetIndex(0)
  end
  local count = math.ceil(heroStar / 2)
  local isHalf = heroStar % 2 == 1
  for i = 1, count do
    local star = self.starList[i]
    if star == nil then
      star = self.ui.img_Star.gameObject:Instantiate():GetComponent(typeof(CS.UiImageItemInfo))
      table.insert(self.starList, star)
    end
    star.gameObject:SetActive(true)
    if isHalf and i == count then
      star:SetIndex(1)
    end
  end
end

function UIPreviewSkin:__LoadLive2D(path, skinCfg)
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  self.Live2DResloader = CS.ResLoader.Create()
  self.Live2DResloader:LoadABAssetAsync(path, function(l2dModelAsset)
    self.l2dModelIns = l2dModelAsset:Instantiate(self.ui.heroHolder.transform)
    self.l2dModelIns.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.l2dModelIns.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = skinCfg.heroId
      local skinId = skinCfg.id
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting("UIMiddle", self.ui.heroHolder)
      self.heroCubismInteration:SetL2DPosType("SkinPreview", false)
    end
    self.l2dBinding = {}
    UIUtil.LuaUIBindingTable(self.l2dModelIns, self.l2dBinding)
  end)
end

function UIPreviewSkin:__LoadPic(path)
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = CS.ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    self.bigImgGameObject = prefab:Instantiate(self.ui.picHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("SkinPreview")
  end)
end

function UIPreviewSkin:GenCoverJumpReturnCallback()
  self:__RecycleAllPic()
  local dataTable = {}
  for key, value in pairs(self) do
    dataTable[key] = value
  end
  waitRecorverNUM = waitRecorverNUM + 1
  return function()
    self.skinId = nil
    self.heroStar = nil
    for key, value in pairs(dataTable) do
      self[key] = value
    end
    self:Show()
    self:ShowSkinPreview(self.skinId, self.heroStar, true)
    waitRecorverNUM = waitRecorverNUM - 1
  end
end

function UIPreviewSkin:BackAction()
  if 0 < waitRecorverNUM then
    self:__RecycleAllPic()
    self:Hide()
    return
  end
  self:Delete()
end

function UIPreviewSkin:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIPreviewSkin:__RecycleAllPic()
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  self.bigImgGameObject = nil
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
  end
  self.l2dModelIns = nil
end

function UIPreviewSkin:OnDelete()
  self:__RecycleAllPic()
  base.OnDelete(self)
end

return UIPreviewSkin
