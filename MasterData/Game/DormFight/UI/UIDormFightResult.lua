local base = UIBaseWindow
local UIDormFightResult = class("UIDormFightResult", base)
local UIDormFightUserInfo = require("Game.DormFight.UI.UIDormFightUserInfo")
local UINUserTitle = require("Game.CommonUI.Title.UINNormalTitleItem")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroInfoData = require("Game.Lottery.Data.HeroInfoData")
local cs_ResLoader = CS.ResLoader
local SkinEnum = require("Game.Skin.SkinEnum")

function UIDormFightResult:OnInit()
  self.userInfo = UIDormFightUserInfo.New()
  self.userInfo:Init(self.ui.dormFightUserInfo)
  self.userTitle = UINUserTitle.New()
  self.userTitle:Init(self.ui.uINAppellation)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickContinue)
  self.resLoader = cs_ResLoader.Create()
end

function UIDormFightResult:InitDormFightResult(mvpKillCount, heroId, skinId, userData, comfirmCallback)
  local resLoader = self.resLoader
  self.comfirmCallback = comfirmCallback
  if skinId == 0 then
    skinId = (heroId + 2000) * 100
  end
  self.skinCfg = ConfigData.skin[skinId]
  self.userInfo:InitDormFightUserInfo(userData, resLoader)
  local title = userData:GetAvatarTitleId()
  if title ~= nil and title.titlePrefix ~= 0 then
    local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
    self._titleBgAtlas = resLoader:LoadABAsset(atlasPath)
    self.userTitle:InitNormalTitleItem(title.titlePrefix, title.titlePostfix, title.titleBackGround, self.resloader, self._titleBgAtlas)
  else
    self.ui.uINAppellation:SetActive(false)
  end
  self:_InitImgRes(heroId, skinId)
  local heroInfoData = HeroInfoData:New()
  heroInfoData:InitData(heroId)
  local heroData = heroInfoData.heroData
  heroData:UpdateSkin(skinId)
  self.ui.tex_HeroName.text = heroData:GetHeroName(true)
end

function UIDormFightResult:_InitImgRes(heroId, skinId)
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
  if self.skinCfg.live2d_level > 0 then
    self:__LoadLive2D(heroId, skinId, resPath)
  else
    self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(self.skinCfg.src_id_pic, SkinEnum.fromWhere.otherPlayerHero))
  end
end

function UIDormFightResult:__LoadLive2D(heroId, skinId, path)
  self.Live2DResloader = CS.ResLoader.Create()
  local l2dModelAsset = self.Live2DResloader:LoadABAsset(path)
  if IsNull(self.transform) or IsNull(l2dModelAsset) then
    return
  end
  self.l2dModelIns = l2dModelAsset:Instantiate()
  self.l2dModelIns.transform:SetParent(self.ui.heroPicHolder.transform)
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

function UIDormFightResult:__LoadPic(path)
  self.bigImgResloader = CS.ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or IsNull(self.transform) then
      return
    end
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroPicHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
  end)
end

function UIDormFightResult:_OnClickContinue()
  self:Delete()
  if self.comfirmCallback ~= nil then
    self.comfirmCallback()
  end
end

function UIDormFightResult:OnDelete()
  self.userInfo:Delete()
  self.userInfo = nil
  self.userTitle:Delete()
  self.userTitle = nil
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
  base.OnDelete(self)
end

return UIDormFightResult
