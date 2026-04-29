_class("UIN28AVGNodeDetails", UIController)
UIN28AVGNodeDetails = UIN28AVGNodeDetails

function UIN28AVGNodeDetails:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function UIN28AVGNodeDetails:OnShow(uiParams)
  self.imgCG = self:GetUIComponent("RawImageLoader", "imgCG")
  self.recordTime = self:GetGameObject("recordTime")
  self.txtTime = self:GetUIComponent("UILocalizationText", "txtTime")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtName1 = self:GetUIComponent("UILocalizationText", "txtName1")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  local poolLeader = self:GetUIComponent("UISelectObjectPath", "leader")
  self.leader = poolLeader:SpawnObject("UIN28AVGActor")
  self.poolPartners = self:GetUIComponent("UISelectObjectPath", "partners")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.nodeId = uiParams[1]
  self:Flush()
end

function UIN28AVGNodeDetails:OnHide()
  self.imgCG:DestoryLastImage()
end

function UIN28AVGNodeDetails:Flush()
  self.node = self.data:GetNodeById(self.nodeId)
  local state = self.node:State()
  if state == N28AVGStoryNodeState.Complete then
    self.imgCG:LoadImage(self.node.cg)
  elseif string.isnullorempty(self.node.cgCanPlay) then
    self.imgCG:LoadImage(self.node.cg)
  else
    self.imgCG:LoadImage(self.node.cgCanPlay)
  end
  self:FlushTime()
  self.txtName:SetText(self.node.title)
  self.txtName1:SetText(self.node.title)
  self.txtDesc:SetText(self.node.desc)
  self:FlushActors()
end

function UIN28AVGNodeDetails:FlushTime()
  local ts = self.node:GetSaveTimestamp()
  if 0 < ts then
    self.recordTime:SetActive(true)
    local str = self.data:Timestamp2Str(ts)
    self.txtTime:SetText(str)
  else
    self.recordTime:SetActive(false)
  end
end

function UIN28AVGNodeDetails:FlushActors()
  local hp, strategies = self.node:StartData()
  self.leader:Flush(0, hp)
  local len = table.count(self.data.actorPartners)
  self.poolPartners:SpawnObjects("UIN28AVGActor", len)
  local uis = self.poolPartners:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Flush(i, strategies[i] or 0)
  end
end

function UIN28AVGNodeDetails:BgOnClick(go)
  self:CloseDialog()
end

function UIN28AVGNodeDetails:BtnCloseOnClick(go)
  self.anim:Play("uieff_UIN28AVGNodeDetails_out")
  self:Lock("UIN28AVGNodeDetails_Close")
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 233)
    self:UnLock("UIN28AVGNodeDetails_Close")
    self:CloseDialog()
  end, self)
end

function UIN28AVGNodeDetails:BtnStartOnClick(go)
  if GameGlobal.UIStateManager():IsShow("UIN28AVGStory") then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_avg_n28_give_up_cur_node_progress_2_start_this_node"), function()
      self:CloseDialog()
      if GameGlobal.UIStateManager():IsShow("UIN28AVGGraph") then
        GameGlobal.UIStateManager():CloseDialog("UIN28AVGGraph")
      end
      if GameGlobal.UIStateManager():IsShow("UIN28AVGEnding") then
        GameGlobal.UIStateManager():CloseDialog("UIN28AVGEnding")
      end
      GameGlobal.UIStateManager():CallUIMethod("UIN28AVGStory", "PlayFromBegain", self.nodeId)
    end)
  else
    self:SwitchState(UIStateType.UIN28AVGStory, self.nodeId)
  end
end
