-- module('hero.HeroSkillSubTabView', Class.impl("lib.mvc.TabSubView"))

-- UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroSkillSubTab.prefab")

-- --构造函数
-- function ctor(self)
--     super.ctor(self)
-- end

-- -- 初始化数据
-- function initData(self)
--     self.m_tabBarHero = nil
--     self.m_curHeroId = nil
--     self.m_itemList = {}
--     self.m_posList = {
--         gs.Vector3(10, 210, 0),
--         gs.Vector3(-165, 80, 0),
--         gs.Vector3(-95, -130, 0),
--         gs.Vector3(115, -130, 0),
--         gs.Vector3(185, 80, 0),
--         gs.Vector3(10, 20, 0)
--     }
-- end

-- function configUI(self)
-- end

-- function active(self, args)
-- end

-- function deActive(self)
--     self:recyIconList()
-- end

-- function recyIconList(self)
--     if (self.m_itemList) then
--         for i = 1, #self.m_itemList do
--             local item = self.m_itemList[i]
--             item:poolRecover()
--         end
--     end
--     self.m_itemList = {}
-- end

-- function setData(self, cusHeroId)
--     self.m_curHeroId = cusHeroId
--     self:__updateView()
-- end

-- function __updateView(self)
-- 	self:__updateSkillIcon()
-- end

-- function __updateSkillIcon(self)
--     self:recyIconList()
--     local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
--     if (curHeroVo) then
--         local starDic = hero.HeroStarManager:getHeroStarDic(curHeroVo.tid)
--         for i = 1, #curHeroVo.baseSkillIdList do
--             local item = hero.HeroSkillItem:poolGet()
--             item:setData(self.m_curHeroId, curHeroVo.baseSkillIdList[i], false)
--             item:setParent(self:getChildTrans("Group"))
--             item:setPosition(self.m_posList[i])
--             item:setCallBack(self, self.__onClickSkillIconHandler, {skillId = curHeroVo.baseSkillIdList[i]})
--             table.insert(self.m_itemList, item)
--         end
--     end
-- end

-- function __onClickSkillIconHandler(self, args)
--     local skillId = args.skillId
--     local skillVo = fight.SkillManager:getSkillRo(skillId)
--     GameDispatcher:dispatchEvent(EventName.OPEN_HERO_SKILL_DES_PANEL, {heroId = self.m_curHeroId, skillVo = skillVo})
-- end

-- return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
