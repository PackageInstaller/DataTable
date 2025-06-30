--[[   
     英雄升星材料选择界面
]]
module('hero.HeroStarUpMaterialPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("hero/HeroStarUpMaterialPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1169, 558)
end
--析构  
function dtor(self)
end

function initData(self)
    self.m_headAddList = {}
    self.mStarList1 = {}
    self.mStarList2 = {}
end

-- 初始化
function configUI(self)
    self.mBtnEvolution = self:getChildGO("mBtnEvolution")
    self.m_scrollerMaterial = self:getChildTrans("MaterialContent")
    self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)
    self.mTxtEvolution1 = self:getChildGO("mTxtEvolution1"):GetComponent(ty.Text)
    self.mTxtEvolution2 = self:getChildGO("mTxtEvolution2"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(hero.HeroStarUpScrollItem)
    self.m_imgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.m_textCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.m_textEmptyTip = self:getChildGO("TextEmptyTip"):GetComponent(ty.Text)

    for i = 1, 6 do
        local item = self:getChildGO("mImgStar_1_" .. i)
        table.insert(self.mStarList1, item)
        local item = self:getChildGO("mImgStar_2_" .. i)
        table.insert(self.mStarList2, item)
    end
end

--激活
function active(self, args)
    super.active(self, args)
    hero.HeroStarManager:addEventListener(hero.HeroStarManager.HERO_STARUP_MATERIAL_SELECT, self.__onMaterialSelectHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_LIST_UPDATE, self.__onHeroListUpdateHandler, self)

    self.m_heroVo = args
    self:setData()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    hero.HeroStarManager:removeEventListener(hero.HeroStarManager.HERO_STARUP_MATERIAL_SELECT, self.__onMaterialSelectHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_LIST_UPDATE, self.__onHeroListUpdateHandler, self)
    self:__recyAllItem()
    self:__recyAllHead()
    RedPointManager:remove(self.mBtnEvolution.transform)
end

function initViewText(self)
    self.m_textEmptyTip.text =  _TT(1083) --"- 暂无可使用的战员 -"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnEvolution, self.__onBtnUpHandler)
end

function updateBubbleView(self, isFlag)
    if(isFlag)then
        RedPointManager:add(self.mBtnEvolution.transform, nil, 79, 19)
    else
        RedPointManager:remove(self.mBtnEvolution.transform)
    end
end

function __onHeroListUpdateHandler(self)
    self:setData()
end

function setData(self)
    self.nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(self.m_heroVo.tid, self.m_heroVo.evolutionLvl + 1)

    hero.HeroStarManager.needMaterialCount = self.nextStarConfigVo.needHeroNum
    hero.HeroStarManager.materialHeroIdList = {}
    self:__updateView()
end

function __updateView(self)
    self:updateStarLvl()
    self:setConditionText()
    self:__updateMaterialView()
    self:updateBubbleView(hero.HeroFlagManager:getFlag(self.m_heroVo.id, hero.HeroFlagManager.FLAG_CAN_STAR_UP))
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

function __updateMaterialView(self, args)
    self:__recyAllHead()
    local materialIdList = hero.HeroStarManager.materialHeroIdList
    local needMaterialCount = hero.HeroStarManager.needMaterialCount
    for i = 1, needMaterialCount do
        local heroVo = hero.HeroManager:getHeroVo(materialIdList[i])
        local item
        if (heroVo) then
            item = hero.HeroMilitaryRankAddItem:create(self.m_scrollerMaterial, heroVo)
            item:setLvl(heroVo.lvl)
        else
            item = hero.HeroMilitaryRankAddItem:create(self.m_scrollerMaterial)
            if(self.nextStarConfigVo.needHeroTid > 0)then
                local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.nextStarConfigVo.needHeroTid)
                heroConfigVo.color = self.nextStarConfigVo.needHeroColor
                item:setTemp(heroConfigVo)
            else
                item:setTemp({tid = 0, color = self.nextStarConfigVo.needHeroColor})
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

-- 更新可用材料列表
function __updateRightView(self, isInit)
    self.m_selectIdList = {}
    local materialIdList = hero.HeroStarManager.materialHeroIdList
    for i = 1, #materialIdList do
        table.insert(self.m_selectIdList, materialIdList[i])
    end

    local list = hero.HeroStarManager:getHeroScrollList(self.nextStarConfigVo.needHeroTid, self.nextStarConfigVo.needHeroColor, self.m_heroVo.id)
    local materialIdList = self.m_selectIdList
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
    self:recoverListData(self.mScroller.DataProvider)
    if isInit then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end
    self.m_textEmptyTip.gameObject:SetActive(#list <= 0)
end

function recoverListData(self, list)
    if(list and #list > 0)then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function updateStarLvl(self)
    self.mTxtEvolution1.text = self.m_heroVo.evolutionLvl
    self.mTxtEvolution2.text = self.m_heroVo.evolutionLvl + 1

    for i = 1, 6 do
        local item1 = self.mStarList1[i]
        local item2 = self.mStarList2[i]
        if self.m_heroVo.evolutionLvl >= i then
            item1:SetActive(true)
        else
            item1:SetActive(false)
        end
        if self.m_heroVo.evolutionLvl + 1 >= i then
            item2:SetActive(true)
        else
            item2:SetActive(false)
        end
    end
end

-- 设置条件说明
function setConditionText(self)
    local name = ""
    if(self.nextStarConfigVo.needHeroTid > 0)then
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.nextStarConfigVo.needHeroTid)
        name = heroConfigVo.name
    end
    self.mTxtCondition.text = string.format(_TT(1076), self.nextStarConfigVo.needHeroNum, hero.getColorName(self.nextStarConfigVo.needHeroColor), name)--"请选择%s名战员进行进化"
    local costTid = self.nextStarConfigVo.cost[1]
    local costCount = self.nextStarConfigVo.cost[2]
    self.m_imgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)
    self.m_textCost.text = costCount
    self.m_textCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(costTid,costCount,false,false) and "FFFFFFFF" or "ed1941FF")
end

function __onMaterialSelectHandler(self, args)
    local isAdd = true
    local clickHeroVo = args
    local materialIdList = hero.HeroStarManager.materialHeroIdList
    local len = #materialIdList
    for i = 1, len do
        if (materialIdList[i] == clickHeroVo.id) then
            table.remove(materialIdList, i)
            isAdd = false
            break
        end
    end

    if (isAdd) then
        if (len >= self.nextStarConfigVo.needHeroNum) then
            gs.Message.Show(_TT(1071))--"已经选满了"
            return
        else
            table.insert(materialIdList, clickHeroVo.id)
        end
    end
    self:__updateMaterialView({ isAdd = isAdd, heroVo = clickHeroVo })
end

function __onClickMaterialHandler(self, scrollData, args)
    local heroVo = scrollData
    if (heroVo) then
        self:__onMaterialSelectHandler(heroVo)
    end
end

function __onBtnUpHandler(self)
    local maxStarLvl = hero.HeroStarManager:getHeroMaxStarLvl()
    if (self.m_heroVo.evolutionLvl >= maxStarLvl) then
        gs.Message.Show(_TT(1052))--"当前星级已满级"
        return
    else
        local materialIdList = hero.HeroStarManager.materialHeroIdList
        local len = #materialIdList
        if (len >= hero.HeroStarManager.needMaterialCount) then

            local starConfigVo = hero.HeroStarManager:getHeroStarConfigVo(self.m_heroVo.tid, self.m_heroVo.evolutionLvl + 1)
            local costTid = starConfigVo.cost[1]
            local costCount = starConfigVo.cost[2]
            if (MoneyUtil.judgeNeedMoneyCountByTid(costTid, costCount, true)) then
				local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.HERO_STAR_UP)
				if(isNotRemind)then
					GameDispatcher:dispatchEvent(EventName.REQ_HERO_STAR_UP, { heroId = self.m_heroVo.id, costHeroIdList = materialIdList })
				else
					GameDispatcher:dispatchEvent(EventName.OPEN_STAR_UP_MATERIAL_TIP_PANEL, {heroId = self.m_heroVo.id})
				end
            end
        else
            gs.Message.Show(_TT(1077))--"请先选择材料"
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
