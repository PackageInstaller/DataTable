module('formation.FormaionDisasterLogPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('formation/FormaionDisasterLogPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 540)
    self:setTxtTitle("战斗记录")
end

function getManager(self)
    return formation.FormationDisasterManager
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mItemList = {}
    self.mGridList = {}
    self.mHeadList = {}
end
-- 初始化
function configUI(self)
    self.mText_1 = self:getChildGO("mText_1"):GetComponent(ty.Text)
    self.mText_2 = self:getChildGO("mText_2"):GetComponent(ty.Text)
    self.mText_3 = self:getChildGO("mText_3"):GetComponent(ty.Text)

    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mScrollerContent = self:getChildTrans("mScrollerContent")
    self.mItem = self:getChildGO("mItem")
    self.mItem:SetActive(false)

    self.mHeroItem = self:getChildGO("mHeroItem")
    self.mImgNo = self:getChildGO("mImgNo")
end

function initViewText(self)
end

function active(self, args)
    super.active(self, args)
    self.teamList = self:getManager():getAllTeamIdList()

    local info = disaster.DisasterManager:getDisasterFormationInfo()
    self.formationList = info.formation_list

    local passList = {}

    for i = 1, #self.formationList do
        if (self.formationList[i].is_pass == 1) then
            table.insert(passList, self.formationList[i])
        end
    end

    table.sort(passList, function(vo1, vo2)
        return vo1.id < vo2.id
    end)

    for i = 1, #passList do
        local item = SimpleInsItem:create(self.mItem, self.mScrollerContent, "disasterLogItem")
        local s = "队伍" .. self:getMaxTxt(passList[i].id - 19000)
        item:getChildGO("mTxtTeam"):GetComponent(ty.Text).text = s
        item:getChildGO("mTxtScore"):GetComponent(ty.Text).text = passList[i].damage
        

        local heroList = self:getTeamHero(passList[i].id)
        for j = 1, 5 do
            local root = SimpleInsItem:create(self.mHeroItem, item:getChildTrans("mGroupHead"), "disasterHeroHeadItem")
            if heroList[j] == nil then
                root:getChildGO("mIsNull"):SetActive(true)
            else
                root:getChildGO("mIsNull"):SetActive(false)
                local heroVo = hero.HeroManager:getHeroVo(heroList[j].heroId)
                local grid = HeroHeadGrid:poolGet()
                grid:setData(hero.HeroManager:getHeroConfigVo(heroList[j].m_heroTid))
                grid:setStarLvl(heroVo.evolutionLvl)
                grid:setLvl(heroVo.lvl)
                grid:setParent(root:getChildTrans("mHeroHead"))
                grid:setScale(0.4)

                table.insert(self.mGridList, grid)
            end

            table.insert(self.mHeadList, root)
        end
        table.insert(self.mItemList, item)
    end

    self.mImgNo:SetActive(#passList == 0)
end

function deActive(self)
    for i = 1, #self.mGridList do
        self.mGridList[i]:poolRecover()
    end
    self.mGridList = {}

    for i = 1, #self.mHeadList do
        self.mHeadList[i]:poolRecover()
    end
    self.mHeadList = {}

    for i = 1, #self.mItemList do
        self.mItemList[i]:poolRecover()
    end
    self.mItemList = {}
end

function getIsPass(formationId)
    for i = 1, #self.formationList do
        if self.formationList[i].id == formationId then
            return self.formationList[i].is_pass
        end
    end
end

function getTeamHero(self, teamId)
    local formationHeroList = self:getManager():getSelectFormationHeroList(teamId)
    return formationHeroList
end

function getMaxTxt(self, index)
    local s = ""
    if index == 1 then
        s = "一"
    elseif index == 2 then
        s = "二"
    elseif index == 3 then
        s = "三"
    elseif index == 4 then
        s = "四"
    elseif index == 5 then
        s = "五"
    elseif index == 6 then
        s = "六"
    elseif index == 7 then
        s = "七"
    elseif index == 8 then
        s = "八"
    elseif index == 9 then
        s = "九"
    elseif index == 10 then
        s = "十"
    end
    return s
end

return _M
