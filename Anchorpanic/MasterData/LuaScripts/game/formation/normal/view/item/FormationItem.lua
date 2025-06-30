module('formation.FormationItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
	super.onInit(self, go)
	self.m_imgNormal = self:getChildGO("ImgNormal"):GetComponent(ty.AutoRefImage)
	self.m_imgSignGo = self:getChildGO('ImgSign')

	self.m_groupSelect = self:getChildGO("GroupSelect")
	
	self.m_groupLock = self:getChildGO("GroupLock")
	self.m_textLock = self:getChildGO("TextLock"):GetComponent(ty.Text)

	self.m_guideClick = self:getChildGO("GuideClick")
	self:addOnClick(self.m_guideClick, self.onClickItemHandler)
end

function getGuideTrans(self)
	return self.m_guideClick.transform
end

function setData(self, param)
	super.setData(self, param)

	local selectVo = self.data
	local showTeamId = selectVo:getDataVo().showTeamId
	local formationConfigVo = selectVo:getDataVo().formationConfigVo
	local manager = selectVo:getDataVo().manager

	self.m_imgNormal.color = gs.ColorUtil.GetColor("FFFFFFFF")
	-- self.m_imgNormal:SetImg(UrlManager:getHeroFormationBtnNormalBgUrl(formationConfigVo:getRefID()), false)
	
	local needLvl = formationConfigVo:getLimit()
	local playerLvl = role.RoleManager:getRoleVo():getPlayerLvl()
	if(playerLvl >= needLvl)then
		if(formationConfigVo:getDupId() > 0)then
			local isPass = battleMap.MainMapManager:isStagePass(formationConfigVo:getDupId())
			if(isPass)then
				self.m_groupLock:SetActive(false)
			else
                local stageVo = battleMap.MainMapManager:getStageVo(formationConfigVo:getDupId())
				self.m_groupLock:SetActive(true)
				self.m_textLock.text = string.format(_TT(1151), stageVo:getName()) -- 通关%s解锁
				self.m_imgNormal.color = gs.ColorUtil.GetColor("FFFFFF89")
			end
		else
			self.m_groupLock:SetActive(false)
		end
	else
		self.m_groupLock:SetActive(true)
		self.m_textLock.text = string.format(_TT(1154), needLvl) --"指挥官%s级解锁"
		self.m_imgNormal.color = gs.ColorUtil.GetColor("FFFFFF89")
	end

	local isSelect = selectVo:getSelect()
	if(isSelect)then
		self.m_groupSelect:SetActive(true)
	else
		self.m_groupSelect:SetActive(false)
	end

	--选择中的阵型id
	local selectFormationId = manager:getFightFormationId(showTeamId)
	if(selectFormationId == formationConfigVo:getRefID())then
		self.m_imgSignGo:SetActive(true)
	else
		self.m_imgSignGo:SetActive(false)
	end
end

function onClickItemHandler(self)
	local selectVo = self.data
	local showTeamId = selectVo:getDataVo().showTeamId
	local formationConfigVo = selectVo:getDataVo().formationConfigVo
	local manager = selectVo:getDataVo().manager
	
	local needLvl = formationConfigVo:getLimit()
	local playerLvl = role.RoleManager:getRoleVo():getPlayerLvl()
	if(playerLvl >= needLvl)then
		if(formationConfigVo:getDupId() > 0)then
			local isPass = battleMap.MainMapManager:isStagePass(formationConfigVo:getDupId())
			if(isPass)then
				manager:dispatchEvent(manager.HERO_FORMATION_SEE, {formationId = formationConfigVo:getRefID()})
			else
                local stageVo = battleMap.MainMapManager:getStageVo(formationConfigVo:getDupId())
				gs.Message.Show(string.format(_TT(1151), stageVo:getName())) -- 通关%s解锁
			end
		else
			manager:dispatchEvent(manager.HERO_FORMATION_SEE, {formationId = formationConfigVo:getRefID()})
		end
	else
		gs.Message.Show(string.format(_TT(1152), needLvl)) -- 指挥官等级达到%s级解锁
	end
end

function deActive(self)
	super.deActive(self)
end

function onDelete(self)
	super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
