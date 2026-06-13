local EasyTouch = require("UI.Ctrl.Common.ComUIEasyTouch")
local OtakuMainUICtrl = BaseClass("OtakuMainUICtrl", BaseUICtrl)
local M = OtakuMainUICtrl
local OtakuRoomType = OtakuType.OtakuRoomType

-- 判断是否可以建造 并返回可建造舱室等级 ，前一个舱室是否建造
function M:IsCompose(type, index)
    if type == OtakuRoomType.EST_Dormitory then
        return true, 1
    end

    local typeData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(type)
    local bridgeData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuRoomType.EST_Bridge)
    local level = bridgeData[1]:Level()
    local config = self.m_HouseConfig[level]
    local configName = self.m_RoomConfigName[type]
    local length = config[configName][1]
    local lockLevel = MapUtil.OrderFilterValues(self.m_HouseConfig, function(v) return v[configName][1] == index end)
    return (#typeData < length and #typeData >= index - 1) or false, lockLevel[1][configName][2], #typeData >= index - 1
end

-- 开始
function M:OnEnter()
    if GameHelper.GetPlayerPrefsInt(SettingConst.Dorm.CabinCameraTrackIn, SettingDefault.Dorm.CabinCameraTrackIn) > 0 then
        GameHelper.SetPlayerPrefsInt(SettingConst.Dorm.CabinCameraTrackIn, 0)
        self._view.animator:Play("OtakuMainUI")
        self.m_OFFAnimator = TimerManager:GetInstance():GetTimer(3.5, Bind(self, self._OnOFFAnimator), self, true)
        self.m_OFFAnimator:Start()
        OtakuRoomDataMgr:GetInstance().onAnimator = true
    else
        self.m_OFFAnimator = TimerManager:GetInstance():GetTimer(0.2, Bind(self, self._OnOFFAnimator), self, true)
        self.m_OFFAnimator:Start()
        OtakuRoomDataMgr:GetInstance().onAnimator = true
    end
    self._tickTimer = TimerManager:GetInstance():GetTimer(1, self.Update, self, false)
    for k, v in pairs(self.m_RoomType) do
        self:_SetTypeRoom(k, v)
    end
    self:_RefreshBtn()
    GameHelper.DoPlayerAction(PlayerAction.EnterOtakuModule)
    self._view.roleBtn:SetActive(true)
end

-- 其他界面返回 刷新主界面房间状态
function M:OnVisible()
    for k, v in pairs(self.m_RoomType) do
        -- 宿舍除外
        if k ~= OtakuRoomType.EST_Dormitory then
            self:UpdateRoomByType(k, v)
        end
    end
    self:_RefreshBtn()
    self:_CheckRedPoint()
    GameHelper.DoPlayerAction(PlayerAction.EnterOtakuModule)
    self._view.roleBtn:SetActive(true)
end

--点击设置退出键【关闭带顶栏的Normal窗口】
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

-- 刷新所有房间
function M:UpdateAllRoom()
    for k, v in pairs(self.m_RoomType) do
        local roomName = v
        if k ~= OtakuRoomType.EST_Dormitory then
            for j = 1, 4 do
                local parme = roomName .. j
                local view = self._view[parme]
                if view then
                    view:Update()
                end
            end
        end
    end
end

-- 刷新这个类型的房间
function M:UpdateRoomByType(type, roomName)
    local len = (type == OtakuRoomType.EST_Produce or type == OtakuRoomType.EST_Canteen) and 4 or 1
    roomName = roomName or self.m_RoomType[type]
    for i = 1, len do
        local parme = roomName .. i
        local view = self._view[parme]

        if view then
            view:Update()
        end
    end
end

function M:_CheckRedPoint()
    local length = self.m_RedPointList.Length
    for i = 1, length do
        local index = i - 1
        local redpoint = self.m_RedPointList[index]
        redpoint:Check()
    end
end

function M:_RefreshBtn()
    self:_RefreshProduce()
    self:_RefreshSurvey()
end

function M:_RefreshProduce()
    self._view.produceClaim:SetActive(false)
    local roomData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuRoomType.EST_Produce)
    for i, v in ipairs(roomData) do
        if v:IsFinish() then
            self._view.produceClaim:SetActive(true)
            return
        end
    end
end

function M:_RefreshSurvey()
    self._view.surveyClaim:SetActive(false)
    self._view.surveyEnter:SetActive(OtakuRedPointMgr.SurveyIdleTask())
    local roomData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuRoomType.EST_Survey)
    for _, v in ipairs(roomData) do
        local ids = v:GetFinishSurveyIds()
        if #ids > 0 then
            self._view.surveyClaim:SetActive(true)
            return
        end
    end
end

-- 设置房间信息 如后续需要添加已知类型舱室 不超过4个都可以不用修改代码 直接让UE修改UI 策划修改表即可 为了不必要的浪费，目前多舱室只判断了制造仓和餐厅
function M:_SetTypeRoom(type, name)
    local len = (type == OtakuRoomType.EST_Produce or type == OtakuRoomType.EST_Canteen) and 3 or 1
    local roomDatas = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(type)

    for i = 1, len do
        local parme = name .. i
        local view = self._view[parme]

        if view then
            view:Awake(type, i, self, roomDatas[i])
        end
    end
end

function M:_SetScollViewScale()
    self._view.content:SetLocalScale(self.m_Scale, self.m_Scale, 1)
end

--初始化 对应的舱室的参数
function M:Init()
    self.m_isOpenScallView = true
    self.m_Scale = 1.2
    self.m_HouseConfig = ConfigHelper.GetCfgs("house")
    self.m_RoomType = {
        [OtakuRoomType.EST_Bridge] = "Bridge",
        [OtakuRoomType.EST_Produce] = "Produce",
        [OtakuRoomType.EST_Communication] = "Communication",
        [OtakuRoomType.EST_Dormitory] = "Drom",
        [OtakuRoomType.EST_Canteen] = "Canteen",
        [OtakuRoomType.EST_Compose] = "Compose",
        [OtakuRoomType.EST_Survey] = "Survey",
        [OtakuRoomType.EST_Kitchen] = "Kitchen"
    }
    self.m_RoomConfigName = {
        [OtakuRoomType.EST_Produce] = "make",
        [OtakuRoomType.EST_Communication] = "communication",
        [OtakuRoomType.EST_Dormitory] = "room",
        [OtakuRoomType.EST_Canteen] = "restaurant",
        [OtakuRoomType.EST_Compose] = "makeUp",
        [OtakuRoomType.EST_Survey] = "expMission",
        [OtakuRoomType.EST_Kitchen] = "kitchen"
    }
    self._view.roleBtn:onClick(Bind(self, self._OnClickHero))
    self.m_RedPointList = self._view.redPointRoot:GetAllRedPoint()
    self._view.surveyEnter:onClick(Bind(self, self._OnClickSurveyEnter))
    self._view.surveyClaim:onClick(Bind(self, self._OnClickSurveyClaim))
    self._view.produceClaim:onClick(Bind(self, self._OnClickProduceClaim))
    EasyTouch:RegisterListener(ComConst.EasyTouch.Pinch, Bind(self, self._OnEasyTouchCallBack))
    EasyTouch:RegisterListener(ComConst.EasyTouch.TouchUp2, Bind(self, self._OnEasyTouchEndCallBack))
    self._onSetOtakuScrollViewValue = EventMgr:AddListener(UIMessageNames.SET_OTAKU_MAIN_UI_HONRIZONTAL,
        Bind(self, self.OnSetOtakuScrollViewValue))
end

function M:_OnOFFAnimator()
    self.m_OFFAnimator:Stop()
    self.m_OFFAnimator = nil
    OtakuRoomDataMgr:GetInstance().onAnimator = false
    if self._view then
        self._view.animator.enabled = false
    end
end

function M:_OnClickHero()
    UIContextMgr:GetInstance():Show("OtakuOverviewMain")
end

function M:_OnClickSurveyClaim(go)
    OtakuRoomDataMgr:GetInstance():SurveyCabinClaim(Bind(self, self.OnVisible))
end

function M:_OnClickProduceClaim(go)
    OtakuRoomDataMgr:GetInstance():MakeCabinClaim(Bind(self, self.OnVisible))
end

function M:_OnClickSurveyEnter(go)
    JumpMgr:GetInstance():Execute(76)
end

function M:_OnEasyTouchCallBack(pos)
    if IGuideMgr.IsGuiding then
        return
    end
    if self.m_isOpenScallView then
        self.m_isOpenScallView = false
        self._view.scrollView.enabled = self.m_isOpenScallView
    end

    if self.m_Pos == pos then
        return
    end

    local curPos = math.ceil(pos)
    self.m_Pos = self.m_Pos or curPos

    if self.m_Pos > curPos then
        if self.m_Scale <= 1 then
            self.m_Pos = curPos
            return
        end

        self.m_Scale = self.m_Scale - (self.m_Pos - curPos) * 0.001
        self.m_Scale = self.m_Scale < 1 and 1 or self.m_Scale
        self:_SetScollViewScale()
    elseif self.m_Pos < curPos then
        if self.m_Scale >= 2.5 then
            self.m_Pos = curPos
            return
        end

        self.m_Scale = self.m_Scale + (curPos - self.m_Pos) * 0.001
        self.m_Scale = self.m_Scale > 2.5 and 2.5 or self.m_Scale
        self:_SetScollViewScale()
    end

    self.m_Pos = curPos
end

function M:_OnEasyTouchEndCallBack()
    if IGuideMgr.IsGuiding then
        return
    end
    self.m_Pos = nil
    if not self.m_isOpenScallView then
        self.m_isOpenScallView = true
        self._view.scrollView.enabled = self.m_isOpenScallView
    end
end

function M:OnSetOtakuScrollViewValue(value)
    coroutine.start(function()
        coroutine.waitforseconds(0.1)
        self._view.scrollView:SetHorizontalValue(value)
    end)
end

function M:OnDispose()
    if self.m_OFFAnimator then
        self.m_OFFAnimator:Stop()
        self.m_OFFAnimator = nil
    end
    EventMgr:RemoveListener(UIMessageNames.SET_OTAKU_MAIN_UI_HONRIZONTAL, self._onSetOtakuScrollViewValue)
    M.super.OnDispose(self)
    EasyTouch:Hide()
end

function M:OnClose()
    OtakuRoomDataMgr:GetInstance().onAnimator = false
end

return OtakuMainUICtrl
