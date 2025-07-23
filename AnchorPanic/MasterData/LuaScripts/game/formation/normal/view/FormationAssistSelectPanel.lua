--[[
     英雄阵型选择界面
]]
module("formation.FormationAssistSelectPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("formation/FormationAssistSelectPanel.prefab")
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(1278))
    self:setSize(1120, 520)
end

-- 初始化数据
function initData(self)
    self.hideNoEffect = false
end

-- 初始化
function configUI(self)
    self.mScrollerSelect = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScrollerSelect:SetItemRender(self:getHeadSelectItem())
    self.mToggleHideAssist = self:getChildGO("mToggleHideAssist"):GetComponent(ty.Toggle)
    self.mTxtToggle = self:getChildGO("mTxtToggle"):GetComponent(ty.Text)
end

function getHeadSelectItem(self)
    return formation.FormationAssistCardItem
end

function getManager(self)
    return self.m_manager
end

function setManager(self, cusManager)
    self.m_manager = cusManager
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:setData(args.data, true)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_ASSIST_SELECT, self.__onFormationHeroSelectHandler, self)
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self.mToggleHideAssist.onValueChanged:RemoveAllListeners()
    self:getManager():removeEventListener(self:getManager().HERO_FORMATION_ASSIST_SELECT, self.__onFormationHeroSelectHandler, self)
end

function initViewText(self)
    self.mTxtToggle.text = _TT(1279)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self.mToggleHideAssist.onValueChanged:AddListener(function() self:screenAssist() end)
end

function screenAssist(self)
    self.hideNoEffect = not self.hideNoEffect
    self:__updateView()
end

function __onFormationHeroSelectHandler(self, args)
    local teamId = self.m_teamId
    local selectHeroId = args.heroId
    local selectHeroTid = args.heroTid
    local selectHeroSourceType = args.heroSourceType
    local selectIsInFormation = args.isInFormation

    local function reqSelect()
        self:getManager():setSelectTeamAssistHeroList(teamId, self.m_formationId, selectHeroId, selectHeroTid, selectHeroSourceType, self.mAssistPos, true)
        self:getManager():dispatchEvent(self:getManager().UPDATE_ASSIST_FIGHT_HERO)
        self:close()
    end
    if(selectIsInFormation)then
        UIFactory:alertMessge(_TT(1280),
        true, function() reqSelect() end, _TT(1), nil,
        true, function() end, _TT(2),
        _TT(5), nil, RemindConst.NULL)
    else
        reqSelect()
    end
end

function setData(self, cusData, isInit)
    if cusData then
        self.mAssistPos = cusData.assistPos
        self.m_teamId = cusData.teamId
        self.m_formationId = cusData.formationId
        self.mAssistPos = cusData.assistPos
        self:setManager(cusData.manager)
    end
    self:__updateView(isInit)
end

function getDataList(self)
    -- 通用英雄列表
    local scrollList = {}
    local noAssistEffectList = {}
    local heroList, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, showBoard.panelSortType.COLOR, true)
    for i = 1, #heroList do
        local heroVo = heroList[i]:getDataVo()
        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({ dataVo = heroVo, teamId = self.m_teamId, formationId = self.m_formationId, manager = self:getManager() })
        local isInFormation = self:getManager():isHeroInFormation(self.m_teamId, heroVo.id)
        if (not isInFormation) then
            local isInAssist = self:getManager():isHeroInAssist(self.m_teamId, heroVo.id)
            if(not isInAssist)then
                local mAssistSkillList = hero.HeroAssistManager:getHeroAssistConfigList(scrollVo:getDataVo().dataVo.tid)
                local unLockNum = 0
                for i = 1, #mAssistSkillList do
                    if(hero.HeroAssistManager:isAssistSkillActive(scrollVo:getDataVo().dataVo.id, mAssistSkillList[i].skillId)) then
                        unLockNum = unLockNum + 1
                    end
                end
                if(unLockNum == 0) then 
                    table.insert(noAssistEffectList, scrollVo)
                else
                    table.insert(scrollList, scrollVo)
                end
            end
        end
    end

    if(not self.hideNoEffect) then
        for i = 1, #noAssistEffectList do
            table.insert(scrollList, noAssistEffectList[i])
        end
    end
    return scrollList
end

function __updateView(self, isInit)
    self:recoverListData(self.mScrollerSelect.DataProvider)
    local scrollList = self:getDataList()
    if isInit or self.mScrollerSelect.Count <= 0 then
        self.mScrollerSelect.DataProvider = scrollList
    else
        self.mScrollerSelect:ReplaceAllDataProvider(scrollList)
    end
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1280):	"是否解除所选战员出战状态，并重新上阵为助战状态？"
	语言包: _TT(1279):	"隐藏没有助战效果战员"
	语言包: _TT(1278):	"<size=24>战</size>员选择"
]]
