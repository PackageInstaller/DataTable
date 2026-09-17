local module = class("cellStationTabItemVertical", G_UIModuleBase)
local offTabImgPath = {
  [1001] = "UI/Atlas/HomeCrop/tex_homepetdispatch_btn_tab1_0.png",
  [1002] = "UI/Atlas/HomeCrop/tex_homepetdispatch_btn_tab2_0.png",
  [1003] = "UI/Atlas/HomeCrop/tex_homepetdispatch_btn_tab3_0.png"
}
local onTabImgPath = {
  [1001] = "UI/Atlas/HomeCrop/tex_homepetdispatch_btn_tab1_1.png",
  [1002] = "UI/Atlas/HomeCrop/tex_homepetdispatch_btn_tab2_1.png",
  [1003] = "UI/Atlas/HomeCrop/tex_homepetdispatch_btn_tab3_1.png"
}

function module.bind()
  return {
    img_onTab = "",
    img_offTab = "",
    txt_offName = "",
    txt_onName = "",
    module_petFrameIcon = {
      moduleName = "pages/pet/modulePetFrameIcon"
    },
    tabId = -1,
    active_nextLine = false
  }
end

function module.methods()
  return {}
end

function module:open()
  self.bind.img_onTab = onTabImgPath[self.bind.id]
  self.bind.img_offTab = offTabImgPath[self.bind.id]
  if self.bind.id == 1001 then
    self.bind.txt_offName = L_WordsTpl:getValue("residual_code_cellstationtabitemvertical_01")
    self.bind.txt_onName = L_WordsTpl:getValue("residual_code_cellstationtabitemvertical_01")
  elseif self.bind.id == 1002 then
    self.bind.txt_offName = L_WordsTpl:getValue("residual_code_cellstationtabitemvertical_03")
    self.bind.txt_onName = L_WordsTpl:getValue("residual_code_cellstationtabitemvertical_03")
  elseif self.bind.id == 1003 then
    self.bind.txt_offName = L_WordsTpl:getValue("residual_code_cellstationtabitemvertical_05")
    self.bind.txt_onName = L_WordsTpl:getValue("residual_code_cellstationtabitemvertical_05")
  end
  self.bind.tabId = self.bind.id
  self.bind.active_nextLine = not self.bind.isLast
  if self.bind.guid then
    self.modules.module_petFrameIcon:setGuid(self.bind.guid, true)
  end
  if not string.isEmpty(self.bind.redKey) and self.bindComponents.transRed then
    L_ReddotManager:registerReddot(self.bindComponents.transRed, self.bind.redKey)
  end
end

return module
