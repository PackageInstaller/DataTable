_class("UIXiaoLinJiaQuestionDBController", UIController)
UIXiaoLinJiaQuestionDBController = UIXiaoLinJiaQuestionDBController

function UIXiaoLinJiaQuestionDBController:OnShow(uiParams)
  self.content = self:GetUIComponent("UISelectObjectPath", "content")
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.missionID = uiParams[1]
  self.record = uiParams[2]
  self:OnValue()
end

function UIXiaoLinJiaQuestionDBController:OnValue()
  local cfg = Cfg.cfg_xiaolinjia_mission({
    ID = self.missionID
  })
  if cfg then
    self.missionCfg = cfg[1]
  else
    Log.exception("story cfg is nil", self.missionID)
  end
  local storyName = self.missionCfg.StoryCfgName
  local sessionCfg = Cfg[storyName]({})
  local dialogList = {}
  for _, v in pairs(sessionCfg) do
    dialogList[v.ID] = v
  end
  self.sessionList = {}
  local sessionID = 1
  while true do
    local session = dialogList[sessionID]
    if not session then
      break
    end
    if session.Options then
      table.insert(self.sessionList, session)
    end
    sessionID = sessionID + 1
  end
  local roleName = StringTable.Get(self.missionCfg.RoleName)
  self.title:SetText(StringTable.Get("str_xiaolinjia_text_qa_1", roleName))
  self.content:SpawnObjects("UIXiaoLinJiaQuestionDBItem", #self.sessionList)
  local pool = self.content:GetAllSpawnList()
  for index, v in pairs(self.sessionList) do
    local session = self.sessionList[index]
    pool[index]:SetData(session, session.Answer, self.missionCfg.ClosingHeadIcon, self.record[index] ~= nil)
  end
end

function UIXiaoLinJiaQuestionDBController:CloseBtnOnClick()
  self:Lock("UIXiaoLinJiaQuestionDBController_Close")
  self.anim:Play("uieffanim_UIXiaoLinJiaQuestionDBController_out")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:CloseDialog()
    self:UnLock("UIXiaoLinJiaQuestionDBController_Close")
  end)
end
