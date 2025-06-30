module('role.RoleSelectHeroPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('role/RoleSelectHeroPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    --self:setSize(0, 0)
    --self:setBg("", false)
end

function initData(self)
    self.m_leftTween = nil
    self.m_rightTween = nil

    -- 是否查找喜欢的英雄
    self.m_isFindLike = false
    -- 是否显示排序界面
    self.m_isShowSort = false
    self.m_isDescending = true
    self.m_tempIsDescending = true
    self.m_selectSortType = showBoard.panelSortType.LEVEL
    self.m_tempSelectSortType = self.m_selectSortType
    self.m_selectFilterDic = {}
    self.m_tempSelectFilterDic = {}
    for type in pairs(showBoard.panelFilterTypeDic) do
        self.m_selectFilterDic[type] = {}
        self.m_selectFilterDic[type][showBoard.filterSubTypeAll] = true
        self.m_tempSelectFilterDic[type] = {}
        self.m_tempSelectFilterDic[type][showBoard.filterSubTypeAll] = true
    end
    self:__recover()
end

function __recover(self)
    if self.m_leftTween then
        self.m_leftTween:Kill()
        self.m_leftTween = nil
    end
    if self.m_rightTween then
        self.m_rightTween:Kill()
        self.m_rightTween = nil
    end
    if (self.m_heroScrollList) then
        for i = 1, #self.m_heroScrollList do
            LuaPoolMgr:poolRecover(self.m_heroScrollList[i])
        end
    end
    self.m_heroScrollList = {}
end

function configUI(self)
    --self.m_modelNode = self:getChildTrans("ModelNode")
    --self.m_modelClicker = self:getChildGO("ClickerArea")
    --self.m_modelPlayer = ModelScenePlayer.new()
    self.m_btnAll = self:getChildGO("BtnAll")
    self.m_btnLike = self:getChildGO("BtnLike")
    self.m_btnSort = self:getChildGO("BtnSort")

    self.m_scroll = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.m_scroll:SetItemRender(role.RoleSelectHeroItem)

    self.m_btnLeft = self:getChildGO("BtnLeft")
    self.m_leftAlpha = self.m_btnLeft:GetComponent(ty.CanvasGroup)
    self.m_btnRight = self:getChildGO("BtnRigth")
    self.m_rightAlpha = self.m_btnRight:GetComponent(ty.CanvasGroup)
    self.m_btnConfirm = self:getChildGO("BtnConfirm")
    self.m_imgConfirm = self.m_btnConfirm:GetComponent(ty.AutoRefImage)

    self.m_textEmptyTip = self:getChildGO("TextEmptyTip"):GetComponent(ty.Text)
    self.m_cancelBtn = self:getChildGO("BtnCancel")
end

function initViewText(self)
    self:setBtnLabel(self.m_btnAll, 4011, "全部")
    self:setBtnLabel(self.m_btnLike, 1029, "喜欢")
end

function addAllUIEvent(self)
    --self:addUIEvent(self.m_btnLeft, self.__onClickLeftHandler)
    --self:addUIEvent(self.m_btnRight, self.__onClickRightHandler)
    self:addUIEvent(self.m_btnConfirm, self.__onClickConfirmHandler)

    self:addUIEvent(self.m_btnAll, self.__onClickSortAllHandler)
    self:addUIEvent(self.m_btnLike, self.__onClickSortLikeHandler)
    self:addUIEvent(self.m_btnSort, self.__onOpenSortViewHandler)
    self:addUIEvent(self.m_cancelBtn, self.onClickClose)
end

function active(self, args)
    super.active(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.ROLE_HERO_LIST_SELECT, self.__onSelectItemHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.__onUpdateHeroDetailDataHandler, self)
    self.m_timeFrameSn = LoopManager:addFrame(1, 0, self, self.__updateArrowStateHandler)

    self.m_selectPos = args.pos
    self.m_posHeroId = args.heroId
    self.m_curHeroId = args.heroId
    self:setData(true)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.ROLE_HERO_LIST_SELECT, self.__onSelectItemHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.__onUpdateHeroDetailDataHandler, self)
    LoopManager:removeFrameByIndex(self.m_timeFrameSn)
    self:__recoverModel(true)
    self:__recover()
end

-- 点击排序全部
function __onClickSortAllHandler(self)
    self:initData()
    self:setData(true)
end

-- 点击排序喜欢的英雄
function __onClickSortLikeHandler(self)
    self.m_isInitOpen = true
    self.m_isFindLike = true
    self:setData(true)
end

-- 点击排序状态按钮
function __onOpenSortViewHandler(self)
    self.m_isShowSort = not self.m_isShowSort
    self:__updateView(false)

    if (self.m_isShowSort) then
        if (not self.m_sortPanel) then
            self.m_sortPanel = hero.HeroListSortPanel.new()
        end
        local cancelFun = function()
            self.m_isShowSort = false
            self:setData(false)
            self.m_sortPanel:close()
        end
        local confirmFun = function(tempSelectSortType, tempIsDescending, tempSelectFilterDic)
            self.m_isShowSort = false
            self.m_selectSortType = tempSelectSortType
            self.m_selectFilterDic = {}
            for type, dic in pairs(tempSelectFilterDic) do
                if (not self.m_selectFilterDic[type]) then
                    self.m_selectFilterDic[type] = {}
                end
                for subType, data in pairs(dic) do
                    self.m_selectFilterDic[type][subType] = data
                end
            end
            self.m_isDescending = tempIsDescending
            self.m_isFindLike = false
            self:setData(true)
            self.m_sortPanel:close()
        end

        local data = {}
        data['tempSelectFilterDic'] = self.m_selectFilterDic
        data['tempSelectSortType'] = self.m_selectSortType
        data['tempIsDescending'] = self.m_isDescending
        data['cancelCallFun'] = cancelFun
        data['confirmCallFun'] = confirmFun
        self.m_sortPanel:open(data)
    end
end

-- item选择
function __onSelectItemHandler(self, args)
    if (self.m_curHeroId ~= args.heroVo.id) then
        self.m_curHeroId = args.heroVo.id
        self:setData(false)
    end
end

function __onClickLeftHandler(self)
    if (not self.m_scroll:IsInLeft()) then
        self.m_scroll:JumpToLeft()
    end
end

function __onClickRightHandler(self)
    if (not self.m_scroll:IsInRight()) then
        self.m_scroll:JumpToRight()
    end
end

-- 点击确认
function __onClickConfirmHandler(self, args)
    local list = {}
    local showHeroList, showHeroPosDic, showHeroIdDic = role.RoleManager:getRoleVo():getShowHeroData()
    if (self.m_posHeroId == nil) then
        if (showHeroIdDic[self.m_curHeroId]) then 				--更换位置
            for k, v in pairs(showHeroList) do
                if (self.m_curHeroId == v.heroId) then
                    table.insert(list, { pos = self.m_selectPos, hero_id = v.heroId })
                else
                    table.insert(list, { pos = v.pos, hero_id = v.heroId })
                end
            end
        else													--添加展示
            for k, v in pairs(showHeroList) do
                table.insert(list, { pos = v.pos, hero_id = v.heroId })
            end
            table.insert(list, { pos = self.m_selectPos, hero_id = self.m_curHeroId })
        end
    else
        if (self.m_posHeroId == self.m_curHeroId) then			--卸载展示
            for k, v in pairs(showHeroList) do
                if (self.m_curHeroId ~= v.heroId) then
                    table.insert(list, { pos = v.pos, hero_id = v.heroId })
                end
            end
        else
            if (showHeroIdDic[self.m_curHeroId]) then 			--交换位置
                for k, v in pairs(showHeroList) do
                    if (v.heroId == self.m_posHeroId) then
                        table.insert(list, { pos = showHeroIdDic[self.m_curHeroId], hero_id = v.heroId })
                    elseif (v.heroId == self.m_curHeroId) then
                        table.insert(list, { pos = self.m_selectPos, hero_id = v.heroId })
                    else
                        table.insert(list, { pos = v.pos, hero_id = v.heroId })
                    end
                end
            else												--更换展示
                for k, v in pairs(showHeroList) do
                    if (self.m_selectPos == v.pos) then
                        table.insert(list, { pos = v.pos, hero_id = self.m_curHeroId })
                    else
                        table.insert(list, { pos = v.pos, hero_id = v.heroId })
                    end
                end
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.REQ_ROLE_SELECT_HERO, { pos = self.m_selectPos, showHeroList = list })
    self:close()
end

-- 英雄详细数据更新
function __onUpdateHeroDetailDataHandler(self, args)
    if (self.m_curHeroId == args.heroId) then
        self:setData(false)
    end
end

function setData(self, isInit)
    local list, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending), self.m_selectFilterDic
    if (not idDic[self.m_curHeroId]) then
        if (#list > 0) then
            self.m_curHeroId = list[1]:getDataVo().id
            local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
            if (heroVo and not heroVo:checkIsPreData()) then
                self:__recover()
                self.m_heroScrollList = list
                -- local heroScrollList, isInclude = hero.HeroManager:getHeroScrollList(hero.panelSortType.ALL, self.m_sortSubType, self.m_curHeroId)
            end
        else
            self.m_curHeroId = nil
            self:__recover()
        end
    else
        self:__recover()
        self.m_heroScrollList = list
    end

    -- 查找玩家喜欢的英雄
    if (self.m_isFindLike) then
        for i = #self.m_heroScrollList, 1, -1 do
            if (self.m_heroScrollList[i]:getDataVo().isLike ~= 1) then
                LuaPoolMgr:poolRecover(self.m_heroScrollList[i])
                table.remove(self.m_heroScrollList, i)
            end
        end
    end
    self:__updateView(isInit)
end

function __updateView(self, cusIsInit)
    if (not self.m_isShowSort) then
        self:__updateListView(cusIsInit)
    end
end

-- 更新英雄列表界面
function __updateListView(self, isInit)
    if (self.m_heroScrollList) then
        for i = 1, #self.m_heroScrollList do
            local heroScrollVo = self.m_heroScrollList[i]
            local heroVo = heroScrollVo:getDataVo()
            if (self.m_curHeroId == heroVo.id) then
                heroScrollVo:setSelect(true)
                self:__updateModelView(heroVo)
            else
                heroScrollVo:setSelect(false)
            end
        end

        if (isInit or self.m_scroll.Count <= 0) then
            self.m_scroll.DataProvider = self.m_heroScrollList
        else
            self.m_scroll:ReplaceAllDataProvider(self.m_heroScrollList)
        end

        if (#self.m_heroScrollList <= 0) then
            self.m_textEmptyTip.gameObject:SetActive(true)
            if (self.m_isFindLike) then
                self.m_textEmptyTip.text = _TT(25212)
            else
                self.m_textEmptyTip.text = _TT(1338)
            end
            self:__recoverModel(false)
        else
            self.m_textEmptyTip.gameObject:SetActive(false)
            self:__tweenArrow()
        end

        self:__updateBtnHandler()
    end
end

-- 更新模型
function __updateModelView(self, heroVo)
    -- if (heroVo) then
    --     self.m_modelPlayer:setData(heroVo.id, false, 1, true, MainCityConst.ROLE_MODE_INTERACTION, "", self.m_modelClicker, true, nil)
    -- else
    --     self:__recoverModel(false)
    -- end
end

function __recoverModel(self, isResetMaincity)
    --self.m_modelPlayer:reset(isResetMaincity)
end

function __updateBtnHandler(self)
    self.m_btnConfirm:SetActive(#self.m_heroScrollList > 0)
    local showHeroList, showHeroPosDic, showHeroIdDic = role.RoleManager:getRoleVo():getShowHeroData()
    if (self.m_posHeroId == nil) then
        if (showHeroIdDic[self.m_curHeroId]) then 				--更换位置
            self:setBtnLabel(self.m_btnConfirm, nil, "更换位置")
            self.m_imgConfirm:SetImg(UrlManager:getCommon4Path("common_3404.png"), false)
        else													--添加展示
            self:setBtnLabel(self.m_btnConfirm, nil, "添加展示")
            self.m_imgConfirm:SetImg(UrlManager:getCommonPath("common_3404.png"), false)
        end
    else
        if (self.m_posHeroId == self.m_curHeroId) then			--卸载展示
            self:setBtnLabel(self.m_btnConfirm, nil, "卸载展示")
            self.m_imgConfirm:SetImg(UrlManager:getCommonPath("common_3404.png"), false)
        else
            if (showHeroIdDic[self.m_curHeroId]) then 			--交换位置
                self:setBtnLabel(self.m_btnConfirm, nil, "交换位置")
                self.m_imgConfirm:SetImg(UrlManager:getCommonPath("common_3404.png"), false)
            else												--更换展示
                self:setBtnLabel(self.m_btnConfirm, nil, "更换展示")
                self.m_imgConfirm:SetImg(UrlManager:getCommonPath("common_3404.png"), false)
            end
        end
    end
end

function __updateArrowStateHandler(self)
    -- if(self.m_scroll:IsInLeft())then
    -- 	self.m_btnLeft:SetActive(false)
    -- else
    -- 	self.m_btnLeft:SetActive(true)
    -- end

    -- if(self.m_scroll:IsInRight())then
    -- 	self.m_btnRight:SetActive(false)
    -- else
    -- 	self.m_btnRight:SetActive(true)
    -- end
end

function __tweenArrow(self)
    --self.m_leftTween = TweenFactory:canvasGroupAlphaTo(self.m_leftAlpha, 1, 0.01, 0.8, nil, nil, nil, true)
    --self.m_rightTween = TweenFactory:canvasGroupAlphaTo(self.m_rightAlpha, 1, 0.01, 0.8, nil, nil, nil, true)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25212):	"- 当前暂无喜欢的战员 -"
	语言包: _TT(1338):	"- 当前暂无战员 -"
]]