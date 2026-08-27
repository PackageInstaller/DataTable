local UIPicLive2dNode = class("UIPicLive2dNode", UIBaseNode)
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local SkinEnum = require("Game.Skin.SkinEnum")

function UIPicLive2dNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIPicLive2dNode:InitPicLive2dNode(heroId, skinId, onlyPic)
  self.skinCfg = ConfigData.skin[skinId]
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resModel = skinCtrl:GetResModel(heroId, skinId)
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  local resPath = PathConsts:GetCharacterLive2DPath(resModel.src_id_pic, SkinEnum.fromWhere.otherPlayerHero)
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.l2dBinding = nil
  if PlayerDataCenter.skinData:GetSkinLive2dLevel(skinId) > 0 and not onlyPic then
    self:__LoadLive2D(heroId, skinId, resPath)
  else
    self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(self.skinCfg.src_id_pic, SkinEnum.fromWhere.otherPlayerHero))
  end
end

function UIPicLive2dNode:__LoadLive2D(heroId, skinId, path)
  self.Live2DResloader = CS.ResLoader.Create()
  local l2dModelAsset = self.Live2DResloader:LoadABAsset(path)
  if IsNull(self.transform) or IsNull(l2dModelAsset) then
    return
  end
  self.l2dModelIns = l2dModelAsset:Instantiate()
  self.l2dModelIns.transform:SetParent(self.transform)
  self.l2dModelIns.transform:SetLayer(LayerMask.UI)
  local cs_CubismInterationController = self.l2dModelIns.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
  if cs_CubismInterationController ~= nil then
    self.heroCubismInteration = HeroCubismInteration.New()
    self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
    self.heroCubismInteration:SetInterationOpenWait(false)
    self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
    self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroFade, 1, true)
    self.heroCubismInteration:SetL2DPosType("HeroSkin", false)
  end
  self.l2dBinding = {}
  UIUtil.LuaUIBindingTable(self.l2dModelIns, self.l2dBinding)
end

function UIPicLive2dNode:__LoadPic(path)
  self.bigImgResloader = CS.ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or IsNull(self.transform) then
      return
    end
    self.bigImgGameObject = prefab:Instantiate(self.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
  end)
end

function UIPicLive2dNode:OnDelete()
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
end

return UIPicLive2dNode
