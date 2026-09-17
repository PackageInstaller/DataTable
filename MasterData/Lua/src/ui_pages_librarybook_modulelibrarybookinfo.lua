local this = class("moduleLibraryBookInfo", G_UIModuleBase)
local _librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()

function this.bind()
  return {
    txtBookGroupName = nil,
    txtCollected = nil,
    txtDesc = nil,
    listTab = nil,
    selectTab = nil,
    unCollected = false,
    moduleLibraryBookTags = {
      moduleName = "pages/libraryBook/cellLibraryTag"
    },
    img_item = nil,
    active_img = true,
    active_img_btnOn = false,
    active_img_btnOff = false,
    active_lock = false
  }
end

function this.methods()
  return {
    onClickClose = function(self)
      if self.collected then
        L_LibrarybookManager:showLibraryReadingPage(self.bookGroupId)
      end
    end
  }
end

function this:close()
  this.super.close(self)
  L_TimerManager:clearTimer(self)
end

function this:refreshDisplay(bookGroupId, isFirst)
  C_AudioManager.Play("Play_SFX_System_HUD_General_Item_Detail_Open")
  self.bookGroupId = bookGroupId
  self.curLibrarySeriesTpl = _librarySeriesTpl:getTplById(bookGroupId)
  if self.curLibrarySeriesTpl == nil then
    return
  end
  self.bindComponents.anim:Stop()
  if isFirst then
    L_TimerManager:newOrResetTimer(self, "openAnim", function()
      self.bindComponents.anim:Play("anim_Nbag_tips_in")
    end, 0.1)
  else
    self.bindComponents.anim:Play("anim_Nbag_tips_change")
  end
  self.bind.txtBookGroupName = _librarySeriesTpl:getName(self.curLibrarySeriesTpl)
  local totalNum = tostring(#self.curLibrarySeriesTpl.subId)
  local collectedNum = 0
  for k2, v2 in pairs(self.curLibrarySeriesTpl.subId) do
    for k3, v3 in pairs(L_LibraryBookStore.data.itemDic) do
      if v2 == v3.itemId then
        collectedNum = collectedNum + 1
        break
      end
    end
  end
  self.bind.txtCollected = tostring(collectedNum) .. "/" .. totalNum
  self.bind.txtDesc = _librarySeriesTpl:getDesc(self.curLibrarySeriesTpl)
  self.categoryList = self.curLibrarySeriesTpl.category
  self.bind.unCollected = collectedNum == 0
  self.collected = collectedNum ~= 0
  local collected = collectedNum ~= 0
  self.bind.active_img_btnOn = collected
  self.bind.active_img_btnOff = collected == false
  self.bind.active_lock = collected == false
  local tag = {}
  for i, v in ipairs(self.categoryList) do
    table.insert(tag, {tagId = v})
  end
  self.bind.moduleLibraryBookTags:clear()
  self.bind.moduleLibraryBookTags:insert_array(tag)
  if self.curLibrarySeriesTpl.icon ~= nil then
    self.bind.img_item = self.curLibrarySeriesTpl.icon
    self.bind.active_img = true
  else
    self.bind.active_img = false
  end
end

return this
