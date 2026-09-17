local cls = class("cellEntrustTaskReward", G_UIModuleBase)
local StarIconEnum = {
  [3] = "UI/Atlas/EntrustTask/tex_dungeonentrust_bg_ztap3.png",
  [2] = "UI/Atlas/EntrustTask/tex_dungeonentrust_bg_ztap2.png",
  [1] = "UI/Atlas/EntrustTask/tex_dungeonentrust_bg_ztap1.png"
}

function cls.bind()
  return {
    go_imgStar = false,
    img_star = "",
    module_cellIcon = L_Const.ModuleInfo.CellIconBag,
    active_img_receive = false
  }
end

function cls:refresh()
  self.modules.module_cellIcon:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNum = self.bind.num,
    itemNumTxt = self.bind.itemNumTxt
  })
  if not self.bind.starNum or self.bind.starNum < 1 then
    self.bind.go_imgStar = false
    return
  end
  self.bind.go_imgStar = true
  self.bind.img_star = StarIconEnum[self.bind.starNum]
end

function cls:setTaskRewardData(params)
  self.bind.itemType = params.itemType and params.itemType or 0
  self.bind.itemId = params.itemId and params.itemId or 0
  self.bind.num = params.itemNum and params.itemNum or 0
  self.bind.itemNumTxt = params.itemNumTxt
  self.bind.starNum = params.starNum and params.starNum or 0
  self.bind.active_img_receive = params.active_img_receive and true or false
  self:refresh()
end

return cls
