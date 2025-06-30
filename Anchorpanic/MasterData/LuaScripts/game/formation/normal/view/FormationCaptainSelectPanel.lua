--[[ 
-----------------------------------------------------
@filename       : FormationCaptainSelectPanel
@Description    : 阵型-队长选择界面
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationCaptainSelectPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("formation/FormationCaptainSelectPanel.prefab")
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(1281))
    self:setSize(1120, 520)
end

function getManager(self)
    return self.m_manager
end

function setManager(self, cusManager)
    self.m_manager = cusManager
end

-- 初始化数据
function initData(self)
end

-- 初始化
function configUI(self)
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
    self.mScrollerSelect = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScrollerSelect:SetItemRender(self:getHeadSelectItem())
end

function getHeadSelectItem(self)
    return formation.FormationCaptainSelectItem
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:setManager(args.manager)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_CAPTAIN_SELECT, self.__onFormationCaptainSelectHandler, self)

    self:setData(args.data, true)
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self:getManager():removeEventListener(self:getManager().HERO_FORMATION_CAPTAIN_SELECT, self.__onFormationCaptainSelectHandler, self)
end

function initViewText(self)
    self.mTxtTip.text = _TT(3027) -- 队长可在部分玩法中显示场景模型
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function __onFormationCaptainSelectHandler(self, args)
    local teamId = self.m_teamId
    local selectHeroId = args.heroId
    local selectHeroTid = args.heroTid
    local selectHeroSourceType = args.heroSourceType
    local selectIsInFormation = args.isInFormation
    self:getManager():setSelectTeamCaptainHeroId(teamId, selectHeroId)
    self:close()
end

function setData(self, cusData, isInit)
    if cusData then
        self.m_teamId = cusData.teamId
        self.m_formationId = cusData.formationId
    end
    self:__updateView(isInit)
end

function getDataList(self)
    -- 通用英雄列表
    local scrollList = {}
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    for i = 1, #formationHeroList do
        local formationHeroVo = formationHeroList[i]
        if(not formationHeroVo.isCaptainHero)then
            local dataVo = nil
            if(formationHeroVo:getIsMonster())then
                dataVo = monster.MonsterManager:getMonsterVo(formationHeroVo.heroId)
            else
                dataVo = hero.HeroManager:getHeroVo(formationHeroVo.heroId)
            end
            local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollVo:setDataVo({formationHeroVo = formationHeroVo, dataVo = dataVo, teamId = self.m_teamId, formationId = self.m_formationId, manager = self:getManager()})
            table.insert(scrollList, scrollVo)
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
	语言包: _TT(1281):	"<size=24>队</size>长选择"
]]
