local base = require("Game.ActivityHeroGrow.UI.UINCharaDungeonBase")
local UINCharDunMillau = class("UINCharDunMillau", base)
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")

function UINCharDunMillau:OnInit()
  base.OnInit(self)
  self.heroID = 1054
  self.skinID = 305400
  self:_LoadLive2D()
end

function UINCharDunMillau:_LoadLive2D()
  local skinCfg = ConfigData.skin[self.skinID]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self.resLoader = CS.ResLoader.Create()
  self.resLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    if IsNull(prefab) then
      return
    end
    self.bigImgGameObject = prefab:Instantiate()
    self.bigImgGameObject.transform:SetParent(self.ui.picHolder.transform)
    self.bigImgGameObject.transform:SetLayer(LayerMask.UI)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("CharDun")
  end)
end

return UINCharDunMillau
