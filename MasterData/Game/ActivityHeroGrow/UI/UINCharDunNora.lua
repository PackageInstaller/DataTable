local base = require("Game.ActivityHeroGrow.UI.UINCharaDungeonBase")
local UINCharDunNora = class("UINCharDunNora", base)
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local HeroData = require("Game.PlayerData.Hero.HeroData")

function UINCharDunNora:OnInit()
  base.OnInit(self)
  self.heroID = 1048
  self:_LoadLive2D()
end

function UINCharDunNora:_LoadLive2D()
  local heroCfg = ConfigData.hero_data[self.heroID]
  if heroCfg == nil then
    error("Can't Get HeroCfg by ID:" .. "1048")
    return
  end
  local heroData = HeroData.New({
    basic = {
      id = self.heroID,
      level = 1,
      exp = 0,
      star = heroCfg.rank,
      potentialLvl = 0,
      ts = -1,
      career = heroCfg.career,
      company = heroCfg.camp,
      skinId = 304801
    }
  })
  DestroyUnityObject(self.liveGo)
  self.resLoader = CS.ResLoader.Create()
  local picName = heroData:GetResPicName()
  local resPath = PathConsts:GetCharacterLive2DPath(picName)
  self.resLoader:LoadABAssetAsync(resPath, function(l2dModelAsset)
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.heroHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local scale = self.ui.l2d_scale
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = heroData.dataId
      local skinId = heroData.skinId
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self.charDunWin:GetWindowSortingLayer(), self.ui.heroHolder, nil, true)
      self.heroCubismInteration:SetL2DPosType("CharDun", false)
    end
    self.liveGo.transform.localScale = Vector3.New(scale, scale, scale)
  end)
end

function UINCharDunNora:OnDelete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  DestroyUnityObject(self.liveGo)
  base.OnDelete(self)
end

return UINCharDunNora
