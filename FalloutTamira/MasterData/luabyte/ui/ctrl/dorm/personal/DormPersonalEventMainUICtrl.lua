local M = BaseClass("DormPersonalEventMainUICtrl", BaseUICtrl)
local bgPath = "UI/Prefab/Room/DormPersonalEvent_Bg/Bg_"

function M:Init()
    local itemCtrl = require("UI.Ctrl.Dorm.Personal.DormPersonalMainItemCtrl")
    local itemView = require("UI.View.Dorm.Personal.DormPersonalMainItemView")
    self.m_heroId = 0
    self.m_isShow = true
    self.m_tabIndex = 0     -- 页签索引
    self.m_dataList = {}
    self.m_selectData = nil -- 正在进行的关卡
    self._view.node_list:Init(itemCtrl, itemView)
    self.m_module = ModuleMgr:GetInstance():GetCurrentModule()
end

function M:OnEnter(heroId, chapters)
    self.m_heroId = heroId
    self.m_dataList = chapters
    ResourceManager:GetInstance():InstanceGameObject(bgPath .. heroId, function(go)
        if not IsNull(go) then go:SetParent(self._view.node_panel, false) end
    end)

    local labels, firstEndTime = {}, 0
    for _, data in ipairs(self.m_dataList) do
        local chapter, endTime = data:GetChapter(), data:EndTime()
        table.insert(labels, ConfigHelper.GetLocalString(chapter.name))
        if endTime > 0 then
            if (firstEndTime == 0) or (firstEndTime > endTime) then
                firstEndTime = endTime
            end
        end
    end

    if firstEndTime > 0 then
        local gapTime = math.max(0, firstEndTime - TimeUtil.GetNowTimeStamp())
        if gapTime > 0 then
            self.m_timer = TimerManager:GetInstance():GetTimer(gapTime, Bind(self, self.UpdateMissionList), self, true)
            self.m_timer:Start()
        end
    end

    self._view.node_tabs:InitItems(self.m_tabIndex, labels, Bind(self, self.OnTabChanged))
    self._view.node_tabs:SetIndex(self.m_tabIndex, true)
    self:InitRedpint()
end

function M:InitRedpint()
    local length = #self.m_dataList
    for i = 0, length - 1 do
        local item = self._view.node_tabs:GetTabItem(i)
        if not IsNull(item) then
            local chapterId = self.m_dataList[i+1]:GetChapter().id
            if chapterId == DormPuzzleActivityDataMgr:GetInstance():GetChapterId() then
                item:SetRedPointParam(0, 1)
            else
                item:SetRedPointParam(0, 0)
            end
            item:RedPointCheck()
        end
    end
end

function M:OnVisible()
    self.m_isShow = true
end

function M:OnInvisible()
    self.m_isShow = false
end

function M:OnBack()
    if self.m_isShow then
        UIContextMgr:GetInstance():Show("Dorm", self.m_module.roleStudio)
        self:Close()
        return false
    end
    return true
end

function M:OnClose()
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
    self.m_module = nil
    self.m_tabIndex = nil
    self.m_dataList = nil
    self.m_selectData = nil
end

function M:OnTabChanged(idx)
    self.m_tabIndex = idx
    local data = self.m_dataList[self.m_tabIndex + 1]
    local md = data:LastUnlockData()
    local list = data:GetAllMissions()
    local index = md and md.Index or 1
    self._view.node_list:SetDataList(list)
    self._view.node_list:SetHorizontalNormalizedByIndex(index)
end

function M:UpdateMissionList()
    self._view.node_list:UpdateList()
    self:InitRedpint()
end

return M
