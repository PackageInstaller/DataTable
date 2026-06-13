-- 餐厅主界面
-- 对应UI  RestaurantRootUI
local RestaurantRootUICtrl = BaseClass("RestaurantRootUICtrl", BaseUICtrl)
local M = RestaurantRootUICtrl
local ETableState = EnumConst.ETableState
local POSNUM = 8

function M:Init()
    self._upGradeCallBack = EventMgr:AddListener(UIMessageNames.OTAKU_UPGRADE, Bind(self, self.StudioUpgradeCallBack))

    self._view.btnStart:onClick(Bind(self, self._onClickStar))
    self.tabStar = {self._view.tfStar}
    self.tabUIPosItemCtrls = {self._view.UIPosItemCtrl}
    for i = 1, POSNUM do
        local UIPosItemCtrl = self.tabUIPosItemCtrls[i]
        if not UIPosItemCtrl then
            UIPosItemCtrl = self._view.UIPosItemCtrl:Instantiate()
            self.tabUIPosItemCtrls[i] = UIPosItemCtrl
        end
    end
end

function M:OnEnter(roomData)
    self.roomData = roomData
    self._view.OtakuTitlePanel:Init(self.roomData)
    self:_initPosDatas()
    RestaurantDataMgr:GetInstance():UdpateToDayStar(Bind(self, self._OnUpdateStarCallBack))
    -- 餐厅埋点
    GameHelper.DoPlayerAction(PlayerAction.OpenCantenn)
end

function M:StudioUpgradeCallBack(roomId)
    if roomId ~= self.roomData:RoomId() then
        return
    end
    self.roomData:UpdateLvUpDining()
    self:_initPosDatas()
end

function M:_initPosDatas()
    self.dinings = self.roomData:GetDinings()
    local nullNum = self.roomData:GetNullPosNum()
    for i = 1, POSNUM do
        local diningData = self.dinings[i]
        local nowTimer = TimeUtil.GetNowTimeStamp()
        local data = {}
        local heroId
        if self.tabUIPosItemCtrls[i] then
            heroId = self.tabUIPosItemCtrls[i]:GetUserId()
        end

        if diningData.state == ETableState.Cleaning then -- 打扫中
            if diningData.EndTick <= nowTimer then
                diningData.state = ETableState.None
            end
        end
        data.state = diningData.state
        if heroId then
            data.state = ETableState.Use
            data.heroId = heroId
            data.value = 0
        end
        data.lockTips = diningData.lockTips

        data.nullNum = nullNum
        if data.state == ETableState.Use or data.state == ETableState.Cleaning then
            data.endTimer = diningData.EndTick
            data.clearTime = diningData.capacity
        end
        data.callBack = Bind(self, self._SelectHero)
        self.tabUIPosItemCtrls[i]:UpdateData(data)
    end
end

function M:_onClickStar()
    if not self.star or not self.food then
        Logger.LogError("没获取到餐厅星级和食物")
        return
    end
    UIContextMgr:GetInstance():Show(UIDefine.UICookStar, self.star, self.food)
end

function M:_SelectHero(heroIds)
    self.heroIds = heroIds
    local nums = #heroIds
    self.post = self.roomData:GetPos(nums)
    RestaurantDataMgr:GetInstance():RequestInviteHeroEat(heroIds, self.post, self.roomData:RoomId(), Bind(self, self._eatCallback))
end

-- 邀请英雄吃饭
function M:_eatCallback(diningTables)
    self:UpdateDinings(diningTables)
    for key, heroId in pairs(self.heroIds) do
        local pos = self.post[key] + 1
        local data = {}
        -- 使用状态
        data.state = ETableState.Use
        data.heroId = heroId
        data.endTimer = self.dinings[pos].EndTick
        data.clearTime = self.dinings[pos].capacity
        self.tabUIPosItemCtrls[pos]:UpdateData(data)
    end
end

-- 邀请吃饭成功 更新餐桌冷却时间
function M:UpdateDinings(DiningTables)
    self.roomData:UpdateDining(DiningTables)
    self.dinings = self.roomData:GetDinings()
end

---请求餐厅星级信息
function M:_OnUpdateStarCallBack(star, food)
    self.star = star
    self.food = food
    self:_intStar()
    local guideData = CS.GameX.Data.PlayerDataNew.Instance.guideData
    if not guideData:IsGuideDone(12) then
        return
    end
    if RestaurantDataMgr:GetInstance():GetToDayTipsStar() then
        UIContextMgr:GetInstance():Show(UIDefine.UICookStar, self.star, self.food)
        RestaurantDataMgr:GetInstance():UpdteTipsStarTimer()
    end
end

function M:_intStar()
    self._view.imgFood:SetItemIcon(self.food)
    for i = 2, self.star do
        local go = GameUtil.Instantiate(self._view.tfStar.gameObject, self._view.tfStar.parent)
        self.tabStar[i] = go
    end
end

function M:OnBack()
    return true
end

-- 点击设置退出键【关闭带顶栏的Normal窗口】
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnDispose()
    if self.tabStar then
        for i = 2, #self.tabStar do
            GameUtil.DestroyGo(self.tabStar[i])
        end
        self.tabStar = nil
    end
    for _, value in ipairs(self.tabUIPosItemCtrls) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end
    M.super.OnDispose(self)
    EventMgr:RemoveListener(UIMessageNames.OTAKU_UPGRADE, self._upGradeCallBack)
end

return RestaurantRootUICtrl
