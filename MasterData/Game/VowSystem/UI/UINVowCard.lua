local UINVowCard = class("UINVowCard", UIBaseNode)
local base = UIBaseNode
local cs_ResLoader = CS.ResLoader
local cs_Material = CS.UnityEngine.Material

function UINVowCard:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.backDir = Vector3.New(0, 0, 1)
  self.mat = cs_Material(self.ui.rander_PaintZone.material)
  self.ui.rander_PaintZone.material = self.mat
  self._resLoader = cs_ResLoader.Create()
end

function UINVowCard:InitVowCardNode(heroId)
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  local userName = PlayerDataCenter.inforData:GetUserName()
  local heroName = heroData:GetName()
  local timeTex = TimeUtil:TimestampToDateString(heroData:GetHeroVowTime(), false, true, ConfigData:GetTipContent(768))
  self.ui.tex_PlayerName.text = userName
  self.ui.tex_HeroName.text = heroName
  self.ui.tex_Time.text = timeTex
  self.rigidBody = self.ui.rigidBody
  local heroVowCfg = ConfigData.hero_vow_reward[heroId]
  self.mat:SetColor("_PointColorA", heroVowCfg.cardColors[2])
  self.mat:SetColor("_PointColorB", heroVowCfg.cardColors[1])
  local heroCfg = ConfigData.hero_data[heroId]
  local loadSkinId = heroCfg.default_skin
  for _, skinId in ipairs(heroCfg.skin) do
    local skinCfg = ConfigData.skin[skinId]
    if skinCfg.theme == 3 then
      loadSkinId = skinId
      break
    end
  end
  local path = PathConsts:GetCharacterBigImgPrefabPath(ConfigData.skin[loadSkinId].src_id_pic)
  self._resLoader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or IsNull(self.transform) then
      return
    end
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
  end)
  self.ui.img_Hero.enabled = false
  local path = PathConsts:GetCharacterPicPath(ConfigData.skin[loadSkinId].src_id_pic)
  self._resLoader:LoadABAssetAsync(path, function(texture)
    if IsNull(texture) or IsNull(self.transform) then
      return
    end
    self.ui.img_Hero.enabled = true
    self.ui.img_Hero.texture = texture
  end)
end

function UINVowCard:ClearAngularMomentum()
  self:SetAngularMomentum(Vector3.zero)
end

function UINVowCard:GetAngularMomentum()
  if not IsNull(self.rigidBody) then
    return self.rigidBody.angularVelocity
  end
end

function UINVowCard:SetAngularMomentum(angularMomentum)
  if not IsNull(self.rigidBody) then
    self.rigidBody.angularVelocity = angularMomentum
  end
end

function UINVowCard:IsRotToBack()
  local backDir = self.backDir
  local currentForward = self.rigidBody.transform.forward
  local dot = Vector3.Dot(backDir, currentForward)
  if 0.4 < dot then
    return true
  end
  return false
end

function UINVowCard:GetRotationAngular()
  if not IsNull(self.rigidBody) then
    return self.rigidBody.rotation.eulerAngles
  end
end

function UINVowCard:OnDelete()
  DestroyUnityObject(self.mat)
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
end

return UINVowCard
