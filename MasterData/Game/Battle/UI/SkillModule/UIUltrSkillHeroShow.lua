local UIUltrSkillHeroShow = class("UIUltrSkillHeroShow", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local SkinEnum = require("Game.Skin.SkinEnum")

function UIUltrSkillHeroShow:OnInit()
  self.isDeleted = false
end

function UIUltrSkillHeroShow:InitUltrSkillHeroShow(caster, notAutoPlay)
  if caster == nil then
    return
  end
  local resName, skinId
  if notAutoPlay and isGameDev then
    resName = caster.resName
    self.ui.go_timeLine:SetActive(true)
    skinId = 0
  else
    local dynPlayer = BattleUtil.GetCurDynPlayer()
    if dynPlayer == nil then
      error("can't get dynPlayer")
      self:Delete()
      return
    end
    local heroData = dynPlayer.heroDic[caster.roleDataId]
    if heroData == nil then
      self:Delete()
      return
    end
    resName = heroData:GetResPicName()
    skinId = heroData.skinId
    if resName == nil then
      error("can't get resName")
      self:Delete()
      return
    end
  end
  local playRate = 1
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg ~= nil then
    playRate = skinCfg.speed * Time.unity_time.timeScale
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = cs_ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName, SkinEnum.fromWhere.ultrSkill), function(prefab)
    if self.isDeleted then
      return
    end
    DestroyUnityObject(self.bigImgGameObject)
    DestroyUnityObject(self.bigImgGameObject2)
    self.bigImgGameObject = prefab:Instantiate(self.ui.smallHeroHolder.transform)
    local comPerspHandle = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle:SetPosType("UltrSkillShowHeroSmall")
    self.bigImgGameObject2 = prefab:Instantiate(self.ui.bigHeroHolder.transform)
    local comPerspHandle2 = self.bigImgGameObject2:FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle2:SetPosType("UltrSkillShowHeroBig")
    local rawImage = self.bigImgGameObject2:FindComponent(eUnityComponentID.RawImage)
    rawImage.material = self.ui.uIM_rolo
    self.ui.bigllMask2D:SetEffect2OtherMat(rawImage.material)
    rawImage.color = self.ui.img_bigHeroHolder.color
    if notAutoPlay and isGameDev then
      self.__rawImage = rawImage
      UpdateManager:AddUpdate(function()
        if IsNull(self.__rawImage) then
          return
        end
        self.__rawImage.color = self.ui.img_bigHeroHolder.color
      end)
      return
    end
    self.ui.go_timeLine:SetActive(true)
    self.__tlCo = TimelineUtil.Play(self.ui.direct, nil, nil, nil, true, function()
      if IsNull(self.ui.img_bigHeroHolder) then
        return
      end
      rawImage.color = self.ui.img_bigHeroHolder.color
    end, playRate)
  end)
end

function UIUltrSkillHeroShow:OnDelete()
  if self.__tlCo ~= nil then
    TimelineUtil.StopTlCo(self.__tlCo)
    self.__tlCo = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.isDeleted = true
  base.OnDelete(self)
end

return UIUltrSkillHeroShow
