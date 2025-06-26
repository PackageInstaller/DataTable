module('formation.FormationAssistCardItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
	super.onInit(self, go)
	self.mHeadGrid = nil
	self.mHeadNode = self:getChildTrans("mHeadNode")
	self.mTxtAssistEffect = self:getChildGO("mTxtAssistEffect"):GetComponent(ty.Text)
	self.mBtnAssist = self:getChildGO("mBtnAssist")
	self:getChildGO("mTxtAssist"):GetComponent(ty.Text).text = _TT(1268)

	self:addOnClick(self:getChildGO("mTouchArea"), self.onClickItemHandler)
	self:addOnClick(self:getChildGO("mBtnAssist"), self.onClickAssistHandler)
end

function getManager(self)
    return self.m_manager
end

function setManager(self, cusManager)
    self.m_manager = cusManager
end

function setData(self, param)
	super.setData(self, param)
	self:setManager(self.data:getDataVo().manager)
	self:update()
end

function update(self)
	local dataVo = self.data:getDataVo().dataVo
	if(self.mHeadGrid) then 
		self.mHeadGrid:poolRecover()
		self.mHeadGrid = nil
	end
	self.mHeadGrid = HeroHeadGrid:poolGet()
	self.mHeadGrid:setData(dataVo)
	self.mHeadGrid:setParent(self.mHeadNode)
	self.mHeadGrid:setLvl(dataVo.lvl)
	-- self.mHeadGrid:setMilitary(true)
	local unLockNum = 0
	self.m_isInFormation = self:getManager():isHeroInFormation(self.data:getDataVo().teamId, dataVo.id, formation.HERO_SOURCE_TYPE.OWN)
	self.m_isInAssist = self:getManager():isHeroInAssist(self.data:getDataVo().teamId, dataVo.id)
	local mAssistSkillList = hero.HeroAssistManager:getHeroAssistConfigList(dataVo.tid)
	for i = 1, #mAssistSkillList do
		if(hero.HeroAssistManager:isAssistSkillActive(dataVo.id, mAssistSkillList[i].skillId)) then
			unLockNum = unLockNum + 1
		end
	end
	if(unLockNum == 0) then 
		unLockNum = HtmlUtil:color(unLockNum, ColorUtil.BLACK_NUM)
	else
		unLockNum = HtmlUtil:color(unLockNum, ColorUtil.GREEN_NUM)
	end
	self:getChildGO("mTxtAssistEffect"):GetComponent(ty.Text).text = _TT(1269).."<color=#44a548>".. unLockNum .."</color>/"..#mAssistSkillList
end

function onClickItemHandler(self)
	TipsFactory:heroAssistTips(self.data:getDataVo().dataVo)
end

function onClickAssistHandler(self)
	local manager = self:getManager()
	local heroVo = self.data:getDataVo().dataVo
	manager:dispatchEvent(manager.HERO_FORMATION_ASSIST_SELECT, {heroId = heroVo.id, heroTid = heroVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.OWN, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist})
end

function deActive(self)
	if(self.mHeadGrid) then 
		self.mHeadGrid:poolRecover()
		self.mHeadGrid = nil
	end
	super.deActive(self)
end

function onDelete(self)
	super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1269):	"助战效果:"
	语言包: _TT(1268):	"助战"
]]
