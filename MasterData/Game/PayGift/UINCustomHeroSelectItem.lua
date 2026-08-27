local UINCustomHeroSelectItem = class("UINCustomHeroSelectItem", UIBaseNode)
local base = UIBaseNode

function UINCustomHeroSelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_HeroInfo, self, self.OnClickPreview)
  UIUtil.AddButtonListener(self.ui.btn_HeroItem, self, self.OnClickHeroSelect)
  self._starList = {}
  table.insert(self._starList, self.ui.img_star)
end

function UINCustomHeroSelectItem:InitCustomHeroItem(heroCfg, callback, resloader)
  self._heroId = heroCfg.id
  self._callback = callback
  self._resloader = resloader
  self.ui.btn_HeroInfo.gameObject:SetActive(false)
  local rankCfg = ConfigData.hero_rank[heroCfg.rank]
  local campCfg = ConfigData.camp[heroCfg.camp]
  local careerCfg = ConfigData.career[heroCfg.career]
  local modelCfg = ConfigData.resource_model[heroCfg.src_id]
  self.ui.tex_HeroID:SetIndex(0, tostring(heroCfg.id))
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self.ui.img_Quality.color = HeroRareColor[rankCfg.rare]
  self.ui.img_QualityLight.color = HeroRareColor[rankCfg.rare]
  self.ui.img_Camp.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campCfg.icon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Camp.gameObject:SetActive(true)
    self.ui.img_Camp.texture = texture
  end)
  self.ui.img_Hero.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(modelCfg.res_Name), function(texture)
    if IsNull(self.transform) or IsNull(texture) then
      return
    end
    self.ui.img_Hero.gameObject:SetActive(true)
    self.ui.img_Hero.texture = texture
  end)
  self.ui.img_Career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  self.ui.img_IsHave:SetActive(PlayerDataCenter:ContainsHeroData(self._heroId))
  local num = heroCfg.rank
  local count = math.ceil(num / 2)
  local isHalf = num % 2 == 1
  for _, starGameObject in ipairs(self._starList) do
    starGameObject.gameObject:SetActive(false)
  end
  for i = 1, count do
    if self._starList[i] ~= nil then
      self._starList[i].gameObject:SetActive(true)
      self._starList[i]:SetIndex(0)
    else
      local imgItemInfo = self.ui.img_star.gameObject:Instantiate():GetComponent(typeof(CS.UiImageItemInfo))
      table.insert(self._starList, imgItemInfo)
      imgItemInfo.gameObject:SetActive(true)
    end
  end
  if isHalf then
    self._starList[count]:SetIndex(1)
  end
end

function UINCustomHeroSelectItem:RefreshCustomHeroState(heroId)
  self.ui.img_OnSelect.gameObject:SetActive(heroId == self._heroId)
end

function UINCustomHeroSelectItem:OnClickHeroSelect()
  if self._callback ~= nil then
    self._callback(self._heroId)
  end
end

function UINCustomHeroSelectItem:OnClickPreview()
end

return UINCustomHeroSelectItem
