local this = class("cellProductAccessoryBig", require("ui.pages.product.cellProductAccessorySmall"))
local CellWidth = 432
this.CellWidth = CellWidth

function this.bind()
  return {
    img_icon = "",
    img_qualityBg = "",
    txt_id = "",
    txt_set = "",
    color_txt_set = C_Color(1, 1, 1, 1),
    color_point_rarity = C_Color(1, 1, 1, 1),
    active_txt_set = false,
    list_star = {},
    active_mask = false,
    active_lock = false,
    active_lock_icon = true,
    active_lock_txtDetail = true,
    txt_lockDetail = "",
    active_bg = true,
    pos_selfRect = C_Vector2.zero,
    active_selectCurr = false,
    active_canAddExp = false,
    active_cantAddExp = false,
    active_petGradeLimit = false,
    txt_petGradeLimit = "",
    active_taskNode = false,
    img_taskType = "",
    active_star = false,
    active_lineRowLock = false,
    active_lineRowUnLock = false,
    active_lineColLock = false,
    active_lineColUnLock = false,
    active_pointLockStar = false,
    active_purpleFlow = false,
    active_goldFlow = false
  }
end

function this:getQualityBgPrefix(qualityNum)
  return string.format("UI/Icon/ProductAccessory/tex_homeequipment_bg_item_0%s.png", qualityNum)
end

function this:UpdateQualityFlow(quality)
  self.bind.active_purpleFlow = quality == 3
  self.bind.active_goldFlow = quality == 4
end

function this.methods()
  return {
    onClickCell = function(self)
      self:clickProcess()
    end
  }
end

return this
