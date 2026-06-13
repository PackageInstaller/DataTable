local M = BaseClass("CoordinateItemCtrl")
local TimeMgr = TimerManager:GetInstance()

function M:__init(view)
    self._view = view
    self.m_data = nil
    self.m_isOnly = false -- 专属任务
    self.m_isOver = false -- 任务是否完成
    self.m_is4Star = false
    self.m_clickCallback = nil
    self.m_timerBind = Bind(self, self.OnTimerCallBack)
    self.m_selectCallback = Bind(self, self.OnSelectState)
    self._view.infoBtn:onClick(Bind(self, self.OnClickItem))
end

function M:OnDispose()
    self.m_data = nil
    self.m_clickCallback = nil
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:SetData(data, missionCfg)
    local quality = missionCfg.quality
    self.m_data = data
    self.m_isOver = false
    self._view:SetActive(true)
    self.m_is4Star = quality >= 4
    self.m_isOnly = missionCfg.complement == 1
    self._view.node_only:SetActive(self.m_isOnly)
    self._view.node_stars:SetActive(not self.m_isOnly)
    -- 显示任务主要条件限制的角色头像，读取【expMission】表的【hero】字段；
    self._view.headIcon:SetBatleIcon(missionCfg.hero)
    -- 显示该任务主要奖励内容，读取【expMission】表的【rewardShow】字段;
    self._view.itemIcon:SetItemIcon(missionCfg.rewardShow)
    -- 根据任务品质显示品质框，读取【expMission】表的【quality】字段；
    self._view.star1:SetActive(quality >= 1)
    self._view.star2:SetActive(quality >= 2)
    self._view.star3:SetActive(quality >= 3)
    self._view.star4:SetActive(self.m_is4Star)
    self._view.gameObject.name = tostring(missionCfg.id)

    if self.m_timer then self.m_timer:Stop() end
    self.m_timer = TimeMgr:GetTimer(1, self.m_timerBind, self, false, nil, true)
    self.m_timer:Start()
    self:OnSelectState(2)
    self:OnTimerCallBack()
end

-- 是否是未启动的4星
function M:Is4StarAndNoStart()
    if not self.m_data then return false end
    local isNormal = self.m_isOnly == false -- 普通
    local noOpen = self.m_data.EndTick <= 0
    return self.m_is4Star and isNormal and noOpen
end

-- 是否已启动远征
function M:IsStart()
    if not self.m_data then return false end
    return self.m_data.EndTick > 0
end

-- 定时器回调
function M:OnTimerCallBack()
    if not self.m_data then return end

    local endStamp = self.m_data.EndTick
    local curTime = GameUtil.GetCurTimeTick()
    local endTime = math.max(endStamp - curTime, 0)
    local isOpen = endStamp > 0
    local isOver = endTime == 0 and isOpen

    if isOver then
        -- 调查完成
        self._view.surveyState:SetState(3)
        self.m_isOver = true
        self.m_timer:Stop()
        self.m_timer = nil
    elseif isOpen then
        -- 调查中
        self._view.surveyState:SetState(2)
        local fmtTime = GameHelper.formatTime(endTime)
        self._view.timeText:SetText(fmtTime)
    else
        -- 未开始
        self._view.surveyState:SetState(1)
    end
end

function M:OnClickItem(go)
    if self.m_clickCallback then
        self.m_clickCallback(self.m_isOver, self.m_data, self.m_selectCallback)
    end
end

function M:OnSelectState(value)
    if IsNull(self._view) then return end
    self._view.selectState:SetState(value)
end

function M:SetClickCallback(callback)
    self.m_clickCallback = callback
end

function M:ClearData()
    self.m_data = nil
    self.m_isOnly = false
    self.m_isOver = false
    self.m_is4Star = false
    self._view:SetActive(false)

    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
end

-- 是否是同一个任务
function M:IsSameTask(id)
    local taskId = self.m_data and self.m_data.Id or 0
    return (taskId > 0) and (taskId == id)
end

return M
