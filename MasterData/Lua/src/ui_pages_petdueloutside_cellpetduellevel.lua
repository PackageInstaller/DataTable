local cls = class("cellPetDuelLevel", G_UIModuleBase)
local dungeonGroupTpl = L_GameTpl:getDungeonGroupTpl()

function cls.bind()
  return {
    toggle_select = false,
    toggle_star1 = false,
    toggle_star2 = false,
    toggle_star3 = false,
    txt_difficulty = "",
    active_img_finish = false,
    active_img_lock = false
  }
end

function cls.methods()
  return {
    onClick_select = function(self)
      if not L_PetDuelStore:checkLevelUnlocked(self.levelId) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cellPetDuelLevel"))
        return
      end
      if self.levelId == self.selectLevelId then
        return
      end
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function cls:refresh()
  self.levelId = self.bind.levelId
  self.selectLevelId = self.bind.selectLevelId
  self:refreshView()
end

function cls:refreshView()
  self.bind.toggle_select = self.levelId == self.selectLevelId
  local starData = L_PetDuelStore:getKiBoDuelStar(self.levelId)
  for i = 1, 3 do
    if not starData[i] then
      self.bind["toggle_star" .. i] = true
    else
      self.bind["toggle_star" .. i] = false
    end
  end
  local dungeonGroupCfg = dungeonGroupTpl:getTplById(self.levelId)
  self.bind.txt_difficulty = dungeonGroupTpl:getDungeonGroupTag(dungeonGroupCfg)
  self.bind.active_img_finish = L_PetDuelStore:getIsSuccess(self.levelId)
  self.bind.active_img_lock = not L_PetDuelStore:checkLevelUnlocked(self.levelId)
end

return cls
