local this = class("pageKiboArenaInitPick", G_UIPageBase)

function this.bind()
  return {
    txt_countDown = nil,
    moduleCardSelf = {moduleName = ""},
    moduleEnemy = {moduleName = ""},
    petList = {
      moduleName = "pages/petDuel/arena/cellKiboArenaInitPickCard"
    },
    active = nil
  }
end

function this.methods()
  return {
    petList = {
      onClick = function(self, index, guid)
        self:onCardClick(index, guid)
      end
    },
    onClickConfirm = function(self)
      self:onClickConfirm()
    end
  }
end

function this:onClickConfirm()
  C_KiboArenaSystemMgr:FinishInitPick()
end

function this:preOpen()
  self.bind.active = false
  self.onEnterInitPickHandler = self.onEnterInitPickHandler or handler(self, self.onEnterInitPick)
  self.onFinishInitPickHandler = self.onFinishInitPickHandler or handler(self, self.onFinishInitPick)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.EnterInitPick, self.onEnterInitPickHandler)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.FinishInitPick, self.onFinishInitPickHandler)
  if C_KiboArenaSystemMgr:GetCurrentState() == CS.Lens.Gameplay.KiboArenaSystem.EKiboArenaSystemUIState.InitPick then
    self.bind.active = true
    self:initPetList()
  end
end

function this:close()
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.EnterInitPick, self.onEnterInitPickHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.FinishInitPick, self.onFinishInitPickHandler)
end

function this:onEnterInitPick(e, v)
  self.bind.active = true
  self:initPetList()
end

function this:onFinishInitPick(e, v)
  self.bind.active = false
  L_UI:close(self.pageName)
end

function this:initPetList()
  self.formationList = C_KiboArenaSystemMgr:GetCardList()
  self.petListData = {}
  for i = 0, self.formationList.Count - 1 do
    local data = self.formationList[i]
    table.insert(self.petListData, {
      isNext = false,
      guid = data.guid,
      petInfo = data,
      index = i + 1
    })
  end
  local petList = self.bind.petList
  petList:clear()
  petList:insert_array(self.petListData)
  if 0 < self.formationList.Count then
    local guid = self.formationList[0].guid
    self:onCardClick(1, guid)
    self.selectGuid = guid
  end
end

function this:onCardClick(index, guid)
  local petData = self.petListData[index]
  C_KiboArenaSystemMgr:SelectInitPet(guid)
  if petData ~= nil then
    for i, v in pairs(self.modules.petList) do
      v:refreshSelect(index)
    end
  end
end

return this
