local module = class("cellPetGene", G_UIModuleBase)
local petDna = L_GameTpl:getDnaTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    id = nil,
    guid = nil,
    geneColor = {
      [1] = "#c3535d",
      [2] = "#ef8787",
      [3] = "#619ed4",
      [4] = "#b261d4",
      [5] = "#e19b56"
    },
    rarity = {
      [1] = "UI/Atlas/PetDna/tex_icon_petdna_bg_red%s.png",
      [2] = "UI/Atlas/PetDna/tex_icon_petdna_bg_red%s.png",
      [3] = "UI/Atlas/PetDna/tex_icon_petdna_bg_red%s.png",
      [4] = "UI/Atlas/PetDna/tex_icon_petdna_bg_red%s.png",
      [5] = "UI/Atlas/PetDna/tex_icon_petdna_bg_red%s.png"
    }
  }
end

function module.bind()
  return {
    conditionIconColor = C_Color.white,
    icon = "",
    bg = "Pages/PetBox/tex_pet_bg_geneblue",
    selected = false,
    empty = true,
    emptyColor = CS.UnityEngine.Color(1, 1, 1),
    show_slot = false,
    show_lockBg = false,
    levelList = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    labelOnAcitve = false,
    labelOffActive = false,
    iconCodition = "",
    blueEffectActive = false,
    geneNameText = "",
    offGaneNameText = ""
  }
end

function module.methods()
  return {
    onClick_Choose = function(self)
      self:emit("onClick_Choose", self.bind)
    end
  }
end

function module:refresh()
  self:refreshInfo()
end

function module:refreshData(data)
  self.bind.geneId = data.geneId
  self.bind.lock = data.lock
  self.bind.gene_skill = data.gene_skill
  self.bind.pos = data.pos
  self.bind.gene_name = data.gene_name
  self.bind.rarity = data.rarity
  self.bind.geneLv = data.geneLv
  self.bind.rectPos = nil
  self:refreshInfo()
end

function module:setSelected(isSelected)
  self.bind.selected = isSelected
end

function module:setRareShowSelected(isSelected)
  self.bind.selected = isSelected
  self.bind.labelOnAcitve = isSelected
  self.bind.labelOffActive = not isSelected
end

function module:refreshInfo()
  if self.bind.rectPos then
    self.bindComponents.geneTrans.localPosition = self.bind.rectPos
  end
  self.bind.geneNameText = self.bind.gene_name
  self.bind.offGaneNameText = self.bind.gene_name
  if not math.isEmpty(self.bind.geneId) then
    local petDnaTpl = petDna:getTplById(self.bind.geneId)
    self.bind.empty = false
    self.bind.show_slot = true
    self.bind.icon = petDna:getIconEffect(petDnaTpl)
    self.bind.iconCodition = petDna:getIconCodition(petDnaTpl)
    local isRarity = petDna:getIsRarity(petDnaTpl)
    local rarityIndex = isRarity and 2 or 1
    self.bind.bg = string.format("UI/Atlas/PetDna/tex_icon_petdna_bg_quality_%s_%s.png", self.bind.rarity, rarityIndex)
    self.bind.levelList:clear()
    self.star = self.bind.rarity
    local data = {}
    for i = 1, self.star do
      table.insert(data, {})
    end
    self.bind.levelList:insert_array(data)
    local _, color = C_ColorUtility.TryParseHtmlString(self.data.geneColor[self.bind.rarity])
    self.bind.conditionIconColor = color
  else
    self.bind.empty = true
    self.bind.show_slot = false
  end
  self.bind.show_lockBg = self.bind.lock
end

function module:playMutationAnim(callBack)
  self.bindComponents.animRoot:Play("anim_pet_gene_change")
  Timer.once(0.2, function()
    L_AudioUtil.playSound("Play_SFX_System_HUD_General_Reward_Qibo_Mutation")
  end)
  if callBack ~= nil then
    self.callBackTimer = Timer.once(0.43, callBack, self, self.gameObject)
  end
end

function module:close()
  if self.callBackTimer ~= nil then
    Timer.remove(self.callBackTimer)
    self.callBackTimer = nil
  end
end

return module
