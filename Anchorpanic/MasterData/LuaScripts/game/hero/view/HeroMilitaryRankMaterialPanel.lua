--[[   
     英雄军衔材料选择界面
]]
module('hero.HeroMilitaryRankMaterialPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('hero/HeroMilitaryRankMaterialPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1169, 558)
    self:setTxtTitle('')
end

-- 初始化数据
function initData(self)
    self.m_heroVo = nil
    self.m_itemList = nil
    self.m_headAddList = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.m_groupLeft = self:getChildTrans('GroupLeft')
    self.m_scrollerMaterial = self:getChildTrans('MaterialContent')
    self.m_textTip = self:getChildGO("TextTip"):GetComponent(ty.Text)
    self:getChildGO("TextTip2"):GetComponent(ty.Text).text = _TT(1085)
    self.m_textCurLvl = self:getChildGO("TextCurLvl"):GetComponent(ty.Text)
    self.m_textNextLvl = self:getChildGO("TextNextLvl"):GetComponent(ty.Text)
    self.m_textCurMilitary = self:getChildGO("TextCurMilitary"):GetComponent(ty.Text)
    self.m_textNextMilitary = self:getChildGO("TextNextMilitary"):GetComponent(ty.Text)
    self.m_imgCurIcon = self:getChildGO("ImgCurIcon"):GetComponent(ty.AutoRefImage)
    self.m_imgNextIcon = self:getChildGO("ImgNextIcon"):GetComponent(ty.AutoRefImage)

    self.m_groupRight = self:getChildTrans('GroupRight')
    self.m_scrollerSelect = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.m_scrollerSelect:SetItemRender(hero.HeroMilitaryRankScrollItem)
    self.m_imgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.m_textCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.m_btnUp = self:getChildGO('BtnUp')
    self.m_textEmptyTip = self:getChildGO("TextEmptyTip"):GetComponent(ty.Text)

    self.m_transGuide_1 = self:getChildTrans("Guide_1")
    self.m_transGuide_2 = self:getChildTrans("Guide_2")
end

-- 激活
function active(self, args)
    super.active(self, args)
    hero.HeroMilitaryRankManager:addEventListener(hero.HeroMilitaryRankManager.HERO_MILITARY_RANK_MATERIAL_SELECT, self.__onMaterialSelectHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_LIST_UPDATE, self.__onHeroListUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MILITARY_RANK_PANEL, self.__onMilitaryRankUpdateHandler, self)
    self:setData(args)
end

-- 非激活
function deActive(self)
    super.deActive(self)
    hero.HeroMilitaryRankManager:removeEventListener(hero.HeroMilitaryRankManager.HERO_MILITARY_RANK_MATERIAL_SELECT, self.__onMaterialSelectHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_LIST_UPDATE, self.__onHeroListUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MILITARY_RANK_PANEL, self.__onMilitaryRankUpdateHandler, self)

    self:__recyAllItem()
    self:__recyAllHead()
end

function initViewText(self)
    self:setBtnLabel(self.m_btnUp, 1061, "晋升")
    self.m_textEmptyTip.text = _TT(1083) --"- 暂无可使用的战员 -"
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnUp, self.__onBtnUpHandler)
end

function __recyAllItem(self)
    if (self.m_itemList) then
        for i = 1, #self.m_itemList do
            local item = self.m_itemList[i]
            item:poolRecover()
        end
    end
    self.m_itemList = {}
end

function __recyAllHead(self)
    if (self.m_headAddList) then
        for i = 1, #self.m_headAddList do
            local item = self.m_headAddList[i]
            item:poolRecover()
        end
    end
    self.m_headAddList = {}
end

function setData(self, heroVo)
    self.m_heroVo = heroVo
    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank)
    hero.HeroMilitaryRankManager.needMaterialCount = curMilitaryRankVo.needHeroNum
    hero.HeroMilitaryRankManager.materialHeroIdList = {}
    self:__updateView()
end

function __updateView(self)
    self:__updateLeftView()
    self:__updateMaterialView()
    self:__updateTextView()
    self:__updateGuide()

    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank)
    local nextMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank + 1)

    -- 等级上限、军衔名显示
    self.m_textCurLvl.text = _TT(1068) .. curMilitaryRankVo.heroMaxLvl--等级上限
    self.m_textNextLvl.text = _TT(1068) .. nextMilitaryRankVo.heroMaxLvl--等级上限
    self.m_textCurMilitary.text = curMilitaryRankVo:getName()
    self.m_textNextMilitary.text = nextMilitaryRankVo:getName()
    self.m_imgCurIcon:SetImg(UrlManager:getHeroMilitaryRankIconUrl(curMilitaryRankVo.lvl), false)
    self.m_imgNextIcon:SetImg(UrlManager:getHeroMilitaryRankIconUrl(nextMilitaryRankVo.lvl), false)
end

function __updateLeftView(self)
    self:__recyAllItem()
end

function __updateMaterialView(self, args)
    self:__recyAllHead()
    local materialIdList = hero.HeroMilitaryRankManager.materialHeroIdList
    local needMaterialCount = hero.HeroMilitaryRankManager.needMaterialCount
    for i = 1, needMaterialCount do
        local heroVo = hero.HeroManager:getHeroVo(materialIdList[i])
        local item = hero.HeroMilitaryRankAddItem:create(self.m_scrollerMaterial, heroVo)
        if (heroVo) then
            item:setLvl(heroVo.lvl)
        end
        table.insert(self.m_headAddList, item)
        item:setCallBack(self, self.__onClickMaterialHandler)
    end
    if (args) then
        self:__updateRightView(false)
    else
        self:__updateRightView(true)
    end
end

function __updateRightView(self, isInit)
    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank)
    local list = hero.HeroMilitaryRankManager:getHeroScrollList(curMilitaryRankVo.needHeroLvl, self.m_heroVo.id)
    local materialIdList = hero.HeroMilitaryRankManager.materialHeroIdList
    for i = 1, #list do
        local heroScrollVo = list[i]
        heroScrollVo:setSelect(false)
        local heroVo = heroScrollVo:getDataVo()
        for j = 1, #materialIdList do
            if (heroVo.id == materialIdList[j]) then
                heroScrollVo:setSelect(true)
                break
            end
        end
    end
    self:recoverListData(self.m_scrollerSelect.DataProvider)
    if isInit then
        self.m_scrollerSelect.DataProvider = list
    else
        self.m_scrollerSelect:ReplaceAllDataProvider(list)
    end
    self.m_textEmptyTip.gameObject:SetActive(#list <= 0)
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function __updateTextView(self)
    local maxMilitaryRank = hero.HeroMilitaryRankManager:getMaxMilitaryRankLvl(self.m_heroVo.tid)
    -- 军衔已满阶
    if (self.m_heroVo.militaryRank >= maxMilitaryRank) then
        self.m_textTip.text = "--"
        self.m_textCost.text = "--"
        self.m_textCost.color = gs.ColorUtil.GetColor("FFFFFFFF")
        self.m_btnUp:SetActive(false)
    else
        local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank)
        self.m_textTip.text = string.substitute(_TT(1070), curMilitaryRankVo.needHeroNum, curMilitaryRankVo.needHeroLvl)--"晋升需要{0}名{1}级战员"
        local costTid = curMilitaryRankVo.cost[1]
        local costCount = curMilitaryRankVo.cost[2]
        self.m_imgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)
        self.m_textCost.text = costCount
        self.m_textCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(costTid, costCount, false, false) and "FFFFFFFF" or "ed1941FF")
        self.m_btnUp:SetActive(true)
    end
end

function __updateGuide(self)
    self:setGuideTrans("weak_hero_militaryUp_1", self.m_transGuide_1)
    self:setGuideTrans("weak_hero_militaryUp_2", self.m_transGuide_2)
end

-- 英雄军衔更新
function __onMilitaryRankUpdateHandler(self, args)
    local heroId = args.heroId
    if (self.m_heroVo.id == heroId) then
        self:__onHeroListUpdateHandler()
    end
end

-- 英雄列表更新
function __onHeroListUpdateHandler(self)
    self.m_heroVo = hero.HeroManager:getHeroVo(self.m_heroVo.id)
    self:setData(self.m_heroVo)
end

function __materialSelectHandler(self, args)
    local isAdd = true
    local clickHeroVo = args
    local materialIdList = hero.HeroMilitaryRankManager.materialHeroIdList
    local len = #materialIdList
    for i = 1, len do
        if (materialIdList[i] == clickHeroVo.id) then
            table.remove(materialIdList, i)
            isAdd = false
            break
        end
    end

    if (isAdd) then
        local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank)
        if (len >= curMilitaryRankVo.needHeroNum) then
            gs.Message.Show(_TT(1071))--"已经选满了"
            return
        else
            table.insert(materialIdList, clickHeroVo.id)
        end
    end
    self:__updateMaterialView({ isAdd = isAdd, heroVo = clickHeroVo })
end

function __onMaterialSelectHandler(self, heroVo)
    local function select()
        self:__materialSelectHandler(heroVo)
    end

    local materialIdList = hero.HeroMilitaryRankManager.materialHeroIdList
    if table.indexof(materialIdList, heroVo.id) ~= false then
        select()
        return
    end

    if self.m_heroVo.lvl < heroVo.lvl then
        -- local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.HERO_MILITARY_LEVEL_UP_SELECT)
        -- if (isNotRemind) then
        --     select();
        -- else
        UIFactory:alertMessge(_TT(1086), true, function()
            select()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.HERO_MILITARY_LEVEL_UP_SELECT
        )
        -- end
    elseif self.m_heroVo.militaryRank < heroVo.militaryRank then
        -- local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.HERO_MILITARY_RANK_UP_SELECT)
        -- if (isNotRemind) then
        --     select();
        -- else
            -- "所选战员军阶等级大于晋升所需战员军阶等级，是否继续添加？"
        UIFactory:alertMessge(_TT(1088), true, function()
            select()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.HERO_MILITARY_RANK_UP_SELECT
        )
        -- end
    else
        select()
    end
end

function __onClickMaterialHandler(self, scrollData, args)
    local heroVo = scrollData
    if (heroVo) then
        self:__materialSelectHandler(heroVo)
    end
end

function __onBtnUpHandler(self)
    local materialIdList = hero.HeroMilitaryRankManager.materialHeroIdList
    local len = #materialIdList
    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank)
    if (len >= curMilitaryRankVo.needHeroNum) then

        local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.m_heroVo.tid, self.m_heroVo.militaryRank)
        local costTid = curMilitaryRankVo.cost[1]
        local costCount = curMilitaryRankVo.cost[2]
        if (MoneyUtil.judgeNeedMoneyCountByTid(costTid, costCount, true)) then
            local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.HERO_MILITARY_RANK_UP)
            if (isNotRemind) then
                GameDispatcher:dispatchEvent(EventName.REQ_HERO_MILITARY_RANK_UP, { heroId = self.m_heroVo.id, costHeroIdList = materialIdList })
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_MILITARY_RANK_MATERIAL_TIP_PANEL, { heroId = self.m_heroVo.id })
            end
        end
    else
        gs.Message.Show(_TT(1072))--"请选择足够数量的战员"
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
