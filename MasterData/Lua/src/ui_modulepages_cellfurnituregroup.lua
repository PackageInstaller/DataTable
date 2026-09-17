local module = class("cellFurnitureGroup", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local heroTpl = L_GameTpl:getHeroTpl()
local _shopTpl = L_GameTpl:getShopTpl()
local homeDormFurnitureTpl = L_GameTpl:gethomeDormFurnitureTpl()
local _goodsTpl = L_GameTpl:getGoodsTpl()

function module.bind()
  return {
    txt_roleName = "",
    img_role = "",
    txt_favorLevel = "",
    go_goodList = true,
    goodList = {
      moduleName = "modulePages/cellGoodsItem"
    },
    arrow_scale = C_Vector3.one
  }
end

function module.methods()
  return {
    onClickFold = function(self)
      self.bFold = not self.bFold
      self.bind.go_goodList = not self.bFold
      self.bind.arrow_scale = self.bFold and C_Vector3(1, -1, 1) or C_Vector3.one
    end,
    goodList = {
      onClick = function(self, slotId, cost)
        print("=======================click cellFurnitureGroup")
        self:emit("onClick", slotId, cost)
      end
    }
  }
end

function module:open()
  self.bFold = false
  self.bind.go_goodList = true
  self:refreshView()
end

function module:close()
end

function module:refresh()
  print("=========================refresh cellFurnitureGroup")
  self:refreshView()
end

function module:refreshView()
  local tpl = heroTpl:getTplById(self.bind.heroID)
  local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  self.bind.img_role = heroClothingTpl:getAvatarTexture(heroClothingTpl:getTplById(self.bind.heroID), L_Const.resourceIndexOfAvatarTextureInHeroTpl.mid)
  local Num = 0
  for key, value in pairs(self.bind.goodsData) do
    if value.stockNum == 0 then
      Num = Num + 1
    end
  end
  local favorabilityLevel = L_HeroStore:getHeroFavorAbilityLevel(L_HeroStore:getHero(L_HeroStore:getGuidByConfigId(self.bind.heroID)))
  self.bind.txt_favorLevel = tostring(favorabilityLevel)
  local txt = ""
  local csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
  local bInDorm = csHomeStore:OnCheckPlayerIsInDormById(self.bind.heroID)
  if bInDorm then
    txt = Num .. "/" .. #self.bind.goodsData
  else
    txt = L_WordsTpl:getValue("residual_code_cellfurnituregroup_01")
  end
  self.bind.txt_roleName = heroTpl:getName(tpl) .. L_WordsTpl:getValue("residual_code_cellfurnituregroup_02") .. "(" .. txt .. ")"
  self.bind.goodList:clear()
  self.bind.goodList:insert_array(self.bind.goodsData)
end

return module
