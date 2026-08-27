local base = require("Game.ActivityHeroGrow.UI.UINCharaDungeonBase")
local UINCharDunMagnhilda = class("UINCharDunMagnhilda", base)
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")

function UINCharDunMagnhilda:OnInit()
  base.OnInit(self)
  self.heroID = 1049
  self:_LoadL2d()
end

function UINCharDunMagnhilda:_LoadL2d()
  local heroCfg = ConfigData.hero_data[self.heroID]
  if heroCfg == nil then
    error("Can't Get HeroCfg by ID:" .. "1049")
    return
  end
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resModel = skinCtrl:GetResModel(self.heroID, 304901)
  DestroyUnityObject(self.liveGo)
  self.resLoader = CS.ResLoader.Create()
  local picName = resModel.src_id_pic
  local resPath = PathConsts:GetCharacterLive2DPath(picName)
  self.resLoader:LoadABAssetAsync(resPath, function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.heroHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local scale = self.ui.l2d_scale
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, self.heroID, heroCfg.default_skin, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self.charDunWin:GetWindowSortingLayer(), self.ui.resHolder, nil, true)
      self.heroCubismInteration:SetL2DPosType("CharDun", false)
    end
    self.liveGo.transform.localScale = Vector3.New(scale, scale, scale)
  end)
end

function UINCharDunMagnhilda:OnDelete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  DestroyUnityObject(self.liveGo)
  base.OnDelete(self)
end

return UINCharDunMagnhilda
