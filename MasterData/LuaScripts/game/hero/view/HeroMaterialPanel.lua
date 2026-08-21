--[[   
     英雄通用材料选择界面
]]
module('hero.HeroMaterialPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('hero/HeroMaterialPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
blurTweenTime = 0 --模糊背景的渐变时间（仅2弹窗面板有效，默认不渐变，单位秒）
isScreensave = 0 --是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(nil, nil)
    self:setTxtTitle('')
end

-- 初始化数据
function initData(self)
    -- 是否降序
    self.mIsDescending = true
    -- 选择的排序类型
    self.mSelectSortType = showBoard.panelSortType.LEVEL
    -- 是否默认显示处于状态的
    self.mIsFilterUseState = true
    -- 已选择的英雄id列表
    self.mSelectIdList = {}

    -- 外部设置的显示标题
    self.mTitle = nil
    -- 外部设置的英雄列表
    self.mHeroList = nil
    -- 外部设置的英雄选择的数量上限
    self.mLimitCount = nil
    -- 外部设置的不再提示内容
    self.mConfirmTip = nil
    -- 外部设置的不再提示类型
    self.mConfirmRemindType = nil
    -- 外部设置的不再提示的检查方法
    self.mCheckIsTipFun = nil
    -- 外部设置的消耗货币tid
    self.mCostMoneyTid = nil
    -- 外部设置的消耗货币数量
    self.mCostMoneyCount = nil
    -- 外部设置的回调方法
    self.mCallFun = nil
    -- 外部设置的回调设置显示隐藏方法
    self.mVisibleCallFun = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnStateNo = self:getChildGO('BtnStateNo')
    self.mBtnClose = self:getChildGO('BtnClose')
    self.mBtnConfirm1 = self:getChildGO('BtnConfirm1')
    self.mBtnConfirm2 = self:getChildGO('BtnConfirm2')
    self.mImgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.mTextCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.mFilterNode = self:getChildTrans('NodeFilter')
    self.mTextTip = self:getChildGO("TextTip"):GetComponent(ty.Text)
    self.mTextCountTip = self:getChildGO("TextCountTip"):GetComponent(ty.Text)
    self.mTextCount = self:getChildGO("TextCount"):GetComponent(ty.Text)

    self.mScroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(hero.HeroMaterialItem)

    self.mGoEmpty = self:getChildGO('GoEmpty')
    self.mTextEmpty = self:getChildGO("TextEmpty"):GetComponent(ty.Text)
    
    self.mSortView = hero.HeroSortView.new()
    self.mSortView:setParentTrans(self.mFilterNode)
    -- 点击排序item
    local function __onClickSortItemHandler(self)
        self.mIsFilterUseState = self.mSortView:getIsFilterUseState()
        self.mIsDescending = self.mSortView:getIsDescending()
        self.mSelectSortType = self.mSortView:getSortFilterType()
        self:__updateView()
    end
    self.mSortView:setCallBack(self, __onClickSortItemHandler)
end

function setMask(self)
    super.setMask(self)
    if(self.mask)then
        self.mask:SetActive(false)
    end
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)

    if self.mSortView then
        self.mSortView:destroy()
        self.mSortView = nil
    end
end

-- 激活
function active(self, args)
    super.active(self, args)
    hero.HeroSkillUpManager:addEventListener(hero.HeroManager.HERO_MATERIAL_SELECT, self.__onMaterialSelectHandler, self)
    if(self.mVisibleCallFun)then
        self.mVisibleCallFun(true)
    end
end

-- 非激活
function deActive(self)
    super.deActive(self)
    hero.HeroSkillUpManager:removeEventListener(hero.HeroManager.HERO_MATERIAL_SELECT, self.__onMaterialSelectHandler, self)
    self.mSortView:resetAll()
    if(self.mVisibleCallFun)then
        self.mVisibleCallFun(false)
    end
end

function initViewText(self)
    self:setBtnLabel(self.mBtnConfirm1, 1, "确定")
    self:setBtnLabel(self.mBtnConfirm2, 1180, "确认选择")
    self.mTextEmpty.text = _TT(1337)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnConfirm1, self.__onClickConfirmHandler)
    self:addUIEvent(self.mBtnConfirm2, self.__onClickConfirmHandler)
end

function __onClickConfirmHandler(self)
    local function _callFun ()
        self:close()
        if(self.mCallFun)then
            self.mCallFun(self.mSelectIdList)
        end
    end
    local function _checkTip()
        if(self.mConfirmTip and self.mConfirmRemindType)then
            local isNeedTip = true
            if(self.mCheckIsTipFun)then
                isNeedTip = self.mCheckIsTipFun(self.mSelectIdList)
            end
            if(isNeedTip)then
                -- local isNotRemind = remind.RemindManager:isTodayNotRemain(self.mConfirmRemindType)
                -- if (isNotRemind) then
                --     _callFun()
                -- else
                UIFactory:alertMessge(self.mConfirmTip, true, function()
                    _callFun()
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, self.mConfirmRemindType
                )
                -- end
            else
                _callFun()
            end
        else
            _callFun()
        end
    end
    local function _checkMoney()
        if(self.mCostMoneyTid and self.mCostMoneyCount)then
            if(MoneyUtil.judgeNeedMoneyCountByTid(self.mCostMoneyTid, self.mCostMoneyCount, false, true))then
                _checkTip()
            end
        else
            _checkTip()
        end
    end
    if(self.mLimitCount)then
        if(#self.mSelectIdList >= self.mLimitCount)then
            _checkMoney()
        else
            gs.Message.Show(string.format(_TT(1153), self.mLimitCount - #self.mSelectIdList)) -- 请选择%s个战员
        end
    else
        _checkMoney()
    end
end

-- 设置外部回调设置显示隐藏方法
function setVisibleCall(self, visibleCallFun)
    self.mVisibleCallFun = visibleCallFun
end

function setSelectHeroId(self, heroId)
    if(heroId and table.indexof(self.mSelectIdList, heroId) == false)then
        table.insert(self.mSelectIdList, heroId)
    end
end

-- 设置外部回调方法
function setData(self, title, heroList, limitCount, confirmTip, confirmRemindType, checkIsTipFun, costMoneyTid, costMoneyCount, callFun)
    self.mTitle = title
    self.mHeroList = heroList
    self.mLimitCount = limitCount
    self.mConfirmTip = confirmTip
    self.mConfirmRemindType = confirmRemindType
    self.mCheckIsTipFun = checkIsTipFun
    self.mCostMoneyTid = costMoneyTid
    self.mCostMoneyCount = costMoneyCount
    self.mCallFun = callFun
    self:__updateView()
end

function __updateView(self)
    self:__updateFilterView()

    local heroScrollList = {}
    if(self.mHeroList)then
        for i = 1, #self.mHeroList do
            local heroVo = self.mHeroList[i]
            if(self.mIsFilterUseState or hero.HeroUseCodeManager:getIsCanUse(heroVo.id, false))then
                local heroScrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
                heroScrollVo:setDataVo(heroVo)
                if(table.indexof(self.mSelectIdList, heroVo.id) ~= false)then
                    heroScrollVo:setSelect(true)
                else
                    heroScrollVo:setSelect(false)
                end
                table.insert(heroScrollList, heroScrollVo)
            else
                -- 检查一下该英雄是不是被过滤了
                local _index = table.indexof01(self.mSelectIdList, heroVo.id)
                if(_index > 0)then
                    table.remove(self.mSelectIdList, _index)
                end
            end
        end
        heroScrollList = showBoard.ShowBoardManager:getHeroScrollList1(self.mSelectSortType, self.mIsDescending, heroScrollList)
    end
    
    self:recoverListData(self.mScroller.DataProvider)
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = heroScrollList
    else
        self.mScroller:ReplaceAllDataProvider(heroScrollList)
    end
    self.mGoEmpty:SetActive(#heroScrollList <= 0)

    self.mTextTip.text = self.mTitle
    self:__updateSelect()
    self:__updateCost()
end

function __updateFilterView(self)
    self.mSortView:setFilterUseState(true, self.mIsFilterUseState, -220, 0)
    self.mSortView:addSortMenu(showBoard.panelSortTypeList, self.mSelectSortType, self.mIsDescending, false)
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function __updateSelect(self)
    if(self.mLimitCount)then
        self.mTextCount.text = string.format("%s/%s", #self.mSelectIdList, self.mLimitCount)
    else
        self.mTextCount.text = ""
    end
end

function __updateCost(self)
    if(self.mCostMoneyTid and self.mCostMoneyCount)then
        self.mBtnConfirm1:SetActive(true)
        self.mBtnConfirm2:SetActive(false)
        self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.mCostMoneyTid), true)
        self.mTextCost.text = self.mCostMoneyCount
        self.mTextCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(self.mCostMoneyTid, self.mCostMoneyCount, false, false) and "FFFFFFFF" or "ed1941FF")
    else
        self.mBtnConfirm1:SetActive(false)
        self.mBtnConfirm2:SetActive(true)
    end
end

function __onMaterialSelectHandler(self, args)
    local heroVo = args.heroVo
    local heroId = heroVo.id
    if(hero.HeroUseCodeManager:getIsCanUse(heroId, true, {hero.HeroUseCodeManager.IN_LOCKING}))then
        local function _selectMaterial()
            local index = table.indexof01(self.mSelectIdList, heroId)
            if(index > 0)then
                -- 取消选择
                table.remove(self.mSelectIdList, index)
            else
                -- 添加选择
                if(self.mLimitCount)then
                    if(#self.mSelectIdList >= self.mLimitCount)then
                        gs.Message.Show(_TT(1071))--"已经选满了"
                    else
                        table.insert(self.mSelectIdList, heroId)
                    end
                else
                    table.insert(self.mSelectIdList, heroId)
                end
            end
            self:__updateView()
        end
        if(heroId ~= sysParam.SysParamManager:getValue(SysParamType.FIRST_HERO_ID))then
            if(hero.HeroUseCodeManager:isInUse(heroId, hero.HeroUseCodeManager.IN_LOCKING))then
                UIFactory:alertMessge(_TT(1147), true, function() -- 该战员已锁定，是否解锁并选中？
                    GameDispatcher:dispatchEvent(EventName.REQ_HERO_LOCK_CHANGE, { heroId = heroId, isLock = 0 })
                    _selectMaterial()
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
                )
            else
                _selectMaterial()
            end
        else
            if(hero.HeroUseCodeManager:getIsCanUse(heroId, true, nil))then
                _selectMaterial()
            end
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1337):	"搜索不到对应战员"
]]
