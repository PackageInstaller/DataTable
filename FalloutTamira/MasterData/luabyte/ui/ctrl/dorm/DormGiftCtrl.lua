local DormGiftCtrl = BaseClass("DormGiftCtrl", BaseUICtrl)
local M = DormGiftCtrl
local tInsert = table.insert

function M:__init()
    self._heroId = 0
    self._scrollView = self._view.ScrollView
    self._onGiveGiftHandle = EventMgr:AddListener(UIMessageNames.DORM_GIVE_GIFT, Bind(self, self._OnGiveGift))
    self._view.obtainBtn:onClick(Bind(self, self.OnGain))
    self._view.BtnL:onClick(Bind(self, self.OnClickLeft))
    self._view.BtnR:onClick(Bind(self, self.OnClickRight))
    self._favorPanelCtrl = require("UI.Ctrl.Dorm.FavorPanelCtrl").New(self._view.FavorPanel)
    self._pageIndex = 1
    self._gifts = {}
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.systemId = ConfigHelper.GetSystemParam(358)
end

function M:OnGain(go)
    self._closeCallback = nil
    GameHelper.Jump(4)
end

function M:OnEnter(heroId, items, closeCallback)
    self.dormAction.state = DormConst.RoleState.Gift
    self._heroId = heroId
    self._items = items
    self._closeCallback = closeCallback

    if self._dragCtrl == nil then
        self._dragCtrl = require("UI.Ctrl.Dorm.DormDragCtrl").New(self._view.transform)
    end

    self._dragCtrl:SetHeroId(self._heroId)
    local len = #self._items
    self._scrollView:SetActive(len > 0)
    self._view.noGifts:SetActive(len == 0)
    self:SetFavour(heroId, nil,false)
    if len > 0 then
        self:InitGifts()
    end
    self:CheckGuide()
end

function M:_OnGiveGift(heroId, addFavor, bagItems)
    self._items = bagItems
    local len = #self._items
    self._scrollView:SetActive(len > 0)
    self._view.noGifts:SetActive(len == 0)
    self:SetFavour(heroId, addFavor,true)
    if len > 0 then
        self:InitGifts()
    end
    self:CheckGuide()
end

function M:InitGifts()
    self.giftArray = {}
    local len = #self._items
    local index = 0
    local singleGiftArray = {}
    for i = 1, len do
        index = index + 1
        if index <= 6 then
            tInsert(singleGiftArray, self._items[i])
        end
        if index == 6 or i == len then
            tInsert(self.giftArray, singleGiftArray)
            singleGiftArray = {}
            index = 0
        end
    end
    self.pageCount = #self.giftArray
    self:CreateGifts()
    self:SetButton()
end

function M:CreateGifts()
    if #self._gifts > 0 then
        for i = 1, #self._gifts do
            GameUtil.DestroyGo(self._gifts[i]._view.gameObject)
        end
    end
    self._gifts = {}
    local array = {}
    if self.giftArray[self._pageIndex] then
        array = self.giftArray[self._pageIndex]
    else
        array = self.giftArray[1]
    end
    local ctrlItemCls = require("UI.Ctrl.Dorm.GiftItemCtrl")
    for k, v in pairs(array) do
        local giftItem = self._view.GiftItem._view:Instantiate()
        giftItem:SetParent(self._view.Content)
        giftItem:SetActive(true)
        local ctrlItem = ctrlItemCls.New(giftItem)
        ctrlItem:UpdateItem(v)
        ctrlItem:EnableTouch(true)
        ctrlItem:SetDragCallback(Bind(self._dragCtrl, self._dragCtrl.DragEventHandle))
        tInsert(self._gifts, ctrlItem)
    end
end

function M:SetFavour(heroId, addFavor, isGivingCallBack)
    self._view.FavorPanel.transform:SetActive(heroId > 0)

    if heroId == 0 then
        return
    end

    local favorLevel = 0
    local curFavor = 0
    local nextFavor = 0
    local favorProgress = 0
    local stage = 0
    self._storyStage = 0
    self._roomStory = 0
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    local favor = 0

    if not IsNull(rshd) then
        favor = rshd:GetFavor()
    end

    favorLevel, curFavor, nextFavor, favorProgress, stage, self._roomStory, self._storyStage = OtakuHelper.GetHeroFeeling(heroId
        , favor)
    self._favorPanelCtrl:UpdateData(
        self._heroId,
        favorLevel,
        curFavor,
        nextFavor,
        stage
    )

    self._dragCtrl:SetFavorProgress(favorProgress)
end

function M:OnClickLeft(go)
    self._pageIndex = Mathf.Clamp(self._pageIndex - 1, 1, self.pageCount)
    self:CreateGifts()
    self:SetButton()
end

function M:OnClickRight(go)
    self._pageIndex = Mathf.Clamp(self._pageIndex + 1, 1, self.pageCount)
    self:CreateGifts()
    self:SetButton()
end

function M:SetButton()
    self._view.BtnL.gameObject:SetActive(self._pageIndex > 1)
    self._view.BtnR.gameObject:SetActive(self._pageIndex < self.pageCount)
end

function M:CheckGuide()
    if DormHelper.CheckGift(self._heroId, self.systemId) == false and self._heroId == 110003 then
        self.isGuide = true
        self._view.GuideObj.gameObject:SetActive(true)
    else
        self.isGuide = false
        self._view.GuideObj.gameObject:SetActive(false)
    end
end

function M:OnBack()
    if self.isGuide == true then
        return
    end
    if self._closeCallback then
        self._closeCallback()
    end
    self:Close()
end

function M:OnClose()
    self.dormAction.state = DormConst.RoleState.Command

    self._closeCallback = nil
    DormHelper.RoleAfk(true)
    DormHelper.SetFreeLookCamera(true)
end

function M:OnDispose()
    self._pageIndex = 1
    self._gifts = {}
    self._onGiveGiftHandle = nil
    self.dormAction = nil
    self._favorPanelCtrl:OnDispose()
    self._scrollView:Dispose()
    self._dragCtrl:Dispose()
    EventMgr:RemoveListener(UIMessageNames.DORM_GIVE_GIFT, self._onGiveGiftHandle)
    M.super.OnDispose(self)
end

return DormGiftCtrl
