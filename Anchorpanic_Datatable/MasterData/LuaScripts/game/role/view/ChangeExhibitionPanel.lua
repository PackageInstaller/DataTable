module("role.ChangeExhibitionPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("role/ChangeExhibitionPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
panelType = 2
isScreensave = 0 --是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(25210))
    self:setSize(1120, 520)
    self:setUICode(LinkCode.HomePage)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    -- 置空将当前面板查看的英雄id
    --当前英雄Id
    self.mCurHeroId = nil
    -- 过滤相同战员
    self.mIsFilterSame = false
    -- 是否查找喜欢的英雄
    self.mIsFindLike = false
    -- 是否查找锁定的英雄
    self.mIsFindLock = false
    -- 是否降序
    self.mIsDescending = true
    -- 选择的排序类型
    self.mSelectSortType = showBoard.panelSortType.LEVEL
    -- 提供的筛选字典
    self.mSelectFilterDic = {}
    for type in pairs(showBoard.panelFilterTypeDic) do
        self.mSelectFilterDic[type] = {}
        self.mSelectFilterDic[type][showBoard.filterSubTypeAll] = true
    end
    self:recover()
end

function recover(self)
    if (self.mHeroScrollList) then
        for i = 1, #self.mHeroScrollList do
            LuaPoolMgr:poolRecover(self.mHeroScrollList[i])
        end
    end
    self.mHeroScrollList = {}
end

function configUI(self)
    super.configUI(self)
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(role.RoleHeroSelectListItem)
    self.mBtnDetermine = self:getChildGO("mBtnDetermine")
    self.mBtnCancel = self:getChildGO("mBtnCancel")
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
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
    self:initData()
end

function active(self, args)
    super.active(self, args)
    self.mCurHeroId = args.heroId
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.ROLE_HERO_LIST_SELECT, self.onSelectItemHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_LIST_INIT, self.onInitHeroListHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_LIST_UPDATE, self.onHeroListUpdateHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.HERO_LIST_SELECT, self.onListSelectHandler, self)
    if (self.mCurHeroId ~= nil) then
        self:setData(false)
    else
        self:setData(true)
    end
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.ROLE_HERO_LIST_SELECT, self.onSelectItemHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_LIST_INIT, self.onInitHeroListHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_LIST_UPDATE, self.onHeroListUpdateHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.HERO_LIST_SELECT, self.onListSelectHandler, self)
    self:onSaveList()
    role.RoleManager:setSelectId(0)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

function onSelectItemHandler(self, args)
    local showHeroList, showHeroPosDic, showHeroIdDic, tempHeroList = role.RoleManager:getRoleVo():getShowHeroData()
    local idx = table.indexof01(tempHeroList, args.heroVo.id)
    -- 已经存在
    if idx > 0 then
        tempHeroList[idx] = -1
        role.RoleManager:getRoleVo():updateTempShowHeroList(tempHeroList)
    else
        --不存在
        local reIdx = table.indexof01(tempHeroList, -1)
        if reIdx == 0 then
            gs.Message.Show(_TT(25171))
            return
        else
            tempHeroList[reIdx] = args.heroVo.id
        end
    end
    role.RoleManager:getRoleVo():updateTempShowHeroList(tempHeroList)
    self:setData(false)
end

function btnCanacelHandler(self)
    local list = {}
    for i = 1, 5 do
        table.insert(list, -1)
    end
    role.RoleManager:getRoleVo():updateTempShowHeroList(list)
    self:setData(false)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnDetermine, 1, "确认")
    self:setBtnLabel(self.mBtnCancel, 25170, "全部卸载")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDetermine, self.btnClickHandler)
    self:addUIEvent(self.mBtnCancel, self.btnCanacelHandler)
end

function btnClickHandler(self, args)
    local list = {}
    local showHeroList, showHeroPosDic, showHeroIdDic, tempHeroList = role.RoleManager:getRoleVo():getShowHeroData()
    for i = 1, #tempHeroList do
        if tempHeroList[i] == -1 then
        else
            table.insert(list, { hero_id = tempHeroList[i], pos = i })
        end
    end
    GameDispatcher:dispatchEvent(EventName.REQ_ROLE_SELECT_HERO, { showHeroList = list })
    self:close()
end

-- 关闭页面保存默认选中
function onSaveList(self)
    local list = {}
    local showHeroList, showHeroPosDic, showHeroIdDic, tempHeroList = role.RoleManager:getRoleVo():getShowHeroData()
    for k = 1, 5 do
        if showHeroPosDic[k] ~= nil then
            table.insert(list, showHeroPosDic[k])
        else
            table.insert(list, -1)
        end
    end
    role.RoleManager:getRoleVo():updateTempShowHeroList(list)
end

-- 英雄列表初始化
function onInitHeroListHandler(self)
    self:setData(true)
end

-- 英雄列表选择
function onListSelectHandler(self, args)
    self.mCurHeroId = args.heroVo.id
    self:setData(false)
end

-- 英雄列表更新
function onHeroListUpdateHandler(self, args)
    if (table.indexof(args.addList, self.mCurHeroId) ~= false) then
        self:setData(false)
    end
end

-- 英雄详细数据更新
function onUpdateHeroDetailDataHandler(self, args)
    if (self.mCurHeroId == args.heroId) then
        self:setData(false)
    end
end

function setData(self, isInit)
    local list, idDic = showBoard.ShowBoardManager:getHeroScrollList(
    nil,
    self.mSelectSortType,
    self.mIsDescending,
    self.mSelectFilterDic,
    self.mIsFilterSame
    )

    if (not idDic[self.mCurHeroId]) then
        if (#list > 0) then
            self.mCurHeroId = list[1]:getDataVo().id
            local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
            if (heroVo and not heroVo:checkIsPreData()) then
                self:recover()
                self.mHeroScrollList = list
            end
        else
            self.mCurHeroId = nil
            self:recover()
        end
    else
        self:recover()
        self.mHeroScrollList = list
    end

    local heroIdList = {}
    -- 查找玩家喜欢或锁定的英雄
    for i = #self.mHeroScrollList, 1, -1 do
        if (self.mIsFindLike and self.mHeroScrollList[i]:getDataVo().isLike ~= 1) then
            if (not self.mIsFindLock or self.mHeroScrollList[i]:getDataVo().isLock ~= 1) then
                LuaPoolMgr:poolRecover(self.mHeroScrollList[i])
                table.remove(self.mHeroScrollList, i)
            end
        elseif (self.mIsFindLock and self.mHeroScrollList[i]:getDataVo().isLock ~= 1) then
            if (not self.mIsFindLike or self.mHeroScrollList[i]:getDataVo().isLike ~= 1) then
                LuaPoolMgr:poolRecover(self.mHeroScrollList[i])
                table.remove(self.mHeroScrollList, i)
            end
        else
            table.insert(heroIdList, 1, self.mHeroScrollList[i]:getDataVo().id)
        end
    end

    self:updateView(isInit)
end

-- 更新界面
function updateView(self, isInit)
    self:updateListView(isInit)
end

-- 更新英雄列表界面
function updateListView(self, isInit)
    local showHeroList, showHeroPosDic, showHeroIdDic, tempHeroList = role.RoleManager:getRoleVo():getShowHeroData()
    if (self.mHeroScrollList) then
        for i = 1, #self.mHeroScrollList do
            local heroScrollVo = self.mHeroScrollList[i]
            local heroVo = heroScrollVo:getDataVo()
            for i = 1, #tempHeroList do
                if tempHeroList[i] == heroVo.id then
                    heroScrollVo:setSelect(true)
                end
            end
        end

        if (isInit or self.mLyScroller.Count <= 0) then
            self.mLyScroller.DataProvider = self.mHeroScrollList
        else
            self.mLyScroller:ReplaceAllDataProvider(self.mHeroScrollList)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25210):	"<size=24>战</size>员展示"
]]