--[[ 
-----------------------------------------------------
@filename       : FormationApostlesHeroSelectItem
@Description    : 迷宫·副本战员选择item
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationApostlesHeroSelectItem', Class.impl(formation.FormationHeroSelectItem))

function setData(self, param)
	super.setData(self, param)
    self:__update()
end

function __update(self)
	local teamId = self.data:getDataVo().teamId
	local isShowRemove = self.data:getDataVo().isShowRemove
	self.manager = self.data:getDataVo().manager
	self.dataVo = self.data:getDataVo().dataVo
    self.lockState = self.data:getDataVo().lockState
	if(self.dataVo) then
		if(self.dataVo.__cname == hero.HeroVo.__cname) then 						-- 我方英雄vo
			local heroVo = self.dataVo
			if(not self.m_headGrid) then
				self.m_headGrid = hero.HeroCard:poolGet()
			end
			self.m_headGrid:setData(heroVo)
			self.m_headGrid:setParent(self.m_cardNode)
			self.m_headGrid:setScale(0.78)
			self.m_headGrid:setCallBack(self, self.__onClickHeadHandler)

            self.m_isInFormation = self.manager:isHeroInFormation(teamId, heroVo.id, formation.HERO_SOURCE_TYPE.OWN)
            self.m_isInAssist = self.manager:isHeroInAssist(teamId, heroVo.id)
			
            self.m_goSource:SetActive(false)
		end

        if (isShowRemove) then
			self.m_goRemove:SetActive(true)
			self.m_goUseState:SetActive(false)
        else
            self.m_goRemove:SetActive(false)
            if(self.lockState == 1) then 
                self.m_goUseState:SetActive(true)
				self.m_textUseState.text = "已经锁定"
            elseif(self.m_isInFormation)then
				self.m_goUseState:SetActive(true)
				self.m_textUseState.text = _TT(1174) --"出战中"
			elseif(self.m_isInAssist)then
				self.m_goUseState:SetActive(true)
				self.m_textUseState.text = "助战中" --"助战中"
			else
				self.m_goUseState:SetActive(false)
				self.m_textUseState.text = ""
			end
        end
    else
        self:deActive()
    end
end

function __onClickHeadHandler(self)
    if self.lockState == 1 then 
        gs.Message.Show("战员已锁定不可选择")
    else
        self.manager:dispatchEvent(self.manager.HERO_FORMATION_SELECT, {heroId = self.dataVo.id, heroTid = self.dataVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.OWN, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist})
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
