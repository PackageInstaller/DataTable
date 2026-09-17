local this = class("cellBattleType", G_UIModuleBase)
local battleTagTpl = L_GameTpl:getBattleTagTpl()

function this.bind()
  return {
    tagColor = C_Color.white,
    tagName = "",
    lineColor = C_Color.white,
    lineEndColor = C_Color.white,
    des = ""
  }
end

function this.methods()
  return {}
end

function this:refresh()
  local tagTpl = battleTagTpl:getTplById(self.bind.tagId)
  local _, color = C_ColorUtility.TryParseHtmlString(battleTagTpl:getColor(tagTpl))
  self.bind.tagColor = color
  self.bind.lineColor = color
  self.bind.lineEndColor = color
  self.bind.tagName = battleTagTpl:getTitle(tagTpl)
  self.bind.des = battleTagTpl:getDesc(tagTpl)
end

return this
