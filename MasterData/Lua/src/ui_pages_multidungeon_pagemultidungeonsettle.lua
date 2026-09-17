local this = class("pageMultiDungeonSettle", G_UIPageBase)
local _multiDungeonTpl = L_GameTpl:getMultiDungeonTpl()
local TeamCount = L_GameConstTpl:getData("MULIT_DUNGEON_PLAYERNUM", L_Const.GameTplType.int)

function this.bind()
  return {
    txt_time = nil,
    img_grade = nil,
    txt_score = nil,
    list_player = {
      moduleName = "pages/multiDungeon/cellMultiDungeonPlayer"
    },
    list_challenge = {
      moduleName = "pages/multiDungeon/cellMultiDungeonChallenge"
    },
    txt_countdown = nil,
    active_reportPlayer = false
  }
end

function this.methods()
  return {
    onClick_continue = function(self)
      L_MultiDungeonStore:req_CSProtoMultiCampaignQuit()
    end,
    onClick_reportPlayer = function(self)
      CS.Lens.Gameplay.UI.ReportStore.GetStore():TryOpenMultiBattleReportBox()
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:initPage()
end

function this:close(options)
  this.super.close(self, options)
  L_TimerManager:clearTimer(self)
end

function this:escHandle()
end

function this:initPage()
  local serverData = L_MultiDungeonStore:getCurMultiDungeonInfo()
  local tpl = _multiDungeonTpl:getTplById(serverData.dungeon_id)
  self.bind.txt_time = L_TimeUtil.secondToLangString(L_MultiDungeonStore:getUseTime(serverData))
  self.bind.img_grade = nil
  self.bind.txt_score = tostring(serverData.score)
  local challengeDesc = _multiDungeonTpl:getChallengeDes(tpl)
  local challengeServerData = L_MultiDungeonStore:getDungeonStar(serverData)
  local tmp_challenge = {}
  for i, v in ipairs(challengeDesc) do
    table.insert(tmp_challenge, {
      txt_name = L_GameUtil.fillColor(v, challengeServerData[i] and L_Const.colorHtml.green002 or L_Const.colorHtml.red002)
    })
  end
  self.bind.list_challenge:clear()
  self.bind.list_challenge:insert_array(tmp_challenge)
  
  local function func()
    local endTime = serverData.end_time + L_GameClientTpl:getData("DUNGEON_STAY_TIME", L_Const.GameTplType.int)
    local nowTime = L_TimeUtil.getServerTime()
    local leftTime = endTime - nowTime
    self.bind.txt_countdown = L_WordsTpl:getValue("notice_pageMultiDungeonSettle", {
      [0] = leftTime
    })
    if leftTime <= 0 then
      L_TimerManager:stopTimer(self, "txt_countdown")
      L_MultiDungeonStore:req_CSProtoMultiCampaignQuit()
    end
  end
  
  L_TimerManager:newOrResetTimer(self, "txt_countdown", func, 1, -1)
  func()
  local tmp = {}
  for i = 1, TeamCount do
    table.insert(tmp, {
      position = i,
      pageName = self.pageName
    })
  end
  self.bind.list_player:clear()
  self.bind.list_player:insert_array(tmp)
  self.bind.active_reportPlayer = CS.Lens.Gameplay.UI.ReportStore.GetStore():IsMultiBattleReportEnabled()
end

return this
