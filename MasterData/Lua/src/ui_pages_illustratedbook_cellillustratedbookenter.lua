local this = class("cellIllustratedbookEnter", G_UIModuleBase)
local _illustratedbookTpl = L_GameTpl:getIllustratedhandbookMainTpl()
local PATH_IMG_BG = "UI/Texture/Illustratedbook_main/illustrated_book_0%s.png"
local PATH_IMG_ITEM = "UI/Atlas/Illustrationbook_main/illustrated_book_icon_0%s.png"
local PATH_IMG_BOTTOM = "UI/Texture/Illustratedbook_main/illustratedbook_readings_bg_shuji0%s.png"
local PATH_IMG_BOTTOM_LOCK = "UI/Texture/Illustratedbook_main/tex_icon_enter_bottom_lock.png"
local idToRedDotMap = {
  [1] = L_ReddotManager.DotDef.HandBook_Character_New,
  [2] = L_ReddotManager.DotDef.IllustratedSoulEssence_Enter
}

function this.bind()
  return {
    img_bg = "",
    img_item = "",
    txt_name = "",
    txt_customName = "",
    img_bottom = "",
    active_infos = true,
    active_lock = false,
    color_txtName = nil,
    color_txtC = nil,
    color_item = nil,
    txt_progressRate = "",
    color_progressRate = nil
  }
end

function this.methods()
  return {
    onClick = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Gallery_Tab_Click")
      self:emit("onClick", self.bind.enterTpl)
    end,
    onEnter = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Gallery_Tab_Glance")
    end
  }
end

function this:open()
  self:refreshView()
  local redDotKey = idToRedDotMap[self.bind.enterTpl.sortID]
  if redDotKey ~= nil then
    L_ReddotManager:registerReddot(self.bindComponents.reddotNew, redDotKey)
  else
    self.bindComponents.reddotNew.gameObject:SetActive(false)
  end
end

function this:refreshView()
  local tpl = self.bind.enterTpl
  if tpl.isLock == 0 then
    self.bind.txt_name = L_WordsTpl:getValue("residual_code_cellillustratedbookenter_01")
    self.bind.active_infos = false
    self.bind.active_lock = true
    self.bind.img_bottom = PATH_IMG_BOTTOM_LOCK
  else
    self.bind.active_infos = true
    self.bind.active_lock = false
    self.bind.txt_name = _illustratedbookTpl:getName(tpl)
    local resourPath = _illustratedbookTpl:getImg_bg(tpl)
    self.bind.img_item = string.format(PATH_IMG_ITEM, resourPath)
    self.bind.customName = _illustratedbookTpl:getTxt_cst(tpl)
    self.bind.img_bottom = string.format(PATH_IMG_BOTTOM, resourPath)
    local _, color = C_ColorUtility.TryParseHtmlString(tpl.color)
    self.bind.color_txtName = color
    self.bind.color_txtC = color
    self.bind.color_item = color
    self.bind.color_progressRate = color
    self.bind.img_bg = string.format("UI/Texture/Illustratedbook_main/illustrated_book_0%s.png", resourPath)
    local collectedNum = 0
    local totalNum = 0
    if self.bind.enterTpl.areaId == 4 then
      collectedNum, totalNum = L_LibraryBookStore:getTotalCollectProcess()
    end
    if totalNum == 0 then
      self.bind.txt_progressRate = ""
    else
      self.bind.txt_progressRate = string.format("%d/%d", collectedNum, totalNum)
    end
  end
end

return this
