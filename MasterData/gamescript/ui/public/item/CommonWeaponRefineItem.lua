local REFINE_STAGE_1_MAXLEVEL = DT.GetConstant("WeaponRefineSkillParaNum")
local MAX_STAR_NUM = 3
local CommonWeaponRefineItem, Super = System.NewComponent("CommonWeaponRefineItem")

function CommonWeaponRefineItem:ctor(uiNode, data)
  Super.ctor(self)
  self.weaponLevel = data.weaponLevel
  self.starImgPreName = data.starImgPreName
  self.maxStarImgName = data.maxStarImgName
  self.maxStarTextName = data.maxStarTextName
  self.ui = data.resource(uiNode)
end

function CommonWeaponRefineItem:OnBind(binder)
  self.binder = binder
  local level = self.weaponLevel
  local showStars = math.min(level, REFINE_STAGE_1_MAXLEVEL)
  for i = 1, MAX_STAR_NUM do
    local obj = self.ui[self.starImgPreName .. i]
    if obj then
      obj:SetActive(i <= showStars)
    end
  end
  if level > REFINE_STAGE_1_MAXLEVEL then
    self.ui[self.maxStarImgName]:SetActive(true)
    binder:SetText(self.ui[self.maxStarTextName], level - REFINE_STAGE_1_MAXLEVEL)
  else
    self.ui[self.maxStarImgName]:SetActive(false)
  end
end

return CommonWeaponRefineItem
