local EncounterStageABItemCtrl = BaseClass("EncounterStageABItemCtrl")
local M = EncounterStageABItemCtrl
local CanSelect = false

function M:__init(view)
    self._view = view
    self._view.openView:onClick(Bind(self, self._OnClickOpenView))
    self._view.detail:onClick(Bind(self, self._OnClickDetail))
    self._view.img:onClick(Bind(self, self._OnSelect))
    self._view.keyWord1:SetOnClick(Bind(self, self._OnClickKeyWord))
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:_OnClickKeyWord(go)
    local cfg = ConfigHelper.GetCfg("encounterMission", self._encounterMissionId)
    local descs = {}
    for i = 1, #cfg.entry do
        local entry = cfg.entry[i]
        local entryIcon = cfg.entryIcon[i]
        local entryName = cfg.entryNames[i]
        local entryDes = cfg.entryDes[i]
        entryName = entryName and entryName or 0
        entryDes = entryDes and entryDes or 0
        local itemDesc = i .. "." .. ConfigHelper.GetLocalString(entryDes)
        table.insert(descs, itemDesc)
    end
    local desc = "\n" .. string.join(descs, "\n\n")
    UIContextMgr:GetInstance():Show("CommonTips", desc)
end

function M:_OnClickOpenView(go)
    local path = self._missionCfg.map
    if path ~= "" then
        UIContextMgr:GetInstance():Show("MissionMapUI", path)
    else
        GameHelper.TipsById(4161)
    end
end

function M:_OnClickDetail(go)

    local stageCfg = ConfigHelper.GetCfg("stage", self._missionCfg.stageId)
    if stageCfg then
        UIContextMgr:GetInstance():Show("MonsterInfoUI", stageCfg)
    else
        GameHelper.TipsById(4162)
    end
end

--设置选中状态
function M:SetSelect(isSelect)
    self._view.state:SetState(isSelect and 2 or 1)
end

--点击选中回调
function M:_OnSelect(go)
    if self._selectCallback and CanSelect then
        self._selectCallback(self._encounterMissionId)
    end
end

function M:SetData(encounterMissionId, isPass, selectCallback)
    self._selectCallback = selectCallback
    self._encounterMissionId = encounterMissionId
    local cfg = ConfigHelper.GetCfg("encounterMission", encounterMissionId)
    local missionId = cfg.missionId
    self._missionCfg = ConfigHelper.GetCfg("mission", missionId)
    self._view.img:SetPic(self._missionCfg.map)
    local wordNum = cfg.entry and #cfg.entry or 0
    self._view.keyWord1:SetActive(wordNum > 0)
    self._view.finishState:SetState(isPass and 2 or 1)
end

return EncounterStageABItemCtrl
