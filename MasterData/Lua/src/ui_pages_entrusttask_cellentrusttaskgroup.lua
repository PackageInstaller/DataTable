local cls = class("cellEntrustTaskGroup", G_UIModuleBase)
local _dungeonEntrustGroupTpl = L_GameTpl:getDungeonEntrustGroupTpl()

function cls.bind()
  return {
    txt_title = "",
    img_banner = "",
    go_empty = false,
    go_listTask = false,
    list_task = {
      moduleName = "pages/entrustTask/cellEntrustTask"
    },
    scale_arrow = C_Vector3.zero
  }
end

function cls.methods()
  return {
    onClick_Folder = function(self)
      if self.bind.cbk then
        self.bind.cbk(self)
      end
    end
  }
end

function cls:open()
  L_EntrustStore:listenCallFunc(L_EntrustStore.event.entrustTaskGroupFolder, self.onEvent_entrustTaskGroupFolder, self)
end

function cls:refresh()
  local dungeonEntrustGroupCfg = _dungeonEntrustGroupTpl:getTplById(self.bind.groupId)
  self.bind.txt_title = _dungeonEntrustGroupTpl:getName(dungeonEntrustGroupCfg)
  self.bind.img_banner = _dungeonEntrustGroupTpl:getBanner(dungeonEntrustGroupCfg)
  self.bind.scale_arrow = self.bind.bFold and C_Vector3(1, -1, 1) or C_Vector3.one
  self:setFolder(self.bind.bFold)
  self:refreshTaskList()
end

function cls:refreshTaskList()
  local function onClick_select(cell)
    local bUnlock = L_EntrustStore:checkEntrustLevelUnlock(cell.bind.levelId)
    
    if not bUnlock then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cellPetDuelLevel"))
      return
    end
    L_EntrustStore:call(L_EntrustStore.event.entrustLevelSelect, cell.bind.levelId)
  end
  
  local info = {}
  for _, v in ipairs(self.bind.levelInfos) do
    table.insert(info, {
      levelId = v.id,
      cbk = onClick_select,
      selectEntrustTaskId = self.bind.selectEntrustTaskId,
      isTaskTarget = v.isTaskTarget,
      taskType = v.taskType,
      need_show_lock_bg = v.need_show_lock_bg,
      lock_bg_length = v.lock_bg_length
    })
  end
  self.bind.list_task:clear()
  self.bind.list_task:insert_array(info)
  self:refreshHight(self.bind.bFold)
end

function cls:refreshHight(bfold)
  local finalHight = 232 + 88 * (#self.bind.levelInfos - 1)
  if self.isBind and self.bindComponents and self.bindComponents.layOut_cellEntrustTaskGroup then
    if not bfold then
      self.bindComponents.layOut_cellEntrustTaskGroup.preferredHeight = finalHight
      self.bindComponents.layOut_cellEntrustTaskGroup.minHeight = finalHight
    else
      self.bindComponents.layOut_cellEntrustTaskGroup.preferredHeight = 104
      self.bindComponents.layOut_cellEntrustTaskGroup.minHeight = 104
    end
  end
end

function cls:setFolder(bFold)
  self.bind.bFold = bFold
  self.bind.go_listTask = not bFold
  self.bind.go_empty = bFold
  self.bind.scale_arrow = bFold and C_Vector3(1, -1, 1) or C_Vector3.one
  self:refreshHight(bFold)
end

function cls:onEvent_entrustTaskGroupFolder(taskGroupId, bFolder)
  if taskGroupId ~= self.bind.groupId then
    return
  end
  self:setFolder(bFolder)
  if not bFolder then
    self.bindComponents.list_taskAnim:Play()
  end
end

function cls:getChildItem(index)
  return self.bind.list_task:getItemCls(index)
end

function cls:close(options)
  cls.super.close(self, options)
  L_EntrustStore:unListenCallFunc(L_EntrustStore.event.entrustTaskGroupFolder, self.onEvent_entrustTaskGroupFolder, self)
end

return cls
