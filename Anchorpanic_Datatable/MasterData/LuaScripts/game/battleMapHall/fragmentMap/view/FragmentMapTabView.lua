module("battleMap.FragmentMapTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("battleMapHall/fragmentMap/FragmentMapTabView.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
--构造函数
function ctor(self)
    super.ctor(self)
end


function initData(self)
    self.mNowSelectChapter = 1
end

function configUI(self)
    self.mRectLeft = self:getChildGO("mGroupLeft"):GetComponent(ty.RectTransform)

    self.mLyScrollerGo = self:getChildGO("LyScroller")
    self.mLyScrollRect = self.mLyScrollerGo:GetComponent(ty.ScrollRect).content:GetComponent(ty.RectTransform)
    self.mLyScroller = self.mLyScrollerGo:GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(battleMap.FragmentChapterItem)

    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtIntroduce = self:getChildGO("mTxtIntroduce"):GetComponent(ty.Text)
    self.mBtnGoIn = self:getChildGO("mBtnGoIn")
    self.mBtnUnlock = self:getChildGO("mBtnUnlock")
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)

    self.mImgTabBg_1 = self:getChildGO("mImgTabBg_1"):GetComponent(ty.AutoRefImage)
    self.mImgTabBg_2 = self:getChildGO("mImgTabBg_2"):GetComponent(ty.AutoRefImage)

    self.mTxtHasNum = self:getChildGO("mTxtHasNum"):GetComponent(ty.Text)
    self.mTxtLimitNum = self:getChildGO("mTxtLimitNum"):GetComponent(ty.Text)
end

-- 玩家点击关闭
function onClickClose(self)
    self:playerClose()
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:playerClose()
    super.onCloseAllCall(self)
end

function playerClose(self)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    self:updateLeftView(true)
    GameDispatcher:addEventListener(EventName.UPDATA_FRAGMENT_CHAPTERVIEW, self.ChangeChapter, self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateRedHandler, self)
end

function deActive(self)
    self.mLyScroller:SetMoveCall(nil, nil)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
    GameDispatcher:removeEventListener(EventName.UPDATA_FRAGMENT_CHAPTERVIEW, self.ChangeChapter, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateRedHandler, self)
end

function initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGoIn, self.onClickGoIn)
    self:addUIEvent(self.mBtnUnlock, self.onClickUnlock)
end

function updateRedHandler(self, args)
    if args.type == ReadConst.FRAGMENTS then 
        battleMap.FragmentMapManager:getIsChapterHasBubble()
        self:updateLeftView()
    end
end

function onClickGoIn(self)
    local nowChapter = battleMap.FragmentMapManager:getChapterVo(battleMap.FragmentMapManager:getNowSelectChapter())
    if battleMap.FragmentMapManager:getChapterRed(nowChapter.chapterId) then 
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.FRAGMENTS, id = nowChapter.chapterId })
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_FRAGMENT_STAGEVIEW, { chapterVo = nowChapter })
end

function onClickUnlock(self)
    -- 材料够 请求解锁
    local restNum = sysParam.SysParamManager:getValue(SysParamType.UNLOCK_FRAGMENT_TIME) - battleMap.FragmentMapManager.mUnlockTime
    if restNum > 0 then 
        GameDispatcher:dispatchEvent(EventName.REQ_UNLOCK_FRAGMENT, {id = battleMap.FragmentMapManager:getNowSelectChapter()})
    else
        gs.Message.Show(_TT(85051))
    end
end

function ChangeChapter(self, index)
    if self.mNowSelectChapter ~= index then 
        self.mImgTabBg_2:SetImg(string.format("arts/ui/bg/mainMap/maindz_bg.jpg",index),false)
        self.mImgTabBg_1:SetImg(string.format("arts/ui/bg/mainMap/maindz_bg.jpg",self.mNowSelectChapter),false)
        self.mImgTabBg_2:GetComponent(ty.UIDoTween):EndTween()
        self.mImgTabBg_2:GetComponent(ty.UIDoTween):BeginTween()
        self.mNowSelectChapter = index  
    end
    self:updateLeftView()
end

function updateLeftView(self, isInit)
    local list = battleMap.FragmentMapManager:getChapterList()
    table.sort( list, function(a, b)
        local completeA = battleMap.FragmentMapManager:getChapterComplete(a.chapterId)
        local completeB = battleMap.FragmentMapManager:getChapterComplete(b.chapterId)
        if completeA == completeB then 
            return a.chapterId < b.chapterId
        else 
            return completeB
        end
    end )
    if #list > 0 then 
        list[#list].isEnd = true
    end
    if (self.mLyScroller.Count <= 0 or cusIsInit == true) then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
    self:updateRightView()
end

function updateRightView(self)
    local nowChapter = battleMap.FragmentMapManager:getChapterVo(battleMap.FragmentMapManager:getNowSelectChapter())
    self.mTxtTitle.text = _TT(nowChapter.m_name)
    self.mTxtIntroduce.text = nowChapter.lang
    self.mTxtLimitNum.text = "/" .. sysParam.SysParamManager:getValue(SysParamType.UNLOCK_FRAGMENT_TIME)
    local restNum = sysParam.SysParamManager:getValue(SysParamType.UNLOCK_FRAGMENT_TIME) - battleMap.FragmentMapManager.mUnlockTime
    self.mTxtHasNum.text = restNum
    if restNum <= 0 then
        self.mTxtCost.color = gs.ColorUtil.GetColor("bd2a2aff")
        self.mTxtHasNum.color = gs.ColorUtil.GetColor("bd2a2aff") 
    else
        self.mTxtCost.color = gs.ColorUtil.GetColor("ffffffff")
        self.mTxtHasNum.color = gs.ColorUtil.GetColor("ffffffff")
    end

    local lock = battleMap.FragmentMapManager:getChapterIsLock(battleMap.FragmentMapManager:getNowSelectChapter())
    if lock then 
        self.mBtnGoIn:SetActive(false)
        self.mBtnUnlock:SetActive(true)
        self.mTxtCost.text = 1 
    else 
        self.mBtnGoIn:SetActive(true)
        self.mBtnUnlock:SetActive(false)
    end

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]