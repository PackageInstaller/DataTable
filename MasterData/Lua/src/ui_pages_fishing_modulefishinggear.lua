local this = class("moduleFishingGear", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _fishRodTpl = L_GameTpl:getFishRodTpl()
local _fishBaitTpl = L_GameTpl:getFishBaitTpl()

function this.bind()
  return {
    go_rod_normal = false,
    go_rod_empty = false,
    go_bait_normal = false,
    go_bait_empty = false,
    img_rod = nil,
    txt_rodName = "",
    img_bait = nil,
    txt_baitName = "",
    txt_baitNum = ""
  }
end

function this.methods()
  return {
    onClick_replaceRod = function(self)
      L_FishingManager:replaceRod(self._pondId)
    end,
    onClick_replaceBait = function(self)
      L_FishingManager:replaceBait(self._pondId)
    end
  }
end

function this:open(options)
  this.super.open(self, options)
  L_FishingStore:listenCallFunc(L_FishingStore.event.refreshFishingGear, self.onEvent_refreshFishingGear, self)
  self.onEvent_refreshFishingGearHandle = handler(self, self.onEvent_refreshFishingGear)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_refreshFishingGearHandle)
end

function this:close(options)
  this.super.close(self, options)
  L_FishingStore:unListenCallFunc(L_FishingStore.event.refreshFishingGear, self.onEvent_refreshFishingGear)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_refreshFishingGearHandle)
end

function this:initModule(pondId)
  self._pondId = pondId
  self:initRodAndBait()
end

function this:initRodAndBait()
  if not math.isEmpty(L_FishingStore:getCurRodId()) and self._curRodId ~= L_FishingStore:getCurRodId() then
    self.bindComponents.ani_img_rod:Stop()
    self.bindComponents.ani_img_rod:Play("anim_fishing_changeitem")
  end
  if not math.isEmpty(L_FishingStore:getCurBaitId()) and self._curBaitId ~= L_FishingStore:getCurBaitId() then
    self.bindComponents.ani_img_bait:Stop()
    self.bindComponents.ani_img_bait:Play("anim_fishing_changeitem")
  end
  self._curRodId = L_FishingStore:getCurRodId()
  self._curBaitId = L_FishingStore:getCurBaitId()
  if math.isEmpty(self._curRodId) then
    self.bind.go_rod_normal = false
    self.bind.go_rod_empty = true
    self.bind.txt_rodName = ""
  else
    self.bind.go_rod_normal = true
    self.bind.go_rod_empty = false
    local tpl_commonItem = _commonItemTpl:getTplById(self._curRodId)
    local tpl_rod = _fishRodTpl:getTplById(_commonItemTpl:getSubId(tpl_commonItem))
    self.bind.txt_rodName = _commonItemTpl:getName(tpl_commonItem)
    self.bind.img_rod = _fishRodTpl:getIcon(tpl_rod)
  end
  if math.isEmpty(self._curBaitId) or not math.isEmpty(self._curBaitId) and C_BagMgr:getItemNumByItemId(self._curBaitId) <= 0 then
    self.bind.go_bait_normal = false
    self.bind.go_bait_empty = true
    self.bind.txt_baitName = ""
  else
    self.bind.go_bait_normal = true
    self.bind.go_bait_empty = false
    local tpl_commonItem = _commonItemTpl:getTplById(self._curBaitId)
    local tpl_bait = _fishBaitTpl:getTplById(_commonItemTpl:getSubId(tpl_commonItem))
    self.bind.txt_baitName = _commonItemTpl:getName(tpl_commonItem)
    self.bind.img_bait = _fishBaitTpl:getIconMain(tpl_bait)
    local baitNum = C_BagMgr:getItemNumByItemId(self._curBaitId)
    self.bind.txt_baitNum = string.format("X%s", 999 < baitNum and "999+" or tostring(baitNum))
  end
end

function this:onEvent_refreshFishingGear()
  self:initRodAndBait()
end

return this
