local this = class("cellDungeonDescCard", G_UIModuleBase)
local CARD_SPACING = 500

function this.bind()
  return {
    img_icon = nil,
    color_iconAlpha = nil,
    text_dungeonName = "",
    text_dungeonNameDecoration = "",
    toggle_chooseItem = false
  }
end

function this.methods()
  return {
    onClick_dungeonDescCard = function(self)
      self:onClickDungeonDescCard()
    end
  }
end

function this:initParent(parent)
  self.parent = parent
end

function this:refreshUI(isChoose)
  local colorKey = isChoose and L_Const.colorHtml.blue015 or "#FFFFFFCC"
  self.bind.color_iconAlpha = isChoose and C_Color(1, 1, 1, 1) or C_Color(1, 1, 1, 0.8)
  self.bind.text_dungeonName = L_GameUtil.fillColor(self.bind.doorName, colorKey)
  self.bind.text_dungeonNameDecoration = L_GameUtil.fillColor("YINGGAI MEIYOU CHANGGUAN", colorKey)
  self.bind.toggle_chooseItem = isChoose
end

function this:onClickDungeonDescCard()
  self.parent:onClickDungeonDescCard(self.bind.doorId)
end

function this:getDoorId()
  return self.bind.doorId
end

return this
