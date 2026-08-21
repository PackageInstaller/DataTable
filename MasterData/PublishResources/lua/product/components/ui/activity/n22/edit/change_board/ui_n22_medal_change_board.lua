_class("UIN22MedalChangeBoard", UIController)
UIN22MedalChangeBoard = UIN22MedalChangeBoard

function UIN22MedalChangeBoard:Constructor()
  self.mMedal = GameGlobal.GetModule(MedalModule)
  self.data = self.mMedal:GetN22MedalEditData()
end

function UIN22MedalChangeBoard:OnShow(uiParams)
  self.curBoardId = uiParams[1]
  self.callbackFlushBoard = uiParams[2]
  self.poolContent = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
end

function UIN22MedalChangeBoard:OnHide()
end

function UIN22MedalChangeBoard:Flush()
  local boards = self:GetSortMedals()
  local len = table.count(boards)
  self.poolContent:SpawnObjects("UIN22MedalChangeBoardItem", len)
  local uis = self.poolContent:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local board = boards[i]
    ui:Flush(board, self.curBoardId, function()
      self:StartTask(function(TT)
        local key = "UIN22MedalChangeBoardItemBtnReplaceOnClick"
        self:Lock(key)
        local placement_infoSer = self.mMedal:GetPlacementInfo()
        local placement_info = medal_placement_info:New()
        placement_info.board_back_id = board.medal_id
        placement_info.medal_on_board = placement_infoSer.medal_on_board
        local res = self.mMedal:ReqSaveMedal(TT, placement_info)
        if N22MedalEditData.CheckCode(res) then
          if self.callbackFlushBoard then
            self.callbackFlushBoard()
          end
          self:CloseDialog()
        end
        self:UnLock(key)
      end)
    end)
  end
end

function UIN22MedalChangeBoard:GetSortMedals()
  local dataBoard = UIMedalBgListData:New()
  dataBoard:Init(self.mMedal:GetMedalBoardVec())
  local boards = dataBoard:GetSortMedals()
  local t = {}
  if boards then
    for index, board in ipairs(boards) do
      if board.status == RewardStatus.E_MEDAL_REWARD_LOCK then
      else
        table.insert(t, board)
      end
    end
  end
  return t
end

function UIN22MedalChangeBoard:BgOnClick(go)
  self:CloseDialog()
end
