local UISeasonMazeTeamRecommendIconType = {Job = 1, Property = 2}
_enum("UISeasonMazeTeamRecommendIconType", UISeasonMazeTeamRecommendIconType)
_class("UISeasonMazeTeamRecommendIcon", UICustomWidget)
UISeasonMazeTeamRecommendIcon = UISeasonMazeTeamRecommendIcon

function UISeasonMazeTeamRecommendIcon:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeTeamRecommendIcon:InitWidget()
  self._bgGo = self:GetGameObject("Bg")
  self._frontGo = self:GetGameObject("Front")
  self._bgImage = self:GetUIComponent("Image", "Bg")
  self._frontImage = self:GetUIComponent("Image", "Front")
  self._jobAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self._propertyAtlas = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._atlasDic = {
    [UISeasonMazeTeamRecommendIconType.Job] = self._jobAtlas,
    [UISeasonMazeTeamRecommendIconType.Property] = self._propertyAtlas
  }
  self._prof2Img = {
    [PetProfType.PetProf_Color] = "spirit_prof_5",
    [PetProfType.PetProf_Blood] = "spirit_prof_1",
    [PetProfType.PetProf_Attack] = "spirit_prof_3",
    [PetProfType.PetProf_Function] = "spirit_prof_7"
  }
  self._elementSpriteName = {
    [ElementType.ElementType_Blue] = "bing_color",
    [ElementType.ElementType_Red] = "huo_color",
    [ElementType.ElementType_Green] = "sen_color",
    [ElementType.ElementType_Yellow] = "lei_color"
  }
end

function UISeasonMazeTeamRecommendIcon:SetData(type, param)
  if type and param then
    local atlas = self._atlasDic[type]
    if atlas then
      if type == UISeasonMazeTeamRecommendIconType.Job then
        self._bgGo:SetActive(true)
        self._frontGo:SetActive(true)
        local imageName = self._prof2Img[param]
        if imageName then
          self._frontImage.sprite = atlas:GetSprite(imageName)
        end
      elseif type == UISeasonMazeTeamRecommendIconType.Property then
        self._bgGo:SetActive(true)
        self._frontGo:SetActive(true)
        local imageName = self._elementSpriteName[param]
        if imageName then
          self._frontImage.sprite = atlas:GetSprite(imageName)
        end
      end
    end
  end
end
