local module = class("cellGeneNewSlot", G_UIModuleBase)
local petDna = L_GameTpl:getDnaTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    id = nil,
    guid = nil,
    disableColor = CS.UnityEngine.Color(0.5764705882352941, 0.5764705882352941, 0.5764705882352941),
    defaultColor = CS.UnityEngine.Color(1.0, 1.0, 1.0),
    selected_pos = L_Vector3.new(-35, 35, 0),
    link_length = {
      [1] = C_Vector2(266, 13),
      [2] = C_Vector2(202, 13),
      [3] = C_Vector2(57, 13),
      [4] = C_Vector2(111, 13),
      [5] = C_Vector2(243, 13),
      [6] = C_Vector2(307, 13)
    },
    linkDetail_length = {
      [1] = C_Vector2(283, 13),
      [2] = C_Vector2(218.5, 13),
      [3] = C_Vector2(85.7, 13),
      [4] = C_Vector2(137.6, 13),
      [5] = C_Vector2(279.1, 13),
      [6] = C_Vector2(307.4, 13)
    },
    geneColor = {
      [1] = "#e98b8b",
      [2] = "#799258",
      [3] = "#d6b16c",
      [4] = "#8fb4e3"
    },
    effectIcon = {
      [1] = "Pages/Pet/tex_pet_frame_reinforce_red",
      [2] = "Pages/Pet/tex_pet_frame_reinforce_green",
      [3] = "Pages/Pet/tex_pet_frame_reinforce_yellow",
      [4] = "Pages/Pet/tex_pet_frame_reinforce_blue",
      [5] = "Pages/Pet/tex_pet_frame_reinforce_multi"
    }
  }
end

function module.bind()
  return {
    icon_1 = "",
    icon_2 = "",
    bg_1 = "Pages/Pet/tex_pet_frame_onebg",
    bg_2 = "Pages/Pet/tex_pet_frame_twobg",
    gene_name = "",
    effect_icon = "",
    effectIcon_color = CS.UnityEngine.Color(1, 1, 1),
    selected = false,
    empty = true,
    emptyColor = CS.UnityEngine.Color(1, 1, 1),
    show_slot = false,
    lock = false,
    show_nameBg = false,
    group_1 = false,
    group_2 = false,
    alpha_link = false,
    alpha_linkIcon = "Pages/Pet/tex_pet_dec_line",
    showGlow = true,
    levelList_1 = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    levelList_2 = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    slot_tranform = L_Vector3.zero,
    link_width = C_Vector2(275, 13),
    detail_seleted = false
  }
end

function module.methods()
  return {
    onClick_Choose = function(self)
      self:emit("onClick_Choose", self.bind)
    end
  }
end

function module:open()
  self:refreshInfo()
end

function module:refresh()
  self:refreshInfo()
end

function module:refreshInfo()
  if self.bind.geneGuid and self.bind.geneGuid ~= 0 then
    local petDnaTpl = petDna:getTplById(self.bind.geneGuid)
    local size = petDna:getLength(petDnaTpl)
    self.bind.empty = false
    self.bind.show_slot = true
    self.bind.group_1 = size == 1 and true or false
    self.bind.group_2 = size == 2 and true or false
    local index = math.ceil(self.bind.pos / 2)
    self.bind["icon_" .. size] = petDna:getIconEffect(petDnaTpl)
    self:showFrameIconColor(size)
    self.bind["bg_" .. size] = L_PetStore:getGeneComponentIcon(size, self.bind.geneColor)
    local levelList = self.bind["levelList_" .. size]
    levelList:clear()
    if self.bind.geneLv and self.bind.geneLv ~= 0 then
      local data = {}
      for i = 1, self.bind.geneLv do
        table.insert(data, {
          starLv = self.bind.geneLv,
          rarity = self.bind.rarity
        })
      end
      levelList:insert_array(data)
    end
  else
    self.bind.empty = true
    self.bind.show_slot = false
  end
  self.bind.showGlow = self.bind.lock ~= true and self.bind.linkStatus == 1 and self.bind.empty ~= true and self.bind.enable == true and true or false
  self.bindComponents.slotTrans.localPosition = self.bind.selected == true and self.data.selected_pos or L_Vector3.zero
  self.bindComponents.groupColor.color = (self.bind.lock == true or self.bind.enable == false) and self.data.disableColor or self.data.defaultColor
  local _, emptyColor = C_ColorUtility.TryParseHtmlString("#ced1d1")
  local _, color = C_ColorUtility.TryParseHtmlString("#ffffff")
  self.bind.emptyColor = self.bind.enable == true and color or emptyColor
end

function module:link_horizontal(linkColor)
  if self.bind.geneGuid and self.bind.geneGuid ~= 0 then
    local petDnaTpl = petDna:getTplById(self.bind.geneGuid)
    local size = petDna:getLength(petDnaTpl)
    self.bind["bg_" .. size] = L_PetStore:getGeneComponentIcon(size, self.bind.geneColor)
    if self.bind.alpha_link then
      local icon
      if linkColor ~= nil then
        icon = L_PetStore:getGeneComponentIcon(3, linkColor)
      else
        icon = L_PetStore:getGeneComponentIcon(3, self.bind.geneColor)
      end
      self.bind.alpha_linkIcon = icon
    end
  end
end

function module:disableHorizontalLink()
  if self.bind.geneGuid and self.bind.geneGuid ~= 0 and self.bind.alpha_link == true then
    self.bind.alpha_link = false
  end
end

function module:setHorizontalLinkLength(show_detail)
  if self.bind.geneGuid and self.bind.geneGuid ~= 0 then
    self.bind.alpha_link = self.bind.gridSize == 2 and self.bind.selected == false and true or false
    if self.bind.alpha_link == true then
      local index = math.ceil(self.bind.pos / 2)
      self.bind.link_width = show_detail == true and self.data.linkDetail_length[index] or self.data.link_length[index]
    end
  end
end

function module:showFrameIconColor()
  if self.bind.geneGuid and self.bind.geneGuid ~= 0 then
    local petDnaTpl = petDna:getTplById(self.bind.geneGuid)
    self.bind.effect_icon = petDna:getIconFrame(petDnaTpl)
  end
end

function module:close()
end

function module:getPosition()
  return self.bindComponents.geneItemTrans.position
end

return module
