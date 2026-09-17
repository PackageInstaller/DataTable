local cls = class("cellEntrustTaskCondition", G_UIModuleBase)
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
local IMG_NOF = "Assets/ResourcesAssets/UI/Texture/EntrustTask/tex_dungeonentrust_bg_z04.png"
local IMG_FINISH = "Assets/ResourcesAssets/UI/Texture/EntrustTask/tex_dungeonentrust_bg_z09.png"

function cls.bind()
  return {
    toggle_finish = false,
    txt_condition = "",
    color_txtCondition = C_Color.white,
    img_reward = "",
    txt_itemNum = "X0",
    color_itemNum = C_Color.white,
    img_bgFinish = "",
    go_bg = false,
    go_line = false,
    go_bgRewardFinishImg = false,
    go_reward = false
  }
end

function cls:refresh()
  self.bind.toggle_finish = self.bind.bFinish
  self.bind.go_bgRewardFinishImg = self.bind.bFinish
  self.bind.img_bgFinish = self.bind.bFinish and IMG_FINISH or IMG_NOF
  self.bind.go_bg = self.bind.bFinish and true or false
  self.bind.go_line = not self.bind.bFinish
  if self.bind.bFinish then
    local _, color = C_ColorUtility.TryParseHtmlString("#d87500")
    self.bind.color_txtCondition = color
    self.bind.color_itemNum = color
  else
    local _, color = C_ColorUtility.TryParseHtmlString("#5f5952")
    self.bind.color_txtCondition = color
    self.bind.color_itemNum = color
  end
end

function cls:setTaskConditionData(params)
  self.bind.txt_condition = params.txt_condition and params.txt_condition or ""
  self.bind.bFinish = params.bFinish and true or false
  self.bind.go_reward = params.go_reward and true or false
  self.bind.img_reward = params.img_reward and params.img_reward or ""
  self.bind.txt_itemNum = params.txt_itemNum and "X" .. params.txt_itemNum or ""
  self:refresh()
end

return cls
