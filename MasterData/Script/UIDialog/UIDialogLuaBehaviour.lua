local View = require("UIDialog/UIDialogView")
local ViewFunction = require("UIDialog/UIDialogViewFunction")
local Controller = require("UIDialog/Model_PlotController")
local DataModel = require("UIDialog/UIDialogDataModel")
local PlotReviewDataModel = require("UIPlotReview/UIPlotReviewDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.Ca = {}
    DataModel.finishLogOut = nil
    DataModel.duration = 0
    DataModel.plotBuildingId = -1
    DataModel.cityMapRedRecord = nil
    DataModel.ClosePanel = true
    DataModel.isReview = next(DataModel.ReviewList) ~= nil
    local label
    if initParams ~= nil then
      local data = Json.decode(initParams)
      if data.activityId then
        DataModel.activityId = data.activityId
      end
      local id
      if type(data) == "table" then
        id = data.id
        label = data.label
        DataModel.plotBuildingId = data.plotBuildingId or -1
        DataModel.cityMapRedRecord = data.cityMapRedRecord
        DataModel.finishLogOut = data.finishLogOut
      else
        id = data
        label = nil
      end
      local paCa = PlayerData:GetFactoryData(id, "ParagraphFactory")
      local isUploadingServe = paCa.isUploadingServe
      DataModel.UploadingParagraphId = -1
      if isUploadingServe then
        for k, v in pairs(PlayerData.plot_paragraph) do
          if v == id then
            isUploadingServe = false
            break
          end
        end
        if isUploadingServe then
          DataModel.UploadingParagraphId = id
        end
      end
      DataModel.CurrentParagraphId = id
      local plotList = {}
      if paCa.mod == "\230\174\181\232\144\189\232\132\154\230\156\172" then
        local info
        local isMale = PlayerData.IsMale()
        local path
        if paCa.girlPath ~= nil and paCa.girlPath ~= "" then
          path = isMale and paCa.path or paCa.girlPath
        else
          path = paCa.path
        end
        if label ~= nil and label ~= "" then
          info = ParseParagraphScript():Parse(path, label)
        else
          local pattern
          if paCa.girlPattern ~= nil and paCa.girlPattern ~= "" then
            pattern = isMale and paCa.pattern or paCa.girlPattern
          else
            pattern = paCa.pattern
          end
          info = ParseParagraphScript():Parse(path, pattern)
        end
        if info ~= nil then
          for k, v in pairs(info.plotBaseCAs) do
            plotList[k] = v
          end
        else
          PlotManager:SetPlotStatus(true)
          UIManager:GoBack(false)
          return
        end
      elseif paCa.mod == "\230\174\181\232\144\189" then
        local curPlotList
        if paCa.plotListGril ~= nil and 0 < #paCa.plotListGril then
          curPlotList = PlayerData.IsMale() and paCa.plotList or paCa.plotListGril
        else
          curPlotList = paCa.plotList
        end
        for k, v in pairs(curPlotList) do
          plotList[k] = PlayerData:GetFactoryData(v.plotID, "PlotFactory")
        end
      end
      DataModel.Ca = paCa
      DataModel.duration = TimeUtil:GetServerTimeStamp()
      DataModel.plotList = plotList
      DataModel:InitAutoBtn()
      Controller.Init()
      ReportTrackEvent.Story_play(1, tonumber(paCa.id), paCa.idCN, -1, 1, 511001, 0)
    end
    DataModel.InitPlotPosData()
    DataModel.InitPaintData()
    DataModel.isTrue = false
    View.Group_Tips.Group_Tip.Btn_Tip.Group_On.self:SetActive(false)
    if DataModel.Ca.hideEnvCamera ~= true then
      return
    end
    if MainManager.bgSceneName == "Battle" then
      local cameraManager = CBus:GetManager(CS.ManagerName.CameraManager)
      cameraManager.MainCamera.gameObject:SetActive(false)
    else
      TrainCameraManager:OpenCamera(-1)
    end
    TrainCameraManager:SetCameraLock(true)
    View.Btn_TimeLine:SetActive(false)
    local AutoChapterState = PlotReviewDataModel.GetAutoChapterState()
    local showAutoChapter = DataModel.isReview and AutoChapterState
    View.Group_Tips.Group_Play:SetActive(showAutoChapter)
    View.Btn_PlayIcon:SetActive(DataModel.isReview)
    Controller.FreshAutoChapterBtn()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    Controller.Update()
  end,
  ondestroy = function()
    if DataModel.activityId then
      local isJion = PlayerData.ServerData.all_activities.ing[tostring(DataModel.activityId)]
      if not isJion then
        Net:SendProto("main.participate", function(jsons)
          if jsons.activity then
            PlayerData.ServerData.all_activities.ing[tostring(DataModel.activityId)] = jsons.activity
          end
        end, DataModel.activityId)
      end
    end
    if Controller:IsFinish() then
      if DataModel.Ca ~= nil and DataModel.Ca.completeQuest ~= nil and DataModel.Ca.completeQuest > 0 then
        local questId = DataModel.Ca.completeQuest
        local findKey = ""
        local quests = PlayerData.ServerData.quests
        for k, v in pairs(quests) do
          if v ~= nil and v[tostring(questId)] ~= nil then
            findKey = k
            break
          end
        end
        if findKey ~= "" and not next(DataModel.ReviewList) then
          do
            local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
            local serverQuest = PlayerData.ServerData.quests[findKey][tostring(questId)]
            if serverQuest ~= nil and not (0 < serverQuest.recv) then
              Net:SendProto("quest.recv_rewards", function(json)
                PlayerData.ServerData.quests[findKey][tostring(questId)] = nil
                if json.current_quests ~= nil then
                  for k, v in pairs(json.current_quests) do
                    questCA = PlayerData:GetFactoryData(k, "QuestFactory")
                    local serverKey = ""
                    if questCA.questType == "Main" then
                      serverKey = "mq_quests"
                    elseif questCA.questType == "Side" then
                      serverKey = "branch_quests"
                    end
                    if serverKey ~= "" then
                      PlayerData.ServerData.quests[serverKey][k] = v
                    end
                    if v.recv == 0 and v.unlock == 1 then
                      QuestTrace.AcceptQuest(k)
                    end
                  end
                end
                GuideManager:CompleteQuestCallBack({
                  [1] = questId
                })
                QuestTrace.CompleteQuestOne(questId)
                PlayerData.TempCache.AutoCompleteLevelsServerReward = json.reward
                CommonTips.OpenQuestsCompleteTip({
                  [1] = questId
                })
              end, questId)
            end
          end
        end
      end
      if DataModel.plotBuildingId > 0 then
        Net:SendProto("building.plot", function()
        end, DataModel.plotBuildingId)
      end
      if PlayerData.TempCache.TrailerFinishCb then
        PlayerData.TempCache.TrailerFinishCb()
        PlayerData.TempCache.TrailerFinishCb = nil
      end
      if DataModel.cityMapRedRecord then
        PlayerData:SetPlayerPrefs("int", "Dialog" .. DataModel.CurrentParagraphId, 1)
      end
      if DataModel.Ca.hideEnvCamera ~= true then
        return
      end
      TrainCameraManager:SetCameraLock(false)
      if MainManager.bgSceneName == "Battle" then
        local cameraManager = CBus:GetManager(CS.ManagerName.CameraManager)
        cameraManager.MainCamera.gameObject:SetActive(true)
      elseif MainManager.bgSceneName == "Main" then
        local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
        if not TradeDataModel.GetInTravel() then
          if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
            PlayerData.TempCache.MainUIOpenCamera = true
            TrainCameraManager:OpenCamera(1)
          end
        else
          TrainCameraManager:OpenCamera(0)
          local camera = TrainCameraManager:GetCamera(0)
          if camera ~= nil then
            do
              local far = camera.farClipPlane
              DOTweenTools.DoTweenFloatTO(function()
                return 1
              end, function(tempFar)
                camera.farClipPlane = tempFar
              end, far, 3)
            end
          end
        end
      else
        TrainCameraManager:OpenCamera(2)
      end
    else
      DataModel.ClosePanel = false
      Controller:OnEnd()
    end
    if next(DataModel.ReviewList) then
      local plotReviewView = require("UIPlotReview/UIPlotReviewView")
      plotReviewView.Img_Bg1.Group_Video.Btn_Item.Video_Main.self.IsNotRelease = false
      plotReviewView.self.gameObject:SetActive(true)
      local Group_PlotList = plotReviewView.Img_Bg1.Group_PlotList
      if Group_PlotList then
        Group_PlotList:SetActive(false)
        Group_PlotList:SetActive(true)
      end
    end
    View.Group_Shake.SpineAnimation_BG.order = -1
    View.Group_Shake.Group_Spines.SpineAnimation_Role01.order = -1
    View.Group_Shake.Group_Spines.SpineAnimation_Role02.order = -1
    View.Group_Shake.Group_Spines.SpineAnimation_Role03.order = -1
    View.Img_Mask.SpineAnimation_Role.order = -1
    View.Img_Face.SpineAnimation_Role.order = -1
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
