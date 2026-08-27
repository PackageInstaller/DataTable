local base = require("Game.ActivityHeroGrow.UI.UINCharaDungeonBase")
local UINCharDunZangYin = class("UINCharDunNora", base)
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")

function UINCharDunZangYin:OnInit()
  base.OnInit(self)
  self.heroID = 1053
  self.skinID = 305301
  self:__LoadL2D()
end

function UINCharDunZangYin:__LoadL2D()
  local skinCfg = ConfigData.skin[self.skinID]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self.resLoader = CS.ResLoader.Create()
  self.resLoader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName), function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.picHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, self.heroID, self.skinID, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self.charDunWin:GetWindowSortingLayer(), self.ui.heroHolder, nil, true)
      self.heroCubismInteration:SetL2DPosType("CharDun", false)
    end
  end)
end

function UINCharDunZangYin:OnDelete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  DestroyUnityObject(self.liveGo)
  base.OnDelete(self)
end

return UINCharDunZangYin
