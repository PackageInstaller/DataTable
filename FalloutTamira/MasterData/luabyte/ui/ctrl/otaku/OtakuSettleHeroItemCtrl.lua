local M = BaseClass("OtakuSettleHeroItemCtrl")
local DeployState = OtakuType.DeployState

function M:__init(view)
    self._view = view
    self._data = nil
    self.m_tween = nil
    self.m_format = ConfigHelper.GetLocalString(5650)
    self._view.stateItem:onClick(Bind(self, self.OnItemClick))
end

function M:UpdateItem(data)
    self:_StopTween()
    if not data then return end

    self._data = data
    local state = data:State()
    self._view.stateItem:SetState(state)
    if state == DeployState.Plus then
        self:_SetNormalInfo()
    elseif state == DeployState.Lock then
        self:_SetLockInfo()
    end
end

function M:_SetNormalInfo()
    local heroId = self._data:HeroId()
    self._view.imgHero:SetAvatarIcon(heroId, RoleType.ERT_Hero, 2)
    self._view.imgProfession:SetProfessional(heroId)

    local heroData = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    local maxSatiety = OtakuHelper.MaxSatiety(heroId)
    local eater, startValue, duration = 0, 0, 0
    if OtakuRoomDataMgr:GetInstance():IsMakeFast() then
        startValue = maxSatiety
        duration = 2 -- 首次制造2秒动画
    else
        eater = heroData:GetEater()
        startValue = eater
        duration = 0
    end

    self._view.txtMaxSatiety:SetText(tostring(maxSatiety))
    self.m_tween = self._view.txtCurSatiety:SetTextRoll(startValue, eater, duration, function(value)
        local satietyRatio = value / maxSatiety
        satietyRatio = MathUtil.GetPreciseDecimal((satietyRatio > 1) and 1 or satietyRatio, 2)
        if not self._data.noState then
            if satietyRatio == 0 then
                self._view.stateSatiety:SetState(1)
            elseif satietyRatio < 0.2 then
                self._view.stateSatiety:SetState(2)
            elseif satietyRatio <= 0.8 then
                self._view.stateSatiety:SetState(3)
            else
                self._view.stateSatiety:SetState(4)
            end
        end
        self._view.sbarSatiety.size = satietyRatio
    end)
end

function M:_SetLockInfo()
    local content = string.format(self.m_format, self._data:LockLevel())
    self._view.txtLockLevel:SetText(content)
end

function M:OnItemClick()
    local state = self._data:State()
    if (state == DeployState.Normal) or (state == DeployState.Plus) then
        local roomId, pos = self._data:RoomId(), self._data:Position()
        OtakuRoomDataMgr:GetInstance():UpdateSettleSelectByRoomId(roomId, pos)
        EventMgr:Broadcast(UIMessageNames.OTAKU_SETTLE_SELECT_UPDATE, roomId)
        UIContextMgr:GetInstance():Show("OtakuChooseHeroUI", roomId, self._data.curSettleType, pos)
    end
end

function M:OnRemoveClick()
    if self._data:State() == DeployState.Plus then
        local roomId, pos = self._data:RoomId(), self._data:Position()
        OtakuRoomDataMgr:GetInstance():RequestCancelGarrisonStudio(roomId, self._data.curSettleType, pos)
        EventMgr:Broadcast(UIMessageNames.OTAKU_SETTLE_SELECT_UPDATE, roomId)
    end
end

function M:_StopTween()
    if self.m_tween then
        self.m_tween:TweenKill()
        self.m_tween = nil
    end
end

function M:OnDispose()
    self._data = nil
    self.m_format = nil
    self:_StopTween()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
