--[[ 
    英雄传记
]]
module('battleMap.HeroBiographyPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('battleMapHall/biography/HeroBiographyPanel.prefab')
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle('')
    self:setBg("biography_bg_2.jpg", false, "biography")
    self:setTxtTitle(_TT(44207))
    self:setUICode(LinkCode.Biography)
end

-- 初始化数据
function initData(self)
    self.mBiographyItemDic = {}
    self.m_itemList = {}
    self.isShowInfo = false
    self.mHeroTid = nil
    self.mSelectBiographyId = nil
end

function configUI(self)    
    self.mTextBiographyName = self:getChildGO('TextBiographyName'):GetComponent(ty.Text)
	self.m_goToucher = self:getChildGO('ImgToucher')
    self.m_scrollerTrans = self:getChildTrans('DupScroll')
    self.m_groupContent = self:getChildTrans('DupContent')
    self.m_rectContent = self.m_groupContent:GetComponent(ty.RectTransform)

    self.m_nodeStart = self:getChildTrans('NodeStart')
    self.m_rectNodeStart = self.m_nodeStart:GetComponent(ty.RectTransform)

    self.mGroupInfo = self:getChildTrans("GroupInfo")
    self.mTxtChallengeNum = self:getChildGO('mTxtChallengeNum'):GetComponent(ty.Text)
    self.mTxt = self:getChildGO('mTxt'):GetComponent(ty.Text)

    self.mToggleAttention = self:getChildGO("mToggleAttention"):GetComponent(ty.Toggle)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID })
    GameDispatcher:addEventListener(EventName.UPDATE_HERO_BIOGRAPHY, self.__onUpdateListHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BIOGRAPHY_INFO, self.__onClickEmptyHandler, self)

    self.mHeroTid = args.heroTid
    self.mSelectBiographyId = args.biographyId
    self.mBiographyVo = battleMap.BiographyManager:getBiographyVo(self.mHeroTid, self.mSelectBiographyId)
    self.mToggleAttention.isOn = self.mBiographyVo.isFollow == 1
    local function onToggle()
        self:heroFollow()
    end
    self.mToggleAttention.onValueChanged:AddListener(onToggle)
    self:__updateView(true)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_BIOGRAPHY, self.__onUpdateListHandler, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_BIOGRAPHY_INFO, self.__onClickEmptyHandler, self)
    self.mToggleAttention.onValueChanged:RemoveAllListeners()
    self:__recoverDupItem()
    self:__recoverBiographyItem()
    self:__onCloseDupViewHandler()
end

function initViewText(self)
    self.mTxt.text = _TT(73203) -- 单个：73203
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_goToucher, self.__onClickEmptyHandler, "")
end

function heroFollow(self)
    self.mBiographyVo.isFollow = self.mBiographyVo.isFollow == 0 and 1 or 0
    GameDispatcher:dispatchEvent(EventName.REQ_HERO_FOLLOW, {tid = self.mHeroTid, follow = self.mBiographyVo.isFollow})
end

function __onClickEmptyHandler(self)
    self:__onCloseDupViewHandler()
end

function __onUpdateListHandler(self)
    self:__updateView(false)
end

function setData(self)
    self:__updateView(true)
end

function __updateView(self, isInit)
    local minChallengeNum = self.mBiographyVo.restTime <= battleMap.BiographyManager:getResTimes() and self.mBiographyVo.restTime or battleMap.BiographyManager:getResTimes()
    self.mTxtChallengeNum.text = minChallengeNum
    self.mTxtChallengeNum.color = gs.ColorUtil.GetColor(minChallengeNum == 0 and "ffffffff" or "18EC68ff")
    self:__updateBiographyTab()

    local biographyConfigVo = battleMap.BiographyManager:getBiographyConfigVo(self.mSelectBiographyId)
    self.mTextBiographyName.text = biographyConfigVo:getName()
end

function __updateBiographyTab(self)
    self:__updateStageListView()
end

function __updateStageListView(self)
    self:__recoverDupItem()
    local scrollToStageId = 999999
    local allPass = true
    local totalW = 0
    local parentTrans = self.m_nodeStart
    local biographyDupListRo = battleMap.BiographyManager:getBiographyConfigVo(self.mSelectBiographyId)
    local list = biographyDupListRo:getChapterList()
    for i = 1, #list do
        local stageId = list[i]
        local item = battleMap.HeroBiographyDupItem:create(parentTrans, {heroTid = self.mHeroTid, biographyId = self.mSelectBiographyId, stageId = stageId}, 1, false)
        if(not table.indexof(self.mBiographyVo.passDupList, stageId) and stageId < scrollToStageId)then
            item:setSelectState(true)
            scrollToStageId = stageId
            allPass = false
        else
            item:setSelectState(false)
        end
        item:setCallBack(self, self.__onClickStageItemHandler, stageId)
        table.insert(self.m_itemList, item)
        parentTrans = item:getNextNodeTrans()
        if(i == #list)then
            local starX, middleX, endX = self:__getItemPosX(item)
            totalW = endX + self:getScreenW() / 2
        end
    end
    gs.TransQuick:SizeDelta01(self.m_rectContent, totalW)

    if(not allPass and scrollToStageId)then
        self:__scrollToStageId(scrollToStageId)
    else
        local item = self.m_itemList[#self.m_itemList]
        if(item)then
            item:setSelectState(true)
            self:__scrollToStageId(item:getData().stageId)
        end
    end
end

function __onClickStageItemHandler(self, data)
    local heroTid = data.heroTid
    local biographyId = data.biographyId
    local stageId = data.stageId
    -- 已开启
    if(self.mBiographyVo)then
        if(table.indexof(self.mBiographyVo.historyDupList, stageId) or self.mBiographyVo.curDupId == stageId)then   
            self:__onOpenDupInfoHandler(heroTid, biographyId, stageId)
            self:__setSelectStage(stageId) 
        else
            gs.Message.Show(_TT(119))
        end
    else
        gs.Message.Show(_TT(119))
    end
end

-- 设置关卡选中状态
function __setSelectStage(self, stageId)
    for k, item in pairs(self.m_itemList) do
        if(item:getData().stageId == stageId)then
            item:setSelectState(true)
        else
            item:setSelectState(false)
        end
    end
    self:__scrollToStageId(stageId, true)
end

function __scrollToStageId(self, stageId, isTween)
    self.lastId = stageId
    local scollOver = function()
        local stageItem = nil
        for k, item in pairs(self.m_itemList) do
            if(item:getData().stageId == stageId)then
                stageItem = item
            end
        end
        if(stageItem)then
            local starX, middleX, endX = self:__getItemPosX(stageItem)
            -- 默认移动到左边部分的中间
            local moveToX = middleX - self:getScreenW() / 5 * 2
            local scrollerW = self.m_scrollerTrans.rect.width
            local totalContentW = self.m_rectContent.rect.width
            local pos = self.m_rectContent.anchoredPosition
            if(totalContentW - moveToX <= scrollerW)then
                -- 移动到最后
                pos.x = -(totalContentW - scrollerW)
            else
                -- 移动到moveToX
                pos.x = -moveToX
            end
            pos.x = pos.x >= 0 and 0 or pos.x
            pos.x = pos.x <= (scrollerW - totalContentW) and (scrollerW - totalContentW) or pos.x
            if(isTween)then
                TweenFactory:move2LPosX(self.m_rectContent, pos.x, 0.3)
            else
                self.m_rectContent.anchoredPosition = pos
            end
        end
    end
    if (self.m_delayFrameSn) then
        LoopManager:removeFrameByIndex(self.m_delayFrameSn)
        self.m_delayFrameSn = nil
    end
    self.m_delayFrameSn = LoopManager:addFrame(3, 1, self, scollOver)
end

function __getItemPosX(self, item)
    local w, h = item:getSize()
    local relativePos = item:getRelativePos(self.m_groupContent)
    local starX = relativePos.x
    local middleX = starX + w / 2
    local endX = starX + w
    return starX, middleX, endX
end

function getScreenW(self)
    local w, h = ScreenUtil:getScreenSize(nil)
    return w
end

function __recoverBiographyItem(self)
    for _, item in pairs(self.mBiographyItemDic) do
        item:recover()
    end
    self.mBiographyItemDic = {}
end

function __recoverDupItem(self)
    for i = #self.m_itemList, 1, -1 do
        local item = self.m_itemList[i]
        item:poolRecover()
        table.remove(self.m_itemList, i)
    end
end

-- 副本信息
function __onOpenDupInfoHandler(self, heroTid, biographyId, stageId)
    if self.gInfoView == nil then
        self.gInfoView = battleMap.HeroBiographyDupInfoView.new()
    end
    if self.isShowInfo and stageId ~= self.lastId then 
        self.gInfoView:showChangeAnimator()
    end
    self.gInfoView:open()
    self.gInfoView:show(heroTid, biographyId, stageId)
    self.m_goToucher:SetActive(true)
    self.isShowInfo = true
end

-- 关闭副本详情
function __onCloseDupViewHandler(self)
    if self.gInfoView then
        self.gInfoView:DelayDestroy()
        self.gInfoView = nil
    end
    self.m_goToucher:SetActive(false)
    self.isShowInfo = false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(49010):	"剩余挑战次数："
]]
