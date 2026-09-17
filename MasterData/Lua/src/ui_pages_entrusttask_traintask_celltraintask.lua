local this = class("cellTrainTask", G_UIModuleBase)
local _trainTaskTpl = L_GameTpl:getTrainTaskTpl()

function this:ctor()
  self.maskHeightNum = 1
end

function this.bind()
  return {
    txt_name = "",
    go_lock = false,
    go_select = false,
    go_completed = false,
    go_lockInfo = false,
    txt_lockInfo = "",
    go_lockMask = true,
    txt_completed = L_WordsTpl:getValue("residual_code_celltraintask_01")
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      if self.lock then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cellPetDuelLevel"))
      else
        self:emit("onClick_select", self.bind)
      end
    end
  }
end

function this:open()
  if not self.isBind then
    return
  end
  self:initCell()
  local id = self.bind.taskId
  L_ReddotManager:registerReddot(self.bindComponents.reddotNew, string.format(L_ReddotManager.DotDef.EntrustTrain, id))
  self.bindComponents.reddotNew.gameObject:SetActive(not L_ReddotManager:haveNew(L_ReddotManager.DotDef.EntrustTrain, self.bind.taskId) and not self.lock)
end

function this:initCell()
  local tpl_task = _trainTaskTpl:getTplById(self.bind.taskId)
  self.lock = not L_ConditionManager:isComplete(_trainTaskTpl:getUnlockCondition(tpl_task))
  self.bind.go_lock = self.lock
  self.bind.go_lockInfo = self.lock
  if self.lock then
    self.bind.txt_lockInfo = L_ConditionManager:getSingleDesc(_trainTaskTpl:getUnlockCondition(tpl_task)[1])
    self.bindComponents.unlockMask.sizeDelta = L_Vector3.new(self.bindComponents.unlockMask.sizeDelta.x, 90 * self.maskHeightNum)
  end
  self.bind.txt_name = _trainTaskTpl:getTaskName(tpl_task)
  self.bind.txt_completed = _trainTaskTpl:getTaskName(tpl_task)
  local str = L_WordsTpl:getValue("dungeon_entrust_pass")
  if str then
    self.bind.txt_completed = str
  end
  self.bind.go_completed = L_EntrustStore:getIsTrainTaskCompleted(self.bind.taskId)
end

function this:adjustLockMaskHeight(num)
  self.bind.go_lockMask = true
  self.maskHeightNum = num
end

function this:hideMask()
  self.maskHeightNum = 1
  self.bind.go_lockMask = false
end

function this:setSelect(select)
  if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.EntrustTrain, self.bind.taskId) and select then
    L_ReddotManager:markNew(L_ReddotManager.DotDef.EntrustTrain, self.bind.taskId)
    if self.bindComponents then
      self.bindComponents.reddotNew.gameObject:SetActive(false)
    end
  end
  self.bind.go_select = select
end

return this
