--[[ 
-----------------------------------------------------
@filename       : FormationMazeHeroSelectItem
@Description    : 迷宫·副本战员选择item
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationMazeHeroSelectItem', Class.impl('game/formation/normal/view/item/FormationHeroSelectItem'))

function onInit(self, go)
    super.onInit(self, go)
    self.mImgHpBg = self:getChildGO("ImgHpBg")
    self.mImgHp = self:getChildGO("mImgHp"):GetComponent(ty.Image)
    self.mTxtHp = self:getChildGO("mTxtHp"):GetComponent(ty.Text)

    self:getChildGO("TextHpTip"):GetComponent(ty.Text).text = _TT(1256)
    self.mGoHpTip = self:getChildGO("ImgHpTip")
end

function setData(self, param)
	super.setData(self, param)
    self:__update()
end

function __update(self)
	local teamId = self.data:getDataVo().teamId
	local formationId = self.data:getDataVo().formationId
	local isShowRemove = self.data:getDataVo().isShowRemove
	local manager = self.data:getDataVo().manager
	local dataVo = self.data:getDataVo().dataVo
	if(dataVo) then
		if(dataVo.__cname == hero.HeroVo.__cname) then 						-- 我方英雄vo
			local heroVo = dataVo
			if(not self.m_headGrid) then
				self.m_headGrid = hero.HeroCard:poolGet()
			end
			self.m_headGrid:setData(heroVo)
			self.m_headGrid:setParent(self.m_cardNode)
			self.m_headGrid:setScale(0.78)
			self.m_headGrid:setCallBack(self, self.__onClickHeadHandler)

            self.m_isInFormation = manager:isHeroInFormation(teamId, heroVo.id, formation.HERO_SOURCE_TYPE.OWN)
            self.m_isInAssist = manager:isHeroInAssist(teamId, heroVo.id)
			
            self.m_goSource:SetActive(false)

		elseif(dataVo.__cname == monster.MonsterTidConfigVo.__cname) then 	-- 援助我方的怪物vo
			local monsterTidVo = dataVo
			local monsterConfigVo = dataVo:getBaseConfig()
			if(not self.m_headGrid) then
				self.m_headGrid = hero.MonsterCard:poolGet()
			end
			self.m_headGrid:setData(monsterTidVo)
			self.m_headGrid:setParent(self.m_cardNode)
			self.m_headGrid:setScale(0.78)
			self.m_headGrid:setCallBack(self, self.__onClickHeadHandler)
			
            self.m_isInFormation = manager:isHeroInFormation(teamId, monsterTidVo.uniqueTid, formation.HERO_SOURCE_TYPE.MAZE_SUPPORT)
			self.m_isInAssist = false

			self.m_goSource:SetActive(not isShowRemove)
			self.m_imgSource:SetImg(UrlManager:getPackPath("formation/formation_3.png"), false)
		end

        local mazeHeroVo = self:getMazeHeroVo()
        if (isShowRemove) then
			self.m_goRemove:SetActive(true)
			self.m_goUseState:SetActive(false)
            self.mImgHpBg:SetActive(false)
            self.mGoHpTip:SetActive(false)
        else
            self.m_goRemove:SetActive(false)
			if(self.m_isInFormation)then
				self.m_goUseState:SetActive(true)
				self.m_textUseState.text = hero.HeroUseCodeManager:getTipByUseCode(hero.HeroUseCodeManager.IN_TEAM_FORMATION) --"出战中"
				self.m_textUseState.color = hero.HeroUseCodeManager:getTipColorByUseCode(hero.HeroUseCodeManager.IN_TEAM_FORMATION)
			elseif(self.m_isInAssist)then
				self.m_goUseState:SetActive(true)
				self.m_textUseState.text = hero.HeroUseCodeManager:getTipByUseCode(hero.HeroUseCodeManager.IN_ASSIST_FIGHT) --"助战中"
				self.m_textUseState.color = hero.HeroUseCodeManager:getTipColorByUseCode(hero.HeroUseCodeManager.IN_ASSIST_FIGHT)
			else
				self.m_goUseState:SetActive(false)
				self.m_textUseState.text = ""
			end
            self.mImgHpBg:SetActive(true)
            if(mazeHeroVo.nowHp > 0)then
                self.mGoHpTip:SetActive(false)
            else
                self.mGoHpTip:SetActive(true)
            end
        end
        local ratio = mazeHeroVo.nowHp / mazeHeroVo.maxHp
        if(ratio <= 0.1)then
            self.mImgHp.color = gs.ColorUtil.GetColor("f91515FF")
        else
            self.mImgHp.color = gs.ColorUtil.GetColor("28c00fFF")
        end
        self.mImgHp.fillAmount = ratio
        self.mTxtHp.text = math.ceil(ratio * 100) .. "%"
    else
        self:deActive()
    end
end

function getMazeHeroVo(self)
    local manager = self.data:getDataVo().manager
    local dataVo = self.data:getDataVo().dataVo
    local mazeHeroVo = nil
    if(dataVo.__cname == hero.HeroVo.__cname)then
        mazeHeroVo = maze.MazeManager:getMazeHero(manager:getData().data.mazeId, dataVo.id, maze.HERO_SOURCE_TYPE.OWN)
    else
        mazeHeroVo = maze.MazeManager:getMazeHero(manager:getData().data.mazeId, dataVo.uniqueTid, maze.HERO_SOURCE_TYPE.SUPPORT)
    end
    return mazeHeroVo
end

function __onClickHeadHandler(self, args)
    local mazeHeroVo = self:getMazeHeroVo()
    if (mazeHeroVo.nowHp <= 0) then
        gs.Message.Show2(_TT(1257))
        return
    end

    local manager = self.data:getDataVo().manager
    local dataVo = self.data:getDataVo().dataVo
    if (dataVo.__cname == hero.HeroVo.__cname) then
        -- 我方英雄vo
        local heroVo = dataVo
        -- if(hero.HeroUseCodeManager:getIsCanUse(heroVo.id, true, {hero.HeroUseCodeManager.IN_TEAM_FORMATION, hero.HeroUseCodeManager.IN_ARENA_DEFENSE})) then
        manager:dispatchEvent(manager.HERO_FORMATION_SELECT, { heroId = heroVo.id, heroTid = heroVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.OWN, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist })
        -- end
    elseif (dataVo.__cname == monster.MonsterTidConfigVo.__cname) then
        -- 援助我方的怪物vo
        local monsterTidVo = dataVo
        local monsterConfigVo = dataVo:getBaseConfig()
        manager:dispatchEvent(manager.HERO_FORMATION_SELECT, { heroId = monsterTidVo.uniqueTid, heroTid = monsterTidVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.MAZE_SUPPORT, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist })
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1257):	"该战员已阵亡"
	语言包: _TT(1256):	"已阵亡"
]]
