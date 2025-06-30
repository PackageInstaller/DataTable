--[[   
     英雄升品材料选择界面
]]
module('hero.HeroColorUpMaterialPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('hero/HeroColorUpMaterialPanel.prefab')

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
    self:getChildGO("TextTip2"):GetComponent(ty.Text).text = _TT(1118) --"升品条件"
    self.m_imgCurColor = self:getChildGO("ImgCurColor"):GetComponent(ty.AutoRefImage)
    self.m_imgNextColor = self:getChildGO("ImgNextColor"):GetComponent(ty.AutoRefImage)

    self.m_groupRight = self:getChildTrans('GroupRight')
    self.m_scrollerSelect = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.m_scrollerSelect:SetItemRender(hero.HeroColorUpScrollItem)
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
    hero.HeroColorUpManager:addEventListener(hero.HeroColorUpManager.HERO_COLOR_UP_MATERIAL_SELECT, self.__onMaterialSelectHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_LIST_UPDATE, self.__onHeroListUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_COLOR_UP_PANEL, self.__onColorUpdateHandler, self)
    self:setData(args)
end

-- 非激活
function deActive(self)
    super.deActive(self)
    hero.HeroColorUpManager:removeEventListener(hero.HeroColorUpManager.HERO_COLOR_UP_MATERIAL_SELECT, self.__onMaterialSelectHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_LIST_UPDATE, self.__onHeroListUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_COLOR_UP_PANEL, self.__onColorUpdateHandler, self)

    self:__recyAllItem()
    self:__recyAllHead()
end

function initViewText(self)
    self:setBtnLabel(self.m_btnUp, 1109, "升品")
    self.m_textEmptyTip.text = _TT(1119) --"- 暂无可使用的战员 -"
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

function updateBubbleView(self, isFlag)
    if(isFlag)then
        RedPointManager:add(self.m_btnUp.transform, nil, 79, 19)
    else
        RedPointManager:remove(self.m_btnUp.transform)
    end
end

function setData(self, heroVo)
    self.m_heroVo = heroVo
    local nextColorUpVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(self.m_heroVo.tid, self.m_heroVo.color + 1)
    hero.HeroColorUpManager.needMaterialCount = nextColorUpVo.needHeroNum
    hero.HeroColorUpManager.materialHeroIdList = {}
    self:__updateView()
end

function __updateView(self)
    self:__updateLeftView()
    self:__updateMaterialView()
    self:updateBubbleView(hero.HeroFlagManager:getFlag(self.m_heroVo.id, hero.HeroFlagManager.FLAG_CAN_COLOR_UP))
    self:__updateTextView()
    self:__updateGuide()

    -- 品质显示
	self.m_imgCurColor:SetImg(UrlManager:getHeroColorCharacterIconUrl_1(self.m_heroVo.color), true)
	self.m_imgNextColor:SetImg(UrlManager:getHeroColorCharacterIconUrl_1(self.m_heroVo.color + 1), true)
end

function __updateLeftView(self)
    self:__recyAllItem()
end

function __updateMaterialView(self, args)
    self:__recyAllHead()
    local nextColorUpVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(self.m_heroVo.tid, self.m_heroVo.color + 1)
    local materialIdList = hero.HeroColorUpManager.materialHeroIdList
    local needMaterialCount = hero.HeroColorUpManager.needMaterialCount
    for i = 1, needMaterialCount do
        local heroVo = hero.HeroManager:getHeroVo(materialIdList[i])
        local item
        if (heroVo) then
            item = hero.HeroColorUpAddItem:create(self.m_scrollerMaterial, heroVo)
            item:setLvl(heroVo.lvl)
        else
            item = hero.HeroColorUpAddItem:create(self.m_scrollerMaterial)
            if(nextColorUpVo.needHeroTid > 0)then
                local heroConfigVo = hero.HeroManager:getHeroConfigVo(nextColorUpVo.needHeroTid)
                heroConfigVo.color = nextColorUpVo.needHeroColor
                item:setTemp(heroConfigVo)
            else
                item:setTemp({tid = 0, color = nextColorUpVo.needHeroColor})
            end
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
    local nextColorUpVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(self.m_heroVo.tid, self.m_heroVo.color + 1)
    local list = hero.HeroColorUpManager:getHeroScrollList(nextColorUpVo.needHeroTid, nextColorUpVo.needHeroColor, self.m_heroVo.id)
    local materialIdList = hero.HeroColorUpManager.materialHeroIdList
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
    local maxColor = hero.HeroColorUpManager:getHeroMaxColor(self.m_heroVo.tid)
    -- 品质已满
    if (self.m_heroVo.color >= maxColor) then
        self.m_textTip.text = "--"
        self.m_textCost.text = "--"
        self.m_textCost.color = gs.ColorUtil.GetColor("FFFFFFFF")
        self.m_btnUp:SetActive(false)
    else
        local nextColorUpVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(self.m_heroVo.tid, self.m_heroVo.color + 1)
        local name = ""
        if(nextColorUpVo.needHeroTid > 0)then
            local needHeroConfigVo = hero.HeroManager:getHeroConfigVo(nextColorUpVo.needHeroTid)
            name = needHeroConfigVo.name
        end
        self.m_textTip.text = string.substitute(_TT(1120), nextColorUpVo.needHeroNum, hero.getColorName(nextColorUpVo.needHeroColor), name)--"升品需要{0}名{1}品质{2}"
        local costTid = nextColorUpVo.cost[1]
        local costCount = nextColorUpVo.cost[2]
        self.m_imgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)
        self.m_textCost.text = costCount
        self.m_textCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(costTid, costCount, false, false) and "FFFFFFFF" or "ed1941FF")
        self.m_btnUp:SetActive(true)
    end
end

function __updateGuide(self)
    -- self:setGuideTrans("weak_hero_colorUp_1", self.m_transGuide_1)
    -- self:setGuideTrans("weak_hero_colorUp_2", self.m_transGuide_2)
end

-- 英雄品质更新
function __onColorUpdateHandler(self, args)
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
    local materialIdList = hero.HeroColorUpManager.materialHeroIdList
    local len = #materialIdList
    for i = 1, len do
        if (materialIdList[i] == clickHeroVo.id) then
            table.remove(materialIdList, i)
            isAdd = false
            break
        end
    end

    if (isAdd) then
        local nextColorUpVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(self.m_heroVo.tid, self.m_heroVo.color + 1)
        if (len >= nextColorUpVo.needHeroNum) then
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

    local materialIdList = hero.HeroColorUpManager.materialHeroIdList
    if table.indexof(materialIdList, heroVo.id) ~= false then
        select()
        return
    end

    if self.m_heroVo.color < heroVo.color then
        -- local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.HERO_COLOR_UP_SELECT)
        -- if (isNotRemind) then
        --     select();
        -- else
        UIFactory:alertMessge(_TT(1121), true, function() -- "所选战员品质大于待升品战员品质，是否继续添加？"
            select()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.HERO_COLOR_UP_SELECT
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
    local materialIdList = hero.HeroColorUpManager.materialHeroIdList
    local len = #materialIdList
    local nextColorUpVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(self.m_heroVo.tid, self.m_heroVo.color + 1)
    if (len >= nextColorUpVo.needHeroNum) then

        local costTid = nextColorUpVo.cost[1]
        local costCount = nextColorUpVo.cost[2]
        if (MoneyUtil.judgeNeedMoneyCountByTid(costTid, costCount, true)) then
            local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.HERO_COLOR_UP)
            if (isNotRemind) then
                GameDispatcher:dispatchEvent(EventName.REQ_HERO_COLOR_UP, { heroId = self.m_heroVo.id, costHeroIdList = materialIdList })
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_COLOR_UP_MATERIAL_TIP_PANEL, { heroId = self.m_heroVo.id })
            end
        end
    else
        gs.Message.Show(_TT(1072))--"请选择足够数量的战员"
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
